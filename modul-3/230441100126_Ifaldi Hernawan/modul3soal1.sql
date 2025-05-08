USE modul2;

-- soal1
DELIMITER //
CREATE PROCEDURE AddUMKM(
	IN nama_usaha VARCHAR(20),
	IN jumlah_karyawan INT
)
BEGIN
	INSERT INTO umkm(nama_usaha, jumlah_karyawan)
	VALUES (nama_usaha, jumlah_karyawan);
END//
DELIMITER ;

CALL AddUMKM('Toko perlengkapan', 11);
SELECT * FROM umkm;


-- soal2 revisi
DELIMITER //
CREATE PROCEDURE UpdateKategoriUMKM(
  IN p_id_kategori INT,
  IN p_nama_baru VARCHAR(50)
)
BEGIN 
  UPDATE kategori_umkm
  SET nama_kategori = p_nama_baru
  WHERE id_kategori = p_id_kategori;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS UpdateKategoriUMKM;

CALL UpdateKategoriUMKM(1, 'makanan ringan');
SELECT * FROM kategori_umkm;

-- soal3
DELIMITER //
CREATE PROCEDURE DeletePemilikUMKM(
    IN p_id_pemilik INT
)
BEGIN
    DELETE FROM pemilik_umkm
    WHERE id_pemilik = p_id_pemilik;
END //
DELIMITER ;


CALL DeletePemilikUMKM (13);
SELECT * FROM pemilik_umkm;
DELETE FROM pemilik_umkm WHERE id_pemilik = 1;

-- soal4
DELIMITER//
CREATE PROCEDURE AddProduk(
	IN p_id_umkm INT,
	IN p_nama_produk VARCHAR(50),
	IN p_harga INT
)
BEGIN
INSERT INTO produk_umkm(id_umkm, nama_produk, harga)
VALUES (p_id_umkm, p_nama_produk, p_harga);
END//
DELIMITER;

CALL AddProduk(16, 'Keripik jagung', 15000);
SELECT * FROM produk_umkm;

-- soal5
DELIMITER//
CREATE PROCEDURE GetUMKMByID(
	IN p_id_umkm INT,
	OUT p_nama_usaha VARCHAR(50),
	OUT p_jumlah_karyawan INT
	)
BEGIN
	SELECT nama_usaha, jumlah_karyawan
	INTO p_nama_usaha, p_jumlah_karyawan
	FROM umkm
	WHERE id_umkm = p_id_umkm;
END//
DELIMITER ;

-- 1. Deklarasi variabel untuk menerima output
SET @nama_usaha = '';
SET @jumlah_karyawan = 0;

-- 2. Panggil prosedurnya dengan parameter input dan output
CALL GetUMKMByID(6, @nama_usaha, @jumlah_karyawan);

-- 3. Tampilkan hasil output
SELECT @nama_usaha AS nama_usaha, @jumlah_karyawan AS jumlah_karyawan;
SELECT * FROM umkm;
