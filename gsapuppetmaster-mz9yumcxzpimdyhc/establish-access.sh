#!/bin/bash
set -euo pipefail

function download_certificate() {
  echo "Downloading server certificate for server gsapuppetmaster."
  aws --region=eu-central-1 opsworks-cm describe-servers --server-name gsapuppetmaster \
--query "Servers[0].EngineAttributes[?Name=='PUPPET_API_CA_CERT'].Value" \
--output text >| .config/ssl/cert/ca.pem

}

function generate_access_token() {
  echo "Generating puppet access token for server gsapuppetmaster."
  puppet-access login --config-file .config/puppetlabs/client-tools/puppet-access.conf --lifetime 8h
}

download_certificate
generate_access_token