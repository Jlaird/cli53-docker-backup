#!/bin/bash

mkdir domains

for domain in $(cli53 list -format json | jq '.[].Name' |sed -e 's/^"//' -e 's/"$//'); do

  echo $domain
  cli53 export "$domain" > "domains/$domain"

  tar -cvf route53-domains.tar domains/*

done

aws s3 cp route53-domains.tar s3://cygnusbackups/route53/

# Clean up
rm -fr route53-domains.tar domains/
