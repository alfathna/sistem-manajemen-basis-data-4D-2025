USE SistemManajemenKaryawan;
-- =========================

-- =============================================================================== no 1 == before ==
-- before insert --
DELIMITER //
CREATE TRIGGER before_insert_gaji
BEFORE INSERT ON Gaji
FOR EACH ROW
BEGIN
    IF NEW.gaji_pokok < 0 OR NEW.tunjangan < 0 OR NEW.potongan < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gaji, tunjangan, dan potongan tidak boleh bernilai negatif.';
    END IF;
END//
DELIMITER ;

INSERT INTO Gaji (id_karyawan, bulan_gaji, gaji_pokok, tunjangan, potongan)
VALUES (1, '2025-05-01', -10000000, 1000000, 500000);

-- before update --
DELIMITER //
CREATE TRIGGER before_update_status_karyawan
BEFORE UPDATE ON Karyawan
FOR EACH ROW
BEGIN
    IF OLD.STATUS = 'Resign' AND NEW.STATUS = 'Aktif' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tidak bisa mengaktifkan kembali karyawan yang sudah resign.';
    END IF;
END//
DELIMITER ;

UPDATE Karyawan SET STATUS = 'Resign' WHERE id_karyawan = 3;
SELECT * FROM Karyawan;
UPDATE Karyawan SET STATUS = 'Aktif' WHERE id_karyawan = 3;

-- before delete --
DELIMITER //
CREATE TRIGGER before_delete_departemen
BEFORE DELETE ON Departemen
FOR EACH ROW
BEGIN
    DECLARE count_karyawan INT;
    SELECT COUNT(*) INTO count_karyawan FROM Karyawan WHERE id_departemen = OLD.id_departemen;
    
    IF count_karyawan > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Departemen tidak dapat dihapus karena masih digunakan oleh karyawan.';
    END IF;
END//
DELIMITER ;

DELETE FROM Departemen WHERE id_departemen = 1;


-- =============================================================================== no 2 == after ==
-- after insert --
DELIMITER //
CREATE TRIGGER after_insert_absensi
AFTER INSERT ON Absensi
FOR EACH ROW
BEGIN
    INSERT INTO LogAktivitas (aktivitas, waktu) 
    VALUES (CONCAT('Absensi ditambahkan untuk karyawan ID ', NEW.id_karyawan), NOW());
END//
DELIMITER ;

CREATE TABLE LogAktivitas (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    aktivitas TEXT,
    waktu DATETIME
);

INSERT INTO Absensi (id_karyawan, tanggal, jam_masuk, jam_keluar, STATUS)
VALUES (2, '2025-05-14', '08:00:00', '17:00:00', 'Hadir');

SELECT * FROM LogAktivitas ORDER BY waktu DESC;

INSERT INTO Absensi (id_karyawan, tanggal, jam_masuk, jam_keluar, STATUS)
VALUES (1, '2025-05-15', '08:10:00', '17:05:00', 'Hadir');


-- after update --
DELIMITER //
CREATE TRIGGER after_update_jabatan
AFTER UPDATE ON Karyawan
FOR EACH ROW
BEGIN
    IF OLD.id_jabatan <> NEW.id_jabatan THEN
        INSERT INTO LogAktivitas (aktivitas, waktu)
        VALUES (CONCAT('Jabatan karyawan ID ', NEW.id_karyawan, ' diubah dari ', OLD.id_jabatan, ' ke ', NEW.id_jabatan), NOW());
    END IF;
END//
DELIMITER ;

UPDATE Karyawan SET id_jabatan = 2 WHERE id_karyawan = 1;

SELECT * FROM LogAktivitas ORDER BY waktu DESC;

UPDATE Karyawan SET id_jabatan = 1 WHERE id_karyawan = 2;

-- after delete --
DELIMITER //
CREATE TRIGGER after_delete_gaji
AFTER DELETE ON Gaji
FOR EACH ROW
BEGIN
    INSERT INTO LogAktivitas (aktivitas, waktu)
    VALUES (CONCAT('Data gaji untuk karyawan ID ', OLD.id_karyawan, ' pada bulan ', DATE_FORMAT(OLD.bulan_gaji, '%Y-%m'), ' telah dihapus'), NOW());
END//
DELIMITER ;

DELETE FROM Gaji WHERE id_gaji = 1;

SELECT * FROM LogAktivitas ORDER BY waktu DESC;
SELECT * FROM Gaji;

DELETE FROM Gaji WHERE id_gaji = 4;






