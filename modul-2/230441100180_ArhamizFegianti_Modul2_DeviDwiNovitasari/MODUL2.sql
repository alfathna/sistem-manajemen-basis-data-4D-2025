CREATE DATABASE praktikum_modul2;
USE praktikum_modul2;

CREATE TABLE anggota(
id_anggota INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
nama_anggota VARCHAR(25) NOT NULL,
angkatan_anggota VARCHAR(6) NOT NULL,
tempat_lahir_anggota VARCHAR(20) NOT NULL,
tanggal_lahir_anggota DATE,
no_telp VARCHAR(20) NOT NULL,
jenis_kelamin VARCHAR(15) NOT NULL,
status_pinjam VARCHAR(15) NOT NULL);

CREATE TABLE petugas(
id_petugas INT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
username VARCHAR(15) NOT NULL,
passwordd VARCHAR(15) NOT NULL,
nama VARCHAR(25) NOT NULL);

CREATE TABLE buku(
kode_buku INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
judul_buku VARCHAR(25) NOT NULL,
pengarang_buku VARCHAR(30) NOT NULL,
penerbit_buku VARCHAR(30) NOT NULL,
tahun_buku VARCHAR(10) NOT NULL,
jumlah_buku VARCHAR(5) NOT NULL,
status_buku VARCHAR(10) NOT NULL,
klasifikasi_buku VARCHAR(20) NOT NULL);

CREATE TABLE peminjaman(
kode_peminjaman INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
id_anggota INT(10) NOT NULL,
id_petugas INT(10) NOT NULL,
kode_buku INT(10) NOT NULL,
tanggal_pinjam DATE,
tanggal_kembali DATE);

ALTER TABLE peminjaman ADD CONSTRAINT fk_id_anggota FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota);
ALTER TABLE peminjaman ADD CONSTRAINT fk_id_petugas FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas);
ALTER TABLE peminjaman ADD CONSTRAINT fk_kode_buku FOREIGN KEY (kode_buku) REFERENCES buku(kode_buku);

CREATE TABLE pengembalian (
kode_kembali INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
id_anggota INT(10) NOT NULL,
kode_buku INT(10) NOT NULL,
id_petugas INT(10) NOT NULL,
tgl_pinjam DATE,
tgl_kembali DATE,
denda VARCHAR(15) NOT NULL);

ALTER TABLE pengembalian ADD CONSTRAINT fk_idanggota FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota);
ALTER TABLE pengembalian ADD CONSTRAINT fk_idpetugas FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas);
ALTER TABLE pengembalian ADD CONSTRAINT fk_idkodebuku FOREIGN KEY (kode_buku) REFERENCES buku(kode_buku);

INSERT INTO anggota (nama_anggota, angkatan_anggota, tempat_lahir_anggota, tanggal_lahir_anggota, no_telp, jenis_kelamin, status_pinjam) VALUES
('Devi Dwi', '2022', 'Lamongan', '2004-09-18', '089529753775', 'P', 'Tidak Aktif'),
('Dedy Eka', '2019', 'Malang', '2002-07-28', '089612340987', 'L', 'Aktif'),
('Eri Nana', '2018', 'Bojonegoro', '2001-12-09', '089765472345', 'P', 'Aktif'),
('Adelia Shafira', '2022', 'Sidoarjo', '2004-09-26', '089178651234', 'P', 'Aktif'),
('Arum Rahma', '2022', 'Pasuruan', '2004-10-20', '081234567890', 'P', 'Aktif');
SELECT * FROM anggota;

INSERT INTO petugas (username, passwordd, nama) VALUES
('userpetugas1', 'consolelog', 'Pebiyanti'),
('userpetugas2', 'helloworld', 'Novitasari'),
('userpetugas3', 'systemoutprint', 'Zahranda'),
('userpetugas4', 'tuhanyangtau', 'Putra'),
('userpetugas5', 'tidakada', 'Anindita');
SELECT * FROM petugas;

INSERT INTO buku (judul_buku, pengarang_buku, penerbit_buku, tahun_buku, jumlah_buku, status_buku, klasifikasi_buku) VALUES
('Malam Yang Kelam', 'Agatha Christie', 'Elex Media Komutindo', '2011', '4', 'Tersedia', 'Fiksi Dediktif'),
('Cantik Itu Luka', 'Eka Kurniawan', 'Gramedia', '2012', '3', 'Tersedia', 'Romansa'),
('Saman', 'Ayu Utami', 'Gramedia', '2002', '7', 'Tersedia', 'Politik Dan Agama'),
('Ronggeng Dukuh Paruh', 'Ahmad Tohari', 'Gramedia', '2003', '9', 'Tersedia', 'Sejarah'),
('Entrok', 'Okky Madasari', 'Gramedia', '2011', '5', 'Tersedia', 'Sejarah');
SELECT * FROM buku;

INSERT INTO peminjaman (id_anggota, id_petugas, kode_buku, tanggal_pinjam, tanggal_kembali) VALUES
(2, 1, 1, '2024-02-10', '2024-02-28'),
(4, 1, 2, '2024-03-11', '2024-03-12'),
(4, 4, 4, '2024-01-09', '2024-01-12'),
(3, 5, 3, '2024-01-05', '2024-01-07'),
(5, 2, 4, '2024-03-09', '2024-03-15');
SELECT * FROM peminjaman;

INSERT INTO pengembalian (id_anggota, kode_buku, id_petugas, tgl_pinjam, tgl_kembali, denda) VALUES
(3, 2, 4, '2023-02-18', '2023-02-28', '10.000'),
(2, 3, 4, '2024-03-11', '2024-03-21', '5000'),
(2, 5, 5, '2023-08-02', '2023-08-12', '10.000'),
(4, 4, 1, '2024-01-05', '2024-01-15', '5000'),
(5, 1, 2, '2024-03-09', '2024-03-19', '10.000');
SELECT * FROM pengembalian;

CREATE VIEW view_nama_angkatan AS 
SELECT nama_anggota AS 'Nama Anggota', angkatan_anggota AS 'angkatan'
FROM anggota;
SELECT * FROM view_nama_angkatan;

CREATE VIEW view_judul_anggota_pinjam AS 
SELECT b.judul_buku AS 'Judul Buku', a.nama_anggota AS 'Nama Anggota'
FROM peminjaman p
JOIN anggota a ON p.id_anggota = a.id_anggota
JOIN buku b ON p.kode_buku = b.kode_buku;
SELECT * FROM view_judul_anggota_pinjam;

CREATE VIEW pinjam_buku AS 
SELECT a.id_anggota, b.nama_anggota,
COUNT(a.id_anggota) AS 'Jumlah Buku Yang Dipinjam'
FROM peminjaman a, anggota b
WHERE a.id_anggota = b.id_anggota
GROUP BY id_anggota
HAVING COUNT(*) = 1;
SELECT * FROM pinjam_buku; 

CREATE VIEW pinjam_dan_kembali AS 
SELECT nama AS 'Nama Petugas', 
COUNT(DISTINCT b.kode_peminjaman) AS 'Jumlah Peminjaman',
COUNT(DISTINCT c.kode_kembali) AS 'Jumlah Pengembalian'
FROM petugas a, peminjaman b, pengembalian c
WHERE a.id_petugas = b.id_petugas AND a.id_petugas = c.id_petugas
GROUP BY nama;
SELECT * FROM pinjam_dan_kembali;
#distinct untuk menghindari duplikat data
#count menghitung