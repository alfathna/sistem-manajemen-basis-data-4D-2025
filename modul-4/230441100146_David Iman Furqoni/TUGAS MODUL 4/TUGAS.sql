USE SistemManajemenKaryawan;
SHOW TABLES;
-- ================================

-- =================================================== no 1
-- DROP PROCEDURE IF EXISTS TambahKolomKeterangan;

DELIMITER //
CREATE PROCEDURE TambahKolomJikaBelumAda(
    IN nama_kolom VARCHAR(64),
    IN tipe_data VARCHAR(64)
)
BEGIN
    DECLARE query_sql TEXT;
    IF NOT EXISTS (
        SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
        WHERE table_schema = 'SistemManajemenKaryawan' 
        AND TABLE_NAME = 'Karyawan' 
        AND COLUMN_NAME = nama_kolom
    ) THEN
        SET @query_sql = CONCAT('ALTER TABLE Karyawan ADD COLUMN ', nama_kolom, ' ', tipe_data);
        PREPARE stmt FROM @query_sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;

    SELECT * FROM Karyawan;
END //
DELIMITER ;

CALL TambahKolomJikaBelumAda('keterangan', 'VARCHAR(255)');

-- =================================================== no 2
DELIMITER //
CREATE PROCEDURE GabungKaryawanGaji()
BEGIN
    SELECT 
        K.nama_karyawan,
        K.jenis_kelamin,
        G.bulan_gaji,
        G.gaji_pokok,
        G.tunjangan,
        G.potongan
    FROM 
        Karyawan K
    JOIN 
        Gaji G ON K.id_karyawan = G.id_karyawan;
END //
DELIMITER ;

CALL GabungKaryawanGaji();

-- =================================================== no 3
DELIMITER //
CREATE PROCEDURE UrutanData()
BEGIN
    SELECT * FROM Karyawan ORDER BY nama_karyawan ASC;
    SELECT * FROM Gaji ORDER BY gaji_pokok DESC;
    SELECT * FROM Absensi ORDER BY tanggal;
END //
DELIMITER ;

CALL UrutanData();

-- =================================================== no 4
DELIMITER //
CREATE PROCEDURE UbahTipeData()
BEGIN
    ALTER TABLE Gaji MODIFY gaji_pokok DECIMAL(15,2);
    SELECT * FROM Gaji;
END //
DELIMITER ;

CALL UbahTipeData();

-- =================================================== no 5
DELIMITER //
CREATE PROCEDURE JoinData()
BEGIN
    -- LEFT JOIN
    SELECT 
        K.nama_karyawan,
        G.bulan_gaji,
        G.gaji_pokok
    FROM 
        Karyawan K
    LEFT JOIN 
        Gaji G ON K.id_karyawan = G.id_karyawan;

    -- RIGHT JOIN
    SELECT 
        G.bulan_gaji,
        G.gaji_pokok,
        K.nama_karyawan
    FROM 
        Gaji G
    RIGHT JOIN 
        Karyawan K ON G.id_karyawan = K.id_karyawan;

    -- SELF JOIN
    SELECT 
        A.nama_karyawan AS Karyawan1,
        B.nama_karyawan AS Karyawan2,
        A.id_departemen
    FROM 
        Karyawan A
    JOIN 
        Karyawan B ON A.id_departemen = B.id_departemen
    WHERE 
        A.id_karyawan < B.id_karyawan;
END //
DELIMITER ;

CALL JoinData();

-- =================================================== no 6
DELIMITER //
CREATE PROCEDURE FilterData()
BEGIN
    -- 1
    SELECT * FROM Gaji WHERE gaji_pokok > 7000000;
    -- 2
    SELECT * FROM Gaji WHERE tunjangan < 2000000;
    -- 3
    SELECT * FROM Karyawan WHERE tanggal_lahir < '1990-01-01';
    -- 4
    SELECT * FROM Jabatan WHERE level_jabatan > 1;
    -- 5
    SELECT * FROM Gaji WHERE gaji_pokok = 3000000;
END //
DELIMITER ;

CALL FilterData();
