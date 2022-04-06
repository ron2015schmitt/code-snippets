#!/bin/bash

prompt=$1
read -r -p "${prompt}" response
response=${response,,}
[[ ! ${response} =~ ^(y|Y|yes|YES)$ ]] && ( echo "Exiting with no action taken" ; exit 1)

echo "Yes"
