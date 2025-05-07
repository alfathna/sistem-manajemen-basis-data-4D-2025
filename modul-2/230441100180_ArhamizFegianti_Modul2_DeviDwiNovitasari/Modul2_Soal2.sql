USE db_fastfood;
INSERT INTO customer (id_customer, nama_customer, no_hp) VALUES
(1, 'Amel', '081234567890'),
(2, 'Nadia', '082134567891'),
(3, 'Putri', '083134567892'),
(4, 'Sarah', '084134567893'),
(5, 'Nesa', '085134567894');
SELECT * FROM customer;

INSERT INTO kasir (id_pegawai, nama_pegawai, username, pasword, no_hp, alamat) VALUES
(1, 'Amira', 'amira_kasir', 'pass123', '0811223344', 'Sidoarjo'),
(2, 'Sinta', 'sinta_kasir', 'pass456', '0811334455', 'Mojokerto'),
(3, 'Crysna', 'crysna_kasir', 'pass789', '0811445566', 'Surabaya');
SELECT * FROM kasir;
SELECT * FROM produk;
SELECT * FROM kategori_menu;

INSERT INTO transaksi (id_pegawai, id_customer, id_produk, total) VALUES
(1, 1, 11, 25000),
(2, 2, 21, 10000),
(3, 3, 31, 15000),
(1, 1, 12, 50000),
(2, 4, 22, 5000),
(3, 5, 13, 30000);
SELECT * FROM transaksi;

#VIEW
CREATE VIEW view_daftar_menu AS
SELECT km.nama_kategori_menu AS 'Kategori Menu', p.nama_produk AS 'Nama Produk', 
p.harga AS 'Harga'
FROM produk p
JOIN kategori_menu km ON km.id_kategori_menu = p.id_kategori_menu;
SELECT * FROM view_daftar_menu;

CREATE VIEW view_transaksi_lengkap AS
SELECT c.nama_customer AS 'Nama Customer', k.nama_pegawai AS 'Kasir',
t.tanggal AS 'Tanggal Transaksi', t.total AS 'Total Transaksi'
FROM transaksi t
JOIN customer c ON c.id_customer = t.id_customer
JOIN kasir k ON k.id_pegawai = t.id_pegawai;
SELECT * FROM view_transaksi_lengkap;

CREATE VIEW view_transaksi_khusus AS
SELECT c.nama_customer AS 'Nama Customer', p.nama_produk AS 'Nama Produk',
p.harga AS 'Harga Produk', t.total AS 'Total Transaksi'
FROM transaksi t
JOIN customer c ON c.id_customer = t.id_customer
JOIN produk p ON p.id_produk = t.id_produk
WHERE t.total > 20000;
SELECT * FROM view_transaksi_khusus;

CREATE VIEW view_detail_penjualan_kasir AS
SELECT k.id_pegawai AS 'No Kasir', k.nama_pegawai AS 'Nama Kasir',
COUNT(t.id_transaksi) AS 'Jumlah Transaksi',
SUM(t.total) AS 'Total Penjualan',
AVG(t.total) AS 'Rata-rata Penjualan'
FROM kasir k
JOIN transaksi t ON k.id_pegawai = t.id_pegawai
GROUP BY k.id_pegawai, k.nama_pegawai;
SELECT * FROM view_detail_penjualan_kasir;

CREATE VIEW view_penjualan_per_kategori AS
SELECT km.nama_kategori_menu AS 'Kategori',
COUNT(t.id_transaksi) AS 'Jumlah Terjual',
SUM(t.total) AS 'Total Penjualan'
FROM transaksi t
JOIN produk p ON t.id_produk = p.id_produk
JOIN kategori_menu km ON p.id_kategori_menu = km.id_kategori_menu
GROUP BY km.nama_kategori_menu;
SELECT * FROM view_penjualan_per_kategori;

SHOW TABLES;