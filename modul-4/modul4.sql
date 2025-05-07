USE sewa_art;

ALTER TABLE Alat ADD COLUMN keterangan TEXT;

SELECT * FROM alat;

SELECT 
    t.id_transaksi,
    t.tanggal_sewa,
    p.nama AS nama_pelanggan
FROM Transaksi t
JOIN Pelanggan p ON t.id_pelanggan = p.id_pelanggan;

SELECT * FROM Alat ORDER BY harga_sewa_per_hari ASC;

SELECT * FROM Pelanggan ORDER BY nama DESC;

SELECT * FROM Transaksi ORDER BY tanggal_sewa;

ALTER TABLE Alat MODIFY stok SMALLINT;



SELECT 
    a.nama_alat,
    d.jumlah
FROM Alat a
LEFT JOIN Detail_Transaksi d ON a.id_alat = d.id_alat;

SELECT 
    a.nama_alat,
    d.jumlah
FROM Alat a
RIGHT JOIN Detail_Transaksi d ON a.id_alat = d.id_alat;

SELECT 
    p1.nama AS pelanggan_1,
    p2.nama AS pelanggan_2,
    p1.alamat
FROM Pelanggan p1
JOIN Pelanggan p2 ON p1.alamat = p2.alamat AND p1.id_pelanggan != p2.id_pelanggan;

SELECT * FROM Alat
WHERE harga_sewa_per_hari > 20000
  AND stok <= 10
  AND kategori != 'Elektronik'
  OR nama_alat = 'Blender'
  AND harga_sewa_per_hari BETWEEN 15000 AND 30000;

