USE umkm_jawa_barat;

DELIMITER //
CREATE PROCEDURE AddUMKM(
IN nama_usaha VARCHAR(255),
IN jumlah_karyawan INT
)
BEGIN
INSERT INTO umkm (nama_usaha, jumlah_karyawan)
VALUES (nama_usaha, jumlah_karyawan);
END //
DELIMITER ;
CALL AddUMKM('Rental Mobil', 20);
DROP PROCEDURE AddUMKM;
SELECT * FROM umkm;


DELIMITER //
CREATE PROCEDURE UpdateKategoriUMKM(
IN idKategori INT(11),
IN namaBaru VARCHAR(100)
)
BEGIN
UPDATE kategori_umkm SET nama_kategori = namaBaru WHERE id_kategori = idKategori;
END//
DELIMITER ;
CALL UpdateKategoriUMKM(2, 'Fashion');
SELECT * FROM kategori_umkm;


DELIMITER //
CREATE PROCEDURE DeletePemilikUMKM(
IN idPemilik INT(11)
)
BEGIN
DELETE FROM pemilik_umkm WHERE id_pemilik = idPemilik;
END//
DELIMITER ;
CALL DeletePemilikUMKM(16);
SELECT * FROM pemilik_umkm;


DELIMITER //
CREATE PROCEDURE AddProduk(
IN idUMKM INT(11),
IN namaProduk VARCHAR(200),
IN Harga DECIMAL(15,2)
)
BEGIN
INSERT INTO produk_umkm (id_umkm, nama_produk, harga)
VALUES (idUMKM, namaProduk, Harga);
END//
DELIMITER ;
CALL AddProduk(2, 'Bebek Goreng Sinjay', 20000);
SELECT * FROM produk_umkm;


DELIMITER //
CREATE PROCEDURE GetUMKMByID(
IN idUMKM INT(11),
OUT namaUsaha VARCHAR(200),
OUT tahunBerdiri YEAR(4)
)
BEGIN
SELECT nama_usaha, tahun_berdiri INTO namaUsaha, tahunBerdiri FROM umkm WHERE id_umkm = idUMKM;
END//
DELIMITER ;
SET @nama_usaha = 'Bebek Goreng Sinjay';
SET @tahun_berdiri = 2020;
CALL GetUMKMByID(2, @nama_usaha, @tahun_berdiri);
SELECT @nama_usaha, @tahun_berdiri;
SELECT * FROM umkm;

