variable "project_name" {
  type        = string
  description = "The name of the project"
  default     = "localai"
}

variable "environment" {
  type        = string
  description = "The environment of the project"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "The location of the project"
  default     = "centralus"
}