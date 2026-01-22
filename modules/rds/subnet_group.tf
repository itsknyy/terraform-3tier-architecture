resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = var.private_db_subnet_ids

  tags = {
    Name = "db-subnet-group"
  }
}
