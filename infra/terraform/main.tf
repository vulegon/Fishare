module "iam" {
  source = "./modules/iam"
  product_name = var.product_name
  env = var.env
}
