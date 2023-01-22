terraform_dependencies:
	sudo ansible-playbook -i "localhost," -c local ansible/books/terraform-dependencies.yaml

infracost_auth:
	infracost auth login

infracost_generate:
	infracost breakdown --path terraform/default/us-east-1/$(module)

pre-commit_install:
	pre-commit install
