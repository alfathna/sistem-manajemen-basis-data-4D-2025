CREATE DATABASE perpustakaan_digital;
USE perpustakaan_digital;

-- TABEL MASTER 
-- tabel katagori
CREATE TABLE kategori (
id_kategori INT AUTO_INCREMENT PRIMARY KEY,
nama_kategori VARCHAR(50) NOT NULL
);

-- tabel buku 
CREATE TABLE buku (
id_buku INT AUTO_INCREMENT PRIMARY KEY,
judul_buku VARCHAR(100) NOT NULL,
penulis VARCHAR(50),
penerbit VARCHAR(50),
tahun_terbit INT,
id_kategori INT,
    ON UPDATE CASCADE ON DELETE SET NULL
);

ALTER TABLE BUKU ADD CONSTRAINT fkid_kategori FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategoori)


-- tabel anggota
CREATE TABLE anggota (
id_anggota INT AUTO_INCREMENT PRIMARY KEY,
nama_anggota VARCHAR(100) NOT NULL,
alamat TEXT,
no_hp VARCHAR(20),
tanggal_daftar DATE
);

-- TABEL TRANSAKSI
-- tabel peminjaman
CREATE TABLE peminjaman (
    id_peminjaman INT AUTO_INCREMENT PRIMARY KEY,
    id_anggota INT,
    id_buku INT,
    tanggal_pinjam DATE NOT NULL,
    tanggal_jatuh_tempo DATE NOT NULL,
    FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_buku) REFERENCES buku(id_buku)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- tabel pengembalian
CREATE TABLE pengembalian (
    id_pengembalian INT AUTO_INCREMENT PRIMARY KEY,
    id_peminjaman INT,
    tanggal_kembali DATE NOT NULL,
    denda DECIMAL(10,2),
    FOREIGN KEY (id_peminjaman) REFERENCES peminjaman(id_peminjaman)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- untuk menampilkan
SELECT * FROM kategori;
SELECT * FROM buku;
SELECT * FROM anggota;
SELECT * FROM peminjaman;
SELECT * FROM pengembalian;
	
-- isi dari tabel kategori
INSERT INTO kategori (nama_kategori) VALUES
('Fiksi'),
('Non-Fiksi'),
('Teknologi'),
('Coding'),
('Percintaan');


-- isi dari tabel buku
INSERT INTO buku (judul_buku, penulis, penerbit, tahun_terbit, id_kategori) VALUES
('Mengaguminya', 'Harry Edward', 'Seven Pustaka', 2004, 1),
('Atomic Habits', 'Zidan', 'Penguin', 2018, 2),
('Pemrograman Python', 'patah', 'Informatika', 2020, 3),
('Sejarah Dunia', 'Diki wayuya', 'History Press', 2015, 4),
('Matematika Mudah', 'Umam beceng', 'Erlangga', 2017, 5);

-- isi dari tabel anggota
INSERT INTO anggota (nama_anggota, alamat, no_hp, tanggal_daftar) VALUES
('Nayla arrafa', 'Jl. Melati No. 10', '081234567890', '2023-01-15'),
('Rizal aselole', 'Jl. Kenanga No. 5', '082345678901', '2023-03-20'),
('Yuni asfarani', 'Jl. Mawar No. 8', '083456789012', '2023-05-10');

-- isi dari tabel peminjaman
INSERT INTO peminjaman (id_anggota, id_buku, tanggal_pinjam, tanggal_jatuh_tempo) VALUES
(1, 1, '2024-03-01', '2024-03-15'),
(2, 3, '2024-03-05', '2024-03-19'),
(3, 2, '2024-03-10', '2024-03-24');

-- isi dari tabel pengembalian
INSERT INTO pengembalian (id_peminjaman, tanggal_kembali, denda) VALUES
(1, '2024-03-14', 0.00),
(2, '2024-03-22', 5000.00),
(3, '2024-03-24', 0.00);

-- Relasi Buku dengan Kategori (1:N)
FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori)
    ON UPDATE CASCADE ON DELETE SET NULL

