USE db_fastfood;

CREATE TABLE customer (
id_customer INT(10) PRIMARY KEY NOT NULL,
nama_customer VARCHAR(20) NOT NULL,
no_hp VARCHAR(20) NOT NULL);

CREATE TABLE kasir (
id_pegawai INT(10) PRIMARY KEY NOT NULL,
nama_pegawai VARCHAR(25) NOT NULL,
username VARCHAR(20) NOT NULL,
pasword VARCHAR(20) NOT NULL,
no_hp VARCHAR(20) NOT NULL,
alamat VARCHAR(50) NOT NULL);

CREATE TABLE kategori_menu (
id_kategori_menu INT(10) PRIMARY KEY NOT NULL,
nama_kategori_menu VARCHAR(50) NOT NULL);

CREATE TABLE produk (
id_produk INT(10) PRIMARY KEY NOT NULL,
nama_produk VARCHAR(50) NOT NULL,
harga INT(50) NOT NULL,
id_kategori_menu INT(10) NOT NULL,
FOREIGN KEY (id_kategori_menu) REFERENCES kategori_menu(id_kategori_menu) ON DELETE CASCADE);

CREATE TABLE transaksi (
id_transaksi INT PRIMARY KEY AUTO_INCREMENT,
id_pegawai INT(10) NOT NULL,
id_customer INT(10) NULL,
id_produk INT(10) NOT NULL,
tanggal DATETIME DEFAULT CURRENT_TIMESTAMP,
total INT(50) NOT NULL,
FOREIGN KEY (id_pegawai) REFERENCES kasir(id_pegawai) ON DELETE CASCADE,
FOREIGN KEY (id_customer) REFERENCES customer(id_customer) ON DELETE SET NULL,
FOREIGN KEY (id_produk) REFERENCES produk(id_produk) ON DELETE CASCADE);

INSERT INTO kategori_menu (id_kategori_menu, nama_kategori_menu) VALUES
(1, 'food'),
(2, 'drink'),
(3, 'snack');

INSERT INTO produk (id_produk, nama_produk, harga, id_kategori_menu) VALUES
#Food
(11, 'Burger', 25000, 1),
(12, 'Pizza', 50000, 1),
(13, 'Fried Chicken', 30000, 1),
#Drink
(21, 'Coca Cola', 10000, 2),
(22, 'Mineral Water', 5000, 2),
(23, 'Iced Coffee', 15000, 2),
#Snack
(31, 'French Fries', 15000, 3),
(32, 'Onion Rings', 12000, 3),
(33, 'Nuggets', 18000, 3);

SHOW TABLES;
SELECT * FROM kategori_menu;
SELECT * FROM produk;
