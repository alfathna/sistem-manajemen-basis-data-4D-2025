-- 1. Membuat database dan menggunakannya
CREATE DATABASE reservasi_hotel;
USE reservasi_hotel;

-- 2. Membuat tabel-tabel utama (tanpa foreign key)
CREATE TABLE Tamu (
    id_tamu INT PRIMARY KEY AUTO_INCREMENT,
    nama_tamu VARCHAR(100),
    alamat VARCHAR(255),
    no_telepon VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE Kamar (
    id_kamar INT PRIMARY KEY AUTO_INCREMENT,
    nomor_kamar VARCHAR(10),
    jenis_kamar VARCHAR(50),
    harga_per_malam DECIMAL(10,2),
    STATUS VARCHAR(20)
);

CREATE TABLE Pegawai (
    id_pegawai INT PRIMARY KEY AUTO_INCREMENT,
    nama_pegawai VARCHAR(100),
    jabatan VARCHAR(50),
    shift VARCHAR(20)
);

CREATE TABLE Fasilitas (
    id_fasilitas INT PRIMARY KEY AUTO_INCREMENT,
    nama_fasilitas VARCHAR(100),
    deskripsi TEXT
    -- kolom id_kamar akan ditambahkan nanti dengan ALTER
);

CREATE TABLE Reservasi (
    id_reservasi INT PRIMARY KEY AUTO_INCREMENT,
    id_tamu INT,
    id_kamar INT,
    id_pegawai INT,
    tanggal_checkin DATE,
    tanggal_checkout DATE,
    total_harga DECIMAL(10,2),
    STATUS VARCHAR(20)
);

-- 3. Menambahkan foreign key secara terpisah dengan ALTER TABLE
ALTER TABLE Reservasi
    ADD CONSTRAINT fk_reservasi_tamu
    FOREIGN KEY (id_tamu) REFERENCES Tamu(id_tamu);

ALTER TABLE Reservasi
    ADD CONSTRAINT fk_reservasi_kamar
    FOREIGN KEY (id_kamar) REFERENCES Kamar(id_kamar);

ALTER TABLE Reservasi
    ADD CONSTRAINT fk_reservasi_pegawai
    FOREIGN KEY (id_pegawai) REFERENCES Pegawai(id_pegawai);

-- 4. Menambahkan kolom id_kamar ke Fasilitas dan foreign key-nya
ALTER TABLE Fasilitas
ADD COLUMN id_kamar INT,
ADD CONSTRAINT fk_fasilitas_kamar
FOREIGN KEY (id_kamar) REFERENCES Kamar(id_kamar);

-- Data Tamu
INSERT INTO Tamu (nama_tamu, alamat, no_telepon, email) VALUES
('Indra', 'Jl. Telang No.1', '081234567890', 'indra@mail.com'),
('Abrori', 'Jl. Telang No.2', '081298765432', 'abrori@mail.com'),
('Salsa', 'Jl. Telang No.3', '081322334455', 'salsa@mail.com'),
('Bagas', 'Jl. Telang No.4', '081344556677', 'bagas@mail.com');

-- Data Kamar
INSERT INTO Kamar (nomor_kamar, jenis_kamar, harga_per_malam, STATUS) VALUES
('101', 'Deluxe', 500000, 'tersedia'),
('102', 'Superior', 400000, 'tersedia'),
('201', 'Suite', 800000, 'tersedia'),
('103', 'Standard', 300000, 'tersedia'),
('202', 'Suite', 850000, 'terisi');

-- Data Pegawai
INSERT INTO Pegawai (nama_pegawai, jabatan, shift) VALUES
('Rival', 'Resepsionis', 'Pagi'),
('Tanji', 'Manager', 'Malam'),
('Dina', 'Housekeeping', 'Siang'),
('Abrori', 'Security', 'Malam');

-- Data Fasilitas (many-to-one ke Kamar)
INSERT INTO Fasilitas (nama_fasilitas, deskripsi, id_kamar) VALUES
('Kolam Renang', 'Kolam renang outdoor untuk dewasa dan anak-anak', 1),
('Gym', 'Tempat fitness lengkap dengan alat-alat olahraga', 1),
('WiFi', 'Akses internet gratis', 2),
('AC', 'Pendingin udara ruangan', 2),
('TV', 'TV LED 32 inch', 3),
('Bathtub', 'Bathtub dengan air panas', 5);

-- Data Reservasi
INSERT INTO Reservasi (id_tamu, id_kamar, id_pegawai, tanggal_checkin, tanggal_checkout, total_harga, STATUS) VALUES
(1, 1, 1, '2025-04-10', '2025-04-12', 1000000, 'aktif'),
(2, 2, 2, '2025-04-11', '2025-04-13', 800000, 'aktif'),
(3, 3, 3, '2025-04-09', '2025-04-10', 800000, 'selesai'),
(4, 4, 4, '2022-04-05', '2022-04-08', 900000, 'batal'),
(1, 5, 1, '2022-04-01', '2023-04-04', 2550000, 'selesai');

SELECT * FROM fasilitas;
SELECT * FROM kamar;
SELECT * FROM pegawai;
SELECT * FROM reservasi;
SELECT * FROM tamu;

-- 1. View gabungan minimal 2 tabel
CREATE VIEW view_tamu_dan_kamar AS
SELECT 
    t.nama_tamu,
    k.nomor_kamar
FROM Reservasi r
JOIN Tamu t ON r.id_tamu = t.id_tamu
JOIN Kamar k ON r.id_kamar = k.id_kamar;

-- 2. View gabungan minimal 3 tabel
CREATE VIEW view_reservasi_lengkap AS
SELECT 
    t.nama_tamu,
    k.nomor_kamar,
    p.nama_pegawai,
    r.tanggal_checkin,
    r.tanggal_checkout
FROM Reservasi r
JOIN Tamu t ON r.id_tamu = t.id_tamu
JOIN Kamar k ON r.id_kamar = k.id_kamar
JOIN Pegawai p ON r.id_pegawai = p.id_pegawai;

-- 3. View gabungan dengan syarat tertentu
CREATE VIEW view_reservasi_aktif AS
SELECT 
    t.nama_tamu,
    k.nomor_kamar,
    r.tanggal_checkin,
    r.tanggal_checkout,
    r.status
FROM Reservasi r
JOIN Tamu t ON r.id_tamu = t.id_tamu
JOIN Kamar k ON r.id_kamar = k.id_kamar
WHERE r.status = 'Aktif';

-- 4. View agregasi dari 2 tabel
CREATE VIEW view_statistik_kamar AS
SELECT 
    k.nomor_kamar,
    COUNT(r.id_reservasi) AS total_reservasi,
    SUM(r.total_harga) AS total_pendapatan,
    AVG(r.total_harga) AS rata_rata_pendapatan,
    MIN(r.total_harga) AS pendapatan_terendah,
    MAX(r.total_harga) AS pendapatan_tertinggi
FROM Kamar k
JOIN Reservasi r ON k.id_kamar = r.id_kamar
GROUP BY k.nomor_kamar;

-- 5. View bebas (reservasi sebelum tahun 2024)
CREATE VIEW view_tamu_lama AS
SELECT 
    t.nama_tamu,
    r.tanggal_checkin,
    r.tanggal_checkout
FROM Reservasi r
JOIN Tamu t ON r.id_tamu = t.id_tamu
WHERE YEAR(r.tanggal_checkin) < 2024;

SELECT * FROM view_tamu_dan_kamar;
SELECT * FROM view_reservasi_lengkap;
SELECT * FROM view_reservasi_aktif;
SELECT * FROM view_statistik_kamar;
SELECT * FROM view_tamu_lama;
DROP DATABASE reservasi_hotel;
