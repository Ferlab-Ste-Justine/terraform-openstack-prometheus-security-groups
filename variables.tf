variable "server_group_name" {
  description = "Name to give to the security group of prometheus servers"
  type = string
  default = ""
}

variable "client_group_ids" {
  description = "Id of client security groups"
  type = list(string)
  default = []
}

variable "bastion_group_ids" {
  description = "Id of bastion security groups"
  type = list(string)
  default = []
}

variable "metrics_server_group_ids" {
  description = "Id of metric servers security groups"
  type = list(string)
  default = []
}