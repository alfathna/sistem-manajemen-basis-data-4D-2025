USE modul2;

DELIMITER//

CREATE PROCEDURE AddUMKM (
    IN nama_usaha VARCHAR(100),
    IN jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm (nama_usaha, jumlah_karyawan)
    VALUES (nama_usaha, jumlah_karyawan);
END//

DELIMITER ;

CALL AddUMKM('Toko Maju Jaya', 12);
SELECT * FROM umkm;

DELIMITER //

CREATE PROCEDURE UpdateKategoriUMKM (
    IN p_id_kategori INT,
    IN p_nama_baru VARCHAR(100)
)
BEGIN
    UPDATE kategori_umkm
    SET nama_kategori = p_nama_baru
    WHERE id_kategori = p_id_kategori;
END//

DELIMITER ;


CALL UpdateKategoriUMKM(3, 'Makanan Modern');

SELECT * FROM kategori_umkm;


DELIMITER//

CREATE PROCEDURE DeletePemilikUMKM (
    IN p_id_pemilik INT
)
BEGIN
    DELETE FROM pemilik_umkm
    WHERE id_pemilik = p_id_pemilik;
END//

DELIMITER ;

CALL DeletePemilikUMKM(5);
SELECT * FROM pemilik_umkm;


DELIMITER//

CREATE PROCEDURE AddProduk (
    IN id_umkm INT,
    IN nama_produk VARCHAR(100),
    IN harga DECIMAL(12,2)
)
BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, harga)
    VALUES (id_umkm, nama_produk, harga);
END//

DELIMITER ;

CALL AddProduk(12, 'Kentang goreng', 12000);
SELECT * FROM produk_umkm;

DELIMITER//

CREATE PROCEDURE GetUMKMByID (
    IN id_umkm_input INT,
    OUT nama_usaha_output VARCHAR(100)
)
BEGIN
    SELECT nama_usaha
    INTO nama_usaha_output
    FROM umkm
    WHERE id_umkm = id_umkm_input;
END//

DELIMITER ;

SET @nama_usaha = '';
SET @jumlah_karyawan = 0;

CALL GetUMKMByID(6, @nama_usaha, @jumlah_karyawan);

SELECT @nama_usaha AS nama_usaha, @jumlah_karyawan AS jumlah_karyawan;
SELECT * FROM umkm;

