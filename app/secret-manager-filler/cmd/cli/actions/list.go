package actions

import (
  "fmt"
  "github.com/Excoriate/terraform-registry-aws-storage/display"
  "github.com/Excoriate/terraform-registry-aws-storage/internal/logger"
  "github.com/Excoriate/terraform-registry-aws-storage/secrets"
  "github.com/pterm/pterm"
)

type ListActionArgs struct {
  AWSRegion string
}

func ListAll(args ListActionArgs) error {
  loggerFactory := logger.SecretFillerLog{}

  r := secrets.NewAWSSecretsManagerReader(args.AWSRegion, &loggerFactory)
  secretResults, err := r.ListSecrets()
  if err != nil {
    display.UXError("List secrets", "Failed to list secrets", err)
    return err
  }

  display.UXSuccess("List secrets", fmt.Sprintf("Number of Secrets found: [%d]", len(secretResults)))

  pterm.Println()
  pterm.Println()

  for i, data := range secretResults {
    if i == 0 {
      _ = pterm.DefaultTable.WithHasHeader().WithData(pterm.TableData{
        {"SECRET", "VALUE", "REGION", "VERSIONID"},
        {data.Name, data.Value, data.AWSRegion, data.VersionId},
      }).WithLeftAlignment().Render()
    } else {
      _ = pterm.DefaultTable.WithData(pterm.TableData{
        {data.Name, data.Value, data.AWSRegion, data.VersionId},
      }).WithLeftAlignment().Render()
    }
  }

  fmt.Println("---------------------------------------")
  pterm.Println()
  pterm.Println()

  return nil
}
