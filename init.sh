#/bin/bash
cd ${PWD}/terraform
terraform init -backend-config="region=us-east-1" -backend-config="bucket=bit-ops-terraform" -backend-config="key=state/service/ecr-cleanup/ops.tfstate"
