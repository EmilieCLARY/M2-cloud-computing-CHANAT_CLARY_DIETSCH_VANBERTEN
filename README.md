# Projet M2 : Cloud computing

API written by Fabien HUITELEC.

## Project Description

This project is a cloud computing solution designed to demonstrate the deployment and management of various cloud resources using Terraform. It includes the setup of a virtual network, subnets, a PostgreSQL database, an HTTP API, and a storage account. The infrastructure is deployed on Azure and is configured to be scalable and secure. The project also integrates monitoring and logging using New Relic.

## Group details

We are 4 students from JUNIA ISEN :
- CHANAT Lucas,
- CLARY Emilie,
- DIETSCH Gabin,
- VANBERTEN Antoine.

## Explanation of our proposition

Our proposition involves creating a robust and scalable cloud infrastructure using Terraform to automate the deployment process. We aim to leverage Azure's cloud services to build a secure and efficient environment that includes:

1. **Virtual Network and Subnets**: Establishing a virtual network with multiple subnets to segregate and manage resources effectively.
2. **Gateway**: Implementing a gateway to manage the connection between external clients and the HTTP API, ensuring secure and efficient communication.
3. **PostgreSQL Database**: Setting up a managed PostgreSQL database for reliable and scalable data storage.
4. **HTTP API**: Deploying an HTTP API to handle client requests and interact with the database.
5. **Storage Account**: Creating a storage account for storing application data and backups.
6. **Monitoring and Logging**: Integrating New Relic for comprehensive monitoring and logging to ensure the infrastructure's health and performance.

![Architecture of our project](/images/project.png)

This solution is designed to be easily maintainable and extensible, allowing for future enhancements and scaling as needed.

## Technologies used

The following technologies were used in this project:

- **Terraform**: For infrastructure as code to automate the deployment and management of cloud resources.
- **Azure**: As the cloud service provider for hosting the infrastructure.
- **PostgreSQL**: For the managed database service.
- **HTTP API**: Built using a suitable framework to handle client requests.
- **New Relic**: For monitoring and logging to ensure the infrastructure's health and performance.
- **Azure Storage**: For storing application data and backups.
- **Azure Virtual Network**: For creating a secure and isolated network environment.

## Project structure

The repository is organized into the following directories :

    - .github : contains the CI/CD declaration with workflows
    - examples : contains the API written in Python using FastAPI framework
    - infrastructure : contains the cloud architecture declarations in Terraform
    - test : contains unit test for API endpoints

## Installation

### Requirements

- HashiCorp Terraform v1.5.7+ : https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Azure CLI v2.66+ : https://learn.microsoft.com/fr-fr/cli/azure/install-azure-cli
- An IDE of your choice

### How to run the project

1. **Clone the repository**
2. **Open it in your favorite IDE**
3. **Go in ./infrastructure folder** : you'll find terraform.tfvars.model
4. **Copy/Paste it in the folder and delete the .model extension**
5. **Fill it with** : Microsoft Azure subscription ID, New Relic Licence Key, your IP address, Github Username and E-Mail address.
6. **Run in this order** : terraform init, terraform plan and finally terraform apply to provision the cloud infrastructure (in ./infrastructure folder)

## Current Issues

1. There is an issue affecting continuous deployment (CD). To authorize the CI/CD pipeline to perform deployments, we need specific keys (CLIENT_ID and CLIENT_SECRET). However, with our current Azure for Students accounts, we are unable to obtain these keys. As a result, the deployment part of the CI/CD process is commented out in the `main.yml` file.
2. The gateway doesn't seem to work and it times out. We are currently investigating the cause of this issue, but as of now, the gateway is not functioning as expected, leading to timeouts when trying to establish a connection. In consequences, we made possible the access the /quotes and the / to access the API. The database is still under a DNS rule making it only possible to access throught vnet network. 