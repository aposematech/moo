# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
resource "aws_dynamodb_table" "db_table" {
  name         = var.db_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item
resource "aws_dynamodb_table_item" "lorem_ipsum" {
  table_name = aws_dynamodb_table.db_table.name
  hash_key   = aws_dynamodb_table.db_table.hash_key

  item = <<ITEM
{
    "${uuid()}": {"name": "Cicero"}, {"quote": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod..."}
}
ITEM
}
