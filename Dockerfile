FROM node:18

RUN corepack enable && corepack prepare yarn@stable --activate

WORKDIR /app

# Copy required files and directories for Yarn and Turbo
COPY .yarn ./.yarn
COPY .yarnrc.yml ./.yarnrc.yml
COPY apps/web ./apps/web
COPY packages ./packages
COPY yarn.lock ./
COPY package.json ./
COPY turbo.json ./

RUN yarn install
RUN cd apps/web && yarn build

EXPOSE 3000

CMD ["yarn", "workspace", "web", "start"]
