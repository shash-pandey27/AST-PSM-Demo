#!/bin/bash

ssh_keyname="OCI_ssh"
sshpub_keyname="OCI_ssh.pub"
ssh_keylocation="$HOME"


gen_sshkey()
{
cd $ssh_keylocation
ssh-keygen -t rsa -N "" -b 2048 -C "$ssh_keyname" -f $ssh_keylocation/$ssh_keyname
}

echo "Generating SSH key pair"

gen_sshkey
