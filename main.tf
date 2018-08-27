/**
 * AWS DC/OS Master Instances
 * ============
 * This module creates typical master instances used by DC/OS
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-master-instances" {
 *   source  = "terraform-dcos/masters/aws"
 *   version = "~> 0.1"
 *
 *   cluster_name = "production"
 *   subnet_ids = ["subnet-12345678"]
 *   security_group_ids = ["sg-12345678"]"
 *   aws_key_name = "my-ssh-key"
 *
 *   num_masters = "3"
 * }
 *```
 */

provider "aws" {}

module "dcos-tested-oses" {
  source  = "dcos-terraform/tested-oses/aws"
  version = "~> 0.0"

  providers = {
    aws = "aws"
  }

  os = "${var.dcos_instance_os}"
}

// Instances is spawning the VMs to be used with DC/OS (bootstrap)
module "dcos-master-instances" {
  source  = "dcos-terraform/instance/aws"
  version = "~> 0.0"

  providers = {
    aws = "aws"
  }

  cluster_name                = "${var.cluster_name}"
  hostname_format             = "${var.hostname_format}"
  num                         = "${var.num_masters}"
  ami                         = "${coalesce(var.aws_ami,module.dcos-tested-oses.aws_ami)}"
  user_data                   = "${var.user_data}"
  instance_type               = "${var.aws_instance_type}"
  subnet_ids                  = ["${var.aws_subnet_ids}"]
  security_group_ids          = ["${var.aws_security_group_ids}"]
  key_name                    = "${var.aws_key_name}"
  root_volume_size            = "${var.aws_root_volume_size}"
  root_volume_type            = "gp2"
  tags                        = "${var.tags}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
}

resource "null_resource" "masters-prereq" {
  // if the user supplies an AMI or user_data we expect the prerequisites are met.
  count = "${coalesce(var.aws_ami, var.user_data) == "" ? var.num_masters : 0}"

  connection {
    host = "${var.aws_associate_public_ip_address ? element(module.dcos-master-instances.public_ips, count.index) : element(module.dcos-master-instances.private_ips, count.index)}"
    user = "${module.dcos-tested-oses.user}"
  }

  provisioner "file" {
    content = "${module.dcos-tested-oses.os-setup}"

    destination = "/tmp/dcos-prereqs.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/dcos-prereqs.sh",
      "sudo bash -x /tmp/dcos-prereqs.sh",
    ]
  }

  depends_on = ["module.dcos-master-instances"]
}
