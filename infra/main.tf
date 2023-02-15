module "git" {
  source                  = "./modules/git"
  git_repo_name           = terraform.workspace
  git_repo_description    = var.git_repo_description
  git_repo_homepage_url   = "https://${var.subdomain_name}.${var.registered_domain_name}/${terraform.workspace}"
  git_repo_topics         = ["api", "cowsay", "demo", "quotes"]
  git_repo_visibility     = var.git_repo_visibility
  aws_access_key_id_name  = "AWS_ACCESS_KEY_ID"
  aws_access_key_id_value = var.aws_access_key_id
  aws_access_key_name     = "AWS_SECRET_ACCESS_KEY"
  aws_access_key_value    = var.aws_access_key
  aws_region_name         = "AWS_REGION"
  aws_region_value        = var.aws_region
}

module "ecr" {
  source        = "./modules/ecr"
  ecr_repo_name = terraform.workspace
}

module "db" {
  source        = "./modules/db"
  db_table_name = terraform.workspace
}

module "lambda" {
  source             = "./modules/lambda"
  function_name      = terraform.workspace
  db_table_arn       = module.db.db_table_arn
  aws_region         = var.aws_region
  aws_account_number = var.aws_account_number
}

module "web" {
  source                 = "./modules/web"
  registered_domain_name = var.registered_domain_name
  subdomain_name         = var.subdomain_name
}

module "api" {
  source                  = "./modules/api"
  api_gateway_name        = terraform.workspace
  lambda_function_arn     = module.lambda.lambda_function_arn
  certificate_arn         = module.web.certificate_arn
  certificate_domain_name = module.web.certificate_domain_name
  hosted_zone_id          = module.web.hosted_zone_id
  aws_region              = var.aws_region
  aws_account_number      = var.aws_account_number
}

module "ops" {
  source                  = "./modules/ops"
  certificate_domain_name = module.web.certificate_domain_name
  api_gateway_name        = module.api.api_gateway_name
  aws_region              = var.aws_region
}
