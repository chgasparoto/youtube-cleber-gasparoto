variable "name" {
  type        = string
  description = "Layer name"
}

variable "description" {
  type        = string
  description = "Layer description. If it is using a npm package it is a good practice to put the version of it"
  default     = ""
}

variable "output_path" {
  type        = string
  description = "The path where the zipped layer will be saved in the local machine"
}

variable "source_dir" {
  type        = string
  description = "The source directory where the layer files are"
}

variable "compatible_runtimes" {
  type        = list(string)
  description = "The list of compatible runtimes"
  default     = ["nodejs14.x"]
}