-- Relasi Peminjaman: Buku + Anggota (N:M direpresentasikan lewat peminjaman)
FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota)
FOREIGN KEY (id_buku) REFERENCES buku(id_buku)

-- Relasi Pengembalian ke Peminjaman (1:1)
FOREIGN KEY (id_peminjaman) REFERENCES peminjaman(id_peminjaman)

-- Bisa Tambah Relasi "Admin" (opsional untuk ide lebih kreatif)
CREATE TABLE ADMIN (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    nama_admin VARCHAR(100),
    email VARCHAR(100)
);

===============================================================================================================================================================
-- Modul 2 

-- Soal 1
-- DROP view jika sudah ada
DROP VIEW IF EXISTS view_perpustakaan_detail;

-- Buat view baru
CREATE VIEW view_perpustakaan_detail AS
SELECT 
    a.nama_anggota AS 'Nama Anggota',
    b.judul_buku AS 'Judul Buku',
    b.penulis AS 'Penulis',
    k.nama_kategori AS 'Kategori Buku',
    p.tanggal_pinjam AS 'Tanggal Pinjam',
    p.tanggal_jatuh_tempo AS 'Tanggal Jatuh Tempo',
    g.tanggal_kembali AS 'Tanggal Kembali',
    g.denda AS 'Denda'
FROM perpustakaan_digital.peminjaman p
JOIN perpustakaan_digital.anggota a ON p.id_anggota = a.id_anggota
JOIN perpustakaan_digital.buku b ON p.id_buku = b.id_buku
LEFT JOIN perpustakaan_digital.pengembalian g ON p.id_peminjaman = g.id_peminjaman
LEFT JOIN perpustakaan_digital.kategori k ON b.id_kategori = k.id_kategori;

SELECT * FROM view_perpustakaan_detail;


-- Soal 2
-- Hapus view jika sudah ada sebelumnya
DROP VIEW IF EXISTS view_anggota_dan_buku;

-- Buat view baru
CREATE VIEW view_anggota_dan_buku AS
SELECT 
    a.id_anggota,
    a.nama_anggota,
    a.no_hp,
    a.alamat,
    b.judul_buku,
    b.penulis
FROM perpustakaan_digital.anggota a
JOIN perpustakaan_digital.peminjaman p ON a.id_anggota = p.id_anggota
JOIN perpustakaan_digital.buku b ON p.id_buku = b.id_buku;

SELECT * FROM view_anggota_dan_buku;

===========================================================================

-- Soal 3
-- Hapus view jika sudah ada
DROP VIEW IF EXISTS view_buku_dan_kategori;

-- Buat view baru
CREATE VIEW view_buku_dan_kategori AS
SELECT 
    b.judul_buku,
    b.penulis,
    b.penerbit,
    b.tahun_terbit,
    k.nama_kategori
FROM perpustakaan_digital.buku b
LEFT JOIN perpustakaan_digital.kategori k ON b.id_kategori = k.id_kategori;

SELECT * FROM view_buku_dan_kategori;

============================================================================

-- Soal 4
-- Hapus view jika sudah ada
DROP VIEW IF EXISTS view_pengembalian_denda;

-- Buat view baru
CREATE VIEW view_pengembalian_denda AS
SELECT 
    a.nama_anggota,
    b.judul_buku,
    g.tanggal_kembali,
    g.denda
FROM perpustakaan_digital.pengembalian g
JOIN perpustakaan_digital.peminjaman p ON g.id_peminjaman = p.id_peminjaman
JOIN perpustakaan_digital.anggota a ON p.id_anggota = a.id_anggota
JOIN perpustakaan_digital.buku b ON p.id_buku = b.id_buku
WHERE g.denda > 0;

SELECT * FROM view_pengembalian_denda;

================================================================

