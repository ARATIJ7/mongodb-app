# Import existing key pair
resource "aws_key_pair" "deployer" {
  key_name   = "jewelry-app-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
