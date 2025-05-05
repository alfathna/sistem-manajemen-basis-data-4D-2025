USE SistemManajemenKaryawan;
SHOW TABLES;
===================================

-- no 1
DELIMITER //
CREATE PROCEDURE UpdateDataMaster(IN id INT, IN nilai_baru VARCHAR(255), OUT STATUS VARCHAR(50))
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SET STATUS = 'Gagal';
    UPDATE Karyawan
    SET nama_karyawan = nilai_baru
    WHERE id_karyawan = id;
    
    SET STATUS = 'Berhasil';
END //
DELIMITER ;
CALL UpdateDataMaster(1, 'Andi Pratama Baru', @status);
SELECT @status AS status_update;

SELECT * FROM Karyawan;
-- DROP PROCEDURE IF EXISTS UpdateDataMaster;


-- no 2
DELIMITER //
CREATE PROCEDURE CountTransaksi (
    OUT total_transaksi INT
)
BEGIN
    SELECT COUNT(*) INTO total_transaksi FROM Gaji;
END //
DELIMITER ;
=====
CALL CountTransaksi(@total);
SELECT @total AS total_transaksi;
=====

-- no 3
DELIMITER //
CREATE PROCEDURE GetDataMasterByID (
    IN p_id INT,
    OUT p_nama_karyawan VARCHAR(100),
    OUT p_status VARCHAR(20)
)
BEGIN
    DECLARE v_exists INT;
    SELECT COUNT(*) INTO v_exists FROM Karyawan WHERE id_karyawan = p_id;
    IF v_exists = 1 THEN
        SELECT nama_karyawan, STATUS INTO p_nama_karyawan, p_status
        FROM Karyawan WHERE id_karyawan = p_id;
    ELSE
        SET p_nama_karyawan = NULL;
        SET p_status = 'Tidak ditemukan';
    END IF;
END //
DELIMITER ;
=====
CALL GetDataMasterByID(2, @nama_karyawan, @status_karyawan);
SELECT @nama_karyawan AS nama, @status_karyawan AS STATUS;
=====

-- no 4
DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi (
    IN p_id INT,
    INOUT p_gaji_pokok DECIMAL(12,2),
    INOUT p_tunjangan DECIMAL(12,2)
)
BEGIN
    DECLARE v_gaji DECIMAL(12,2);
    DECLARE v_tunj DECIMAL(12,2);    
    SELECT gaji_pokok, tunjangan INTO v_gaji, v_tunj
    FROM Gaji WHERE id_gaji = p_id;
    IF p_gaji_pokok IS NULL THEN
        SET p_gaji_pokok = v_gaji;
    END IF;
    IF p_tunjangan IS NULL THEN
        SET p_tunjangan = v_tunj;
    END IF;
    UPDATE Gaji
    SET gaji_pokok = p_gaji_pokok, tunjangan = p_tunjangan
    WHERE id_gaji = p_id;
END //
DELIMITER ;
=====
SET @gaji := 9000000;
SET @tunj := NULL;  -- tidak mengubah yang lama

CALL UpdateFieldTransaksi(1, @gaji, @tunj);

-- Lihat nilai 
SELECT @gaji AS gaji_baru, @tunj AS tunjangan_baru;

-- Cek 
SELECT * FROM Gaji WHERE id_gaji = 1;
=====

-- no 5
DELIMITER //
CREATE PROCEDURE DeleteEntriesByIDMaster (
    IN p_id INT
)
BEGIN
    DELETE FROM Absensi WHERE id_karyawan = p_id;
    DELETE FROM Gaji WHERE id_karyawan = p_id;
    DELETE FROM Karyawan WHERE id_karyawan = p_id;
END //
DELIMITER ;
=====
CALL DeleteEntriesByIDMaster(3);

-- Cek 
SELECT * FROM Karyawan WHERE id_karyawan = 3;
SELECT * FROM Gaji WHERE id_karyawan = 3;
SELECT * FROM Absensi WHERE id_karyawan = 3;

SELECT * FROM Karyawan;
-- ALTER TABLE Karyawan
-- ADD COLUMN STATUS VARCHAR(20) DEFAULT 'Aktif'; -- 

-- INSERT INTO Karyawan (
   -- id_karyawan, nama_karyawan, jenis_kelamin, tanggal_lahir,
   -- id_jabatan, id_departemen, tanggal_masuk, STATUS
-- )
-- VALUES (
   -- 3, 'Tono Prasetyo', 'Laki-laki', '1988-11-03',
   -- 2, 3, '2018-08-10', 'Resign'
-- );;

-- INSERT INTO Gaji (
   -- id_karyawan, bulan_gaji, gaji_pokok, tunjangan, potongan
-- )
-- VALUES (
   -- 3, '2025-03-01', 8000000, 1500000, 300000
-- );

-- INSERT INTO Absensi (
   -- id_karyawan, tanggal, jam_masuk, jam_keluar, STATUS
-- )
-- VALUES (
   -- 3, '2025-04-01', NULL, NULL, 'Alpha'
-- );

=====
	















