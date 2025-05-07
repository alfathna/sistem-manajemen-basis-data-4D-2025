-- 1. Buat database
CREATE DATABASE akademik;
USE akademik;

-- 2. Buat tabel tanpa foreign key dulu
CREATE TABLE Mahasiswa (
    nim CHAR(10) PRIMARY KEY,
    nama VARCHAR(50) NOT NULL,
    angkatan YEAR NOT NULL,
    program_studi VARCHAR(50) NOT NULL
);

CREATE TABLE Dosen (
    nip CHAR(10) PRIMARY KEY,
    nama_dosen VARCHAR(50) NOT NULL,
    bidang_keahlian VARCHAR(50) NOT NULL
);

CREATE TABLE MataKuliah (
    kode_mk CHAR(10) PRIMARY KEY,
    nama_mk VARCHAR(50) NOT NULL,
    sks INT NOT NULL,
    nip CHAR(10)
);

CREATE TABLE KRS (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim CHAR(10),
    kode_mk CHAR(10),
    semester INT NOT NULL
);

-- 3. Tambahkan foreign key setelah tabel dibuat
ALTER TABLE MataKuliah
ADD CONSTRAINT fk_mk_dosen FOREIGN KEY (nip) REFERENCES Dosen(nip) ON DELETE SET NULL;

ALTER TABLE KRS
ADD CONSTRAINT fk_krs_mahasiswa FOREIGN KEY (nim) REFERENCES Mahasiswa(nim) ON DELETE CASCADE;

ALTER TABLE KRS
ADD CONSTRAINT fk_krs_mk FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk) ON DELETE CASCADE;

-- 4. Insert data Mahasiswa (sesuai permintaan)
INSERT INTO Mahasiswa (nim, nama, angkatan, program_studi) VALUES
('230441100186', 'Ibnu Nashrulloh.M', 2022, 'Teknik Informatika'),
('22002', 'Budi Santoso', 2021, 'Sistem Informasi'),
('22003', 'Citra Dewi', 2020, 'Manajemen Informatika'),
('22004', 'Dian Sari', 2022, 'Teknik Informatika'),
('22005', 'Eko Prasetyo', 2021, 'Sistem Informasi'),
('22006', 'Fajar Rahman', 2020, 'Manajemen Informatika'),
('22007', 'Gita Ayu', 2022, 'Teknik Informatika'),
('22008', 'Hadi Saputra', 2021, 'Sistem Informasi'),
('22009', 'Irfan Maulana', 2020, 'Manajemen Informatika'),
('22010', 'Joko Susanto', 2022, 'Teknik Informatika');

-- 5. Insert data Dosen
INSERT INTO Dosen (nip, nama_dosen, bidang_keahlian) VALUES
('D001', 'Dr. Arif Setiawan', 'Basis Data'),
('D002', 'Dr. Budi Hartono', 'Pemrograman'),
('D003', 'Dr. Cahyono Wibowo', 'Jaringan Komputer'),
('D004', 'Dr. Dewi Kusuma', 'Sistem Informasi'),
('D005', 'Dr. Edi Supriyanto', 'Keamanan Sistem'),
('D006', 'Dr. Fanny Oktaviani', 'AI dan Machine Learning'),
('D007', 'Dr. Gunawan Santoso', 'Cloud Computing'),
('D008', 'Dr. Hana Permata', 'Big Data'),
('D009', 'Dr. Ilham Riyadi', 'Manajemen Proyek TI'),
('D010', 'Dr. Joko Widodo', 'Rekayasa Perangkat Lunak');

-- 6. Insert data Mata Kuliah
INSERT INTO MataKuliah (kode_mk, nama_mk, sks, nip) VALUES
('MK001', 'Basis Data', 3, 'D001'),
('MK002', 'Pemrograman Java', 3, 'D002'),
('MK003', 'Jaringan Komputer', 3, 'D003'),
('MK004', 'Sistem Informasi', 3, 'D004'),
('MK005', 'Keamanan Sistem', 3, 'D005'),
('MK006', 'AI dan Machine Learning', 3, 'D006'),
('MK007', 'Cloud Computing', 3, 'D007'),
('MK008', 'Big Data', 3, 'D008'),
('MK009', 'Manajemen Proyek TI', 3, 'D009'),
('MK010', 'Rekayasa Perangkat Lunak', 3, 'D010');

-- 7. Insert data KRS
INSERT INTO KRS (nim, kode_mk, semester) VALUES
('230441100186', 'MK001', 3),
('22002', 'MK002', 2),
('22003', 'MK003', 4),
('22004', 'MK004', 2),
('22005', 'MK005', 3);

-- 8. SELECT (memanggil data tertentu)
-- Semua mahasiswa
SELECT * FROM Mahasiswa;

-- Semua dosen
SELECT * FROM Dosen;

-- Semua mata kuliah
SELECT * FROM MataKuliah;

-- Semua data KRS
SELECT * FROM KRS;

-- Mahasiswa dengan angkatan 2022
SELECT * FROM Mahasiswa WHERE angkatan = 2022;

-- Mata kuliah yang diampu oleh 'D002'
SELECT * FROM MataKuliah WHERE nip = 'D002';


-- 9. UPDATE (ubah data)
-- Ubah nama mahasiswa dengan NIM tertentu
UPDATE Mahasiswa SET nama = 'Ibnu N. M.' WHERE nim = '230441100186';

-- Ubah jumlah SKS untuk MK002
UPDATE MataKuliah SET sks = 4 WHERE kode_mk = 'MK002';

-- 10. DELETE (hapus data)
-- Hapus mahasiswa tertentu
DELETE FROM Mahasiswa WHERE nim = '22006';

-- Hapus dosen tertentu
DELETE FROM Dosen WHERE nip = 'D010';

-- 11. Rename tabel Mahasiswa menjadi Student
ALTER TABLE Mahasiswa RENAME TO Student;

-- 12. DROP DATABASE
DROP DATABASE akademik;
