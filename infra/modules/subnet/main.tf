# パブリックサブネット
resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.target_availability_zones[count.index % length(var.target_availability_zones)]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-${var.target_availability_zones[count.index % length(var.target_availability_zones)]}"
  }
}

# プライベートサブネット
resource "aws_subnet" "private" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.target_availability_zones[count.index % length(var.target_availability_zones)]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name}-private-${var.target_availability_zones[count.index % length(var.target_availability_zones)]}"
  }
}
