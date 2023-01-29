# Path to Terraform code
ENV=$1
TF_PATH=terraform/$ENV
cd $TF_PATH

# Generate plan JSON files for all Terragrunt modules and add them to an Infracost config file
terragrunt run-all --terragrunt-ignore-external-dependencies plan -out tfplan.txt

# Find the plan files
plans=($(find . -name tfplan.txt))

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

# done
