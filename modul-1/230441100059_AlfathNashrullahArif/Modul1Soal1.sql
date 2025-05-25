CREATE DATABASE dbAkademik ; 

USE dbAkademik ;

CREATE TABLE Mahasiswa (
NIM CHAR (12) PRIMARY KEY,
Nama VARCHAR (80) NOT NULL,
Prodi VARCHAR (50) NOT NULL,
Angkatan YEAR NOT NULL
);

CREATE TABLE Dosen (
NIP CHAR (5) PRIMARY KEY,
Nama VARCHAR (80) NOT NULL,
Jurusan VARCHAR (50) NOT NULL
);

CREATE TABLE Matakuliah (
Kode_MK CHAR (3) PRIMARY KEY,
Nama_MK VARCHAR (100) NOT NULL,
NIP CHAR (5) NOT NULL,
Sks INT NOT NULL,
FOREIGN KEY (NIP) REFERENCES Dosen (NIP)
);

CREATE TABLE KRS (
Id_KRS INT PRIMARY KEY AUTO_INCREMENT,
NIM CHAR (12) NOT NULL,
Kode_MK CHAR (3) NOT NULL,
FOREIGN KEY (NIM) REFERENCES Mahasiswa (NIM),
FOREIGN KEY (Kode_MK) REFERENCES Matakuliah (Kode_MK)
);  

INSERT INTO Mahasiswa VALUES
('230441100029', 'Vikas', 'Sistem Informasi', 2023),
('230441100042', 'Nopal', 'Sistem Informasi', 2023),
('230441100059', 'Alif', 'Sistem Informasi', 2023),
('230441100060', 'Akbar', 'Sistem Informasi', 2023),
('230441100063', 'Ivan', 'Sistem Informasi', 2023),
('230441100064', 'Tio', 'Sistem Informasi', 2023),
('230441100067', 'Malik', 'Sistem Informasi', 2023),
('230441100081', 'Isma', 'Sistem Informasi', 2023),
('230441100089', 'Ivan', 'Sistem Informasi', 2023),
('230441100116', 'Syafii', 'Sistem Informasi', 2023);

UPDATE Mahasiswa SET NIM='230441100090', Nama='Rafi' WHERE NIM='230441100029';

SELECT COUNT(NIM) FROM Mahasiswa;

INSERT INTO Dosen VALUES 
('D0001', 'Syafi', 'Teknik'),
('D0002', 'Hera', 'Teknik'),
('D0003', 'Samsul', 'Teknik'),
('D0004', 'Hari', 'Teknik'),
('D0005', 'Dian', 'Teknik'),
('D0006', 'Ansori', 'Teknik'),
('D0007', 'Isti', 'Teknik'),
('D0008', 'Rohman', 'Teknik'),
('D0009', 'Husnul', 'Teknik'),
('D0010', 'Maryam', 'Teknik');

SELECT * FROM Dosen ORDER BY (NIP) DESC;

INSERT INTO Matakuliah VALUES 
('001', 'Algoritma Pemrograman', 'D0001', 4),
('002', 'Sistem Operasi', 'D0002', 3),
('003', 'Agama', 'D0001', 2),
('004', 'Pemrograman Berbasis Web', 'D0003', 4),
('005', 'Pemrograman Berbasis Objek', 'D0004', 4),
('006', 'Bahasa Inggris', 'D0010', 2),
('007', 'Financial Technology', 'D0005', 3),
('008', 'Pemrograman Visual', 'D0006', 4),
('009', 'SIstem Manajemen Basis Data', 'D0007', 4),
('010', 'Pemrograman Bergerak', 'D0008', 4);

INSERT INTO KRS (NIM, Kode_MK) VALUES
('230441100059', '001'),
('230441100060', '002'),
('230441100063', '003'),
('230441100064', '004'),
('230441100067', '005');

SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM Matakuliah;
SELECT * FROM KRS;

ALTER TABLE Dosen RENAME TO DataDosen;

DROP DATABASE dbAkademik;


