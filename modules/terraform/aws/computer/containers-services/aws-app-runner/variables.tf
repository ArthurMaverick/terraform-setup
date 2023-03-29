variable "app_runner_name" {
  type        = string
  description = "The name of the App Runner service."
  validation {
    condition     = length(var.app_runner_name) <= 64
    error_message = "The maximum length of the service name is 64 characters."
  }
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the App Runner service."
  default = {
    "Poweredby" = "terraform"
  }
  validation {
    condition     = length(keys(var.tags)) <= 10
    error_message = "The maximum number of tags that can be applied to a resource is 10."
  }
}

variable "is_publicly_accessible" {
  type        = bool
  description = "Whether the App Runner service is publicly accessible."
  default     = true
}

#===============================================================================
# HEALTH CHECK CONFIGURATION
#===============================================================================

variable "health_threshold" {
  type        = number
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy."
  default     = 2
}

variable "interval" {
  type        = number
  description = "The time interval between health checks."
  default     = 5
}

variable "path" {
  type        = string
  description = "The path to the health check."
  default     = "/"
}

variable "protocol" {
  type        = string
  description = "The protocol to use for the health check."
  default     = "HTTP"
}

variable "timeout" {
  type        = number
  description = "The amount of time to wait for a response from the health check."
  default     = 2
}

variable "unhealthy_threshold" {
  type        = number
  description = "The number of consecutive health check failures required before considering the target unhealthy."
  default     = 2
}

#===============================================================================
# AUTOSCALING CONFIGURATION
#===============================================================================

variable "max_concurrency" {
  type        = number
  description = "The maximum number of concurrent deployments."
  default     = 2
  validation {
    condition     = can(regex("^[0-9]+$", var.max_concurrency))
    error_message = "The maximum number of concurrent deployments must be a number."
  }
}

variable "max_size" {
  type        = number
  description = "The maximum number of instances that can be scaled up to."
  default     = 2
  validation {
    condition     = can(regex("^[0-9]+$", var.max_size))
    error_message = "The maximum number of instances that can be scaled up to must be a number."
  }
}

variable "min_size" {
  type        = number
  description = "The minimum number of instances that can be scaled down to."
  default     = 1
  validation {
    condition     = can(regex("^[1-9]+$", var.min_size))
    error_message = "The minimum number of instances that can be scaled down to must be a number."
  }
}

#===============================================================================
# DEPLOYMENT CONFIGURATION
#===============================================================================

variable "auto_deployments_enabled" {
  type        = bool
  description = "Whether to enable automatic deployments for the App Runner service."
  default     = true
}


#===============================================================================
# SOURCE CONFIGURATION
#===============================================================================

#==== CODE REPOSITORY CONFIGURATION
variable "code_repository" {
  type        = map(string)
  description = "The code repository configuration for the App Runner service."
  default     = {}

}

variable "connection_name" {
  type        = string
  description = "The ARN of the App Runner connection to use for the App Runner service."
  default     = ""
  validation {
    condition     = can(regex("arn:aws:apprunner:.*:.*:connection/.*", var.connection_name))
    error_message = "The ARN of the App Runner connection must be in the format arn:aws:apprunner:REGION:ACCOUNT_ID:connection/CONNECTION_NAME."
  }
}

variable "provider_type" {
  type        = string
  description = "The source provider type for the App Runner service."
  default     = "GITHUB"
  validation {
    condition     = can(regex("GITHUB", var.provider_type))
    error_message = "The source provider type must be one of GITHUB."
  }
}

#==== IMAGE REPOSITORY CONFIGURATION
variable "image_repository" {
  type        = map(string)
  description = "The image repository configuration for the App Runner service."
  default     = {}
}

#===============================================================================
# OBSERVABILITY
#===============================================================================
variable "observability_enabled" {
  type        = bool
  description = "Whether to enable observability for the App Runner service."
  default     = true
}

#===============================================================================
# NETWORK CONFIGURATION
#===============================================================================

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to use for the App Runner service."
  validation {
    condition     = can(regex("vpc-.*", var.vpc_id))
    error_message = "The ID of the VPC must be in the format vpc-xxxxxxxxxxxxxxxxx."
  }
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "The IDs of the subnets to use for the App Runner service."
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "The IDs of the security groups to use for the App Runner service."
  validation {
    condition     = can(regex("sg-.*", var.vpc_security_group_ids))
    error_message = "The IDs of the security groups must be in the format sg-xxxxxxxxxxxxxxxxx."
  }
}
