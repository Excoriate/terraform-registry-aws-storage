package cli

import (
  "fmt"
  "github.com/Excoriate/terraform-registry-aws-storage/cmd/cli/actions"
  "github.com/spf13/cobra"
  "os"
)

var (
  SecretName  string
  SecretValue string
  AWSRegion   string
)

var PopulateCMD = &cobra.Command{
  Version: "v0.0.1",
  Use:     "populate",
  Long:    "asd",
  Example: "asd",
  Run: func(cmd *cobra.Command, args []string) {
    var regionNormalised string
    if AWSRegion == "" {
      regionNormalised = os.Getenv("AWS_REGION")
      if regionNormalised == "" {
        _ = fmt.Errorf("AWS_REGION environment variable is not set")
        os.Exit(1)
      }

      regionNormalised = os.Getenv("AWS_REGION")
    } else {
      regionNormalised = AWSRegion
    }

    input := actions.PopulateActionArgs{
      AWSRegion:   regionNormalised,
      SecretName:  SecretName,
      SecretValue: SecretValue,
    }
    err := actions.PopulateSecret(input)

    if err != nil {
      os.Exit(1)
    }
  },
}

func AddArguments() {
  PopulateCMD.Flags().StringVarP(&SecretName,
    "name",
    "n", "",
    "Name of the secret to be populated")

  PopulateCMD.Flags().StringVarP(&SecretValue,
    "value",
    "v", "",
    "Value of the secret to be populated - It'll also look for the"+
      " SECRET_MANAGER_FILLER_SECRET_VALUE environment variable if not provided")

  PopulateCMD.Flags().StringVarP(&AWSRegion,
    "region",
    "r", "",
    "AWS Region to be used - It'll also look for the"+
      " AWS_REGION environment variable if not provided")

  _ = PopulateCMD.MarkFlagRequired("name")
}

func init() {
  AddArguments()
}
