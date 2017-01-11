#!/bin/bash

## Configuration
RBCF_VERSION="0.8-SNAPSHOT"

## Prepare the base image for Roboconf agents
CURR=$(pwd)
if [[ "$(docker images -q roboconf/roboconf-agent:latest 2> /dev/null)" == "" ]]; then
	
	echo "Creating the base image for Roboconf agent... 1/2"
	DIR="/tmp/roboconf-demo"
	if [[ ! -d ${DIR} ]]; then
		mkdir -p ${DIR}
		git clone https://github.com/roboconf/roboconf-dockerfile.git ${DIR}
	fi

	echo "Base version = ${RBCF_VERSION}"
	cd ${DIR}/meta-scripts
	./build.sh "agent" ${RBCF_VERSION}
	echo "Done"
	echo ""

fi

## Now, create a new image from this one to install Decanter and co.
cd ${CURR}
echo ""
echo "Back into ${CURR}"
if [[ "$(docker images -q roboconf/roboconf-agent-docker:occiware 2> /dev/null)" == "" ]]; then
	
	echo "Creating the final base image for Roboconf agent... 2/2"
	docker build -t roboconf/roboconf-agent-docker:occiware .
	echo "Done"
	echo ""

fi

## FIXME: automate the creation of ELK?

echo "That should be fine now..."

