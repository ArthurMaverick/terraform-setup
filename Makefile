###############
# DEPENDENCES #
###############
terraform_dependencies:
	sudo ansible-playbook -i "localhost," -c local ansible/books/terraform-dependencies.yaml
pre-commit_install:
	pre-commit install


#############
# TERRAFORM #
#############
plan:
	cd terraform/${ENV} && terragrunt run-all plan
apply:
	cd terraform/${ENV} && terragrunt run-all apply
destroy:
	cd terraform/${ENV} && terragrunt run-all destroy
planfile_json:
	bash scripts/tfplanjson.sh ${ENV}

#############
# INFRACOST #
#############
infracostauth:
	infracost auth login
infracost:
	bash scripts/infracost.sh terraform/${ENV}
# need authentication
