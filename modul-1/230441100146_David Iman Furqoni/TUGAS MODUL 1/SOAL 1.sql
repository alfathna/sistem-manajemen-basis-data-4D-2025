CREATE DATABASE akademik_prodi;

USE akademik_prodi;
SHOW TABLES;

---------------------------------
CREATE TABLE mahasiswa(
NIM INT (10),
nama VARCHAR (50) NOT NULL,
prodi VARCHAR (100) NOT NULL,
th_angkatan INT (10) NOT NULL,
PRIMARY KEY(NIM)
);
ALTER TABLE mahasiswa ADD alamat VARCHAR (100) NOT NULL;
ALTER TABLE mahasiswa MODIFY NIM INT (10) NOT NULL;

ALTER TABLE mahasiswa DROP COLUMN alamat;
ALTER TABLE mahasiswa ADD id_kota INT;
ALTER TABLE mahasiswa ADD FOREIGN KEY (id_kota) REFERENCES kota(id_kota);

UPDATE mahasiswa SET id_kota = 1 WHERE NIM = 21001; 
UPDATE mahasiswa SET id_kota = 2 WHERE NIM = 21002; 
UPDATE mahasiswa SET id_kota = 2 WHERE NIM = 22003; 
UPDATE mahasiswa SET id_kota = 3 WHERE NIM = 21004;
UPDATE mahasiswa SET id_kota = 4 WHERE NIM = 22005; 
UPDATE mahasiswa SET id_kota = 5 WHERE NIM = 23006; 
UPDATE mahasiswa SET id_kota = 4 WHERE NIM = 23007; 
UPDATE mahasiswa SET id_kota = 1 WHERE NIM = 21008; 
UPDATE mahasiswa SET id_kota = 3 WHERE NIM = 22009; 
UPDATE mahasiswa SET id_kota = 5 WHERE NIM = 23010; 
------------------------------------------------------------------------------

CREATE TABLE dosen (
NIP INT (10),
nama VARCHAR (50),
alamat VARCHAR (100),
PRIMARY KEY (NIP)
);
ALTER TABLE dosen ADD keahlian VARCHAR (100) NOT NULL;
SELECT * FROM dosen;

ALTER TABLE dosen 
MODIFY NIP INT (10) NOT NULL, 
MODIFY nama VARCHAR (50) NOT NULL, 
MODIFY alamat VARCHAR (100) NOT NULL;

ALTER TABLE dosen DROP COLUMN alamat;
ALTER TABLE dosen ADD id_kota INT;
ALTER TABLE dosen ADD FOREIGN KEY (id_kota) REFERENCES kota(id_kota);

UPDATE dosen SET id_kota = 1 WHERE NIP = 10001;  
UPDATE dosen SET id_kota = 6 WHERE NIP = 10002;  
UPDATE dosen SET id_kota = 5 WHERE NIP = 10003;  
UPDATE dosen SET id_kota = 4 WHERE NIP = 10004; 
UPDATE dosen SET id_kota = 2 WHERE NIP = 10005;  
UPDATE dosen SET id_kota = 3 WHERE NIP = 10006; 
UPDATE dosen SET id_kota = 7 WHERE NIP = 10007; 
UPDATE dosen SET id_kota = 8 WHERE NIP = 10008;  
UPDATE dosen SET id_kota = 9 WHERE NIP = 10009;  
UPDATE dosen SET id_kota = 10 WHERE NIP = 10010; 
----------------------------------------------------

CREATE TABLE matakuliah (
id_matkul INT (10) NOT NULL,
matkul VARCHAR (50) NOT NULL,
sks INT (10) NOT NULL,
NIP INT (10) NOT NULL,
FOREIGN KEY (NIP) REFERENCES dosen (NIP)
);
SELECT * FROM matakuliah;
ALTER TABLE matakuliah MODIFY id_matkul INT (10) PRIMARY KEY;
------------------------------------------------------------------

CREATE TABLE KRS (
id_krs INT AUTO_INCREMENT,
NIM INT(10),
id_matkul INT(10),
semester INT,
tahun_akademik VARCHAR(10),
FOREIGN KEY (NIM) REFERENCES mahasiswa(NIM),
FOREIGN KEY (id_matkul) REFERENCES matakuliah(id_matkul),
PRIMARY KEY (id_krs)
);
SELECT * FROM KRS;
-----------------------------------------

CREATE TABLE kota (
    id_kota INT AUTO_INCREMENT,
    nama_kota VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_kota)
);
-------------------------------------------

