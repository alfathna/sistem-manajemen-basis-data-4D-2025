-- 1. PROCEDURE AddUMKM: Menambahkan data UMKM baru
-- Parameter: nama_usaha (nama bisnis UMKM), jumlah_karyawan (total karyawan)
-- Fungsi: Menyimpan data UMKM baru dengan nilai default untuk field lainnya

USE modul2;

-- 1
DELIMITER //
CREATE PROCEDURE AddUMKM (
    IN p_nama_usaha VARCHAR(200),
    IN p_jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm (
        nama_usaha, id_pemilik, id_kategori, id_skala, id_kabupaten_kota,
        alamat_usaha, nib, npwp, tahun_berdiri, jumlah_karyawan,
        total_aset, omzet_per_tahun, deskripsi_usaha, tanggal_registrasi
    ) VALUES (
        p_nama_usaha, 1, 1, 1, 1, 
        'Alamat Default', '0000000000000', '00.000.000.0-000.000', 2020,
        p_jumlah_karyawan, 0, 0, 'Deskripsi Default', CURDATE()
    );
END //
DELIMITER ;
SELECT * FROM umkm;
CALL AddUMKM('Toko Maju Jaya', 10); 
SELECT nama_usaha, jumlah_karyawan FROM umkm;



-- 2. PROCEDURE UpdateKategoriUMKM: Memperbarui nama kategori UMKM
-- Parameter: id_kategori (ID kategori yang akan diupdate), nama_baru (nama baru untuk kategori)
-- Fungsi: Mengubah nama kategori berdasarkan ID yang diberikan
DELIMITER //
CREATE PROCEDURE UpdateKategoriUMKM (
    IN p_id_kategori INT,
    IN p_nama_baru VARCHAR(100)
)
BEGIN
    UPDATE kategori_umkm
    SET nama_kategori = p_nama_baru
    WHERE id_kategori = p_id_kategori;
END //
DELIMITER ;

SELECT * FROM kategori_umkm;
SELECT * FROM kategori_umkm WHERE id_kategori = 2;


-- 3. PROCEDURE DeletePemilikUMKM: Menghapus data pemilik UMKM
-- Parameter: id_pemilik (ID pemilik yang akan dihapus)
-- Fungsi: Menghapus pemilik dan semua UMKM yang dimilikinya (cascade delete)
DROP PROCEDURE IF EXISTS DeletePemilikUMKM;
DELIMITER //

CREATE PROCEDURE DeletePemilikUMKM (
    IN p_id_pemilik INT
)
BEGIN
    -- Hapus data terkait di tabel umkm yang bergantung pada pemilik UMKM
    DELETE FROM umkm
    WHERE id_pemilik = p_id_pemilik;

    -- Hapus data terkait di produk_umkm yang terkait dengan pemilik UMKM
    DELETE FROM produk_umkm
    WHERE id_umkm IN (
        SELECT id_umkm FROM umkm WHERE id_pemilik = p_id_pemilik
    );

    -- Hapus data dari tabel pemilik_umkm
    DELETE FROM pemilik_umkm
    WHERE id_pemilik = p_id_pemilik;
END //

DELIMITER ;

CALL DeletePemilikUMKM(3);
ALTER TABLE umkm
DROP FOREIGN KEY fk_umkm_pemilik;

ALTER TABLE umkm
ADD CONSTRAINT fk_umkm_pemilik
FOREIGN KEY (id_pemilik) REFERENCES pemilik_umkm(id_pemilik) ON DELETE CASCADE;

SELECT * FROM umkm;
CALL DeletePemilikUMKM(2);
DELETE FROM umkm WHERE id_pemilik = 5;
CALL DeletePemilikUMKM(5);

-- Memeriksa apakah data pemilik UMKM sudah terhapus
SELECT * FROM pemilik_umkm WHERE id_pemilik = 2;

-- Memeriksa apakah data produk UMKM yang terkait sudah terhapus
SELECT * FROM produk_umkm WHERE id_umkm = (SELECT id_umkm FROM umkm WHERE id_pemilik = 2);



-- 4. PROCEDURE AddProduk: Menambahkan produk baru untuk UMKM
-- Parameter: id_umkm (ID UMKM pemilik produk), nama_produk (nama produk), harga (harga produk)
-- Fungsi: Menambahkan produk baru ke dalam sistem
DROP PROCEDURE IF EXISTS AddProduk;
DELIMITER //
CREATE PROCEDURE AddProduk (
    IN p_id_umkm INT,
    IN p_nama_produk VARCHAR(200),
    IN p_harga DECIMAL(15,2)
)
BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, deskripsi_produk, harga)
    VALUES (p_id_umkm, p_nama_produk, 'Deskripsi default', p_harga);
END //
DELIMITER ;

CALL AddProduk(1, 'Kopi Arabika', 25000.00);
SELECT * FROM produk_umkm;

