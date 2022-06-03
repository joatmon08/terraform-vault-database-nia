terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.6"
    }
  }
}

provider "vault" {}

variable "services" {
  description = "Mock services variable for CTS"
  type = map(
    object({
      id        = string
      name      = string
      kind      = string
      address   = string
      port      = number
      meta      = map(string)
      tags      = list(string)
      namespace = string
      status    = string

      node                  = string
      node_id               = string
      node_address          = string
      node_datacenter       = string
      node_tagged_addresses = map(string)
      node_meta             = map(string)

      cts_user_defined_meta = map(string)
    })
  )
}

module "secrets_engine" {
  source                           = "../"
  name                             = "test"
  postgres_username                = "postgres"
  postgres_password                = "password"
  postgres_database_name           = "products"
  services                         = var.services
  vault_kubernetes_auth_path       = "kubernetes"
  bound_service_account_names      = ["product"]
  bound_service_account_namespaces = ["default"]
}