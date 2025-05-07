-- 1. Membuat database dan menggunakannya
CREATE DATABASE reservasi_hotel;

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
SELECT * FROM tamu


-- 1. Menambahkan kolom 'keterangan' di tabel Reservasi
ALTER TABLE Reservasi ADD COLUMN keterangan TEXT;

-- 2. Gabungan 2 tabel: Reservasi dan Tamu
SELECT 
    r.id_reservasi,
    t.nama_tamu,
    r.tanggal_checkin,
    r.tanggal_checkout,
    r.total_harga
FROM Reservasi r
JOIN Tamu t ON r.id_tamu = t.id_tamu;

-- 3. Order by ASC: Tampilkan tamu berdasarkan nama secara naik
SELECT * FROM Tamu ORDER BY nama_tamu ASC;

-- 3. Order by DESC: Tampilkan kamar berdasarkan harga tertinggi ke terendah
SELECT * FROM Kamar ORDER BY harga_per_malam DESC;

-- 4. Mengubah tipe data no_telepon di Tamu agar bisa menampung kode negara
ALTER TABLE Tamu MODIFY no_telepon VARCHAR(20);

-- 5. LEFT JOIN: Semua kamar beserta info reservasi (jika ada)
SELECT k.id_kamar, k.nomor_kamar, r.id_reservasi
FROM Kamar k
LEFT JOIN Reservasi r ON k.id_kamar = r.id_kamar;

-- 5. RIGHT JOIN: Semua reservasi beserta info kamar (jika ada)
SELECT r.id_reservasi, r.tanggal_checkin, k.nomor_kamar
FROM Kamar k
RIGHT JOIN Reservasi r ON k.id_kamar = r.id_kamar;

-- 5. SELF JOIN: Pegawai dengan shift yang sama
SELECT p1.nama_pegawai AS Pegawai1, p2.nama_pegawai AS Pegawai2, p1.shift
FROM Pegawai p1
JOIN Pegawai p2 ON p1.shift = p2.shift AND p1.id_pegawai < p2.id_pegawai;

-- 6. Operator Perbandingan:

-- Lebih besar dari
SELECT * FROM Kamar WHERE harga_per_malam > 500000;

-- Kurang dari
SELECT * FROM Reservasi WHERE total_harga < 1000000;

-- Sama dengan
SELECT * FROM Reservasi WHERE STATUS = 'aktif';

-- Tidak sama dengan
SELECT * FROM Tamu WHERE nama_tamu != 'Abrori';

-- Antara (BETWEEN)
SELECT * FROM Kamar WHERE harga_per_malam BETWEEN 400000 AND 800000;

DROP DATABASE reservasi_hotel;