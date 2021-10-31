
variable "apikey" {
  type        = string
  description = "API Key"
}
  
variable "secretkey" {
  type        = string
  description = "Secret Key or file location"
}
  
variable "organization" {
  type        = string
  description = "Organization Name"
  default     = "default"
}

variable "vc_password" {
  type        = string
  description = "Secret Key or file location"
}  

variable "ssh_user" {
  type        = string
  description = "SSH user name to be used to node login."
}
  
variable "ssh_key" {
  type        = string
  description = "SSH Public Key to be used to node login."
}
