CREATE DATABASE akademik;
USE akademik;

CREATE TABLE Mahasiswa (
    nim CHAR(10) PRIMARY KEY,
    nama VARCHAR(100),
    jurusan VARCHAR(50),
    angkatan INT
);
ALTER TABLE Mahasiswa DROP COLUMN angkatan;

CREATE TABLE Dosen (
    nip CHAR(10) PRIMARY KEY,
    dosen VARCHAR(75),
    prodi VARCHAR(50)
);

CREATE TABLE MataKuliah (
    kode_mk CHAR(6) PRIMARY KEY,
    nama_mk VARCHAR(100),
    sks INT,
    nip_dosen CHAR(10)
);


CREATE TABLE KRS (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim CHAR(10),
    kode_mk CHAR(6),
    semester INT
);

ALTER TABLE MataKuliah ADD CONSTRAINT fk_nip_dosen FOREIGN KEY (nip_dosen) REFERENCES Dosen(nip);
ALTER TABLE KRS ADD CONSTRAINT fk_nim FOREIGN KEY (nim) REFERENCES Mahasiswa(nim);
ALTER TABLE KRS ADD CONSTRAINT fk_kode_mk FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk);

INSERT INTO Mahasiswa VALUES
('01', 'David', 'Sistem Informasi'),
('02', 'Cindy', 'Sistem Informasi'),
('03', 'Doni', 'Sistem Informasi'),
('04', 'Vikas', 'Sistem Informasi'),
('05', 'Izza', 'Sistem Informasi'),
('06', 'Tanji', 'Sistem Informasi'),
('07', 'Faiz', 'Sistem Informasi'),
('08', 'Abrori', 'Sistem Informasi'),
('09', 'Indra', 'Sistem Informasi'),
('10', 'Ibnu', 'Sistem Informasi');

INSERT INTO Dosen VALUES
('D001', 'Dosen Fitri', 'Sistem Informasi'),
('D002', 'Pak Firli', 'Sistem Informasi'),
('D003', 'Ibu Ezza', 'Sistem Informasi'),
('D004', 'Ibu Imamah', 'Sistem Informasi'),
('D005', 'Pak Budi', 'Sistem Informasi'),
('D006', 'Ibu Novi', 'Sistem Informasi'),
('D007', 'Pak Syarif', 'Sistem Informasi'),
('D008', 'Pak Firman', 'Sistem Informasi'),
('D009', 'Ibu Bila', 'Sistem Informasi'),
('D010', 'Pak Yusuf', 'Sistem Informasi');

INSERT INTO MataKuliah VALUES
('MK001', 'Algoritma dan Pemrograman', 3, 'D001'),
('MK002', 'Basis Data', 3, 'D002'),
('MK003', 'Jaringan Komputer', 3, 'D003'),
('MK004', 'Pemrograman Web', 3, 'D004'),
('MK005', 'Financial technologoy', 3, 'D005'),
('MK006', 'Sistem Operasi', 3, 'D006'),
('MK007', 'Manajemen Proyek IT', 3, 'D007'),
('MK008', 'Data Mining', 3, 'D008'),
('MK009', 'Pemrograman Java', 3, 'D009'),
('MK010', 'sistem pendukung keputusan', 3, 'D010');

INSERT INTO KRS (nim, kode_mk, semester) VALUES
('01', 'MK001', 1),
('02', 'MK002', 1),
('03', 'MK003', 2),
('04', 'MK004', 2),
('05', 'MK005', 3);

SELECT * FROM Mahasiswa;
SELECT * FROM Dosen;
SELECT * FROM MataKuliah;
SELECT * FROM KRS;

ALTER TABLE Mahasiswa RENAME TO MahasiswaBaru;

DROP DATABASE akademik;
