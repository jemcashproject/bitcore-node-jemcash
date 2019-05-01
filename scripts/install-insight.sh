#/usr/bin/env bash

echo "This script downloads Jemcash Insight server sources and creates a NodeJS to host the server."
echo "The bitcore-node-jemcash library should be downloaded and accessible from the cwd."
echo "Parameter 1 is used as the new node name. The default new node name is n."
echo

set -x

lib_name=bitcore-node-jemcash

(cd $lib_name; npm i)

node_name=${1-n}

$lib_name/bin/bitcore-node-jemcash create $node_name

cd $node_name

node_modules/bitcore-node-jemcash/bin/bitcore-node-jemcash install jemcashproject/insight-ui-jemcash
node_modules/bitcore-node-jemcash/bin/bitcore-node-jemcash install jemcashproject/insight-api-jemcash

find . -name "jcore-lib" -type d -not -path "./node_modules/jcore-lib" | xargs rm -rf

set +x

echo 
echo "Please enter proper settings to the $node_name/bitcore-node-jemcash.json file and use the" 
echo "  cd $node_name; node_modules/bitcore-node-jemcash/bin/bitcore-node-jemcash start"
echo "command to start Insight server."
