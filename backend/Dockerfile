# Stage 1 - Build
FROM node:16-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .

# Stage 2 - Production
FROM node:16-alpine
WORKDIR /app
COPY --from=build /usr/src/app /app
EXPOSE 5000
CMD ["npm", "start"]