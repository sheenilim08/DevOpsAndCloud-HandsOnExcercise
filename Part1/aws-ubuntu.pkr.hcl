# If you have your default VPC available then use it. 

# packer puglin for AWS 
# https://www.packer.io/plugins/builders/amazon 
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.6"
      source = "github.com/hashicorp/amazon"
    }
  }
}

# which ami to use as the base and where to save it
# source block has 2 labels 
# amazon-ebs - is the builder type
# amazon-linux - is the name assigned to this builder
# properties that can be assigned - https://developer.hashicorp.com/packer/plugins/builders/amazon/instance#run-configuration
source "amazon-ebs" "amazon-linux" {
  region          = "ap-southeast-2"
  ami_name        = "ami-version-1.0.1-{{timestamp}}"
  instance_type   = "t2.micro"
  source_ami      = "ami-06cd706b6bacee637"
  ssh_username    = "ec2-user"
  ami_regions     = [
                      "ap-southeast-2"
                    ]
}

# what to install, configure and file to copy/execute
build {
  name = "devops-learning-packer"
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]

  provisioner "file" {
    source = "provisioner.sh"
    destination = "/tmp/provisioner.sh"
  }

  provisioner "shell" {
    inline = ["chmod a+x /tmp/provisioner.sh"]
  }
  
  # provisioner "shell" {
  #   inline = [ "ls -la /tmp"]
  # }
  
  # provisioner "shell" {
  #   inline = [ "pwd"]
  # }
  
  provisioner "shell" {
    inline = ["/tmp/provisioner.sh"]
  }
}