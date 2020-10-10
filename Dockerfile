FROM node:14.11.0-alpine

# アプリケーションディレクトリを作成する
WORKDIR /usr/src/app

RUN apk add --no-cache yarn git

# アプリケーションの依存関係をインストールする
# package.jsonだけ先にコピーするのは、依存関係のインストールまでをキャッシュしてリビルドを高速化するため
COPY package.json yarn.lock ./

RUN yarn install

# アプリケーションのソースをバンドルする
COPY . .

RUN chown -R node:node ./
USER node

EXPOSE 3000

CMD [ "yarn", "run", "debug" ]
