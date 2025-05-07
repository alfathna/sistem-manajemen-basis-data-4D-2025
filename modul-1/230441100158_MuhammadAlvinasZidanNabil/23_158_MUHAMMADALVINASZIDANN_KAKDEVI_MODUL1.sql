-- Buat database & pakai CREAT ALTER DROP , INSERT SELECT
CREATE DATABASE akademik1;
USE akademik1;

-- Tabel Mahasiswa
CREATE TABLE Mahasiswa (
    nim INT PRIMARY KEY,
    nama VARCHAR(50),
    jurusan VARCHAR(50),
    angkatan YEAR
);

-- ALTER TABLE Mahasiswa ADD exxx VARCHAR (100) NOT NULL;
MODIFY nama VARCHAR(50) NOT NULL;
MODIFY jurusan VARCHAR(50) NOT NULL;
MODIFY angkatan YEAR NOT NULL;


-- +
INSERT INTO Mahasiswa (nim, nama, jurusan, angkatan) VALUES
(230154, 'zain', 'Sistem Informasi', 2027),
(230010, 'zaki', 'Sistem Informasi', 2027),
(230020, 'Rizky', 'Teknik Informatika', 2028),
(230030, 'akbar', 'Teknik Elektro', 2029),
(230040, 'Diki', 'Sistem Informasi', 2028),
(230050, 'Nabil', 'Teknik Informatika', 2023),
(230060, 'Aditya', 'Sistem Informasi', 2023),
(230070, 'Based', 'Teknik Elektro', 2022),
(230080, 'Umam', 'Teknik Informatika', 2021),
(230090, 'Herri', 'Sistem Informasi', 2025);

-- Tabel Dosen
CREATE TABLE Dosen (
    nidn INT PRIMARY KEY,
    nama_dosen VARCHAR(50),
    gelar VARCHAR(20),
    departemen VARCHAR(50)
);

MODIFY nama_dosen VARCHAR(50) NOT NULL;
MODIFY gelar VARCHAR(20) NOT NULL;
MODIFY departemen VARCHAR(50) NOT NULL;


INSERT INTO Dosen (nidn, nama_dosen, gelar, departemen) VALUES
(1, 'Prof. Dr. Bambang', 'S.T., M.T.', 'Teknik Informatika'),
(2, 'Dr. Sri Wahyuni', 'M.Kom.', 'Sistem Informasi'),
(3, 'Dr. Agus Salim', 'S.T., M.Kom.', 'Teknik Komputer'),
(4, 'Prof. Dr. Fatimah', 'S.T., M.T.', 'Teknik Elektro'),
(5, 'Dr. Rina Dewi', 'M.Kom.', 'Sistem Informasi'),
(6, 'Dr. Budi Hartono', 'S.T., M.T.', 'Teknik Informatika'),
(7, 'Dr. Riza Purnama', 'M.Kom.', 'Sistem Informasi'),
(8, 'Prof. Dr. Arif Hidayat', 'S.T., M.T.', 'Teknik Elektro'),
(9, 'Dr. Retno Sari', 'S.T., M.Kom.', 'Sistem Informasi'),
(10, 'Dr. Imam Subekti', 'M.Kom.', 'Teknik Komputer');

-- Tabel Mata Kuliah
CREATE TABLE MataKuliah (
    kode_mk VARCHAR(10) PRIMARY KEY,
    nama_mk VARCHAR(100),
    sks INT
);

MODIFY nama_mk VARCHAR(50) NOT NULL;
MODIFY sks VARCHAR NOT NULL;


INSERT INTO MataKuliah (kode_mk, nama_mk, sks) VALUES
('MK001', 'Algoritma dan Pemrograman', 3),
('MK002', 'Basis Data', 3),
('MK003', 'Struktur Data', 3),
('MK004', 'Jaringan Komputer', 3),
('MK005', 'Sistem Operasi', 3),
('MK006', 'Pengembangan Web', 3),
('MK007', 'Kecerdasan Buatan', 3),
('MK008', 'Pemrograman Mobile', 3),
('MK009', 'Rekayasa Perangkat Lunak', 3),
('MK010', 'Manajemen Proyek TI', 3);

-- UPDATE MataKuliah SET nama_mk = 'dataa' WHERE kode_mk='MK003';

-- Tabel KRS
CREATE TABLE KRS (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim INT,
    kode_mk VARCHAR(10),
    nidn INT,
    semester INT--
);


MODIFY nim VARCHAR NOT NULL;
MODIFY kode_mk VARCHAR (10) NOT NULL;
MODIFY nidn VARCHAR (10) NOT NULL;
MODIFY semester VARCHAR NOT NULL;

ALTER TABLE KRS ADD CONSTRAINT fk_nim FOREIGN KEY (nim) REFERENCES Mahasiswa(nim);
ALTER TABLE KRS ADD CONSTRAINT fk_kode_mk FOREIGN KEY (kode_mk) REFERENCES Matakuliah(kode_mk);
ALTER TABLE KRS ADD CONSTRAINT fk_nIdn FOREIGN KEY (nim) REFERENCES Dosen(nidn);




-- Insert ke tabel KRS
INSERT INTO KRS (nim, nidn, kode_mk, semester) VALUES
(230154, 1, 'MK001', 1),
(230010, 2, 'MK002', 2),
(230020, 3, 'MK003', 1),
(230030, 4, 'MK004', 3),
(230040, 5, 'MK005', 4);

ALTER TABLE KRS RENAME TO KRS2 ;

DROP DATABASE akademik;

-- TAMPILKAN
SELECT * FROM Mahasiswa;

SELECT * FROM Dosen;

SELECT * FROM KRS;

SELECT * FROM MataKuliah;