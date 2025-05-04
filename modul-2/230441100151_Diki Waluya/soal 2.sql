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

INSERT INTO Kategori (NamaKategori) VALUES 
('Sneakers'),
('Boots'),
('Formal'),
('Running'),
('Casual');

INSERT INTO Sepatu (NamaSepatu, Merek, Ukuran, Harga, Stok, ID_Kategori) VALUES 
('Air Max 90', 'Nike', 42, 1200000.00, 15, 1),
('Classic Leather', 'Reebok', 40, 850000.00, 8, 5),
('Desert Boot', 'Clarks', 41, 1300000.00, 5, 2),
('Oxford', 'Bata', 43, 700000.00, 12, 3),
('Ultraboost 21', 'Adidas', 42, 1800000.00, 20, 4);

INSERT INTO Pelanggan (Nama, Alamat, NoHP) VALUES 
('Andi Wijaya', 'Jl. Melati No.10, Jakarta', '081234567890'),
('Siti Aminah', 'Jl. Kenanga No.5, Bandung', '082134567891'),
('Dewi Lestari', 'Jl. Mawar No.8, Surabaya', '083134567892');

INSERT INTO Pegawai (NamaPegawai, Jabatan) VALUES 
('Rudi Hartono', 'Kasir'),
('Lina Marlina', 'Admin'),
('Budi Prasetyo', 'Sales');

INSERT INTO Transaksi (Tanggal, ID_Pelanggan, ID_Pegawai, ID_Sepatu, Jumlah, Total) VALUES 
('2025-04-01', 1, 1, 1, 2, 2400000.00),
('2025-04-02', 2, 2, 2, 1, 850000.00),
('2025-04-03', 3, 1, 5, 1, 1800000.00),
('2025-04-04', 1, 3, 3, 1, 1300000.00),
('2025-04-05', 2, 1, 4, 2, 1400000.00);


SELECT * FROM Kategori;
SELECT * FROM Sepatu;
SELECT * FROM Pelanggan;
SELECT * FROM Pegawai;
SELECT * FROM Transaksi;


SELECT * FROM View_SepatuKategori;
SELECT * FROM View_TransaksiDetail;
SELECT * FROM View_SepatuStokRendah;
SELECT * FROM View_TotalPenjualanSepatu;
SELECT * FROM View_TransaksiHarianPegawai;

CREATE VIEW View_SepatuKategori AS
SELECT 
    s.ID_Sepatu,
    s.NamaSepatu,
    s.Merek,
    s.Ukuran,
    s.Harga,
    s.Stok,
    k.NamaKategori
FROM Sepatu s
JOIN Kategori k ON s.ID_Kategori = k.ID_Kategori;

CREATE VIEW View_TransaksiDetail AS
SELECT 
    t.ID_Transaksi,
    t.Tanggal,
    p.Nama AS NamaPelanggan,
    s.NamaSepatu,
    s.Merek,
    t.Jumlah,
    t.Total
FROM Transaksi t
JOIN Pelanggan p ON t.ID_Pelanggan = p.ID_Pelanggan
JOIN Sepatu s ON t.ID_Sepatu = s.ID_Sepatu;

CREATE VIEW View_SepatuStokRendah AS
SELECT 
    s.ID_Sepatu,
    s.NamaSepatu,
    s.Merek,
    s.Stok,
    k.NamaKategori
FROM Sepatu s
JOIN Kategori k ON s.ID_Kategori = k.ID_Kategori
WHERE s.Stok < 10;

CREATE VIEW View_TotalPenjualanSepatu AS
SELECT 
    s.NamaSepatu,
    SUM(t.Jumlah) AS TotalTerjual,
    SUM(t.Total) AS TotalPendapatan
FROM Transaksi t
JOIN Sepatu s ON t.ID_Sepatu = s.ID_Sepatu
GROUP BY s.NamaSepatu;

CREATE VIEW View_TransaksiHarianPegawai AS
SELECT 
    t.Tanggal,
    pg.NamaPegawai,
    COUNT(t.ID_Transaksi) AS JumlahTransaksi,
    SUM(t.Total) AS TotalPendapatan
FROM Transaksi t
JOIN Pegawai pg ON t.ID_Pegawai = pg.ID_Pegawai
GROUP BY t.Tanggal, pg.NamaPegawai;



