variable "aws_region" {
  type        = string
  description = "The region to deploy to"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "The environment to deploy to"
  default     = "dev"
}

variable "service_name" {
  type        = string
  description = "The service name identifier"
  default     = "autoscaling-app"
}

variable "instance_config" {
  description = "Instance configuration"
  type = object({
    ami      = string
    type     = string
    key_name = optional(string, null)
  })
  default = {
    ami      = "ami-0759f51a90924c166"
    type     = "t2.micro"
    key_name = "test"
  }
}

variable "alb_healthcheck_config" {
  description = "Application Load Balancer configuration for healthchecks"
  nullable    = true
  default     = {}

  type = object({
    enabled             = optional(bool, true)
    healthy_threshold   = optional(number, 5)
    interval            = optional(number, 30)
    matcher             = optional(string, "200")
    path                = optional(string, "/")
    port                = optional(string, "80")
    protocol            = optional(string, "HTTP")
    timeout             = optional(number, 5)
    unhealthy_threshold = optional(number, 5)
  })
}