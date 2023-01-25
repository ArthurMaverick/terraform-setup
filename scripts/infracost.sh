# Path to Terraform code
TF_ROOT=$1

cd $TF_ROOT

# Generate plan JSON files for all Terragrunt modules and add them to an Infracost config file
terragrunt run-all --terragrunt-ignore-external-dependencies plan -out tfplan.binary

# Find the plan files
plans=($(find . -name tfplan.binary))

# Generate plan JSON files by running terragrunt show for each plan file
planjsons=()
for plan in "${plans[@]}"; do
  # Find the Terraform working directory for running terragrunt show
  # We want to take the dir of the plan file and strip off anything after the .terraform-cache dir
  # to find the location of the Terraform working directory that contains the Terraform code
  dir=$(dirname $plan)
  dir=$(echo "$dir" | sed 's/\(.*\)\/\.terragrunt-cache\/.*/\1/')

  # Customize this to how you run Terragrunt
  echo "Running terragrunt show for $(basename $plan) for $dir"
  terragrunt show -json $(basename $plan) --terragrunt-working-dir=$dir --terragrunt-no-auto-init > $dir/plan.json
  planjsons=(${planjsons[@]} "$dir/plan.json")
done

# Sort the plan JSONs so we get consistent project ordering in the config file
IFS=$'\n' planjsons=($(sort <<<"${planjsons[*]}"))

# Generate Infracost config file
echo -e "version: 0.1\n\nprojects:\n" > infracost-generated.yml
for planjson in "${planjsons[@]}"; do
  echo -e "  - path: $planjson" >> infracost-generated.yml
done

# Infracost CLI commands can be run now
infracost breakdown --config-file=infracost-generated.yml

# Cleanup generated files
rm infracost-generated.yml
rm $plans
rm $planjsons
