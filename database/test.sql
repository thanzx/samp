-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2022 at 03:56 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `invID` int(12) NOT NULL,
  `invOwner` int(11) NOT NULL DEFAULT 0,
  `invItem` varchar(32) DEFAULT NULL,
  `invQuantity` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`invID`, `invOwner`, `invItem`, `invQuantity`) VALUES
(1, 3, 'แอปเปิ้ล', 5),
(2, 3, 'พิซซ่า', 13),
(3, 4, 'พิซซ่า', 3),
(4, 4, 'แอปเปิ้ล', 3),
(5, 3, 'แฮมเบอร์เกอร์', 10);

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `ID` int(11) NOT NULL,
  `Username` varchar(64) NOT NULL,
  `Password` char(128) NOT NULL,
  `Money` int(11) NOT NULL DEFAULT 0,
  `Admins` int(11) NOT NULL DEFAULT 0,
  `Model` int(11) NOT NULL DEFAULT 0,
  `PosX` float NOT NULL DEFAULT 0,
  `PosY` float NOT NULL DEFAULT 0,
  `PosZ` float NOT NULL DEFAULT 0,
  `PosA` float NOT NULL DEFAULT 0,
  `Login` int(11) NOT NULL DEFAULT 0,
  `pLevel` int(11) NOT NULL DEFAULT 0,
  `RedMoney` int(11) NOT NULL,
  `Hungry` float NOT NULL DEFAULT 0,
  `Water` float NOT NULL DEFAULT 0,
  `maxitem` int(11) NOT NULL DEFAULT 0,
  `itemamount` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`ID`, `Username`, `Password`, `Money`, `Admins`, `Model`, `PosX`, `PosY`, `PosZ`, `PosA`, `Login`, `pLevel`, `RedMoney`, `Hungry`, `Water`, `maxitem`, `itemamount`) VALUES
(1, 'ewwfg', 'gwefg', 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
(2, 'John_conner', '789456', 1000, 0, 22, 2003.36, 1543.92, 13.5859, 274.772, 0, 0, 0, 100, 100, 0, 0),
(3, 'Johnny_Dev', '789456', 1000, 9, 22, 2022.21, 1544.69, 10.8225, 275.086, 1, 0, 0, 20, -30, 10, 50),
(4, 'Johnny_Dev1', '789456', 1000, 0, 22, 2003.36, 1543.92, 13.5859, 274.772, 0, 0, 0, 35, -40, 10, 50);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`invID`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Username` (`Username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `invID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
