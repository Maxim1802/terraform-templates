# формируем базовый преффикс для именования ресурсов
module "label" {
  source = "../terraform-null-label"

  namespace   = try(var.namespace, null)
  tenant      = try(var.tenant, null)
  environment = try(var.environment, null)
  stage       = try(var.stage, null)
  attributes  = try(var.attributes, null)
}

# формируем имя для нашего ресурса вм
module "label_vm" {
  source = "../terraform-null-label"

  context = module.label.context
  name    = var.name
}

# данный ресурс используется как пример и не содержит множество необходимых полей
resource "cloud_vm" "this" {
  name        = module.label_vm.id # имя будет сформировано автоматически с использованием нужного шаблона
  description = "Example vm"
}