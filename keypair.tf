resource "aws_key_pair" "three_tier_key_pair" {
  key_name = "Three_Tier_Key_Pair"

  public_key = tls_private_key.three_tier_key_pair.public_key_openssh
}
resource "tls_private_key" "three_tier_key_pair" {
    algorithm = "RSA"
    rsa_bits = 4096
}
resource "local_file" "three_tier_key_pair" {
    filename = "${aws_key_pair.three_tier_key_pair.key_name}.pem"
    content = tls_private_key.three_tier_key_pair.private_key_pem
}