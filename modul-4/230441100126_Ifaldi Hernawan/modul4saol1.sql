USE db_sistem_manajemen_sekolah;

-- soal1
ALTER TABLE siswa
ADD COLUMN keterangan TEXT;
SELECT * FROM siswa;


-- soal2
SELECT 
    siswa.nama AS nama_siswa,
    siswa.nisn,
    nilai.semester,
    nilai.nilai_angka,
    nilai.nilai_huruf
FROM 
    siswa
JOIN 
    nilai ON siswa.id_siswa = nilai.id_siswa;
    
-- soal3
SELECT * FROM siswa
ORDER BY nama ASC;

SELECT * FROM nilai
ORDER BY semester ASC, nilai_angka DESC;

SELECT * FROM guru
ORDER BY nip DESC, nama ASC;

SELECT * FROM mapel
ORDER BY nama_mapel ASC;

SELECT * FROM jadwal
ORDER BY jam_mulai DESC;

-- soal4
ALTER TABLE siswa
MODIFY COLUMN alamat TEXT;
SELECT * FROM siswa;


-- soal5
SELECT siswa.nama, nilai.nilai_angka, nilai.nilai_huruf
FROM siswa 
LEFT JOIN nilai ON siswa.id_siswa = nilai.id_siswa;

SELECT nilai.id_siswa, siswa.nama, nilai.nilai_angka, nilai.nilai_huruf
FROM nilai
RIGHT JOIN siswa ON siswa.id_siswa = nilai.id_siswa;

SELECT g1.nama AS guru, g2.nama AS atasan_guru
FROM guru g1
LEFT JOIN guru g2 ON g1.id_guru = g2.id_guru;


-- soal6
SELECT *
FROM nilai
WHERE nilai_angka >= 75        -- Operator 1: lebih besar atau sama dengan
  AND nilai_angka <= 90        -- Operator 2: lebih kecil atau sama dengan
  AND semester = 'Ganjil'      -- Operator 3: sama dengan
  AND id_siswa != 3            -- Operator 4: tidak sama dengan
  AND nilai_huruf <> 'C';      -- Operator 5: tidak sama dengan (bentuk lain)

 

