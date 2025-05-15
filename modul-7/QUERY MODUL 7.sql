-- Modul 7 --

-- Soal 1 Cegah judul buku kosong

DELIMITER //

CREATE TRIGGER before_insert_buku
BEFORE INSERT ON buku
FOR EACH ROW
BEGIN
    IF NEW.judul_buku IS NULL OR TRIM(NEW.judul_buku) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Judul buku tidak boleh kosong!';
    END IF;
END //

DELIMITER ;

-- pengujian

INSERT INTO buku (judul_buku, penulis, penerbit, tahun_terbit, id_kategori)
VALUES ('', 'Penulis', 'Penerbit', 2022, 1); -- contoh error

INSERT INTO buku (judul_buku, penulis, penerbit, tahun_terbit, id_kategori)
VALUES ('Judul Valid', 'Penulis', 'Penerbit', 2022, 1); -- contoh berhasil

-- soal 2 Cegah update status jadi kosong/null

DELIMITER //

CREATE TRIGGER before_update_status_peminjaman
BEFORE UPDATE ON peminjaman
FOR EACH ROW
BEGIN
    IF NEW.status IS NULL OR CHAR_LENGTH(TRIM(NEW.status)) = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Status peminjaman tidak boleh kosong!';
    END IF;
END //

DELIMITER ;

-- pengujian
UPDATE peminjaman SET STATUS = '' WHERE id_peminjaman = 304;

SELECT * FROM peminjaman;

-- Soal 1 Cegah hapus kategori yang masih dipakai di buku

DELIMITER //

CREATE TRIGGER before_delete_kategori
BEFORE DELETE ON kategori
FOR EACH ROW
BEGIN
    DECLARE jumlah INT;
    SELECT COUNT(*) INTO jumlah FROM buku WHERE id_kategori = OLD.id_kategori;
    IF jumlah > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tidak bisa hapus kategori karena masih digunakan di buku.';
    END IF;
END //

DELIMITER ;

-- pengujian
SELECT * FROM buku WHERE id_kategori = 1;
DELETE FROM kategori WHERE id_kategori = 1;

-- Soal 2 Catat log setelah peminjaman ditambahkan

-- buat tabel log_peminjaman terlebih dahulu
CREATE TABLE log_peminjaman (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_peminjaman INT,
    aksi VARCHAR(20),
    waktu TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Triggernya
DELIMITER //

CREATE TRIGGER after_insert_peminjaman
AFTER INSERT ON peminjaman
FOR EACH ROW
BEGIN
    INSERT INTO log_peminjaman (id_peminjaman, aksi)
    VALUES (NEW.id_peminjaman, 'INSERT');
END //

DELIMITER ;

-- pengujian
INSERT INTO peminjaman (id_buku, id_anggota, tanggal_pinjam, tanggal_jatuh_tempo, STATUS)
VALUES (1, 1, CURDATE(), CURDATE() + INTERVAL 7 DAY, 'dipinjam');

SELECT * FROM log_peminjaman ORDER BY waktu DESC;

-- Soal 2 Catat log perubahan status peminjaman
DELIMITER //

CREATE TRIGGER after_update_peminjaman
AFTER UPDATE ON peminjaman
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO log_peminjaman (id_peminjaman, aksi)
        VALUES (NEW.id_peminjaman, 'UPDATE STATUS');
    END IF;
END //

DELIMITER ;

-- pengujian
UPDATE peminjaman SET STATUS = 'dikembalikan' WHERE id_peminjaman = 304;

SELECT * FROM log_peminjaman WHERE aksi = 'UPDATE STATUS' ORDER BY waktu DESC;

-- Soal 2 Catat log ketika peminjaman dihapus

DELIMITER //

CREATE TRIGGER after_delete_peminjaman
AFTER DELETE ON peminjaman
FOR EACH ROW
BEGIN
    INSERT INTO log_peminjaman (id_peminjaman, aksi)
    VALUES (OLD.id_peminjaman, 'DELETE');
END //

DELIMITER ;

DELETE FROM peminjaman WHERE id_peminjaman = 402;

SELECT * FROM log_peminjaman WHERE aksi = 'DELETE' ORDER BY waktu DESC;

INSERT INTO peminjaman (id_buku, id_anggota, tanggal_pinjam, tanggal_jatuh_tempo, STATUS)
VALUES (1, 1, CURDATE(), CURDATE() + INTERVAL 7 DAY, 'dipinjam'); -- untuh menambah data yang sudah di hapus

-- END --