variable "bucket_name" {
  description = "Bucket name, must be unique"
  type        = string

  validation {
    condition     = length(var.bucket_name) > 10 && endswith(var.bucket_name, ".com")
    error_message = "The given bucket name is invalid. It must have more than 10 chars and ends with '.com'"
  }
}

variable "files" {
  description = "Configuration for website files"
  type = object({
    terraform_managed     = bool
    error_document_key    = optional(string, "error.html")
    index_document_suffix = optional(string, "index.html")
    www_path              = optional(string)
  })
}

variable "cors_rules" {
  description = "List of CORS rules"
  type = list(object({
    allowed_headers = optional(set(string)),
    allowed_methods = set(string),
    allowed_origins = set(string),
    expose_headers  = optional(set(string)),
    max_age_seconds = optional(number)
  }))
  default = []
}
