prevent_destroy = false

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  aws_account_id            = include.root.locals.env_vars.aws_account_id
  aws_region                = include.root.locals.env_vars.aws_region
  env                       = include.root.locals.env_vars.env
  prefix_env                = include.root.locals.env_vars.prefix_env
  domain_name               = include.root.locals.env_vars.acm.domain_name
  validation_method         = include.root.locals.env_vars.acm.validation_method
  subject_alternative_names = include.root.locals.env_vars.acm.subject_alternative_names
  tags                      = include.root.locals.env_vars.tags
}

