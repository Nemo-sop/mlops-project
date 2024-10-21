locals {
  project-id  = "mlops-project-plan-2023-11"
  project-num = 349383938394
  usernames = {
    "taki" : "taki@abc.com",
    "john" : "john@abc.com"
  }
}

## ==============================================
## Section 1: FILL IN CODE HERE TO REFERENCE RELEVANT MODULES
## ==============================================
module "service_accounts" {
  source    = "./modules/service-accounts"  
  usernames = keys(local.usernames)          
  project_id = local.project_id               
}

module "big_query" {
  source    = "./modules/big-query"          
  project_id = local.project_id               
}