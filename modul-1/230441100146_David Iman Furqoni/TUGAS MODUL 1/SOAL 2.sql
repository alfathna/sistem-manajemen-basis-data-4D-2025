
CREATE DATABASE SistemManajemenKaryawan;
USE SistemManajemenKaryawan;
-----------------------------------------------------------------

CREATE TABLE Departemen (
    id_departemen INT PRIMARY KEY AUTO_INCREMENT,
    nama_departemen VARCHAR(100) NOT NULL,
    lokasi VARCHAR(100) NOT NULL
);
ALTER TABLE Departemen MODIFY id_departemen INT (10) NOT NULL;

INSERT INTO Departemen (nama_departemen, lokasi) VALUES
('HRD', 'Jakarta'),
('IT', 'Bandung'),
('Keuangan', 'Surabaya');
SELECT * FROM Departemen;

CREATE TABLE Jabatan (
    id_jabatan INT PRIMARY KEY AUTO_INCREMENT,
    nama_jabatan VARCHAR(100) NOT NULL,
    level_jabatan INT CHECK (level_jabatan > 0)
);
ALTER TABLE Jabatan MODIFY id_jabatan INT (10) NOT NULL;

INSERT INTO Jabatan (nama_jabatan, level_jabatan) VALUES
('Manager', 1),
('Supervisor', 2),
('Staff', 3);
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


    
INSERT INTO Karyawan (nama_karyawan, jenis_kelamin, tanggal_lahir, id_jabatan, id_departemen, tanggal_masuk, STATUS) VALUES
('Budi Santoso', 'Laki-laki', '1990-04-12', 1, 1, '2015-03-01', 'Aktif'),
('Ani Lestari', 'Perempuan', '1995-07-23', 3, 2, '2020-01-15', 'Aktif'),
('Tono Prasetyo', 'Laki-laki', '1988-11-03', 2, 3, '2018-08-10', 'Resign');
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




INSERT INTO Gaji (id_karyawan, bulan_gaji, gaji_pokok, tunjangan, potongan) VALUES
(1, '2025-03-01', 10000000, 2500000, 500000),
(2, '2025-03-01', 6000000, 1000000, 200000),
(3, '2025-03-01', 8000000, 1500000, 300000);
SELECT * FROM Gaji;
-------------------------------------------------------------------------------------------

CREATE TABLE Absensi (
    id_absensi INT PRIMARY KEY AUTO_INCREMENT,
    tanggal DATE,
    jam_masuk TIME,
    jam_keluar TIME,
    STATUS ENUM('Hadir', 'Izin', 'Sakit', 'Alpha') DEFAULT 'Hadir'
);
SELECT * FROM Absensi;
ALTER TABLE Absensi ADD CONSTRAINT fk_id_karyawan FOREIGN KEY (id_karyawan) REFERENCES Karyawan (id_karyawan);


INSERT INTO Absensi (id_karyawan, tanggal, jam_masuk, jam_keluar, STATUS) VALUES
(1, '2025-04-01', '08:00:00', '17:00:00', 'Hadir'),
(1, '2025-04-02', '08:10:00', '17:05:00', 'Hadir'),
(2, '2025-04-01', '08:20:00', '17:15:00', 'Izin'),
(3, '2025-04-01', NULL, NULL, 'Alpha');
SELECT * FROM Absensi;

-----------------------------------------------------------------------------------------------
SHOW TABLES;

SELECT 
    k.id_karyawan,
    k.nama_karyawan,
    k.jenis_kelamin,
    k.tanggal_lahir,
    j.nama_jabatan,
    d.nama_departemen,
    d.lokasi,
    k.tanggal_masuk,
    k.status
FROM Karyawan k
JOIN Jabatan j ON k.id_jabatan = j.id_jabatan
JOIN Departemen d ON k.id_departemen = d.id_departemen;
------
SELECT 
    g.id_gaji,
    k.nama_karyawan,
    g.bulan_gaji,
    g.gaji_pokok,
    g.tunjangan,
    g.potongan,
    (g.gaji_pokok + g.tunjangan - g.potongan) AS total_gaji
FROM Gaji g
JOIN Karyawan k ON g.id_karyawan = k.id_karyawan;
