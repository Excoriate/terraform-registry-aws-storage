aws_region = "us-east-1"
is_enabled = true

parameters_config = [
  {
    name           = "param1"
    parameter_path = "mypath/param1"
    parameter_type = "String"
    value          = "value1"
  },
  {
    name           = "param2"
    parameter_path = "mypath/param2"
    parameter_type = "String"
    value          = "value2"
  },
  {
    name           = "param3"
    parameter_path = "mypath/param3"
    parameter_type = "String"
    value          = json
    description    = "my description"
    overwrite      = true
  },
]
