###############
# DEPENDENCES #
###############
terraform_dependencies:
	sudo ansible-playbook -i "localhost," -c local ansible/books/terraform-dependencies.yaml
pre-commit_install:
	pre-commit install


################
# TERRAFORM CLI
################

# --------------
# plan commands
# --------------
plan:
	cd terraform/${STAGE} && terragrunt run-all plan
plan_module:
	terragrunt plan --terragrunt-working-dir=terraform/${STAGE}/${AWS_REGION}/$(module)

planfile_json:
	bash scripts/tfplanjson.sh ${STAGE}

# --------------
# apply commands
# --------------
apply:
	cd terraform/${STAGE} && terragrunt run-all apply
apply_module:
	terragrunt apply --terragrunt-working-dir=terraform/${STAGE}/${AWS_REGION}/$(module) -auto-approve

# ----------------
# destroy commands
# ----------------
destroy:
	cd terraform/${STAGE} && terragrunt run-all destroy
destroy_module:
	terragrunt destroy --terragrunt-working-dir=terraform/${STAGE}/${AWS_REGION}/$(module)

# --------------
# state commands
# --------------
state_list:
	terragrunt state list --terragrunt-working-dir=terraform/${STAGE}/${AWS_REGION}/$(module)

#############
# INFRACOST #
#############
infracostauth:
	infracost auth login
infracost:
	bash scripts/infracost.sh terraform/${STAGE}
# need authentication
