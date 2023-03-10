## Getting Started
To get started with this infrastructure repository, you will need:

- An AWS Marketplace product built on an Amazon Machine Image (AMI)
- A working knowledge of Terraform and AWS

The repository includes detailed documentation on how to use the Terraform modules and scripts to update your AMI. To get started, simply clone the repository and follow the instructions in the documentation.

## Packages
- **Ansible**
  The Ansible Playbooks help install dependencies and configure the environment for the Terraform development.
- **CLI**
  The CLI is use aws sdk to mangaing aws resources like ec2 and aws marketplace, etc.
- **Modules**
  The modules are used to create reusable components for the Terraform development.
- **Scripts**
  The scripts are used to automate the Terraform development.
- **Terraform**
  Local where you create components using terragrunt.
- **Tests**
  The integrations and end2end tests are used to validate the Terraform development.

# Terraform Dependencies
  - pre-commit
  - tfsec
  - tflint
  - terragrunt
  - terraform-docs

**to install terraform depenpendencies:**

```bash
  make terraform_dependencies
```
## Enable pre-commit hooks
_After install terraform dependencies, you need to enable pre-commit hooks to validate your code before commit._
```bash
make pre-commit
```

## Provisioning AWS resources

### 1. First Step
_It´s recommended install aws-vault to manage your aws credentials easily._
**without aws-vault**
```bash
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
```

**with aws-vault**
```bash
aws-vault exec <profile> --no-session
```
### 2. Second Step
export environment where you want to create your resources
```bash
export ENV=dev
export AWS_REGION=us-east-1
```

### 3. Third Step
run makefile to plan your resources
```bash
make plan
```

### 4. Fourth Step
run makefile to apply your resources
```bash
make apply
```

### Issues
If you have any issues, please open a ticket in the [Issues]() section.
**EX:**
- **Intention** = _What is the purpose of the Issue?_
- **Design** = _Show a design to solve the problem_
- **Implementation** = _Clearly list the steps for implementation_

### Contributing
If you want to contribute to this project, please create a pull request. We will review it and merge it if it is relevant.

### Conclusion
This infrastructure repository provides a powerful solution for updating your AWS Marketplace product's AMI. By automating the process of creating a new version of your product and updating the product's listing in the AWS Marketplace, you can save time, reduce errors, and ensure consistency and reliability.
