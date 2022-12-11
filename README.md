# Terraform Task for Blue Billy Wig

You have just been hired as the new DevOps Engineer at ACME inc. They have been working with Ansible and Cloudformaon for the last couple of years and via word of mouth, Terraform has sparked their interest but they’re not completely sure if Terraform is the way to go. You are a fan of Terraform and are trying to convince them of taking this route.

## Explain how Terraform works and how it compares to Cloudformation + Ansible (basics, pialls, pros and cons)

### Explain how Terraform works
- Needs:
  - terraform Terraform ~> 1.3
  - terraform-docs
  - go
  - tflint

- Here is a sample Terraform infrastructure.
```
task-BBW-Terraform
├─ backend
│  └─ main.tf
├─ infrastructure
│  ├─ main.tf
│  ├─ outputs.tf
│  ├─ README.md
│  ├─ variables.tf
│  └─ versions.tf
├─ modules
│  ├─ ec2
│  │  ├─ main.tf
│  │  ├─ outputs.tf
│  │  ├─ README.md
│  │  ├─ userdata.sh
│  │  ├─ variables.tf
│  │  └─ versions.tf
│  └─ s3-backend
│     ├─ main.tf
│     ├─ outputs.tf
│     ├─ README.md
│     ├─ variables.tf
│     └─ versions.tf
├─ README.md
└─ test
   └─ terraform_infrastructure_test.go
```

- There will be one module for a service. IAM role, s3 etc.

- Backend will be an s3 bucket which enables us to work as a team securely. (Tfstate, locking) 

- Infrastructure will be tested using Terratest (Go).

To spin up this demo:
- Clone `https://github.com/bluehackrafestefano/task-BBW-Terraform`.

- cd to backend folder.
- Use terraform to create s3 backend:
```hcl
terraform init
terraform plan
terraform apply -auto-approve
```

- Get the bucket name and dynamodb table name from the autput. This operation will be done once for whole infra.

- cd to infrastructure folder.

- Paste bucket name and dynamodb table name to versions.tf.

- Use terraform:
```hcl
terraform init
terraform fmt
terraform validate
tflint
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve
terrafrom graph
```

- Copy graph output.

- Navigate to [GraphvizOnline](https://dreampuf.github.io/GraphvizOnline) page. Paste graph output.

- cd to test folder.

- Test terraform:
```go
go mod init github.com/bluehackrafestefano/gopath
go mod tidy
go test -v -run TestTerraformEC2 -timeout 10m
```
- Optionally, change workspace to `prod` by activating related lines on the test and see the result.

### Compare to Cloudformation + Ansible (basics, pialls, pros and cons)
- Basically Cloudformation and Terraform have similar solutions.
- If change to other cloud provider it is a must to use terraform.
- Terraform can do some configuration operations like local/remote exec and files.
- Ansible still will be an altimate solution for CM. But, simple techniques like creating golden image, user data, and Terraform remote exec can reduce Ansible requirements.
- Terraform runs on a HCL and quite flexible to create loops and conditionals.


## Explain in general terms what it would take to move from their current setup to a full blown Terraform implementaon
- We will create modules for every service the company is using on cloud. And infrastructure files to spin up the services. 
- We will write Terratest for each infrastructure.
- It will take time, but we can start small


## Describe how you would approach the implementation of this project in their environment (best practices)
- Team will create a naming convention, and tagging strategy.
- We will decide the repo to keep tf modules.
- Best practices implemented on this task:
  - Use decoupled modules
  - Follow a standard module structure
  - Adopt a naming convention, give standard names to resources. ("web_server" not "web-server")
  - Document output descriptions in the README.md file. Auto-generate descriptions on commit with tools like terraform-docs
  - Put data sources next to the resources that reference them.
  - Use scripts only when necessary.
  - Use built-in formatting (fmt)
  - Use for_each for iterated resources
  - Expose outputs for all resources
  - Minimize the number of resources in each root module
  - Pin to minor provider versions
  - Use remote state, and use gitignore for Terraform state files.
  - Encrypt state
  - Use less expensive test methods first (validate, tflint)
  - Testing (terratest)
  - Optimize test runtime (run tests in parallel)
  - Start small

