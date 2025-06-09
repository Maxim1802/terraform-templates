terraform {
  source = "${get_terragrunt_dir()}/../../../../modules//vm"
}

include "namespace" {
  path = "${get_terragrunt_dir()}/../../../terragrunt.hcl"
  merge_strategy = "deep"
}

include "contour" { 
  path = "${get_terragrunt_dir()}/../../terragrunt.hcl"
  merge_strategy = "deep"
}

include "stage" { 
  path = "${get_terragrunt_dir()}/../terragrunt.hcl"
  merge_strategy = "deep"
}

inputs = {
  name = "vpc" #slgh-msk01-lt-vpc-01
}