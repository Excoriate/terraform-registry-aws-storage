package cli

import (
  "context"
  "os"
)

import (
  "github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
  Version: "v0.0.1",
  Use:     "secret-manager-filler",
  Long:    "Tiny utility that aims to fill adapter with proper values in AWS Secrets Manager",
  Example: "",
  Run: func(cmd *cobra.Command, args []string) {
    _ = cmd.Help()
  },
}

func Execute() {
  err := rootCmd.ExecuteContext(context.Background())
  if err != nil {
    os.Exit(1)
  }
}

func init() {
  rootCmd.AddCommand(PopulateCMD)
  rootCmd.AddCommand(ListCMD)
}
