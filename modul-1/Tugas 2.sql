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
FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori)
    ON UPDATE CASCADE ON DELETE SET NULL
);

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

