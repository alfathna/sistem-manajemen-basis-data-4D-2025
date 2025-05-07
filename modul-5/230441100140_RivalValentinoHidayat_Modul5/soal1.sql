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

ALTER TABLE Reservasi
    ADD CONSTRAINT fk_reservasi_tamu
    FOREIGN KEY (id_tamu) REFERENCES Tamu(id_tamu);

ALTER TABLE Reservasi
    ADD CONSTRAINT fk_reservasi_kamar
    FOREIGN KEY (id_kamar) REFERENCES Kamar(id_kamar);

ALTER TABLE Reservasi
    ADD CONSTRAINT fk_reservasi_pegawai
    FOREIGN KEY (id_pegawai) REFERENCES Pegawai(id_pegawai);

ALTER TABLE Fasilitas
ADD COLUMN id_kamar INT,
ADD CONSTRAINT fk_fasilitas_kamar
FOREIGN KEY (id_kamar) REFERENCES Kamar(id_kamar);


INSERT INTO Tamu (nama_tamu, alamat, no_telepon, email) VALUES
('Indra', 'Jl. Telang No.1', '081234567890', 'indra@mail.com'),
('Abrori', 'Jl. Telang No.2', '081298765432', 'abrori@mail.com'),
('Salsa', 'Jl. Telang No.3', '081322334455', 'salsa@mail.com'),
('Bagas', 'Jl. Telang No.4', '081344556677', 'bagas@mail.com'),
('Aga', 'Jl. Telang No.6', '081344556813', 'aga@mail.com');


INSERT INTO Kamar (nomor_kamar, jenis_kamar, harga_per_malam, STATUS) VALUES
('101', 'Deluxe', 500000, 'tersedia'),
('102', 'Superior', 400000, 'tersedia'),
('201', 'Suite', 800000, 'tersedia'),
('103', 'Standard', 300000, 'tersedia'),
('202', 'Suite', 850000, 'terisi');


INSERT INTO Pegawai (nama_pegawai, jabatan, shift) VALUES
('Rival', 'Resepsionis', 'Pagi'),
('Tanji', 'Manager', 'Malam'),
('Dina', 'Housekeeping', 'Siang'),
('Abrori', 'Security', 'Malam');

INSERT INTO Fasilitas (nama_fasilitas, deskripsi, id_kamar) VALUES
('Kolam Renang', 'Kolam renang outdoor untuk dewasa dan anak-anak', 1),
('Gym', 'Tempat fitness lengkap dengan alat-alat olahraga', 1),
('WiFi', 'Akses internet gratis', 2),
('AC', 'Pendingin udara ruangan', 2),
('TV', 'TV LED 32 inch', 3),
('Bathtub', 'Bathtub dengan air panas', 5);

INSERT INTO Reservasi (id_tamu, id_kamar, id_pegawai, tanggal_checkin, tanggal_checkout, total_harga, STATUS) VALUES
(1, 1, 1, '2025-04-04', '2025-05-12', 1000000, 'aktif'),
(2, 2, 2, '2024-01-11', '2025-04-13', 800000, 'batal'),
(3, 3, 3, '2025-03-09', '2025-04-10', 800000, 'selesai'),
(4, 4, 4, '2022-04-05', '2022-04-08', 900000, 'batal'),
(1, 5, 1, '2022-04-01', '2023-04-04', 2550000, 'selesai'),
(2, 3, 1, '2025-05-01', '2025-05-03', 1600000, 'selesai'),
(3, 4, 2, '2025-05-05', '2025-05-07', 600000, 'aktif'),
(4, 1, 3, '2025-05-02', '2025-05-12', 1000000, 'aktif'),
(1, 2, 4, '2025-05-02', '2025-05-17', 800000, 'aktif'),
(2, 3, 1, '2025-05-02', '2025-05-22', 1600000, 'aktif'),
(3, 4, 2, '2025-05-03', '2025-05-27', 600000, 'aktif'),
(4, 5, 3, '2025-05-01', '2025-06-02', 2550000, 'aktif');


-- 1
DELIMITER //
CREATE PROCEDURE tampil_reservasi_berdasarkan_lama(
    IN pilihan VARCHAR(20)
)
BEGIN
    DECLARE batas_tanggal DATE;

    IF pilihan = 'SEMINGGU' THEN
        SET batas_tanggal = CURDATE() - INTERVAL 7 DAY;
    ELSEIF pilihan = '1 BULAN' THEN
        SET batas_tanggal = CURDATE() - INTERVAL 1 MONTH;
    ELSEIF pilihan = '3 BULAN' THEN
        SET batas_tanggal = CURDATE() - INTERVAL 3 MONTH;
    END IF;

    SELECT * FROM Reservasi
    WHERE tanggal_checkin >= batas_tanggal;
END //
DELIMITER ;


-- 2
DELIMITER //
CREATE PROCEDURE hapus_reservasi_lama()
BEGIN
    DELETE FROM Reservasi
    WHERE tanggal_checkout < CURDATE() - INTERVAL 1 YEAR
    AND STATUS IN ('selesai', 'batal');
END //
DELIMITER ;


