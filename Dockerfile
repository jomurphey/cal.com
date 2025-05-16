# Use Node.js 18
FROM node:18

# Enable Yarn via Corepack
RUN corepack enable && corepack prepare yarn@stable --activate

# Set working directory to app
WORKDIR /app

# Copy only frontend files
COPY apps/web ./apps/web
COPY packages ./packages
COPY yarn.lock ./
COPY package.json ./
COPY turbo.json ./

# Install and build only frontend
RUN yarn install
RUN cd apps/web && yarn build

# Expose Cal.com frontend port
EXPOSE 3000

# Start the app
CMD ["yarn", "workspace", "web", "start"]
