output "db_table_name" {
  value       = aws_dynamodb_table.db_table.name
  description = "DynamoDB Table Name"
}