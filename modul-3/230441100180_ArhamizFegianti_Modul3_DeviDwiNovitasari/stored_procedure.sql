USE praktikum_modul2;

DELIMITER //
CREATE PROCEDURE insert_petugas(
 IN userName VARCHAR(15),
 IN passworddd VARCHAR(15),
 IN nama_petugas VARCHAR(25)
)
BEGIN
 INSERT INTO petugas(username, passwordd, nama) 
 VALUES (userName, passworddd, nama_petugas);
END//
DELIMITER ;
SELECT * FROM petugas;
DROP PROCEDURE insert_petugas;
CALL insert_petugas('userpetugas6','abcd','Dhea Rahma Dianti');


DELIMITER //
CREATE PROCEDURE jumlah_anggota(
OUT banyak_anggota INT(10)
)
BEGIN
SELECT COUNT(*) INTO banyak_anggota FROM anggota;
END//
DELIMITER ;
CALL jumlah_anggota(@banyak_anggota);
SELECT @banyak_anggota;

DELIMITER //
CREATE PROCEDURE tambah_buku(
IN kodeBuku INT(10),
INOUT jumlahBuku INT(10)
)
BEGIN
SET jumlahBuku = jumlahBuku+4;
UPDATE buku SET jumlah_buku = jumlahBuku WHERE kode_buku = kodeBuku;
END//
DELIMITER ;
SET @jumlahBuku = 3;
CALL tambah_buku(3, @jumlahBuku);
SELECT @jumlahBuku AS jumlah_buku_setelah_ditambah;

DROP PROCEDURE tambah_buku;
#--------------------------------------------------------------------------------#

DELIMITER//
CREATE PROCEDURE tambah_pengembalian(
IN p_id_anggota INT,
IN p_kode_buku INT,
IN p_id_petugas INT,
IN p_tgl_pinjam DATE,
IN p_tgl_kembali DATE,
IN p_denda VARCHAR(15)
)
BEGIN 
INSERT INTO pengembalian (id_anggota, kode_buku, id_petugas, tgl_pinjam, tgl_kembali, denda)
VALUES (p.id_anggota, p.kode_buku, p.id_petugas, p.tgl_pinjam, p.tgl_kembali, p.denda);
END//
DELIMITER;


CREATE VIEW view_total_pinjam_per_anggota AS
SELECT a.nama_anggota AS 'Nama Anggota',
COUNT(p.kode_peminjaman) AS 'Jumlah Peminjaman'
FROM anggota a
LEFT JOIN peminjaman p ON p.id_anggota = a.id_anggota
GROUP BY p.id_anggota = a.id_anggota;
SELECT * FROM view_total_pinjam_per_anggota;