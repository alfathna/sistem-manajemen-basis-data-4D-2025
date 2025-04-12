CREATE DATABASE TokoSepatu;
USE TokoSepatu;


CREATE TABLE Kategori (
    ID_Kategori INT AUTO_INCREMENT PRIMARY KEY,
    NamaKategori VARCHAR(50)
);


CREATE TABLE Sepatu (
    ID_Sepatu INT AUTO_INCREMENT PRIMARY KEY,
    NamaSepatu VARCHAR(100),
    Merek VARCHAR(50),
    Ukuran INT,
    Harga DECIMAL(10,2),
    Stok INT,
    ID_Kategori INT,
    FOREIGN KEY (ID_Kategori) REFERENCES Kategori(ID_Kategori)
);


CREATE TABLE Pelanggan (
    ID_Pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    Nama VARCHAR(100),
    Alamat VARCHAR(200),
    NoHP VARCHAR(15)
);


CREATE TABLE Pegawai (
    ID_Pegawai INT AUTO_INCREMENT PRIMARY KEY,
    NamaPegawai VARCHAR(100),
    Jabatan VARCHAR(50)
);


CREATE TABLE Transaksi (
    ID_Transaksi INT AUTO_INCREMENT PRIMARY KEY,
    Tanggal DATE,
    ID_Pelanggan INT,
    ID_Pegawai INT,
    ID_Sepatu INT,
    Jumlah INT,
    Total DECIMAL(10,2),
    FOREIGN KEY (ID_Pelanggan) REFERENCES Pelanggan(ID_Pelanggan),
    FOREIGN KEY (ID_Pegawai) REFERENCES Pegawai(ID_Pegawai),
    FOREIGN KEY (ID_Sepatu) REFERENCES Sepatu(ID_Sepatu)
);

SELECT * FROM Kategori;
SELECT * FROM Sepatu;
SELECT * FROM Pelanggan;
SELECT * FROM Pegawai;
SELECT * FROM Transaksi;

