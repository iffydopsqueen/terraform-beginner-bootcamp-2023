# Terraform Beginner Bootcamp 2023 - Week 1

## 1. Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)


## 2. Terraform and Input Variables

### a. Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your `bash` terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your `tfvars` file

We can set Terraform Cloud variables to be sensitive so they are not shown visibly in the UI.

### b. Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### c. var flag

We can use the `-var` flag to set an input variable or override a variable in the `tfvars` file eg. `terraform -var user_ud="my-user_id"`

### d. var-file flag

This file consists only of variable name assignments. It automatically loads the variable names mentioned if either of the variable files are not found. 

### e. terraform.tvfars or terraform.tvfars.json

This is the default file to load in terraform variables in blunk

### f. auto.tfvars or auto.tfvars.json

This file also consists of variable name assignments. It is automatically loaded if the other variable files are not found. 

### g. Order of Terraform Variables

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

- Environment variables

- The `terraform.tfvars` file, if present.

- The `terraform.tfvars.json` file, if present.

- Any `*.auto.tfvars` or `*.auto.tfvars.json` files, processed in lexical order of their filenames.

- Any `-var` and `-var-file` options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)


# References 

- [Terraform Variables](https://developer.hashicorp.com/terraform/language/values/variables)