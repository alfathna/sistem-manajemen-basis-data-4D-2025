-- MODUL 1

-- Membuat database
DROP DATABASE bengkel_motor;
CREATE DATABASE bengkel_motor;
USE bengkel_motor;

-- Tabel Master: Pelanggan
CREATE TABLE pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    alamat TEXT,
    no_telepon VARCHAR(20),
    email VARCHAR(100)
);

INSERT INTO pelanggan (nama, alamat, no_telepon, email) VALUES
('Andi', 'Jl. Raya No. 15, Sidoarjo', '081234567890', 'andi_sidoarjo@gmail.com'),
('Budi', 'Jl. Madu No. 7, Surabaya', '082198765432', 'budi.surabaya@gmail.com'),
('Zara', 'Jl. Kemuning No. 3, Gresik', '081234567893', 'zara.gresik@gmail.com'),
('Rudi', 'Jl. Cendana No. 9, Mojokerto', '082123456789', 'rudi.mojokerto@gmail.com'),
('Lina', 'Jl. Merpati No. 12, Bangkalan', '081345678912', 'lina.bangkalan@gmail.com');



-- Tabel Master: Mekanik
CREATE TABLE mekanik (
    id_mekanik INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    spesialisasi VARCHAR(100),
    no_telepon VARCHAR(20)
);

INSERT INTO mekanik (nama, spesialisasi, no_telepon) VALUES
('Pak Joko', 'Mesin', '081345678901'),
('Pak Josddd', 'Mesin', '081345678922'),
('Pak Dedi', 'Kelistrikan', '082198765432'),
('Bu Sari', 'Rem & Suspensi', '081398762341'),
('Pak Anton', 'Karburator & Injeksi', '082223456789'),
('Pak Rudi', 'Body & Cat', '083145672341');




-- Tabel Master: Layanan
CREATE TABLE layanan (
    id_layanan INT AUTO_INCREMENT PRIMARY KEY,
    nama_layanan VARCHAR(100),
    deskripsi TEXT,
    harga DECIMAL(10, 2)
);

INSERT INTO layanan (nama_layanan, deskripsi, harga) VALUES
('Ganti Oli', 'Mengganti oli mesin', 50000),
('Service Rem', 'Pemeriksaan dan perbaikan sistem rem', 75000),
('Tune Up', 'Penyetelan dan pemeriksaan menyeluruh', 100000),
('Ganti Busi', 'Mengganti busi mesin motor', 30000),
('Cek Kelistrikan', 'Pemeriksaan sistem kelistrikan', 40000);




-- Tabel Master: Suku Cadang
CREATE TABLE suku_cadang (
    id_suku_cadang INT AUTO_INCREMENT PRIMARY KEY,
    nama_suku_cadang VARCHAR(100),
    stok INT,
    harga DECIMAL(10, 2)
);

INSERT INTO suku_cadang (nama_suku_cadang, stok, harga) VALUES
('Oli Mesin', 100, 40000),
('Kampas Rem', 50, 60000),
('Busi', 70, 25000),
('Aki', 30, 200000),
('Filter Udara', 40, 35000);




-- Tabel Transaksi: Transaksi Service
CREATE TABLE transaksi_service (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    tanggal DATE,
    id_pelanggan INT,
    id_mekanik INT,
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan),
    FOREIGN KEY (id_mekanik) REFERENCES mekanik(id_mekanik)
);


INSERT INTO transaksi_service (tanggal, id_pelanggan, id_mekanik) VALUES
('2025-04-30', 1, 1),
('2025-04-30', 2, 2),
('2025-05-01', 3, 1),
('2025-05-02', 4, 3),
('2025-05-03', 5, 2);



-- Tabel Detail: Detail Layanan
CREATE TABLE detail_layanan (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_transaksi INT,
    id_layanan INT,
    jumlah INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_transaksi) REFERENCES transaksi_service(id_transaksi),
    FOREIGN KEY (id_layanan) REFERENCES layanan(id_layanan)
);

INSERT INTO detail_layanan (id_transaksi, id_layanan, jumlah, subtotal) VALUES
(1, 1, 1, 50000.00),
(2, 3, 1, 100000.00),
(3, 2, 1, 75000.00),
(4, 4, 1, 30000.00),
(5, 5, 1, 60000.00);




