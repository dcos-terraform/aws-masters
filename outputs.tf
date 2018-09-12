output "instances" {
  description = "List of instances IDs created by this module"
  value       = ["${module.dcos-master-instances.instances}"]
}

output "public_ips" {
  description = "List of public ip addresses created by this module"
  value       = ["${module.dcos-master-instances.public_ips}"]
}

output "private_ips" {
  description = "List of private ip addresses created by this module"
  value       = ["${module.dcos-master-instances.private_ips}"]
}

output "os_user" {
  description = "Output the OS user if default AMI is used"
  value       = "${module.dcos-master-instances.os_user}"
}

output "prereq-id" {
  description = "Returns the ID of the prereq script (if user_data or ami are not used)"
  value       = "${module.dcos-master-instances.prereq-id}"
}
