services = {
  "database.dc1" = {
    id                    = "database"
    name                  = "database"
    kind                  = ""
    address               = "127.0.0.1"
    port                  = 5432
    meta                  = {}
    tags                  = ["external"]
    namespace             = ""
    status                = "passing"
    node                  = "database"
    node_id               = ""
    node_address          = "127.0.0.1"
    node_datacenter       = "dc1"
    node_tagged_addresses = null
    node_meta = {
      external-node  = "true"
      external-probe = "true"
    }
    cts_user_defined_meta = {}
  }
}