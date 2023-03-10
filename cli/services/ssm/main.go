package ssm

import (
	"context"
	"fmt"
	"os"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	"github.com/bluearchio/Infrastructure/client"
)

type SSMService struct {
	ssm *ssm.Client
}

func (s *SSMService) MPCConfig() {
	s.ssm = ssm.NewFromConfig(*client.Client())
}

func (s *SSMService) GetParameter(name string) *ssm.GetParameterOutput {
	GetParameterInput := &ssm.GetParameterInput{
		Name: aws.String(name),
	}

	payload, error := s.ssm.GetParameter(context.TODO(), GetParameterInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}

func (s *SSMService) PutParameter(name, value string) *ssm.PutParameterOutput {
	PutParameterInput := &ssm.PutParameterInput{
		Name:      aws.String(name),
		Value:     aws.String(value),
		Overwrite: aws.Bool(true),
	}

	payload, error := s.ssm.PutParameter(context.TODO(), PutParameterInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}

func (s *SSMService) SendCommand(instanceIDs []string, scriptPath, ghToken, project string) {
	script, err := os.ReadFile(scriptPath)
	if err != nil {
		panic(err)
	}
	SendCommandInput := &ssm.SendCommandInput{
		InstanceIds:  instanceIDs,
		DocumentName: aws.String("AWS-RunShellScript"),
		Comment:      aws.String("Bash Script Command"),
		Parameters: map[string][]string{
			"commands": {string(script)},
			"env":      {fmt.Sprintf("GH_TOKEN=%s", ghToken), fmt.Sprintf("PROJECT=%s", project)},
		},
		MaxConcurrency: aws.String("50"),
	}
	GetParameterOutput, error := s.ssm.SendCommand(context.TODO(), SendCommandInput)
	if error != nil {
		fmt.Println(error)
		os.Exit(1)
	}
	// Print the Status, command ID and instance IDs
	fmt.Println("Command ID:", *GetParameterOutput.Command.CommandId)
	fmt.Println("Instance IDs:", GetParameterOutput.Command.InstanceIds)
	fmt.Println("Status:", GetParameterOutput.Command.Status)
}

func (s *SSMService) GetCommandInvocation(commandID, instanceID string) *ssm.GetCommandInvocationOutput {
	GetCommandInvocationInput := &ssm.GetCommandInvocationInput{
		CommandId:  aws.String(commandID),
		InstanceId: aws.String(instanceID),
		PluginName: aws.String("AWS-RunShellScript"),
	}

	GetCommandInvocationOutput, error := s.ssm.GetCommandInvocation(context.TODO(), GetCommandInvocationInput)

	if error != nil {
		fmt.Println(error)
	}
	return GetCommandInvocationOutput
}
