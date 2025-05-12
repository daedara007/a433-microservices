# Menggunakan image Node.js berbasis Alpine (ringan)
FROM node:18-alpine
# Set direktori kerja di dalam container
WORKDIR /app 
# Copy file dependensi (package.json dan lock)
COPY package*.json ./
# Install dependencies
RUN npm install
# Salin semua kode aplikasi ke dalam image
COPY . .
# Mengekspos port aplikasi (misal 3000)
EXPOSE 3000
# Perintah default saat container dijalankan
CMD ["npm", "start"]