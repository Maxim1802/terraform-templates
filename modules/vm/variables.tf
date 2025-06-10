variable "namespace" {
  type        = string
  default     = ""
}

variable "tenant" {
  type        = string
  default     = ""
}

variable "environment" {
  type        = string
  default     = ""
}

variable "stage" {
  type        = string
  default     = ""
}

variable "attributes" {
  type        = list(string)
  default     = []
}

variable "name" {
  type        = string
  default     = ""
}