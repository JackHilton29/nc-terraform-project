variable "table_name" {
  type = string
  description = "Name of table"
}

variable "hash_key" {
  type = string
  description = "Hash key for dynamo table"
}

variable "hash_key_type" {
  type = string
  description = "Type of hash key for dynamo table"
}

variable "billing_mode" {
  type = string
  description = "billing mode for our dynamo table"
}