#!/bin/bash

# ==============================================================================
# Day 2: Automated Azure Resource Group Creation & Tagging
# ==============================================================================

# Variables
LOCATION="centralindia"
PROJECT="PythonConnectors"
OWNER="Prince"

# Array of target environments
ENVIRONMENTS=("dev" "staging" "prod")

echo "Starting Resource Group Creation..."
echo "==================================="

# Loop through each environment to create RG with tags
for ENV in "${ENVIRONMENTS[@]}"; do
    RG_NAME="rg-connectors-${ENV}"
    
    echo "Creating: ${RG_NAME} in ${LOCATION}..."
    
    az group create \
      --name "$RG_NAME" \
      --location "$LOCATION" \
      --tags Environment="$ENV" Project="$PROJECT" Owner="$OWNER" \
      --output table

    echo "-----------------------------------"
done

echo "All Resource Groups created successfully!"
