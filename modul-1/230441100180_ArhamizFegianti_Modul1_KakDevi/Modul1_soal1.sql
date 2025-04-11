USE akademik_prodi;

CREATE TABLE data_mahasiswa (
NIM INT(15) PRIMARY KEY NOT NULL,
nama VARCHAR(25) NOT NULL,
asal_kota VARCHAR(20) NOT NULL,
prodi VARCHAR(20) NOT NULL,
j_kelamin ENUM('Perempuan','Laki-laki') NOT NULL);

ALTER TABLE data_mahasiswa DROP COLUMN asal_kota;
ALTER TABLE data_mahasiswa ADD asal_kota VARCHAR(20) NOT NULL;
ALTER TABLE data_mahasiswa nama nama_mahasiswa VARCHAR(50);

CREATE TABLE dosen (
NIP INT(10) PRIMARY KEY NOT NULL,
nama VARCHAR(20) NOT NULL,
asal_kota VARCHAR(20));
ALTER TABLE dosen ADD prodi VARCHAR(20) NOT NULL;

CREATE TABLE mata_kuliah (
id_mk INT(10) PRIMARY KEY,
nama_mk VARCHAR(50) NOT NULL,
sks INT(2) NOT NULL);
ALTER TABLE mata_kuliah ADD COLUMN NIP INT(10) NULL;
ALTER TABLE mata_kuliah ADD FOREIGN KEY (NIP) REFERENCES dosen(NIP) ON DELETE SET NULL;

CREATE TABLE krs (
id_krs INT(10) PRIMARY KEY NOT NULL,
maks_sks INT(2) NOT NULL,
semester INT(2) NOT NULL);
ALTER TABLE krs ADD tahun YEAR(4) NOT NULL;
ALTER TABLE krs ADD COLUMN NIM INT(15) NOT NULL;
ALTER TABLE krs ADD FOREIGN KEY (NIM) REFERENCES data_mahasiswa(NIM) ON DELETE CASCADE;
ALTER TABLE krs ADD COLUMN NIP INT(10) NULL;
ALTER TABLE krs ADD FOREIGN KEY (NIP) REFERENCES dosen(NIP) ON DELETE SET NULL;

CREATE TABLE kuliah (
NIM INT(15) NOT NULL,
id_mk INT(10) NOT NULL,
semester ENUM('Ganjil', 'Genap') NOT NULL,
nilai VARCHAR(2) NOT NULL);

DROP TABLE kuliah;
ALTER TABLE kuliah ADD CONSTRAINT fk_NIM FOREIGN KEY (NIM) REFERENCES data_mahasiswa(NIM);
ALTER TABLE kuliah ADD CONSTRAINT fk_id_mk FOREIGN KEY (id_mk) REFERENCES mata_kuliah(id_mk);

CREATE TABLE detail_krs (
id_krs INT(10) NOT NULL,
id_mk INT(10) NOT NULL,
FOREIGN KEY (id_krs) REFERENCES krs(id_krs) ON DELETE CASCADE,
FOREIGN KEY (id_mk) REFERENCES mata_kuliah(id_mk) ON DELETE CASCADE);
ALTER TABLE detail_krs ADD COLUMN tanggal_pengambilan DATE;

INSERT INTO data_mahasiswa (NIM, nama, asal_kota, prodi, j_kelamin) VALUES 
(23180, 'Arhamiz', 'Sidoarjo', 'Sistem Informasi', 'Perempuan'),
(23100, 'Lily', 'Bangkalan', 'Sistem Informasi', 'Perempuan'),
(23110, 'Crysna', 'Bandung', 'Sistem Informasi', 'Laki-laki'),
(23123, 'Sindy', 'Sidoarjo', 'Sistem Informasi', 'Perempuan'),
(23009, 'Amel', 'Sidoarjo', 'Sistem Informasi', 'Perempuan'),
(23001, 'Fira', 'Bangkalan', 'Sistem Informasi', 'Perempuan'),
(23051, 'Sarah', 'Medan', 'Sistem Informasi', 'Perempuan'),
(23075, 'Ella', 'Sidoarjo', 'Sistem Informasi', 'Perempuan'),
(23090, 'Amira', 'Sidoarjo', 'Sistem Informasi', 'Perempuan'),
(23135, 'Merlin', 'Sidoarjo', 'Sistem Informasi', 'Perempuan');
SELECT * FROM data_mahasiswa;

INSERT INTO dosen (NIP, nama, asal_kota, prodi) VALUES 
(1001, 'Dr. Budi Satoto', 'Sidoarjo', 'Sistem Informasi'),
(1002, 'Prof. Budi Dwi', 'Surabaya', 'Sistem Informasi'),
(1003, 'Prof. Aeri', 'Semarang', 'Sistem Informasi'),
(1004, 'Dr. Firli', 'Nganjuk', 'Sistem Informasi'),
(1005, 'Dr. Dony', 'Malang', 'Sistem Informasi'),
(1006, 'Dr. Ali Syakur', 'Mojokerto', 'Sistem Informasi'),
(1007, 'Dr. Yusuf', 'Gresik', 'Sistem Informasi'),
(1008, 'Drs. Hera', 'Bandung', 'Sistem Informasi'),
(1009, 'Drs. Eza Rahmawati', 'Surabaya', 'Sistem Informasi'),
(1010, 'Drs. Novi', 'Sidoarjo', 'TSistem Informasi');
SELECT * FROM dosen;

INSERT INTO mata_kuliah (id_mk, nama_mk, sks, NIP) VALUES
(401, 'MPIT', 3, 1010),
(402, 'Riset Operasi', 3, 1009),
(403, 'Sistem Pengambil Keputusan', 3, 1008),
(404, 'Arsitektur Perusahaan', 3, 1007),
(405, 'Etika Profesi', 3, 1006),
(406, 'Interaksi Manusia & Komputer', 3, 1005),
(407, 'Sistem Operasi', 3, 1004),
(408, 'Pemrograman Bergerak', 4, 1003),
(409, 'Manajemen Desain Jaringan', 3, 1002),
(410, 'Data Mining', 3, 1001);
SELECT * FROM mata_kuliah;

INSERT INTO krs (id_krs, maks_sks, semester, tahun, NIM, NIP) VALUES
(1, 24, 4, 2024, 23180, 1010),
(2, 22, 4, 2024, 23100, 1003),
(3, 23, 4, 2024, 23110, 1008),
(4, 24, 4, 2024, 23123, 1001),
(5, 22, 4, 2024, 23009, 1006);
SELECT * FROM krs;

ALTER TABLE krs RENAME TO krs_mahasiswa;
DROP DATABASE akademik_prodi;