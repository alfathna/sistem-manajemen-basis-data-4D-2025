USE modul2;

-- soal1
DELIMITER //
CREATE PROCEDURE GetUMKM_1BulanTerakhir()
BEGIN
  SELECT * FROM umkm
  WHERE tanggal_registrasi >= CURDATE() - INTERVAL 1 MONTH;
END //
DELIMITER ;
CALL GetUMKM_1BulanTerakhir;

SELECT * FROM transaksi;

-- soal2
DELIMITER //
CREATE PROCEDURE HapusTransaksiLebihDari1Tahun()
BEGIN
    DELETE FROM transaksi
    WHERE tanggal_transaksi <= CURDATE() - INTERVAL 1 YEAR
    AND status_transaksi IN ('lunas', 'dikembalikan');
    
    SELECT ROW_COUNT() AS jumlah_transaksi_yang_dihapus;
END //
DELIMITER ;
CALL HapusTransaksiLebihDari1Tahun();
SELECT * FROM transaksi;


SELECT * FROM USER;
-- soal3
DELIMITER //
CREATE PROCEDURE UpdateStatusTransaksi()
BEGIN
    UPDATE transaksi
    SET status_transaksi = 'sukses'
    WHERE status_transaksi = 'tidak sukses'
    ORDER BY tanggal_transaksi ASC
    LIMIT 7;

    SELECT ROW_COUNT() AS jumlah_transaksi_diubah;
END //
DELIMITER ;
CALL UpdateStatusTransaksi();
SELECT * FROM transaksi;

-- soal4
DELIMITER //
CREATE PROCEDURE EditUser(
    IN p_id_user INT,
    IN p_nama_baru VARCHAR(100),
    IN p_email_baru VARCHAR(100)
)
BEGIN
    UPDATE `user`
    SET nama = p_nama_baru, email = p_email_baru
    WHERE id_user = p_id_user
      AND NOT EXISTS (
          SELECT 1 FROM transaksi WHERE transaksi.id_user = `user`.id_user
      );

    SELECT ROW_COUNT() AS hasil_edit; -- 1 jika berhasil, 0 jika gagal (karena ada transaksi)
END //
DELIMITER ;

DELETE FROM USER WHERE id_user = 8;
CALL EditUser(11, 'Nama', 'baru@example.com');
SELECT * FROM USER;

-- soal5
DELIMITER //
CREATE PROCEDURE UpdateTransaksiStatus()
BEGIN
    DECLARE id_terkecil INT;
    DECLARE id_terbesar INT;
    DECLARE id_sedang INT;
    DECLARE total INT;
    DECLARE offset_sedang INT;

    SELECT COUNT(*) INTO total
    FROM transaksi
    WHERE tanggal_transaksi >= CURDATE() - INTERVAL 1 MONTH;

    SET offset_sedang = FLOOR(total / 2);

    IF total >= 3 THEN

        SELECT id_transaksi INTO id_terkecil
        FROM transaksi
        WHERE tanggal_transaksi >= CURDATE() - INTERVAL 1 MONTH
        ORDER BY jumlah_transaksi ASC
        LIMIT 1;

        SELECT id_transaksi INTO id_terbesar
        FROM transaksi
        WHERE tanggal_transaksi >= CURDATE() - INTERVAL 1 MONTH
        ORDER BY jumlah_transaksi DESC
        LIMIT 1;

        SELECT id_transaksi INTO id_sedang
        FROM (
            SELECT id_transaksi
            FROM transaksi
            WHERE tanggal_transaksi >= CURDATE() - INTERVAL 1 MONTH
            ORDER BY jumlah_transaksi ASC
            LIMIT 1 OFFSET offset_sedang
        ) AS tengah;

        UPDATE transaksi SET status_transaksi = 'non-aktif' WHERE id_transaksi = id_terkecil;
        UPDATE transaksi SET status_transaksi = 'aktif' WHERE id_transaksi = id_terbesar;
        UPDATE transaksi SET status_transaksi = 'pasif' WHERE id_transaksi = id_sedang;
    END IF;

    SELECT * FROM transaksi WHERE tanggal_transaksi >= CURDATE() - INTERVAL 1 MONTH;
END //
DELIMITER ;

CALL UpdateTransaksiStatus();

