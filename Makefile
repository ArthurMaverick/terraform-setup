terraform_dependencies:
	sudo ansible-playbook -i "localhost," -c local ansible/books/terraform-dependencies.yaml

pre-commit_install:
	pre-commit install

# workspaces management
set_workspace:
	git checkout -b $(env)
	terragrunt init
