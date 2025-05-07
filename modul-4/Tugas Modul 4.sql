-- Modul 4

-- Soal 1  Menambahkan Kolom keterangan di Salah Satu Tabel 
USE 
ALTER TABLE anggota ADD COLUMN keterangan TEXT AFTER tanggal_daftar;
UPDATE anggota SET keterangan = 'Anggota aktif'; -- ini hasil revisi agar baris keterangan ada isinya

SELECT * FROM anggota;

-- Soal 2 Gabungan 2 Tabel yang Memiliki Fungsi

SELECT a.nama_anggota, p.id_buku, p.tanggal_pinjam
FROM anggota a
JOIN peminjaman p ON a.id_anggota = p.id_anggota;

-- Soal  3 Urutan Kolom Menggunakan ORDER BY ASC dan DESC
-- ASC
SELECT * FROM anggota ORDER BY tanggal_daftar ASC;
-- DESC
SELECT * FROM buku ORDER BY tahun_terbit DESC;

-- Soal 4 Perubahan pada Tipe Data (contoh kolom tahun_terbit di buku)

-- awalnya tahun_terbit INT
-- dibawah ini perubahannya

ALTER TABLE buku MODIFY COLUMN tahun_terbit YEAR;
DESCRIBE buku;
-- atau
SHOW COLUMNS FROM buku;


-- Soal 5 Contoh LEFT JOIN, RIGHT JOIN, SELF JOIN

-- Left Join
SELECT a.nama_anggota, b.judul_buku, g.tanggal_kembali
FROM peminjaman p
LEFT JOIN pengembalian g ON p.id_peminjaman = g.id_peminjaman
JOIN anggota a ON p.id_anggota = a.id_anggota
JOIN buku b ON p.id_buku = b.id_buku;

-- Right Join
SELECT p.id_peminjaman, g.tanggal_kembali
FROM peminjaman p
RIGHT JOIN pengembalian g ON p.id_peminjaman = g.id_peminjaman;

DESCRIBE peminjaman;


-- Self Join
SELECT DISTINCT a.nama_anggota, p.tanggal_pinjam
FROM anggota a
JOIN peminjaman p ON a.id_anggota = p.id_anggota
WHERE EXISTS (
    SELECT 1
    FROM anggota b
    WHERE a.id_anggota != b.id_anggota
    AND LEFT(a.nama_anggota, 1) = LEFT(b.nama_anggota, 1)
);
-- revisi done

-- Soal 6 Query dengan Operator Perbandingan (minimal 5)

SELECT * FROM buku WHERE tahun_terbit >= 2015;           -- Lebih dari atau sama dengan
SELECT * FROM anggota WHERE no_hp LIKE '081%';           -- String LIKE (bisa dianggap perbandingan pola)
SELECT * FROM pengembalian WHERE denda > 0;              -- Lebih dari
SELECT * FROM anggota WHERE tanggal_daftar < '2024-01-01'; -- Kurang dari
SELECT * FROM buku WHERE penerbit != 'Erlangga';         -- Tidak sama dengan
