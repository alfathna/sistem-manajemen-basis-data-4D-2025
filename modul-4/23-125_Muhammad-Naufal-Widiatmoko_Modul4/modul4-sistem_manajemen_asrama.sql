ALTER TABLE kamar
ADD COLUMN status_kamar ENUM('Single', 'Double', 'Triple', 'Family') AFTER id_kamar;

ALTER TABLE kamar
ADD COLUMN keterangan TEXT AFTER status_kamar;

SELECT pk.id_pemesanan, m.nama, pk.id_kamar, pk.tanggal_masuk, pk.status
FROM pemesanan_kamar pk
JOIN mahasiswa m ON pk.id_mahasiswa = m.id_mahasiswa;

SELECT * FROM mahasiswa
ORDER BY nama ASC;
SELECT * FROM pemesanan_kamar
ORDER BY tanggal_masuk DESC;

ALTER TABLE pemesanan_kamar
MODIFY COLUMN STATUS ENUM('Pending', 'Aktif', 'Selesai') DEFAULT 'Pending';

SELECT m.nama, pk.id_kamar
FROM mahasiswa m
LEFT JOIN pemesanan_kamar pk ON m.id_mahasiswa = pk.id_mahasiswa;

SELECT m.nama, pk.id_kamar
FROM mahasiswa m
RIGHT JOIN pemesanan_kamar pk ON m.id_mahasiswa = pk.id_mahasiswa;

SELECT m1.nama AS Mahasiswa_1, m2.nama AS Mahasiswa_2, pk1.id_kamar
FROM pemesanan_kamar pk1
JOIN pemesanan_kamar pk2 ON pk1.id_kamar = pk2.id_kamar AND pk1.id_pemesanan <> pk2.id_pemesanan
JOIN mahasiswa m1 ON pk1.id_mahasiswa = m1.id_mahasiswa
JOIN mahasiswa m2 ON pk2.id_mahasiswa = m2.id_mahasiswa;

-- 1. Sama dengan (=)
SELECT * FROM pemesanan_kamar WHERE status = 'Aktif';

-- 2. Tidak sama dengan (<>)
SELECT * FROM kamar WHERE keterangan <> 'Kosong';

-- 3. Lebih besar dari (>)
SELECT * FROM kamar WHERE kapasitas > 2;

-- 4. Lebih kecil dari (<)
SELECT * FROM kamar WHERE kapasitas < 5;

-- 5. Antara dua nilai (BETWEEN)
SELECT * FROM pemesanan_kamar WHERE tanggal_masuk BETWEEN '2024-05-01' AND '2024-08-25';


