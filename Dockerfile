FROM node:18

RUN corepack enable && corepack prepare yarn@stable --activate

WORKDIR /app

COPY . .

RUN yarn install

RUN yarn build

EXPOSE 3000

CMD ["yarn", "start"]
