CREATE DATABASE reservasi_hotel;
USE reservasi_hotel;

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

ALTER TABLE Reservasi ADD CONSTRAINT fk_reservasi_tamu FOREIGN KEY (id_tamu) REFERENCES Tamu(id_tamu);

ALTER TABLE Reservasi ADD CONSTRAINT fk_reservasi_kamar FOREIGN KEY (id_kamar) REFERENCES Kamar(id_kamar);

ALTER TABLE Reservasi ADD CONSTRAINT fk_reservasi_pegawai FOREIGN KEY (id_pegawai) REFERENCES Pegawai(id_pegawai);

INSERT INTO Tamu (nama_tamu, alamat, no_telepon, email) VALUES
('Indra', 'Jl. Telang No.1', '081234567890', 'indra@mail.com'),
('Abrori', 'Jl. Telang No.2', '081298765432', 'abrori@mail.com');

INSERT INTO Kamar (nomor_kamar, jenis_kamar, harga_per_malam, STATUS) VALUES
('101', 'Deluxe', 500000, 'tersedia'),
('102', 'Superior', 400000, 'tersedia'),
('201', 'Suite', 800000, 'tersedia');

INSERT INTO Pegawai (nama_pegawai, jabatan, shift) VALUES
('Rival', 'Resepsionis', 'Pagi'),
('Tanji', 'Manager', 'Malam');

INSERT INTO Fasilitas (nama_fasilitas, deskripsi) VALUES
('Kolam Renang', 'Kolam renang outdoor untuk dewasa dan anak-anak'),
('Gym', 'Tempat fitness lengkap dengan alat-alat olahraga');

INSERT INTO Reservasi (id_tamu, id_kamar, id_pegawai, tanggal_checkin, tanggal_checkout, total_harga, STATUS) VALUES
(1, 1, 1, '2025-04-10', '2025-04-12', 1000000, 'aktif'),
(2, 2, 2, '2025-04-11', '2025-04-13', 800000, 'aktif');

SELECT * FROM fasilitas;
SELECT * FROM kamar;
SELECT * FROM pegawai;
SELECT * FROM reservasi;
SELECT * FROM tamu;

