provider "oci" {
  tenancy_ocid = "${var.tenancy_ocid}"
  user_ocid = "${var.user_ocid}"
  fingerprint = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region = "${var.region}"
}
# Virtual Cloud Network
resource "oci_core_virtual_network" "VCN" {
  cidr_block = "10.0.0.0/16"
  dns_label = "vnc1"
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.clustername}-vcn"
}
# Public Subnet
resource "oci_core_subnet" "PubSubnet" {
  availability_domain 	= "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block 		= "10.0.1.0/24"
  display_name 		= "${var.clustername}-pubsubnet1"
  dns_label 		= "Pubsubnet"
  compartment_id 	= "${var.compartment_ocid}"
  vcn_id 		= "${oci_core_virtual_network.VCN.id}"
  route_table_id 	= "${oci_core_route_table.RouteTable1.id}"
  security_list_ids 	= ["${oci_core_security_list.SecurityList1.id}"]
  dhcp_options_id 	= "${oci_core_virtual_network.VCN.default_dhcp_options_id}"
#prohibit_public_ip_on_vnic = "true"

}

resource "oci_core_security_list" "SecurityList1" {
  display_name   = "${var.clustername}-securitylist"
  compartment_id = "${oci_core_virtual_network.VCN.compartment_id}"
  vcn_id         = "${oci_core_virtual_network.VCN.id}"

  egress_security_rules = [{
    protocol    = "all"
    destination = "0.0.0.0/0"
  }]

  ingress_security_rules = [
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 80
        "max" = 80
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 443
        "max" = 443
      }
    },
    {
      protocol = "6"
      source   = "0.0.0.0/0"

      tcp_options {
        "min" = 22
        "max" = 22
      }
    },
  ]
}


resource "oci_core_internet_gateway" "InternetGateway1" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "${var.clustername}-InternetGateway"
    vcn_id = "${oci_core_virtual_network.VCN.id}"
}

resource "oci_core_route_table" "RouteTable1" {
    compartment_id 	= "${var.compartment_ocid}"
    vcn_id 		= "${oci_core_virtual_network.VCN.id}"
    display_name 	= "${var.clustername}-Route"
    route_rules {
        cidr_block 	= "0.0.0.0/0"
        network_entity_id = "${oci_core_internet_gateway.InternetGateway1.id}"
    }
}

#Create compute instance
resource "oci_core_instance" "PubCompute" {
  count = "${var.numinstances}"
  availability_domain 	= "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id 	= "${var.compartment_ocid}"
  display_name       	= "${var.clustername}-${format("PubCompute-%03d", count.index + 1)}"
  hostname_label 	= "mgr"
  image  		= "${var.InstanceImageOCID[var.region]}"
  shape 		= "${var.InstanceShape}"
  subnet_id 		= "${oci_core_subnet.PubSubnet.id}"

  metadata {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data 		= "${base64encode(file(var.BootStrapFile))}"
  }

  timeouts {
    create 		= "60m"
  }
}

# ------ Display the public IP of instance
output " Public IP of mgr instance " {
  value = ["${oci_core_instance.PubCompute.*.public_ip}"]
}

resource "oci_core_volume" "PubBlockVol1" {
  count                 = "${var.numinstances}"
  availability_domain 	= "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id 	= "${var.compartment_ocid}"
  display_name 		= "${var.clustername}-${format("PubBlockVol1%03d", count.index + 1)}"
  size_in_gbs 		= "${var.blockstorage}"
}

resource "oci_core_volume_attachment" "PubBlockVol1Attach" {
  count                 = "${var.numinstances}"
  attachment_type 		= "iscsi"
  compartment_id 		= "${var.compartment_ocid}"
  instance_id           = "${element(oci_core_instance.PubCompute.*.id, count.index + 1)}"
  volume_id           	= "${element(oci_core_volume.PubBlockVol1.*.id, count.index + 1)}"
}


