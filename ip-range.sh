#!/bin/bash

curl -o ip-ranges.json https://ip-ranges.amazonaws.com/ip-ranges.json

echo "Please input the service:
Valid values: AMAZON | AMAZON_APPFLOW | AMAZON_CONNECT | API_GATEWAY | CHIME_MEETINGS | CHIME_VOICECONNECTOR | CLOUD9 | CLOUDFRONT | CLOUDFRONT_ORIGIN_FACING | CODEBUILD | DYNAMODB | EBS | EC2 | EC2_INSTANCE_CONNECT | GLOBALACCELERATOR | KINESIS_VIDEO_STREAMS | ROUTE53 | ROUTE53_HEALTHCHECKS | ROUTE53_HEALTHCHECKS_PUBLISHING | ROUTE53_RESOLVER | S3 | WORKSPACES_GATEWAYS"
read -r service

echo "Please input the region:
Valid values: ALL | ap-east-1 | ap-northeast-1 | ap-northeast-2 | ap-northeast-3 | ap-south-1 | ap-southeast-1 | ap-southeast-2 | ca-central-1 | cn-north-1 | cn-northwest-1 | eu-central-1 | eu-central-2 | eu-north-1 | eu-south-1 | eu-south-2 | eu-west-1 | eu-west-2 | eu-west-3 | me-central-1 | me-south-1 | sa-east-1 | us-east-1 | us-east-2 | us-gov-east-1 | us-gov-west-1 | us-west-1 | us-west-2 | GLOBAL"
read -r regions

if [[ "$regions" == "ALL" ]]
then
  echo -e "us-east-2
us-east-1
us-west-1
us-west-2
af-south-1
ap-east-1
ap-southeast-3
ap-south-1
ap-northeast-3
ap-northeast-2
ap-southeast-1
ap-southeast-2
ap-northeast-1
ca-central-1
eu-central-1
eu-west-1
eu-west-2
eu-south-1
eu-west-3
eu-south-2
eu-north-1
eu-central-2
me-south-1
me-central-1
sa-east-1" > regions.txt
  else
  echo "$regions" > regions.txt
fi

while IFS= read -r region; do
  echo -e "--- $region ---"
  jq -r '.prefixes[] | select(.region=='\"$region\"') | select(.service=='\"$service\"') | .ip_prefix' <ip-ranges.json
done <regions.txt

rm ip-ranges.json regions.txt
