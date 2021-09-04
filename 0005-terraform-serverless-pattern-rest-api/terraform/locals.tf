locals {
  lambdas_path = "${path.module}/../lambdas"
  layers_path  = "${local.lambdas_path}/layers"
  lambdas = {
    get = {
      description = "Get todos"
      memory      = 256
      timeout     = 10
    }
    delete = {
      description = "Delete given todo"
      memory      = 128
      timeout     = 5
    }
    put = {
      description = "Update given todo"
      memory      = 128
      timeout     = 5
    }
    post = {
      description = "Create new todo"
      memory      = 128
      timeout     = 5
    }
  }
}
