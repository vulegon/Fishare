FROM node:lts-slim

WORKDIR /front

ENV CI=true

# アプリケーションコードとwait-for-it.shスクリプトをコピー
COPY . .

# 依存関係のインストール
WORKDIR /front/app
RUN npm install

ENV NODE_ENV=$NODE_ENV
# production時のみbuild
RUN if [ "$NODE_ENV" = "production" ]; then npm run build; fi

WORKDIR /front
