-- MODUL 1

-- Membuat database
DROP DATABASE bengkel_motor;
CREATE DATABASE bengkel_motor;
USE bengkel_motor;

-- Tabel Master: Pelanggan
CREATE TABLE pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    alamat TEXT,
    no_telepon VARCHAR(20),
    email VARCHAR(100)
);

INSERT INTO pelanggan (nama, alamat, no_telepon, email) VALUES
('Andi', 'Jl. Raya No. 15, Sidoarjo', '081234567890', 'andi_sidoarjo@gmail.com'),
('Budi', 'Jl. Madu No. 7, Surabaya', '082198765432', 'budi.surabaya@gmail.com'),
('Zara', 'Jl. Kemuning No. 3, Gresik', '081234567893', 'zara.gresik@gmail.com'),
('Rudi', 'Jl. Cendana No. 9, Mojokerto', '082123456789', 'rudi.mojokerto@gmail.com'),
('Lina', 'Jl. Merpati No. 12, Bangkalan', '081345678912', 'lina.bangkalan@gmail.com');



-- Tabel Master: Mekanik
CREATE TABLE mekanik (
    id_mekanik INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    spesialisasi VARCHAR(100),
    no_telepon VARCHAR(20)
);

INSERT INTO mekanik (nama, spesialisasi, no_telepon) VALUES
('Pak Joko', 'Mesin', '081345678901'),
('Pak Josddd', 'Mesin', '081345678922'),
('Pak Dedi', 'Kelistrikan', '082198765432'),
('Bu Sari', 'Rem & Suspensi', '081398762341'),
('Pak Anton', 'Karburator & Injeksi', '082223456789'),
('Pak Rudi', 'Body & Cat', '083145672341');




-- Tabel Master: Layanan
CREATE TABLE layanan (
    id_layanan INT AUTO_INCREMENT PRIMARY KEY,
    nama_layanan VARCHAR(100),
    deskripsi TEXT,
    harga DECIMAL(10, 2)
);

INSERT INTO layanan (nama_layanan, deskripsi, harga) VALUES
('Ganti Oli', 'Mengganti oli mesin', 50000),
('Service Rem', 'Pemeriksaan dan perbaikan sistem rem', 75000),
('Tune Up', 'Penyetelan dan pemeriksaan menyeluruh', 100000),
('Ganti Busi', 'Mengganti busi mesin motor', 30000),
('Cek Kelistrikan', 'Pemeriksaan sistem kelistrikan', 40000);




-- Tabel Master: Suku Cadang
CREATE TABLE suku_cadang (
    id_suku_cadang INT AUTO_INCREMENT PRIMARY KEY,
    nama_suku_cadang VARCHAR(100),
    stok INT,
    harga DECIMAL(10, 2)
);

INSERT INTO suku_cadang (nama_suku_cadang, stok, harga) VALUES
('Oli Mesin', 100, 40000),
('Kampas Rem', 50, 60000),
('Busi', 70, 25000),
('Aki', 30, 200000),
('Filter Udara', 40, 35000);




-- Tabel Transaksi: Transaksi Service
CREATE TABLE transaksi_service (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    tanggal DATE,
    id_pelanggan INT,
    id_mekanik INT,
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan),
    FOREIGN KEY (id_mekanik) REFERENCES mekanik(id_mekanik)
);


INSERT INTO transaksi_service (tanggal, id_pelanggan, id_mekanik) VALUES
('2025-04-30', 1, 1),
('2025-04-30', 2, 2),
('2025-05-01', 3, 1),
('2025-05-02', 4, 3),
('2025-05-03', 5, 2);



-- Tabel Detail: Detail Layanan
CREATE TABLE detail_layanan (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_transaksi INT,
    id_layanan INT,
    jumlah INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_transaksi) REFERENCES transaksi_service(id_transaksi),
    FOREIGN KEY (id_layanan) REFERENCES layanan(id_layanan)
);

INSERT INTO detail_layanan (id_transaksi, id_layanan, jumlah, subtotal) VALUES
(1, 1, 1, 50000.00),
(2, 3, 1, 100000.00),
(3, 2, 1, 75000.00),
(4, 4, 1, 30000.00),
(5, 5, 1, 60000.00);




-- Tabel Detail: Detail Suku Cadang
CREATE TABLE detail_suku_cadang (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_transaksi INT,
    id_suku_cadang INT,
    jumlah INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_transaksi) REFERENCES transaksi_service(id_transaksi),
    FOREIGN KEY (id_suku_cadang) REFERENCES suku_cadang(id_suku_cadang)
);

INSERT INTO detail_suku_cadang (id_transaksi, id_suku_cadang, jumlah, subtotal) VALUES
(2, 3, 1, 40000),
(4, 5, 2, 50000),
(3, 1, 3, 60000),
(1, 4, 2, 35000),
(5, 2, 1, 70000);



SELECT * FROM pelanggan
SELECT * FROM mekanik
SELECT * FROM layanan
SELECT * FROM suku_cadang
SELECT * FROM transaksi_service
SELECT * FROM detail_layanan
SELECT * FROM detail_suku_cadang

