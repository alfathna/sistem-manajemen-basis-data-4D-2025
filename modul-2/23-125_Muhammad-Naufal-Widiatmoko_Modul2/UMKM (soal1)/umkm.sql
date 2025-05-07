-- Tabel: skala_umkm
CREATE TABLE skala_umkm (
    id_skala INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nama_skala VARCHAR(50) NOT NULL,
    batas_aset_bawah DECIMAL(15,2) NOT NULL,
    batas_aset_atas DECIMAL(15,2) NOT NULL,
    batas_omzet_bawah DECIMAL(15,2) NOT NULL,
    batas_omzet_atas DECIMAL(15,2) NOT NULL
);

-- Tabel: kabupaten_kota
CREATE TABLE kabupaten_kota (
    id_kabupaten_kota INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nama_kabupaten_kota VARCHAR(100) NOT NULL
);

-- Tabel: kategori_umkm
CREATE TABLE kategori_umkm (
    id_kategori INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(100) NOT NULL,
    deskripsi TEXT NOT NULL
);

-- Tabel: pemilik_umkm
CREATE TABLE pemilik_umkm (
    id_pemilik INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nik VARCHAR(16) NOT NULL,
    nama_lengkap VARCHAR(200) NOT NULL,
    jenis_kelamin ENUM('Laki-laki', 'Perempuan') NOT NULL,
    alamat TEXT NOT NULL,
    nomor_telepon VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Tabel: umkm
CREATE TABLE umkm (
    id_umkm INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nama_usaha VARCHAR(200) NOT NULL,
    id_pemilik INT(11) NOT NULL,
    id_kategori INT(11) NOT NULL,
    id_skala INT(11) NOT NULL,
    id_kabupaten_kota INT(11) NOT NULL,
    alamat_usaha TEXT NOT NULL,
    nib VARCHAR(50) NOT NULL,
    npwp VARCHAR(20) NOT NULL,
    tahun_berdiri YEAR(4) NOT NULL,
    jumlah_karyawan INT(11) NOT NULL,
    total_aset DECIMAL(15,2) NOT NULL,
    omzet_per_tahun DECIMAL(15,2) NOT NULL,
    deskripsi_usaha TEXT NOT NULL,
    tanggal_registrasi DATE NOT NULL,
    FOREIGN KEY (id_pemilik) REFERENCES pemilik_umkm(id_pemilik),
    FOREIGN KEY (id_kategori) REFERENCES kategori_umkm(id_kategori),
    FOREIGN KEY (id_skala) REFERENCES skala_umkm(id_skala),
    FOREIGN KEY (id_kabupaten_kota) REFERENCES kabupaten_kota(id_kabupaten_kota)
);

-- Tabel: produk_umkm
CREATE TABLE produk_umkm (
    id_produk INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_umkm INT(11) NOT NULL,
    nama_produk VARCHAR(200) NOT NULL,
    deskripsi_produk TEXT NOT NULL,
    harga DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (id_umkm) REFERENCES umkm(id_umkm)
);

SELECT * FROM umkm;
SELECT * FROM kategori_umkm;
SELECT * FROM skala_umkm;
SELECT * FROM produk_umkm;
SELECT * FROM pemilik_umkm;
SELECT * FROM kabupaten_kota;

CREATE VIEW view_umkm_detail AS
SELECT 
    u.nama_usaha,
    p.nama_lengkap AS nama_pemilik,
    k.nama_kategori,
    s.nama_skala,
    kab.nama_kabupaten_kota,
    u.tahun_berdiri
FROM umkm u
JOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik
JOIN kategori_umkm k ON u.id_kategori = k.id_kategori
JOIN skala_umkm s ON u.id_skala = s.id_skala
JOIN kabupaten_kota kab ON u.id_kabupaten_kota = kab.id_kabupaten_kota;

CREATE VIEW view_pemilik_dan_usaha AS
SELECT 
    p.nik,
    p.nama_lengkap,
    p.jenis_kelamin,
    p.nomor_telepon,
    p.email,
    u.nama_usaha
FROM pemilik_umkm p
JOIN umkm u ON p.id_pemilik = u.id_pemilik;

CREATE VIEW view_produk_umkm AS
SELECT 
    u.nama_usaha,
    pr.nama_produk,
    pr.deskripsi,
    pr.harga
FROM produk_umkm pr
JOIN umkm u ON pr.id_umkm = u.id_umkm;

CREATE VIEW view_umkm_menengah AS
SELECT 
    u.nama_usaha,
    p.nama_lengkap AS nama_pemilik,
    u.total_aset,
    u.omzet_per_tahun
FROM umkm u
JOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik
JOIN skala_umkm s ON u.id_skala = s.id_skala
WHERE s.nama_skala = 'Menengah';

CREATE VIEW view_umkm_per_kota AS
SELECT 
    k.nama_kabupaten_kota,
    COUNT(u.id_umkm) AS jumlah_umkm
FROM umkm u
JOIN kabupaten_kota k ON u.id_kabupaten_kota = k.id_kabupaten_kota
GROUP BY k.nama_kabupaten_kota;

-- 1. Menampilkan isi view_umkm_detail
SELECT * FROM view_umkm_detail;

-- 2. Menampilkan isi view_pemilik_dan_usaha
SELECT * FROM view_pemilik_dan_usaha;

-- 3. Menampilkan isi view_produk_umkm
SELECT * FROM view_produk_umkm;

-- 4. Menampilkan isi view_umkm_menengah
SELECT * FROM view_umkm_menengah;

-- 5. Menampilkan isi view_umkm_per_kota
SELECT * FROM view_umkm_per_kota;
