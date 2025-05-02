-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 02, 2025 at 02:20 PM
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDataMasterByID` (IN `p_id_mahasiswa` INT, OUT `p_nama_mahasiswa` VARCHAR(100))  BEGIN
    SELECT nama INTO p_nama_mahasiswa
    FROM mahasiswa
    WHERE id_mahasiswa = p_id_mahasiswa;
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

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `id_kamar` int(11) NOT NULL,
  `status_kamar` enum('Single','Double','Triple','Family') DEFAULT NULL,
  `keterangan` text,
  `nomor_kamar` varchar(10) NOT NULL,
  `kapasitas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`id_kamar`, `status_kamar`, `keterangan`, `nomor_kamar`, `kapasitas`) VALUES
(1, 'Double', 'Tersedia', 'A101', 2),
(2, 'Double', 'Tersedia', 'A102', 2),
(3, 'Double', 'Tersedia', 'A103', 2),
(4, 'Triple', 'Tersedia', 'B201', 3),
(5, 'Triple', 'Tersedia', 'B202', 3),
(6, 'Triple', 'Tersedia', 'B203', 3),
(7, 'Single', 'Tersedia', 'C301', 1),
(8, 'Single', 'Tersedia', 'C302', 1),
(9, 'Family', 'Tersedia', 'D401', 4),
(10, 'Family', 'Tersedia', 'D402', 4),
(11, 'Double', 'Tersedia', 'A104', 2),
(12, 'Double', 'Tersedia', 'B204', 2),
(13, 'Single', 'Tersedia', 'C303', 1),
(14, 'Double', 'Tersedia', 'C304', 2),
(15, 'Single', 'Tersedia', 'D403', 1),
(16, 'Double', 'Tersedia', 'D404', 2);

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
(2, 3, 3, 2, 'AC kamar kurang dingin.', '2025-04-11 14:42:51', 'Sedang Diproses'),
(3, 5, 5, 5, 'Lampu kamar mati dan belum diganti.', '2025-04-11 14:42:51', 'Belum Ditangani'),
(4, 6, 6, 3, 'Layanan laundry tidak datang minggu ini.', '2025-04-11 14:42:51', 'Selesai'),
(5, 8, 8, 4, 'Dapur umum kotor dan tidak dibersihkan rutin.', '2025-04-11 14:42:51', 'Sedang Diproses');

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
(2, '20230002', 'Budi Santoso', 'Sistem Informasi', 2023, '081234567892'),
(3, '20230003', 'Citra Dewi', 'Manajemen', 2022, '081234567893'),
(5, '20230005', 'Eka Lestari', 'Teknik Industri', 2022, '081234567895'),
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

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan_kamar`
--

CREATE TABLE `pemesanan_kamar` (
  `id_pemesanan` int(11) NOT NULL,
  `id_mahasiswa` int(11) DEFAULT NULL,
  `id_kamar` int(11) DEFAULT NULL,
  `tanggal_masuk` date NOT NULL,
  `status` enum('Pending','Aktif','Selesai') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pemesanan_kamar`
--

INSERT INTO `pemesanan_kamar` (`id_pemesanan`, `id_mahasiswa`, `id_kamar`, `tanggal_masuk`, `status`) VALUES
(1, 1, 1, '2024-05-01', 'Aktif'),
(2, 2, 2, '2024-08-05', 'Selesai'),
(3, 3, 3, '2024-09-10', 'Selesai'),
(5, 5, 5, '2024-08-20', 'Aktif'),
(6, 6, 6, '2024-08-25', 'Aktif'),
(7, 7, 7, '2024-09-01', 'Aktif'),
(8, 8, 8, '2024-09-05', 'Aktif'),
(10, 10, 10, '2024-08-01', 'Aktif'),
(21, 11, 11, '2025-05-01', 'Aktif'),
(22, 12, 11, '2025-05-01', 'Aktif'),
(23, 13, 12, '2025-05-02', 'Aktif'),
(24, 14, 12, '2025-05-02', 'Aktif'),
(25, 15, 13, '2025-05-03', 'Aktif'),
(26, 16, 14, '2025-05-03', 'Aktif'),
(27, 17, 14, '2025-05-04', 'Aktif'),
(28, 18, 15, '2025-05-05', 'Aktif'),
(29, 19, 16, '2025-05-05', 'Aktif'),
(30, 20, 16, '2025-05-06', 'Aktif');

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
  MODIFY `id_fasilitas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id_kamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `laporan_keluhan`
--
ALTER TABLE `laporan_keluhan`
  MODIFY `id_keluhan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
