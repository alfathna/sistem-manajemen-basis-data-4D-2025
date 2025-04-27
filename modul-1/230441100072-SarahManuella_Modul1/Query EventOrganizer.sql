CREATE DATABASE eventorganize;
USE eventorganize;

CREATE TABLE org (
id_org INT PRIMARY KEY AUTO_INCREMENT,
nama_org VARCHAR (100),
contact_info VARCHAR(100),
email VARCHAR (100)
);

ALTER TABLE org RENAME TO penyelenggara;

CREATE TABLE acara (
id_acara INT PRIMARY KEY AUTO_INCREMENT,
nama_acara VARCHAR (100),
tanggal_acara DATE,
lokasi VARCHAR(100),
id_org INT,
FOREIGN KEY (id_org) REFERENCES penyelenggara(id_org) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE acara 
MODIFY COLUMN id_acara INT PRIMARY KEY;


CREATE TABLE partisipan (
id_peserta INT PRIMARY KEY AUTO_INCREMENT,
nama_peserta VARCHAR (100),
email VARCHAR (50)
);

CREATE TABLE detail_partisipan(
id_acara INT,
id_peserta INT,
tgl_registrasi DATE NOT NULL,
PRIMARY KEY(id_acara,id_peserta),
FOREIGN KEY(id_acara) REFERENCES acara(id_acara),
FOREIGN KEY(id_peserta) REFERENCES partisipan(id_peserta)
);

DELETE FROM

CREATE TABLE Tiket (
id_tiket INT PRIMARY KEY AUTO_INCREMENT,
tipe_tiket ENUM ('Regular','VIP','Student','Early Bird') NOT NULL,
harga DECIMAL(10,2) NOT NULL,
id_acara INT,
id_peserta INT,
FOREIGN KEY (id_acara) REFERENCES acara (id_acara),
FOREIGN KEY (id_peserta) REFERENCES partisipan (id_peserta)
);

CREATE TABLE sponsorship (
id_sponsor INT PRIMARY KEY AUTO_INCREMENT,
nama_sponsor VARCHAR (100) NOT NULL,
jumlah DECIMAL (10,2) NOT NULL,
id_acara INT,
FOREIGN KEY (id_acara) REFERENCES acara (id_acara)
);

ALTER TABLE sponsorship
DROP FOREIGN KEY id_acara ;
INSERT INTO penyelenggara (nama_org, contact_info, email) VALUES
('suka tani','sarah@gmail.com','sarah@gmail.com');


SELECT * FROM penyelenggara;


INSERT INTO penyelenggara (nama_org, contact_info, email) VALUES
('Suka Tani', 'Sarah', 'sarah@gmail.com'),
('Seadanyaa', '08123456789', 'Seadanya@gmail.com'),
('FLTU', '08123456780', 'FLTU@gmail.com'),
('SMBD', '08123456781', 'SMBDC@gmail.com'),
('Ini Itu', '08123456782', 'INIitu@gmail.com');

INSERT INTO acara (nama_acara, tanggal_acara, lokasi, id_org) VALUES
('Festival Pertanian', '2025-08-21', 'Lapangan Merdeka', 1),
('Konferensi Teknologi', '2025-07-20', 'Hotel Bintang Lima', 2),
('Pameran Seni', '2025-06-20', 'Galeri Seni', 3),
('Workshop Kewirausahaan', '2025-05-20', 'Kampus Universitas', 4),
('Seminar Kesehatan', '2025-04-15', 'Ruang Serbaguna', 5);

INSERT INTO partisipan (nama_peserta, email) VALUES
('Andi', 'andi@gmail.com'),
('Budi', 'budi@gmail.com'),
('Cindy', 'cindy@gmail.com'),
('Diana', 'diana@gmail.com'),
('Eko', 'eko@gmail.com'),
('Fani', 'fani@gmail.com'),
('Gina', 'gina@gmail.com'),
('Hadi', 'hadi@gmail.com'),
('Ika', 'ika@gmail.com'),
('Joko', 'joko@gmail.com');


INSERT INTO detail_partisipan (id_acara, id_peserta, tgl_registrasi) VALUES
(1, 1, '2025-08-01'),
(1, 2, '2025-08-02'),
(2, 3, '2025-07-15'),
(2, 4, '2025-07-16'),
(3, 5, '2025-06-10'),
(3, 6, '2025-06-11'),
(4, 7, '2025-05-05'),
(4, 8, '2025-05-06'),
(5, 9, '2025-04-10'),
(5, 10, '2025-04-11');

INSERT INTO Tiket (tipe_tiket, harga, id_acara, id_peserta) VALUES
('Regular', 100000.00, 1, 1),
('VIP', 250000.00, 1, 2),
('Student', 50000.00, 2, 3),
('Early Bird', 75000.00, 2, 4),
('Regular', 100000.00, 3, 5),
('VIP', 250000.00, 3, 6),
('Student', 50000.00, 4, 7),
('Early Bird', 75000.00, 4, 8),
('Regular', 100000.00, 5, 9),
('VIP', 250000.00, 5, 10);

INSERT INTO sponsorship (nama_sponsor, jumlah, id_acara) VALUES
('Sponsor A', 5000000.00, 1),
('Sponsor B', 3000000.00, 2),
('Sponsor C', 2000000.00, 3),
('Sponsor D', 4000000.00, 4),
('Sponsor E', 1000000.00, 5);

#Soal 1 (2 TABEL)
CREATE VIEW view_harga_tiket
AS SELECT 
a.harga AS "Harga Tiket",
b.nama_acara AS "Acara"
FROM tiket a
JOIN acara b ON a.id_acara = b.id_acara;
SELECT * FROM view_harga_tiket;

#Soal2 (3 TABEL)
CREATE VIEW view_sponsor AS 
SELECT
a.nama_acara AS "Nama Acara",
b.nama_org AS "Penyelenggara",
c.nama_sponsor AS "Sponsorship",
a.tanggal_acara AS "Tanggal Acara"
FROM 
acara a
JOIN 
penyelenggara b ON a.id_org = b.id_org
JOIN 
sponsorship c ON a.id_acara = c.id_acara;
SELECT * FROM view_sponsor;

#Soal 3

CREATE VIEW harga_tiket_acara AS 
SELECT 
a.harga AS "Harga Tiket",
b.nama_acara AS "Nama Acara",
a.tipe_tiket AS "Tipe Tiket"
FROM 
Tiket a
JOIN 
acara b ON a.id_acara = b.id_acara
WHERE 
a.tipe_tiket = 'VIP';

SELECT * FROM harga_tiket_acara;

#Soal nomor 4
CREATE VIEW view_total_pendapatan_acara AS 
SELECT 
a.nama_acara AS "Nama Acara",
SUM(t.harga) AS "Total Pendapatan"
FROM 
Tiket t
JOIN 
acara a ON t.id_acara = a.id_acara
GROUP BY 
a.id_acara, a.nama_acara;
SELECT * FROM view_total_pendapatan_acara;

#Soal nomor 5
CREATE VIEW view_statistik_acara AS 
SELECT 
a.nama_acara AS "Nama Acara",
COUNT(dp.id_peserta) AS "Jumlah Partisipan",
AVG(t.harga) AS "Rata-rata Harga Tiket"
FROM 
acara a
LEFT JOIN 
detail_partisipan dp ON a.id_acara = dp.id_acara
LEFT JOIN 
Tiket t ON a.id_acara = t.id_acara
GROUP BY 
a.id_acara, a.nama_acara;

SELECT * FROM view_statistik_acara;


CREATE
    /*[ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = { user | CURRENT_USER }]
    [SQL SECURITY { DEFINER | INVOKER }]*/
    VIEW `eventorganize`.`viewacara_sponshorship` 
    AS
SELECT a.nama_acara AS "Nama Acara",
a.lokasi AS "Lokasi Acara",
a.tanggal_acara AS "Tanggal Pelaksanaan",
b.nama_sponsor AS "Sponsorship"

FROM acara a
JOIN sponsorship b ON a.id_acara = b.id_acara;

SELECT * FROM viewacara_sponshorship;


CREATE VIEW view_acara_partisipan AS 
SELECT 
    p.nama_peserta AS "Nama Peserta",
    a.nama_acara AS "Nama Acara",
    dp.tgl_registrasi AS "Tanggal Registrasi",
    a.tanggal_acara AS "Tanggal Acara"
FROM 
    detail_partisipan dp
JOIN 
    partisipan p ON dp.id_peserta = p.id_peserta
JOIN 
    acara a ON dp.id_acara = a.id_acara;

SELECT * FROM view_acara_partisipan;

#MODUL 4
#Menamahkan kolom keterangan di salah satu tabel 
ALTER TABLE acara ADD COLUMN keterangan VARCHAR (255);
DESCRIBE acara;
#2.gabungan 2 tabel yang memungkinkan memiliki fungsi 
CREATE VIEW view_acara_partisipan_2 AS 
SELECT 
a.nama_acara AS "Nama Acara",
b.nama_peserta AS "Nama Peserta"
FROM acara a
JOIN detail_partisipan c ON a.id_acara=c.id_acara
JOIN partisipan b ON c.id_peserta =b.id_peserta;
SELECT * FROM view_acara_partisipan_2;

#3.Membuat urutan kolom dengan order by 
SELECT * FROM partisipan ORDER BY nama_peserta ASC;
SELECT * FROM acara ORDER BY tanggal_acara DESC;

#4.perubahan pada salah satu tipe data
ALTER TABLE tiket MODIFY COLUMN harga FLOAT NOT NULL;
SHOW CREATE TABLE tiket;

#5.Kode left join, right join, dan self join
SELECT a.nama_acara, 
a.lokasi,
b.nama_peserta
FROM acara a
LEFT JOIN detail_partisipan c ON a.id_acara = c.id_acara
LEFT JOIN partisipan b ON c.id_peserta = b.id_peserta;

SELECT a.nama_org,
a.contact_info,
b.nama_acara
FROM 
penyelenggara a
RIGHT JOIN 
acara b ON a.id_org = b.id_org;

SELECT 
s1.id_sponsor AS "ID Sponsor 1", 
s1.nama_sponsor AS "Nama Sponsor 1", 
s2.id_sponsor AS "ID Sponsor 2", 
s2.nama_sponsor AS "Nama Sponsor 2", 
s1.id_acara AS "ID Acara 1", 
s2.id_acara AS "ID Acara 2"
FROM 
sponsorship s1
JOIN 
sponsorship s2 ON s1.nama_sponsor = s2.nama_sponsor 
AND s1.id_sponsor <> s2.id_sponsor
WHERE 
s1.id_acara <> s2.id_acara;

#Kode yang mengandung operator perbandingan
SELECT * FROM partisipan WHERE email ='andi@gmail.com';
SELECT * FROM acara WHERE tanggal_acara > '2025-06-01';
SELECT * FROM tiket WHERE harga < 500000;
SELECT * FROM sponsorship WHERE jumlah >45;
SELECT * FROM partisipan WHERE nama_peserta <> 'cindy';

