package adapter

import (
  "context"
  "github.com/aws/aws-sdk-go-v2/aws"
  awsCfg "github.com/aws/aws-sdk-go-v2/config"
)

func ToAWS(region string) (aws.Config, error) {
  awsAuth, err := awsCfg.LoadDefaultConfig(context.TODO(), awsCfg.WithRegion(region))
  if err != nil {
    return aws.Config{}, err
  }

  return awsAuth, nil
}
