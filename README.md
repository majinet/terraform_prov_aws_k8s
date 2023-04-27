# About

This repository is used to demonstrate provisioning AWS Cloud and Softwares using Terraform and GitHub Actions


## Why use Infrastructure as Code tools to provisioning Cloud Infrastructure

There are several reasons use Infrastructure as Code (IaC) tools to provision Cloud infrastructure:

1. Consistency and reproducibility: IaC tools enable users to define and manage infrastructure resources in a declarative way, ensuring that the infrastructure is provisioned and configured consistently and reproducibly. This reduces the risk of errors and inconsistencies caused by manual provisioning and configuration.

2. Speed and agility: IaC tools automate infrastructure management tasks, enabling users to deploy and update infrastructure resources quickly and easily. This increases the speed and agility of infrastructure operations, allowing organizations to respond to changing business requirements and market conditions more effectively.

3. Collaboration and versioning: IaC tools store infrastructure configurations as code, enabling version control, code review, and collaboration among team members. This facilitates teamwork and knowledge sharing, improving the quality and reliability of infrastructure operations.

4. Scalability and cost-efficiency: IaC tools enable users to manage infrastructure at scale, allowing them to provision and manage large, complex infrastructures with ease. This improves the scalability and cost-efficiency of infrastructure operations, reducing the time and effort required for manual infrastructure management.

### Terraform

Terraform is an open-source infrastructure as code (IaC) tool that allows users to define and manage cloud infrastructure resources, such as virtual machines, containers, networks, storage, and security policies, in a declarative way.

With Terraform, users can write configuration files in a high-level language called HashiCorp Configuration Language (HCL), which is used to define the desired state of their infrastructure. Terraform then compares this desired state with the current state of the infrastructure and automatically provisions or updates resources to match the desired state.

Terraform supports various cloud providers, including AWS, Google Cloud, Microsoft Azure, and many others, as well as on-premises data centers and infrastructure. It also provides a rich ecosystem of plugins and modules that can be used to extend its functionality and integrate with other tools and services.

## GitHub Actions

We use GitHub Actions to install and setup Kubernetes and Kubernetes software;

- [Microk8s](microk8s) 
- PostgreSQL
- Redis
- Feast
- Kafka