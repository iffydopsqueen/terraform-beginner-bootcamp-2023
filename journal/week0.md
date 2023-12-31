# Terraform Beginner Bootcamp 2023

- [Semantic Versioning :mage:](#semantic-versioning--mage-)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
  * [Considerations for Linux Distribution](#considerations-for-linux-distribution)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [a. Shebang Considerations](#a-shebang-considerations)
    + [b. Execution Considerations](#b-execution-considerations)
    + [c. Linux Permissions Considerations](#c-linux-permissions-considerations)
- [Gitpod Lifecycles (`before`, `init`, `command`)](#gitpod-lifecycles---before----init----command--)
- [Working Env Vars](#working-env-vars)
  * [a. `env` command](#a--env--command)
  * [b. Setting and Unsetting Env Vars](#b-setting-and-unsetting-env-vars)
  * [c. Printing Vars](#c-printing-vars)
  * [d. Scoping of Env Vars](#d-scoping-of-env-vars)
  * [e. Persisting Env Vars in Gitpod](#e-persisting-env-vars-in-gitpod)
- [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
  * [1. Terraform Registry](#1-terraform-registry)
  * [2. Terraform Console](#2-terraform-console)
    + [a. Terraform Init](#a-terraform-init)
    + [b. Terraform Plan](#b-terraform-plan)
    + [c. Terraform Apply](#c-terraform-apply)
    + [d. Terraform Destroy](#d-terraform-destroy)
    + [3. Terraform Lock Files](#3-terraform-lock-files)
    + [a. Terraform State Files](#a-terraform-state-files)
    + [b. Terraform Directory](#b-terraform-directory)
- [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)


## Semantic Versioning :mage:

This project is going utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to `gpg` keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


### Considerations for Linux Distribution

This project is built against Ubunutu. Please consider checking your Linux Distrubtion and change accordingly to distrubtion needs. 

[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:

```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI `gpg` depreciation issues, we noticed that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allows us to manually install the Terraform CLI and easily debug 
- This will allow better portablity for other projects that need to install Terraform CLI.


#### a. Shebang Considerations

A Shebang (prounced sha-bang) tells the bash script what program that will interpret the script. eg. `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- for portability, 
- for different OS distributions, will search the user's PATH for the bash executable

[Why Use Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))


#### b. Execution Considerations

When executing the bash script we can use the `./` shorthand notiation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in ``.gitpod.yml` we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`


#### c. Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permission for the fix to be exetuable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

[Linux Permission - chmod](https://en.wikipedia.org/wiki/Chmod)


## Gitpod Lifecycles (`before`, `init`, `command`)

We need to be careful when using the `init` because it will not rerun if we restart an existing workspace.

[Gitpod Workspace Lifecycles](https://www.gitpod.io/docs/configure/workspaces/tasks)


## Working Env Vars

### a. `env` command

We can list out all enviroment variables (env vars) using the `env` command. 

We can filter specific env vars using `grep` eg. `env | grep AWS_`


### b. Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`.

In the terrminal we `unset` using `unset HELLO`.

We can set an env var temporarily when just running a command:

```sh
HELLO='world' ./bin/print_message
```
Within a bash script we can set env without writing `export` eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### c. Printing Vars

We can print an env var using `echo` eg. `echo $HELLO`.


### d. Scoping of Env Vars

When you open up new bash terminals in VSCode, it will not be aware of env vars that you have set in another window.

If you want your env vars to persist across all future bash terminals that are open you need to set env vars in your `bash profile`, eg. `.bash_profile`


### e. Persisting Env Vars in Gitpod

We can persist env vars into `gitpod` by storing them in Gitpod Secrets Storage.

```sh
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-senstive env vars.


## AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If it is successful, you should see a JSON payload return that looks like this:

```json
{
    "UserId": "AIEAVUO15ZPVHJ5WIJ5KR",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials from the IAM User we created in order to use AWS CLI.


## Terraform Basics

### 1. Terraform Registry

Terraform sources their providers and modules from the Terraform registry which located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow to create resources in terraform.
- **Modules** are a way to make large amount of terraform code modular, portable and sharable.

[Randon Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)


### 2. Terraform Console

We can see a list of all the Terrform commands by simply typing `terraform`.


#### a. Terraform Init

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project.


#### b. Terraform Plan

`terraform plan` - This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.


#### c. Terraform Apply

`terraform apply` - This will run a `plan` and pass the changeset to be executed by terraform. `apply` should prompt **yes** or **no**.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`


#### d. Terraform Destroy

`teraform destroy` - This will destroy resources.

You can also use the `auto-approve` flag to skip the approve prompt eg. `terraform destroy --auto-approve`


#### 3. Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modulues that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VSC) eg. Github


#### a. Terraform State Files

`.terraform.tfstate` contain information about the current state of your infrastructure.

This file **should not be commited** to your VCS.

This file can contain sensentive data.

If you lose this file, you lose knowning the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.


#### b. Terraform Directory

`.terraform` directory contains binaries of terraform providers.


## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch a bash view to generate a token. However it does not work as expected in `Gitpod` because it's on the browser.

The workaround is to manually generate a token in Terraform Cloud

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create and open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```

We have automated this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials). 