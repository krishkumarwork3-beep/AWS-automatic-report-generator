#!/bin/bash

#####################
# Author: Krish
# Date: 11th Jan
#
#
# Version v1
#
# This script will report the AWS resource usage
#####################

# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users

# Get the directory this script lives in
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Output file
OUTPUT_DIR="$SCRIPT_DIR/aws-reports"
OUTPUT_FILE="$OUTPUT_DIR/aws_resource_report_$(date +%F_%H-%M-%S).txt"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

{
    echo "AWS Resource Usage Report - $(date)"

    # list s3 buckets
    echo "Print list of s3 buckets"
    aws s3 ls

    # list EC2 instances
    echo "Print list of ec2 instances"
    aws ec2 describe-instances | jq '.Reservations[].Instances[].Architecture'

    # list lambda
    echo "Print list of lambda functions"
    aws lambda list-functions

    #list IAM users
    echo "Print list of IAM Users"
    aws iam list-users

} > "$OUTPUT_FILE" 2>&1

echo "Report saved to: $OUTPUT_FILE"
