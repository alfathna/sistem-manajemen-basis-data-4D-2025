CREATE DATABASE sistem_manajemen_asrama;
USE sistem_manajemen_asrama;

-- Tabel Master: Mahasiswa
CREATE TABLE mahasiswa (
    id_mahasiswa INT AUTO_INCREMENT PRIMARY KEY,
    nim VARCHAR(15) UNIQUE NOT NULL,
    nama VARCHAR(100) NOT NULL,
    jurusan VARCHAR(50),
    angkatan YEAR,
    kontak VARCHAR(20)
);

-- Tabel Master: Kamar
CREATE TABLE kamar (
    id_kamar INT AUTO_INCREMENT PRIMARY KEY,
    nomor_kamar VARCHAR(10) UNIQUE NOT NULL,
    kapasitas INT NOT NULL,
    tersedia BOOLEAN DEFAULT TRUE
);

-- Tabel Master: Fasilitas
CREATE TABLE fasilitas (
    id_fasilitas INT AUTO_INCREMENT PRIMARY KEY,
    nama_fasilitas VARCHAR(100) NOT NULL,
    deskripsi TEXT
);

-- Tabel Transaksi: Pemesanan Kamar
CREATE TABLE pemesanan_kamar (
    id_pemesanan INT AUTO_INCREMENT PRIMARY KEY,
    id_mahasiswa INT,
    id_kamar INT,
    tanggal_masuk DATE NOT NULL,
    tanggal_keluar DATE,
    status ENUM('Aktif', 'Selesai') DEFAULT 'Aktif',
    FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa(id_mahasiswa) ON DELETE CASCADE,
    FOREIGN KEY (id_kamar) REFERENCES kamar(id_kamar) ON DELETE CASCADE
);

-- Tabel Transaksi: Laporan Keluhan
CREATE TABLE laporan_keluhan (
    id_keluhan INT AUTO_INCREMENT PRIMARY KEY,
    id_mahasiswa INT,
    id_kamar INT,
    id_fasilitas INT NULL,
    deskripsi_keluhan TEXT NOT NULL,
    tanggal_laporan DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Belum Ditangani', 'Sedang Diproses', 'Selesai') DEFAULT 'Belum Ditangani',
    FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa(id_mahasiswa) ON DELETE CASCADE,
    FOREIGN KEY (id_kamar) REFERENCES kamar(id_kamar) ON DELETE SET NULL,
    FOREIGN KEY (id_fasilitas) REFERENCES fasilitas(id_fasilitas) ON DELETE SET NULL
);
