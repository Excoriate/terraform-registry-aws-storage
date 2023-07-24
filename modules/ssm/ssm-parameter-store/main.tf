resource "aws_ssm_parameter" "this" {
  for_each        = local.parameters_cfg_create
  name            = each.value["name"]
  type            = each.value["type"]
  allowed_pattern = each.value["allowed_pattern"]
  data_type       = each.value["data_type"]
  description     = each.value["description"]
  insecure_value  = each.value["insecure_value"]
  key_id          = each.value["key_id"]
  overwrite       = each.value["overwrite"]
  tier            = each.value["tier"]
  value           = each.value["value"]

  tags = var.tags
}
