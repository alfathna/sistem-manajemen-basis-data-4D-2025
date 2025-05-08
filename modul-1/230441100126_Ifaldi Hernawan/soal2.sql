USE db_sistem_manajemen_sekolah;

CREATE TABLE siswa (
    id_siswa INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    nisn VARCHAR(20) UNIQUE NOT NULL,
    kelas VARCHAR(10),
    alamat TEXT
);

CREATE TABLE guru (
    id_guru INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    nip VARCHAR(20) UNIQUE NOT NULL,
    mata_pelajaran VARCHAR(50)
);

CREATE TABLE mapel (
    id_mapel INT AUTO_INCREMENT PRIMARY KEY,
    nama_mapel VARCHAR(100) NOT NULL,
    tingkat VARCHAR(10)
);

CREATE TABLE jadwal (
    id_jadwal INT AUTO_INCREMENT PRIMARY KEY,
    id_guru INT NOT NULL,
    id_mapel INT NOT NULL,
    kelas VARCHAR(10) NOT NULL,
    hari VARCHAR(15),
    jam_mulai TIME,
    jam_selesai TIME,
    FOREIGN KEY (id_guru) REFERENCES guru(id_guru),
    FOREIGN KEY (id_mapel) REFERENCES mapel(id_mapel)
);

CREATE TABLE nilai (
    id_nilai INT AUTO_INCREMENT PRIMARY KEY,
    id_siswa INT NOT NULL,
    id_mapel INT NOT NULL,
    semester VARCHAR(10),
    nilai_angka DECIMAL(5,2),
    nilai_huruf VARCHAR(2),
    FOREIGN KEY (id_siswa) REFERENCES siswa(id_siswa),
    FOREIGN KEY (id_mapel) REFERENCES mapel(id_mapel)
);

SELECT * FROM siswa;
SELECT * FROM guru;
SELECT * FROM mapel;
SELECT * FROM jadwal;
SELECT * FROM nilai;

INSERT INTO siswa (id_siswa, nama, nisn, kelas, alamat)
VALUES 
(6, 'Salsabila Nur', '0006', 'XI IPA 1', 'Jl. Cemara No. 6'),
(7, 'Rendi Maulana', '0007', 'XII IPA 2', 'Jl. Teratai No. 7'),
(8, 'Nadya Karina', '0008', 'X IPS 1', 'Jl. Sawo No. 8'),
(9, 'Galang Pradana', '0009', 'XI IPS 2', 'Jl. Merpati No. 9'),
(10, 'Laras Anindya', '0010', 'X IPA 1', 'Jl. Flamboyan No. 10');

INSERT INTO nilai (id_nilai, id_siswa, id_mapel, nilai_angka, nilai_huruf, semester)
VALUES 
(6, 6, 1, 65.00, 'D+', 'Genap'),
(7, 7, 2, 70.00, 'C', 'Ganjil'),
(8, 8, 3, 68.50, 'C', 'Genap'),
(9, 9, 1, 73.00, 'C+', 'Genap'),
(10, 10, 2, 62.50, 'D', 'Ganjil');

ALTER TABLE nilai DROP FOREIGN KEY fk_nl;

ALTER TABLE nilai
ADD CONSTRAINT fk_nl
FOREIGN KEY (id_siswa) REFERENCES siswa(id_siswa)
ON DELETE CASCADE;