-- 3
DELIMITER //
CREATE PROCEDURE ubah_status_reservasi()
BEGIN
    UPDATE Reservasi
    SET STATUS = 'dikonfirmasi'
    WHERE STATUS = 'aktif'
    LIMIT 11;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE edit_tamu(
    IN pid_tamu INT,
    IN pnama_tamu VARCHAR(100),
    IN palamat VARCHAR(255),
    IN ptelepon VARCHAR(15),
    IN pemail VARCHAR(100),
    IN paction VARCHAR(10) -- Menambahkan parameter untuk menentukan aksi (edit/hapus)
)
BEGIN
    DECLARE jumlah INT;

    -- Mengecek apakah tamu telah melakukan reservasi
    SELECT COUNT(*) INTO jumlah
    FROM Reservasi
    WHERE id_tamu = pid_tamu;

    IF paction = 'edit' THEN
        IF jumlah > 0 THEN
            -- Update jika tamu sudah melakukan reservasi
            UPDATE Tamu
            SET nama_tamu = pnama_tamu,
                alamat = palamat,
                no_telepon = ptelepon,
                email = pemail
            WHERE id_tamu = pid_tamu;
        END IF;
    ELSEIF paction = 'hapus' THEN
        IF jumlah = 0 THEN
            -- Hapus tamu yang belum melakukan reservasi
            DELETE FROM Tamu WHERE id_tamu = pid_tamu;
        END IF;
    END IF;
END //
DELIMITER ;



-- 5
DELIMITER //
CREATE PROCEDURE update_status_transaksi_bulanan()
BEGIN
    DECLARE id_kecil INT;
    DECLARE id_besar INT;
    DECLARE id_tengah INT;

    -- Buat temporary table untuk menyimpan transaksi 1 bulan terakhir
    DROP TEMPORARY TABLE IF EXISTS transaksi_bulan_terakhir;
    CREATE TEMPORARY TABLE transaksi_bulan_terakhir AS
    SELECT id_reservasi, total_harga
    FROM Reservasi
    WHERE MONTH(tanggal_checkin) = MONTH(CURDATE())
      AND YEAR(tanggal_checkin) = YEAR(CURDATE());

    -- Ambil ID dengan total harga paling kecil
    SELECT id_reservasi INTO id_kecil
    FROM transaksi_bulan_terakhir
    ORDER BY total_harga ASC
    LIMIT 1;

    -- Ambil ID dengan total harga paling besar
    SELECT id_reservasi INTO id_besar
    FROM transaksi_bulan_terakhir
    ORDER BY total_harga DESC
    LIMIT 1;

    -- Ambil ID transaksi tengah jika ada lebih dari 2 transaksi
    IF (SELECT COUNT(*) FROM transaksi_bulan_terakhir) > 2 THEN
        SELECT id_reservasi INTO id_tengah
        FROM transaksi_bulan_terakhir
        ORDER BY total_harga ASC
        LIMIT 1 OFFSET 1;
    ELSE
        SET id_tengah = NULL;
    END IF;

    -- Update status
    UPDATE Reservasi SET STATUS = 'non-aktif' WHERE id_reservasi = id_kecil;
    UPDATE Reservasi SET STATUS = 'aktif' WHERE id_reservasi = id_besar;

    IF id_tengah IS NOT NULL THEN
        UPDATE Reservasi SET STATUS = 'pasif' WHERE id_reservasi = id_tengah;
    END IF;
END//

DELIMITER ;


-- 6
DELIMITER //

CREATE PROCEDURE hitung_reservasi_berhasil()
BEGIN
    DECLARE total INT DEFAULT 0;
    DECLARE i INT DEFAULT 0;
    DECLARE jumlah INT;
    
    -- Buat temporary table berisi ID reservasi sesuai kriteria
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_reservasi AS
    SELECT id_reservasi 
    FROM Reservasi 
    WHERE tanggal_checkout >= CURDATE() - INTERVAL 1 MONTH
    AND STATUS = 'selesai';

    -- Ambil jumlah baris dari temp table
    SELECT COUNT(*) INTO jumlah FROM temp_reservasi;

    -- Loop sebanyak jumlah baris
    WHILE i < jumlah DO
        SET total = total + 1;
        SET i = i + 1;
    END WHILE;

    -- Tampilkan hasil
    SELECT total AS jumlah_transaksi_selesai;

    -- Hapus temp table
    DROP TEMPORARY TABLE IF EXISTS temp_reservasi;
END //

DELIMITER ;



CALL tampil_reservasi_berdasarkan_lama('SEMINGGU');

CALL hapus_reservasi_lama();
SELECT * FROM Reservasi; 

CALL ubah_status_reservasi();
SELECT * FROM Reservasi;  

CALL edit_tamu(5, 'agi gg', 'Jl. Baru No.8', '071234567680', 'agi88@mail.com');
CALL edit_tamu(5, '', '', '', '', 'hapus');

SELECT * FROM Tamu;      

CALL update_status_transaksi_bulanan();
SELECT * FROM Reservasi; 

CALL hitung_reservasi_berhasil(); 

DROP DATABASE reservasi_hotel;