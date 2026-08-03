locals {
  # Organization standards: maintained by the platform team, not deployment users.
  # Replace the example identifiers once when adopting the framework.
  organization = {
    aws_region           = "us-east-1"
    subnet_ids           = ["subnet-0bb3070f46f7fc6f1", "subnet-0e5be66c6c215435c", "subnet-00968a1399309e3b6"]
    ec2_subnet_id        = "subnet-0bb3070f46f7fc6f1"
    security_group_ids   = ["sg-05f487552e2c26f28"]
    ami_id               = "ami-0b6d9d3d33ba97d99"
    iam_instance_profile = null
    ec2_key_name         = "agenticai"
    ansible_username     = "agenticai"
    availability_zone    = "us-east-1a"
    ebs_kms_key_id       = null
    efs_kms_key_id       = null
    efs_performance_mode = "generalPurpose"
    efs_throughput_mode  = "bursting"
    efs_transition_to_ia = "AFTER_30_DAYS"
    default_tags = {
      ManagedBy   = "Terraform"
      Environment = "production"
      Owner       = "platform-team"
    }
  }

  config_path = "${path.root}/config"
  ec2_config  = jsondecode(file("${local.config_path}/ec2.json"))
  s3_config   = jsondecode(file("${local.config_path}/s3.json"))
  ebs_config  = jsondecode(file("${local.config_path}/ebs.json"))
  efs_config  = jsondecode(file("${local.config_path}/efs.json"))
}
