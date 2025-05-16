FROM node:18

# Enable Yarn v3
RUN corepack enable && corepack prepare yarn@stable --activate

WORKDIR /app

# Copy everything Yarn needs
COPY .yarn ./.yarn
COPY .yarnrc.yml ./.yarnrc.yml
COPY package.json ./
COPY yarn.lock ./
COPY turbo.json ./

# Copy full app structure for monorepo
COPY apps ./apps
COPY packages ./packages

# Install and build
RUN yarn install --immutable
RUN yarn build

EXPOSE 3000

CMD ["yarn", "workspace", "web", "start"]