-- Soal 5
-- Hapus view jika sudah ada
DROP VIEW IF EXISTS view_peminjaman_per_anggota;

-- Buat view baru
CREATE VIEW view_peminjaman_per_anggota AS
SELECT 
    a.nama_anggota,
    COUNT(p.id_peminjaman) AS jumlah_peminjaman
FROM perpustakaan_digital.peminjaman p
JOIN perpustakaan_digital.anggota a ON p.id_anggota = a.id_anggota
GROUP BY a.nama_anggota;

SELECT * FROM view_peminjaman_per_anggota ORDER BY jumlah_peminjaman DESC;

========================================================================================================
--  View Statistik Denda Total per Anggota
-- Tambahan view dari saya
-- Hapus view jika sudah ada
DROP VIEW IF EXISTS view_total_denda_per_anggota;

-- Buat view baru
CREATE VIEW view_total_denda_per_anggota AS
SELECT 
    a.id_anggota,
    a.nama_anggota,
    SUM(g.denda) AS total_denda
FROM pengembalian g
JOIN peminjaman p ON g.id_peminjaman = p.id_peminjaman
JOIN anggota a ON p.id_anggota = a.id_anggota
GROUP BY a.id_anggota, a.nama_anggota;

-- Lihat hasil
SELECT * FROM view_total_denda_per_anggota ORDER BY total_denda DESC;

=======================================================================

-- View Buku yang Paling Sering Dipinjam
-- Hapus view jika sudah ada
DROP VIEW IF EXISTS view_buku_terpopuler;

-- Buat view baru
CREATE VIEW view_buku_terpopuler AS
SELECT 
    b.judul_buku,
    COUNT(p.id_buku) AS jumlah_dipinjam
FROM buku b
JOIN peminjaman p ON b.id_buku = p.id_buku
GROUP BY b.id_buku, b.judul_buku
ORDER BY jumlah_dipinjam DESC;

-- Lihat hasil
SELECT * FROM view_buku_terpopuler;

=======================================================================

-- View Laporan Peminjaman Per Bulan
-- Hapus view jika sudah ada
DROP VIEW IF EXISTS view_peminjaman_per_bulan;

-- Buat view baru
CREATE VIEW view_peminjaman_per_bulan AS
SELECT 
    DATE_FORMAT(tanggal_pinjam, '%Y-%m') AS bulan,
    COUNT(*) AS jumlah_peminjaman
FROM peminjaman
GROUP BY bulan
ORDER BY bulan ASC;

-- Lihat hasil
SELECT * FROM view_peminjaman_per_bulan;

=======================================================================

-- View: Jumlah Buku per Kategori
-- Hapus view jika sudah ada
DROP VIEW IF EXISTS view_jumlah_buku_per_kategori;

-- Buat view baru
CREATE VIEW view_jumlah_buku_per_kategori AS
SELECT 
    k.nama_kategori,
    COUNT(b.id_buku) AS jumlah_buku
FROM kategori k
LEFT JOIN buku b ON k.id_kategori = b.id_kategori
GROUP BY k.nama_kategori;

-- Lihat hasil
SELECT * FROM view_jumlah_buku_per_kategori;

=======================================================================

-- View: Anggota yang Belum Mengembalikan Buku
-- Hapus view jika sudah ada
DROP VIEW IF EXISTS view_anggota_belum_kembali;

-- Buat view baru
CREATE VIEW view_anggota_belum_kembali AS
SELECT 
    a.nama_anggota,
    b.judul_buku,
    p.tanggal_pinjam,
    p.tanggal_jatuh_tempo
FROM peminjaman p
JOIN anggota a ON p.id_anggota = a.id_anggota
JOIN buku b ON p.id_buku = b.id_buku
LEFT JOIN pengembalian g ON p.id_peminjaman = g.id_peminjaman
WHERE g.id_pengembalian IS NULL;

-- Lihat hasil
SELECT * FROM view_anggota_belum_kembali;
