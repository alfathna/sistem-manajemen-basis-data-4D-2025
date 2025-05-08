
-- =============================================
-- Soal 1: 
-- =============================================
USE perpustakaan_digital;

-- Untuk SEMINGGU
DELIMITER //

CREATE PROCEDURE GetTransaksiSeminggu()
BEGIN
    SELECT * FROM peminjaman
    WHERE tanggal_pinjam >= CURDATE() - INTERVAL 7 DAY;
END //

DELIMITER ;

-- Untuk 1 BULAN
DELIMITER //

CREATE PROCEDURE GetTransaksi1Bulan()
BEGIN
    SELECT * FROM peminjaman
    WHERE tanggal_pinjam >= CURDATE() - INTERVAL 1 MONTH;
END //

DELIMITER ;

-- Untuk 3 BULAN
DELIMITER //

CREATE PROCEDURE GetTransaksi3Bulan()
BEGIN
    SELECT * FROM peminjaman
    WHERE tanggal_pinjam >= CURDATE() - INTERVAL 3 MONTH;
END //

DELIMITER ;

-- Pemanggilan
CALL GetTransaksi1Bulan();
CALL GetTransaksi3Bulan();
CALL GetTransaksiSeminggu();


-- =============================================
-- Soal 2: 
-- =============================================

-- untuk hapus
DELIMITER //

CREATE PROCEDURE HapusTransaksiLamaValid()
BEGIN
    DELETE FROM peminjaman
    WHERE tanggal_pinjam < CURDATE() - INTERVAL 1 YEAR
    AND (STATUS = 'dikembalikan' OR STATUS = 'selesai');
END //

DELIMITER ;


-- untuk melihat tabel peminjaman
SELECT * FROM peminjaman;
-- ini untuk hapus
CALL HapusTransaksiLamaValid();


-- =============================================
-- Soal 3: 
-- =============================================

DELIMITER //

CREATE PROCEDURE UpdateStatusTransaksi()
BEGIN
    UPDATE peminjaman
    SET STATUS = 'dikembalikan'
    WHERE STATUS = 'belum dikembalikan'
    LIMIT 7;
END //

DELIMITER ;

-- Menambahkan 7 transaksi dengan status 'belum dikembalikan'
INSERT INTO peminjaman (id_buku, id_anggota, tanggal_pinjam, tanggal_jatuh_tempo, STATUS)
VALUES 
(1, 1, CURDATE() - INTERVAL 10 DAY, CURDATE(), 'belum dikembalikan'),
(2, 2, CURDATE() - INTERVAL 9 DAY, CURDATE(), 'belum dikembalikan'),
(3, 3, CURDATE() - INTERVAL 8 DAY, CURDATE(), 'belum dikembalikan'),
(4, 4, CURDATE() - INTERVAL 7 DAY, CURDATE(), 'belum dikembalikan'),
(5, 5, CURDATE() - INTERVAL 6 DAY, CURDATE(), 'belum dikembalikan'),
(6, 6, CURDATE() - INTERVAL 5 DAY, CURDATE(), 'belum dikembalikan'),
(7, 7, CURDATE() - INTERVAL 4 DAY, CURDATE(), 'belum dikembalikan');

-- ini  untuk menghapus
DELETE FROM peminjaman WHERE STATUS = 'dikembalikan'
ORDER BY tanggal_pinjam DESC LIMIT 7;

-- Contoh pemanggilan:
CALL UpdateStatusTransaksi();

-- untuk melihat tabel peminjaman
SELECT * FROM peminjaman;

-- =============================================
-- Soal 4: 
-- =============================================

-- edit
DELIMITER //

CREATE PROCEDURE EditUserTanpaTransaksi(
    IN p_id_anggota INT,
    IN p_nama_baru VARCHAR(100)
)
BEGIN
    UPDATE anggota
    SET nama_anggota = p_nama_baru
    WHERE id_anggota = p_id_anggota
      AND id_anggota NOT IN (
          SELECT DISTINCT id_anggota FROM peminjaman
      );
END //

DELIMITER ;

-- hapus
DELIMITER //

CREATE PROCEDURE HapusUserTanpaTransaksi(
    IN p_id_anggota INT
)
BEGIN
    DECLARE ROW_COUNT INT;

    -- Hapus hanya jika anggota TIDAK ada di tabel peminjaman
    DELETE FROM anggota
    WHERE id_anggota = p_id_anggota
      AND id_anggota NOT IN (
          SELECT DISTINCT id_anggota FROM peminjaman
      );

    -- Cek apakah ada baris yang dihapus
    SET ROW_COUNT = ROW_COUNT();

    -- Tentukan pesan berdasarkan hasil
    IF ROW_COUNT > 0 THEN
        SET @pesan = CONCAT('Anggota dengan ID ', p_id_anggota, ' berhasil dihapus.');
    ELSE
        SET @pesan = CONCAT('Gagal menghapus: anggota dengan ID ', p_id_anggota, ' sudah memiliki transaksi atau tidak ditemukan.');
    END IF;
