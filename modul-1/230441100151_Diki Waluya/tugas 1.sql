CREATE DATABASE Akademik;
USE Akademik;

CREATE TABLE Mahasiswa (
    NIM INT PRIMARY KEY,
    Nama VARCHAR(50),
    Alamat VARCHAR(100),
    Jurusan VARCHAR(50)
);

CREATE TABLE Dosen (
    NIDN INT PRIMARY KEY,
    Nama VARCHAR(50),
    Fakultas VARCHAR(50)
);

CREATE TABLE MataKuliah (
    KodeMK INT PRIMARY KEY,
    NamaMK VARCHAR(50),
    SKS INT,
    NIDN INT,
    FOREIGN KEY (NIDN) REFERENCES Dosen(NIDN)
);

CREATE TABLE KRS (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NIM INT,
    KodeMK INT,
    Semester INT,
    FOREIGN KEY (NIM) REFERENCES Mahasiswa(NIM),
    FOREIGN KEY (KodeMK) REFERENCES MataKuliah(KodeMK)
);


INSERT INTO Mahasiswa VALUES
(10001, 'Diki', 'Jl. Melati 1', 'Informatika'),
(10002, 'Budi', 'Jl. Mawar 2', 'Informatika'),
(10003, 'Cici', 'Jl. Anggrek 3', 'Sistem Informasi'),
(10004, 'Dedi', 'Jl. Kenanga 4', 'Sistem Informasi'),
(10005, 'Eka', 'Jl. Flamboyan 5', 'Informatika'),
(10006, 'Fajar', 'Jl. Dahlia 6', 'Teknik Komputer'),
(10007, 'Gina', 'Jl. Cemara 7', 'Teknik Komputer'),
(10008, 'Hari', 'Jl. Kamboja 8', 'Informatika'),
(10009, 'Indah', 'Jl. Melur 9', 'Sistem Informasi'),
(10010, 'Joko', 'Jl. Teratai 10', 'Teknik Komputer');

INSERT INTO Dosen VALUES
(20001, 'Pak Budi', 'FTI'),
(20002, 'Bu Ani', 'FTI'),
(20003, 'Pak Cahyono', 'FTI'),
(20004, 'Bu Dewi', 'FTI'),
(20005, 'Pak Endang', 'FTI'),
(20006, 'Bu Fitri', 'FTI'),
(20007, 'Pak Guntur', 'FTI'),
(20008, 'Bu Hani', 'FTI'),
(20009, 'Pak Irwan', 'FTI'),
(20010, 'Bu Jannah', 'FTI');

INSERT INTO MataKuliah VALUES
(301, 'Basis Data', 3, 20001),
(302, 'Algoritma', 3, 20002),
(303, 'Pemrograman Web', 3, 20003),
(304, 'Jaringan Komputer', 3, 20004),
(305, 'Struktur Data', 3, 20005),
(306, 'Pemrograman Mobile', 3, 20006),
(307, 'Kecerdasan Buatan', 3, 20007),
(308, 'Rekayasa Perangkat Lunak', 3, 20008),
(309, 'Etika Profesi', 2, 20009),
(310, 'Sistem Operasi', 3, 20010);


ALTER TABLE KRS RENAME TO Registrasi;

INSERT INTO Registrasi (NIM, KodeMK, Semester) VALUES
(10001, 301, 1),
(10002, 302, 1),
(10003, 303, 2),
(10004, 304, 2),
(10005, 305, 3);

UPDATE Mahasiswa SET Nama = 'Andi Pratama' WHERE NIM = 10001;


SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM MataKuliah;
SELECT * FROM Registrasi;


DATABASE Akademik;
