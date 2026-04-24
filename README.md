# 🛍️ Katalog Produk E-Commerce (Flutter Frontend Task 2)

Aplikasi mobile Flutter berfokus pada sisi Frontend, berfungsi sebagai manajemen katalog produk sederhana menggunakan state lokal dan layout responsif.

## 🌟 Fitur Utama
1. **Dashboard Responsif**: Menampilkan produk dalam GridView yang menyesuaikan kolom secara dinamis (1 kolom di Mobile, 2 di Tablet, 4 di Desktop).
2. **Detail Interaktif**: Navigasi custom ke halaman detail lengkap menggunakan animasi Hero.
3. **Form Validasi & Pencegahan Keluar**: Tambah produk baru dengan validasi data form. Dilengkapi `PopScope` untuk memunculkan peringatan jika user mencoba kembali tanpa menyimpan (mencegah data hilang).
4. **Local State Management**: Sistem toggle favorit (suka/tidak suka produk) secara *real-time* berbasis `setState` yang rapi.
5. **Dark/Light Mode**: Mendukung perubahan tema melalui widget adaptif (Platform-aware).

## 🗂️ Struktur Halaman
- **Home/Dashboard (`/`)**: Menampilkan daftar produk (Mock data Dart list), tombol tambah, dan tombol pengaturan.
- **Detail (`/detail`)**: Menampilkan gambar, nama, harga, dan deskripsi menggunakan argumen *named routes*.
- **Form (`/form`)**: Menggunakan `Form`, `TextFormField` dan custom validator untuk input produk baru.
- **Settings (`/settings`)**: Switch adaptif untuk mode tema yang juga memanfaatkan `Semantics` untuk aksesibilitas.

## 🚀 Cara Menjalankan Project

1. Pastikan Flutter SDK sudah terpasang di komputermu.
2. Clone/Fork repository ini.
3. Buka terminal di folder project, lalu jalankan:
   ```bash
   flutter pub get