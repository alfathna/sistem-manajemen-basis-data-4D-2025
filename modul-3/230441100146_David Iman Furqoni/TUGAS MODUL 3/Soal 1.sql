USE db_umkm;
SHOW TABLES;
=====================
-- no 1
DELIMITER //
CREATE PROCEDURE AddUMKM (
    IN p_nama_usaha VARCHAR(200),
    IN p_jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm (nama_usaha, jumlah_karyawan, tanggal_registrasi)
    VALUES (p_nama_usaha, p_jumlah_karyawan, CURDATE());
END //
DELIMITER ;
=====
CALL AddUMKM('Toko Maju Jaya', 10);			-- DELETE FROM umkm WHERE id_umkm = 17;
SELECT * FROM umkm;

=====
-- no 2
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
=====
CALL UpdateKategoriUMKM(2, 'Fashionn');
CALL UpdateKategoriUMKM(10, "Teknologi Modern");
SELECT * FROM kategori_umkm;

=====
-- no 3
DELIMITER //
CREATE PROCEDURE DeletePemilikUMKM (
    IN p_id_pemilik INT
)
BEGIN
    DELETE FROM pemilik_umkm
    WHERE id_pemilik = p_id_pemilik;
END//
DELIMITER ;
=====
CALL DeletePemilikUMKM(5);


-- DELETE FROM produk_umkm WHERE id_umkm IN (SELECT id_umkm FROM umkm WHERE id_pemilik = 5);
-- DELETE FROM umkm WHERE id_pemilik = 5;
-- INSERT INTO pemilik_umkm (
   --  id_pemilik, nik, nama_lengkap, jenis_kelamin, alamat, nomor_telepon, email
-- ) VALUES (
   --  5, '3275021203830005', 'Joko Widodo', 'Laki-laki', 'Jl. Cendana No. 34, Bekasi', '089012345678', 'joko.widodo@gmail.com'
-- );


SELECT * FROM pemilik_umkm;

=====
-- no 4
DELIMITER //
CREATE PROCEDURE AddProduk (
    IN p_id_umkm INT,
    IN p_nama_produk VARCHAR(200),
    IN p_harga DECIMAL(15,2)
)
BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, harga)
    VALUES (p_id_umkm, p_nama_produk, p_harga);
END//
DELIMITER ;
=====
CALL AddProduk(1, 'Keripik Singkong', 15000.00);
SELECT * FROM produk_umkm;

======
-- no 5
DELIMITER //
CREATE PROCEDURE GetUMKMByID (
    IN p_id_umkm INT
)
BEGIN
    SELECT * FROM umkm
    WHERE id_umkm = p_id_umkm;
END//
DELIMITER ;
=====
CALL GetUMKMByID(15);






