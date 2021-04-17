terraform {
  required_version = "~> 0.15"
}

resource "random_pet" "bucket" {}

output "pet" {
  value = random_pet.bucket.id
}

locals {
  now  = timestamp()

  brasilia_tz = timeadd(local.now, "-3h")
  amsterdam_tz = timeadd(local.now, "2h")

  date_br = formatdate("DD/MM/YYYY", local.brasilia_tz)
  date_nl = formatdate("D-MM-YYYY", local.amsterdam_tz)

  date_utc = formatdate("YYYY-MM-DD", local.now)
}

output "locals" {
  value = [
    local.now,

    local.brasilia_tz,
    local.amsterdam_tz,

    local.date_br,
    local.date_nl,
    local.date_utc
  ]
}

output "bucket_name" {
  value = "${random_pet.bucket.id}-${local.date_utc}"
}
