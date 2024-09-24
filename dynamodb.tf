resource "aws_dynamodb_table" "dynamodb_tables" {
  for_each = { for table, create in local.dynamodb_tables : table => create if create }

  name         = each.key
  billing_mode = "PAY_PER_REQUEST"

  # Define the primary key structure
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }
  # Optionally add tags to each table
  tags = {
    Name        = each.key
    Environment = "development"
  }
}
