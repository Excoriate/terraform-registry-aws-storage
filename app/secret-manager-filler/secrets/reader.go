package secrets

import (
  "context"
  "fmt"
  "github.com/Excoriate/terraform-registry-aws-storage/adapter"
  "github.com/Excoriate/terraform-registry-aws-storage/internal/logger"
  "github.com/aws/aws-sdk-go-v2/aws"
  "github.com/aws/aws-sdk-go-v2/service/secretsmanager"
)

type Secret struct {
  AWSRegion string
  Name      string
  Value     string
  VersionId string
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

  for {
    output, err := c.ListSecrets(context.TODO(), input)
    if err != nil {
      r.Logger.LogError("AWS Secrets Manager", "Failed to list secrets", err)
      return nil, err
    }

    for _, secret := range output.SecretList {
      secretValue, errList := c.GetSecretValue(context.TODO(), &secretsmanager.GetSecretValueInput{
        SecretId: secret.Name,
      })
      if errList != nil {
        r.Logger.LogError("AWS Secrets Manager", "Failed to retrieve secret value", errList)
        continue
      }

      secrets = append(secrets, Secret{
        AWSRegion: r.Client.Region,
        Name:      *secret.Name,
        Value:     *secretValue.SecretString,
        VersionId: *secretValue.VersionId,
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

  if err != nil {
    r.Logger.LogError("AWS Secrets Manager", "Failed to retrieve secret value", err)
    return nil, err
  }

  secret := &Secret{
    AWSRegion: r.Client.Region,
    Name:      *secretValue.Name,
    Value:     *secretValue.SecretString,
    VersionId: *secretValue.VersionId,
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
