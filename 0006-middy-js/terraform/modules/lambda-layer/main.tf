data "archive_file" "artefact" {
  output_path = var.output_path
  type        = "zip"
  source_dir  = var.source_dir
}

resource "aws_lambda_layer_version" "this" {
  layer_name          = var.name
  description         = var.description
  filename            = data.archive_file.artefact.output_path
  source_code_hash    = data.archive_file.artefact.output_base64sha256
  compatible_runtimes = var.compatible_runtimes
}
