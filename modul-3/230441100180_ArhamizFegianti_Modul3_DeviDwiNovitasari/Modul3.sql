USE praktikum_modul2;

DELIMITER//
CREATE PROCEDURE insert_buku(
IN judulBuku VARCHAR(25),
IN pengarangBuku VARCHAR(30),
IN penerbitBuku VARCHAR(30),
IN tahunBuku VARCHAR(10),
IN jumlahBuku VARCHAR(5),
IN statusBuku VARCHAR(10),
IN klasifikasiBuku VARCHAR(20)
)
BEGIN
INSERT INTO buku(judul_buku, pengarang_buku, penerbit_buku, tahun_buku, jumlah_buku, status_buku, klasifikasi_buku)
VALUES(judulBuku, pengarangBuku, penerbitBuku, tahunBuku, jumlahBuku, statusBuku, klasifikasiBuku);
END//
DELIMITER ;
CALL insert_buku('Manajemen Proyek IT', 'Sarah Manuella' ,'Gramedia', '2024', '10', 'Tersedia', 'Informatics')
CALL insert_buku('Pemrograman Berorientasi Objek', 'Armansyah', 'Gramedia', '2022', '15', 'Tersedia', 'Informatics');

DELIMITER //
CREATE PROCEDURE cari_judul_buku(
IN judulBuku VARCHAR(25)
)
BEGIN
SELECT * FROM buku WHERE judul_buku = judulBuku;
END//
DELIMITER ;
CALL cari_judul_buku('Pemrograman Berorientasi Objek');


DELIMITER //
CREATE PROCEDURE cari_status_buku(
IN statusBuku VARCHAR(10),
IN penerbitBuku VARCHAR(30)
)
BEGIN
SELECT * FROM buku WHERE penerbit_buku = penerbitBuku AND status_buku = statusBuku;
END//
DELIMITER ;
CALL cari_status_buku('Tersedia', 'Gramedia');


DELIMITER //
CREATE PROCEDURE cari_klasifikasi_buku(
IN statusBuku VARCHAR(10),
IN penerbitBuku VARCHAR(30),
IN klasifikasiBuku VARCHAR(20)
)
BEGIN
SELECT * FROM buku WHERE status_buku = statusBuku AND penerbit_buku = penerbitBuku AND klasifikasi_buku = klasifikasiBuku;
END//
DELIMITER ;
CALL cari_klasifikasi_buku('Tersedia', 'Gramedia', 'Informatics');


DELIMITER //
CREATE PROCEDURE insert_anggota(
IN namaAnggota VARCHAR(25),
IN angkatanAnggota VARCHAR(6),
IN tempatLahirAnggota VARCHAR(20),
IN tanggalLahirAnggota DATE,
IN noTelp VARCHAR(20),
IN jKelamin VARCHAR(15),
IN statusPinjam VARCHAR(20)
)
BEGIN
INSERT INTO anggota(nama_anggota, angkatan_anggota, tempat_lahir_anggota, tanggal_lahir_anggota, no_telp, jenis_kelamin, status_pinjam)
VALUES (namaAnggota, angkatanAnggota, tempatLahirAnggota, tanggalLahirAnggota, noTelp, jKelamin, statusPinjam);
END//
DELIMITER ;
CALL insert_anggota('Arhamiz', '2023', 'Nganjuk', '2005-02-26', '085607198136', 'P', 'Aktif');
SELECT * FROM anggota;


DELIMITER //
CREATE PROCEDURE jumlah_anggota(
OUT jumlah INT(11)
)
BEGIN
SELECT COUNT(*) INTO jumlah FROM anggota;
END//
DELIMITER ;
SET @hasiljumlah = 0;
CALL jumlah_anggota(@hasiljumlah);
SELECT @hasiljumlah;


DELIMITER //
CREATE PROCEDURE lihat_judul_buku(
INOUT b_kode_buku VARCHAR(20)
)
BEGIN
SELECT judul_buku INTO b_kode_buku FROM buku WHERE kode_buku = b_kode_buku;
END//
DELIMITER ;
DROP PROCEDURE lihat_judul_buku;
SET @kode = 2;
CALL lihat_judul_buku(@kode);
SELECT @kode;