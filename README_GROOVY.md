# DevOps Pipeline Project

## Overview

The project implements a **Jenkins pipeline** using **Groovy** that performs the following tasks:

- **Trigger from SCM change** - The pipeline is triggered whenever there is a change in the source code management (SCM) system.  
  This is achieved using a **Git Webhook** that notifies **Jenkins** whenever new commits are pushed to the repository.  
  Jenkins then automatically starts the pipeline execution in response to the SCM change.

- **Build an artifact** - The pipeline compiles and builds the application artifact.
- **Pack the artifact and upload it to a repository** - The built artifact is packaged and uploaded to a repository for storage and later use.

The project utilizes **Groovy Shared Libraries** to modularize and reuse the pipeline logic.

## Project Structure
├── devops_shared/
│ ├── vars/
│ │ ├── prepareEnv.groovy # Shared Library function to process SCM trigger parameters
├── Jenkinsfile # Defines the pipeline logic
├── docker/
│ ├── docker-compose-jenkins.yml # Docker Compose configuration for Jenkins deployment
│ ├── ansible/
│ │ ├── playbook.yml # Ansible playbook for deployment automation
├── build.gradle # Build configuration


## Shared Library

For this exercise, the **Shared Library** is included in the same repository under:

devops_shared/vars/prepareEnv.groovy


However, the recommended best practice is to place the **Shared Library** in a dedicated repository.

## Artifact Repository

Initially, the artifact was intended to be uploaded to **JFrog Artifactory**, but due to database-related issues, it was instead stored in a separate Git repository:

**Artifact Repository:** [devops-pipeline-artifacts](https://github.com/Shulamit9292/devops-pipeline-artifacts)

## Files Included

- **`Jenkinsfile`** - Defines the CI/CD pipeline.
- **`prepareEnv`** - Shared Library function that processes SCM trigger parameters, such as identifying the code committer.
- **`docker-compose-jenkins.yml`** - Used to deploy Jenkins using Docker Compose.
- **`build.gradle`** - Build configuration for the project.

## Running the Project

### Deploy Jenkins with Docker Compose

To set up Jenkins using Docker Compose, navigate to the `docker` directory and run:

```sh
docker-compose -f docker-compose-jenkins.yml up -d
```

## Configure Jenkins

- Install required plugins in Jenkins.
- Add the pipeline job and point it to the `Jenkinsfile` in the repository.
- Ensure SCM webhooks are configured to trigger builds.

## Running the Pipeline

Once Jenkins is set up, the pipeline will automatically trigger on SCM changes.  
You can also trigger it manually from Jenkins.

## Verifying the Artifact Upload

After a successful build, the artifact should be available in the dedicated Git repository:  
**[devops-pipeline-artifacts](https://github.com/Shulamit9292/devops-pipeline-artifacts)**.

## Future Improvements

- Use a dedicated repository for the **Shared Library**.
- Resolve database-related issues to allow artifact storage in **JFrog Artifactory**.
- Automate more deployment steps using **Ansible**.

By following these instructions, you can successfully run and manage this **DevOps pipeline**. 