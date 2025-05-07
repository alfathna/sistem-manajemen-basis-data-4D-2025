CREATE DATABASE akademik;
USE akademik; 

CREATE TABLE mahasiswa (
nim CHAR(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
nama VARCHAR(100) NOT NULL,
jurusan VARCHAR(50) NOT NULL,
angkatan INT(30) NOT NULL
);

CREATE TABLE Dosen (
nidn CHAR(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
nama VARCHAR(100) NOT NULL,
keahlian VARCHAR(50) NOT NULL
);

CREATE TABLE MataKuliah (
kode_mk CHAR(6) PRIMARY KEY NOT NULL AUTO_INCREMENT,
nama_mk VARCHAR(100) NOT NULL,
sks INT (10) NOT NULL,
nidn CHAR(10) NOT NULL
);

ALTER TABLE MataKuliah ADD CONSTRAINT fknidn FOREIGN KEY (nidn) REFERENCES Dosen(nidn)

CREATE TABLE KRS (
id_krs INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
nim CHAR(10) NOT NULL,
kode_mk CHAR(6) NOT NULL,
semester INT NOT NULL
);

ALTER TABLE KRS ADD CONSTRAINT fknim FOREIGN KEY (nim) REFERENCES Mahasiswa(nim)
ALTER TABLE KRS ADD CONSTRAINT fkkode_mk FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk)

-- Isi Data Mahasiswa, Dosen, dan Mata Kuliah
-- Mahasiswa
INSERT INTO Mahasiswa VALUES
('M001', 'Ali', 'Informatika', 2022),
('M002', 'Budi', 'Sistem Informasi', 2021),
('M003', 'Citra', 'Informatika', 2022),
('M004', 'Dina', 'Teknik Komputer', 2020),
('M005', 'Eka', 'Informatika', 2021),
('M006', 'Fani', 'Sistem Informasi', 2022),
('M007', 'Gilang', 'Informatika', 2020),
('M008', 'Hana', 'Teknik Komputer', 2023),
('M009', 'Irfan', 'Informatika', 2023),
('M010', 'Joko', 'Sistem Informasi', 2021);

-- Dosen
INSERT INTO Dosen VALUES
('D001', 'Dr. Ahmad', 'Database'),
('D002', 'Dr. Beni', 'AI'),
('D003', 'Dr. Cici', 'Jaringan'),
('D004', 'Dr. Dodi', 'Web Development'),
('D005', 'Dr. Euis', 'Mobile Dev'),
('D006', 'Dr. Fajar', 'Keamanan'),
('D007', 'Dr. Gita', 'Pemrograman'),
('D008', 'Dr. Hadi', 'Big Data'),
('D009', 'Dr. Indah', 'Cloud'),
('D010', 'Dr. Joni', 'Sistem Terdistribusi');

-- Mata Kuliah
INSERT INTO MataKuliah VALUES
('MK001', 'Basis Data', 3, 'D001'),
('MK002', 'Kecerdasan Buatan', 3, 'D002'),
('MK003', 'Jaringan Komputer', 3, 'D003'),
('MK004', 'Pemrograman Web', 3, 'D004'),
('MK005', 'Pemrograman Mobile', 3, 'D005'),
('MK006', 'Keamanan Informasi', 3, 'D006'),
('MK007', 'Pemrograman Dasar', 3, 'D007'),
('MK008', 'Big Data Analytics', 3, 'D008'),
('MK009', 'Cloud Computing', 3, 'D009'),
('MK010', 'Sistem Terdistribusi', 3, 'D010');

-- menampilkan semua data 
SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM MataKuliah;
SELECT * FROM KRS;

-- tambah data ke tabel krs 
INSERT INTO KRS (nim, kode_mk, semester) VALUES
('M001', 'MK001', 2),
('M002', 'MK002', 2),
('M003', 'MK003', 2),
('M004', 'MK004', 4),
('M005', 'MK005', 4);

-- ganti nama tabel
RENAME TABLE Mahasiswa TO DataMahasiswa;

-- hapus database
DROP DATABASE akademik;

DROP TABLE KRS;

DROP TABLE MataKuliah;

