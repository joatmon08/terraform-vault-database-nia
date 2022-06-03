# terraform-vault-database-nia

Consul-Terraform-Sync compatible module for synchronizing Consul service to the
[PostgreSQL database secrets engine](https://www.vaultproject.io/docs/secrets/databases/postgresql)
for Vault.

> Note: This scopes the creation of a single database service to unique secrets engine path.
> Mapping the database service to its own secrets engine path ensures that you can scope
> Vault roles and authentication to the specific credential you need.

This module configures:

- Database secrets engine backend
- Database secrets engine connection
- Database secrets engine role
- (Optional) Kubernetes authentication method role

You can separately configure a different authentication method.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 3.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | 3.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_database_secret_backend_connection.postgres](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/database_secret_backend_connection) | resource |
| [vault_database_secret_backend_role.postgres](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/database_secret_backend_role) | resource |
| [vault_kubernetes_auth_backend_role.postgres](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kubernetes_auth_backend_role) | resource |
| [vault_mount.postgres](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.postgres](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy_document.postgres](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_connection_string_arguments"></a> [additional\_connection\_string\_arguments](#input\_additional\_connection\_string\_arguments) | Additional connection string arguments for database connection in Vault | `string` | `"sslmode=disable"` | no |
| <a name="input_allowed_roles"></a> [allowed\_roles](#input\_allowed\_roles) | List of allowed roles for database connection in Vault | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_bound_service_account_names"></a> [bound\_service\_account\_names](#input\_bound\_service\_account\_names) | If set, set up Kubernetes auth method with specific service accounts. | `list(string)` | `[]` | no |
| <a name="input_bound_service_account_namespaces"></a> [bound\_service\_account\_namespaces](#input\_bound\_service\_account\_namespaces) | If set, set up Kubernetes auth method with specific namespaces. | `list(string)` | `[]` | no |
| <a name="input_creation_statements"></a> [creation\_statements](#input\_creation\_statements) | List of creation statements to create user in PostgreSQL | `list(string)` | <pre>[<br>  "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";"<br>]</pre> | no |
| <a name="input_database_path"></a> [database\_path](#input\_database\_path) | Path to database secrets engine in Vault | `string` | `"database"` | no |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | Default TTL for database credentials | `number` | `3600` | no |
| <a name="input_max_ttl"></a> [max\_ttl](#input\_max\_ttl) | Max TTL for database credentials | `number` | `3600` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of database connection and role to configure in Vault | `string` | n/a | yes |
| <a name="input_postgres_database_name"></a> [postgres\_database\_name](#input\_postgres\_database\_name) | Database to access for PostgreSQL | `string` | n/a | yes |
| <a name="input_postgres_password"></a> [postgres\_password](#input\_postgres\_password) | Administrative password for PostgreSQL | `string` | n/a | yes |
| <a name="input_postgres_username"></a> [postgres\_username](#input\_postgres\_username) | Administrative username for PostgreSQL | `string` | n/a | yes |
| <a name="input_revocation_statements"></a> [revocation\_statements](#input\_revocation\_statements) | List of revocation statements to create user in PostgreSQL | `list(string)` | <pre>[<br>  "ALTER ROLE \"{{name}}\" NOLOGIN;"<br>]</pre> | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of role to configure in Vault if not the same as database connection. | `string` | `""` | no |
| <a name="input_services"></a> [services](#input\_services) | Consul services monitored by Consul-Terraform-Sync | <pre>map(<br>    object({<br>      id        = string<br>      name      = string<br>      kind      = string<br>      address   = string<br>      port      = number<br>      meta      = map(string)<br>      tags      = list(string)<br>      namespace = string<br>      status    = string<br><br>      node                  = string<br>      node_id               = string<br>      node_address          = string<br>      node_datacenter       = string<br>      node_tagged_addresses = map(string)<br>      node_meta             = map(string)<br><br>      cts_user_defined_meta = map(string)<br>    })<br>  )</pre> | n/a | yes |
| <a name="input_vault_kubernetes_auth_path"></a> [vault\_kubernetes\_auth\_path](#input\_vault\_kubernetes\_auth\_path) | If set, set up Kubernetes auth method. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vault_mount_path"></a> [vault\_mount\_path](#output\_vault\_mount\_path) | n/a |
| <a name="output_vault_policy"></a> [vault\_policy](#output\_vault\_policy) | n/a |
| <a name="output_vault_role"></a> [vault\_role](#output\_vault\_role) | n/a |
