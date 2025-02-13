provider "kubernetes" {
    host = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

}

provider "aws" {
    region = var.region
}
locals {
  cluster_name = var.clusterName
}

locals {
  private_subnet_map = {
    subnet-1 = module.vpc.private_subnets[0]
    subnet-2 = module.vpc.private_subnets[1]
    subnet-3 = module.vpc.private_subnets[2]
  }
}

data "aws_subnet" "private_subnets" {
  for_each = local.private_subnet_map  # Using a map with keys subnet-1, subnet-2, subnet-3

  id = each.value  # Use the subnet ID from the map to fetch details
}

# Create DB Subnet Group for RDS
resource "aws_db_subnet_group" "crewmeister_db_subnet_group" {
  name       = "crewmeister-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "crewmeister-db-subnet-group"
  }
}



# Custom DB Parameter Group for RDS
resource "aws_db_parameter_group" "crewmeister_mysql" {
  name        = "crewmeister-mysql-parameters"
  family      = var.rds_family
  description = "Custom parameter group for Crewmeister MySQL DB"

  parameter {
    name  = "max_connections"
    value = "150"
  }

}

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name_prefix = "crewmeister-rds-sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    #cidr_blocks = [for subnet in data.aws_subnet.private_subnets : subnet.cidr_block]  # Collect CIDR blocks
    cidr_blocks = [for subnet in data.aws_subnet.private_subnets : subnet.cidr_block]
    
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "crewmeister-rds-sg"
  }
} 
# RDS Module
module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.10.0"

  identifier             = "crewmeister-db"
  db_subnet_group_name   = "crewmeister-db-subnet-group"
  subnet_ids             = module.vpc.private_subnets
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = var.rds_instance_class
  allocated_storage = var.rds_allocated_storage
  storage_type      = "gp2"

  username = var.rds_username
  password = var.rds_password

  backup_retention_period   = 7
  multi_az                  = false
  publicly_accessible       = false
  delete_automated_backups  = true
  skip_final_snapshot       = true

  storage_encrypted = true
  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]

  parameter_group_name = aws_db_parameter_group.crewmeister_mysql.name  # Attach custom parameter group
  family = var.rds_family
  major_engine_version = "8.0"  # Required for option groups

  tags = {
    Name = "crewmeister-db"
  }
} 






