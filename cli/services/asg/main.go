package asg

import (
	"context"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/autoscaling"
	"github.com/bluearchio/Infrastructure/client"
)

type ASG struct {
	autoscaling *autoscaling.Client
}

func (asg *ASG) MPCConfig() {
	asg.autoscaling = autoscaling.NewFromConfig(*client.Client())
}

func (asg *ASG) UpdateAutoScalingGroup(instancesCount int32) {
	ascd := &autoscaling.UpdateAutoScalingGroupInput{
		AutoScalingGroupName: aws.String("products_builder-autoscaling_group"),
		MaxSize:              aws.Int32(1),
		MinSize:              aws.Int32(0),
		DesiredCapacity:      aws.Int32(instancesCount),
	}
	asg.autoscaling.UpdateAutoScalingGroup(context.TODO(), ascd)

}
