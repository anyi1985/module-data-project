module "ec2_module_s3DB" {
  source           = "../modules/ec2"
  REGIONec2        = "us-east-1"
  ami_idmod        = "ami-0ed9277fb7eb570c9"
  instance_typemod = "t2.micro"
  subnet_idmod     = "subnet-0c94e38ae0ba63753" #change this to a subnet in us-east-1
}

module "s3_module" {
  source      = "../modules/s3"
  REGIONs3    = "us-east-1"
  s3modbucket = "anyimodulebucket"

}
