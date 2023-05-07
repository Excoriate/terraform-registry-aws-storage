locals {
  aws_region_to_deploy = var.aws_region

  /*
  * Feature flags
  */
  is_enabled               = !var.is_enabled ? false : var.secrets_config == null ? false : length(var.secrets_config) > 0
  is_enforced_prefixes_set = !local.is_enabled ? false : var.enforced_prefixes == null ? false : length(var.enforced_prefixes) > 0
  #  is_rotation_set          = !local.is_enabled ? false : var.secrets_rotation_config == null ? false : length(var.secrets_rotation_config) > 0
  is_replication_set = !local.is_enabled ? false : var.secrets_replication_config == null ? false : length(var.secrets_replication_config) > 0

  /*
    * 1. Secrets configuration.
      - Configure the basic settings of the secret.
      - Other options, are managed in their own objects, and are related to their adapter through the 'name' attribute.
  */
  secrets_config_normalised = !local.is_enabled ? [] : [
    for secret in var.secrets_config : {
      name                       = trimspace(secret.name)
      path                       = trimspace(secret.path)
      description                = secret["description"] == null ? "This secret does not have a description set" : trimspace(secret["description"])
      kms_key_id                 = secret["kms_key_id"] == null ? null : trimspace(secret["kms_key_id"])
      recovery_window_in_days    = secret["recovery_window_in_days"] == null ? 0 : secret["recovery_window_in_days"]
      policy                     = secret["policy"] == null ? null : trimspace(secret["policy"])
      enable_random_secret_value = secret["enable_random_secret_value"] == null ? false : secret["enable_random_secret_value"]
      // Feature flags
      is_prefix_enforced = !local.is_enforced_prefixes_set ? false : lookup(local.prefixes_create, secret.name, null) == null ? false : true
    }
  ]

  secrets_config_create = !local.is_enabled ? {} : {
    for secret in local.secrets_config_normalised : secret["name"] => secret
  }

  /*
    * 2. Enforced prefixes
      - Opinionated configuration. Allow the secret to be created following a 'path' convention.
      - Other options, are managed in their own objects, and are related to their adapter through the 'name' attribute.
  */
  prefixes_normalised = !local.is_enforced_prefixes_set ? [] : [
    for prefix in var.enforced_prefixes : {
      name   = trimspace(prefix.name)
      prefix = lower(trimspace(prefix.prefix))
    }
  ]

  prefixes_create = !local.is_enforced_prefixes_set ? {} : {
    for prefix in local.prefixes_normalised : prefix["name"] => prefix
  }

  /*
  * 3. Secret replication
    - Replicate the secret into a new AWS region.
    - Other options, are managed in their own objects, and are related to their adapter through the 'name' attribute.
  */

  replication_normalised = !local.is_replication_set ? [] : [
    for replication in var.secrets_replication_config : {
      name       = trimspace(replication.name)
      region     = trimspace(replication.region)
      kms_key_id = replication["kms_key_id"] == null ? null : trimspace(replication["kms_key_id"])
    }
  ]

  replication_create = !local.is_replication_set ? {} : {
    for replication in local.replication_normalised : replication["region"] => replication
  }

  #  /*
  #  * 4. Secret rotation
  #    - Rotate the secret.
  #    - Other options, are managed in their own objects, and are related to their adapter through the 'name' attribute.
  #  */
  #  rotation_normalised = !local.is_rotation_set ? [] : [
  #    for rotation in var.secrets_rotation_config : {
  #      name = trimspace(rotation.name)
  #      rotation_lambda_arn = rotation["rotation_lambda_arn"] == null ? null : trimspace(rotation["rotation_lambda_arn"])
  #      automatically_after_days = rotation["automatically_after_days"] == null ? 30 : rotation["automatically_after_days"]
  #    }
  #  ]
  #
  #  rotation_create = !local.is_rotation_set ? {} : {
  #    for rotation in local.rotation_normalised : rotation["name"] => rotation
  #  }
}
