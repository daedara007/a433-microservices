# ini menggunakan image Node.js berbasis Alpine (ringan)
FROM node:18-alpine
# ini adalah direktori kerja di dalam container
WORKDIR /app 
# buat copy file dependensi
COPY package*.json ./
# buat install dependensi
RUN npm install
# buat salin semua kode aplikasi ke dalam image
COPY . .
# untuk mengekspos port aplikasi ke 3000
EXPOSE 3000
# ini adalah perintah default saat container dijalankan
CMD ["npm", "start"]