INSERT INTO mahasiswa VALUES 
(21001, 'Ali Syahputra', 'Informatika', 2021, 'Surabaya'),
(21002, 'Budi Santoso', 'Informatika', 2021, 'Sumenep'),
(22003, 'Citra Dewi', 'Sistem Informasi', 2022, 'Sumenep'),
(21004, 'Dedi Irawan', 'Sistem Informasi', 2021, 'Pamekasan'),
(22005, 'Eka Yuliani', 'Teknik Komputer', 2022, 'Pasuruan'),
(23006, 'Fajar Nugraha', 'Informatika', 2023, 'Malang'),
(23007, 'Putri Prameswari', 'Sistem Informasi', 2023, 'Pasuruan'),
(21008, 'Hana Kartika', 'Teknik Komputer', 2021, 'Surabanya'),
(22009, 'Irfan Maulana', 'Informatika', 2022, 'Pamekasan'),
(23010, 'Joko Saputra', 'Sistem Informasi', 2023, 'Malang');
SELECT * FROM mahasiswa;
---------------------------------------------------------------------

INSERT INTO dosen (NIP, nama, alamat, keahlian) VALUES
(10001, 'Dr. Siti Aminah', 'Jl. Melati No.1, Surabaya', 'Basis Data'),
(10002, 'Dr. Bambang Setiawan', 'Jl. Anggrek No.2, Sidoarjo', 'Pemrograman Web'),
(10003, 'Prof. Indra Wijaya', 'Jl. Mawar No.3, Malang', 'Kecerdasan Buatan'),
(10004, 'Dr. Lestari Handayani', 'Jl. Kamboja No.4, Pasuruan', 'Jaringan Komputer'),
(10005, 'Dr. Rudi Hartono', 'Jl. Kenanga No.5, Sumenep', 'Sistem Informasi'),
(10006, 'Dr. Nia Kurniawati', 'Jl. Teratai No.6, Pamekasan', 'Pemrograman Mobile'),
(10007, 'Dr. Tono Prabowo', 'Jl. Melur No.7, Bangkalan', 'Statistika Komputasi'),
(10008, 'Dr. Lina Marlina', 'Jl. Dahlia No.8, Lamongan', 'Multimedia'),
(10009, 'Dr. Andi Gunawan', 'Jl. Cempaka No.9, Gresik', 'Algoritma dan Struktur Data'),
(10010, 'Prof. Wahyu Santosa', 'Jl. Flamboyan No.10, Kediri', 'Machine Learning');
SELECT * FROM dosen;
--------------------------------------------------------------------------------------

INSERT INTO matakuliah (id_matkul, matkul, sks, NIP) VALUES
(2001, 'Basis Data', 3, 10001),
(2002, 'Pemrograman Web', 3, 10002),
(2003, 'Kecerdasan Buatan', 3, 10003),
(2004, 'Jaringan Komputer', 3, 10004),
(2005, 'Sistem Informasi', 3, 10005),
(2006, 'Pemrograman Mobile', 3, 10006),
(2007, 'Statistika Komputasi', 2, 10007),
(2008, 'Multimedia', 2, 10008),
(2009, 'Struktur Data', 3, 10009),
(2010, 'Machine Learning', 3, 10010);
SELECT * FROM mata_kuliahh;
----------------------------------------------

INSERT INTO KRS (NIM, id_matkul, semester, tahun_akademik) VALUES
(21001, 2001, 2, '2021/2022'),
(21002, 2002, 2, '2021/2022'),
(22003, 2003, 2, '2022/2023'),
(21004, 2004, 4, '2022/2023'),
(22005, 2005, 2, '2022/2023');
SELECT * FROM KRS;
DELETE FROM KRS WHERE NIM IN (21001);
---------------------------------------------------

INSERT INTO kota (nama_kota) VALUES
('Surabaya'),
('Sumenep'),
('Pamekasan'),
('Pasuruan'),
('Malang');

INSERT INTO kota (nama_kota) VALUES 
('Sidoarjo'),
('Bangkalan'),
('Lamongan'),
('Gresik'),
('Kediri');
SELECT * FROM kota;
------------------------------------------------

RENAME TABLE matakuliah TO mata_kuliahh;

-- drop database akademik_prodi;
------------------------------------
SELECT 
    m.NIM,
    m.nama AS nama_mahasiswa,
    m.prodi,
    m.th_angkatan,
    k.nama_kota
FROM 
    mahasiswa m
JOIN 
    kota k ON m.id_kota = k.id_kota;
--------------------------------------------

SELECT 
    d.NIP,
    d.nama AS nama_dosen,
    d.keahlian,
    k.nama_kota
FROM 
    dosen d
JOIN 
    kota k ON d.id_kota = k.id_kota;


