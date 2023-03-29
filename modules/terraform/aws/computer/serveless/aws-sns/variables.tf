variable "topic_name" {
  type        = string
  description = "The name of the topic you want to create."
  default     = ""
}

variable "display_name" {
  type        = string
  description = "The display name for the topic."
  default     = ""
}

variable "fifo_topic" {
  type        = bool
  description = "Boolean indicating whether to create a FIFO topic."
  default     = false
}

variable "min_delay_target" {
  type        = number
  description = "The minimum delay target in seconds."
  default     = 20
}

variable "max_delay_target" {
  type        = number
  description = "The maximum delay target in seconds."
  default     = 20
}

variable "num_retries" {
  type        = number
  description = "The number of retries."
  default     = 3
}

variable "num_max_delay_retries" {
  type        = number
  description = "The number of maximum delay retries."
  default     = 0
}

variable "num_no_delay_retries" {
  type        = number
  description = "The number of no delay retries."
  default     = 0
}


variable "num_min_delay_retries" {
  type        = number
  description = "The number of minimum delay retries."
  default     = 0
}

variable "backoff_function" {
  type        = string
  description = "The backoff function."
  default     = "linear"
}

variable "disable_subscription_overrides" {
  type        = bool
  description = "Boolean indicating whether to disable subscription overrides."
  default     = false
}

variable "max_receives_per_second" {
  type        = number
  description = "The maximum receives per second."
  default     = 10
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
