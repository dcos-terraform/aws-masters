variable "cluster_name" {
  description = "Specify the cluster name all resources get named and tagged with"
}

variable "tags" {
  description = "Add special tags to the resources created by this module"
  type        = "map"
  default     = {}
}

variable "aws_ami" {
  description = "Specify the AMI to be used."
  default     = ""
}

variable "aws_instance_type" {
  description = "Specify the instance type"
  default     = "m4.xlarge"
}

variable "aws_root_volume_size" {
  description = "Specify the root volume size"
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
  description = "The instance profile to be used for these instances"
  default     = ""
}

variable "aws_associate_public_ip_address" {
  description = "The instance profile to be used for these instances"
  default     = true
}

variable "aws_user_data" {
  description = "The user data to be used on these instances. E.g. cloud init"
  default     = ""
}

// TODO: Maybe use a list instead and provision keys through cloudinit
variable "aws_key_name" {
  description = "The SSH key to use for these instances."
}

variable "hostname_format" {
  description = "Format the hostname inputs are index+1, region, cluster_name"
  default     = "%[3]s-master%[1]d-%[2]s"
}

variable "dcos_instance_os" {
  description = "The operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = "centos_7.4"
}

variable "num_masters" {
  description = "The Number of masters to spawn. This number should be odd. Typical options are (1,3,5,7,9)"
  default     = "3"
}