-- 5. PROCEDURE GetUMKMByID: Mendapatkan data UMKM berdasarkan ID
-- Parameter: 
--   IN: id_umkm (ID UMKM yang dicari)
--   OUT: berbagai field data UMKM yang akan dikembalikan
-- Fungsi: Mengambil detail lengkap UMKM berdasarkan ID-nya
DELIMITER //
CREATE PROCEDURE GetUMKMByID (
    IN p_id_umkm INT,
    OUT p_nama_usaha VARCHAR(200)
)
BEGIN
    SELECT nama_usaha INTO p_nama_usaha
    FROM umkm
    WHERE id_umkm = p_id_umkm;
END //
DELIMITER ;
CALL GetUMKMByID(1, @nama_usaha);
SELECT @nama_usaha;


-- SOAL 2
-- 1
DROP DATABASE IF EXISTS bioskop1;
CREATE DATABASE bioskop1;
USE bioskop1;


-- Buat semua tabel tanpa foreign key dulu
CREATE TABLE Film (
    kode_film CHAR(5) PRIMARY KEY,
    judul VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    durasi INT,
    rating VARCHAR(10)
);

CREATE TABLE Studio (
    id_studio INT PRIMARY KEY AUTO_INCREMENT,
    nama_studio VARCHAR(50) NOT NULL,
    kapasitas INT NOT NULL
);

CREATE TABLE Pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_hp VARCHAR(15) NOT NULL
);

CREATE TABLE Jadwal_Film (
    id_jadwal INT PRIMARY KEY AUTO_INCREMENT,
    kode_film CHAR(5),
    id_studio INT,
    tanggal DATE,
    jam_tayang TIME
);

CREATE TABLE Tiket (
    id_tiket INT PRIMARY KEY AUTO_INCREMENT,
    id_pelanggan INT,
    id_jadwal INT,
    jumlah INT,
    total_harga DECIMAL(10,2)
);

CREATE TABLE Pembayaran (
    id_pembayaran INT PRIMARY KEY AUTO_INCREMENT,
    id_tiket INT,
    metode_pembayaran VARCHAR(50) NOT NULL,
    tanggal_pembayaran DATE NOT NULL,
    jumlah_bayar DECIMAL(10,2) NOT NULL
);

-- Tambahkan foreign key secara terpisah
ALTER TABLE Jadwal_Film
ADD CONSTRAINT fk_jadwal_film_film
FOREIGN KEY (kode_film) REFERENCES Film(kode_film) ON DELETE CASCADE;

ALTER TABLE Jadwal_Film
ADD CONSTRAINT fk_jadwal_film_studio
FOREIGN KEY (id_studio) REFERENCES Studio(id_studio) ON DELETE CASCADE;

ALTER TABLE Tiket
ADD CONSTRAINT fk_tiket_pelanggan
FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan) ON DELETE CASCADE;

ALTER TABLE Tiket
ADD CONSTRAINT fk_tiket_jadwal
FOREIGN KEY (id_jadwal) REFERENCES Jadwal_Film(id_jadwal) ON DELETE CASCADE;

ALTER TABLE Pembayaran
ADD CONSTRAINT fk_pembayaran_tiket
FOREIGN KEY (id_tiket) REFERENCES Tiket(id_tiket) ON DELETE CASCADE;

DROP TABLE IF EXISTS Film;



-- Isi data (dengan urutan yang benar)
INSERT INTO Pelanggan (nama, email, no_hp) VALUES 
('Budi Santoso', 'budi@email.com', '081234567890'),
('Siti Aminah', 'siti@email.com', '081298765432');

INSERT INTO Pelanggan (nama, email, no_hp) VALUES 
('Bilkis', 'bilkis@email.com', '08208307483');

INSERT INTO Pelanggan (nama, email, no_hp) VALUES 
('Budi juga', 'budia@emil.com', '08208307483');

INSERT INTO Film (kode_film, judul, genre, durasi, rating) VALUES
('F001', 'Avengers: Endgame', 'Action', 181, 'PG-13'),
('F002', 'Joker', 'Drama', 122, 'R');

INSERT INTO Studio (nama_studio, kapasitas) VALUES
('Studio 1', 150),
('Studio 2', 100);

INSERT INTO Jadwal_Film (kode_film, id_studio, tanggal, jam_tayang) VALUES
('F001', 1, '2024-03-25', '18:30:00'),
('F002', 2, '2024-03-25', '20:00:00');

-- Perhatikan id_jadwal dan id_pelanggan
-- id_pelanggan = 1 dan 2; id_jadwal = 1 dan 2
INSERT INTO Tiket (id_pelanggan, id_jadwal, jumlah, total_harga) VALUES 
(1, 1, 2, 100000), 
(2, 2, 3, 150000);

-- Sekarang id_tiket adalah 1 dan 2
INSERT INTO Pembayaran (id_tiket, metode_pembayaran, tanggal_pembayaran, jumlah_bayar) VALUES
(1, 'E-Wallet', '2024-03-25', 100000),
(2, 'Kartu Kredit', '2024-03-26', 150000);


-- Ubah nama pelanggan
UPDATE Pelanggan
SET nama = 'Andi Pratama'
WHERE id_pelanggan = 1;

