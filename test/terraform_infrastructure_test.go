package test

import (
	"fmt"

	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformEC2(t *testing.T) {
	t.Parallel()

	expectedInstanceType := "t2.micro"
	// expectedInstanceType := "t2.small" // for `dev` environment
	// expectedInstanceType := "t2.medium" // for `prod` environment
	// expectedWorkSpace := "dev"
	// expectedWorkSpace := "prod"

	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		// website::tag::1::Set the path to the Terraform code that will be tested.
		// The path to where our Terraform code is located
		TerraformDir: "../infrastructure",
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created.
	defer terraform.Destroy(t, terraformOptions)

	// log.Print("Changing workspace!!!!!!!!")
	// fmt.Println("****************Changing workspace****************")
	// workSpace := terraform.WorkspaceSelectOrNew(t, terraformOptions, "dev")
	// workSpace := terraform.WorkspaceSelectOrNew(t, terraformOptions, "prod")

	// Run `terraform init` and `terraform apply`. Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the outputs
	instanceType := terraform.Output(t, terraformOptions, "instance_type")
	publicIp := terraform.Output(t, terraformOptions, "instance_public_ip")

	// Make an HTTP request to the instance and make sure we get back a 200 OK
	// with the body "Hello, World!"
	url := fmt.Sprintf("http://%s:8080", publicIp) // http://[44.192.69.23]:8080

	// func HttpGetWithRetry(t testing.TestingT, url string, tlsConfig *tls.Config,
	// expectedStatus int, expectedBody string, retries int, sleepBetweenRetries time.Duration)
	http_helper.HttpGetWithRetry(t, url, nil, 200, "Hello, World!", 30, 5*time.Second)

	// assert.Equal(t, expectedWorkSpace, workSpace)
	assert.Equal(t, expectedInstanceType, instanceType)
}
