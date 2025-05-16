FROM node:18

# Enable corepack so we can use yarn
RUN corepack enable

# Set working directory inside container
WORKDIR /app

# Copy full monorepo
COPY . .

# Install dependencies from the monorepo root
RUN yarn install --frozen-lockfile

# Build the Cal.com web app
RUN yarn build:web

# Expose port
EXPOSE 3000

# Start the app
CMD ["yarn", "start:web"]
