package ec2

import (
	"fmt"
	"os"
	"time"

	"github.com/aws/aws-sdk-go-v2/service/ec2/types"
	"github.com/bluearchio/Infrastructure/services/ec2"
	"github.com/google/uuid"
)

type EC2Actions struct {
	ec2        *ec2.Ec2Service
	InstanceIP *string
	InstanceID *string
	Name       *string
	Repository *string
	Status     chan types.InstanceStateName
}

func (e *EC2Actions) Config() {
	e.ec2 = &ec2.Ec2Service{}
	e.ec2.MPCConfig()
}
func (e *EC2Actions) WaitAndGetInstanceIP() {
	for {
		for _, instances := range e.ec2.DescribeInstances().Reservations {
			for _, instance := range instances.Instances {
				if instance.State.Name == types.InstanceStateNameRunning {
					e.InstanceIP = instance.PublicIpAddress
					fmt.Println(*e.InstanceIP)
					os.Exit(0)
				}
			}
		}
		time.Sleep(2 * time.Second)
		fmt.Println("Waiting for instance to start...")
	}
}
func (e *EC2Actions) GenerateAmi() {
	fmt.Println("Generating AMI...")
	payload := *e.ec2.GenerateEc2AMI(fmt.Sprintf("%s-%v", *e.Repository, uuid.New().ID()), "Software by BlueArchio")
	fmt.Printf("ImageID: %v created.\n", *payload.ImageId)
}
func (e *EC2Actions) GetInstanceID() {

	InstanceID, err := e.ec2.GetEc2InstanceID()
	if err != nil {
		fmt.Println(err)
	}
	e.InstanceID = &InstanceID
}

// func (e *EC2Actions) WatchInstanceState() {

// 	instanceStateChan := make(chan types.InstanceStateName)

//		go func() {
//			for _, instances := range e.ec2.ListInstances().Reservations {
//				for _, instance := range instances.Instances {
//					if instance.State.Name == types.InstanceStateNameRunning {
//						instanceStateChan <- instance.State.Name
//						e.InstanceIP = instance.PublicIpAddress
//					}
//				}
//			}
//			e.ec2.DescribeInstanceStatus(*e.InstanceIP, "running", instanceStateChan)
//		}()
//		instanceState := <-instanceStateChan
//		fmt.Printf("Waiting for instance %s to start...\n", *e.InstanceIP)
//		fmt.Printf("Instance %s is now %s\n", *e.InstanceIP, instanceState)
//	}
