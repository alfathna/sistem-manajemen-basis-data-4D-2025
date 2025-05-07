-- Tabel Master

-- Membuat database
-- Drop dan buat ulang database
DROP DATABASE IF EXISTS Bioskop1;
CREATE DATABASE Bioskop1;
USE Bioskop1;

-- Buat semua tabel
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

-- Tambahkan constraint FK
ALTER TABLE Jadwal_Film
ADD CONSTRAINT fk_jadwal_film_film
FOREIGN KEY (kode_film) REFERENCES Film(kode_film) ON DELETE CASCADE;

ALTER TABLE Jadwal_Film
ADD CONSTRAINT fk_jadwal_film_studio
FOREIGN KEY (id_studio) REFERENCES Studio(id_studio) ON DELETE CASCADE;

ALTER TABLE Tiket
ADD CONSTRAINT fk_tiket_pelanggan
FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan) ON DELETE CASCADE;

ALTER TABLE Tiket
ADD CONSTRAINT fk_tiket_jadwal
FOREIGN KEY (id_jadwal) REFERENCES Jadwal_Film(id_jadwal) ON DELETE CASCADE;

ALTER TABLE Pembayaran
ADD CONSTRAINT fk_pembayaran_tiket
FOREIGN KEY (id_tiket) REFERENCES Tiket(id_tiket) ON DELETE CASCADE;

-- Isi data (dengan urutan yang benar)
INSERT INTO Pelanggan (nama, email, no_hp) VALUES 
('Budi Santoso', 'budi@email.com', '081234567890'),
('Siti Aminah', 'siti@email.com', '081298765432');

INSERT INTO Pelanggan (nama, email, no_hp) VALUES 
('Bilkis', 'bilkis@email.com', '08208307483');

INSERT INTO Pelanggan (nama, email, no_hp) VALUES 
('Budi juga', 'budia@emil.com', '08208307483');

INSERT INTO Film (kode_film, judul, genre, durasi, rating) VALUES
('F001', 'Avengers: Endgame', 'Action', 181, 'PG-13'),
('F002', 'Joker', 'Drama', 122, 'R');

INSERT INTO Studio (nama_studio, kapasitas) VALUES
('Studio 1', 150),
('Studio 2', 100);

INSERT INTO Jadwal_Film (kode_film, id_studio, tanggal, jam_tayang) VALUES
('F001', 1, '2024-03-25', '18:30:00'),
('F002', 2, '2024-03-25', '20:00:00');

-- Perhatikan id_jadwal dan id_pelanggan
-- id_pelanggan = 1 dan 2; id_jadwal = 1 dan 2
INSERT INTO Tiket (id_pelanggan, id_jadwal, jumlah, total_harga) VALUES 
(1, 1, 2, 100000), 
(2, 2, 3, 150000);

-- Sekarang id_tiket adalah 1 dan 2
INSERT INTO Pembayaran (id_tiket, metode_pembayaran, tanggal_pembayaran, jumlah_bayar) VALUES
(1, 'E-Wallet', '2024-03-25', 100000),
(2, 'Kartu Kredit', '2024-03-26', 150000);


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


-- 1. Menambahkan kolom keterangan dan mengisi data
ALTER TABLE Tiket ADD COLUMN keterangan VARCHAR(255) AFTER total_harga;

UPDATE Tiket SET keterangan = 'Pembelian online' WHERE id_tiket = 1;
UPDATE Tiket SET keterangan = 'Pembelian offline' WHERE id_tiket = 2;

SELECT * FROM Tiket;
-- 2. Gabungan tabel dengan JOIN
SELECT 
    t.id_tiket, 
    p.nama AS pelanggan, 
    f.judul AS film, 
    j.tanggal, 
    j.jam_tayang,
    s.nama_studio,
    t.jumlah,
    t.total_harga,
    t.keterangan
FROM Tiket t
JOIN Pelanggan p ON t.id_pelanggan = p.id_pelanggan
JOIN Jadwal_Film j ON t.id_jadwal = j.id_jadwal
JOIN Film f ON j.kode_film = f.kode_film
JOIN Studio s ON j.id_studio = s.id_studio;

-- 3. Contoh ORDER BY dengan data yang ada
-- ASC
SELECT * FROM Film ORDER BY judul ASC;

-- DESC
SELECT * FROM Pelanggan ORDER BY id_pelanggan DESC;

-- Multiple columns
SELECT * FROM Jadwal_Film ORDER BY tanggal ASC, jam_tayang ASC;

-- 4. Perubahan tipe data
ALTER TABLE Pelanggan MODIFY COLUMN no_hp VARCHAR(20);
SELECT * FROM pelanggan;
-- 5. Join examples with current data
-- Left Join
SELECT f.judul, j.tanggal, j.jam_tayang
FROM Film f
LEFT JOIN Jadwal_Film j ON f.kode_film = j.kode_film;

-- Right Join
SELECT f.judul, j.tanggal, j.jam_tayang
FROM Film f
RIGHT JOIN Jadwal_Film j ON f.kode_film = j.kode_film;

-- Self Join (mencari pelanggan dengan nama depan sama)
SELECT p1.nama AS nama1, p2.nama AS nama2
FROM Pelanggan p1
JOIN Pelanggan p2 ON SUBSTRING_INDEX(p1.nama, ' ', 1) = SUBSTRING_INDEX(p2.nama, ' ', 1)
WHERE p1.id_pelanggan < p2.id_pelanggan;

-- 6. Operator perbandingan dengan data yang ada
-- =
SELECT * FROM Film WHERE rating = 'PG-13';

-- !=
SELECT * FROM Studio WHERE kapasitas != 100;

-- >
SELECT * FROM Film WHERE durasi > 150;

-- <=
SELECT * FROM Tiket WHERE total_harga <= 100000;

-- BETWEEN
SELECT * FROM Jadwal_Film 
WHERE jam_tayang BETWEEN '18:00:00' AND '22:00:00';

-- LIKE
SELECT * FROM Pelanggan WHERE email LIKE '%@email.com'; 