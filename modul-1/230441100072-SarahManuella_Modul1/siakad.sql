CREATE DATABASE siakad;
USE siakad;
CREATE TABLE Mahasiswa (
    nim INT PRIMARY KEY,
    nama VARCHAR(100),
    tanggal_lahir DATE,
    jurusan VARCHAR(100),
    email VARCHAR(100)
);
ALTER TABLE Mahasiswa ADD COLUMN semester INT;

ALTER TABLE Mahasiswa DROP COLUMN semester;

CREATE TABLE Dosen (
nip INT PRIMARY KEY,
nama VARCHAR (50),
gelar VARCHAR (25),
email VARCHAR (50)
);


CREATE TABLE Mata_Kuliah (
id_mk INT PRIMARY KEY AUTO_INCREMENT,
nama_mk VARCHAR(100),
sks int,
semester int
);


create table detail_minat (
nip int,
id_mk int,
foreign key (nip) references Dosen (nip) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (id_mk) REFERENCES Mata_Kuliah(id_mk) ON DELETE CASCADE ON UPDATE CASCADE
);


create table krs(
id_krs int primary key auto_increment,
nim int,
dosen_pembimbing int,
foreign key (nim) references Mahasiswa(nim),
foreign key (dosen_pembimbing) references Dosen(nip)
);

drop table krs;

create table krs (
id_krs INT PRIMARY KEY AUTO_INCREMENT,
nim INT,
dosen_pembimbing INT);

ALTER TABLE krs 
ADD CONSTRAINT fk_krs_mahasiswa FOREIGN KEY (nim) REFERENCES Mahasiswa(nim) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk_krs_dosen FOREIGN KEY (dosen_pembimbing) REFERENCES Dosen(nip) ON DELETE SET NULL ON UPDATE CASCADE;


create table detail_krs (
id_detail_krs int primary key auto_increment,
nim int,
id_mk int,
foreign key (nim) references Mahasiswa (nim),
foreign key (id_mk) references Mata_Kuliah(id_mk)
);


#SOAL NOMOR 2
insert into Mahasiswa (nim,nama,tanggal_lahir,jurusan,email) values 
(23044110001,'Magfirah','2004-12-15','Sistem Informasi','Fira@gmail.com'),
(123,'Sarah Manuella','2005-08-21','Sistem Informasi','Sarahluga21@gmail.com'),
(124,'nabila','2004-08-21','Sistem Informasi','Sarahluga22@gmail.com'),
(205, 'Eko nazwa', '2001-07-30', 'Teknik Komputer', 'eko.prabowo@gmail'),
(206, 'Fani Rahma', '2000-11-11', 'Teknik Informatika', 'fani.rahma@gmail.com'),
(207, 'Gita Sari', '1999-09-09', 'Sistem Informasi', 'gita.sari@gmail.com'),
(208, 'Hendra Setiawan', '2000-02-14', 'Teknik Komputer', 'hendra.setiawan@egmail.com'),
(209, 'Indah Permata', '1998-10-10', 'Teknik Informatika', 'indah.permata@gmail.com'),
(200, 'Putri Natasya', '1998-10-10', 'Teknik Informatika', 'indah.permata@gmail.com'),
(210, 'Joko Widodo', '2001-04-20', 'Sistem Informasi', 'joko.widodo@gmail.com');

INSERT INTO Dosen (nip, nama, gelar, email) VALUES
(101, 'Dr. Budi Dwi Satoto', 'S.T., M.Kom.', 'budids@trunojoyo.ac.id'),
(102, 'Wahyudi Agustiono', 'S.Kom., M.Sc., Ph.D', ' wahyudi.agustiono@trunojoyo.ac.id'),
(103, 'Dr. Yeni Kustiyahningsih', 'S.Kom., M.Kom.', 'cindy.lestari@example.com'),
(104, 'Dr. Dedi Supriyadi', 'S.Kom., M.Kom.', 'dedi.supriyadi@example.com'),
(105, 'Dr. Eko Wibowo', 'S.T., M.T.', 'eko.wibowo@example.com'),
(106, 'Dr. Fani Rahmawati', 'S.Kom., M.Kom.', 'fani.rahmawati@example.com'),
(107, 'Dr. Gita Sari', 'S.T., M.T.', 'gita.sari@example.com'),
(108, 'Dr. Hendra Setiawan', 'S.Kom., M.Kom.', 'hendra.setiawan@example.com'),
(109, 'Dr. Indah Permatasari', 'S.T., M.T.', 'indah.permatasari@example.com'),
(110, 'Imamah, S.Kom.', 'M.Kom.', 'i2m@trunojoyo.ac.id');

UPDATE Dosen
SET nip = 120 WHERE nama ="Dr. Budi Dwi Satoto";

INSERT INTO detail_minat (nip, id_mk) VALUES
(103,1),
(101,2),
(104,2),
(105,3),
(106,5);
delete from detail_minat where nip = 103;
DELETE FROM detail_minat WHERE nip = 101;


INSERT INTO Mata_Kuliah (id_mk, nama_mk, sks, semester) VALUES
(1, 'Algoritma Pemrograman', 3, 1),
(2, 'Pemrograman Berbasis Web', 3, 2),
(3, 'Sistem pendukung Keputusan', 3, 4),
(4, 'Manajemen Proyek IT', 3, 4),
(5, 'Financial Technology', 3, 4),
(6, 'Sistem Manajemen Basis', 3, 4),
(7, 'Implementasi dan Pengujian Perangkat Lunak', 3, 4),
(8, 'Dat Mining', 3, 5),
(9, 'Pemrograman Berbasis Objek', 3, 2),
(10, 'Mobile Programming', 3, 4);

UPDATE mata_kuliah
SET semester = 3 WHERE nama_mk ='Algoritma Pemrograman';

UPDATE mata_kuliah
SET semester = 3 WHERE nama_mk ='Pemrograman Berbasis Web';



#SOAL NOMOR 3
select * from Mata_Kuliah;
SELECT * FROM detail_krs;
select * from detail_minat;
SELECT * FROM mahasiswa;
SELECT * FROM dosen;


#SOAL NOMOR 4
INSERT into krs (nim, dosen_pembimbing) values 
(123,101),
(205,101),
(206,104),
(207,105),
(208,105);

select dosen_pembimbing from krs where nim=123;
SELECT COUNT(*) FROM Mahasiswa;

select nama from Mahasiswa,krs where dosen_pembimbing = 101;

DELETE FROM mata_kuliah WHERE id_mk = 1;
DELETE FROM mata_kuliah WHERE id_mk = 2


update dosen
set email = 'sarahmanuellalumbangaol' where nip= 103;


#SOAL NOMOR 5
#ALTER TABLE detail_krs RENAME TO daftar_krs;


#SOAL NOMOR 6
#DROP siakad






