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
SELECT * FROM tamu;

-- 1
DELIMITER //
CREATE PROCEDURE UpdateDataMaster (
    IN p_id INT,
    IN p_nilai_baru VARCHAR(100),
    OUT p_status VARCHAR(50)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_status = 'Gagal';
    END;

    UPDATE Pegawai
    SET nama_pegawai = p_nilai_baru
    WHERE id_pegawai = p_id;

    SET p_status = 'Berhasil';
END;
//
DELIMITER ;

-- 2
DELIMITER //
CREATE PROCEDURE CountTransaksi (
    OUT p_jumlah INT
)
BEGIN
    SELECT COUNT(*) INTO p_jumlah FROM Reservasi;
END;
//
DELIMITER ;

-- 3
DELIMITER //
CREATE PROCEDURE GetDataMasterByID (
    IN p_id INT,
    OUT p_nama_pegawai VARCHAR(100),
    OUT p_jabatan VARCHAR(50),
    OUT p_shift VARCHAR(20)
)
BEGIN
    SELECT nama_pegawai, jabatan, shift
    INTO p_nama_pegawai, p_jabatan, p_shift
    FROM Pegawai
    WHERE id_pegawai = p_id;
END;
//
DELIMITER ;

-- 4
DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi (
    IN p_id INT,
    INOUT p_checkin DATE,
    INOUT p_status VARCHAR(20)
)
BEGIN
    DECLARE v_checkin DATE;
    DECLARE v_status VARCHAR(20);

    SELECT tanggal_checkin, STATUS
    INTO v_checkin, v_status
    FROM Reservasi
    WHERE id_reservasi = p_id;

    IF p_checkin IS NULL THEN
        SET p_checkin = v_checkin;
    END IF;

    IF p_status IS NULL THEN
        SET p_status = v_status;
    END IF;

    UPDATE Reservasi
    SET tanggal_checkin = p_checkin, STATUS = p_status
    WHERE id_reservasi = p_id;
END;
//
DELIMITER ;

-- 5
DELIMITER //
CREATE PROCEDURE DeleteEntriesByIDMaster (
    IN p_id INT
)
BEGIN
    DELETE FROM Pegawai WHERE id_pegawai = p_id;
END;
//
DELIMITER ;

-- 1. Memanggil prosedur UpdateDataMaster
CALL UpdateDataMaster(1, 'Budi Santoso', @status);
SELECT @status;

-- 2. Memanggil prosedur CountTransaksi
CALL CountTransaksi(@jumlah);
SELECT @jumlah;

-- 3. Memanggil prosedur GetDataMasterByID
CALL GetDataMasterByID(1, @nama_pegawai, @jabatan, @shift);
SELECT @nama_pegawai, @jabatan, @shift;

-- 4. Memanggil prosedur UpdateFieldTransaksi
SET @checkin = NULL;
SET @status = NULL;
CALL UpdateFieldTransaksi(10, @checkin, @status);
SELECT @checkin, @status;

-- 5. Memanggil prosedur DeleteEntriesByIDMaster
DELETE FROM Reservasi WHERE id_pegawai = 1;
CALL DeleteEntriesByIDMaster(1);

DROP DATABASE reservasi_hotel;