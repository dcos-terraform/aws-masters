AWS DC/OS Master Instances
============
This module creates typical master instances used by DC/OS

EXAMPLE
-------

```hcl
module "dcos-master-instances" {
  source  = "dcos-terraform/masters/aws"
  version = "~> 0.2.0"

  cluster_name = "production"
  subnet_ids = ["subnet-12345678"]
  security_group_ids = ["sg-12345678"]"
  aws_key_name = "my-ssh-key"

  num_masters = "3"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_key\_name | Specify the aws ssh key to use. We assume its already loaded in your SSH agent. Set ssh_public_key_file to empty string | string | n/a | yes |
| aws\_security\_group\_ids | Firewall IDs to use for these instances | list | n/a | yes |
| aws\_subnet\_ids | Subnets to spawn the instances in. The module tries to distribute the instances | list | n/a | yes |
| cluster\_name | Name of the DC/OS cluster | string | n/a | yes |
| aws\_ami | AMI that will be used for the instances instead of the Mesosphere chosen default images. Custom AMIs must fulfill the Mesosphere DC/OS system-requirements: See https://docs.mesosphere.com/1.12/installing/production/system-requirements/ | string | `""` | no |
| aws\_associate\_public\_ip\_address | Associate a public IP address with the instances | string | `"true"` | no |
| aws\_iam\_instance\_profile | Instance profile to be used for these instances | string | `""` | no |
| aws\_instance\_type | Instance type | string | `"m4.xlarge"` | no |
| aws\_root\_volume\_size | Root volume size in GB | string | `"120"` | no |
| dcos\_instance\_os | Operating system to use. Instead of using your own AMI you could use a provided OS. | string | `"centos_7.4"` | no |
| hostname\_format | Format the hostname inputs are index+1, region, cluster_name | string | `"%[3]s-master%[1]d-%[2]s"` | no |
| name\_prefix | Name Prefix | string | `""` | no |
| num\_masters | Specify the amount of masters. For redundancy you should have at least 3 | string | `"3"` | no |
| tags | Add custom tags to all resources | map | `<map>` | no |
| user\_data | User data to be used on these instances (cloud-init) | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| instances | List of instance IDs |
| os\_user | The OS user to be used |
| prereq-id | Returns the ID of the prereq script (if user_data or ami are not used) |
| private\_ips | List of private ip addresses created by this module |
| public\_ips | List of public ip addresses created by this module |

