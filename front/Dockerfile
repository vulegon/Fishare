FROM node:lts-slim

WORKDIR /front

ENV CI=true

# アプリケーションコードとwait-for-it.shスクリプトをコピー
COPY . .

# 依存関係のインストール
WORKDIR /front/app
RUN npm install

ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

ARG NODE_ENV
# production時のみbuild
RUN if [ "$NODE_ENV" = "production" ]; then \
      npm run build && \
      npm install -g serve; \
    fi
