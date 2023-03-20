package actions

import (
  "fmt"
  "github.com/Excoriate/terraform-registry-aws-storage/display"
  "github.com/Excoriate/terraform-registry-aws-storage/internal/logger"
  "github.com/Excoriate/terraform-registry-aws-storage/secrets"
  "github.com/pterm/pterm"
)

type PopulateActionArgs struct {
  AWSRegion   string
  SecretValue string
  SecretName  string
}

func PopulateSecret(args PopulateActionArgs) error {
  loggerFactory := logger.SecretFillerLog{}

  secret, err := getSecret(args.AWSRegion, args.SecretName, &loggerFactory)

  if secret.Name == "" {
    display.UXError("POPULATE", fmt.Sprintf("Failed to find secret with name: %s",
      args.SecretName), err)
    return err
  }

  if secret.Value != "" {
    if secret.Value == args.SecretValue {
      display.UXWarning(fmt.Sprintf("POPULATE: %s", args.SecretName),
        fmt.Sprintf("Secret value already set: %s", args.SecretValue))
      return nil
    }

    warnMsg := fmt.Sprintf("There's already a value set (value: %s) for the secret: %s",
      secret.Value, secret.Name)
    display.UXWarning("POPULATE", warnMsg)

    // Show confirm to the user.
    result, _ := pterm.DefaultInteractiveConfirm.Show(
      fmt.Sprintf("Would you like to override the existing value for the secret %s?", secret.Name))
    pterm.Println()

    if !result {
      display.UXInfo("POPULATE", "Aborted")
      return nil
    }

    if _, mutationErr := mutateSecret(args.AWSRegion, secret.Name,
      args.SecretValue, &loggerFactory); mutationErr != nil {
      display.UXError("POPULATE", "Failed to mutate secret", mutationErr)
      return mutationErr
    }

    newSecret, readPostMutationErr := getSecret(args.AWSRegion, args.SecretName, &loggerFactory)
    if readPostMutationErr != nil {
      display.UXError("POPULATE", fmt.Sprintf("Failed to get secret %s after it was mutated",
        args.SecretName), readPostMutationErr)
      return readPostMutationErr
    }

    display.UXSuccess("POPULATE", fmt.Sprintf("Successfully populated secret: %s. Old value: %s, new value: %s",
      secret.Name, secret.Value, newSecret.Value))

    return nil
  }

  if _, mutationErr := mutateSecret(args.AWSRegion, secret.Name,
    args.SecretValue, &loggerFactory); mutationErr != nil {
    display.UXError("POPULATE", "Failed to mutate secret", mutationErr)
    return mutationErr
  }

  newSecret, readPostMutationErr := getSecret(args.AWSRegion, args.SecretName, &loggerFactory)
  if readPostMutationErr != nil {
    display.UXError("POPULATE", fmt.Sprintf("Failed to get secret %s after it was mutated",
      args.SecretName), readPostMutationErr)
    return readPostMutationErr
  }

  display.UXSuccess("POPULATE", fmt.Sprintf("Successfully populated secret: %s. Old value: %s, new value: %s",
    secret.Name, secret.Value, newSecret.Value))

  return nil
}

func getSecret(region, secretName string, logger logger.Logger) (*secrets.Secret, error) {
  r := secrets.NewAWSSecretsManagerReader(region, logger)
  secret, err := r.GetSecret(secretName)
  if err != nil {
    return nil, err
  }

  if secret.Name == "" {
    return nil, fmt.Errorf("failed to find secret with name: %s", secretName)
  }

  return secret, nil
}

func mutateSecret(region, secretName, secretNewValue string,
  logger logger.Logger) (*secrets.Secret, error) {
  m := secrets.NewAWSSecretsManagerMutator(region, logger)
  mutationResult, err := m.UpdateSecretValue(secretName, secretNewValue)
  if err != nil {
    return nil, err
  }

  if mutationResult == nil {
    display.UXError("POPULATE", fmt.Sprintf("Failed to mutate secret: %s", secretName), err)
  }

  return mutationResult, nil
}
