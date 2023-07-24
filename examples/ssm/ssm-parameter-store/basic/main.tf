module "main_module" {
  source     = "../../../../modules/ssm/ssm-parameter-store"
  is_enabled = var.is_enabled
  aws_region = var.aws_region
  parameters_config = length(var.parameters_config) == 0 ? [
    {
      name           = "from_main"
      parameter_path = "config/service/json/something"
      parameter_type = "String"
      value = jsonencode({
        key1 = "value1"
        key2 = "value2"
      })
    }
  ] : var.parameters_config
}
