# Minecraft Server Automation

## Requirements
To run this project, you will need the following:
 - AWS ec2 account
 - SSH key pair that you already have created for Amazon
 - anisble installed version: ansible --version
 - terraform installed version: v1.12.1

### Environment Variables
You may need to set the following environment variables for your AWS credentials:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

## List of Commands to Run
1. **Clone the Repository**:
   ```
   git clone https://github.com/ZachMartin7/Minecraft_project
   ```

2. **Provision AWS Resources**:
   ```
   terraform init
   terraform apply
   Enter the name of the key pair you want to use
   Enter the ami version you want to use
   ```
3. **Edit inventory and run ansible script** 
   ```
   Add your public IP as indicated 
   Add the path to your key downloaded from amazon
   run: ansible-playbook -i inventory ansible.yml
   server should be runnning
   ```

## Connecting to the Minecraft Server
Run this in command line: 
```
nmap -sV -Pn -p T:25565 <instance_public_ip>
```
Replace `<instance_public_ip>` with the actual public IP address of your Minecraft server.

## Resources
- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

