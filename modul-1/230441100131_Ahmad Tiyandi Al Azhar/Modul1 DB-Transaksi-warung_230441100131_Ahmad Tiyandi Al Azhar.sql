
CREATE DATABASE IF NOT EXISTS db_warung;
USE db_warung;

CREATE TABLE kategori_barang (
    id_kategori INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(100)
);

CREATE TABLE pemasok (
    id_pemasok INT PRIMARY KEY AUTO_INCREMENT,
    nama_pemasok VARCHAR(100),
    kontak VARCHAR(50)
);

CREATE TABLE barang (
    id_barang INT PRIMARY KEY AUTO_INCREMENT,
    nama_barang VARCHAR(100),
    harga DECIMAL(10,2),
    stok INT,
    id_kategori INT,
    id_pemasok INT,
    FOREIGN KEY (id_kategori) REFERENCES kategori_barang(id_kategori),
    FOREIGN KEY (id_pemasok) REFERENCES pemasok(id_pemasok)
);

CREATE TABLE transaksi (
    id_transaksi INT PRIMARY KEY AUTO_INCREMENT,
    tanggal_transaksi DATE,
    total_harga DECIMAL(10,2),
    metode_pembayaran VARCHAR(50)
);

CREATE TABLE detail_transaksi (
    id_detail INT PRIMARY KEY AUTO_INCREMENT,
    id_transaksi INT,
    id_barang INT,
    jumlah INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi),
    FOREIGN KEY (id_barang) REFERENCES barang(id_barang)
);
