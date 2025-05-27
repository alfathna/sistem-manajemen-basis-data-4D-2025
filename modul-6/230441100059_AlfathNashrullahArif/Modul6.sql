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
-- -- -- -- -- Modul 5 & 6 -- -- -- -- --
-- 1
UPDATE NFT SET Tanggal_upload = NOW() WHERE Id_nft = 1;
UPDATE NFT SET Tanggal_upload = NOW() - INTERVAL 6 DAY WHERE Id_nft = 2;
UPDATE NFT SET Tanggal_upload = NOW() - INTERVAL 20 DAY WHERE Id_nft = 3;
UPDATE NFT SET Tanggal_upload = NOW() - INTERVAL 2 MONTH WHERE Id_nft = 4;
UPDATE NFT SET Tanggal_upload = NOW() - INTERVAL 4 MONTH WHERE Id_nft = 5;

DELIMITER //
CREATE PROCEDURE TampilkanNFT(IN durasi VARCHAR(20))
BEGIN
    SELECT ID_nft, Nama_nft, Tanggal_upload FROM NFT
    WHERE 
        (durasi = 'SEMINGGU' AND Tanggal_upload >= NOW() - INTERVAL 7 DAY)
        OR
        (durasi = '1 BULAN' AND Tanggal_upload >= NOW() - INTERVAL 1 MONTH)
        OR
        (durasi = '3 BULAN' AND Tanggal_upload >= NOW() - INTERVAL 3 MONTH);
END //
DELIMITER ;
CALL TampilkanNFT('SEMINGGU');
CALL TampilkanNFT('1 BULAN');
CALL TampilkanNFT('3 BULAN');

-- 2
INSERT INTO Transaksi (Id_nft, Id_kreator, Id_pembeli, Harga_beli) VALUES
(4, 4, 6, 5.1000), 
(5, 5, 7, 1.3000), 
(6, 6, 8, 5.6000); 

UPDATE Transaksi SET Tanggal_transaksi = NOW() - INTERVAL 2 YEAR WHERE Id_transaksi IN (11, 12);

ALTER TABLE Transaksi ADD Status_pembayaran ENUM('belum lunas', 'lunas') DEFAULT 'lunas';

DELIMITER //
CREATE PROCEDURE HapusTransaksiLamaValid()
BEGIN
    DELETE FROM Transaksi
    WHERE Tanggal_transaksi < NOW() - INTERVAL 1 YEAR
    AND Status_pembayaran = 'lunas';
    SELECT Id_transaksi, Harga_beli, Tanggal_transaksi, Status_pembayaran FROM Transaksi;
END //
DELIMITER ;
CALL HapusTransaksiLamaValid();

-- 3 
ALTER TABLE Transaksi ADD COLUMN Status_transaksi ENUM('sukses', 'tidak sukses') DEFAULT 'tidak sukses';

DELIMITER //
CREATE PROCEDURE UbahStatusTransaksi()
BEGIN
    UPDATE Transaksi
    SET Status_transaksi = 'sukses'
    WHERE Id_transaksi IN (
        SELECT Id_transaksi FROM (
            SELECT Id_transaksi
            FROM Transaksi
            WHERE Status_transaksi = 'tidak sukses'
            ORDER BY Id_transaksi ASC
            LIMIT 7
        ) AS sub
    );
    SELECT * FROM Transaksi ORDER BY Id_transaksi;
END //
DELIMITER ;
CALL UbahStatusTransaksi();

-- 4
DELIMITER //
CREATE PROCEDURE EditPengguna(
    IN p_Id_pengguna INT,
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_sandi VARCHAR(100)
)
BEGIN
    UPDATE Pengguna
    SET Username = p_username,
        Email = p_email,
        Sandi = p_sandi
    WHERE Id_pengguna = p_Id_pengguna
      AND NOT EXISTS (
        SELECT 1 FROM Transaksi 
        WHERE Id_kreator = p_Id_pengguna OR Id_pembeli = p_Id_pengguna
      );
    SELECT * FROM Pengguna WHERE Id_pengguna = p_Id_pengguna;
END //
DELIMITER ;
CALL EditPengguna(11, 'AlifUpdated', 'alif_updated@mail.com', 'alif456');
SELECT * FROM Pengguna WHERE Id_pengguna = 3;

INSERT INTO Pengguna (Username, Email, Sandi) VALUES
('Alif', 'alif@mail.com', 'alif123');

SELECT * FROM Pengguna;

-- 5 
ALTER TABLE Transaksi ADD COLUMN Status_performa ENUM('non-aktif', 'pasif', 'aktif') DEFAULT 'non-aktif';

DELIMITER //
CREATE PROCEDURE UpdateStatusTransaksi()
BEGIN
    DECLARE min_count INT;
    DECLARE max_count INT;
    DECLARE mid_count INT;

    SELECT MIN(jumlah), MAX(jumlah)
    INTO min_count, max_count
    FROM (
        SELECT Id_pembeli, COUNT(*) AS jumlah
        FROM Transaksi
        WHERE Tanggal_transaksi >= NOW() - INTERVAL 1 MONTH
        GROUP BY Id_pembeli
    ) AS stats;

    SET mid_count = (min_count + max_count) / 2;

    UPDATE Transaksi t
    JOIN (
        SELECT Id_pembeli, COUNT(*) AS jumlah
        FROM Transaksi
        WHERE Tanggal_transaksi >= NOW() - INTERVAL 1 MONTH
        GROUP BY Id_pembeli
    ) AS tr ON t.Id_pembeli = tr.Id_pembeli
    SET t.Status_performa = 
        CASE 
            WHEN tr.jumlah = min_count THEN 'non-aktif'
            WHEN tr.jumlah = max_count THEN 'aktif'
            WHEN tr.jumlah = mid_count THEN 'pasif'
            ELSE t.Status_performa
        END
    WHERE t.Tanggal_transaksi >= NOW() - INTERVAL 1 MONTH;

    SELECT * FROM Transaksi;
END //
DELIMITER ;
CALL UpdateStatusTransaksi();

-- 6
DELIMITER //
CREATE PROCEDURE HitungTransaksiSukses()
BEGIN
    DECLARE total INT DEFAULT 0;
    DECLARE hitung INT DEFAULT 0;

    SELECT COUNT(*) INTO total
    FROM Transaksi
    WHERE Status_transaksi = 'sukses'
      AND Tanggal_transaksi >= NOW() - INTERVAL 1 MONTH;

    WHILE hitung < total DO
        SET hitung = hitung + 1;
    END WHILE;

    SELECT CONCAT('Jumlah transaksi sukses: ', hitung) AS hasil;
END //
DELIMITER ;
CALL HitungTransaksiSukses();

	




















