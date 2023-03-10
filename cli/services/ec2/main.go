package ec2

import (
	"context"
	"fmt"
	"os"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/ec2"
	"github.com/aws/aws-sdk-go-v2/service/ec2/types"
	"github.com/bluearchio/Infrastructure/client"
)

type Ec2Service struct {
	ec2        *ec2.Client
	InstanceID *string
	ImageID    *string
}

func (e *Ec2Service) MPCConfig() {
	e.ec2 = ec2.NewFromConfig(*client.Client())
}
func (e *Ec2Service) StartEc2Instances(instanceIds []string) *ec2.StartInstancesOutput {
	StartInstancesInput := &ec2.StartInstancesInput{
		InstanceIds: instanceIds,
	}

	payload, error := e.ec2.StartInstances(context.TODO(), StartInstancesInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}
func (e *Ec2Service) StopEc2Instances(instanceIds []string) *ec2.StopInstancesOutput {
	StopInstancesInput := &ec2.StopInstancesInput{
		InstanceIds: instanceIds,
	}
	payload, error := e.ec2.StopInstances(context.TODO(), StopInstancesInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}
func (e *Ec2Service) GenerateEc2AMI(Productname, description string) *ec2.CreateImageOutput {
	BlockDeviceMapping := []types.BlockDeviceMapping{
		{
			DeviceName: aws.String("/dev/sda1"),
			Ebs: &types.EbsBlockDevice{
				Encrypted:           aws.Bool(false),
				DeleteOnTermination: aws.Bool(true),
				VolumeSize:          aws.Int32(8),
				VolumeType:          types.VolumeType("gp2"),
			},
		},
	}
	CreateImageInput := &ec2.CreateImageInput{
		InstanceId:          aws.String(*e.InstanceID),
		Name:                aws.String(Productname),
		Description:         aws.String(description),
		BlockDeviceMappings: BlockDeviceMapping,
		TagSpecifications: []types.TagSpecification{
			{
				ResourceType: types.ResourceTypeImage,
				Tags: []types.Tag{
					{
						Key:   aws.String("Name"),
						Value: aws.String(Productname),
					},
				},
			},
		},
	}

	payload, error := e.ec2.CreateImage(context.TODO(), CreateImageInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}
func (e *Ec2Service) GetEc2InstanceID() (string, error) {
	var instanceValue string
	DescribeInstancesInput := &ec2.DescribeInstancesInput{}

	payload, error := e.ec2.DescribeInstances(context.TODO(), DescribeInstancesInput)

	if error != nil {
		return "", os.ErrNotExist
	}

	for _, reservations := range payload.Reservations {
		for _, instance := range reservations.Instances {
			if instance.State.Name == types.InstanceStateNameRunning {
				e.InstanceID = instance.InstanceId
			}
		}
	}

	return instanceValue, nil
}
func (e *Ec2Service) DescribeInstanceStatus(state types.InstanceStateName, stateChan chan<- types.InstanceStateName) {

	DescribeInstanceStatusInput := &ec2.DescribeInstanceStatusInput{
		IncludeAllInstances: aws.Bool(true),
		InstanceIds:         []string{*e.InstanceID},
	}
	for {
		payload, err := e.ec2.DescribeInstanceStatus(context.TODO(), DescribeInstanceStatusInput)
		if err != nil {
			panic(err)
		}
		if len(payload.InstanceStatuses) > 0 && payload.InstanceStatuses[0].InstanceState.Name == state {
			stateChan <- state
			return
		}
		time.Sleep(5 * time.Second)
	}
}
func (e *Ec2Service) DescribeInstances() *ec2.DescribeInstancesOutput {
	DescribeInstancesInput := &ec2.DescribeInstancesInput{}

	payload, error := e.ec2.DescribeInstances(context.TODO(), DescribeInstancesInput)

	if error != nil {
		fmt.Println(error)
	}

	return payload
}
func (e *Ec2Service) CreateKeyPair(KeyName string) *ec2.CreateKeyPairOutput {
	DescribeInstanceStatusInput := &ec2.CreateKeyPairInput{
		KeyName: aws.String(KeyName),
		KeyType: types.KeyType("rsa"),
	}

	payload, error := e.ec2.CreateKeyPair(context.TODO(), DescribeInstanceStatusInput)

	if error != nil {
		fmt.Println(error)
	}

	return payload
}
func (e *Ec2Service) DeleteKeyPair(KeyName string) *ec2.DeleteKeyPairOutput {
	DeleteKeyPairInput := &ec2.DeleteKeyPairInput{
		KeyName: aws.String(KeyName),
	}

	payload, error := e.ec2.DeleteKeyPair(context.TODO(), DeleteKeyPairInput)

	if error != nil {
		fmt.Println(error)
	}

	return payload
}
func (e *Ec2Service) CreateInstance() *ec2.RunInstancesOutput {
	// EbsBlockDevice :=
	BlockDeviceMapping := []types.BlockDeviceMapping{
		{
			DeviceName: aws.String("/dev/sda1"),
			Ebs: &types.EbsBlockDevice{
				Encrypted:           aws.Bool(true),
				VolumeSize:          aws.Int32(8),
				VolumeType:          types.VolumeType("gp2"),
				DeleteOnTermination: aws.Bool(true),
			},
		},
	}

	Tag := types.TagSpecification{
		Tags: []types.Tag{
			{
				Key:   aws.String("Name"),
				Value: aws.String("ami-builder"),
			},
		},
		ResourceType: types.ResourceType("instance"),
	}

	TagSpecification := []types.TagSpecification{Tag}

	net := []types.InstanceNetworkInterfaceSpecification{
		{
			AssociatePublicIpAddress: aws.Bool(true),
			DeviceIndex:              aws.Int32(0),
			DeleteOnTermination:      aws.Bool(true),
			Groups:                   []string{"sg-06a5725361bc21bdd"},
			SubnetId:                 aws.String("subnet-08dfb876b20415032"),
			Description:              aws.String("ami builder network interface"),
		},
	}

	RunInstancesInput := &ec2.RunInstancesInput{
		TagSpecifications:   TagSpecification,
		ImageId:             aws.String("ami-065bb5126e4504910"),
		InstanceType:        types.InstanceType("t2.micro"),
		MinCount:            aws.Int32(1),
		MaxCount:            aws.Int32(1),
		KeyName:             aws.String("ami-builder"),
		NetworkInterfaces:   net,
		BlockDeviceMappings: BlockDeviceMapping,
	}

	payload, error := e.ec2.RunInstances(context.TODO(), RunInstancesInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}
func (e *Ec2Service) DescribeAmi() *ec2.DescribeImagesOutput {
	DescribeImageInput := &ec2.DescribeImagesInput{
		ImageIds: []string{*e.ImageID},
	}

	payload, error := e.ec2.DescribeImages(context.TODO(), DescribeImageInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}
