# Azure Real-World Task - Day 1: Linux Fundamentals & VM Setup

## 1. VM Provisioning
az vm create --resource-group rg-devops-10days-in --location centralindia --name vm-devops-agent --image Ubuntu2204 --size Standard_D2s_v3 --admin-username azureuser --ssh-key-values ~/.ssh/id_rsa.pub

## 2. User & Sudo Management
sudo adduser devops-agent
sudo usermod -aG sudo devops-agent

## 3. Python 3.11 & Pip Installation
sudo apt update && sudo apt install -y software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt install -y python3.11 python3.11-venv python3-pip

## 4. Directory Ownership Setup
sudo mkdir -p /opt/connectors
sudo chown -R devops-agent:devops-agent /opt/connectors
