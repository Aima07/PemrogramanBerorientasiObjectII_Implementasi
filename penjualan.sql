-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 15 Jul 2024 pada 15.37
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penjualan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang`
--

CREATE TABLE `tbl_barang` (
  `kd_barang` varchar(10) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `jumlah_barang` int(11) NOT NULL,
  `harga_beli` int(11) NOT NULL,
  `harga_jual` int(11) NOT NULL,
  `tanggal_masuk` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tbl_barang`
--

INSERT INTO `tbl_barang` (`kd_barang`, `nama_barang`, `jumlah_barang`, `harga_beli`, `harga_jual`, `tanggal_masuk`) VALUES
('B0001', 'Laptop', 8, 5000000, 5000000, '2024-06-30'),
('B0002', 'Mouse', 10, 100000, 100000, '2024-06-30'),
('B0003', 'Keyboard', 10, 300000, 300000, '2024-06-30'),
('B0004', 'Speaker', 18, 50000, 50000, '2024-06-30');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_hitung_jual`
--

CREATE TABLE `tbl_hitung_jual` (
  `id` int(11) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  `kd_barang` varchar(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `hsatuan` int(11) NOT NULL,
  `jumlah_jual` int(11) NOT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Trigger `tbl_hitung_jual`
--
DELIMITER $$
CREATE TRIGGER `tr_batal` AFTER DELETE ON `tbl_hitung_jual` FOR EACH ROW BEGIN 
UPDATE tbl_barang 
SET jumlah_barang = jumlah_barang + old.jumlah_jual
WHERE kd_barang = old.kd_barang;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_jual` AFTER INSERT ON `tbl_hitung_jual` FOR EACH ROW BEGIN
UPDATE tbl_barang
SET jumlah_barang = jumlah_barang - new.jumlah_jual
WHERE kd_barang = new.kd_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_login`
--

CREATE TABLE `tbl_login` (
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `jenis_kelamin` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telp` int(11) NOT NULL,
  `agama` varchar(30) NOT NULL,
  `alamat` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tbl_login`
--

INSERT INTO `tbl_login` (`username`, `password`, `jenis_kelamin`, `email`, `no_telp`, `agama`, `alamat`) VALUES
('aima', '123', 'Perempuan', 'nuraimahasanah@gmail.com', 194830195, 'Islam', 'Malaysia'),
('test', 'test', 'L', 'ardi', 123123, 'Islam', '123123123');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_penjualan`
--

CREATE TABLE `tbl_penjualan` (
  `nofaktur` varchar(11) NOT NULL,
  `kd_barang` varchar(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `hsatuan` int(11) NOT NULL,
  `jumlah_jual` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `bayar` int(11) NOT NULL,
  `kembalian` int(11) NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tbl_penjualan`
--

INSERT INTO `tbl_penjualan` (`nofaktur`, `kd_barang`, `nama_barang`, `hsatuan`, `jumlah_jual`, `harga`, `bayar`, `kembalian`, `tanggal`) VALUES
('F0001', 'B0003', 'Keyboard', 300000, 1, 300000, 300000, 0, '2024-07-01'),
('F0002', 'B0002', 'Mouse', 100000, 1, 100000, 100000, 0, '2024-07-01'),
('F0003', 'B0002', 'Mouse', 100000, 2, 200000, 200000, 0, '2024-07-01'),
('F0004', 'B0003', 'Keyboard', 300000, 1, 300000, 500000, 100000, '2024-07-01'),
('F0004', 'B0004', 'Speaker', 50000, 2, 100000, 500000, 100000, '2024-07-01');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tbl_barang`
--
ALTER TABLE `tbl_barang`
  ADD PRIMARY KEY (`kd_barang`);

--
-- Indeks untuk tabel `tbl_hitung_jual`
--
ALTER TABLE `tbl_hitung_jual`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tbl_hitung_jual`
--
ALTER TABLE `tbl_hitung_jual`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
