-- Soal 1
USE perpustakaan_digital;
DELIMITER //

CREATE PROCEDURE UpdateDataMaster(
    IN id INT,
    IN nilai_baru VARCHAR(100),
    OUT status_msg VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        SET status_msg = 'Gagal memperbarui data';
    END;

    UPDATE anggota
    SET nama_anggota = nilai_baru
    WHERE id_anggota = id;

    SET status_msg = 'Berhasil memperbarui data';
END //

DELIMITER ;

CALL UpdateDataMaster(1, @status);
SELECT @status;


-- Soal 2
DELIMITER //

CREATE PROCEDURE CountTransaksi(OUT total_transaksi INT)
BEGIN
    SELECT COUNT(*) INTO total_transaksi FROM peminjaman;
END //

DELIMITER ;

CALL CountTransaksi(@total);
SELECT @total;

-- Soal 3
DELIMITER //

CREATE PROCEDURE GetDataMasterByID(
    IN id INT,
    OUT judul VARCHAR(100),
    OUT penulis VARCHAR(50)
)
BEGIN
    SELECT judul_buku, penulis
    INTO judul, penulis
    FROM buku
    WHERE id_buku = id;
END //

DELIMITER ;

CALL GetDataMasterByID(2, @judul, @penulis);
SELECT @judul, @penulis;

-- Soal 4
DELIMITER //

CREATE PROCEDURE UpdateFieldTransaksi(
    IN id INT,
    INOUT field1 DATE,
    INOUT field2 DATE
)
BEGIN
    DECLARE temp1 DATE;
    DECLARE temp2 DATE;

    SELECT tanggal_pinjam, tanggal_jatuh_tempo
    INTO temp1, temp2
    FROM peminjaman
    WHERE id_peminjaman = id;

    UPDATE peminjaman
    SET tanggal_pinjam = IFNULL(field1, temp1),
        tanggal_jatuh_tempo = IFNULL(field2, temp2)
    WHERE id_peminjaman = id;
END //

DELIMITER ;

SET @tgl_pinjam = '2024-04-01';
SET @tgl_jatuh = NULL;

CALL UpdateFieldTransaksi(1, @tgl_pinjam, @tgl_jatuh);

SELECT * FROM peminjaman WHERE id_peminjaman = 1;
SELECT * FROM peminjaman;


-- Soal 5
DELIMITER //

CREATE PROCEDURE DeleteEntriesByIDMaster(IN id INT)
BEGIN
    DELETE FROM kategori WHERE id_kategori = id;
END //

DELIMITER ;

CALL DeleteEntriesByIDMaster(5);

SELECT * FROM kategori WHERE id_kategori = 5;
SELECT * FROM kategori;