variable "region" {
    description = "Pass the required region"
    type = string
    default = "us-east-1"
}


variable "clusterName" {
    description = "Name of the cluster"
    type = string
    default = "crewmeister-eks"
}

variable "rds_username" {
  description = "The master username for the RDS instance"
  type        = string
  default     = "admin"  # You can default it to a username for local testing, or use secrets for production
}

variable "rds_password" {
  description = "The master password for the RDS instance"
  type        = string
  sensitive   = true   # Marking this as sensitive prevents accidental logging
  default     = "Company123" # You can set this to a secret in production
}

variable "rds_db_name" {
  description = "The name of the database to create in RDS"
  type        = string
  default     = "crewmeisterdb"
}

variable "rds_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
  default     = "db.t3.small"
}

variable "rds_allocated_storage" {
  description = "The amount of allocated storage (in GB) for the RDS instance"
  type        = number
  default     = 20
}

# Adding the `family` variable for the DB parameter group family (MySQL)
variable "rds_family" {
  description = "The DB engine family for the RDS instance"
  type        = string
  default     = "mysql8.0" # The family corresponding to MySQL 8.0
}

variable "my-key" {
  description = "Name of the SSH key pair"
  default = "my-key"
}