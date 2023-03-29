variable "function_name" {
  type        = string
  description = "The name of the function."
  default     = ""
}

variable "description" {
  type        = string
  description = "A description of the function."
  default     = "lambda function - edited by terraform"
}

variable "handler" {
  type        = string
  description = "The function entrypoint in your code."
  default     = "index.handler"
}

variable "runtime" {
  type        = string
  description = "The runtime environment for the Lambda function."
  default     = "nodejs16.x"
}

variable "timeout" {
  type        = number
  description = "The function execution time at which Lambda should terminate the function."
  default     = 3
}

variable "memory_size" {
  type        = number
  description = "The amount of memory in MB your Lambda function is given."
  default     = 128
}

variable "source_file_path" {
  type        = string
  description = "The path to the function's deployment package within the local filesystem."
  default     = "./lambda/"
}

variable "dependencies_path" {
  type        = string
  description = "The path to the function's dependencies within the local filesystem."
  default     = "./lambda/node_modules/"
}

variable "iam_role_arn" {
  type        = string
  description = "The ARN of the IAM role that Lambda assumes when it executes your function to access any other Amazon Web Services (AWS) resources."
  default     = ""
}

variable "layers" {
  type        = list(string)
  description = "A list of function layers to add to the function's execution environment."
  default     = []
}

variable "environment" {
  type        = map(string)
  description = "A map that defines environment variables for the Lambda function."
  default     = {}
}

variable "tracing_config" {
  type        = map(string)
  description = "A map that configures options for function tracing."
  default     = {}
}

variable "dead_letter_config" {
  type        = map(string)
  description = "A map that configures options for function dead letter queue."
  default     = {}
}

variable "image_config" {
  type        = map(string)
  description = "A map that configures options for function image."
  default     = {}
}

variable "ephemeral_storage" {
  type        = map(string)
  description = "A map that configures options for function ephemeral storage."
  default     = {}
}

variable "architectures" {
  type        = list(string)
  description = "A list of architectures that your function supports."
  default     = ["x86_64"]
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the function."
  default     = {}
}

variable "vpc_config" {
  type        = map(string)
  description = "A map that configures options for function VPC."
  default     = {}
}

variable "file_system_config" {
  type        = map(string)
  description = "A map that configures options for function file system."
  default     = {}
}

variable "dead_letter_config" {
  type        = map(string)
  description = "A map that configures options for function dead letter queue."
  default     = {}
}

/* layer version */

variable "enable_layer_dependency" {
  type        = bool
  description = "Whether to enable the layer dependency."
  default     = false
}

variable "layer_name" {
  type        = string
  description = "The name of the layer."
  default     = "lambda-layer"
}

/* invoke config */

variable "maximum_event_age_in_seconds" {
  type        = number
  description = "The maximum age of a request that Lambda sends to a function for processing."
  default     = 60
}

variable "maximum_retry_attempts" {
  type        = number
  description = "The maximum number of times to retry when the function returns an error."
  default     = 2
}

variable "on_failure_destination" {
  type        = string
  description = "The Amazon Resource Name (ARN) of an Amazon SQS queue or Amazon SNS topic."
  default     = {}
}

variable "on_success_destination" {
  type        = string
  description = "The Amazon Resource Name (ARN) of an Amazon SQS queue or Amazon SNS topic."
  default     = {}
}

/* lambda permissions */

variable "lambda_permissions" {
  type        = map(string)
  description = "A list of maps that define the permissions for the Lambda function."
  default     = {}
}
