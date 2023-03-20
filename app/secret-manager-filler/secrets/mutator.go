package secrets

import (
  "context"
  "github.com/Excoriate/terraform-registry-aws-storage/adapter"
  "github.com/Excoriate/terraform-registry-aws-storage/internal/logger"
  "github.com/aws/aws-sdk-go-v2/aws"
  "github.com/aws/aws-sdk-go-v2/service/secretsmanager"
)

type Mutator struct {
  Client  *aws.Config
  Context context.Context
  Logger  logger.Logger
}

type SecretsMutator interface {
  UpdateSecretValue(secretName, newValue string) (*Secret, error)
}

func (m *Mutator) UpdateSecretValue(secretName, newValue string) (*Secret, error) {
  c := secretsmanager.NewFromConfig(*m.Client)

  updatedSecret, err := c.UpdateSecret(context.TODO(), &secretsmanager.UpdateSecretInput{
    SecretId:     aws.String(secretName),
    SecretString: aws.String(newValue),
  })

  if err != nil {
    m.Logger.LogError("AWS Secrets Manager", "Failed to update secret value", err)
    return nil, err
  }

  secret := &Secret{
    AWSRegion: m.Client.Region,
    Name:      *updatedSecret.Name,
    Value:     newValue,
    VersionId: *updatedSecret.VersionId,
  }

  return secret, nil
}

func NewAWSSecretsManagerMutator(region string, loggerFactory logger.Logger) SecretsMutator {
  c, err := adapter.ToAWS(region)
  if err != nil {
    loggerFactory.LogError("AWS Adapter", "Failed to create AWS client", err)
  }

  return &Mutator{
    Client:  &c,
    Context: context.TODO(),
    Logger:  loggerFactory,
  }
}
