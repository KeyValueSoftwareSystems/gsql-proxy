#!/bin/bash
if which cloud_sql_proxy &>/dev/null
then
{    
    which gsql-proxy | xargs sudo rm -rf 
}
fi
# curl -s https://raw.githubusercontent.com/KeyValueSoftwareSystems/gsql-proxy/master/scripts/install_prerequisites.sh | bash
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/KeyValueSoftwareSystems/gsql-proxy/releases/latest)
LATEST_VERSION_TAG=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
LATEST_VERSION="${LATEST_VERSION_TAG:1}"
ARTIFACT_URL=https://github.com/KeyValueSoftwareSystems/gsql-proxy/releases/download/${LATEST_VERSION_TAG}/gsql-proxy_${LATEST_VERSION}_Linux_x86_64.tar.gz
wget -qc  $ARTIFACT_URL -P /tmp && sudo tar -xvf /tmp/gsql-proxy_${LATEST_VERSION}_Linux_x86_64.tar.gz -C /usr/local/bin/ gsql-proxy >/dev/null 2>&1
gsql-proxy connect --help
