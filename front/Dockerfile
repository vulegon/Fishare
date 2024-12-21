FROM node:lts-slim

WORKDIR /front

ENV CI=true

# アプリケーションコードとwait-for-it.shスクリプトをコピー
COPY . .

# 依存関係のインストール
WORKDIR /front/app
RUN npm install

ARG NODE_ENV
# production時のみbuild
RUN if [ "$NODE_ENV" = "production" ]; then npm run build; fi
