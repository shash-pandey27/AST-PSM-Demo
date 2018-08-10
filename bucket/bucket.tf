provider "oci" {
  tenancy_ocid = "${var.tenancy_ocid}"
  user_ocid = "${var.user_ocid}"
  fingerprint = "${var.fingerprint}"
  private_key_path = "${var.private_key_path}"
  region = "${var.region}"
}

resource "oci_objectstorage_bucket" "test_bucket" {
	#Required
	compartment_id = "${var.compartment_ocid}"
	name = "${var.bucket_name}"
	namespace = "${var.bucket_namespace}"
}
