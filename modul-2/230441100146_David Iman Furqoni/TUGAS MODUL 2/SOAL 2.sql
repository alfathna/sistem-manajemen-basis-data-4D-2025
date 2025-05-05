============================================================================================ -- tugas sebelumnya (MODUL 1) !!!
CREATE DATABASE SistemManajemenKaryawan;
USE SistemManajemenKaryawan;
-----------------------------------------------------------------
-- DROP DATABASE SistemManajemenKaryawan;
	CREATE TABLE Departemen (
	    id_departemen INT PRIMARY KEY AUTO_INCREMENT,
	    nama_departemen VARCHAR(100) NOT NULL,
	    lokasi VARCHAR(100) NOT NULL
	);
ALTER TABLE Departemen MODIFY id_departemen INT (10) NOT NULL AUTO_INCREMENT;
SELECT * FROM Departemen;

CREATE TABLE Jabatan (
    id_jabatan INT PRIMARY KEY AUTO_INCREMENT,
    nama_jabatan VARCHAR(100) NOT NULL,
    level_jabatan INT CHECK (level_jabatan > 0)
);
ALTER TABLE Jabatan MODIFY id_jabatan INT (10) NOT NULL AUTO_INCREMENT;
SELECT * FROM Jabatan;


CREATE TABLE Karyawan (
    id_karyawan INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nama_karyawan VARCHAR(100) NOT NULL,
    jenis_kelamin ENUM('Laki-laki', 'Perempuan') NOT NULL,
    tanggal_lahir DATE,
    id_jabatan INT,
    id_departemen INT,
    tanggal_masuk DATE
);
ALTER TABLE Karyawan ADD CONSTRAINT fk_id_jabatan FOREIGN KEY (id_jabatan) REFERENCES Jabatan (id_jabatan);
ALTER TABLE Karyawan ADD CONSTRAINT fk_id_departemen FOREIGN KEY (id_departemen) REFERENCES Departemen (id_departemen);
SELECT * FROM Karyawan;


CREATE TABLE Gaji (
    id_gaji INT PRIMARY KEY AUTO_INCREMENT,
    id_karyawan INT,
    bulan_gaji DATE,
    gaji_pokok DECIMAL(12,2),
    tunjangan DECIMAL(12,2),
    potongan DECIMAL(12,2)
);
ALTER TABLE Gaji ADD CONSTRAINT fk_id_karyawan FOREIGN KEY (id_karyawan) REFERENCES Karyawan (id_karyawan);
SELECT * FROM Gaji;


CREATE TABLE Absensi (
    id_absensi INT PRIMARY KEY AUTO_INCREMENT,
    tanggal DATE,
    jam_masuk TIME,
    jam_keluar TIME,
    STATUS ENUM('Hadir', 'Izin', 'Sakit', 'Alpha') DEFAULT 'Hadir'
);
SELECT * FROM Absensi;

ALTER TABLE Absensi 
ADD COLUMN id_karyawan INT;

ALTER TABLE Absensi ADD CONSTRAINT fk_absensi_karyawan FOREIGN KEY (id_karyawan) REFERENCES Karyawan(id_karyawan);

============================================================================================ -- tugas sebelumnya (MODUL 1) !!!

USE SistemManajemenKaryawan;
============================================ -- tambahan tabel kota asal !!! ///
CREATE TABLE KotaAsal (
    id_kota INT PRIMARY KEY AUTO_INCREMENT,
    nama_kota VARCHAR(100) NOT NULL
);
ALTER TABLE Karyawan ADD COLUMN id_kota INT;
ALTER TABLE Karyawan ADD CONSTRAINT fk_id_kota FOREIGN KEY (id_kota) REFERENCES KotaAsal(id_kota);
SELECT * FROM KotaAsal;
============================================ -- tambahan tabel kota asal !!! ///

INSERT INTO Departemen (nama_departemen, lokasi) VALUES
('HRD', 'Jakarta'),
('IT', 'Bandung'),
('Keuangan', 'Surabaya'),
('Pemasaran', 'Yogyakarta'),
('Produksi', 'Semarang'),
('Logistik', 'Medan');

INSERT INTO KotaAsal (nama_kota) VALUES
('Jakarta'),
('Bandung'),
('Surabaya'),
('Yogyakarta'),
('Semarang'),
('Medan'),
('Palembang'),
('Makassar'),
('Denpasar'),
('Balikpapan');

INSERT INTO Jabatan (nama_jabatan, level_jabatan) VALUES
('Manager', 1),
('Supervisor', 2),
('Staff', 3),
('Admin', 4),
('Magang', 5);

INSERT INTO Karyawan (nama_karyawan, jenis_kelamin, tanggal_lahir, id_jabatan, id_departemen, tanggal_masuk, id_kota) VALUES
('Budi Santoso', 'Laki-laki', '1990-04-12', 1, 1, '2015-03-01', 1),
('Ani Lestari', 'Perempuan', '1995-07-23', 3, 2, '2020-01-15', 2),
('Tono Prasetyo', 'Laki-laki', '1988-11-03', 2, 3, '2018-08-10', 3),
('Sinta Ayu', 'Perempuan', '1992-05-11', 1, 4, '2017-09-01', 4),
('Dedi Kurniawan', 'Laki-laki', '1993-02-28', 3, 5, '2019-07-15', 5),
('Maya Fitri', 'Perempuan', '1996-06-17', 4, 2, '2021-03-25', 6),
('Rian Saputra', 'Laki-laki', '1991-09-05', 2, 6, '2016-12-10', 7),
('Lilis Kartika', 'Perempuan', '1998-01-14', 3, 1, '2022-05-01', 8),
('Eko Pranoto', 'Laki-laki', '1985-10-08', 1, 3, '2012-06-18', 9),
('Fajar Hidayat', 'Laki-laki', '1994-04-27', 5, 5, '2023-01-05', 10),
('Desi Rahayu', 'Perempuan', '1997-08-30', 4, 4, '2023-08-15', 3),
('Yoga Ananda', 'Laki-laki', '2000-03-20', 5, 6, '2024-02-01', 1);

