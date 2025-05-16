FROM node:18-alpine

# Enable Corepack and prepare Yarn
RUN corepack enable && corepack prepare yarn@stable --activate

# Set working directory
WORKDIR /app

# Copy Yarn configuration and lockfiles
COPY .yarn ./.yarn
COPY .yarnrc.yml ./
COPY package.json ./
COPY yarn.lock ./
COPY turbo.json ./

# Copy only the web app and required packages
COPY apps/web ./apps/web
COPY packages ./packages

# Install dependencies for the web workspace only
RUN yarn workspace web install --frozen-lockfile

# Build the web workspace
RUN yarn workspace web build

# Expose port
EXPOSE 3000

# Start the web app
CMD ["yarn", "workspace", "web", "start"]
