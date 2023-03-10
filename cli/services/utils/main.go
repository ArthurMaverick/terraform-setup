package utils

import (
	"context"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/sts"
	"github.com/bluearchio/Infrastructure/client"
)

type UtilsServices struct {
	config *aws.Config
}

func (u *UtilsServices) GetConfig() {
	u.config = client.Client()
}

func (u *UtilsServices) GetRegion() string {
	return u.config.Region
}

func (u *UtilsServices) GetAccountID() string {
	stsClient := sts.NewFromConfig(*u.config)
	payload, err := stsClient.GetCallerIdentity(context.TODO(), &sts.GetCallerIdentityInput{})
	if err != nil {
		panic("failed to retrieve account ID, " + err.Error())
	}
	return *payload.Account
}