INSERT INTO Gaji (id_karyawan, bulan_gaji, gaji_pokok, tunjangan, potongan) VALUES
(1, '2025-03-01', 10000000, 2500000, 500000),
(2, '2025-03-01', 6000000, 1000000, 200000),
(3, '2025-03-01', 8000000, 1500000, 300000),
(4, '2025-03-01', 9500000, 2000000, 400000),
(5, '2025-03-01', 6500000, 1200000, 250000),
(6, '2025-03-01', 5000000, 800000, 150000),
(7, '2025-03-01', 8500000, 1800000, 300000),
(8, '2025-03-01', 6200000, 1000000, 200000),
(9, '2025-03-01', 11000000, 3000000, 700000),
(10, '2025-03-01', 3500000, 500000, 100000),
(11, '2025-03-01', 4500000, 600000, 150000),
(12, '2025-03-01', 3000000, 400000, 80000);

INSERT INTO Absensi (id_karyawan, tanggal, jam_masuk, jam_keluar, STATUS) VALUES
(1, '2025-04-01', '08:00:00', '17:00:00', 'Hadir'),
(2, '2025-04-01', '08:05:00', '17:00:00', 'Hadir'),
(3, '2025-04-01', NULL, NULL, 'Alpha'),
(4, '2025-04-01', '08:10:00', '17:05:00', 'Hadir'),
(5, '2025-04-01', '08:20:00', '17:10:00', 'Sakit'),
(6, '2025-04-01', '08:00:00', '17:00:00', 'Hadir'),
(1, '2025-04-02', '08:00:00', '17:00:00', 'Hadir'),
(2, '2025-04-02', '08:03:00', '17:02:00', 'Hadir'),
(3, '2025-04-02', '08:15:00', '17:20:00', 'Izin'),
(4, '2025-04-02', NULL, NULL, 'Alpha'),
(5, '2025-04-02', '08:00:00', '17:00:00', 'Hadir'),
(6, '2025-04-02', '08:00:00', '17:00:00', 'Hadir');
============================================================================================ -- tugas selanjutnya (MODUL 2) !!!

-- 1
CREATE VIEW ViewKaryawanKotaAsal AS
SELECT 
    k.nama_karyawan,
    ka.nama_kota AS kota_asal
FROM 
    Karyawan k
JOIN 
    KotaAsal ka ON k.id_kota = ka.id_kota;

SELECT * FROM ViewKaryawanKotaAsal;
============================================================================================

-- 2
CREATE VIEW view_karyawan_jabatan_dan_departemen AS
SELECT 
	k.nama_karyawan AS 'Nama Karyawan',
	j.nama_jabatan AS 'Jabatan',
	d.nama_departemen AS 'Departemen'
FROM Karyawan k
JOIN Jabatan j ON k.id_jabatan = j.id_jabatan 
JOIN Departemen d ON k.id_departemen = d.id_departemen;

SELECT * FROM view_karyawan_jabatan_dan_departemen;
============================================================================================

-- 3
CREATE VIEW view_karyawan_perempuan_luar_jawa AS
SELECT 
    k.nama_karyawan AS `Nama Karyawan`,
    ka.nama_kota AS `Asal Kota`,
    k.jenis_kelamin AS `Jenis Kelamin`
FROM 
    Karyawan k
JOIN KotaAsal ka ON k.id_kota = ka.id_kota
WHERE 
    k.jenis_kelamin = 'Perempuan' AND
    ka.nama_kota IN ('Makassar', 'Medan', 'Palembang', 'Denpasar', 'Balikpapan');

SELECT * FROM view_karyawan_perempuan_luar_jawa;
============================================================================================

-- 4
CREATE VIEW view_total_gaji_per_departemen AS
SELECT 
    d.nama_departemen AS `Departemen`,
    COUNT(k.id_karyawan) AS `Jumlah Karyawan`,
    SUM(g.gaji_pokok + g.tunjangan - g.potongan) AS `Total Gaji Bersih`,
    AVG(g.gaji_pokok + g.tunjangan - g.potongan) AS `Rata-rata Gaji`,
    MAX(g.gaji_pokok + g.tunjangan - g.potongan) AS `Gaji Tertinggi`,
    MIN(g.gaji_pokok + g.tunjangan - g.potongan) AS `Gaji Terendah`
FROM Karyawan k
JOIN Gaji g ON k.id_karyawan = g.id_karyawan
JOIN Departemen d ON k.id_departemen = d.id_departemen
GROUP BY d.nama_departemen;

SELECT * FROM view_total_gaji_per_departemen;
============================================================================================

-- 5
CREATE VIEW view_rekap_absensi_karyawan AS
SELECT 
    k.nama_karyawan AS `Nama Karyawan`,
    COUNT(CASE WHEN a.status = 'Hadir' THEN 1 END) AS `Hadir`,
    COUNT(CASE WHEN a.status = 'Izin' THEN 1 END) AS `Izin`,
    COUNT(CASE WHEN a.status = 'Sakit' THEN 1 END) AS `Sakit`,
    COUNT(CASE WHEN a.status = 'Alpha' THEN 1 END) AS `Alpha`
FROM Karyawan k
JOIN Absensi a ON k.id_karyawan = a.id_karyawan
GROUP BY k.id_karyawan;

SELECT * FROM view_rekap_absensi_karyawan;

