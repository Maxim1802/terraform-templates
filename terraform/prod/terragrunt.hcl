locals {
  contour = yamldecode(file("contour.yaml"))
}

inputs = {
  environment = local.contour.environment
  contour = local.contour.datacenter_name
  dc = local.contour.datacenter_name
  
  custom_tags = {
    environment = local.contour.environment
    contour = local.contour.contour
  }
}