DROP PROCEDURE hitung_transaksi_berhasil_bulanan;

-- soal6
DELIMITER //
CREATE PROCEDURE hitung_transaksi_berhasil_bulanan()
BEGIN
    DECLARE jumlah INT DEFAULT 0;
    DECLARE total INT DEFAULT 0;

    CREATE TEMPORARY TABLE IF NOT EXISTS temp_pemesanan AS
    SELECT id_transaksi
    FROM transaksi
    WHERE status_transaksi = 'lunas'
      AND tanggal_transaksi >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

    SELECT COUNT(*) INTO total FROM temp_pemesanan;

    WHILE jumlah < total DO
        SET jumlah = jumlah + 1;
    END WHILE;

    SELECT jumlah AS jumlah_transaksi_berhasil_bulan_terakhir;

    DROP TEMPORARY TABLE IF EXISTS temp_pemesanan;
END //
DELIMITER ;


CALL hitung_transaksi_berhasil_bulanan();
SELECT * FROM transaksi;



DROP TABLE IF EXISTS transaksi;
DROP TABLE IF EXISTS USER;

CREATE TABLE USER (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE transaksi (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    tanggal_transaksi DATE NOT NULL,
    status_transaksi ENUM('lunas', 'tidak sukses', 'non-aktif', 'pasif', 'aktif', 'pending', 'sukses') NOT NULL DEFAULT 'pending',
    jumlah_transaksi INT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES USER(id_user)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


INSERT INTO USER (nama, email) VALUES
('Dina Anggraini', 'dina@example.com'),
('Rizky Maulana', 'rizky@example.com'),
('Siti Rahmawati', 'siti@example.com'),
('Bayu Setiawan', 'bayu@example.com'),
('Ayu Lestari', 'ayu@example.com');

INSERT INTO transaksi (id_user, tanggal_transaksi, status_transaksi, jumlah_transaksi) VALUES
(1, CURDATE() - INTERVAL 5 DAY, 'lunas', 5000),
(2, CURDATE() - INTERVAL 10 DAY, 'lunas', 7000),
(3, CURDATE() - INTERVAL 15 DAY, 'tidak sukses', 2000),
(4, CURDATE() - INTERVAL 20 DAY, 'pending', 3000),
(5, CURDATE() - INTERVAL 25 DAY, 'tidak sukses', 1500),
(1, CURDATE() - INTERVAL 30 DAY, 'lunas', 10000),
(2, CURDATE() - INTERVAL 40 DAY, 'lunas', 12000),
(3, CURDATE() - INTERVAL 370 DAY, 'lunas', 2500), -- lebih dari 1 tahun
(4, CURDATE() - INTERVAL 400 DAY, 'tidak sukses', 2700), -- lebih dari 1 tahun
(5, CURDATE() - INTERVAL 3 DAY, 'lunas', 9000);

INSERT INTO USER (nama, email) VALUES
('ifal', 'ifal@gmail.com');

SELECT * FROM transaksi;
SELECT * FROM USER;
SELECT * FROM umkm;


INSERT INTO umkm (
  nama_usaha, id_pemilik, id_kategori, id_skala, id_kabupaten_kota,
  alamat_usaha, nib, npwp, tahun_berdiri, jumlah_karyawan,
  total_aset, omzet_per_tahun, deskripsi_usaha, tanggal_registrasi
) VALUES
('Kopi Mantap', 1, 1, 1, 1,
 'Jl. Merdeka No. 10', '1234567890', '9876543210', 2020, 5,
 10000000.00, 50000000.00, 'Usaha kopi kekinian.', CURDATE() - INTERVAL 5 DAY),

('Kerajinan Kayu Jati', 2, 2, 2, 2,
 'Jl. Kayu No. 45', '1122334455', '5544332211', 2018, 10,
 30000000.00, 100000000.00, 'Produksi furniture dari kayu jati.', CURDATE() - INTERVAL 10 DAY),

('Snack Ringan Mama', 3, 1, 1, 1,
 'Perumahan Griya No. 8', '6677889900', '9988776655', 2021, 3,
 5000000.00, 20000000.00, 'Produksi makanan ringan rumahan.', CURDATE() - INTERVAL 20 DAY);

SELECT * FROM umkm;













