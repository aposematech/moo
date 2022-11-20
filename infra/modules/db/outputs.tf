output "db_table_arn" {
  value       = aws_dynamodb_table.db_table.arn
  description = "DynamoDB Table ARN"
}
