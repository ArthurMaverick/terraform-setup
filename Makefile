
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
tfplanjson_module:
	sudo ansible-playbook -i "localhost," -c local ansible/books/terraform-tfplanjson.yaml -e "tf_module=$(module)" -v

tfplan:
	cd terraform && \
	terragrunt run-all plan -out tfplan.bin


#############
# INFRACOST #
#############
infracostauth:
	infracost auth login

infracost:
	bash ansible/scripts/infracost.sh $(tfmodule)
# need authentication
