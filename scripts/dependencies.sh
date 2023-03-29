#!bin/bash

KERNEL_NAME=$(uname -s)
ARCH=$(uname -m)

if [ $KERNEL_NAME == "Darwin" ]; then
    KERNEL_NAME="darwin"
fi

if [ $KERNEL_NAME == "Linux" ]; then
    KERNEL_NAME="linux"
fi

if [ $ARCH == "x86_64" ]; then
    ARCH="amd64"
fi

if [ $ARCH == "aarch64" ]; then
    ARCH="arm64"
fi

if [ $ARCH == "i686" ]; then
    ARCH="386"
fi

echo "Installing dependencies..."

echo "install terraform pre-commit hooks"
sudo apt-get install pre-commit -y

echo "install terraform docs"

curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/v0.16.0/terraform-docs-v0.16.0-$KERNEL_NAME-$ARCH.tar.gz
tar -xzf terraform-docs.tar.gz
chmod +x terraform-docs
mv terraform-docs /usr/local/bin/terraform-docs
rm -rf terraform-docs.tar.gz LICENSE README.md

echo "install terraform tfsec"
curl -sSLo ./tfsec tfsec-checkgen-linux-amd64 https://github.com/aquasecurity/tfsec/releases/download/v1.28.1/tfsec-checkgen-$KERNEL_NAME-$ARCH
chmod +x tfsec
mv tfsec /usr/local/bin/tfsec

echo "install terraform tflint"
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

echo "install terragrunt"
echo "installing terragrunt for $KERNEL_NAME $ARCH"
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.43.0/terragrunt_${KERNEL_NAME}_${ARCH}
mv terragrunt_${KERNEL_NAME}_${ARCH} /usr/local/bin/terragrunt
chmod +x /usr/local/bin/terragrunt

echo "infracost install"
curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh
