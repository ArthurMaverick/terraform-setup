package vpc_test

import (
	"strconv"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

type Test struct {
}

func TestVpcModule(t *testing.T) {

	terraformOptions := &terraform.Options{
		TerraformDir: "../../us-east-2/vpc/",
		VarFiles:     []string{"vpc.tfvars"},
	}

	terraform.WithDefaultRetryableErrors(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	defer terraform.Destroy(t, terraformOptions)

	vpcID := terraform.Output(t, terraformOptions, "vpc_id")
	vpcAddress := terraform.Output(t, terraformOptions, "vpc_cidr")

	assert.NotEmpty(t, vpcID, "Expected a non-empty VPC ID to be returned")
	ip_range, _ := strconv.Atoi(strings.Split(vpcAddress, "/")[1])
	assert.GreaterOrEqual(t, ip_range, 16, "CIDR range block needs to be greater then 16")
	assert.LessOrEqual(t, ip_range, 20, "CIDR range block needs to be less then 20")

}
