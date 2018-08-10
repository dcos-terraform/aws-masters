variable "cluster_name" {
  description = "Cluster name all resources get named and tagged with"
}

variable "tags" {
  description = "Custom tags added to the resources created by this module"
  type        = "map"
  default     = {}
}

variable "aws_ami" {
  description = "AMI to be used"
  default     = ""
}

variable "aws_instance_type" {
  description = "Instance type"
  default     = "m4.xlarge"
}

variable "aws_root_volume_size" {
  description = "Root volume size"
  default     = "120"
}

variable "aws_subnet_ids" {
  description = "Subnets to spawn the instances in. The module tries to distribute the instances"
  type        = "list"
}

variable "aws_security_group_ids" {
  description = "Firewall IDs to use for these instances"
  type        = "list"
}

variable "aws_iam_instance_profile" {
  description = "Instance profile to be used for these instances"
  default     = ""
}

variable "aws_associate_public_ip_address" {
  description = "Associate a public ip address with there instances"
  default     = true
}

variable "user_data" {
  description = "User data to be used on these instances (cloud-init)"
  default     = ""
}

// TODO: Maybe use a list instead and provision keys through cloudinit
variable "aws_key_name" {
  description = "EC2 SSH key to use for these instances"
}

variable "hostname_format" {
  description = "Format the hostname inputs are index+1, region, cluster_name"
  default     = "%[3]s-master%[1]d-%[2]s"
}

variable "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = "centos_7.4"
}

variable "num_masters" {
  description = "Number of masters to spawn. This number should be odd. Typical options are (1,3,5,7,9)."
  default     = "3"
}
