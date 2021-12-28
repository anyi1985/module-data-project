resource "aws_instance" "Instance_Mods3DB" {
  ami                         = var.ami_idmod
  instance_type               = var.instance_typemod
  subnet_id                   = var.subnet_idmod
  key_name                    = "BastionKeyPair" #use your own key pair#
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2s3DyDB-Instance-Profile.id
  user_data                   = <<EOF
		#! /bin/bash
    sudo chown ec2-user 
    yum update -y 
    yum install httpd -y 
    chkconfig httpd on
    cd /var/*
    aws s3 cp /var/log s3://var.s3modbucket --recursive
    service httpd start
	EOF
}

resource "aws_iam_role" "ec2_role" {
  description        = "this is an instance role with an assume role policy"
  name               = "ec2-s3-DynamoDB-role"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json

}

resource "aws_iam_role_policy" "ec2s3DyDB-Role-Policy" {
  name   = "ec2-s3-DynamoDB-policy"
  role   = aws_iam_role.ec2_role.id
  policy = data.aws_iam_policy_document.ec2-s3-DyDB-role-policy.json

}

resource "aws_iam_instance_profile" "ec2s3DyDB-Instance-Profile" {
  name = "ec2s3DyDB_instance_Profile"
  role = aws_iam_role.ec2_role.name

}
