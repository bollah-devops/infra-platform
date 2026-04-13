variable "vpc_cidr" {
  type        = string
  default     = ""
  description = "CIDR block for the vpc"
}

variable "public_subnet_cidr" {
    description = "CIDR for public subnet"
}

variable "private_subnet_cidr" {
    description = "CIDR for private subnet"

}

variable "env_name" {
    description = "Enviroment name e.g staging"
}
