terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
resource "aws_dynamodb_table" "db_table" {
  name         = var.db_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  range_key    = "sk"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid
resource "random_uuid" "uuid" {}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item
resource "aws_dynamodb_table_item" "lorem_ipsum" {
  table_name = aws_dynamodb_table.db_table.name
  hash_key   = aws_dynamodb_table.db_table.hash_key
  range_key  = aws_dynamodb_table.db_table.range_key

  item = <<ITEM
{
  "${aws_dynamodb_table.db_table.hash_key}": {"S": "${var.db_table_name}"}, "${aws_dynamodb_table.db_table.range_key}": {"S": "${random_uuid.uuid.result}"}, "value": {"M": {"name": {"S": "Cicero"}, "quote": {"S": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod..."}}}
}
ITEM
}
