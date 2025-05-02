-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 02, 2025 at 02:19 PM
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
-- Database: `umkm`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddProduk` (IN `p_id_umkm` INT, IN `p_nama_produk` VARCHAR(100), IN `p_deskripsi_produk` TEXT, IN `p_harga` DECIMAL(10,2))  BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, deskripsi_produk, harga)
    VALUES (p_id_umkm, p_nama_produk, p_deskripsi_produk, p_harga);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUMKM` (IN `p_nama_usaha` VARCHAR(100), IN `p_jumlah_karyawan` INT, IN `p_id_pemilik` INT, IN `p_id_kategori` INT, IN `p_id_skala` INT, IN `p_id_kabupaten_kota` INT, IN `p_tahun_berdiri` YEAR)  BEGIN
    INSERT INTO umkm (
        nama_usaha, jumlah_karyawan, id_pemilik, 
        id_kategori, id_skala, id_kabupaten_kota, tahun_berdiri
    ) VALUES (
        p_nama_usaha, p_jumlah_karyawan, p_id_pemilik, 
        p_id_kategori, p_id_skala, p_id_kabupaten_kota, p_tahun_berdiri
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePemilikUMKM` (IN `p_id_pemilik` INT)  BEGIN
    DELETE FROM pemilik_umkm
    WHERE id_pemilik = p_id_pemilik;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUMKMByID` (IN `p_id_umkm` INT)  BEGIN
    SELECT 
        u.nama_usaha,
        p.nama_lengkap AS nama_pemilik,
        k.nama_kategori,
        s.nama_skala,
        kab.nama_kabupaten_kota,
        u.jumlah_karyawan,
        u.tahun_berdiri
    FROM umkm u
    JOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik
    JOIN kategori_umkm k ON u.id_kategori = k.id_kategori
    JOIN skala_umkm s ON u.id_skala = s.id_skala
    JOIN kabupaten_kota kab ON u.id_kabupaten_kota = kab.id_kabupaten_kota
    WHERE u.id_umkm = p_id_umkm;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateKategoriUMKM` (IN `p_id_kategori` INT, IN `p_nama_baru` VARCHAR(100))  BEGIN
    UPDATE kategori_umkm
    SET nama_kategori = p_nama_baru
    WHERE id_kategori = p_id_kategori;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kabupaten_kota`
--

CREATE TABLE `kabupaten_kota` (
  `id_kabupaten_kota` int(11) NOT NULL,
  `nama_kabupaten_kota` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kabupaten_kota`
--

INSERT INTO `kabupaten_kota` (`id_kabupaten_kota`, `nama_kabupaten_kota`) VALUES
(1, 'Kota Bandung'),
(2, 'Kota Bekasi'),
(3, 'Kota Bogor'),
(4, 'Kota Cimahi'),
(5, 'Kota Cirebon'),
(6, 'Kota Depok'),
(7, 'Kota Sukabumi'),
(8, 'Kota Tasikmalaya'),
(9, 'Kota Banjar'),
(10, 'Kabupaten Bandung'),
(11, 'Kabupaten Bandung Barat'),
(12, 'Kabupaten Bekasi'),
(13, 'Kabupaten Bogor'),
(14, 'Kabupaten Ciamis'),
(15, 'Kabupaten Cianjur'),
(16, 'Kabupaten Cirebon'),
(17, 'Kabupaten Garut'),
(18, 'Kabupaten Indramayu'),
(19, 'Kabupaten Karawang'),
(20, 'Kabupaten Kuningan'),
(21, 'Kabupaten Majalengka'),
(22, 'Kabupaten Pangandaran'),
(23, 'Kabupaten Purwakarta'),
(24, 'Kabupaten Subang'),
(25, 'Kabupaten Sukabumi'),
(26, 'Kabupaten Sumedang'),
(27, 'Kabupaten Tasikmalaya');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_umkm`
--

CREATE TABLE `kategori_umkm` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(100) NOT NULL,
  `deskripsi` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kategori_umkm`
--

INSERT INTO `kategori_umkm` (`id_kategori`, `nama_kategori`, `deskripsi`) VALUES
(1, 'Kuliner', 'Usaha yang bergerak di bidang makanan dan minuman'),
(2, 'Kuliner daerah', 'Usaha yang bergerak di bidang pakaian, aksesoris, dan produk fashion lainnya'),
(3, 'Kerajinan', 'Usaha yang bergerak di bidang pembuatan produk kerajinan tangan'),
(4, 'Pertanian', 'Usaha yang bergerak di bidang pertanian, perkebunan, dan pengolahan hasil pertanian'),
(5, 'Peternakan', 'Usaha yang bergerak di bidang peternakan dan pengolahan hasil peternakan'),
(6, 'Perikanan', 'Usaha yang bergerak di bidang perikanan dan pengolahan hasil perikanan'),
(7, 'Jasa', 'Usaha yang bergerak di bidang pelayanan jasa'),
(8, 'Perdagangan', 'Usaha yang bergerak di bidang perdagangan barang'),
(9, 'Manufaktur', 'Usaha yang bergerak di bidang pembuatan produk'),
(10, 'Teknologi', 'Usaha yang bergerak di bidang teknologi informasi'),
(11, 'Pariwisata', 'Usaha yang bergerak di bidang pariwisata dan hospitality'),
(12, 'Ekonomi Kreatif', 'Usaha yang bergerak di bidang ekonomi kreatif seperti desain, seni, dll');

-- --------------------------------------------------------

--
-- Table structure for table `pemilik_umkm`
--

CREATE TABLE `pemilik_umkm` (
  `id_pemilik` int(11) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `nama_lengkap` varchar(200) NOT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `alamat` text NOT NULL,
  `nomor_telepon` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pemilik_umkm`
--

INSERT INTO `pemilik_umkm` (`id_pemilik`, `nik`, `nama_lengkap`, `jenis_kelamin`, `alamat`, `nomor_telepon`, `email`) VALUES
(1, '3273012505780001', 'Ahmad Sudrajat', 'Laki-laki', 'Jl. Pahlawan No. 123, Bandung', '081234567890', 'ahmad.sudrajat@gmail.com'),
(2, '3217016004850002', 'Siti Rahayu', 'Perempuan', 'Jl. Merdeka No. 45, Bekasi', '085678901234', 'siti.rahayu@gmail.com'),
(3, '3273025601900003', 'Budi Santoso', 'Laki-laki', 'Jl. Sukajadi No. 78, Bandung', '081345678901', 'budi.santoso@gmail.com'),
(4, '3271046502870004', 'Dewi Lestari', 'Perempuan', 'Jl. Veteran No. 56, Bogor', '087890123456', 'dewi.lestari@gmail.com'),
(6, '3277054408920006', 'Rina Anggraini', 'Perempuan', 'Jl. Kemuning No. 67, Cimahi', '082345678901', 'rina.anggraini@gmail.com'),
(7, '3210015509870007', 'Agus Hermawan', 'Laki-laki', 'Jl. Teratai No. 89, Bandung', '081456789012', 'agus.hermawan@gmail.com'),
(8, '3215026302860008', 'Ani Yudhoyono', 'Perempuan', 'Jl. Cikutra No. 23, Garut', '083567890123', 'ani.yudhoyono@gmail.com'),
(9, '3601014507830009', 'Hendra Wijaya', 'Laki-laki', 'Jl. Sudirman No. 56, Cianjur', '085678901234', 'hendra.wijaya@gmail.com'),
(10, '3216028308910010', 'Maya Sari', 'Perempuan', 'Jl. Gatot Subroto No. 78, Cirebon', '087890123456', 'maya.sari@gmail.com'),
(11, '3214013011820011', 'Rudi Hartono', 'Laki-laki', 'Jl. Setiabudi No. 90, Kuningan', '089012345678', 'rudi.hartono@gmail.com'),
(12, '3279027105860012', 'Lina Marlina', 'Perempuan', 'Jl. Pasteur No. 45, Majalengka', '081234567890', 'lina.marlina@gmail.com'),
(13, '3278011708840013', 'Dedi Kurniawan', 'Laki-laki', 'Jl. Ciganitri No. 67, Purwakarta', '085678901234', 'dedi.kurniawan@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `produk_umkm`
--

CREATE TABLE `produk_umkm` (
  `id_produk` int(11) NOT NULL,
  `id_umkm` int(11) NOT NULL,
  `nama_produk` varchar(200) NOT NULL,
  `deskripsi_produk` text NOT NULL,
  `harga` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `produk_umkm`
--

INSERT INTO `produk_umkm` (`id_produk`, `id_umkm`, `nama_produk`, `deskripsi_produk`, `harga`) VALUES
(1, 1, 'Sambel Hejo Level 1', 'Sambel hejo dengan tingkat kepedasan rendah', '15000.00'),
(2, 1, 'Sambel Hejo Level 3', 'Sambel hejo dengan tingkat kepedasan sedang', '17000.00'),
(3, 1, 'Sambel Hejo Level 5', 'Sambel hejo dengan tingkat kepedasan tinggi', '20000.00'),
(4, 1, 'Ayam Goreng Sambel Hejo', 'Paket nasi dengan ayam goreng dan sambel hejo', '25000.00'),
(5, 2, 'Batik Tulis Mega Mendung', 'Batik tulis motif mega mendung khas Cirebon', '750000.00'),
(6, 2, 'Batik Cap Kujang', 'Batik cap dengan motif kujang', '350000.00'),
(7, 2, 'Kemeja Batik Pria', 'Kemeja batik pria lengan panjang', '275000.00'),
(8, 2, 'Dress Batik Modern', 'Dress batik modern untuk wanita', '325000.00'),
(9, 3, 'Keranjang Anyaman Bambu', 'Keranjang anyaman bambu multi fungsi', '85000.00'),
(10, 3, 'Topi Anyaman Bambu', 'Topi anyaman bambu untuk bertani', '45000.00'),
(11, 3, 'Vas Bunga Rotan', 'Vas bunga dari rotan dengan desain klasik', '120000.00'),
(12, 4, 'Jeruk Keprok 1 kg', 'Jeruk keprok segar langsung dari kebun', '30000.00'),
(13, 4, 'Mangga Gedong Gincu 1 kg', 'Mangga gedong gincu khas Indramayu', '45000.00'),
(16, 6, 'Ikan Nila Segar 1 kg', 'Ikan nila segar hasil budidaya', '40000.00'),
(17, 6, 'Ikan Mas Segar 1 kg', 'Ikan mas segar hasil budidaya', '45000.00'),
(18, 6, 'Pempek Ikan', 'Pempek ikan nila homemade', '60000.00'),
(19, 7, 'Jasa Las Teralis', 'Jasa pembuatan teralis per meter', '350000.00'),
(20, 7, 'Jasa Las Pagar', 'Jasa pembuatan pagar besi per meter', '450000.00'),
(21, 8, 'Paket Sembako Hemat', 'Paket sembako hemat (beras, minyak, gula)', '150000.00'),
(22, 8, 'Beras Premium 5 kg', 'Beras premium kualitas terbaik', '75000.00'),
(23, 9, 'Meja Makan Set', 'Set meja makan kayu jati dengan 6 kursi', '12500000.00'),
(24, 9, 'Lemari Pakaian 3 Pintu', 'Lemari pakaian 3 pintu dari kayu jati', '8500000.00'),
(25, 10, 'Jasa Pembuatan Website', 'Jasa pembuatan website profesional', '5000000.00'),
(26, 10, 'Jasa Pembuatan Aplikasi Mobile', 'Jasa pembuatan aplikasi mobile Android dan iOS', '15000000.00'),
(27, 11, 'Kamar Standar per Malam', 'Sewa kamar standar per malam termasuk sarapan', '350000.00'),
(28, 11, 'Kamar Superior per Malam', 'Sewa kamar superior per malam termasuk sarapan', '500000.00'),
(29, 12, 'Jasa Desain Logo', 'Jasa pembuatan desain logo perusahaan', '2500000.00'),
(30, 12, 'Jasa Branding Komprehensif', 'Jasa branding komprehensif (logo, kop surat, dll)', '7500000.00'),
(31, 13, 'Dodol Garut', 'Dodol khas Garut berbagai rasa', '25000.00'),
(32, 13, 'Opak Singkong', 'Opak singkong khas Purwakarta', '20000.00'),
(37, 4, 'Keripik Singkong Pedas', 'Keripik singkong pedas dengan bumbu khas.', '12000.00'),
(38, 4, 'Pempek Palembang', 'Pempek pedas dengan bumbu khas Rendang.', '12000.00'),
(39, 18, 'Pempek', 'Pempek pedas dengan bumbu khas Rendang.', '15000.00');

-- --------------------------------------------------------

--
-- Table structure for table `skala_umkm`
--

CREATE TABLE `skala_umkm` (
  `id_skala` int(11) NOT NULL,
  `nama_skala` varchar(50) NOT NULL,
  `batas_aset_bawah` decimal(15,2) NOT NULL,
  `batas_aset_atas` decimal(15,2) NOT NULL,
  `batas_omzet_bawah` decimal(15,2) NOT NULL,
  `batas_omzet_atas` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `skala_umkm`
--

INSERT INTO `skala_umkm` (`id_skala`, `nama_skala`, `batas_aset_bawah`, `batas_aset_atas`, `batas_omzet_bawah`, `batas_omzet_atas`) VALUES
(1, 'Mikro', '0.00', '50000000.00', '0.00', '300000000.00'),
(2, 'Kecil', '50000000.00', '500000000.00', '300000000.00', '2500000000.00'),
(3, 'Menengah', '500000000.00', '10000000000.00', '2500000000.00', '50000000000.00');

-- --------------------------------------------------------

--
-- Table structure for table `umkm`
--

CREATE TABLE `umkm` (
  `id_umkm` int(11) NOT NULL,
  `nama_usaha` varchar(200) NOT NULL,
  `id_pemilik` int(11) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `id_skala` int(11) NOT NULL,
  `id_kabupaten_kota` int(11) NOT NULL,
  `alamat_usaha` text NOT NULL,
  `nib` varchar(50) NOT NULL,
  `npwp` varchar(20) NOT NULL,
  `tahun_berdiri` year(4) NOT NULL,
  `jumlah_karyawan` int(11) NOT NULL,
  `total_aset` decimal(15,2) NOT NULL,
  `omzet_per_tahun` decimal(15,2) NOT NULL,
  `deskripsi_usaha` text NOT NULL,
  `tanggal_registrasi` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `umkm`
--

INSERT INTO `umkm` (`id_umkm`, `nama_usaha`, `id_pemilik`, `id_kategori`, `id_skala`, `id_kabupaten_kota`, `alamat_usaha`, `nib`, `npwp`, `tahun_berdiri`, `jumlah_karyawan`, `total_aset`, `omzet_per_tahun`, `deskripsi_usaha`, `tanggal_registrasi`) VALUES
(1, 'Warung Sambel Hejo', 1, 1, 1, 1, 'Jl. Pahlawan No. 123, Bandung', '9120001234567', '09.876.543.2-123.000', 2018, 3, '35000000.00', '250000000.00', 'Warung makan spesialis sambel khas Sunda dengan aneka lauk', '2022-03-15'),
(2, 'Butik Batik Pesona', 2, 2, 2, 2, 'Jl. Merdeka No. 45, Bekasi', '9120001234568', '09.876.543.2-123.001', 2015, 7, '320000000.00', '1200000000.00', 'Butik batik dengan motif khas Jawa Barat', '2021-07-20'),
(3, 'Kerajinan Anyaman Rahayu', 3, 3, 1, 1, 'Jl. Sukajadi No. 78, Bandung', '9120001234569', '09.876.543.2-123.002', 2019, 5, '45000000.00', '280000000.00', 'Produk kerajinan anyaman bambu dan rotan', '2022-01-10'),
(4, 'Taman Buah Sejahtera', 4, 4, 2, 3, 'Jl. Veteran No. 56, Bogor', '9120001234570', '09.876.543.2-123.003', 2014, 10, '450000000.00', '2000000000.00', 'Pertanian buah-buahan lokal dan jeruk impor', '2020-11-05'),
(6, 'Budidaya Ikan Barokah', 6, 6, 2, 4, 'Jl. Kemuning No. 67, Cimahi', '9120001234572', '09.876.543.2-123.005', 2017, 8, '380000000.00', '1800000000.00', 'Budidaya ikan air tawar dan olahan ikan', '2021-04-12'),
(7, 'Bengkel Las Abadi', 7, 7, 1, 10, 'Jl. Teratai No. 89, Bandung', '9120001234573', '09.876.543.2-123.006', 2016, 6, '49000000.00', '290000000.00', 'Jasa pengelasan dan pembuatan pagar', '2022-05-17'),
(8, 'Toko Sembako Barokah', 8, 8, 2, 17, 'Jl. Cikutra No. 23, Garut', '9120001234574', '09.876.543.2-123.007', 2013, 5, '420000000.00', '2300000000.00', 'Perdagangan sembako dan kebutuhan rumah tangga', '2020-08-23'),
(9, 'Furniture Kayu Jati', 9, 9, 3, 15, 'Jl. Sudirman No. 56, Cianjur', '9120001234575', '09.876.543.2-123.008', 2012, 20, '2500000000.00', '15000000000.00', 'Produksi furniture kayu jati untuk ekspor', '2020-03-10'),
(10, 'Digital Solution', 10, 10, 2, 16, 'Jl. Gatot Subroto No. 78, Cirebon', '9120001234576', '09.876.543.2-123.009', 2018, 12, '480000000.00', '2200000000.00', 'Pengembangan aplikasi dan website', '2021-09-15'),
(11, 'Homestay Panorama', 11, 11, 1, 20, 'Jl. Setiabudi No. 90, Kuningan', '9120001234577', '09.876.543.2-123.010', 2019, 4, '47000000.00', '270000000.00', 'Penyedia akomodasi homestay di daerah wisata', '2022-04-21'),
(12, 'Studio Desain Kreatif', 12, 12, 2, 21, 'Jl. Pasteur No. 45, Majalengka', '9120001234578', '09.876.543.2-123.011', 2016, 8, '350000000.00', '1900000000.00', 'Jasa desain grafis dan branding', '2021-05-17'),
(13, 'Oleh-oleh Khas Sunda', 13, 1, 2, 23, 'Jl. Ciganitri No. 67, Purwakarta', '9120001234579', '09.876.543.2-123.012', 2015, 9, '370000000.00', '2100000000.00', 'Makanan oleh-oleh khas Sunda Buhun', '2020-10-30'),
(18, 'Toko Berkah Jaya', 1, 2, 1, 3, '', '', '', 2015, 12, '0.00', '0.00', '', '0000-00-00'),
(19, 'Toko Berkah Jaya', 1, 2, 1, 3, '', '', '', 2015, 12, '0.00', '0.00', '', '0000-00-00');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_pemilik_dan_usaha`
-- (See below for the actual view)
--
CREATE TABLE `view_pemilik_dan_usaha` (
`nik` varchar(16)
,`nama_lengkap` varchar(200)
,`jenis_kelamin` enum('Laki-laki','Perempuan')
,`nomor_telepon` varchar(15)
,`email` varchar(100)
,`nama_usaha` varchar(200)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_produk_umkm`
-- (See below for the actual view)
--
CREATE TABLE `view_produk_umkm` (
`nama_usaha` varchar(200)
,`nama_produk` varchar(200)
,`deskripsi_produk` text
,`harga` decimal(15,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_umkm_detail`
-- (See below for the actual view)
--
CREATE TABLE `view_umkm_detail` (
`nama_usaha` varchar(200)
,`nama_pemilik` varchar(200)
,`nama_kategori` varchar(100)
,`nama_skala` varchar(50)
,`nama_kabupaten_kota` varchar(100)
,`tahun_berdiri` year(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_umkm_menengah`
-- (See below for the actual view)
--
CREATE TABLE `view_umkm_menengah` (
`nama_usaha` varchar(200)
,`nama_pemilik` varchar(200)
,`total_aset` decimal(15,2)
,`omzet_per_tahun` decimal(15,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_umkm_per_kota`
-- (See below for the actual view)
--
CREATE TABLE `view_umkm_per_kota` (
`nama_kabupaten_kota` varchar(100)
,`jumlah_umkm` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `view_pemilik_dan_usaha`
--
DROP TABLE IF EXISTS `view_pemilik_dan_usaha`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_pemilik_dan_usaha`  AS  select `p`.`nik` AS `nik`,`p`.`nama_lengkap` AS `nama_lengkap`,`p`.`jenis_kelamin` AS `jenis_kelamin`,`p`.`nomor_telepon` AS `nomor_telepon`,`p`.`email` AS `email`,`u`.`nama_usaha` AS `nama_usaha` from (`pemilik_umkm` `p` join `umkm` `u` on((`p`.`id_pemilik` = `u`.`id_pemilik`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_produk_umkm`
--
DROP TABLE IF EXISTS `view_produk_umkm`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_produk_umkm`  AS  select `u`.`nama_usaha` AS `nama_usaha`,`pr`.`nama_produk` AS `nama_produk`,`pr`.`deskripsi_produk` AS `deskripsi_produk`,`pr`.`harga` AS `harga` from (`produk_umkm` `pr` join `umkm` `u` on((`pr`.`id_umkm` = `u`.`id_umkm`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_umkm_detail`
--
DROP TABLE IF EXISTS `view_umkm_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_umkm_detail`  AS  select `u`.`nama_usaha` AS `nama_usaha`,`p`.`nama_lengkap` AS `nama_pemilik`,`k`.`nama_kategori` AS `nama_kategori`,`s`.`nama_skala` AS `nama_skala`,`kab`.`nama_kabupaten_kota` AS `nama_kabupaten_kota`,`u`.`tahun_berdiri` AS `tahun_berdiri` from ((((`umkm` `u` join `pemilik_umkm` `p` on((`u`.`id_pemilik` = `p`.`id_pemilik`))) join `kategori_umkm` `k` on((`u`.`id_kategori` = `k`.`id_kategori`))) join `skala_umkm` `s` on((`u`.`id_skala` = `s`.`id_skala`))) join `kabupaten_kota` `kab` on((`u`.`id_kabupaten_kota` = `kab`.`id_kabupaten_kota`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_umkm_menengah`
--
DROP TABLE IF EXISTS `view_umkm_menengah`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_umkm_menengah`  AS  select `u`.`nama_usaha` AS `nama_usaha`,`p`.`nama_lengkap` AS `nama_pemilik`,`u`.`total_aset` AS `total_aset`,`u`.`omzet_per_tahun` AS `omzet_per_tahun` from ((`umkm` `u` join `pemilik_umkm` `p` on((`u`.`id_pemilik` = `p`.`id_pemilik`))) join `skala_umkm` `s` on((`u`.`id_skala` = `s`.`id_skala`))) where (`s`.`nama_skala` = 'Menengah') ;

-- --------------------------------------------------------

--
-- Structure for view `view_umkm_per_kota`
--
DROP TABLE IF EXISTS `view_umkm_per_kota`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_umkm_per_kota`  AS  select `k`.`nama_kabupaten_kota` AS `nama_kabupaten_kota`,count(`u`.`id_umkm`) AS `jumlah_umkm` from (`umkm` `u` join `kabupaten_kota` `k` on((`u`.`id_kabupaten_kota` = `k`.`id_kabupaten_kota`))) group by `k`.`nama_kabupaten_kota` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kabupaten_kota`
--
ALTER TABLE `kabupaten_kota`
  ADD PRIMARY KEY (`id_kabupaten_kota`);

--
-- Indexes for table `kategori_umkm`
--
ALTER TABLE `kategori_umkm`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `pemilik_umkm`
--
ALTER TABLE `pemilik_umkm`
  ADD PRIMARY KEY (`id_pemilik`);

--
-- Indexes for table `produk_umkm`
--
ALTER TABLE `produk_umkm`
  ADD PRIMARY KEY (`id_produk`),
  ADD KEY `fk_produk_umkm` (`id_umkm`);

--
-- Indexes for table `skala_umkm`
--
ALTER TABLE `skala_umkm`
  ADD PRIMARY KEY (`id_skala`);

--
-- Indexes for table `umkm`
--
ALTER TABLE `umkm`
  ADD PRIMARY KEY (`id_umkm`),
  ADD KEY `fk_umkm_pemilik` (`id_pemilik`),
  ADD KEY `fk_umkm_kategori` (`id_kategori`),
  ADD KEY `fk_umkm_skala` (`id_skala`),
  ADD KEY `fk_umkm_kabupaten` (`id_kabupaten_kota`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kabupaten_kota`
--
ALTER TABLE `kabupaten_kota`
  MODIFY `id_kabupaten_kota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `kategori_umkm`
--
ALTER TABLE `kategori_umkm`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `pemilik_umkm`
--
ALTER TABLE `pemilik_umkm`
  MODIFY `id_pemilik` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `produk_umkm`
--
ALTER TABLE `produk_umkm`
  MODIFY `id_produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `skala_umkm`
--
ALTER TABLE `skala_umkm`
  MODIFY `id_skala` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `umkm`
--
ALTER TABLE `umkm`
  MODIFY `id_umkm` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `produk_umkm`
--
ALTER TABLE `produk_umkm`
  ADD CONSTRAINT `fk_produk_umkm` FOREIGN KEY (`id_umkm`) REFERENCES `umkm` (`id_umkm`) ON DELETE CASCADE;

--
-- Constraints for table `umkm`
--
ALTER TABLE `umkm`
  ADD CONSTRAINT `fk_umkm_kabupaten` FOREIGN KEY (`id_kabupaten_kota`) REFERENCES `kabupaten_kota` (`id_kabupaten_kota`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_umkm_kategori` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_umkm` (`id_kategori`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_umkm_pemilik` FOREIGN KEY (`id_pemilik`) REFERENCES `pemilik_umkm` (`id_pemilik`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_umkm_skala` FOREIGN KEY (`id_skala`) REFERENCES `skala_umkm` (`id_skala`) ON DELETE CASCADE,
  ADD CONSTRAINT `umkm_ibfk_1` FOREIGN KEY (`id_pemilik`) REFERENCES `pemilik_umkm` (`id_pemilik`),
  ADD CONSTRAINT `umkm_ibfk_2` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_umkm` (`id_kategori`),
  ADD CONSTRAINT `umkm_ibfk_3` FOREIGN KEY (`id_skala`) REFERENCES `skala_umkm` (`id_skala`),
  ADD CONSTRAINT `umkm_ibfk_4` FOREIGN KEY (`id_kabupaten_kota`) REFERENCES `kabupaten_kota` (`id_kabupaten_kota`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
