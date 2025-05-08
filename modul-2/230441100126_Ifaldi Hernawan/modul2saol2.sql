USE db_sistem_manajemen_sekolah;

CREATE VIEW view_nilai_siswa AS
SELECT 
    s.nama AS nama_siswa,
    s.kelas,
    m.nama_mapel,
    n.semester,
    n.nilai_angka,
    n.nilai_huruf
FROM nilai n
JOIN siswa s ON n.id_siswa = s.id_siswa
JOIN mapel m ON n.id_mapel = m.id_mapel;

CREATE VIEW view_jadwal_pelajaran AS
SELECT 
    g.nama AS nama_guru,
    m.nama_mapel,
    j.kelas,
    j.hari,
    j.jam_mulai,
    j.jam_selesai
FROM jadwal j
JOIN guru g ON j.id_guru = g.id_guru
JOIN mapel m ON j.id_mapel = m.id_mapel;

CREATE VIEW view_siswa_perlu_remedial AS
SELECT 
    s.nama AS nama_siswa,
    s.kelas,
    n.nilai_angka,
    n.nilai_huruf,
    n.semester
FROM siswa s
JOIN nilai n ON s.id_siswa = n.id_siswa
WHERE n.nilai_angka < 75;


CREATE VIEW view_rata_nilai_per_kelas AS
SELECT 
    s.kelas,
    AVG(n.nilai_angka) AS rata_rata_nilai,
    COUNT(n.id_nilai) AS jumlah_data_nilai
FROM nilai n
JOIN siswa s ON n.id_siswa = s.id_siswa
GROUP BY s.kelas;

CREATE VIEW view_jumlah_nilai_siswa AS
SELECT 
    s.nama AS nama_siswa,
    s.kelas,
    COUNT(n.id_nilai) AS jumlah_mapel_dinilai
FROM siswa s
JOIN nilai n ON s.id_siswa = n.id_siswa
GROUP BY s.id_siswa, s.nama, s.kelas;

SELECT * FROM view_jumlah_nilai_siswa;
SELECT * FROM view_rata_nilai_per_kelas;
SELECT * FROM view_jadwal_pelajaran;
SELECT * FROM view_nilai_siswa;
SELECT * FROM view_siswa_perlu_remedial;



