locals {
  stage = yamldecode(file("stage.yaml"))
}

inputs = {
  stage = local.stage.stage
  
  custom_tags = {
    stage = local.stage.stage
  }
}