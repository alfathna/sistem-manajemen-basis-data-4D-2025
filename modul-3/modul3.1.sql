USE sewa_art;

DELIMITER//

CREATE PROCEDURE UpdateDataMaster (
    IN in_id CHAR(10),
    IN in_nama_baru VARCHAR(100),
    OUT out_status VARCHAR(50)
)
BEGIN
    DECLARE affected INT;

    UPDATE Pelanggan
    SET nama = in_nama_baru
    WHERE id_pelanggan = in_id;

    SET affected = ROW_COUNT();

    IF affected > 0 THEN
        SET out_status = 'Berhasil diupdate';
    ELSE
        SET out_status = 'Gagal: ID tidak ditemukan';
    END IF;
END//

DELIMITER ;

CALL UpdateDataMaster(1, 'Andi Nugroho', @status);
SELECT * FROM pelanggan;


DELIMITER//

CREATE PROCEDURE CountTransaksi (
    OUT jumlah_transaksi INT
)
BEGIN
    SELECT COUNT(*) INTO jumlah_transaksi FROM Transaksi;
END//

DELIMITER ;

CALL CountTransaksi(@jumlah);
SELECT @jumlah;


DELIMITER//

CREATE PROCEDURE GetDataMasterByID (
    IN in_id CHAR(10),
    OUT out_nama VARCHAR(100),
    OUT out_alamat TEXT,
    OUT out_telepon VARCHAR(15),
    OUT out_email VARCHAR(100)
)
BEGIN
    SELECT nama, alamat, no_telepon, email
    INTO out_nama, out_alamat, out_telepon, out_email
    FROM Pelanggan
    WHERE id_pelanggan = in_id;
END//

DELIMITER ;

CALL GetDataMasterByID(1, @nama, @alamat, @telepon, @email);
SELECT @nama, @alamat, @telepon, @email;


DELIMITER//

CREATE PROCEDURE UpdateFieldTransaksi (
    IN in_id CHAR(10),
    INOUT inout_tanggal_kembali DATE,
    INOUT inout_total_biaya DECIMAL(12,2)
)
BEGIN
    DECLARE existing_tanggal DATE;
    DECLARE existing_biaya DECIMAL(12,2);

    SELECT tanggal_kembali, total_biaya
    INTO existing_tanggal, existing_biaya
    FROM Transaksi
    WHERE id_transaksi = in_id;

    IF inout_tanggal_kembali IS NULL THEN
        SET inout_tanggal_kembali = existing_tanggal;
    END IF;

    IF inout_total_biaya IS NULL THEN
        SET inout_total_biaya = existing_biaya;
    END IF;

    UPDATE Transaksi
    SET tanggal_kembali = inout_tanggal_kembali,
        total_biaya = inout_total_biaya
    WHERE id_transaksi = in_id;
END//

DELIMITER ;

-- Contoh: hanya ubah total_biaya, tanggal_kembali biarkan tetap
SET @tanggal_kembali = NULL;
SET @total_biaya = 90000;

CALL UpdateFieldTransaksi(1, @tanggal_kembali, @total_biaya);

-- Cek hasil
SELECT * FROM Transaksi WHERE id_transaksi = 1;

-- revisi

DELIMITER//

CREATE PROCEDURE DeleteEntriesByIDMaster (
    IN p_id_pelanggan INT(10)
)
BEGIN
    DELETE FROM Pelanggan
    WHERE id_pelanggan = p_id_pelanggan;
END//

DELIMITER ;

CALL DeleteEntriesByIDMaster(3);

-- Cek hasil
SELECT * FROM Pelanggan;

ALTER TABLE transaksi
ADD CONSTRAINT Tran_sw
FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
ON DELETE CASCADE;


DROP PROCEDURE IF EXISTS DeleteEntriesByIDMaster;