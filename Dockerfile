FROM node:14.11.0-alpine

# アプリケーションディレクトリを作成する
WORKDIR /usr/src/app

RUN apk add --no-cache yarn

# アプリケーションの依存関係をインストールする
# ワイルドカードを使用して、package.json と package-lock.json の両方が確実にコピーされるようにします。
# 可能であれば (npm@5+)
COPY --chown=node:node package*.json ./

RUN yarn install

# アプリケーションのソースをバンドルする
COPY --chown=node:node . .

USER node

EXPOSE 3000

CMD [ "yarn", "run", "debug" ]
