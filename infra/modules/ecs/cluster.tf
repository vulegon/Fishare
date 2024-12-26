resource "aws_ecs_cluster" "app_cluster" {
  name = "${var.env}-${var.product_name}-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "app_cluster_capacity_providers" {
  cluster_name = aws_ecs_cluster.app_cluster.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    base              = 1   # 最低1つのインスタンスをFARGATE_SPOTで確保
    weight            = 2   # FARGATE_SPOTを優先的に使用
  }

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 0   # FARGATEは補助的に使用
    weight            = 1   # FARGATEはFARGATE_SPOTが不足した場合に使用される
  }
}
