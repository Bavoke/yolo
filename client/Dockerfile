# Stage 1 - Build
FROM node:16-slim AS build

# Set the working directory
WORKDIR /usr/src/app

# Copy dependency files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Stage 2 - Production
FROM node:16-alpine

# Create app directory
WORKDIR /app

# Install serve globally
RUN npm install -g serve

# Copy built app from build stage
COPY --from=build /usr/src/app /app

# Expose the port React runs on
EXPOSE 3000

# Start the app
CMD ["serve", "-s", "build", "-l", "3000"]
