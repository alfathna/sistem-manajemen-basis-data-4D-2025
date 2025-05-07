-- Gunakan database TokoSepatu
USE TokoSepatu;

-- Ganti delimiter
DELIMITER //
CREATE OR REPLACE PROCEDURE UpdateDataMaster(
    IN id INT,
    IN nilai_baru VARCHAR(50),
    OUT STATUS VARCHAR(100)
)
BEGIN
    DECLARE ROW_COUNT INT;

    UPDATE Kategori
    SET NamaKategori = nilai_baru
    WHERE ID_Kategori = id;

    SET ROW_COUNT = ROW_COUNT();

    IF ROW_COUNT > 0 THEN
        SET STATUS = 'Update berhasil';
    ELSE
        SET STATUS = 'ID tidak ditemukan atau tidak ada perubahan';
    END IF;
END //

-- Panggil procedure untuk update kategori dengan ID 1 menjadi 'Sport'
CALL UpdateDataMaster(1, 'Sport', @status);
-- Tampilkan hasil status
SELECT @status;


-- 2. Stored Procedure: CountTransaksi
DELIMITER //

CREATE PROCEDURE CountTransaksi(
    OUT total INT
)
BEGIN
    SELECT COUNT(*) INTO total FROM Transaksi;
END //
DELIMITER ;

CALL CountTransaksi(@total);
SELECT @total;



-- 3. Stored Procedure: GetDataMasterByID
DELIMITER //

CREATE PROCEDURE GetDataMasterByID(
    IN id INT,
    OUT nama_kategori VARCHAR(50)
)
BEGIN
    SELECT NamaKategori INTO nama_kategori
    FROM Kategori
    WHERE ID_Kategori = id;
END //

DELIMITER ;

-- 1. Buat variabel untuk output
SET @nama := '';

-- 2. Panggil prosedur
CALL GetDataMasterByID(1, @nama);

-- 3. Tampilkan hasil OUT
SELECT @nama;



-- 4. Stored Procedure: UpdateFieldTransaksi
DELIMITER //

CREATE PROCEDURE UpdateFieldTransaksi (
    IN id INT,
    INOUT field1 INT,
    INOUT field2 DECIMAL(10,2)
)
BEGIN
    DECLARE currentJumlah INT;
    DECLARE currentTotal DECIMAL(10,2);

    SELECT Jumlah, Total
    INTO currentJumlah, currentTotal
    FROM Transaksi
    WHERE ID_Transaksi = id;

    IF field1 IS NULL THEN
        SET field1 = currentJumlah;
    END IF;

    IF field2 IS NULL THEN
        SET field2 = currentTotal;
    END IF;

    UPDATE Transaksi
    SET Jumlah = field1, Total = field2
    WHERE ID_Transaksi = id;
END //

DELIMITER ;

-- Persiapkan variabel input/output
SET @id := 1;          -- Ganti sesuai ID_Transaksi yang ada di tabel
SET @field1 := NULL;   -- NULL agar bisa diisi dari prosedur
SET @field2 := NULL;

-- Panggil prosedur
CALL UpdateFieldTransaksi(@id, @field1, @field2);

-- Tampilkan hasil output
SELECT @field1 AS Jumlah, @field2 AS Total;


-- 5. Stored Procedure: DeleteEntriesByIDMaster
CREATE PROCEDURE DeleteEntriesByIDMaster(
    IN id INT
)
BEGIN
    DELETE FROM Kategori WHERE ID_Kategori = id;
END //

-- Kembalikan delimiter ke default
DELIMITER ;
