USE umkm_jawa_barat;

-- 1. Menambahkan UMKM Baru
DELIMITER //
CREATE OR REPLACE PROCEDURE AddUMKM (
    IN nama_usaha VARCHAR(100),
    IN jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm (nama_usaha, jumlah_karyawan)
    VALUES (nama_usaha, jumlah_karyawan);
END //
DELIMITER ;
CALL AddUMKM('UMKM Sederhana', 1);
	-- Melihat hasilnya
	SELECT * FROM umkm;
	
-- 2. Mengubah Nama Kategori UMKM
DELIMITER //

CREATE OR REPLACE PROCEDURE UpdateKategoriUMKM (
    IN p_id_kategori INT,
    IN p_nama_baru VARCHAR(100)
)
BEGIN
    UPDATE kategori_umkm
    SET nama_kategori = p_nama_baru
    WHERE id_kategori = p_id_kategori;
END //

DELIMITER ;
CALL UpdateKategoriUMKM(5, 'Agro');
SELECT * FROM kategori_umkm;


	
-- 3. Menghapus Data Pemilik UMKM 
DELIMITER //
CREATE OR REPLACE PROCEDURE hapuspemilik (
    IN pid INT
)
BEGIN
    -- menghapus semua produk yang terkait dengan UMKM yang dimiliki oleh pemilik
    DELETE p FROM produk_umkm p
    JOIN umkm u ON p.id_umkm = u.id_umkm
    WHERE u.id_pemilik = pid;
    -- menghapus semua UMKM yang terkait dengan pemilik
    DELETE FROM umkm WHERE id_pemilik = pid;
    -- menghapus pemiliknya
    DELETE FROM pemilik_umkm WHERE id_pemilik = pid;
END //
DELIMITER ;
CALL hapuspemilik(15);
	-- Lihat hasil
	SELECT * FROM pemilik_umkm;	

-- 4. Menambahkan Produk Baru untuk UMKM
DELIMITER //
CREATE OR REPLACE PROCEDURE AddProduk (
    IN id_umkm INT,
    IN nama_produk VARCHAR(100),
    IN harga INT
)
BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, harga)
    VALUES (id_umkm, nama_produk, harga);
END //
DELIMITER ;
CALL AddProduk(1, 'Kopi Bubuk Arabika', 25000);
SELECT * FROM produk_umkm;
-- 5. Mengambil Data UMKM Berdasarkan ID
DELIMITER //
CREATE OR REPLACE PROCEDURE GetUMKMByID (
    IN id_umkm INT,
    OUT nama_usaha VARCHAR(100),
    OUT jumlah_karyawan INT
)
BEGIN
    SELECT u.nama_usaha, u.jumlah_karyawan
    INTO nama_usaha, jumlah_karyawan
    FROM umkm u
    WHERE u.id_umkm = id_umkm;
END //
DELIMITER ;
	-- Deklarasikan variabel output
	SET @nama = '';
	SET @jumlah = 0;
	-- Panggil prosedurnya
	CALL GetUMKMByID(3, @nama, @jumlah);
	-- Lihat hasilnya
	SELECT @nama AS nama_usaha, @jumlah AS jumlahkaryawan;

USE umkm_jawa_barat;

DESC umkm;