ALTER TABLE Sepatu ADD Keterangan VARCHAR(255);

-- Misalnya sepatu ID 1 & 5 paling laku, kita tandai sebagai "Best seller"
UPDATE Sepatu
SET keterangan = 'Best seller'
WHERE ID_Sepatu IN (1, 5);

-- Sepatu dengan stok < 10 diberi keterangan "Stok menipis"
UPDATE Sepatu
SET keterangan = 'Stok menipis'
WHERE Stok < 10;

-- Sisanya diberi keterangan umum "Stok tersedia"
UPDATE Sepatu
SET keterangan = 'Stok tersedia'
WHERE keterangan IS NULL;

SELECT NamaSepatu, Merek, Stok, keterangan FROM Sepatu;

SELECT s.NamaSepatu, s.Merek, k.NamaKategori
FROM Sepatu s
JOIN Kategori k ON s.ID_Kategori = k.ID_Kategori;

SELECT * FROM Pelanggan
ORDER BY Nama ASC;

SELECT * FROM Sepatu
ORDER BY Harga DESC;

ALTER TABLE Pelanggan MODIFY NoHP VARCHAR(20);

DESCRIBE Pelanggan;


SELECT s.NamaSepatu, k.NamaKategori
FROM Sepatu s
LEFT JOIN Kategori k ON s.ID_Kategori = k.ID_Kategori;

SELECT p1.NamaPegawai AS Pegawai1, p2.NamaPegawai AS Pegawai2, p1.Jabatan
FROM Pegawai p1
JOIN Pegawai p2 ON p1.Jabatan = p2.Jabatan AND p1.ID_Pegawai < p2.ID_Pegawai;

-- 1. Harga lebih dari 1 juta
SELECT * FROM Sepatu WHERE Harga > 1000000;

-- 2. Ukuran sepatu sama dengan 42
SELECT * FROM Sepatu WHERE Ukuran = 42;

-- 3. Stok kurang dari 10
SELECT * FROM Sepatu WHERE Stok < 10;

-- 4. Total pembelian lebih besar dari atau sama dengan 2 juta
SELECT * FROM Transaksi WHERE Total >= 2000000;

-- 5. Jumlah beli tidak sama dengan 1
SELECT * FROM Transaksi WHERE Jumlah != 1;