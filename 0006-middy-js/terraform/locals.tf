locals {
  namespaced_service_name = "${var.service_name}-${var.env}"

  lambdas_path = "${path.module}/../lambdas"
  layers_path  = "${local.lambdas_path}/layers"

  lambda_layers = {
    utils       = "Utils for response and event normalization",
    middy       = "Middy core 2.5.1",
    middlewares = "Custom middy middlewares"
  }

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
