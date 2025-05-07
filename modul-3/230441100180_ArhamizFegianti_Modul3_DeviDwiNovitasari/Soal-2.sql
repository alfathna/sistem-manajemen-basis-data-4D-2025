USE db_fastfood;

DELIMITER //
CREATE PROCEDURE UpdateDataMaster(
IN id INT(11),
IN nilai_baru VARCHAR(30),
OUT STATUS VARCHAR(30)
)
BEGIN 
DECLARE jumlah INT;
SELECT COUNT(*) INTO jumlah FROM produk WHERE id_produk = id;
IF jumlah > 0 THEN
UPDATE produk SET nama_produk = nilai_baru WHERE id_produk = id;
SET STATUS = 'Berhasil';
ELSE
SET STATUS = 'ID Tidak Ada';
END IF;
END//
DELIMITER ;
CALL UpdateDataMaster(11, 'Cheeseburger', @status_operasi);
SELECT @status_operasi;


DELIMITER //
CREATE PROCEDURE CountTransaksi(
OUT total_transaksi INT
)
BEGIN
SELECT COUNT(*) INTO total_transaksi FROM transaksi;
END//
DELIMITER ;
CALL CountTransaksi (@total_transaksi);
SELECT @total_transaksi;


DELIMITER //
CREATE PROCEDURE GetDataMasterByID(
IN id INT(11),
OUT id_produk INT(11),
OUT nama_produk VARCHAR(50),
OUT harga INT,
OUT id_kategori_menu INT
)
BEGIN
SELECT p.id_produk, p.nama_produk, p.harga, p.id_kategori_menu
INTO id_produk, nama_produk, harga, id_kategori_menu
FROM produk p
WHERE p.id_produk = id;
END//
DELIMITER ;
CALL GetDataMasterByID(11, @id_produk, @nama_produk, @harga, @id_kategori_menu);
SELECT @id_produk AS 'ID Produk', @nama_produk AS 'Nama Produk', @harga AS 'Harga', @id_kategori_menu AS 'ID Kategori Menu';


DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi(
IN id INT(11),
INOUT field1 INT,
INOUT field2 INT
)
BEGIN
DECLARE current_field1 INT;
DECLARE current_field2 INT;
    # Ambil nilai berdasarkan id
SELECT t.total, t.id_pegawai
INTO current_field1, current_field2
FROM transaksi t
WHERE t.id_transaksi = id;

IF field1 IS NOT NULL AND field1 != 0 THEN
UPDATE transaksi
SET total = field1
WHERE id_transaksi = id;
ELSE
SET field1 = current_field1;
END IF;

    -- Jika field2 tidak kosong, update nilai id_pegawai
IF field2 IS NOT NULL AND field2 != 0 THEN
UPDATE transaksi
SET id_pegawai = field2
WHERE id_transaksi = id;
ELSE
SET field2 = current_field2;  -- Kembalikan nilai lama jika field2 kosong
END IF;
END//
DELIMITER ;
SET @field1 = 35000;
SET @field2 = 2;
CALL UpdateFieldTransaksi(5, @field1, @field2);
SELECT @field1 AS 'Updated Total', @field2 AS 'Updated Kasir';


DELIMITER //
CREATE PROCEDURE DeleteEntriesByIDMaster(
IN id INT(11)
)
BEGIN
DELETE FROM transaksi
WHERE id_produk = id;

DELETE FROM produk
WHERE id_produk = id;
END//
DELIMITER ;
CALL DeleteEntriesByIDMaster(11);
SELECT * FROM produk;