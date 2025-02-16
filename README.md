# Crewmeister Challenge

## Background

At Crewmeister, our development team is continuously growing. We aim to hire the best educated, motivated, and enthusiastic people in the field who have fun building up Crewmeister in our vision to empower small businesses to thrive in a digital world. For this quest, we are continuously getting new applicants from all over the world. To filter which candidates could be a good fit, we provide our candidates with a coding challenge that we manually review and evaluate.

---

## DevOps Engineer Task

As a DevOps Engineer at Crewmeister, you will be in charge of several challenging tasks in your daily work. One of your core responsibilities will be to ensure that the system is always running smoothly and that the application is deployed successfully to our customers.

In this challenge, you should use DevOps best practices to architect and implement the complete cycle of building, packaging, and deploying a Java application (specified later in this document). 

The following are core technologies/tools that should be present in the solution:

- Dockerfile
- Helm Chart
- Terraform to interact with the Kubernetes cluster

## Plus:

- Create a CI Pipeline in Github to automate the application lifecycle

- Add monitoring tools to check the health of the application

## Important Points:

- At Crewmeister, we value creativity and pushing for better. You are encouraged to expand the solution as you find fit. To do so, you must ensure high-quality documentation and that the base solution is correctly executed.
- All the tools used must be publicly accessible or explicitly documented on how to authenticate.
- All the tools must be free to use.

## Challenge Application

A Spring Boot application that provides a simple user management REST API.

### Technologies Used

- Java 17
- Spring Boot 3.3.5
- MySQL Database
- Flyway Migration
- Maven
- Spring Data JPA
- Spring Actuator

### Pre-requisites

- JDK 17
- MySQL
- Maven

### API Endpoints

#### GET /user

Retrieves a user by ID

#### POST /user

Creates a new user

### Execution Prerequisites

- Fork this repository - https://github.com/ma914372/devops-coding-challenge/
- Add Secrets in the Github Setings for Github Actions
    - AWS_ACCESS_KEY_ID
    - AWS_SECRET_ACCESS_KEY
    - BUCKET_TF_STATE
    - DOCKER_PASSWORD
    - DOCKER_USERNAME
    - SSH_PRIVATE_KEY

- Modify the ec2-instance key-pair name in variable.tf. Here I have used my ssh key pair name (my-key).

- Create S3 bucket for terraform statefile backend and update the main.tf

- Update the docker hub repository details in /app/values.yaml (currently it is having my docker hub repo details)

### Execution steps

- Once the above settings  are done, enable the workflow/main.yml for Docker+Terraform+Kubernetes+Helm
  
### Validation steps

- Login to the kubernetes master-node.
- Call the API endpoints using curl.
Example :

curl -X GET http://master-node-private-ip:8080/user?id=1
Greetings from Crewmeister, Alice!

curl -X POST http://master-node-private-ip:8080/user \
     -H "Content-Type: application/json" \
     -d '{"name": "Madhurima"}'
Greetings from Crewmeister, Madhurima!

curl -X GET http://master-node-private-ip:8080/user?id=2
Greetings from Crewmeister, Madhurima!

* I am using K3S to setup the cluster which doesn't support AWS ELB creation automatically.

### Destroy steps
  
  This workflow needs to be triggered manually.
- For destroying the infrastructure provisioned by terraform there is a destroy.yml too.



