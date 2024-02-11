locals {
  ### DYNAMIC VARS ###
  vpc_id = "vpc-886a07f5"
  
  subnets_frontend_hmg = ["subnet-c44aab88", "subnet-edf2f9e3"]

  subnets_frontend_prd = ["subnet-c44aab88", "subnet-edf2f9e3"]

  subnets_frontend = terraform.workspace == "hmg" ?  local.subnets_frontend_hmg : local.subnets_frontend_prd

}