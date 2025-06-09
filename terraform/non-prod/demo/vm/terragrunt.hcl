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
  vm = {
    "postges-01" = {
      name = "postges-01" # slgh-msk01-demo-postgres-01
    },
    "postges-02" = {
      name = "postges-02" # slgh-msk02-demo-postgres-02
      environment = "msk02"
    }
    "postges-03" = {
      name = "postges-03" # slgh-msk03-demo-postgres-02
      environment = "msk03"
    }
  }
}