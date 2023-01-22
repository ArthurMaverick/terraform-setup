package main_test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestVpcModule(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../modules/vpc",
		VarFiles:     []string{"/home/arthur/Documents/terraform/project/default.tfvars"},
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	vpcID := terraform.Output(t, terraformOptions, "vpc_id")

	if vpcID == "" {
		t.Fatal("Expected a non-empty VPC ID to be returned")
	}
}