-- Ubah jadwal film
UPDATE Jadwal_Film
SET jam_tayang = '20:00:00'
WHERE id_jadwal = 1;

-- Ubah jumlah tiket
UPDATE Tiket
SET jumlah = 3, total_harga = 120000
WHERE id_tiket = 1;

-- Ubah nama pelanggan
UPDATE Pelanggan
SET nama = 'Andi Pratama'
WHERE id_pelanggan = 1;

-- Ubah jadwal film
UPDATE Jadwal_Film
SET jam_tayang = '20:00:00'
WHERE id_jadwal = 1;

-- Ubah jumlah tiket
UPDATE Tiket
SET jumlah = 3, total_harga = 120000
WHERE id_tiket = 1;

DROP PROCEDURE IF EXISTS UpdateDataMaster;
DELIMITER $$
CREATE PROCEDURE UpdateDataMaster(IN id INT, IN nilai_baru VARCHAR(255), OUT STATUS VARCHAR(50))
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SET STATUS = 'Gagal';

    UPDATE Pelanggan
    SET nama = nilai_baru
    WHERE id_pelanggan = id;
    
    SET STATUS = 'Berhasil';
END $$

DELIMITER ;
CALL UpdateDataMaster(1, 'Andi Pratama Baru', @status);
SELECT @status;


-- 2. PROCEDURE CountTransaksi: Menghitung total transaksi
-- Parameter: 
--   OUT: p_total (jumlah total transaksi)
-- Fungsi: Menghitung jumlah total entri di tabel transaksi (Tiket)
DELIMITER $$

CREATE PROCEDURE CountTransaksi(OUT jumlah INT)
BEGIN
    SELECT COUNT(*) INTO jumlah
    FROM Tiket;
END $$

DELIMITER ;

CALL CountTransaksi(@jumlah);
SELECT @jumlah;


-- 3. PROCEDURE GetDataMasterByID: Mendapatkan data master berdasarkan ID
-- Parameter: 
--   IN: p_table (nama tabel master), p_id (ID data)
--   OUT: berbagai field data yang akan dikembalikan
-- Fungsi: Mengambil data master berdasarkan ID-nya
DROP PROCEDURE IF EXISTS GetDataMasterByID;
DROP PROCEDURE IF EXISTS GetDataMasterByID;
DELIMITER $$

CREATE PROCEDURE GetDataMasterByID(
    IN id INT,
    OUT nama_pelanggan VARCHAR(100),
    OUT email_out VARCHAR(100),
    OUT no_hp_out VARCHAR(15)
)
BEGIN
    DECLARE v_nama VARCHAR(100);
    DECLARE v_email VARCHAR(100);
    DECLARE v_no_hp VARCHAR(15);
    
    SELECT nama, email, no_hp
    INTO v_nama, v_email, v_no_hp
    FROM Pelanggan
    WHERE id_pelanggan = id;

    SET nama_pelanggan = v_nama;
    SET email_out = v_email;
    SET no_hp_out = v_no_hp;
END $$

DELIMITER ;

CALL GetDataMasterByID(1, @nama, @email, @no_hp);
SELECT @nama, @email, @no_hp;


-- 4. PROCEDURE UpdateFieldTransaksi: Memperbarui field transaksi
-- Parameter: 
--   IN: p_id (ID transaksi/Tiket)
--   INOUT: p_field1 (field pertama untuk update), p_field2 (field kedua untuk update)
-- Fungsi: Memperbarui dua kolom dalam tabel Tiket berdasarkan ID
DROP PROCEDURE IF EXISTS UpdateFieldTransaksi;

DELIMITER $$

CREATE PROCEDURE UpdateFieldTransaksi(IN id INT, INOUT field1 INT, INOUT field2 DECIMAL(10,2))
BEGIN
    IF field1 IS NOT NULL THEN
        UPDATE Tiket
        SET jumlah = field1
        WHERE id_tiket = id;
    END IF;

    IF field2 IS NOT NULL THEN
        UPDATE Tiket
        SET total_harga = field2
        WHERE id_tiket = id;
    END IF;
END $$

DELIMITER ;

SET @field1 = 4, @field2 = 150000;
CALL UpdateFieldTransaksi(1, @field1, @field2);
SELECT @field1, @field2;


-- 5. PROCEDURE DeleteEntriesByIDMaster: Menghapus entri berdasarkan ID master
-- Parameter: 
--   IN: p_table (nama tabel master), p_id (ID data master)
-- Fungsi: Menghapus entri yang terkait dengan ID master (cascade delete)
DROP PROCEDURE IF EXISTS DeleteEntriesByIDMaster;

DELIMITER $$

CREATE PROCEDURE DeleteEntriesByIDMaster(IN id INT)
BEGIN
    DELETE FROM Pelanggan
    WHERE id_pelanggan = id;
END $$

DELIMITER ;
CALL DeleteEntriesByIDMaster(1);
SELECT * FROM pelanggan; 