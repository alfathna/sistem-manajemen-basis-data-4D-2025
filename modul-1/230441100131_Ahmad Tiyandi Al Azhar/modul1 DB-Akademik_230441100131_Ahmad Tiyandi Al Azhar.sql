 
CREATE DATABASE akademik_prodi;
USE akademik_prodi;

CREATE TABLE Program_Studi (
    id_prodi INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nama_prodi VARCHAR(100) NOT NULL,
    jenjang ENUM('D3', 'S1', 'S2', 'S3') NOT NULL
);

CREATE TABLE Mahasiswa (
    nim INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    jenis_kelamin ENUM('Laki-laki', 'Perempuan') NOT NULL,
    tanggal_lahir DATE NOT NULL,
    alamat TEXT NOT NULL,
    id_prodi INT NOT NULL
);

CREATE TABLE Dosen (
    nidn INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nama VARCHAR(100)NOT NULL,
    gelar VARCHAR(20)NOT NULL,
    email VARCHAR(100)NOT NULL,
    no_hp VARCHAR(15)NOT NULL,
    id_prodi INT NOT NULL
);

CREATE TABLE Mata_Kuliah (
    kode_mk INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nama_mk VARCHAR(100)NOT NULL,
    sks INT NOT NULL,
    semester INT NOT NULL,
    nidn CHAR(10) NOT NULL
);

CREATE TABLE Tahun_Akademik (
    id_ta INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tahun VARCHAR(9)NOT NULL,
    semester ENUM('Ganjil', 'Genap') NOT NULL,
    STATUS ENUM('Aktif', 'Nonaktif') NOT NULL
);

CREATE TABLE KRS (
    id_krs INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nim CHAR(10) NOT NULL,
    kode_mk CHAR(6) NOT NULL,
    id_ta INT NOT NULL,
    nilai CHAR(2) NOT NULL
);

ALTER TABLE Mahasiswa ADD CONSTRAINT fk_mahasiswa_prodi FOREIGN KEY (id_prodi) REFERENCES Program_Studi(id_prodi);

ALTER TABLE Dosen ADD CONSTRAINT fk_dosen_prodi FOREIGN KEY (id_prodi) REFERENCES Program_Studi(id_prodi);

ALTER TABLE Mata_Kuliah ADD CONSTRAINT fk_mk_dosen FOREIGN KEY (nidn) REFERENCES Dosen(nidn);

ALTER TABLE KRS 
    ADD CONSTRAINT fk_krs_mahasiswa FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
    ADD CONSTRAINT fk_krs_matkul FOREIGN KEY (kode_mk) REFERENCES Mata_Kuliah(kode_mk),
    ADD CONSTRAINT fk_krs_tahunakademik FOREIGN KEY (id_ta) REFERENCES Tahun_Akademik(id_ta);

INSERT INTO Program_Studi (nama_prodi, jenjang) VALUES
('Teknik Informatika', 'S1'),
('Sistem Informasi', 'S1');

INSERT INTO Mahasiswa VALUES
('2301000001', 'Rizki Ahmad', 'Laki-laki', '2004-02-01', 'Jl. Mawar 1', 1),
('2301000002', 'Lina Sari', 'Perempuan', '2003-05-17', 'Jl. Melati 2', 2),
('2301000003', 'Budi Santoso', 'Laki-laki', '2002-03-21', 'Jl. Kenanga 3', 1),
('2301000004', 'Dewi Kartika', 'Perempuan', '2004-06-12', 'Jl. Dahlia 4', 2),
('2301000005', 'Rian Pratama', 'Laki-laki', '2003-11-23', 'Jl. Flamboyan 5', 1),
('2301000006', 'Siti Aminah', 'Perempuan', '2002-12-20', 'Jl. Cemara 6', 1),
('2301000007', 'Fajar Nugroho', 'Laki-laki', '2003-08-15', 'Jl. Sakura 7', 2),
('2301000008', 'Indah Permata', 'Perempuan', '2004-09-09', 'Jl. Mawar 8', 2),
('2301000009', 'Hendra Saputra', 'Laki-laki', '2002-07-07', 'Jl. Melati 9', 1),
('2301000010', 'Nur Aini', 'Perempuan', '2003-10-01', 'Jl. Kenanga 10', 2);

INSERT INTO Dosen VALUES
('1980121001', 'Dr. Slamet Hadi', 'M.Kom', 'slamet@kampus.ac.id', '081234567890', 1),
('1975112202', 'Ir. Sulastri', 'M.T', 'sulastri@kampus.ac.id', '081234567891', 2),
('1987081503', 'Ahmad Yani', 'M.Kom', 'ahmad@kampus.ac.id', '081234567892', 1),
('1990021004', 'Dewi Lestari', 'M.Pd', 'dewi@kampus.ac.id', '081234567893', 1),
('1981122305', 'Rina Wahyuni', 'M.Kom', 'rina@kampus.ac.id', '081234567894', 2),
('1979111506', 'Bambang Supriadi', 'M.T', 'bambang@kampus.ac.id', '081234567895', 1),
('1983052707', 'Sri Rahayu', 'M.Kom', 'sri@kampus.ac.id', '081234567896', 2),
('1994010508', 'Fikri Hidayat', 'M.Kom', 'fikri@kampus.ac.id', '081234567897', 2),
('1972120109', 'Nurul Azizah', 'M.Kom', 'nurul@kampus.ac.id', '081234567898', 1),
('1986060210', 'Yusuf Maulana', 'M.Pd', 'yusuf@kampus.ac.id', '081234567899', 2);

INSERT INTO Mata_Kuliah VALUES
('IF101', 'Pemrograman Dasar', 3, 1, '1980121001'),
('IF102', 'Struktur Data', 3, 2, '1975112202'),
('IF103', 'Basis Data', 3, 2, '1987081503'),
('IF104', 'Jaringan Komputer', 3, 3, '1990021004'),
('IF105', 'Sistem Operasi', 3, 3, '1981122305'),
('IF106', 'Kecerdasan Buatan', 3, 5, '1979111506'),
('IF107', 'Pemrograman Web', 3, 4, '1983052707'),
('IF108', 'Rekayasa Perangkat Lunak', 3, 5, '1994010508'),
('IF109', 'Data Mining', 3, 6, '1972120109'),
('IF110', 'Etika Profesi', 2, 1, '1986060210');

INSERT INTO Tahun_Akademik (tahun, semester, STATUS) VALUES
('2023/2024', 'Ganjil', 'Aktif'),
('2023/2024', 'Genap', 'Nonaktif');

INSERT INTO KRS (nim, kode_mk, id_ta, nilai) VALUES
('2301000001', 'IF101', 1, 'A'),
('2301000002', 'IF102', 1, 'B+'),
('2301000003', 'IF103', 1, 'B'),
('2301000004', 'IF104', 1, 'A'),
('2301000005', 'IF105', 1, 'B-');

-- RENAME TABLE Mahasiswa TO Data_Mahasiswa;

 DROP DATABASE akademik_prodi;
