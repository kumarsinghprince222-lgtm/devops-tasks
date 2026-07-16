#!/bin/bash
# Day 3: Azure VNet, NSG, Bastion, and Storage Private Endpoint

# 1. Create Resource Group
az group create --name rg-devops-day3 --location centralindia

# 2. Create VNet and Subnets
az network vnet create --resource-group rg-devops-day3 --name vnet-prod --address-prefixes 10.0.0.0/16 --subnet-name snet-app --subnet-prefixes 10.0.1.0/24
az network vnet subnet create --resource-group rg-devops-day3 --vnet-name vnet-prod --name snet-data --address-prefixes 10.0.2.0/24
az network vnet subnet create --resource-group rg-devops-day3 --vnet-name vnet-prod --name snet-mgmt --address-prefixes 10.0.3.0/24
az network vnet subnet create --resource-group rg-devops-day3 --vnet-name vnet-prod --name AzureBastionSubnet --address-prefixes 10.0.4.0/26

# 3. Create and Attach NSG for snet-app
az network nsg create --resource-group rg-devops-day3 --name nsg-snet-app
az network nsg rule create --resource-group rg-devops-day3 --nsg-name nsg-snet-app --name Allow-HTTPS --protocol tcp --priority 100 --source-address-prefixes '*' --destination-port-ranges 443 --access allow
az network nsg rule create --resource-group rg-devops-day3 --nsg-name nsg-snet-app --name Deny-All-Inbound --protocol '*' --priority 1000 --source-address-prefixes '*' --destination-port-ranges '*' --access deny
az network vnet subnet update --resource-group rg-devops-day3 --vnet-name vnet-prod --name snet-app --network-security-group nsg-snet-app

# 4. Deploy Bastion Host
az network public-ip create --resource-group rg-devops-day3 --name pip-bastion --sku Standard --allocation-method Static
az network bastion create --resource-group rg-devops-day3 --name bastion-prod --vnet-name vnet-prod --public-ip-address pip-bastion

# 5. Create Storage Account & Private Endpoint
STORAGE_NAME="stprod99823"
az storage account create --resource-group rg-devops-day3 --name $STORAGE_NAME --location centralindia --sku Standard_LRS --public-network-access Disabled
STORAGE_ID=$(az storage account show --name $STORAGE_NAME --resource-group rg-devops-day3 --query id -o tsv)
az network private-endpoint create --resource-group rg-devops-day3 --name pe-storage-prod --vnet-name vnet-prod --subnet snet-data --private-connection-resource-id $STORAGE_ID --group-id blob --connection-name conn-pe-storage
