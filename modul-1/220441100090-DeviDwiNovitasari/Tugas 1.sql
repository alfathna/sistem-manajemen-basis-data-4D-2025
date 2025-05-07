CREATE DATABASE AkademikProgramStudi;
USE AkademikProgramStudi;

DROP TABLE IF EXISTS mahasiswa;

CREATE TABLE mahasiswa (
  nim INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nama VARCHAR(50) NOT NULL,
  jurusan VARCHAR(50) NOT NULL,
  semester INT(11) NOT NULL
);

DROP TABLE krs;

INSERT  INTO `mahasiswa`(`nim`,`nama`,`jurusan`,`semester`) VALUES
('220001', 'Ahmad Fauzi', 'Sistem Informasi', '4'),
('220002', 'Budi Santoso', 'Teknik Informatika', '4'),
('220003', 'Citra Lestari', 'Pendidikan Informatika', '2'),
('220004', 'Dewi Permata', 'Pendidikan MIPA', '4'),
('220005', 'Eko Saputra', 'PGSD', '2'),
('220006', 'Farah Indah', 'PGPAUD', '2'),
('220007', 'Gilang Pratama', 'Teknik Elektro', '4'),
('220008', 'Hesti Wijaya', 'Teknik Industri', '4'),
('220009', 'Indra Maulana', 'Mekatronika', '2'),
('220010', 'Joko Susilo', 'Kelautan', '2');

DROP TABLE IF EXISTS dosen;

CREATE TABLE dosen (
  nidn INT(10) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nama VARCHAR(50) NOT NULL,
  gelar VARCHAR(20) NOT NULL,
  pengajar VARCHAR(50) NOT NULL
);

INSERT  INTO `dosen`(`nidn`,`nama`,`gelar`,`pengajar`) VALUES
('1981001', 'Prof. Dr. Suryadi', 'S3', 'Kecerdasan Buatan'),
('1982002', 'Dr. Ratna Sari', 'S3', 'Sistem Informasi'),
('1983003', 'Dr. Bambang Wibowo', 'S3', 'Data Science'),
('1984004', 'Dr. Agus Setiawan', 'S3', 'Jaringan Komputer'),
('1985005', 'Dr. Yulianti Dewi', 'S3', 'Rekayasa Perangkat Lunak'),
('1986006', 'Prof. Dr. Sutrisno', 'S3', 'Manajemen Proyek TI'),
('1987007', 'Dr. Dwi Handayani', 'S3', 'Komputasi Awan'),
('1988008', 'Dr. Fajar Nugroho', 'S3', 'Pemrograman Web'),
('1989009', 'Dr. Lia Anggraini', 'S3', 'Internet of Things'),
('1990010', 'Dr. Slamet Haryono', 'S3', 'Keamanan Siber');

DROP TABLE IF EXISTS `matakuliah`;

CREATE TABLE matakuliah (
  kode_mk INT(6) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nama_mk VARCHAR(50) NOT NULL,
  sks INT(11) NOT NULL,
  nidn INT(10) NOT NULL
);
 ALTER TABLE matakuliah ADD CONSTRAINT `matakuliah_ibfk_1` FOREIGN KEY (nidn) REFERENCES dosen (nidn);

INSERT INTO `matakuliah` (`kode_mk`, `nama_mk`, `sks`, `nidn`) VALUES
(1, 'Algoritma dan Pemrograman', 3, '1981001'),
(2, 'Struktur Data', 3, '1982002'),
(3, 'Basis Data', 4, '1983003'),
(4, 'Pemrograman Web', 3, '1988008'),
(5, 'Jaringan Komputer', 3, '1984004'),
(6, 'Kecerdasan Buatan', 3, '1981001'),
(7, 'Data Science', 4, '1983003'),
(8, 'Sistem Operasi', 3, '1984004'),
(9, 'Manajemen Proyek TI', 2, '1986006'),
(10, 'Keamanan Jaringan', 3, '1990010');

DROP TABLE IF EXISTS krs;

CREATE TABLE krs (
  id_krs INT(11) PRIMARY KEY AUTO_INCREMENT NOT NULL ,
  nim INT(10) NOT NULL,
  kode_mk INT(6) NOT NULL,
  semester INT(11) NOT NULL
);

ALTER TABLE krs ADD CONSTRAINT krs_ibfk_1 FOREIGN KEY (nim) REFERENCES mahasiswa (nim);
ALTER TABLE krs ADD CONSTRAINT krs_ibfk_2 FOREIGN KEY (kode_mk) REFERENCES matakuliah (kode_mk);

DROP TABLE krs;

INSERT  INTO krs(id_krs, nim, kode_mk, semester) VALUES 
(1,'220001', 1, 4),
(2,'220002', 3, 4),
(3,'220003', 5, 2),
(4,'220004', 2, 4),
(5,'220005', 6, 2);

SELECT * FROM mahasiswa;
SELECT * FROM dosen;
SELECT * FROM matakuliah;
SELECT * FROM krs;

RENAME TABLE mhs TO mahasiswa;

SELECT * FROM mahasiswa;

DROP DATABASE akademikprogramstudi;