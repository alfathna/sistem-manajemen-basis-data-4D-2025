-- Hapus database jika sudah ada
DROP DATABASE IF EXISTS bioskop1;
CREATE DATABASE bioskop1;
USE bioskop1;

-- ============================
-- TABEL UTAMA
-- ============================

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

-- Tabel transaksi utama (sudah dimodifikasi sesuai kebutuhan soal)
CREATE TABLE Tiket (
    id_tiket INT PRIMARY KEY AUTO_INCREMENT,
    id_pelanggan INT,
    id_jadwal INT,
    jumlah INT,
    total_harga DECIMAL(10,2),

    -- Kolom tambahan untuk mendukung prosedur
    status_transaksi VARCHAR(20) DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_valid BOOLEAN DEFAULT TRUE
);

-- Tabel pembayaran
CREATE TABLE Pembayaran (
    id_pembayaran INT PRIMARY KEY AUTO_INCREMENT,
    id_tiket INT,
    metode_pembayaran VARCHAR(50) NOT NULL,
    tanggal_pembayaran DATE NOT NULL,
    jumlah_bayar DECIMAL(10,2) NOT NULL,

    -- Tracking waktu pembayaran
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================
-- RELASI FOREIGN KEY
-- ============================

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

-- ============================
-- DATA AWAL
-- ============================

-- Pelanggan
INSERT INTO Pelanggan (nama, email, no_hp) VALUES 
('Budi Santoso', 'budi@email.com', '081234567890'),
('Siti Aminah', 'siti@email.com', '081298765432'),
('Bilkis', 'bilkis@email.com', '08208307483'),
('Budi juga', 'budia@emil.com', '08208307483');

-- Film
INSERT INTO Film (kode_film, judul, genre, durasi, rating) VALUES
('F001', 'Avengers: Endgame', 'Action', 181, 'PG-13'),
('F002', 'Joker', 'Drama', 122, 'R');

-- Studio
INSERT INTO Studio (nama_studio, kapasitas) VALUES
('Studio 1', 150),
('Studio 2', 100);

-- Jadwal Film
INSERT INTO Jadwal_Film (kode_film, id_studio, tanggal, jam_tayang) VALUES
('F001', 1, '2024-03-25', '18:30:00'),
('F002', 2, '2024-03-25', '20:00:00');

-- Tiket (Transaksi)
INSERT INTO Tiket (id_pelanggan, id_jadwal, jumlah, total_harga, status_transaksi, created_at, is_valid) VALUES 
(1, 1, 2, 100000, 'sukses', '2024-03-25 12:00:00', TRUE), 
(2, 2, 3, 150000, 'sukses', '2024-03-26 15:00:00', TRUE);

-- Pembayaran
INSERT INTO Pembayaran (id_tiket, metode_pembayaran, tanggal_pembayaran, jumlah_bayar, created_at) VALUES
(1, 'E-Wallet', '2024-03-25', 100000, '2024-03-25 12:10:00'),
(2, 'Kartu Kredit', '2024-03-26', 150000, '2024-03-26 15:10:00');

-- Set tanggal transaksi bervariasi untuk testing soal 1 & 6
UPDATE Tiket SET created_at = CURDATE() - INTERVAL 3 DAY WHERE id_tiket = 1;
UPDATE Tiket SET created_at = CURDATE() - INTERVAL 10 DAY WHERE id_tiket = 2;

-- Set status_transaksi agar bisa digunakan di soal 3 dan 5
UPDATE Tiket SET status_transaksi = 'tidak sukses' WHERE id_tiket = 1;
UPDATE Tiket SET status_transaksi = 'berhasil' WHERE id_tiket = 2;

-- Set is_valid agar bisa digunakan di soal 2 dan 4
UPDATE Tiket SET is_valid = 1 WHERE id_tiket IN (1, 2);

-- Tambah tiket lama untuk testing hapus transaksi
INSERT INTO Tiket (id_pelanggan, id_jadwal, jumlah, total_harga, status_transaksi, created_at, is_valid)
VALUES 
(1, 1, 1, 50000, 'berhasil', CURDATE() - INTERVAL 2 YEAR, 1),
(2, 1, 1, 60000, 'berhasil', CURDATE() - INTERVAL 1 YEAR - INTERVAL 1 DAY, 0); -- ini tidak valid, tidak boleh dihapus

INSERT INTO Tiket (id_pelanggan, id_jadwal, jumlah, total_harga, status_transaksi, created_at, is_valid)
VALUES 
(1, 2, 2, 80000, 'pending', CURDATE() - INTERVAL 5 DAY, 1),
(2, 2, 1, 45000, 'gagal', CURDATE() - INTERVAL 2 DAY, 1),
(1, 1, 3, 120000, 'proses', CURDATE() - INTERVAL 3 DAY, 1),
(2, 1, 1, 40000, 'menunggu', CURDATE() - INTERVAL 6 DAY, 1),
(1, 2, 1, 90000, 'pending', CURDATE() - INTERVAL 1 DAY, 1);

INSERT INTO Tiket (id_pelanggan, id_jadwal, jumlah, total_harga, status_transaksi, created_at, is_valid)
VALUES (1, 1, 1, 50000, 'berhasil', CURDATE() - INTERVAL 15 DAY, 1);


UPDATE Tiket SET created_at = CURDATE() - INTERVAL 3 DAY WHERE id_tiket = 1;


UPDATE Tiket SET created_at = CURDATE() - INTERVAL 20 DAY WHERE id_tiket = 5;


UPDATE Tiket SET created_at = CURDATE() - INTERVAL 60 DAY WHERE id_tiket = 6;


UPDATE Tiket SET created_at = CURDATE() - INTERVAL 10 DAY WHERE id_tiket = 7;


UPDATE Tiket SET created_at = CURDATE() - INTERVAL 120 DAY WHERE id_tiket = 8;
        
ALTER TABLE Pelanggan ADD status_transaksi VARCHAR(20) DEFAULT 'belum_transaksi';


-- 1.  Menampilkan transaksi berdasarkan lama waktu (7 hari / 1 bulan / 3 bulan)

DELIMITER //

CREATE PROCEDURE ShowTransaksiByLama(IN periode VARCHAR(20))
BEGIN
    DECLARE rentang DATE;

    IF periode = 'SEMINGGU' THEN
        SET rentang = CURDATE() - INTERVAL 7 DAY;
    ELSEIF periode = '1 BULAN' THEN
        SET rentang = CURDATE() - INTERVAL 1 MONTH;
    ELSEIF periode = '3 BULAN' THEN
        SET rentang = CURDATE() - INTERVAL 3 MONTH;
    END IF;

    SELECT * FROM Tiket
    WHERE created_at >= rentang;
END //

DELIMITER ;

CALL ShowTransaksiByLama('SEMINGGU');
CALL ShowTransaksiByLama('1 BULAN');
CALL ShowTransaksiByLama('3 BULAN');

-- 2. Hapus transaksi lebih dari 1 tahun jika valid
DELIMITER //

CREATE PROCEDURE HapusTransaksiLama()
BEGIN
    DELETE FROM Tiket
    WHERE created_at < CURDATE() - INTERVAL 1 YEAR
      AND is_valid = TRUE;
END //

DELIMITER ;

CALL HapusTransaksiLama();
SELECT * FROM Tiket;  

-- 3 Update status 7 transaksi jadi 'selesai'
DELIMITER //

CREATE PROCEDURE UpdateStatusTransaksi()
BEGIN
    UPDATE Tiket t
    JOIN (
        SELECT id_tiket FROM Tiket LIMIT 7
    ) subquery ON t.id_tiket = subquery.id_tiket
    SET t.status_transaksi = 'selesai';
END //

DELIMITER ;

-- 🔍 Cara pakai:
CALL UpdateStatusTransaksi();
SELECT id_tiket, status_transaksi FROM Tiket;


-- 4. Edit user hanya jika tidak punya transaksi
DELIMITER $$

CREATE PROCEDURE hapus_pelanggan_belum_transaksi()
BEGIN
    -- Menghapus pelanggan dengan status belum_transaksi
    DELETE FROM Pelanggan
    WHERE status_transaksi = 'belum_transaksi';
    
    SELECT 'Pelanggan dengan status belum_transaksi telah dihapus' AS pesan;
END$$

DELIMITER ;
CALL hapus_pelanggan_belum_transaksi();

 
-- no 4 revisi

-- 5 Branching update status berdasarkan jumlah transaksi 1 bulan terakhir
DELIMITER //

CREATE PROCEDURE UpdateStatusBerdasarkanJumlah()
BEGIN
    DECLARE id_min INT DEFAULT NULL;
    DECLARE id_max INT DEFAULT NULL;
    DECLARE id_mid INT DEFAULT NULL;
    DECLARE count_data INT DEFAULT 0;

    -- Ambil id transaksi 1 bulan terakhir
    DROP TEMPORARY TABLE IF EXISTS TempTrans;
    CREATE TEMPORARY TABLE TempTrans AS
    SELECT id_tiket, jumlah FROM Tiket
    WHERE created_at >= CURDATE() - INTERVAL 1 MONTH;

    -- Hitung jumlah data dulu
    SELECT COUNT(*) INTO count_data FROM TempTrans;

    -- Percabangan berdasarkan jumlah data
    IF count_data >= 3 THEN
        -- Ambil id jumlah terkecil (non-aktif)
        SELECT id_tiket INTO id_min FROM TempTrans ORDER BY jumlah ASC LIMIT 1;

        -- Ambil id jumlah terbesar (aktif)
        SELECT id_tiket INTO id_max FROM TempTrans ORDER BY jumlah DESC LIMIT 1;

        -- Ambil id yang bukan min atau max (pasif)
        SELECT id_tiket INTO id_mid FROM TempTrans 
        WHERE id_tiket NOT IN (id_min, id_max) 
        ORDER BY jumlah ASC 
        LIMIT 1;

        -- Update status
        UPDATE Tiket SET status_transaksi = 'non-aktif' WHERE id_tiket = id_min;
        UPDATE Tiket SET status_transaksi = 'aktif' WHERE id_tiket = id_max;
        UPDATE Tiket SET status_transaksi = 'pasif' WHERE id_tiket = id_mid;

    ELSEIF count_data = 2 THEN
        -- Jika hanya ada 2 data, kita tetapkan satu aktif dan satu non-aktif
        SELECT id_tiket INTO id_min FROM TempTrans ORDER BY jumlah ASC LIMIT 1;
        SELECT id_tiket INTO id_max FROM TempTrans ORDER BY jumlah DESC LIMIT 1;

        UPDATE Tiket SET status_transaksi = 'non-aktif' WHERE id_tiket = id_min;
        UPDATE Tiket SET status_transaksi = 'aktif' WHERE id_tiket = id_max;

    ELSEIF count_data = 1 THEN
        -- Jika hanya 1 data, jadikan aktif
        SELECT id_tiket INTO id_max FROM TempTrans LIMIT 1;
        UPDATE Tiket SET status_transaksi = 'aktif' WHERE id_tiket = id_max;

    ELSE
        -- Tidak ada data sama sekali dalam 1 bulan terakhir
        SELECT 'Tidak ada transaksi 1 bulan terakhir' AS info;
    END IF;
END //

DELIMITER ;

SELECT id_tiket, jumlah, status_transaksi FROM Tiket
WHERE created_at >= CURDATE() - INTERVAL 1 MONTH;




-- 🔍 Cara pakai:
CALL UpdateStatusBerdasarkanJumlah();
SELECT id_tiket, jumlah, status_transaksi FROM Tiket;

-- 6 Looping tampilkan jumlah transaksi sukses 1 bulan terakhir

DELIMITER $$

DROP PROCEDURE IF EXISTS HitungTransaksiBerhasil $$
CREATE PROCEDURE HitungTransaksiBerhasil()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_jumlah INT DEFAULT 0;
    DECLARE cur CURSOR FOR 
        SELECT id_tiket FROM Tiket 
        WHERE status_transaksi = 'selesai' 
        AND created_at >= CURDATE() - INTERVAL 1 MONTH;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET v_jumlah = v_jumlah + 1;
    END LOOP;

    CLOSE cur;

    -- Tampilkan hasilnya
    SELECT CONCAT('Jumlah transaksi berhasil dalam 1 bulan terakhir: ', v_jumlah) AS hasil;
END$$

DELIMITER ;

-- Update semua tiket agar status berhasil dan created_at-nya sesuai
UPDATE Tiket
SET status_transaksi = 'selesai',
    created_at = CURDATE()
WHERE id_tiket IN (2,4,8);  -- atau sesuaikan ID-nya

CALL HitungTransaksiBerhasil();
SELECT id_tiket, status_transaksi, created_at
FROM Tiket;
