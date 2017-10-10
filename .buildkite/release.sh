#!/usr/bin/env bash

bucket=${RELEASE_BUCKET:-s3://bit-ops-artifacts}
service=${RELEASE_SERVICE:-ecr-cleaner}
zip_file="${service}-lambda.zip"
bucket_key="${bucket}/${service}-lambda/latest/${zip_file}"

# Make package
cd ../
rm -rf ./bin
GOARCH=amd64 GOOS=linux go build -o bin/linux/ecr-cleaner
zip -j ${zip_file} ./bin/linux/ecr-cleaner ./python/index.py

# Push
echo "Pushing zip file: ${zip_file} to ${bucket_key}..."
aws s3 cp ${zip_file} ${bucket_key}

# Cleanup
echo "Removing zip file: ${zip_file}..."
rm -f ${zip_file}