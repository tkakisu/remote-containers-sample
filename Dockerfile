FROM node:14.11.0-alpine

# アプリケーションディレクトリを作成する
WORKDIR /usr/src/app

RUN apk add --no-cache yarn git

# アプリケーションの依存関係をインストールする
# ワイルドカードを使用して、package.json と package-lock.json の両方が確実にコピーされるようにします。
# package.jsonだけ先にコピーするのは、依存関係のインストールまでをキャッシュしてリビルドを高速化するため
COPY package*.json ./

RUN yarn install

# アプリケーションのソースをバンドルする
COPY . .

RUN chown -R node:node ./
USER node

EXPOSE 3000

CMD [ "yarn", "run", "debug" ]
