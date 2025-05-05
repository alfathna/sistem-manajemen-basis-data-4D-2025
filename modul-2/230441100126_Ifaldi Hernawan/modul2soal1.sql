CREATE DATABASE modul2;
USE modul2;

CREATE TABLE produk_umkm(
id_produk INT(11) NOT NULL AUTO_INCREMENT,
id_umkm INT(11) NOT NULL,
nama_produk VARCHAR(200) NOT NULL,
deskripsi_produk TEXT,
harga DECIMAL(15,2),
PRIMARY KEY(id_produk)
);

CREATE TABLE pemilik_umkm(
id_pemilik INT(11) NOT NULL AUTO_INCREMENT,
nik VARCHAR(16) NOT NULL,
nama_lengkap VARCHAR(200) NOT NULL,
jenis_kelamin ENUM('laki-laki','perempuan') NOT NULL,
alamat TEXT NOT NULL,
nomor_telepon VARCHAR(15) NOT NULL,
email VARCHAR(100) NOT NULL,
PRIMARY KEY(id_pemilik)
);

CREATE TABLE kategori_umkm(
id_kategori INT(11) NOT NULL AUTO_INCREMENT,
nama_kategori VARCHAR(100) NOT NULL,
deskripsi TEXT,
PRIMARY KEY(id_kategori)
);

CREATE TABLE skala_umkm (
id_skala INT(11) NOT NULL AUTO_INCREMENT,
    nama_skala VARCHAR(50) NOT NULL,
    batas_aset_bawah DECIMAL(15,2),
    batas_aset_atas DECIMAL(15,2),
    batas_omzet_bawah DECIMAL(15,2),
    batas_omzet_atas DECIMAL(15,2),
    PRIMARY KEY(id_skala)
);

CREATE TABLE kabupaten_kota(
id_kabupaten_kota INT(11) NOT NULL AUTO_INCREMENT,
nama_kabupaten_kota VARCHAR(100),
PRIMARY KEY(id_kabupaten_kota)
);

CREATE TABLE umkm(
id_umkm INT (11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
nama_usaha VARCHAR (200) NOT NULL,
id_pemilik INT (11),
id_kategori INT (11),
id_skala INT (11),
id_kabupaten_kota INT (11),
alamat_usaha TEXT,
nib VARCHAR (50),
npwp VARCHAR (20),
tahun_berdiri YEAR (4),
jumlah_karyawan INT (11),
total_aset DECIMAL (15,2),
omzet_per_tahun DECIMAL (15,2),
deskripsi_usaha TEXT,
tanggal_registrasi DATE
);

ALTER TABLE produk_umkm ADD CONSTRAINT fk_pu_umkm FOREIGN KEY (id_umkm) REFERENCES umkm(id_umkm);
ALTER TABLE umkm ADD CONSTRAINT fk_pemilik_umkm FOREIGN KEY (id_pemilik) REFERENCES pemilik_umkm(id_pemilik);
ALTER TABLE umkm ADD CONSTRAINT fk_kategori_umkm FOREIGN KEY (id_kategori) REFERENCES kategori_umkm(id_kategori);
ALTER TABLE umkm ADD CONSTRAINT fk_skala_umkm FOREIGN KEY(id_skala) REFERENCES skala_umkm(id_skala);
ALTER TABLE umkm ADD CONSTRAINT fk_kabupaten_umkm FOREIGN KEY (id_kabupaten_kota) REFERENCES kabupaten_kota(id_kabupaten_kota);

ALTER TABLE umkm
DROP FOREIGN KEY fk_pemilik_umkm;

ALTER TABLE produk_umkm
DROP FOREIGN KEY fk_pu_umkm;

ALTER TABLE produk_umkm
ADD CONSTRAINT fk_pu_umkm
FOREIGN KEY (id_umkm) REFERENCES umkm(id_umkm)
ON DELETE CASCADE;

ALTER TABLE umkm
ADD CONSTRAINT fk_pemilik_umkm
FOREIGN KEY (id_pemilik) REFERENCES pemilik_umkm(id_pemilik)
ON DELETE CASCADE;

SELECT * FROM kabupaten_kota;
SELECT * FROM kategori_umkm;
SELECT * FROM pemilik_umkm;
SELECT * FROM produk_umkm;
SELECT * FROM skala_umkm;
SELECT * FROM umkm;


CREATE VIEW view_umkm_detail AS
SELECT
  u.nama_usaha,
  u.id_pemilik,
  k.nama_kategori AS kategori_umkm,
  s.nama_skala AS skala_usaha,
  kab.nama_kabupaten_kota AS kabupaten_kota,
  u.tahun_berdiri
FROM umkm u
JOIN kategori_umkm k ON k.id_kategori = u.id_kategori
JOIN skala_umkm s ON s.id_skala = u.id_skala
JOIN kabupaten_kota kab ON kab.id_kabupaten_kota = u.id_kabupaten_kota;

CREATE VIEW view_pemilik_dan_usaha AS
SELECT 
  p.nik,
  p.nama_lengkap,
  p.jenis_kelamin,
  p.nomor_telepon,
  p.email,
  u.nama_usaha
FROM pemilik_umkm p
JOIN umkm u ON p.id_pemilik = u.id_pemilik;

USE modul2;

CREATE VIEW view_produk_umkm AS SELECT 
u.nama_usaha,
p.nama_produk,
p.deskripsi_produk,
p.harga
FROM produk_umkm p
JOIN umkm u ON p.id_umkm = u.id_umkm;

CREATE VIEW view_umkm_menengah AS
SELECT
  u.nama_usaha,
  p.nama_lengkap AS nama_pemilik,
  u.total_aset,
  u.omzet_per_tahun
FROM umkm u
JOIN pemilik_umkm p ON p.id_pemilik = u.id_pemilik
JOIN skala_umkm s ON s.id_skala = u.id_skala
WHERE s.nama_skala = 'Menengah';

CREATE VIEW view_umkm_per_kota AS
SELECT 
  k.nama_kabupaten_kota,
  COUNT(u.id_umkm) AS jumlah_umkm
FROM 
  kabupaten_kota k
JOIN 
  umkm u ON u.id_kabupaten_kota = k.id_kabupaten_kota
GROUP BY `db_sistem_manajemen_sekolah`
  k.nama_kabupaten_kota;
  

SELECT * FROM view_pemilik_dan_usaha;
SELECT * FROM view_produk_umkm;
SELECT * FROM view_umkm_detail;
SELECT * FROM view_umkm_menengah;
SELECT * FROM view_umkm_per_kota;








