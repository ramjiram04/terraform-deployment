check "ec2_configuration" {
  assert {
    condition = alltrue([
      for item in local.ec2_config :
      can(item.name) && can(item.instance_type) && trimspace(item.name) != "" && trimspace(item.instance_type) != ""
    ]) && length(distinct([for item in local.ec2_config : item.name])) == length(local.ec2_config)
    error_message = "Each EC2 entry requires a non-empty, unique name and a non-empty instance_type."
  }
}

check "s3_configuration" {
  assert {
    condition = alltrue([
      for item in local.s3_config : can(item.bucket_name) && trimspace(item.bucket_name) != ""
    ]) && length(distinct([for item in local.s3_config : item.bucket_name])) == length(local.s3_config)
    error_message = "Each S3 entry requires a non-empty, unique bucket_name."
  }
}

check "ebs_configuration" {
  assert {
    condition = alltrue([
      for item in local.ebs_config : can(item.name) && can(item.size) && trimspace(item.name) != "" && item.size > 0
    ]) && length(distinct([for item in local.ebs_config : item.name])) == length(local.ebs_config)
    error_message = "Each EBS entry requires a non-empty, unique name and a positive size."
  }
}

check "efs_configuration" {
  assert {
    condition = alltrue([
      for item in local.efs_config : can(item.name) && trimspace(item.name) != ""
    ]) && length(distinct([for item in local.efs_config : item.name])) == length(local.efs_config)
    error_message = "Each EFS entry requires a non-empty, unique name."
  }
}
