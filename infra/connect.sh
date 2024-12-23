#!/bin/bash

# Fargateで実行しているAPIコンテナにログインするためのスクリプト
# ログインしてrakeタスクなど実行する用

entry=$1

if [ -z "$entry" ]; then
  echo "Usage: $0 <entry>"
  exit 1
fi

product_name="fishare"
cluster_name="$entry-$product_name-cluster"
task_id=$(aws ecs list-tasks --cluster $cluster_name --service-name $entry-$product_name-api-service --desired-status RUNNING | jq -r '.taskArns[0]')
container_name="$entry-$product_name-api"

if [ -z "$task_id" ]; then
  echo "Error: タスクIDの取得に失敗しました。"
  exit 1
fi

echo "Trace: cluster_name: $cluster_name"
echo "Trace: task_id: $task_id"
echo "Trace: container_name: $container_name"

aws ecs execute-command --cluster $cluster_name --task $task_id --container $container_name --command "/bin/bash" --interactive
