package client

import (
	"context"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
)

func Client() *aws.Config {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	if err != nil {
		panic("configuration error, " + err.Error())
	}
	// cre, err := cfg.Credentials.Retrieve(context.TODO())
	// if err != nil {
	// 	panic("failed to retrieve credentials, " + err.Error())
	// }
	// fmt.Println("Access Key ID: " + cre.AccessKeyID)
	return &cfg
}
