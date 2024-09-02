# Part 1
## Rates API with PostgreSQL

Status:
- Local setup - works 
- Terraform plan - works
- Ran out of time to deploy it to Azure to fully test it

## Local setup

This project sets up a simple API service backed by a PostgreSQL database using Docker Compose. The setup includes two services:

1. **PostgreSQL Database** (`db`)
2. **Rates API** (`api`)

## Prerequisites

Before you begin, ensure you have the following software installed on your machine:

1. **Docker**: Docker is required to run the containers. You can download and install Docker from [here](https://docs.docker.com/get-docker/).
2. **Docker Compose**: Docker Compose is a tool for defining and running multi-container Docker applications. It is included by default with Docker Desktop, but you can verify it is installed by running `docker-compose --version` in your terminal.

## Getting Started

### Build and Run the Containers

- make sure you open your terminal in the root of this repository

#### You can build and run the Docker containers using Docker Compose:

``
docker-compose up --build
``

### Accessing the Services
Once the containers are up and running:

``
curl "http://localhost:3000/rates?date_from=2021-01-01&date_to=2021-01-31&orig_code=CNGGZ&dest_code=EETLL"
``
You should see a successful response.

#### PostgreSQL: The PostgreSQL database will be accessible on port 5432. You can connect to it using your preferred database client with the following credentials:

- Database Name: cfptest
- User: cfpuser
- Password: There is no password due to POSTGRES_HOST_AUTH_METHOD=trust.

### Stopping the Containers
To stop the running containers, use

``
docker-compose down
``

## Terraform

### Prerequisites:

- Ensure that [powershell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4), [az-cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) and Docker are installed on your system.
- You should have access to an Azure account.

### Create a Service Principal:

- run the ps script in terraform/setup-sp.ps1
You can run the following in a powershell terminal (make sure your terminal is opened at the root of this repository)

``
.\terraform\setup-sp.ps1
``

### Navigate to the Terraform Directory:

Change to the terraform directory - `cd terraform`

### Initialize Terraform:

Run the command `terraform init` to initialize the Terraform configuration.

### Preview the Infrastructure Changes:

Execute `terraform plan` to see the changes that Terraform will make to your infrastructure.

### Apply the Terraform Configuration:

Run `terraform apply` to create or update the infrastructure as defined in your Terraform configuration.

### Destroy the Infrastructure:

To remove the infrastructure, use the command `terraform destroy`.

# Note:
The Terraform code has not been fully deployed or tested in Azure. However, terraform plan has been successfully passing.


## Tools and Technologies Used

**PowerShell**
I used PowerShell for scripting and automation because I was working on a Windows machine, where PowerShell is native and powerful scripting environment. PowerShell provided a convenient and familiar interface for managing Azure resources and automating repetitive tasks.

**PyCharm**
PyCharm was selected as the IDE because the project's API code is written in Python.

**Terraform**
Terraform was used for IaC to define and provision cloud infrastructure. I used the Terraform IDE plugin to validate configurations on the fly, which helps in identifying issues early and ensuring that the infrastructure is defined correctly before deployment.

**Snyk.io**
Snyk.io was utilized as a security tool to continuously scan the solution for vulnerabilities and security issues.

# Part 2

# Practical case: Deployable production environment

Diagram:
[PDF Diagram](PracticalCaseDiagram.pdf)