# EC2_show_instances
A simple Bash script for displaying EC2 instances based on region, and or tags. 
The output is displayed in a table showing the instance name, running state, private and public ip, and region.

## Getting started

First, clone the repository using git (recommended):

```bash
git clone https://github.com/ddipernala5/EC2_show_instances.git
```

or download the script manually using this command:

```bash
curl "https://raw.githubusercontent.com/EC2_show_instances/show_instances.sh" -o show_instances.sh
```

Then give the execution permission to the script and run it:

```bash
 $chmod +x show_instances.sh
 $./show_instances.sh
```

## Credentials

 In order to make API calls to AWS you will need the appropriate authenication credentials.
 
 1. If running the script from an instance in AWS it is recommended to assign an IAM role to that instance at launch.
 2. Or pass the credentials into the ~/.aws/credentials file

### Creating an IAM Role

- Creating an IAM role using the console is simple to start with
  https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html

### Setting up local credentials

- Located in the user's home directory. Create the file `~/.aws/credentials`
```
[default]
aws_access_key_id = ACCESS_KEY_ID
aws_secret_access_key = ACCESS_KEY
```

- Further information is located here  
  https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-config-files

## Setup
 The script is setup to accept a region and two tag values then plugs them into the aws api call.
 This can be customized to your specific needs by customizing the filters section of the aws api call. 
 - For Example: to limit your search to instances with a tag called "Environment" that has the value of the user's second input
 
 ENVIR=$2
 
 --filters "Name=tag:Environment,Values=$ENVIR"
 
  
  
  
 
