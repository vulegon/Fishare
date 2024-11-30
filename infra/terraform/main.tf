module "iam" {
  source = "./modules/iam"
  product_name = var.product_name
  env = var.env
}

module "s3" {
  source = "./modules/s3"
  product_name = var.product_name
  env = var.env
}
