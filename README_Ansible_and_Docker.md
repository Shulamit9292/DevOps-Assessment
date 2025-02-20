# Ansible and Docker Deployment

This project contains an Ansible playbook that deploys a Docker Compose application with two services:

1. **Web Server** – Serves a basic “Hello World” HTML page.
2. **Stateful Service** – Tracks hit counts from the web server using a separate PostgreSQL database.

## Project Structure

### 1. `playbook.yml`
The Ansible playbook automates the deployment process by:
- Installing required packages such as Docker and Docker Compose.
- Copying the necessary Docker Compose files to the target machine.
- Running the Docker Compose command to bring up the services.

### 2. `inventory`
The inventory file defines the target hosts where Ansible will execute the deployment. It includes:
- The IP addresses or hostnames of the servers.
- Connection details (such as SSH configurations).

### 3. `docker-compose.yml`
This file defines the application's services and networking:
- **Web Service:** Built from a Dockerfile and exposes port `8083:8080`.
- **Database Service:** Uses a PostgreSQL container to store hit counts.
- **Counter Service:** Simulates requests to the web server, incrementing the hit count in the database.

## How to Use

### 1. Running Ansible Playbook
To deploy the application, navigate to the `docker/ansible` directory and execute:
```sh
ansible-playbook -i inventory playbook.yml
```
## Ensure Ansible is Installed

Ensure Ansible is installed and configured to connect to the target machine.

## Jenkins Integration

This deployment is automated as part of a Jenkins pipeline. The `ansible` directory is located inside the `docker` directory, and the pipeline executes the playbook to deploy the application.

## Verifying Deployment

After running the playbook, the web server should be accessible at:

http://<server-ip>:8083


## Application Overview

The application is implemented using **Spring Boot**, which simplifies the setup and deployment process by encapsulating all necessary configurations into a single script.

### `App.groovy`

The `App.groovy` file serves as the main entry point for the application. It is a **Spring Boot** script that:

* Starts an embedded web server.
* Serves a basic "Hello World" HTML page.
* Handles HTTP requests and tracks hits using a database connection.
* Automatically configures the application context without requiring extensive XML or properties configuration.

Spring Boot enables this functionality with minimal boilerplate code, making it easy to manage and deploy the entire service with a single script.

## Counter Service

The counter service will continuously hit the web server and store results in the database.

## Notes

* Ensure Docker and Ansible are installed on the target machine.  
* Modify the inventory file to match your deployment environment.  
* The Jenkins pipeline automatically triggers the deployment upon changes in the repository.  

## Known Issues

* The counter service functionality has not been fully tested due to connection and communication issues with the database. Further debugging and adjustments may be required to ensure proper functionality.