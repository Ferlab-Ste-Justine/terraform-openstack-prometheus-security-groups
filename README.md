# About

This is a terraform module that provisions security groups meant to be restrict network access to a set of prometheus servers.

The following security group is created:
- **server**: Security group for the prometheus servers. It can make external requests and communicate with other members of the **server** group on ports **9090** and **9100** as well as **imcp**, essentially allowing prometheus servers to scrape each others' metrics.

Additionally, you can pass a list of groups that will fulfill each of the following roles:
- **bastion**: Security groups that will have access to the prometheus servers on port **22** as well as **icmp** traffic.
- **client**: Security groups that will have access to the prometheus servers on ports **9090** as well as icmp traffic.
- **metrics_server**: Security groups that will have access to the prometheus servers on ports **9090** and **9100** as well as icmp traffic to scrape metrics (useful if you have prometheus servers belonging to another group that need to scrape some metrics).

# Usage

## Variables

The module takes the following variables as input:

- **server_group_name**: Name to give to the security group for the prometheus servers
- **client_group_ids**: List of ids of security groups that should have **client** access to the prometheus servers
- **bastion_group_ids**: List of ids of security groups that should have **bastion** access to the prometheus servers
- **metrics_server_group_ids**: List of ids of security groups that should have **metrics server** access to the prometheus servers.

## Output

The module outputs the following variables as output:

- **server_group**: Security group for the prometheus servers that got created. It contains a resource of type **openstack_networking_secgroup_v2**