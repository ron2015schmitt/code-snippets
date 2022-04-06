#!/bin/bash

prompt=$1
#echo ${prompt}
read -r -p "${prompt}" response
#echo ${response}
response=${response,,}
echo ${response}
if [[ ! ${response} =~ ^(y|Y|yes|YES)$ ]]
then
    echo "Exiting with no action taken"
    exit 1
else
    echo "Yes"
fi
