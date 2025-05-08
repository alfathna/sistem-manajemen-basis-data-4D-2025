CREATE DATABASE kuliah;

USE kuliah;

CREATE TABLE Mahasiswa (
nim INT AUTO_INCREMENT NOT NULL,
nama VARCHAR(50)NOT NULL,
jurusan VARCHAR(50) NOT NULL,
semester INT NOT NULL,
PRIMARY KEY(nim)
);

CREATE TABLE Dosen (
nidn INT AUTO_INCREMENT NOT NULL,
nama VARCHAR(50) NOT NULL,
gelar VARCHAR(20) NOT NULL,
PRIMARY KEY(nidn)
);

CREATE TABLE MataKuliah (
kode_mk INT AUTO_INCREMENT NOT NULL,
nama_mk VARCHAR(50) NOT NULL,
sks INT NOT NULL,
nidn INT NOT NULL,
PRIMARY KEY(kode_mk)
);

ALTER TABLE matakuliah ADD CONSTRAINT fk_mk_dosen FOREIGN KEY (nidn) REFERENCES dosen(nidn);


CREATE TABLE KRS (
id_krs INT AUTO_INCREMENT NOT NULL,
nim INT(10)NOT NULL,
kode_mk INT(6)NOT NULL,
semester INT NOT NULL,
tahun_ajaran VARCHAR(9) NOT NULL,
PRIMARY KEY(id_krs)
);


ALTER TABLE KRS ADD CONSTRAINT fk_krs_mhs FOREIGN KEY (nim) REFERENCES mahasiswa(nim);
ALTER TABLE KRS ADD CONSTRAINT fk_dosen_mhs FOREIGN KEY (kode_mk) REFERENCES matakuliah(kode_mk);

FOREIGN KEY (nim) REFERENCES Mahasiswa(nim),
FOREIGN KEY (kode_mk) REFERENCES MataKuliah(kode_mk)


INSERT INTO Mahasiswa VALUES
('M001', 'Faldi Hernawan', 'Informatika', 4),
('M002', 'Rani Dewi', 'Informatika', 2),
('M003', 'Budi Santoso', 'Sistem Informasi', 6),
('M004', 'Siti Aminah', 'Teknik Komputer', 2),
('M005', 'Aldo Putra', 'Informatika', 4),
('M006', 'Nina Rahayu', 'Sistem Informasi', 3),
('M007', 'Ilham Saputra', 'Teknik Komputer', 1),
('M008', 'Rika Ayu', 'Informatika', 6),
('M009', 'Dimas Prasetyo', 'Sistem Informasi', 5),
('M010', 'Citra Lestari', 'Teknik Komputer', 3);


INSERT INTO Dosen VALUES
('D001', 'Dr. Rudi Hartono', 'M.Kom'),
('D002', 'Ir. Sulastri', 'MT'),
('D003', 'Ahmad Fauzi', 'M.Kom'),
('D004', 'Dr. Lestari', 'Ph.D'),
('D005', 'Bambang Supriadi', 'M.Kom'),
('D006', 'Yuni Wulandari', 'M.Sc'),
('D007', 'Satrio Wibowo', 'M.Kom'),
('D008', 'Rina Kusuma', 'M.Kom'),
('D009', 'Dedi Hermawan', 'M.T'),
('D010', 'Eka Fadilah', 'M.Kom');


INSERT INTO MataKuliah VALUES
('MK001', 'Basis Data', 3, 'D001'),
('MK002', 'Pemrograman Java', 3, 'D003'),
('MK003', 'Struktur Data', 2, 'D001'),
('MK004', 'Jaringan Komputer', 3, 'D009'),
('MK005', 'Algoritma', 3, 'D002'),
('MK006', 'Sistem Operasi', 2, 'D005'),
('MK007', 'Kecerdasan Buatan', 3, 'D004'),
('MK008', 'Manajemen Proyek', 2, 'D006'),
('MK009', 'Pemrograman Web', 3, 'D007'),
('MK010', 'Etika Profesi', 2, 'D010');

INSERT INTO KRS VALUES
('M001', 'MK001', 4, '2023/2024'),
('M002', 'MK002', 2, '2023/2024'),
('M003', 'MK003', 6, '2023/2024'),
('M004', 'MK004', 2, '2023/2024'),
('M005', 'MK005', 4, '2023/2024');


RENAME TABLE matkul TO matakuliah;

DROP DATABASE kuliah;

RENAME TABLE MataKuliah TO Matkul;


ALTER TABLE bro 
ADD CONSTRAINT pk_bro
PRIMARY KEY (ko);

ALTER TABLE bro
ADD CONSTRAINT fk_bro_dosen
FOREIGN KEY (nip)
REFERENCES dosen(nip);


SELECT * FROM dosen;
SELECT * FROM krs;
SELECT * FROM mahasiswa;
SELECT * FROM matakuliah;


DROP DATABASE db_sistem_manajemen_sekolah;


CREATE DATABASE db_sistem_manajemen_sekolah;
USE db_sistem_manajemen_sekolah;

CREATE TABLE siswa (
id_siswa INT AUTO_INCREMENT NOT NULL,
nama VARCHAR(100) NOT NULL,
nisn VARCHAR(20) UNIQUE NOT NULL,
kelas VARCHAR(10)NOT NULL,
alamat TEXT NOT NULL,
PRIMARY KEY(id_siswa)
);

CREATE TABLE guru (
id_guru INT AUTO_INCREMENT NOT NULL,
nama VARCHAR(100) NOT NULL,
nip VARCHAR(20) UNIQUE NOT NULL,
mata_pelajaran VARCHAR(50) NOT NULL,
PRIMARY KEY(id_guru)
);

CREATE TABLE mapel (
id_mapel INT AUTO_INCREMENT NOT NULL,
nama_mapel VARCHAR(100) NOT NULL,
tingkat VARCHAR(10)NOT NULL,
PRIMARY KEY(id_mapel)
);

CREATE TABLE jadwal (
id_jadwal INT AUTO_INCREMENT NOT NULL,
id_guru INT NOT NULL,
id_mapel INT NOT NULL,
kelas VARCHAR(100) NOT NULL,
hari VARCHAR(150)NOT NULL,
jam_mulai TIME NOT NULL,
jam_selesai TIME NOT NULL,
PRIMARY KEY(id_jadwal)
);

ALTER TABLE jadwal ADD CONSTRAINT fk_gr FOREIGN KEY (id_guru) REFERENCES guru(id_guru);
ALTER TABLE jadwal ADD CONSTRAINT fk_gr FOREIGN KEY (id_mapel) REFERENCES mapel(id_mapel);

CREATE TABLE nilai (
id_nilai INT AUTO_INCREMENT NOT NULL,
id_siswa INT NOT NULL,
id_mapel INT NOT NULL,
semester VARCHAR(10) NOT NULL,
nilai_angka DECIMAL(5,2) NOT NULL,
nilai_huruf VARCHAR(2)NOT NULL,
PRIMARY KEY(id_nilai)
);

ALTER TABLE nilai ADD CONSTRAINT fk_nl FOREIGN KEY (id_siswa) REFERENCES siswa(id_siswa);
ALTER TABLE nilai ADD CONSTRAINT fk_nl FOREIGN KEY (id_mapel) REFERENCES mapel(id_mapel);


SELECT * FROM guru;
SELECT * FROM jadwal;
SELECT * FROM mapel;
SELECT * FROM nilai;
SELECT * FROM siswa;