END //

DELIMITER ;
USE perpustakaan_digital;
CALL HapusUserTanpaTransaksi(9);

-- Pemanggilan:
SET @pesan = '';
CALL EditUserTanpaTransaksi(8, 'Fatah'); -- user yang tidak berhasil di edit
CALL EditUserTanpaTransaksi(9, 'Gema'); -- user yang berhasil di edit
SELECT @pesan; 
SELECT * FROM anggota WHERE id_anggota = 8; -- untuk cek apakah data berhasil di hapus apa belum
SELECT * FROM anggota WHERE id_anggota = 9; -- untuk cek apakah data berhasil di hapus apa belum
SELECT * FROM anggota; -- cek tabel
-- untuk menambah lagi data yang sudah di hapus
INSERT INTO anggota (id_anggota, nama_anggota, alamat, no_hp, tanggal_daftar, keterangan) VALUES 
(9, 'Gema', 'Bangkalan', 083463652989, "2022-03-26", "Anggota aktif");


-- =============================================
-- Soal 5: 
-- =============================================


DELIMITER //

CREATE PROCEDURE UpdateStatusByTransaksi()
BEGIN
    DECLARE id_terbanyak INT DEFAULT NULL;
    DECLARE id_tersedikit INT DEFAULT NULL;
    DECLARE id_sedang INT DEFAULT NULL;
    DECLARE jumlah_anggota INT DEFAULT 0;

    -- Buat tabel sementara jumlah transaksi per anggota dalam 1 bulan terakhir
    CREATE TEMPORARY TABLE temp_transaksi AS
    SELECT id_anggota, COUNT(*) AS total
    FROM peminjaman
    WHERE tanggal_pinjam >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    GROUP BY id_anggota;

    -- Hitung jumlah anggota yang melakukan transaksi
    SELECT COUNT(*) INTO jumlah_anggota FROM temp_transaksi;

    -- Ambil id dengan transaksi paling banyak
    IF jumlah_anggota >= 1 THEN
        SELECT id_anggota INTO id_terbanyak
        FROM temp_transaksi
        ORDER BY total DESC
        LIMIT 1;
    END IF;

    -- Ambil id dengan transaksi paling sedikit
    IF jumlah_anggota >= 1 THEN
        SELECT id_anggota INTO id_tersedikit
        FROM temp_transaksi
        ORDER BY total ASC
        LIMIT 1;
    END IF;

    -- Ambil id dengan jumlah sedang (hanya jika ada minimal 3 data)
    IF jumlah_anggota >= 3 THEN
        SELECT id_anggota INTO id_sedang
        FROM temp_transaksi
        ORDER BY total DESC
        LIMIT 1 OFFSET 1;
    END IF;

    -- Update status berdasarkan kriteria (cek NULL dulu agar tidak error)
    IF id_terbanyak IS NOT NULL THEN
        UPDATE peminjaman SET STATUS = 'aktif' WHERE id_anggota = id_terbanyak;
    END IF;

    IF id_tersedikit IS NOT NULL THEN
        UPDATE peminjaman SET STATUS = 'non-aktif' WHERE id_anggota = id_tersedikit;
    END IF;

    IF id_sedang IS NOT NULL THEN
        UPDATE peminjaman SET STATUS = 'pasif' WHERE id_anggota = id_sedang;
    END IF;

    -- Hapus tabel sementara
    DROP TEMPORARY TABLE temp_transaksi;
END //

DELIMITER ;

-- Pemanggilan:
CALL UpdateStatusByTransaksi();


-- =============================================
-- Soal 6: 
-- =============================================


DELIMITER //

CREATE PROCEDURE HitungTransaksiBerhasil()
BEGIN
    DECLARE tanggal_mulai DATE;
    DECLARE tanggal_akhir DATE;
    DECLARE jumlah INT DEFAULT 0;
    DECLARE transaksi_harian INT;

    SET tanggal_mulai = DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
    SET tanggal_akhir = CURDATE();

    WHILE tanggal_mulai <= tanggal_akhir DO
        -- Hitung transaksi berhasil di setiap hari dalam periode sebulan
        SELECT COUNT(*) INTO transaksi_harian
        FROM peminjaman
        WHERE STATUS = 'berhasil' AND DATE(tanggal_pinjam) = tanggal_mulai;

        -- Tambahkan ke total
        SET jumlah = jumlah + transaksi_harian;

        -- Tambahkan satu hari
        SET tanggal_mulai = DATE_ADD(tanggal_mulai, INTERVAL 1 DAY);
    END WHILE;

    -- Tampilkan hasil
    SELECT jumlah AS total_transaksi_berhasil_bulan_terakhir;
END //

DELIMITER ;

-- Pemanggilan
CALL HitungTransaksiBerhasil();

-- =============================================
-- SELESAI TERIMA KASIH
-- =============================================
