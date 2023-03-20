package cli

import (
  "fmt"
  "github.com/Excoriate/terraform-registry-aws-storage/cmd/cli/actions"
  "github.com/spf13/cobra"
  "os"
)

var ListCMD = &cobra.Command{
  Version: "v0.0.1",
  Use:     "list",
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
    err := actions.ListAll(actions.ListActionArgs{
      AWSRegion: regionNormalised,
    })

    if err != nil {
      os.Exit(1)
    }
  },
}

func AddArgsToListCMD() {
  ListCMD.Flags().StringVarP(&AWSRegion,
    "region",
    "r", "",
    "AWS Region to be used - It'll also look for the"+
      " AWS_REGION environment variable if not provided")
}

func init() {
  AddArgsToListCMD()
}
