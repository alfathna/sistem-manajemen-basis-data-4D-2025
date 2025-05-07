USE SistemManajemenKaryawan;
-- ================================

-- =================================================== no 1
DELIMITER //
CREATE PROCEDURE GetAbsensiSatuBulan()
BEGIN
    SELECT * FROM Absensi
    WHERE tanggal >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
END //
DELIMITER ;

CALL GetAbsensiSatuBulan();

-- =================================================== no 2

-- INSERT INTO Karyawan (nama_karyawan, jenis_kelamin, tanggal_lahir, id_jabatan, id_departemen, tanggal_masuk, id_kota) 
VALUES('Nadia Ramadhani', 'Perempuan', '1996-08-14', 3, 2, '2022-06-01', 3),
('Rizky Maulana', 'Laki-laki', '1992-10-30', 2, 5, '2021-11-10', 4),
('Dina Aprilia', 'Perempuan', '1995-12-05', 4, 1, '2023-02-15', 6);
INSERT INTO Karyawan (id_karyawan, nama_karyawan, jenis_kelamin, tanggal_lahir, id_jabatan, id_departemen, tanggal_masuk, id_kota)
VALUES (3, 'Agus Wijaya', 'Laki-laki', '1990-05-20', 2, 3, '2019-09-01', 4);
SELECT id_karyawan, nama_karyawan FROM Karyawan; 
-- 

INSERT INTO Gaji (id_karyawan, bulan_gaji, gaji_pokok, tunjangan, potongan) VALUES
(13, '2023-02-01', 6000000, 1000000, 250000);


SELECT * FROM Gaji;
select * from Gaji order by id_gaji asc;

DELIMITER //
CREATE PROCEDURE HapusGajiLama()
BEGIN
    DELETE FROM Gaji
    WHERE bulan_gaji < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
      AND potongan IS NOT NULL;

    SELECT ROW_COUNT() AS jumlah_dihapus;
END //
DELIMITER ;

CALL HapusGajiLama();

-- =================================================== no 3
select * from Absensi;


DELIMITER //
CREATE PROCEDURE UpdateStatusAbsensi()
BEGIN
    UPDATE Absensi
    SET STATUS = 'Izin'
    WHERE STATUS = 'Hadir'
    LIMIT 7;

    SELECT ROW_COUNT() AS jumlah_diubah;
END //
DELIMITER ;

CALL UpdateStatusAbsensi();

-- =================================================== no 4

SELECT k.*
FROM Karyawan k
LEFT JOIN Gaji g ON k.id_karyawan = g.id_karyawan
WHERE g.id_karyawan IS NULL;


DELIMITER //

CREATE PROCEDURE EditDanHapusKaryawanDenganLog(
    IN karyawanId INT,
    IN namaBaru VARCHAR(100)
)
BEGIN
    DECLARE jumlahGaji INT;

    -- Cek apakah karyawan punya gaji
    SELECT COUNT(*) INTO jumlahGaji
    FROM Gaji
    WHERE id_karyawan = karyawanId;

    IF jumlahGaji > 0 THEN
        -- Tidak bisa edit atau hapus
        SELECT 
            karyawanId AS id_karyawan,
            'Karyawan tidak dapat diedit atau dihapus karena memiliki gaji' AS hasil;

    ELSE
        -- Ambil data sebelum diedit/dihapus
        SELECT 
            id_karyawan,
            nama_karyawan AS nama_sebelum_edit
        FROM Karyawan
        WHERE id_karyawan = karyawanId;

        -- Edit nama terlebih dahulu
        UPDATE Karyawan
        SET nama_karyawan = namaBaru
        WHERE id_karyawan = karyawanId;

        -- Konfirmasi nama setelah edit
        SELECT 
            karyawanId AS id_karyawan,
            namaBaru AS nama_setelah_edit,
            'Nama karyawan telah diperbarui' AS status;

        -- Lalu hapus karyawan tersebut
        DELETE FROM Karyawan
        WHERE id_karyawan = karyawanId;

        -- Feedback akhir
        SELECT 
            karyawanId AS id_karyawan,
            'Karyawan berhasil diedit dan dihapus' AS hasil;
    END IF;
END //

DELIMITER ;

CALL EditDanHapusKaryawanDenganLog(3, 'Siti Nurjanah Update');
CALL EditDanHapusKaryawanDenganLog(13, 'Update Nama 13');
CALL EditDanHapusKaryawanDenganLog(15, 'Update Nama 15');


