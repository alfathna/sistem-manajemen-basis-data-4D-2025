-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2025 at 12:29 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistem_manajemen_asrama`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CountTransaksi` (OUT `jumlah_pemesanan` INT, OUT `jumlah_keluhan` INT)  BEGIN
    -- Hitung jumlah pemesanan kamar
    SELECT COUNT(*) INTO jumlah_pemesanan
    FROM pemesanan_kamar;
    
    -- Hitung jumlah laporan keluhan
    SELECT COUNT(*) INTO jumlah_keluhan
    FROM laporan_keluhan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteEntriesByIDMaster` (IN `p_id_mahasiswa` INT)  BEGIN
    -- Hapus mahasiswa berdasarkan ID
    DELETE FROM mahasiswa
    WHERE id_mahasiswa = p_id_mahasiswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_atau_hapus_user_jika_transaksi_selesai` (IN `p_id_mahasiswa` INT, IN `p_nama_baru` VARCHAR(100), IN `p_kontak_baru` VARCHAR(20), IN `p_aksi` ENUM('edit','hapus'))  BEGIN
  -- Update jika aksi = 'edit' dan tidak ada transaksi aktif/pending
  UPDATE mahasiswa
  SET nama = p_nama_baru,
      kontak = p_kontak_baru
  WHERE p_aksi = 'edit'
    AND id_mahasiswa = p_id_mahasiswa
    AND NOT EXISTS (
      SELECT 1 FROM pemesanan_kamar
      WHERE id_mahasiswa = p_id_mahasiswa
        AND status IN ('Pending', 'Aktif')
    );

  -- Delete jika aksi = 'hapus' dan tidak ada transaksi aktif/pending
  DELETE FROM mahasiswa
  WHERE p_aksi = 'hapus'
    AND id_mahasiswa = p_id_mahasiswa
    AND NOT EXISTS (
      SELECT 1 FROM pemesanan_kamar
      WHERE id_mahasiswa = p_id_mahasiswa
        AND status IN ('Pending', 'Aktif')
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDataMasterByID` (IN `p_id_mahasiswa` INT, OUT `p_nama_mahasiswa` VARCHAR(100))  BEGIN
    SELECT nama INTO p_nama_mahasiswa
    FROM mahasiswa
    WHERE id_mahasiswa = p_id_mahasiswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `hapus_pemesanan_lama` ()  BEGIN
  DELETE FROM pemesanan_kamar
  WHERE status = 'Selesai'
    AND tanggal_masuk < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `hitung_transaksi_berhasil_bulanan` ()  BEGIN
    DECLARE jumlah INT DEFAULT 0;
    DECLARE total INT DEFAULT 0;
    DECLARE idx INT DEFAULT 0;

    -- Buat temporary table untuk menyimpan id yang akan dihitung
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_pemesanan AS
    SELECT id_pemesanan
    FROM pemesanan_kamar
    WHERE STATUS = 'selesai'
      AND tanggal_pembayaran >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

    -- Hitung total baris untuk batas loop
    SELECT COUNT(*) INTO total FROM temp_pemesanan;

    -- Loop dengan WHILE tanpa cursor
    WHILE idx < total DO
        -- Simulasikan pembacaan baris dengan LIMIT + OFFSET
        SET jumlah = jumlah + 1;
        SET idx = idx + 1;
    END WHILE;

    -- Tampilkan hasilnya
    SELECT jumlah AS jumlah_transaksi_berhasil_bulan_terakhir;

    -- Hapus temporary table agar bersih
    DROP TEMPORARY TABLE IF EXISTS temp_pemesanan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampil_transaksi_periode` (IN `periode_input` VARCHAR(20))  BEGIN
  SELECT pk.*, m.nama, k.nomor_kamar
  FROM pemesanan_kamar pk
  JOIN mahasiswa m ON pk.id_mahasiswa = m.id_mahasiswa
  JOIN kamar k ON pk.id_kamar = k.id_kamar
  WHERE periode_input = 'SEMINGGU'
    AND pk.tanggal_masuk >= CURDATE() - INTERVAL 7 DAY

  UNION ALL

  SELECT pk.*, m.nama, k.nomor_kamar
  FROM pemesanan_kamar pk
  JOIN mahasiswa m ON pk.id_mahasiswa = m.id_mahasiswa
  JOIN kamar k ON pk.id_kamar = k.id_kamar
  WHERE periode_input = '1 BULAN'
    AND pk.tanggal_masuk >= CURDATE() - INTERVAL 1 MONTH

  UNION ALL

  SELECT pk.*, m.nama, k.nomor_kamar
  FROM pemesanan_kamar pk
  JOIN mahasiswa m ON pk.id_mahasiswa = m.id_mahasiswa
  JOIN kamar k ON pk.id_kamar = k.id_kamar
  WHERE periode_input = '3 BULAN'
    AND pk.tanggal_masuk >= CURDATE() - INTERVAL 3 MONTH;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ubah_status_pemesanan` ()  BEGIN
  UPDATE pemesanan_kamar
  SET status = 'Selesai'
  WHERE status = 'Aktif'
  LIMIT 7;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDataMaster` (IN `p_id_mahasiswa` INT, IN `p_nama_baru` VARCHAR(100), OUT `p_status` VARCHAR(50))  BEGIN
    DECLARE v_cek INT;

    -- Cek apakah data mahasiswa ada
    SELECT COUNT(*) INTO v_cek
    FROM mahasiswa
    WHERE id_mahasiswa = p_id_mahasiswa;
    
    IF v_cek = 1 THEN
        -- Update nama
        UPDATE mahasiswa
        SET nama = p_nama_baru
        WHERE id_mahasiswa = p_id_mahasiswa;
        
        SET p_status = 'Update Berhasil';
    ELSE
        SET p_status = 'Data Tidak Ditemukan';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateFieldTransaksi` (IN `p_id_pemesanan` INT, INOUT `p_tanggal_masuk` DATE, INOUT `p_status` VARCHAR(50))  BEGIN
    DECLARE v_tanggal_masuk DATE;
    DECLARE v_status VARCHAR(50);

    -- Ambil data lama kalau field input NULL
    SELECT tanggal_masuk, status
    INTO v_tanggal_masuk, v_status
    FROM pemesanan_kamar
    WHERE id_pemesanan = p_id_pemesanan;

    -- Kalau input NULL, pakai data lama
    IF p_tanggal_masuk IS NULL THEN
        SET p_tanggal_masuk = v_tanggal_masuk;
    END IF;

    IF p_status IS NULL THEN
        SET p_status = v_status;
    END IF;

    -- Update field
    UPDATE pemesanan_kamar
    SET 
        tanggal_masuk = p_tanggal_masuk,
        status = p_status
    WHERE id_pemesanan = p_id_pemesanan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_status_transaksi_terakhir` ()  BEGIN
    DECLARE id_terkecil INT;
    DECLARE id_terbesar INT;
    DECLARE id_sedang INT;
    DECLARE offset_median INT;
    DECLARE total_transaksi INT;
    DECLARE done INT DEFAULT 0;
    DECLARE cur_id INT;

    -- Cursor untuk looping (opsional, untuk contoh looping)
    DECLARE cur CURSOR FOR 
        SELECT id_pemesanan FROM transaksi_bulan_terakhir;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Ambil transaksi 1 bulan terakhir berdasarkan tanggal_pembayaran
    CREATE TEMPORARY TABLE transaksi_bulan_terakhir AS
    SELECT id_pemesanan, iuran_oper
    FROM pemesanan_kamar
    WHERE tanggal_pembayaran >= CURDATE() - INTERVAL 1 MONTH;

    -- Hitung total transaksi
    SELECT COUNT(*) INTO total_transaksi FROM transaksi_bulan_terakhir;

    -- Branching: cek apakah transaksi minimal 3
    IF total_transaksi < 3 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Transaksi kurang dari 3, proses dibatalkan.';
    ELSE
        -- Hitung offset median
        SELECT FLOOR(total_transaksi / 2) INTO offset_median FROM DUAL;

        -- Ambil id transaksi dengan iuran_oper terkecil
        SELECT id_pemesanan INTO id_terkecil
        FROM transaksi_bulan_terakhir
        ORDER BY iuran_oper ASC LIMIT 1;

        -- Ambil id transaksi dengan iuran_oper terbesar
        SELECT id_pemesanan INTO id_terbesar
        FROM transaksi_bulan_terakhir
        ORDER BY iuran_oper DESC LIMIT 1;

        -- Ambil id transaksi dengan iuran_oper median
        SELECT id_pemesanan INTO id_sedang
        FROM transaksi_bulan_terakhir
        ORDER BY iuran_oper
        LIMIT 1 OFFSET offset_median;

        -- Update status
        UPDATE pemesanan_kamar SET STATUS = 'Pending' WHERE id_pemesanan = id_terkecil;
        UPDATE pemesanan_kamar SET STATUS = 'Aktif' WHERE id_pemesanan = id_sedang;
        UPDATE pemesanan_kamar SET STATUS = 'Selesai' WHERE id_pemesanan = id_terbesar;
    END IF;

    DROP TEMPORARY TABLE transaksi_bulan_terakhir;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `fasilitas`
--

CREATE TABLE `fasilitas` (
  `id_fasilitas` int(11) NOT NULL,
  `nama_fasilitas` varchar(100) NOT NULL,
  `deskripsi` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fasilitas`
--

INSERT INTO `fasilitas` (`id_fasilitas`, `nama_fasilitas`, `deskripsi`) VALUES
(1, 'WiFi', 'Akses internet 24 jam di seluruh area asrama'),
(2, 'AC', 'Pendingin ruangan di setiap kamar'),
(3, 'Laundry', 'Layanan cuci pakaian mingguan'),
(4, 'Dapur Umum', 'Tempat memasak bersama yang dilengkapi kompor dan peralatan'),
(5, 'Ruang Belajar', 'Ruang tenang untuk belajar dan diskusi kelompok');

--
-- Triggers `fasilitas`
--
DELIMITER $$
CREATE TRIGGER `after_delete_fasilitas` AFTER DELETE ON `fasilitas` FOR EACH ROW BEGIN
  INSERT INTO log_fasilitas (id_fasilitas, waktu_hapus)
  VALUES (OLD.id_fasilitas, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `id_kamar` int(11) NOT NULL,
  `status_kamar` enum('Single','Double','Triple','Family') DEFAULT NULL,
  `keterangan` text,
  `nomor_kamar` varchar(10) NOT NULL,
  `kapasitas` int(11) NOT NULL,
  `status_ketersediaan` enum('kosong','penuh') DEFAULT 'penuh'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`id_kamar`, `status_kamar`, `keterangan`, `nomor_kamar`, `kapasitas`, `status_ketersediaan`) VALUES
(1, 'Double', 'Tersedia', 'A101', 2, 'kosong'),
(2, 'Double', 'Tersedia', 'A102', 2, 'penuh'),
(3, 'Double', 'Tersedia', 'A103', 2, 'penuh'),
(4, 'Triple', 'Tersedia', 'B201', 3, 'penuh'),
(5, 'Triple', 'Tersedia', 'B202', 3, 'kosong'),
(6, 'Triple', 'Tersedia', 'B203', 3, 'kosong'),
(7, 'Single', 'Tersedia', 'C301', 1, 'penuh'),
(8, 'Single', 'Tersedia', 'C302', 1, 'penuh'),
(9, 'Family', 'Tersedia', 'D401', 4, 'penuh'),
(10, 'Family', 'Tersedia', 'D402', 4, 'penuh'),
(11, 'Double', 'Tersedia', 'A104', 2, 'penuh'),
(12, 'Double', 'Tersedia', 'B204', 2, 'penuh'),
(13, 'Single', 'Tersedia', 'C303', 1, 'kosong'),
(14, 'Double', 'Tersedia', 'C304', 2, 'penuh'),
(15, 'Single', 'Tersedia', 'D403', 1, 'penuh'),
(16, 'Double', 'Tersedia', 'D404', 2, 'penuh');

--
-- Triggers `kamar`
--
DELIMITER $$
CREATE TRIGGER `before_update_ketersediaan_kamar` BEFORE UPDATE ON `kamar` FOR EACH ROW BEGIN
  IF NEW.status_ketersediaan = 'kosong' AND EXISTS (
    SELECT 1 FROM pemesanan_kamar
    WHERE id_kamar = NEW.id_kamar AND status = 'aktif'
  ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Tidak bisa mengubah kamar menjadi kosong karena masih ada transaksi aktif';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `laporan_keluhan`
--

CREATE TABLE `laporan_keluhan` (
  `id_keluhan` int(11) NOT NULL,
  `id_mahasiswa` int(11) DEFAULT NULL,
  `id_kamar` int(11) DEFAULT NULL,
  `id_fasilitas` int(11) DEFAULT NULL,
  `deskripsi_keluhan` text NOT NULL,
  `tanggal_laporan` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Belum Ditangani','Sedang Diproses','Selesai') DEFAULT 'Belum Ditangani'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `laporan_keluhan`
--

INSERT INTO `laporan_keluhan` (`id_keluhan`, `id_mahasiswa`, `id_kamar`, `id_fasilitas`, `deskripsi_keluhan`, `tanggal_laporan`, `status`) VALUES
(1, 1, 1, 1, 'WiFi sering putus-putus sejak minggu lalu.', '2025-04-11 14:42:51', 'Belum Ditangani'),
(3, 5, 5, 5, 'Lampu kamar mati dan belum diganti.', '2025-04-11 14:42:51', 'Belum Ditangani'),
(4, 6, 6, 3, 'Layanan laundry tidak datang minggu ini.', '2025-04-11 14:42:51', 'Selesai'),
(5, 8, 8, 4, 'Dapur umum kotor dan tidak dibersihkan.', '2025-04-11 14:42:51', 'Sedang Diproses'),
(10, 1, 1, 1, 'AC kamar bocor dan meneteskan air', '2025-05-16 15:58:44', 'Belum Ditangani'),
(11, 1, 1, 1, 'AC kamar bocor', '2025-05-16 17:09:26', 'Belum Ditangani');

--
-- Triggers `laporan_keluhan`
--
DELIMITER $$
CREATE TRIGGER `after_insert_keluhan` AFTER INSERT ON `laporan_keluhan` FOR EACH ROW BEGIN
  INSERT INTO log_keluhan (id_laporan, waktu_log, aksi)
  VALUES (NEW.id_keluhan, NOW(), 'INSERT');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `log_fasilitas`
--

CREATE TABLE `log_fasilitas` (
  `id_log` int(11) NOT NULL,
  `id_fasilitas` int(11) DEFAULT NULL,
  `waktu_hapus` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `log_fasilitas`
--

INSERT INTO `log_fasilitas` (`id_log`, `id_fasilitas`, `waktu_hapus`) VALUES
(1, 6, '2025-05-12 14:02:29'),
(2, 7, '2025-05-12 14:02:29'),
(3, 8, '2025-05-12 14:02:29'),
(4, 6, '2025-05-16 17:10:10'),
(5, 7, '2025-05-16 17:10:10'),
(6, 8, '2025-05-16 17:10:10');

-- --------------------------------------------------------

--
-- Table structure for table `log_keluhan`
--

CREATE TABLE `log_keluhan` (
  `id_log` int(11) NOT NULL,
  `id_laporan` int(11) DEFAULT NULL,
  `waktu_log` datetime DEFAULT NULL,
  `aksi` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `log_keluhan`
--

INSERT INTO `log_keluhan` (`id_log`, `id_laporan`, `waktu_log`, `aksi`) VALUES
(1, 1, '2025-05-12 13:44:58', 'INSERT'),
(2, 3, '2025-05-12 13:44:58', 'INSERT'),
(3, 4, '2025-05-12 13:44:58', 'INSERT'),
(4, 5, '2025-05-12 13:44:58', 'INSERT'),
(5, 10, '2025-05-16 15:58:44', 'INSERT'),
(6, 11, '2025-05-16 17:09:26', 'INSERT');

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id_mahasiswa` int(11) NOT NULL,
  `nim` varchar(15) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `jurusan` varchar(50) DEFAULT NULL,
  `angkatan` year(4) DEFAULT NULL,
  `kontak` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`id_mahasiswa`, `nim`, `nama`, `jurusan`, `angkatan`, `kontak`) VALUES
(1, '20230001', 'Fahmi', 'Teknik Informatika', 2023, '081234567891'),
(5, '20230005', 'Eka', 'Teknik Industri', 2022, '081234567890'),
(6, '20230006', 'Fajar Pratama', 'Teknik Sipil', 2023, '081234567896'),
(7, '20230007', 'Gita Ayu', 'Psikologi', 2021, '081234567897'),
(8, '20230008', 'Hendra Saputra', 'Ilmu Komunikasi', 2023, '081234567898'),
(10, '20230010', 'Joko Susilo', 'Teknik Elektro', 2022, '081234567800'),
(11, '20230011', 'Ahmad Ramadhan', 'Teknik Informatika', 2023, '081234567811'),
(12, '20230012', 'Siti Nurhaliza', 'Sistem Informasi', 2023, '081234567812'),
(13, '20230013', 'Rina Marlina', 'Manajemen', 2022, '081234567813'),
(14, '20230014', 'Bagus Setiawan', 'Teknik Industri', 2022, '081234567814'),
(15, '20230015', 'Dwi Saputri', 'Teknik Sipil', 2023, '081234567815'),
(16, '20230016', 'Muhammad Ridwan', 'Ilmu Komunikasi', 2023, '081234567816'),
(17, '20230017', 'Nabila Zahra', 'Psikologi', 2021, '081234567817'),
(18, '20230018', 'Indra Gunawan', 'Teknik Elektro', 2022, '081234567818'),
(19, '20230019', 'Putri Melati', 'Desain Komunikasi Visual', 2022, '081234567819'),
(20, '20230020', 'Yoga Saputra', 'Teknik Informatika', 2023, '081234567820');

--
-- Triggers `mahasiswa`
--
DELIMITER $$
CREATE TRIGGER `before_delete_mahasiswa` BEFORE DELETE ON `mahasiswa` FOR EACH ROW BEGIN
  IF EXISTS (
    SELECT 1 FROM pemesanan_kamar
    WHERE id_mahasiswa = OLD.id_mahasiswa AND status = 'aktif'
  ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Tidak bisa menghapus mahasiswa yang masih memiliki transaksi aktif';
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_mahasiswa` BEFORE INSERT ON `mahasiswa` FOR EACH ROW BEGIN
  IF NEW.nama IS NULL OR NEW.nama = '' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Nama mahasiswa tidak boleh kosong';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan_kamar`
--

CREATE TABLE `pemesanan_kamar` (
  `id_pemesanan` int(11) NOT NULL,
  `id_mahasiswa` int(11) DEFAULT NULL,
  `id_kamar` int(11) DEFAULT NULL,
  `tanggal_masuk` date NOT NULL,
  `iuran_oper` int(11) DEFAULT NULL,
  `tanggal_pembayaran` date DEFAULT NULL,
  `status` enum('Pending','Aktif','Selesai') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pemesanan_kamar`
--

INSERT INTO `pemesanan_kamar` (`id_pemesanan`, `id_mahasiswa`, `id_kamar`, `tanggal_masuk`, `iuran_oper`, `tanggal_pembayaran`, `status`) VALUES
(1, 1, 1, '2024-05-01', 700000, '2024-05-16', 'Aktif'),
(5, 5, 5, '2024-08-20', 790000, '2025-03-22', 'Selesai'),
(6, 6, 6, '2024-08-25', 880000, '2025-03-25', 'Selesai'),
(7, 7, 7, '2024-09-01', 770000, '2025-03-28', 'Aktif'),
(8, 8, 8, '2024-09-05', 950000, '2025-03-31', 'Aktif'),
(10, 10, 10, '2024-08-01', 800000, '2025-04-06', 'Aktif'),
(21, 11, 11, '2025-05-01', 800000, '2025-04-09', 'Selesai'),
(22, 12, 11, '2025-05-01', 740000, '2025-04-12', 'Selesai'),
(23, 13, 12, '2025-05-02', 830000, '2025-04-15', 'Aktif'),
(24, 14, 12, '2025-05-02', 710000, '2025-04-18', 'Selesai'),
(25, 15, 13, '2025-05-03', 920000, '2025-04-21', 'Selesai'),
(26, 16, 14, '2025-05-03', 860000, '2025-04-24', 'Selesai'),
(27, 17, 14, '2025-05-04', 690000, '2025-04-27', 'Pending'),
(28, 18, 15, '2025-05-05', 940000, '2025-04-30', 'Selesai'),
(29, 19, 16, '2025-05-05', 890000, '2025-05-03', 'Selesai'),
(30, 20, 16, '2025-05-06', 760000, '2025-05-06', 'Selesai');

--
-- Triggers `pemesanan_kamar`
--
DELIMITER $$
CREATE TRIGGER `after_update_transaksi` AFTER UPDATE ON `pemesanan_kamar` FOR EACH ROW BEGIN
  IF NEW.status = 'selesai' THEN
    UPDATE kamar
    SET status_ketersediaan = 'kosong'
    WHERE id_kamar = NEW.id_kamar;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_agregasi_penghuni_per_kamar`
-- (See below for the actual view)
--
CREATE TABLE `view_agregasi_penghuni_per_kamar` (
`nomor_kamar` varchar(10)
,`jumlah_penghuni` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_detail_pemesanan`
-- (See below for the actual view)
--
CREATE TABLE `view_detail_pemesanan` (
`nim` varchar(15)
,`nama` varchar(100)
,`nomor_kamar` varchar(10)
,`tanggal_masuk` date
,`status` enum('Pending','Aktif','Selesai')
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_info_pemesanan`
-- (See below for the actual view)
--
CREATE TABLE `view_info_pemesanan` (
`nim` varchar(15)
,`nama` varchar(100)
,`jurusan` varchar(50)
,`tanggal_masuk` date
,`status` enum('Pending','Aktif','Selesai')
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_jumlah_keluhan_per_fasilitas`
-- (See below for the actual view)
--
CREATE TABLE `view_jumlah_keluhan_per_fasilitas` (
`nama_fasilitas` varchar(100)
,`total_keluhan` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_status_aktif`
-- (See below for the actual view)
--
CREATE TABLE `view_status_aktif` (
`nim` varchar(15)
,`nama` varchar(100)
,`nomor_kamar` varchar(10)
,`tanggal_masuk` date
);

-- --------------------------------------------------------

--
-- Structure for view `view_agregasi_penghuni_per_kamar`
--
DROP TABLE IF EXISTS `view_agregasi_penghuni_per_kamar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_agregasi_penghuni_per_kamar`  AS  select `k`.`nomor_kamar` AS `nomor_kamar`,count(`p`.`id_mahasiswa`) AS `jumlah_penghuni` from (`kamar` `k` join `pemesanan_kamar` `p` on((`k`.`id_kamar` = `p`.`id_kamar`))) where (`p`.`status` = 'Aktif') group by `k`.`nomor_kamar` ;

-- --------------------------------------------------------

--
-- Structure for view `view_detail_pemesanan`
--
DROP TABLE IF EXISTS `view_detail_pemesanan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_detail_pemesanan`  AS  select `m`.`nim` AS `nim`,`m`.`nama` AS `nama`,`k`.`nomor_kamar` AS `nomor_kamar`,`p`.`tanggal_masuk` AS `tanggal_masuk`,`p`.`status` AS `status` from ((`pemesanan_kamar` `p` join `mahasiswa` `m` on((`p`.`id_mahasiswa` = `m`.`id_mahasiswa`))) join `kamar` `k` on((`p`.`id_kamar` = `k`.`id_kamar`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_info_pemesanan`
--
DROP TABLE IF EXISTS `view_info_pemesanan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_info_pemesanan`  AS  select `m`.`nim` AS `nim`,`m`.`nama` AS `nama`,`m`.`jurusan` AS `jurusan`,`p`.`tanggal_masuk` AS `tanggal_masuk`,`p`.`status` AS `status` from (`mahasiswa` `m` join `pemesanan_kamar` `p` on((`m`.`id_mahasiswa` = `p`.`id_mahasiswa`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_jumlah_keluhan_per_fasilitas`
--
DROP TABLE IF EXISTS `view_jumlah_keluhan_per_fasilitas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_jumlah_keluhan_per_fasilitas`  AS  select `f`.`nama_fasilitas` AS `nama_fasilitas`,count(`lk`.`id_keluhan`) AS `total_keluhan` from (`fasilitas` `f` left join `laporan_keluhan` `lk` on((`f`.`id_fasilitas` = `lk`.`id_fasilitas`))) group by `f`.`nama_fasilitas` ;

-- --------------------------------------------------------

--
-- Structure for view `view_status_aktif`
--
DROP TABLE IF EXISTS `view_status_aktif`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_status_aktif`  AS  select `m`.`nim` AS `nim`,`m`.`nama` AS `nama`,`k`.`nomor_kamar` AS `nomor_kamar`,`p`.`tanggal_masuk` AS `tanggal_masuk` from ((`pemesanan_kamar` `p` join `mahasiswa` `m` on((`p`.`id_mahasiswa` = `m`.`id_mahasiswa`))) join `kamar` `k` on((`p`.`id_kamar` = `k`.`id_kamar`))) where (`p`.`status` = 'Aktif') ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fasilitas`
--
ALTER TABLE `fasilitas`
  ADD PRIMARY KEY (`id_fasilitas`);

--
-- Indexes for table `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`id_kamar`),
  ADD UNIQUE KEY `nomor_kamar` (`nomor_kamar`);

--
-- Indexes for table `laporan_keluhan`
--
ALTER TABLE `laporan_keluhan`
  ADD PRIMARY KEY (`id_keluhan`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`),
  ADD KEY `id_kamar` (`id_kamar`),
  ADD KEY `id_fasilitas` (`id_fasilitas`);

--
-- Indexes for table `log_fasilitas`
--
ALTER TABLE `log_fasilitas`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `log_keluhan`
--
ALTER TABLE `log_keluhan`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id_mahasiswa`),
  ADD UNIQUE KEY `nim` (`nim`);

--
-- Indexes for table `pemesanan_kamar`
--
ALTER TABLE `pemesanan_kamar`
  ADD PRIMARY KEY (`id_pemesanan`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`),
  ADD KEY `id_kamar` (`id_kamar`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fasilitas`
--
ALTER TABLE `fasilitas`
  MODIFY `id_fasilitas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id_kamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `laporan_keluhan`
--
ALTER TABLE `laporan_keluhan`
  MODIFY `id_keluhan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `log_fasilitas`
--
ALTER TABLE `log_fasilitas`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `log_keluhan`
--
ALTER TABLE `log_keluhan`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id_mahasiswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `pemesanan_kamar`
--
ALTER TABLE `pemesanan_kamar`
  MODIFY `id_pemesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `laporan_keluhan`
--
ALTER TABLE `laporan_keluhan`
  ADD CONSTRAINT `laporan_keluhan_ibfk_1` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_mahasiswa`) ON DELETE CASCADE,
  ADD CONSTRAINT `laporan_keluhan_ibfk_2` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`) ON DELETE SET NULL,
  ADD CONSTRAINT `laporan_keluhan_ibfk_3` FOREIGN KEY (`id_fasilitas`) REFERENCES `fasilitas` (`id_fasilitas`) ON DELETE SET NULL;

--
-- Constraints for table `pemesanan_kamar`
--
ALTER TABLE `pemesanan_kamar`
  ADD CONSTRAINT `pemesanan_kamar_ibfk_1` FOREIGN KEY (`id_mahasiswa`) REFERENCES `mahasiswa` (`id_mahasiswa`) ON DELETE CASCADE,
  ADD CONSTRAINT `pemesanan_kamar_ibfk_2` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
