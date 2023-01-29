# Path to Terraform code
ENV=$1
TF_PATH=terraform/$ENV

WORK_PATH=`echo $(pwd)`
# Generate plan JSON files for all Terragrunt modules and add them to an Infracost config file
cd $TF_PATH && terragrunt run-all apply "$WORK_PATH/terraform/$ENV/tfplan.txt"
