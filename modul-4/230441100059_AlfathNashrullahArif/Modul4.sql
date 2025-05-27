CREATE DATABASE dbNFT ; 

USE dbNFT;

CREATE TABLE Pengguna (
Id_pengguna INT AUTO_INCREMENT PRIMARY KEY,
Username VARCHAR(50) UNIQUE NOT NULL,
Email VARCHAR(100) UNIQUE NOT NULL,
Sandi VARCHAR(100) NOT NULL,
Tanggal_daftar DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Kategori (
Id_kategori INT AUTO_INCREMENT PRIMARY KEY,
Nama_kategori VARCHAR(50) NOT NULL
);

CREATE TABLE NFT (
Id_nft INT AUTO_INCREMENT PRIMARY KEY,
Nama_nft VARCHAR(100) NOT NULL,
Deskripsi TEXT,
Id_kreator INT NOT NULL,
Id_kategori INT NOT NULL,
Harga DECIMAL(10,4) NOT NULL,
Info_status ENUM('tersedia', 'terjual') DEFAULT 'tersedia',
Tanggal_upload DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (Id_kreator) REFERENCES Pengguna(Id_pengguna),
FOREIGN KEY (Id_kategori) REFERENCES Kategori(Id_kategori)
);

CREATE TABLE Transaksi (
Id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
Id_nft INT NOT NULL,
Id_kreator INT NOT NULL,
Id_pembeli INT NOT NULL,
Harga_beli DECIMAL(10,4) NOT NULL,
Tanggal_transaksi DATETIME DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE Transaksi ADD CONSTRAINT fk_Id_nft FOREIGN KEY(Id_nft) REFERENCES NFT(Id_nft);
ALTER TABLE Transaksi ADD CONSTRAINT fk_Id_kreator FOREIGN KEY(Id_kreator) REFERENCES Pengguna(Id_pengguna);
ALTER TABLE Transaksi ADD CONSTRAINT fk_Id_pembeli FOREIGN KEY(Id_pembeli) REFERENCES Pengguna(Id_pengguna);

CREATE TABLE Favorit (
Id_favorit INT AUTO_INCREMENT PRIMARY KEY,
Id_pengguna INT NOT NULL,
Id_nft INT NOT NULL,
Tanggal_ditambahkan DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (Id_pengguna) REFERENCES Pengguna(Id_pengguna),
FOREIGN KEY (Id_nft) REFERENCES NFT(Id_nft),
UNIQUE (Id_pengguna, Id_nft)
);

-- Pengguna
INSERT INTO Pengguna (Username, Email, Sandi) VALUES
('Harith', 'harith@mail.com', 'harith123'),
('Alice', 'alice@mail.com', 'alice123'),
('Lukas', 'lukas@mail.com', 'lukas123'),
('Aurora', 'aurora@mail.com', 'aurora123'),
('Kalea', 'kalea@mail.com', 'kalea123'),
('Roronoa', 'roronoa@mail.com', 'roronoa123'),
('Sakura', 'sakura@mail.com', 'sakura123'),
('Steve', 'steve@mail.com', 'steve123'),
('Maya', 'maya@mail.com', 'maya123'),
('Zayn', 'zayn@mail.com', 'zayn123');

-- Kategori
INSERT INTO Kategori (Nama_kategori) VALUES
('Seni Digital'),
('Fotografi'),
('3D Art'),
('Animasi'),
('Game Asset');

-- NFT
INSERT INTO NFT (Nama_nft, Deskripsi, Id_kreator, Id_kategori, Harga) VALUES
('Cyberpunk Skyline', 'Pemandangan kota futuristik dengan pencahayaan neon.', 1, 1, 3.5000),
('Forest Spirit', 'Ilustrasi roh hutan dalam bentuk digital painting.', 2, 1, 2.0000),
('Urban Shadows', 'Foto hitam putih jalanan kota di malam hari.', 3, 2, 1.7500),
('3D Warrior Model', 'Model karakter prajurit untuk game RPG.', 4, 3, 5.0000),
('Pixel Cat', 'Animasi kucing piksel lucu yang bergerak.', 5, 4, 1.2500),
('Joy Boy', 'Bentuk ke lima dari buah iblis Monkey D. Luffy.', 6, 4, 5.5000),
('Naruto Baryon Mode', 'Model karakter Naruto dalam form terakhirnya.', 10, 3, 4.0000),
('Digital Phoenix', 'Burung api mitologis dengan efek cahaya.', 6, 1, 4.7500),
('AR Dragon', 'Naga 3D interaktif untuk AR games.', 7, 3, 6.2000),
('Enma', 'Item ekslusif pada game konsol Pirate King', 6, 5, 2.2000);

-- Transaksi
INSERT INTO Transaksi (Id_nft, Id_kreator, Id_pembeli, Harga_beli) VALUES
(1, 1, 2, 3.5000),
(2, 2, 3, 2.0000),
(3, 3, 4, 1.7500),
(4, 4, 5, 5.0000),
(5, 5, 1, 1.2500),
(6, 6, 7, 5.5000),
(7, 10, 8, 4.0000),
(8, 6, 9, 4.7500),
(9, 7, 10, 6.2000),
(10, 6, 1, 2.2000);

-- Favorit
INSERT INTO Favorit (Id_pengguna, Id_nft) VALUES
(1, 3),
(2, 4),
(3, 1),
(4, 5),
(5, 2),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Menampilkan Tabel --
SELECT * FROM Pengguna;
SELECT * FROM Kategori;
SELECT * FROM NFT;
SELECT * FROM Transaksi;
SELECT * FROM Favorit;

DROP DATABASE dbNFT;
-- -- -- -- -- -- -- --
-- 1
ALTER TABLE NFT ADD Keterangan TEXT AFTER Harga;
SELECT * FROM NFT;

-- 2
SELECT P.Username, N.Nama_nft, N.Harga FROM Pengguna P JOIN NFT N ON P.Id_pengguna = N.Id_kreator;

-- 3 
SELECT * FROM NFT ORDER BY Harga ASC;
SELECT * FROM NFT ORDER BY Harga DESC;
SELECT * FROM NFT ORDER BY Id_kategori ASC, Harga DESC;

-- 4
ALTER TABLE NFT MODIFY COLUMN Harga DECIMAL(15,6);

-- 5
SELECT P.Username, N.Nama_nft FROM Pengguna P LEFT JOIN NFT N ON P.Id_pengguna = N.Id_kreator;
SELECT P.Username, N.Nama_nft FROM Pengguna P RIGHT JOIN NFT N ON P.Id_pengguna = N.Id_kreator;
SELECT N1.Nama_nft AS NFT_1, N2.Nama_nft AS NFT_2 FROM NFT N1 JOIN NFT N2 ON N1.Harga > N2.Harga;

-- 6
-- 1. Mengambil NFT yang harganya lebih dari 3
SELECT * FROM NFT
WHERE Harga > 3;

-- 2. Mengambil NFT yang harganya kurang dari atau sama dengan 2
SELECT * FROM NFT
WHERE Harga <= 2;

-- 3. Mengambil transaksi yang dilakukan oleh pengguna dengan id 1
SELECT * FROM Transaksi
WHERE Id_pembeli = 1;

-- 4. Mengambil semua NFT yang statusnya 'tersedia'
SELECT * FROM NFT
WHERE Info_status = 'tersedia';

-- 5. Mengambil NFT yang tidak berasal dari kategori Animasi 
SELECT N.Nama_nft, K.Nama_kategori
FROM NFT N
JOIN Kategori K ON N.Id_kategori = K.Id_kategori
WHERE K.Nama_kategori <> 'Animasi';
