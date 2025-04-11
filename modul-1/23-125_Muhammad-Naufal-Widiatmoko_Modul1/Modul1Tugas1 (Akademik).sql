-- 1. Buat database
CREATE DATABASE Akademik;
USE Akademik;

-- 2. Buat tabel Mahasiswa, Dosen, Mata Kuliah, dan KRS
CREATE TABLE Mahasiswa (
    NIM INT PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    Angkatan YEAR NOT NULL
);

CREATE TABLE Dosen (
    NIP INT PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    Fakultas VARCHAR(100) NOT NULL
);


CREATE TABLE MataKuliah (
    KodeMK VARCHAR(10) PRIMARY KEY,
    NamaMK VARCHAR(100) NOT NULL,
    SKS INT NOT NULL
);


CREATE TABLE KRS (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NIM INT NOT NULL,
    KodeMK VARCHAR(10) NOT NULL,
    NIP INT NOT NULL,
    Semester INT NOT NULL,
    FOREIGN KEY (NIM) REFERENCES Mahasiswa(NIM),
    FOREIGN KEY (KodeMK) REFERENCES MataKuliah(KodeMK),
    FOREIGN KEY (NIP) REFERENCES Dosen(NIP)
);


-- 3. Isi data pada tabel Mahasiswa, Dosen, dan Mata Kuliah (masing-masing 10 data)
INSERT INTO Mahasiswa (NIM, Nama, Angkatan) VALUES
(101, 'Ahmad', 2021),
(102, 'Budi', 2022), (103, 'Citra', 2021),
(104, 'Dewi', 2023), (105, 'Eko', 2020), (106, 'Fajar', 2022),
(107, 'Gita', 2023), (108, 'Hadi', 2021), (109, 'Indah', 2020), (110, 'Joko', 2023);

INSERT INTO Dosen (NIP, Nama, Fakultas) VALUES
(2001, 'Dr. Andi', 'Teknik'), (2002, 'Dr. Bunga', 'Ekonomi'), (2003, 'Dr. Cahyo', 'Hukum'),
(2004, 'Dr. Dedi', 'Kedokteran'), (2005, 'Dr. Erna', 'MIPA'), (2006, 'Dr. Faisal', 'Teknik'),
(2007, 'Dr. Gina', 'Ekonomi'), (2008, 'Dr. Herman', 'Hukum'), (2009, 'Dr. Intan', 'Kedokteran'), (2010, 'Dr. Joni', 'MIPA');

INSERT INTO MataKuliah (KodeMK, NamaMK, SKS) VALUES
('MK001', 'Basis Data', 3), ('MK002', 'Kalkulus', 4), ('MK003', 'Algoritma', 3),
('MK004', 'Statistika', 3), ('MK005', 'Pemrograman', 3), ('MK006', 'Etika Profesi', 2),
('MK007', 'Fisika', 4), ('MK008', 'Manajemen', 3), ('MK009', 'Akuntansi', 3), ('MK010', 'Kimia', 3);

-- 4. Tampilkan seluruh data pada setiap tabel
SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM Mata_kuliah;

-- 5. Tambahkan data pada tabel KRS sebanyak 5 data
INSERT INTO KRS (NIM, KodeMK, NIP, Semester) VALUES
(101, 'MK001', 2001, 1), (102, 'MK002', 2002, 2), (103, 'MK003', 2003, 1),
(104, 'MK004', 2004, 3), (105, 'MK005', 2005, 2);

ALTER TABLE krs CHANGE COLUMN KodeMk Kode_Mata_kuliah VARCHAR(100);

-- 6. Lakukan perubahan pada salah satu nama tabel (contoh: ubah nama tabel 'MataKuliah' menjadi 'Mata_Kuliah')
ALTER TABLE MataKuliah RENAME TO Mata_Kuliah;

-- 7. Hapus database
DROP DATABASE Akademik;