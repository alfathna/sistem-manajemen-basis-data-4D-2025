USE umkm_jawa_barat;

CREATE VIEW view_umkm_detail AS
SELECT u.nama_usaha AS 'Nama Usaha', p.nama_lengkap AS 'Nama Pemilik',
k.nama_kategori AS 'Kategori UMKM', s.nama_skala AS 'Skala Usaha',
kb.nama_kabupaten_kota AS 'Nama Kabupaten/Kota', u.tahun_berdiri AS 'Tahun Berdiri'
FROM umkm u
JOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik
JOIN kategori_umkm k ON u.id_kategori = k.id_kategori
JOIN skala_umkm s ON u.id_skala = s.id_skala
JOIN kabupaten_kota kb ON u.id_kabupaten_kota = kb.id_kabupaten_kota;
SELECT * FROM view_umkm_detail;

CREATE VIEW view_pemilik_dan_usaha AS 
SELECT p.NIK AS 'NIK', p.nama_lengkap AS 'Nama Pemilik',
p.jenis_kelamin AS 'Jenis Kelamin', p.nomor_telepon AS 'No Telepon',
p.email AS 'Email', u.nama_usaha AS 'Nama Usaha'
FROM pemilik_umkm p
JOIN umkm u ON u.id_pemilik = p.id_pemilik;
SELECT * FROM view_pemilik_dan_usaha;

CREATE VIEW view_produk_umkm AS
SELECT u.nama_usaha AS 'Nama Usaha', pr.nama_produk AS 'Nama Produk',
pr.deskripsi_produk AS 'Deskripsi Produk', pr.harga AS 'Harga'
FROM produk_umkm pr
JOIN umkm u ON u.id_umkm = pr.id_umkm;
SELECT * FROM view_produk_umkm;

CREATE VIEW view_umkm_menengah AS
SELECT s.nama_skala AS 'Skala Usaha', u.nama_usaha AS 'Nama Usaha',
p.nama_lengkap AS 'Nama Pemilik', u.total_aset 'Total Aset UMKM',
u.omzet_per_tahun 'Omset Per Tahun' 
FROM skala_umkm s
JOIN umkm u ON u.id_skala = s.id_skala
JOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik
WHERE s.batas_aset_atas = 10000000000;
SELECT * FROM view_umkm_menengah;

CREATE VIEW view_umkm_per_kota AS
SELECT kk.nama_kabupaten_kota AS 'Kabupaten/Kota', 
COUNT(u.id_umkm) AS 'Jumlah UMKM'
FROM umkm u
JOIN kabupaten_kota kk ON u.id_kabupaten_kota = kk.id_kabupaten_kota
GROUP BY kk.nama_kabupaten_kota;
SELECT * FROM view_umkm_per_kota;