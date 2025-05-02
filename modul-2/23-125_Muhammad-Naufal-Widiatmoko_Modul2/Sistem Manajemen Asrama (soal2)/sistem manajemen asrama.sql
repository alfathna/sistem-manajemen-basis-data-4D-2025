CREATE VIEW view_info_pemesanan AS
SELECT m.nim, m.nama, m.jurusan, p.tanggal_masuk, p.status
FROM mahasiswa m
JOIN pemesanan_kamar p ON m.id_mahasiswa = p.id_mahasiswa;

CREATE VIEW view_detail_pemesanan AS
SELECT m.nim, m.nama, k.nomor_kamar, p.tanggal_masuk, p.status
FROM pemesanan_kamar p
JOIN mahasiswa m ON p.id_mahasiswa = m.id_mahasiswa
JOIN kamar k ON p.id_kamar = k.id_kamar;

CREATE VIEW view_status_aktif AS
SELECT m.nim, m.nama, k.nomor_kamar, p.tanggal_masuk
FROM pemesanan_kamar p
JOIN mahasiswa m ON p.id_mahasiswa = m.id_mahasiswa
JOIN kamar k ON p.id_kamar = k.id_kamar
WHERE p.status = 'Aktif';

CREATE VIEW view_agregasi_penghuni_per_kamar AS
SELECT k.nomor_kamar, COUNT(p.id_mahasiswa) AS jumlah_penghuni
FROM kamar k
JOIN pemesanan_kamar p ON k.id_kamar = p.id_kamar
WHERE p.status = 'Aktif'
GROUP BY k.nomor_kamar;

CREATE VIEW view_jumlah_keluhan_per_fasilitas AS
SELECT 
    f.nama_fasilitas,
    COUNT(lk.id_keluhan) AS total_keluhan
FROM fasilitas f
LEFT JOIN laporan_keluhan lk ON f.id_fasilitas = lk.id_fasilitas
GROUP BY f.nama_fasilitas;


SELECT * FROM kamar;
SELECT * FROM fasilitas;
SELECT * FROM mahasiswa;
SELECT * FROM laporan_keluhan;
SELECT * FROM pemesanan_kamar;

SELECT * FROM view_info_pemesanan;

SELECT * FROM view_detail_pemesanan;

SELECT * FROM view_status_aktif;

SELECT * FROM view_agregasi_penghuni_per_kamar;

SELECT * FROM view_jumlah_keluhan_per_fasilitas;