#!/bin/bash

# Default values for the directory structure
ROOT="./src"
BIZ="biz"
CMD="cmd"
CONFIG="config"
SERVICES="services"
ADAPTER="adapters"
APPLICATION="application"
CORE="core"
PORT="ports"

# Init files
ADAPTER_DB="db.go"
ADAPTER_GRPC="grpc.go"
ADAPTER_SERVER="server.go"
CORE_API="api.go"
CORE_DOMAIN="store.go"
PORT_API="api.go"
CMD_MAIN="main.go"
CONFIG_NAME="config.go"

# Function to create directory structure
create_structure() {
    local name=$1
    local adapter_v1=$2
    local adapter_v2=$3
    local core_v1=$4
    local core_v2=$5
    
    # Check if the service name is provided
    if [[ -z "$name" ]]; then
        echo "Please provide a service name."
        exit 1
    fi

    cd ${name}
    # Create directories based on hexagonal architecture
    mkdir -p ${ROOT}/${BIZ}/${ADAPTER}/${adapter_v1}
    mkdir -p ${ROOT}/${BIZ}/${ADAPTER}/${adapter_v2}
    mkdir -p ${ROOT}/${BIZ}/${APPLICATION}/${CORE}/${core_v1}
    mkdir -p ${ROOT}/${BIZ}/${APPLICATION}/${CORE}/${core_v2}
    mkdir -p ${ROOT}/${BIZ}/${PORT}
    mkdir -p ${ROOT}/${CMD}
    mkdir -p ${ROOT}/${CONFIG}
    mkdir -p ${ROOT}/${SERVICES}

    # Create adapter files
    touch ${ROOT}/${BIZ}/${ADAPTER}/${adapter_v1}/${ADAPTER_DB}
    touch ${ROOT}/${BIZ}/${ADAPTER}/${adapter_v2}/${ADAPTER_GRPC}
    touch ${ROOT}/${BIZ}/${ADAPTER}/${adapter_v2}/${ADAPTER_SERVER}

    # Create application files
    touch ${ROOT}/${BIZ}/${APPLICATION}/${CORE}/${core_v1}/${CORE_API}
    touch ${ROOT}/${BIZ}/${APPLICATION}/${CORE}/${core_v2}/${CORE_DOMAIN}

    # Create port file
    touch ${ROOT}/${BIZ}/${PORT}/${PORT_API}

    # Create execute application files
    touch ${ROOT}/${CMD}/${CMD_MAIN}
    touch ${ROOT}/${CONFIG}/${CONFIG_NAME}
    
    echo "Folder structure created for service: $name"
}

create_structure "$1" "$2" "$3" "$4" "$5"