-- Tabel Detail: Detail Suku Cadang
CREATE TABLE detail_suku_cadang (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_transaksi INT,
    id_suku_cadang INT,
    jumlah INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_transaksi) REFERENCES transaksi_service(id_transaksi),
    FOREIGN KEY (id_suku_cadang) REFERENCES suku_cadang(id_suku_cadang)
);

INSERT INTO detail_suku_cadang (id_transaksi, id_suku_cadang, jumlah, subtotal) VALUES
(2, 3, 1, 40000),
(4, 5, 2, 50000),
(3, 1, 3, 60000),
(1, 4, 2, 35000),
(5, 2, 1, 70000);



SELECT * FROM pelanggan
SELECT * FROM mekanik
SELECT * FROM layanan
SELECT * FROM suku_cadang
SELECT * FROM transaksi_service
SELECT * FROM detail_layanan
SELECT * FROM detail_suku_cadang



-- MODUL 2


-- View 1: Menampilkan data transaksi dan informasi pelanggan
CREATE VIEW view_transaksi_pelanggan AS
SELECT 
    ts.id_transaksi, 
    ts.tanggal, 
    p.nama AS nama_pelanggan, 
    p.no_telepon
FROM 
    transaksi_service ts
    INNER JOIN pelanggan p ON ts.id_pelanggan = p.id_pelanggan;

-- Cek isi view
SELECT * FROM view_transaksi_pelanggan;

	

-- View 2: Menampilkan data lengkap transaksi, pelanggan, dan mekanik, colum
CREATE VIEW view_detail_transaksi AS
SELECT 
    ts.id_transaksi, 
    ts.tanggal, 
    p.nama AS nama_pelanggan, 
    m.nama AS nama_mekanik, 
    m.spesialisasi
FROM 
    transaksi_service ts
    INNER JOIN pelanggan p ON ts.id_pelanggan = p.id_pelanggan
    INNER JOIN mekanik m ON ts.id_mekanik = m.id_mekanik;

-- Cek isi view
SELECT * FROM view_detail_transaksi;


-- REVISI 
-- View 3: Menampilkan layanan dengan subtotal lebih dari 60.000
CREATE VIEW view_layanan_mahal AS
SELECT 
    dl.id_transaksi, 
    l.nama_layanan, 
    dl.jumlah, 
    dl.subtotal
FROM 
    detail_layanan dl
    JOIN layanan l ON dl.id_layanan = l.id_layanan
WHERE 
    dl.subtotal > 60000;

-- Cek isi view
SELECT * FROM view_layanan_mahal;


-- GA ADA AGREGASI
-- View 4: Menampilkan total biaya layanan dan suku cadang per transaksi, menghidar dari nilai null ,+COLUM, hapus duplikat
CREATE VIEW view_total_biaya_per_transaksi AS
SELECT 
    ts.id_transaksi,
    COALESCE(SUM(DISTINCT dl.subtotal), 0) AS total_layanan,
    COALESCE(SUM(DISTINCT ds.subtotal), 0) AS total_suku_cadang,
    COALESCE(SUM(DISTINCT dl.subtotal), 0) + COALESCE(SUM(DISTINCT ds.subtotal), 0) AS total_biaya
FROM
#LEFT JOIN agar transaksi tetap ditampilkan meskipun belum ada layanan atau suku cadang.

    transaksi_service ts
    LEFT JOIN detail_layanan dl ON ts.id_transaksi = dl.id_transaksi
    LEFT JOIN detail_suku_cadang ds ON ts.id_transaksi = ds.id_transaksi
GROUP BY 
    ts.id_transaksi;

-- Cek isi view, mengelompokkan data berdasarkan satu atau lebih kolom,
SELECT * FROM view_total_biaya_per_transaksi;



-- View 5: Ringkasan transaksi (nama pelanggan, tanggal, dan total biaya), mengelompokkan data
CREATE VIEW view_ringkasan_transaksi AS
SELECT 
    ts.id_transaksi, 
    p.nama AS nama_pelanggan, 
    ts.tanggal,
    COALESCE(SUM(DISTINCT dl.subtotal), 0) + COALESCE(SUM(DISTINCT ds.subtotal), 0) AS total_biaya
