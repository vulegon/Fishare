# Data: Secrets Managerから外部リソースを取得
data "aws_ssm_parameter" "rails_master_key" {
  name        = "/${var.product_name}/${var.env}/RAILS_MASTER_KEY"
  with_decryption = true
}

data "aws_ssm_parameter" "postgres_user" {
  name            = "/${var.product_name}/${var.env}/POSTGRES_USER"
  with_decryption = true
}

data "aws_ssm_parameter" "postgres_password" {
  name            = "/${var.product_name}/${var.env}/POSTGRES_PASSWORD"
  with_decryption = true
}
