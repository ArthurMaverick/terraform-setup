/*
Copyright © 2023 BLUEARCHIO <>
*/

package cmd

import (
	"strconv"

	"github.com/aws/aws-sdk-go-v2/aws"
	function "github.com/bluearchio/Infrastructure/functions/ec2"
	"github.com/bluearchio/Infrastructure/services/asg"
	"github.com/bluearchio/Infrastructure/services/ec2"
	"github.com/spf13/cobra"
)

var (
	autoscaling    string
	productName    string
	ec2_repository string
)

var createInstance = &cobra.Command{
	Use:   "ec2-instance-create",
	Short: "A brief description of your command",
	Long:  `Create EC2 Instance.`,
	Run: func(_ *cobra.Command, _ []string) {
		ec2_svc := ec2.Ec2Service{}
		ec2_svc.MPCConfig()
		ec2_svc.CreateInstance()
	},
}
var WaitAndGetInstanceIP = &cobra.Command{
	Use:   "ec2-wait-and-get-instance-id",
	Short: "A brief description of your command",
	Long:  `Create EC2 Instance.`,
	Run: func(_ *cobra.Command, _ []string) {
		ami_create := function.EC2Actions{
			Name: aws.String("gold-amazon-linux"),
		}
		ami_create.Config()
		ami_create.WaitAndGetInstanceIP()
	},
}
var CreateAMI = &cobra.Command{
	Use:   "ec2-ami-create",
	Short: "A brief description of your command",
	Long:  `Create EC2 Instance.`,
	Run: func(_ *cobra.Command, _ []string) {
		ami_create := function.EC2Actions{
			Name:       aws.String("gold-amazon-linux"),
			Repository: &ec2_repository,
		}
		ami_create.Config()
		ami_create.GetInstanceID()
		ami_create.GenerateAmi()
	},
}
var ManageASG = &cobra.Command{
	Use:   "ec2-asg",
	Short: "A brief description of your command",
	Long:  `Create EC2 Instance.`,
	Run: func(_ *cobra.Command, _ []string) {
		println(autoscaling)
		payload, err := strconv.ParseInt(autoscaling, 10, 0)
		if err != nil {
			panic(err)
		}

		asg_svc := asg.ASG{}
		asg_svc.MPCConfig()
		asg_svc.UpdateAutoScalingGroup(int32(payload))
	},
}

func init() {
	ManageASG.Flags().StringVarP(&autoscaling, "autoscaling", "a", "", "autoscaling")
	CreateAMI.Flags().StringVarP(&productName, "product-name", "p", "", "Name")
	CreateAMI.Flags().StringVarP(&ec2_repository, "repository", "r", "", "Repository name")

	rootCmd.AddCommand(createInstance, ManageASG, CreateAMI, WaitAndGetInstanceIP)
}

// var ec2Cmd = &cobra.Command{
// 	Use:   "ec2",
// 	Short: "A brief description of your command",
// 	Long:  `A longer description that spans multiple lines and likely contains examples and usage of using your command. For example:`,
// 	// Run: func(_ *cobra.Command, _ []string) {
// 	Run: func(_ *cobra.Command, _ []string) {
// 		ec2_svc := ec2.Ec2Service{}
// 		s3_svc := s3.S3Service{}
// 		ec2_svc.MPCConfig()
// 		s3_svc.MPCConfig()

//			instanceIds := []string{instanceId}
//			if method == "start" {
//				ec2_svc.StartEc2Instances(instanceIds)
//			}
//			if method == "stop" {
//				ec2_svc.StopEc2Instances(instanceIds)
//			}
//			if method == "generate-ami" {
//				ec2_svc.GenerateEc2AMI(instanceId, name, description)
//			}
//			if method == "get-id" {
//				ec2_svc.GetEc2InstanceID(instanceId)
//			}
//			if method == "create-key" {
//				// prepare bucket name and key name variables
//				buket_name := fmt.Sprintf("%s-bucket-%s", keyName, uuid.New().String())
//				keyname_formated := fmt.Sprintf("%s.pem", keyName)
//				// create keypair
//				create_keypair := ec2_svc.CreateKeyPair(keyName)
//				readfile := strings.NewReader(*create_keypair.KeyMaterial)
//				//  create bucket
//				s3_svc.CreateBucket(buket_name)
//				// put object
//				s3_svc.PutObject(buket_name, keyname_formated, readfile)
//				fmt.Printf("KeyPair created and uploaded to S3 \n Bucket: %s \n Key: %s", buket_name, keyname_formated)
//			}
//			if method == "send-command" {
//				// ec2_svc.RunCommand(instanceIds, parameters)
//				fmt.Println("send-command")
//			}
//		},
//	}

// var GetInstanceIP = &cobra.Command{
// 	Use:   "get-instance-ip",
// 	Short: "A brief description of your command",
// 	Long:  `Create EC2 Instance.`,
// 	Run: func(_ *cobra.Command, _ []string) {
// 		ami_create := function.EC2Actions{
// 			Name: aws.String("gold-amazon-linux"),
// 		}
// 		ami_create.Config()
// 		ami_create.WaitAndGetInstanceIP()
// 		ami_create.GetInstanceIP()
// 	},
// }
