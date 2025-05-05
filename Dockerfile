FROM node:14.21-alpine as builder

WORKDIR /app

# Salin hanya yang dibutuhkan terlebih dahulu
COPY package*.json ./
RUN npm install

# Tambahkan ARG agar bisa diteruskan dari build context
ARG VUE_APP_API_BASE_URL
ENV VUE_APP_API_BASE_URL=$VUE_APP_API_BASE_URL

# Salin semua file, termasuk .env
COPY . .

# Build Vue dengan env yang sudah ditentukan
RUN npm run build

EXPOSE 8000

# Serve file hasil build menggunakan serve package
RUN npm install -g serve
CMD [ "serve", "-s", "dist" ]