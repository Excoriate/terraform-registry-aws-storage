package secrets

import (
  "context"
  "errors"
  "fmt"
  "github.com/Excoriate/terraform-registry-aws-storage/adapter"
  "github.com/Excoriate/terraform-registry-aws-storage/display"
  "github.com/Excoriate/terraform-registry-aws-storage/internal/logger"
  "github.com/aws/aws-sdk-go-v2/aws"
  "github.com/aws/aws-sdk-go-v2/service/secretsmanager"
  "strings"
)

type Secret struct {
  AWSRegion string
  Name      string
  Value     string
  VersionId string
}

type SecretWithNoValue struct {
  AWSRegion string
  ARN       string
  Name      string
}

type Reader struct {
  Client  *aws.Config
  Context context.Context
  Logger  logger.Logger
}

type Fetcher interface {
  ListSecrets() ([]Secret, error)
  GetSecret(name string) (*Secret, error)
}

func (r *Reader) ListSecrets() ([]Secret, error) {
  c := secretsmanager.NewFromConfig(*r.Client)

  input := &secretsmanager.ListSecretsInput{}
  var secrets []Secret
  var secretsPreFetch []SecretWithNoValue

  for {
    output, err := c.ListSecrets(context.TODO(), input)
    if err != nil {
      r.Logger.LogError("AWS Secrets Manager", "Failed to list secrets", err)
      return nil, err
    }

    for _, secret := range output.SecretList {
      secretsPreFetch = append(secretsPreFetch, SecretWithNoValue{
        ARN:       *secret.ARN,
        AWSRegion: r.Client.Region,
        Name:      *secret.Name,
      })
    }

    if len(secretsPreFetch) == 0 {
      r.Logger.LogError("AWS Secrets Manager", "No secrets found", nil)
      return nil, errors.New(fmt.Sprintf("No secrets found in region %s", r.Client.Region))
    }

    for _, secret := range secretsPreFetch {
      secretValue, errList := c.GetSecretValue(context.TODO(), &secretsmanager.GetSecretValueInput{
        SecretId: aws.String(secret.ARN),
      })

      var secretValueNormalised string
      var versionNormalised string
      if errList != nil {
        display.UXInfo("LIST-VALUES", fmt.Sprintf("Failed to retrieve secret value for secret %s."+
          " "+
          "Most likely it does not have a value set yet", secret.Name))
        r.Logger.LogWarn("AWS Secrets Manager", "Failed to retrieve secret value", errList)
        secretValueNormalised = ""
        versionNormalised = ""
      } else {
        secretValueNormalised = *secretValue.SecretString
        versionNormalised = *secretValue.VersionId
      }

      secrets = append(secrets, Secret{
        AWSRegion: r.Client.Region,
        Name:      secret.Name,
        Value:     secretValueNormalised,
        VersionId: versionNormalised,
      })
    }

    if output.NextToken == nil {
      break
    }
    input.NextToken = output.NextToken
  }

  // Print retrieved secrets
  for _, secret := range secrets {
    fmt.Printf("Secret Name: %s\nSecret Value: %s\n\n", secret.Name, secret.Value)
  }

  return secrets, nil
}

func (r *Reader) GetSecret(secretName string) (*Secret, error) {
  c := secretsmanager.NewFromConfig(*r.Client)

  secretValue, err := c.GetSecretValue(context.TODO(), &secretsmanager.GetSecretValueInput{
    SecretId: aws.String(secretName),
  })

  var secretValueNormalised string
  var versionNormalised string
  var secretNameNormalised string

  if err != nil {
    msg := err.Error()
    if strings.Contains(msg,
      "Secrets Manager can't find the specified secret value for staging label: AWSCURRENT") {
      r.Logger.LogWarn("AWS Secrets Manager", "Secret value not found. Means it's an empty secret",
        err)

      secretValueNormalised = ""
      versionNormalised = ""
      secretNameNormalised = secretName
    } else {
      r.Logger.LogError("AWS Secrets Manager", "Failed to retrieve secret value", err)
      return nil, err
    }
  } else {
    secretValueNormalised = *secretValue.SecretString
    versionNormalised = *secretValue.VersionId
    secretNameNormalised = *secretValue.Name
  }

  secret := &Secret{
    AWSRegion: r.Client.Region,
    Name:      secretNameNormalised,
    //Value:     *secretValue.SecretString,
    //VersionId: *secretValue.VersionId,
    Value:     secretValueNormalised,
    VersionId: versionNormalised,
  }

  return secret, nil
}

func NewAWSSecretsManagerReader(region string, loggerFactory logger.Logger) Fetcher {
  c, err := adapter.ToAWS(region)
  if err != nil {
    loggerFactory.LogError("AWS Adapter", "Failed to create AWS client", err)
  }

  return &Reader{
    Client:  &c,
    Context: context.TODO(),
    Logger:  loggerFactory,
  }
}
