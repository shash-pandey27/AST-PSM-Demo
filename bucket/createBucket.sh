

### Authentication details
export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaaqgknm5ilfoqljqkhj27kzyyplepsoksbfvk5eqxaskyb63w2xe3a"
export TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaaee6bkrxiwlkj7zc55hmyp4v6nrhafbhqf6dnjwsfjyzeneiwwp6a"
export TF_VAR_fingerprint="b8:29:56:e6:52:03:2c:37:99:61:a2:9c:6d:cb:ac:53"
export TF_VAR_private_key_path="`pwd`/.oci/oci_api_key.pem"

### Region
export TF_VAR_region="us-ashburn-1"

### Compartment
export TF_VAR_compartment_ocid="ocid1.compartment.oc1..aaaaaaaaofg6ihfnzp7i5q7dz3hm4lvb46o7lzz3u5g4bivyhhmmkp53fraa"


### Bucket Information
export TF_VAR_bucket_name="TestB"


terraform init
terraform apply -auto-approve
