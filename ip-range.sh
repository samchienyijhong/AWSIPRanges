#!/bin/bash

curl -o ip-ranges.json https://ip-ranges.amazonaws.com/ip-ranges.json

while IFS= read -r region; do
  echo -e "--- $region ---"
  jq -r '.prefixes[] | select(.region=='\"$region\"') | select(.service=="<**SERVICE**>") | .ip_prefix' <ip-ranges.json
done <regions.txt
