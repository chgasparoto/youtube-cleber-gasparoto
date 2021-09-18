module "layers" {
  for_each = local.lambda_layers

  source = "./modules/lambda-layer"

  name        = each.key
  description = each.value
  output_path = "files/${each.key}-layer.zip"
  source_dir  = "${local.layers_path}/${each.key}"
}
