FROM node:lts-slim

WORKDIR /front

ENV CI=true

# アプリケーションコードとwait-for-it.shスクリプトをコピー
COPY . .

# 依存関係のインストール
WORKDIR /front/app
RUN npm install

ARG NODE_ENV
ARG REACT_APP_GOOGLE_MAP_API_KEY

# production時のみbuild
RUN if [ "$NODE_ENV" = "production" ]; then \
      echo "REACT_APP_GOOGLE_MAPS_API_KEY=$REACT_APP_GOOGLE_MAP_API_KEY" >> .env.production && \
      npm run build && \
      npm install -g serve; \
    fi
