USE db_fastfood;

ALTER TABLE produk ADD COLUMN keterangan VARCHAR(100) AFTER harga;


SELECT p.id_produk, p.nama_produk, p.harga, km.nama_kategori_menu
FROM produk p
JOIN kategori_menu km ON p.id_kategori_menu = km.id_kategori_menu;


SELECT * FROM kasir
ORDER BY nama_pegawai ASC;
SELECT * FROM produk
ORDER BY harga DESC;


ALTER TABLE customer MODIFY COLUMN no_hp VARCHAR(10) NOT NULL;


SELECT p.nama_produk, t.total
FROM produk p
LEFT JOIN transaksi t ON p.id_produk = t.id_produk;

SELECT p.nama_produk, t.total
FROM produk p
RIGHT JOIN transaksi t ON p.id_produk = t.id_produk;

SELECT k1.nama_pegawai AS Kasir1, k2.nama_pegawai AS Kasir2, k1.alamat
FROM kasir k1
JOIN kasir k2 ON k1.alamat = k2.alamat
WHERE k1.id_pegawai < k2.id_pegawai;

SELECT 
t.id_transaksi,
t.tanggal,
p.nama_produk,
p.harga,
k.nama_pegawai AS kasir,
c.nama_customer
FROM transaksi t
INNER JOIN produk p ON t.id_produk = p.id_produk
INNER JOIN kasir k ON t.id_pegawai = k.id_pegawai
INNER JOIN customer c ON t.id_customer = c.id_customer;
# transaksi diJOIN produk ambil nama dan harga produk
# transaksi diJOIN kasir ambil nama kasir yang melayani
# transaksi diJOIN customer ambil nama customer
# semua INNER JOIN hanya menampilkan transaksi yang datanya lengkap

SELECT * FROM produk WHERE harga > 20000;
SELECT * FROM produk WHERE harga < 20000;
SELECT * FROM kasir WHERE username = 'amira_kasir';
SELECT * FROM customer WHERE nama_customer <> 'Amel';
SELECT * FROM produk WHERE harga >= 25000;
SELECT * FROM produk WHERE harga <= 10000;