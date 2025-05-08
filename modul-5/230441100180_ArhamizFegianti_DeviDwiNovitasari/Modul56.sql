USE db_fastfood;

DELIMITER //
CREATE PROCEDURE getTransaksiSatuBulan()
BEGIN
SELECT t.id_transaksi, c.nama_customer,
p.nama_produk, t.total,
t.tanggal, k.nama_pegawai
FROM transaksi t
JOIN customer c ON t.id_customer = c.id_customer
JOIN produk p ON t.id_produk = p.id_produk
JOIN kasir k ON t.id_pegawai = k.id_pegawai
WHERE t.tanggal >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
ORDER BY t.tanggal DESC;
END //
DELIMITER ;
CALL getTransaksiSatuBulan();
SELECT * FROM transaksi;


ALTER TABLE transaksi ADD STATUS ENUM('lunas', 'belum_lunas') DEFAULT 'belum_lunas';
UPDATE transaksi SET STATUS = 'lunas' WHERE id_transaksi = 5;
DELIMITER //
CREATE PROCEDURE hapusTransaksiLama()
BEGIN
DELETE FROM transaksi
WHERE tanggal < DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
AND STATUS = 'lunas';
END //
DELIMITER ;
CALL hapusTransaksiLama();
UPDATE transaksi SET tanggal = '2023-03-14 20:53:56' WHERE id_transaksi = 6;
SELECT * FROM transaksi WHERE id_transaksi = 6;
SELECT * FROM transaksi;


DELIMITER //
CREATE PROCEDURE ubahStatusTransaksi()
BEGIN
UPDATE transaksi
SET STATUS = 'lunas'
WHERE STATUS = 'belum_lunas'
ORDER BY id_transaksi ASC
LIMIT 7;
END //
DELIMITER ;
CALL ubahStatusTransaksi();
SELECT * FROM transaksi WHERE STATUS = 'lunas';


DELIMITER //
CREATE PROCEDURE editCustomer (
IN p_id_customer INT,
IN p_nama_customer VARCHAR(100),
IN p_no_hp VARCHAR(20)
)
BEGIN
UPDATE customer
SET nama_customer = p_nama_customer,
no_hp = p_no_hp
WHERE id_customer = p_id_customer
AND NOT EXISTS (
  SELECT 1 FROM transaksi WHERE id_customer = p_id_customer
      );
END //
DELIMITER ;
CALL editCustomer(3, 'Nadia Putri', '08123456789');
SELECT nama_customer FROM customer;

DELIMITER //
CREATE PROCEDURE deleteCustomer (
IN p_id_customer INT
)
BEGIN
DELETE FROM customer
WHERE id_customer = p_id_customer
AND NOT EXISTS (
SELECT 1 FROM transaksi WHERE id_customer = p_id_customer
);
END //
DELIMITER ;
CALL deleteCustomer(2);
SELECT id_customer, nama_customer FROM customer;



ALTER TABLE customer ADD COLUMN STATUS VARCHAR(20);
DELIMITER //
CREATE PROCEDURE StatusTransaksi()
BEGIN
CREATE TEMPORARY TABLE tmp_transaksi_bulanan AS
SELECT c.id_customer, c.nama_customer,
COUNT(t.id_transaksi) AS jumlah_transaksi
FROM customer c
JOIN transaksi t ON c.id_customer = t.id_customer
WHERE t.tanggal >= CURDATE() - INTERVAL 1 MONTH
GROUP BY c.id_customer, c.nama_customer;

SET @min_trans := (SELECT MIN(jumlah_transaksi) FROM tmp_transaksi_bulanan);
SET @max_trans := (SELECT MAX(jumlah_transaksi) FROM tmp_transaksi_bulanan);

SELECT id_customer, nama_customer, jumlah_transaksi,
   IF(jumlah_transaksi = @max_trans, 'aktif',
      IF(jumlah_transaksi = @min_trans, 'non-aktif', 'pasif')) AS STATUS
FROM tmp_transaksi_bulanan
ORDER BY jumlah_transaksi DESC;

DROP TEMPORARY TABLE tmp_transaksi_bulanan;
END //
DELIMITER ;
CALL StatusTransaksi();


DELIMITER //
CREATE PROCEDURE loopingTransaksi()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE total_count INT DEFAULT 0;

    SELECT COUNT(*) INTO total_count 
    FROM transaksi 
    WHERE STATUS = 'lunas' 
      AND tanggal >= NOW() - INTERVAL 1 MONTH;

    #looping sebanyak total_count
    WHILE i < total_count DO
        SET i = i + 1;
    END WHILE;

    SELECT total_count AS Total_Transaksi_Lunas_Satu_Bulan_Terakhir;
END //
DELIMITER ;
CALL loopingTransaksi();
