CREATE DATABASE PenyewaanAlatRumahTangga;
USE PenyewaanAlatRumahTangga;

DROP TABLE IF EXISTS `Pelanggan`;

CREATE TABLE `Pelanggan` (
    `id_pelanggan` INT (10)PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `nama` VARCHAR(100),
    `alamat` TEXT,
    `no_telepon` VARCHAR(15),
    `email` VARCHAR(100)
);

INSERT INTO Pelanggan (id_pelanggan, nama, alamat, no_telepon, email) VALUES
(1, 'Andi Wijaya', 'Jl. Merdeka No.10', '081234567890', 'andi@gmail.com'),
(2, 'Siti Nurhaliza', 'Jl. Melati No.45', '082134567891', 'siti.nur@gmail.com'),
(3, 'Budi Santoso', 'Jl. Sudirman No.20', '085234567892', 'budi_san@gmail.com');

DROP TABLE IF EXISTS `Alat`;

CREATE TABLE Alat (
    id_alat INT(10)PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nama_alat VARCHAR(100),
    id_kategori INT(10)NOT NULL,
    kategori VARCHAR(50),
    harga_sewa_per_hari DECIMAL(10,2),
    stok INT
);

ALTER TABLE Alat ADD CONSTRAINT `Alat_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `Kategori_Alat` (`id_kategori`);

INSERT INTO Alat (id_alat, nama_alat, id_kategori, kategori, harga_sewa_per_hari, stok) VALUES
(1, 'Vacuum Cleaner',3, 'Alat Kebersihan', 25000, 5),
(2, 'Rice Cooker',2, 'Peralatan Dapur', 20000, 8),
(3, 'Setrika Listrik',1, 'Elektronik', 15000, 10),
(4, 'Blender',2, 'Peralatan Dapur', 22000, 7);

DROP TABLE IF EXISTS `Kategori_Alat`;

CREATE TABLE Kategori_Alat (
    id_kategori INT(10)PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nama_kategori VARCHAR(50)
);

INSERT INTO Kategori_Alat (id_kategori, nama_kategori) VALUES
(1, 'Elektronik'),
(2, 'Peralatan Dapur'),
(3, 'Alat Kebersihan');

DROP TABLE IF EXISTS `Transaksi`;

CREATE TABLE Transaksi (
    id_transaksi INT(10)PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_pelanggan INT(10)NOT NULL,
    tanggal_sewa DATE,
    tanggal_kembali DATE,
    total_biaya DECIMAL(12,2)
);

ALTER TABLE Transaksi ADD CONSTRAINT `Transaksi_ibfk_1` FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan);

INSERT INTO Transaksi (id_transaksi, id_pelanggan, tanggal_sewa, tanggal_kembali, total_biaya) VALUES
(1, 1, '2025-04-01', '2025-04-03', 75000),
(2, 2, '2025-04-02', '2025-04-04', 44000);

DROP TABLE IF EXISTS `Detail_Transaksi`;

CREATE TABLE Detail_Transaksi (
    id_detail INT(10)PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_transaksi INT(10)NOT NULL,
    id_alat INT(10)NOT NULL,
    jumlah INT,
    harga_sewa DECIMAL(10,2)
) ;

    ALTER TABLE Detail_Transaksi ADD CONSTRAINT fk_dt_transaksi FOREIGN KEY (id_transaksi) REFERENCES Transaksi(id_transaksi);
    ALTER TABLE Detail_Transaksi ADD CONSTRAINT fk_dt_alat FOREIGN KEY (id_alat) REFERENCES Alat(id_alat);

INSERT INTO Detail_Transaksi (id_detail, id_transaksi, id_alat, jumlah, harga_sewa) VALUES
(1, 1, 1, 1, 25000),
(2, 1, 3, 1, 15000),
(3, 2, 2, 1, 20000),
(4, 2, 4, 1, 22000);


SELECT * FROM Pelanggan;
SELECT * FROM Kategori_Alat;
SELECT * FROM Alat;
SELECT * FROM Transaksi;
SELECT * FROM Detail_Transaksi;
