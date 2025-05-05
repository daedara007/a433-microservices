FROM node:14.21-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install

# tambahan
ARG VUE_APP_API_BASE_URL
ENV VUE_APP_API_BASE_URL=$VUE_APP_API_BASE_URL

# Salin semua file, termasuk .env
COPY . .

COPY . .
RUN npm run build
EXPOSE 8000
CMD [ "npm", "run", "serve" ]
