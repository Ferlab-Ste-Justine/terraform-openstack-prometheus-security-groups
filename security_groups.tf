resource "openstack_networking_secgroup_v2" "prometheus_server" {
  name                 = var.member_group_name
  description          = "Security group for prometheus servers"
  delete_default_rules = true
}

//Allow all outbound traffic from prometheus servers
resource "openstack_networking_secgroup_rule_v2" "prometheus_server_outgoing_v4" {
  direction         = "egress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.prometheus_server.id
}

resource "openstack_networking_secgroup_rule_v2" "prometheus_server_outgoing_v6" {
  direction         = "egress"
  ethertype         = "IPv6"
  security_group_id = openstack_networking_secgroup_v2.prometheus_server.id
}

//Allow port 22 and icmp traffic from the bastion
resource "openstack_networking_secgroup_rule_v2" "internal_ssh_access" {
  for_each          = { for idx, id in var.bastion_group_ids : idx => id }
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_group_id   = each.value
  security_group_id = openstack_networking_secgroup_v2.prometheus_server.id
}

resource "openstack_networking_secgroup_rule_v2" "bastion_icmp_access_v4" {
  for_each          = { for idx, id in var.bastion_group_ids : idx => id }
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_group_id   = each.value
  security_group_id = openstack_networking_secgroup_v2.prometheus_server.id
}

resource "openstack_networking_secgroup_rule_v2" "bastion_icmp_access_v6" {
  for_each          = { for idx, id in var.bastion_group_ids : idx => id }
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "ipv6-icmp"
  remote_group_id   = each.value
  security_group_id = openstack_networking_secgroup_v2.prometheus_server.id
}

//Allow port 9090 and icmp traffic from the client
resource "openstack_networking_secgroup_rule_v2" "client_prometheus_access" {
  for_each          = { for idx, id in var.client_group_ids : idx => id }
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9090
  port_range_max    = 9090
  remote_group_id   = each.value
  security_group_id = openstack_networking_secgroup_v2.prometheus_server.id
}

resource "openstack_networking_secgroup_rule_v2" "client_icmp_access_v4" {
  for_each          = { for idx, id in var.client_group_ids : idx => id }
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_group_id   = each.value
  security_group_id = openstack_networking_secgroup_v2.prometheus_server.id
}

resource "openstack_networking_secgroup_rule_v2" "client_icmp_access_v6" {
  for_each          = { for idx, id in var.client_group_ids : idx => id }
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "ipv6-icmp"
  remote_group_id   = each.value
  security_group_id = openstack_networking_secgroup_v2.prometheus_server.id
}

//Allow port 9090, 9100 and icmp traffic from metrics server
resource "openstack_networking_secgroup_rule_v2" "metrics_server_node_exporter_access" {
  for_each          = { for idx, id in var.metrics_server_group_ids : idx => id }
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9100
  port_range_max    = 9100
  remote_group_id   = each.value
  security_group_id = openstack_networking_secgroup_v2.prometheus_server.id
}

resource "openstack_networking_secgroup_rule_v2" "metrics_server_prometheus_exporter_access" {
  for_each          = { for idx, id in var.metrics_server_group_ids : idx => id }
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 9090
  port_range_max    = 9090
  remote_group_id   = each.value
  security_group_id = openstack_networking_secgroup_v2.prometheus_server.id
}

resource "openstack_networking_secgroup_rule_v2" "metrics_server_icmp_access_v4" {
  for_each          = { for idx, id in var.metrics_server_group_ids : idx => id }
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_group_id   = each.value
  security_group_id = openstack_networking_secgroup_v2.prometheus_server.id
}

resource "openstack_networking_secgroup_rule_v2" "metrics_server_icmp_access_v6" {
  for_each          = { for idx, id in var.metrics_server_group_ids : idx => id }
  direction         = "ingress"
  ethertype         = "IPv6"
  protocol          = "ipv6-icmp"
  remote_group_id   = each.value
  security_group_id = openstack_networking_secgroup_v2.prometheus_server.id
}