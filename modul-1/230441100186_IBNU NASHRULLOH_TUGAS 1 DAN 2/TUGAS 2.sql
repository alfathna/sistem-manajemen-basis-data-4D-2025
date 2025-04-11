CREATE DATABASE Bioskop;
USE Bioskop;

-- Tabel Master
CREATE TABLE Film (
    kode_film CHAR(5) PRIMARY KEY,
    judul VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    durasi INT,
    rating VARCHAR(10)
);

CREATE TABLE Studio (
    id_studio INT PRIMARY KEY AUTO_INCREMENT,
    nama_studio VARCHAR(50) NOT NULL,
    kapasitas INT NOT NULL
);

CREATE TABLE Pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_hp VARCHAR(15) NOT NULL
);

-- Tabel Transaksi (Tanpa FK dulu)
CREATE TABLE Jadwal_Film (
    id_jadwal INT PRIMARY KEY AUTO_INCREMENT,
    kode_film CHAR(5),
    id_studio INT,
    tanggal DATE,
    jam_tayang TIME
);

CREATE TABLE Tiket (
    id_tiket INT PRIMARY KEY AUTO_INCREMENT,
    id_pelanggan INT,
    id_jadwal INT,
    jumlah INT,
    total_harga DECIMAL(10,2)
);

CREATE TABLE Pembayaran (
    id_pembayaran INT PRIMARY KEY AUTO_INCREMENT,
    id_tiket INT,
    metode_pembayaran VARCHAR(50) NOT NULL,
    tanggal_pembayaran DATE NOT NULL,
    jumlah_bayar DECIMAL(10,2) NOT NULL
);

-- Foreign Key Jadwal_Film
ALTER TABLE Jadwal_Film
ADD CONSTRAINT fk_jadwal_film_film
FOREIGN KEY (kode_film) REFERENCES Film(kode_film) ON DELETE CASCADE;

ALTER TABLE Jadwal_Film
ADD CONSTRAINT fk_jadwal_film_studio
FOREIGN KEY (id_studio) REFERENCES Studio(id_studio) ON DELETE CASCADE;

-- Foreign Key Tiket
ALTER TABLE Tiket
ADD CONSTRAINT fk_tiket_pelanggan
FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan) ON DELETE CASCADE;

ALTER TABLE Tiket
ADD CONSTRAINT fk_tiket_jadwal
FOREIGN KEY (id_jadwal) REFERENCES Jadwal_Film(id_jadwal) ON DELETE CASCADE;

-- Foreign Key Pembayaran
ALTER TABLE Pembayaran
ADD CONSTRAINT fk_pembayaran_tiket
FOREIGN KEY (id_tiket) REFERENCES Tiket(id_tiket) ON DELETE CASCADE;

INSERT INTO Pembayaran (id_tiket, metode_pembayaran, tanggal_pembayaran,jumlah_bayar) VALUES
(17, 'E-Wallet', '2024-03-25', 100000),
(20, 'Kartu Kredit', '2024-03-26', 50000);

 
INSERT INTO Film (kode_film, judul, genre, durasi, rating) VALUES
('F001', 'Avengers: Endgame', 'Action', 181, 'PG-13'),
('F002', 'Joker', 'Drama', 122, 'R');

INSERT INTO Studio (nama_studio, kapasitas) VALUES
('Studio 1', 150),
('Studio 2', 100);

INSERT INTO Jadwal_Film (kode_film, id_studio, tanggal, jam_tayang) VALUES
('F001', 1, '2024-03-25', '18:30:00'),
('F002', 2, '2024-03-25', '20:00:00');

INSERT INTO Tiket (id_pelanggan, id_jadwal, jumlah, total_harga) VALUES 
(3, 3, 2, 100000), 
(2, 2, 3, 50000);

INSERT INTO Pelanggan (nama, email, no_hp) VALUES 
('Budi Santoso', 'budi@email.com', '081234567890'),
('Siti Aminah', 'siti@email.com', '081298765432');

-- Ubah nama pelanggan
UPDATE Pelanggan
SET nama = 'Andi Pratama'
WHERE id_pelanggan = 1;

-- Ubah jadwal film
UPDATE Jadwal_Film
SET jam_tayang = '20:00:00'
WHERE id_jadwal = 1;

-- Ubah jumlah tiket
UPDATE Tiket
SET jumlah = 3, total_harga = 120000
WHERE id_tiket = 1;

-- Ubah nama pelanggan
UPDATE Pelanggan
SET nama = 'Andi Pratama'
WHERE id_pelanggan = 1;

-- Ubah jadwal film
UPDATE Jadwal_Film
SET jam_tayang = '20:00:00'
WHERE id_jadwal = 1;

-- Ubah jumlah tiket
UPDATE Tiket
SET jumlah = 3, total_harga = 120000
WHERE id_tiket = 1;

SELECT * FROM Pelanggan
WHERE nama LIKE '%Budi%';

SELECT * FROM Pelanggan;
SELECT * FROM Film;
SELECT * FROM Studio;
SELECT * FROM Jadwal_Film;
SELECT * FROM Tiket;
SELECT * FROM pembayaran;

SELECT * FROM Tiket
WHERE id_pelanggan = 3;

SELECT * FROM Jadwal_Film
WHERE tanggal = '2024-04-20';