FROM 
    transaksi_service ts
    INNER JOIN pelanggan p ON ts.id_pelanggan = p.id_pelanggan
    LEFT JOIN detail_layanan dl ON ts.id_transaksi = dl.id_transaksi
    LEFT JOIN detail_suku_cadang ds ON ts.id_transaksi = ds.id_transaksi
GROUP BY 
    ts.id_transaksi, p.nama, ts.tanggal;

-- Cek isi view
SELECT * FROM view_ringkasan_transaksi;





-- MODUL 4


-- 1. Kolom keterangan di salah satu tabel (contoh: layanan)
ALTER TABLE layanan ADD COLUMN keterangan TEXT;

-- Contoh update keterangan
UPDATE layanan SET keterangan = 'eeeeee' WHERE nama_layanan = 'Ganti Oli';
UPDATE layanan SET keterangan = 'Cek rem rutin untuk keselamatan' WHERE nama_layanan = 'Service Rem';
UPDATE layanan SET keterangan = 'Service berkala untuk performa optimal' WHERE nama_layanan = 'Tune Up';
UPDATE layanan SET keterangan = 'biar tidak brebet' WHERE nama_layanan = 'Ganti Busi';
UPDATE layanan SET keterangan = 'untuk ga mati total' WHERE nama_layanan = 'cek Kelistrikan';
SELECT * FROM layanan

-- 2. Gabungan 2 tabel yang memungkinkan dan fungsional: pelanggan dan transaksi
SELECT 
    ts.id_transaksi,
    ts.tanggal,
    p.nama AS nama_pelanggan,
    p.no_telepon
FROM 
    transaksi_service ts
JOIN 
    pelanggan p ON ts.id_pelanggan = p.id_pelanggan;

-- 3. Order By ASC dan DESC
-- ASC: Menampilkan pelanggan berdasarkan nama A-Z
SELECT * FROM pelanggan ORDER BY nama ASC;

-- DESC: Menampilkan layanan berdasarkan harga tertinggi
SELECT * FROM layanan ORDER BY harga DESC;

-- DESC: Menampilkan suku cadang berdasarkan stok terbanyak
SELECT * FROM suku_cadang ORDER BY stok DESC;

-- 4. Perubahan tipe data: ubah panjang no_telepon di tabel mekanik
ALTER TABLE mekanik MODIFY no_telepon VARCHAR(30);

-- 5. LEFT JOIN: Menampilkan semua transaksi, walaupun belum ada layanan
SELECT 
    ts.id_transaksi,
    ts.tanggal,
    p.nama AS nama_pelanggan,
    l.nama_layanan,
    dl.subtotal
FROM transaksi_service ts
LEFT JOIN detail_layanan dl ON ts.id_transaksi = dl.id_transaksi
LEFT JOIN layanan l ON dl.id_layanan = l.id_layanan
JOIN pelanggan p ON ts.id_pelanggan = p.id_pelanggan;

-- 5. RIGHT JOIN: Menampilkan semua layanan walaupun belum digunakan
SELECT 
    l.nama_layanan,
    dl.jumlah,
    ts.id_transaksi
FROM detail_layanan dl
RIGHT JOIN layanan l ON dl.id_layanan = l.id_layanan
LEFT JOIN transaksi_service ts ON dl.id_transaksi = ts.id_transaksi;

-- 5. SELF JOIN: Menampilkan pelanggan yang punya nama depan sama (simulasi)
SELECT 
    p1.id_pelanggan, p1.nama AS nama1,
    p2.id_pelanggan, p2.nama AS nama2
FROM pelanggan p1
JOIN pelanggan p2 ON p1.id_pelanggan <> p2.id_pelanggan
WHERE LEFT(p1.nama, 1) = LEFT(p2.nama, 1);

-- 6. Operator perbandingan
-- a. Pelanggan dengan id lebih dari 1
SELECT * FROM pelanggan WHERE id_pelanggan > 1;

-- b. Layanan dengan harga lebih dari atau sama dengan 75000
SELECT * FROM layanan WHERE harga >= 75000;

-- c. Suku cadang dengan stok kurang dari 60
SELECT * FROM suku_cadang WHERE stok < 60;

-- d. Suku cadang dengan harga tidak sama dengan 25000
SELECT * FROM suku_cadang WHERE harga <> 25000;

-- e. Transaksi yang dilakukan pada tanggal tertentu
SELECT * FROM transaksi_service WHERE tanggal = '2025-04-30';