==============================================================
DELIMITER //
CREATE PROCEDURE EditKaryawan(
    IN karyawanId INT,
    IN namaBaru VARCHAR(100)
)
BEGIN
    -- Update nama jika tidak punya gaji
    UPDATE Karyawan
    SET nama_karyawan = namaBaru
    WHERE id_karyawan = karyawanId
      AND NOT EXISTS (
          SELECT 1 FROM Gaji WHERE id_karyawan = karyawanId
      );

    -- Ambil data terbaru dan berikan feedback
    SELECT 
        k.id_karyawan,
        k.nama_karyawan,
        CASE 
            WHEN ROW_COUNT() > 0 THEN 'Nama berhasil diubah'
            ELSE 'Nama tidak diubah (punya gaji atau ID salah)'
        END AS hasil
    FROM Karyawan k
    WHERE k.id_karyawan = karyawanId;
END //
DELIMITER ;

CALL EditKaryawan(2, 'Ani Lestari Update');

select * from Karyawan;

-- =================================================== no 5
DELIMITER //
CREATE PROCEDURE UpdateStatusGaji()
BEGIN
    DECLARE id_trans INT;
    DECLARE total DECIMAL(12,2);

    SELECT id_gaji, (gaji_pokok + tunjangan - potongan)
    INTO id_trans, total
    FROM Gaji
    WHERE bulan_gaji >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    ORDER BY total ASC
    LIMIT 1;

    IF total < 5000000 THEN
        UPDATE Gaji SET STATUS = 'non-aktif' WHERE id_gaji = id_trans;
    ELSEIF total BETWEEN 5000000 AND 9000000 THEN
        UPDATE Gaji SET STATUS = 'pasif' WHERE id_gaji = id_trans;
    ELSE
        UPDATE Gaji SET STATUS = 'aktif' WHERE id_gaji = id_trans;
    END IF;
    
    SELECT * FROM Gaji WHERE id_gaji = id_trans;
END //
DELIMITER ;

CALL UpdateStatusGaji();

-- =================================================== no 6

INSERT INTO Gaji (id_gaji, id_karyawan, bulan_gaji, gaji_pokok, potongan)
VALUES 
  -- (1001, 14, CURDATE(), 5000000, 1000000),  
  (1002, 15, CURDATE(), 6000000, 2000000);  
  
INSERT INTO Karyawan (id_karyawan, nama_karyawan, jenis_kelamin, tanggal_lahir, id_jabatan, id_departemen, tanggal_masuk, id_kota)
VALUES (16, 'Rudi Rudi', 'Laki-laki', '1990-05-20', 2, 3, '2019-09-01', 4);



SELECT * FROM Gaji
WHERE bulan_gaji >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
  AND potongan < (gaji_pokok / 2);




DELIMITER //

CREATE PROCEDURE HitungTransaksiBerhasil_WHILE()
BEGIN
    DECLARE jumlah INT DEFAULT 0;
    DECLARE selesai INT DEFAULT FALSE;
    DECLARE id_saat_ini INT;

    -- Cursor untuk ambil transaksi berhasil
    DECLARE ambil_transaksi 
    CURSOR FOR
        SELECT id_gaji FROM Gaji
        WHERE bulan_gaji >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
          AND potongan < (gaji_pokok / 2);

    -- Penanganan akhir cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET selesai = TRUE;

    -- Buka cursor
    OPEN ambil_transaksi;

    -- WHILE Loop
    FETCH ambil_transaksi INTO id_saat_ini;
    WHILE NOT selesai DO
        SET jumlah = jumlah + 1;

        -- Fetch data berikutnya
        FETCH ambil_transaksi INTO id_saat_ini;
    END WHILE;

    -- Tutup cursor
    CLOSE ambil_transaksi;

    -- Tampilkan hasil
    SELECT jumlah AS jumlah_transaksi_berhasil;
END //

DELIMITER ;

CALL HitungTransaksiBerhasil_WHILE();




=============================================
DELIMITER //
CREATE PROCEDURE HitungTransaksiBerhasil()
BEGIN
    DECLARE jumlah INT DEFAULT 0;
    DECLARE selesai INT DEFAULT FALSE;
    DECLARE id_saat_ini INT;

    DECLARE ambil_transaksi 
    CURSOR FOR
        SELECT id_gaji FROM Gaji
        WHERE bulan_gaji >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
          AND potongan < (gaji_pokok / 2);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET selesai = TRUE;
    OPEN ambil_transaksi;

    baca_loop: LOOP
        FETCH ambil_transaksi INTO id_saat_ini;
        IF selesai THEN
            LEAVE baca_loop;
        END IF;

        SET jumlah = jumlah + 1;
    END LOOP;
    CLOSE ambil_transaksi;

    SELECT jumlah AS transaksi_berhasil;
END //
DELIMITER ;

CALL HitungTransaksiBerhasil();


