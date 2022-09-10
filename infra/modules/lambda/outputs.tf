output "lambda_function_name" {
  value       = aws_lambda_function.lambda_function.function_name
  description = "AWS Lambda Function Name"
}

output "lambda_function_arn" {
  value       = aws_lambda_function.lambda_function.arn
  description = "AWS Lambda Function ARN"
}
