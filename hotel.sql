-- phpMyAdmin SQL Dump
-- version 4.4.15.9
-- https://www.phpmyadmin.net
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2021. Máj 13. 10:31
-- Kiszolgáló verziója: 5.6.37
-- PHP verzió: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `hotel`
--
CREATE DATABASE IF NOT EXISTS `hotel` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `hotel`;

DELIMITER $$
--
-- Eljárások
--
DROP PROCEDURE IF EXISTS `addNewAddress`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewAddress`(IN `houseIN` SMALLINT(6), IN `cityIN` INT(8), IN `streetIN` INT(8))
    NO SQL
INSERT INTO `addresses`(`addresses`.`House_number`, `addresses`.`City_id`, `addresses`.`Street_id`) VALUES(houseIN, cityIN, streetIN)$$

DROP PROCEDURE IF EXISTS `addNewBooking`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewBooking`(IN `bookingDateIN` DATETIME, IN `arrivalIN` DATETIME, IN `leaveIN` DATETIME, IN `noGuestsIN` INT(2), IN `guestIN` INT(8), IN `servicesIN` INT(8), IN `statusIN` INT(8), IN `roomIN` INT(11))
    NO SQL
INSERT INTO `bookings`(`bookings`.`Booking_date`, `bookings`.`Arrival_date`, `bookings`.`Leave_date`, `bookings`.`Number_of_guests`, `bookings`.`Guest_id`, `bookings`.`Services_id`, `bookings`.`Booking_status_id`, `bookings`.`Room_id`) VALUES(bookingDateIN, arrivalIN, leaveIN, noGuestsIN, guestIN, servicesIN, statusIN, roomIN)$$

DROP PROCEDURE IF EXISTS `addNewBookingStatus`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewBookingStatus`(IN `statusIN` VARCHAR(45))
    NO SQL
INSERT INTO `booking_status`(`booking_status`.`status`) VALUES(statusIN)$$

DROP PROCEDURE IF EXISTS `addNewCity`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewCity`(IN `nameIN` VARCHAR(45))
    NO SQL
INSERT INTO `cities`(`cities`.`City_name`) VALUES(nameIN)$$

DROP PROCEDURE IF EXISTS `addNewExtra`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewExtra`(IN `nameIN` VARCHAR(45), IN `descIN` VARCHAR(45))
    NO SQL
INSERT INTO `extras`(`extras`.`Extra_name`, `extras`.`Extra_desc`) VALUES(nameIN, descIN)$$

DROP PROCEDURE IF EXISTS `addNewGuest`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewGuest`(IN `firstnameIN` VARCHAR(50), IN `lastnameIN` VARCHAR(50), IN `emailIN` VARCHAR(256), IN `mobileIN` VARCHAR(13), IN `addressIN` INT(8))
    NO SQL
INSERT INTO `guests`(`guests`.`Firstname`, `guests`.`Lastname`, `guests`.`Email`, `guests`.`Mobile`, `guests`.`Address_id`) VALUES(firstnameIN, lastnameIN, emailIN, mobileIN, addressIN)$$

DROP PROCEDURE IF EXISTS `addNewRoom`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewRoom`(IN `capacityIN` INT(4), IN `room_statusIN` INT(8), IN `extraIN` INT(8), IN `priceIN` INT, IN `pictureIN` VARCHAR(50) CHARSET utf8, IN `descIN` TEXT CHARSET utf8)
    NO SQL
INSERT INTO `rooms`(`rooms`.`capacity`, `rooms`.`room_status_id`, `rooms`.`extra_id`, `rooms`.`Price`, `rooms`.`Picture`, `rooms`.`Description`) VALUES(capacityIN, room_statusIN, extraIN, priceIN, pictureIN, descIN)$$

DROP PROCEDURE IF EXISTS `addNewRoomStatus`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewRoomStatus`(IN `statusIN` VARCHAR(45))
    NO SQL
INSERT INTO `room_status`(`room_status`.`status`) VALUES(statusIN)$$

DROP PROCEDURE IF EXISTS `addNewService`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewService`(IN `nameIN` VARCHAR(45))
    NO SQL
INSERT INTO `services`(`services`.`Service_name`) VALUES(nameIN)$$

DROP PROCEDURE IF EXISTS `addNewStreet`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewStreet`(IN `nameIN` VARCHAR(45), IN `zipIN` INT(8))
    NO SQL
INSERT INTO `streets`(`streets`.`Street_name`, `streets`.`Zipcode_id`) VALUES(nameIN, zipIN)$$

DROP PROCEDURE IF EXISTS `addNewZipcode`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewZipcode`(IN `zipIN` VARCHAR(6))
    NO SQL
REPLACE INTO `zipcodes`(`zipcodes`.`zipcode`) VALUES(zipIN)$$

DROP PROCEDURE IF EXISTS `checkAddress`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkAddress`(IN `houseIN` INT, IN `cityIN` INT, IN `streetIN` INT)
    NO SQL
SELECT * FROM `addresses` WHERE `addresses`.`House_number` = houseIN AND `addresses`.`City_id` = cityIN AND `addresses`.`Street_id` = streetIN$$

DROP PROCEDURE IF EXISTS `checkCity`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkCity`(IN `cityIN` VARCHAR(45))
    NO SQL
SELECT * FROM `cities` WHERE `cities`.`City_name` = cityIN$$

DROP PROCEDURE IF EXISTS `checkGuest`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkGuest`(IN `emailIN` VARCHAR(200))
    NO SQL
SELECT * FROM `guests` WHERE `guests`.`Email` = emailIN$$

DROP PROCEDURE IF EXISTS `checkRoomAvailability`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkRoomAvailability`(IN `leaveIN` DATE, IN `arrivalIN` DATE, IN `roomIN` INT(8))
    NO SQL
SELECT `bookings`.`Booking_id` FROM `bookings`
	WHERE `bookings`.`Room_id` = roomIN AND
    ((arrivalIN BETWEEN `bookings`.`Arrival_date` AND `bookings`.`Leave_date`) OR
    (leaveIN BETWEEN `bookings`.`Arrival_date` AND `bookings`.`Leave_date`) OR
    (`bookings`.`Arrival_date` BETWEEN arrivalIN AND leaveIN) OR
   	(`bookings`.`Leave_date` BETWEEN arrivalIN AND leaveIN))$$

DROP PROCEDURE IF EXISTS `checkStreet`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkStreet`(IN `streetIN` VARCHAR(45))
    NO SQL
SELECT * FROM `streets` WHERE `streets`.`Street_name` = streetIN$$

DROP PROCEDURE IF EXISTS `checkZipcode`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkZipcode`(IN `zipIN` VARCHAR(6))
    NO SQL
SELECT * FROM `zipcodes` WHERE `zipcodes`.`zipcode` = zipIN$$

DROP PROCEDURE IF EXISTS `getAllRooms`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllRooms`()
    NO SQL
SELECT * FROM `rooms`$$

DROP PROCEDURE IF EXISTS `updateBookingStatusById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateBookingStatusById`(IN `idIN` INT(8), IN `statusIN` INT(8))
    NO SQL
UPDATE `bookings` SET `bookings`.`Booking_status_id` = statusIN WHERE `bookings`.`Booking_id` = idIN$$

DROP PROCEDURE IF EXISTS `updateRoomStatusById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateRoomStatusById`(IN `idIN` INT(8), IN `statusIN` INT)
    NO SQL
UPDATE `rooms` SET `rooms`.`room_status_id` = statusIN WHERE `rooms`.`Room_id` = idIN$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `addresses`
--

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE IF NOT EXISTS `addresses` (
  `Address_id` int(8) NOT NULL,
  `House_number` smallint(6) NOT NULL,
  `City_id` int(8) NOT NULL,
  `Street_id` int(8) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `addresses`
--

INSERT INTO `addresses` (`Address_id`, `House_number`, `City_id`, `Street_id`) VALUES
(1, 12, 1, 1),
(2, 13, 1, 1),
(3, 14, 1, 1),
(4, 14, 1, 1),
(5, 89, 1, 1),
(6, 42, 2, 5),
(7, 42, 2, 5),
(8, 54, 3, 6),
(9, 54, 3, 6),
(10, 54, 3, 6),
(11, 54, 3, 6),
(12, 54, 3, 6),
(13, 54, 3, 7),
(14, 54, 3, 7),
(15, 54, 3, 7),
(16, 54, 3, 7),
(17, 54, 3, 7),
(18, 54, 3, 7),
(19, 54, 3, 7),
(20, 54, 3, 7),
(21, 54, 3, 7),
(22, 54, 3, 7),
(23, 54, 3, 7),
(24, 54, 3, 7),
(25, 54, 3, 7);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `Booking_id` int(8) NOT NULL,
  `Booking_date` datetime NOT NULL,
  `Arrival_date` datetime NOT NULL,
  `Leave_date` datetime NOT NULL,
  `Number_of_guests` int(2) NOT NULL,
  `Guest_id` int(8) NOT NULL,
  `Services_id` int(8) NOT NULL,
  `Booking_status_id` int(8) NOT NULL,
  `Room_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `bookings`
--

INSERT INTO `bookings` (`Booking_id`, `Booking_date`, `Arrival_date`, `Leave_date`, `Number_of_guests`, `Guest_id`, `Services_id`, `Booking_status_id`, `Room_id`) VALUES
(1, '2021-04-15 00:00:00', '2021-04-15 00:00:00', '2021-04-16 00:00:00', 1, 1, 1, 1, 1),
(2, '2021-04-15 00:00:00', '2021-04-17 00:00:00', '2021-04-18 00:00:00', 1, 1, 1, 1, 1),
(3, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-04-28 00:00:00', 2, 1, 2, 1, 2),
(4, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-04-28 00:00:00', 2, 1, 2, 1, 2),
(5, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-04-28 00:00:00', 2, 1, 2, 1, 2),
(6, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-05-01 00:00:00', 2, 1, 2, 1, 2),
(7, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-05-01 00:00:00', 2, 1, 2, 1, 2),
(8, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-05-01 00:00:00', 2, 1, 2, 1, 2),
(9, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-05-01 00:00:00', 2, 1, 2, 1, 2),
(10, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-05-01 00:00:00', 2, 1, 2, 1, 2),
(11, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-05-01 00:00:00', 2, 1, 2, 1, 2),
(12, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-05-01 00:00:00', 2, 1, 1, 1, 1),
(13, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-05-01 00:00:00', 2, 1, 1, 1, 1),
(14, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-05-09 00:00:00', 3, 1, 1, 1, 1),
(15, '2021-05-04 00:00:00', '2021-04-28 00:00:00', '2021-05-02 00:00:00', 352, 1, 3, 1, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `booking_status`
--

DROP TABLE IF EXISTS `booking_status`;
CREATE TABLE IF NOT EXISTS `booking_status` (
  `Booking_status_id` int(8) NOT NULL,
  `status` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `booking_status`
--

INSERT INTO `booking_status` (`Booking_status_id`, `status`) VALUES
(1, 'Nem fizetve'),
(2, 'Fizetve');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cities`
--

DROP TABLE IF EXISTS `cities`;
CREATE TABLE IF NOT EXISTS `cities` (
  `City_id` int(8) NOT NULL,
  `City_name` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `cities`
--

INSERT INTO `cities` (`City_id`, `City_name`) VALUES
(2, 'AAAA'),
(1, 'Budapest'),
(3, 'dasgffdsah');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `extras`
--

DROP TABLE IF EXISTS `extras`;
CREATE TABLE IF NOT EXISTS `extras` (
  `Extra_id` int(11) NOT NULL,
  `Extra_name` varchar(45) NOT NULL,
  `Extra_desc` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `extras`
--

INSERT INTO `extras` (`Extra_id`, `Extra_name`, `Extra_desc`) VALUES
(2, 'Jakuzzi', 'Buborékos medence'),
(3, '4K LED TV', 'Televízió'),
(4, 'Légkondi', 'Hűs levegő télen-nyáron');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `guests`
--

DROP TABLE IF EXISTS `guests`;
CREATE TABLE IF NOT EXISTS `guests` (
  `Guest_id` int(8) NOT NULL,
  `Firstname` varchar(50) NOT NULL,
  `Lastname` varchar(50) NOT NULL,
  `Email` varchar(200) NOT NULL,
  `Mobile` varchar(13) NOT NULL,
  `Address_id` int(8) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `guests`
--

INSERT INTO `guests` (`Guest_id`, `Firstname`, `Lastname`, `Email`, `Mobile`, `Address_id`) VALUES
(1, 'Miki', 'Móka', 'mokamiki@email.com', ' 36123456789', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rooms`
--

DROP TABLE IF EXISTS `rooms`;
CREATE TABLE IF NOT EXISTS `rooms` (
  `Room_id` int(8) NOT NULL,
  `capacity` tinyint(4) NOT NULL,
  `room_status_id` int(8) NOT NULL,
  `extra_id` int(8) NOT NULL,
  `Price` int(11) NOT NULL,
  `Picture` varchar(50) NOT NULL,
  `Description` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `rooms`
--

INSERT INTO `rooms` (`Room_id`, `capacity`, `room_status_id`, `extra_id`, `Price`, `Picture`, `Description`) VALUES
(1, 2, 1, 4, 5000, 'res/hotel1.png', 'Lorem ipsum dolor sit amet'),
(2, 3, 1, 2, 9000, 'res/hotel2.jpg', 'Van benne bubis víz'),
(3, 4, 1, 3, 12000, 'res/hotel3.jpg', 'Van kispárna is');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `room_status`
--

DROP TABLE IF EXISTS `room_status`;
CREATE TABLE IF NOT EXISTS `room_status` (
  `Room_status_id` int(8) NOT NULL,
  `status` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `room_status`
--

INSERT INTO `room_status` (`Room_status_id`, `status`) VALUES
(1, 'Szabad'),
(2, 'Foglalt'),
(3, '1'),
(4, 'RoomStatus'),
(5, 'HAHAHAHHAHHAHHHA'),
(6, 'Jajdejó'),
(7, 'fff');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `services`
--

DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `Service_id` int(8) NOT NULL,
  `Service_name` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `services`
--

INSERT INTO `services` (`Service_id`, `Service_name`) VALUES
(1, 'szolgáltatás');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `streets`
--

DROP TABLE IF EXISTS `streets`;
CREATE TABLE IF NOT EXISTS `streets` (
  `Street_id` int(8) NOT NULL,
  `Street_name` varchar(45) NOT NULL,
  `Zipcode_id` int(8) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `streets`
--

INSERT INTO `streets` (`Street_id`, `Street_name`, `Zipcode_id`) VALUES
(1, 'Vízimolnár utca', 1),
(2, 'Ráday utca', 5),
(3, 'Pók utca', 6),
(4, 'Móka utca', 7),
(5, 'ÁÁÁÁÁ', 8),
(6, 'dsgfadhsf', 9),
(7, 'dsgfadhsf', 9);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `zipcodes`
--

DROP TABLE IF EXISTS `zipcodes`;
CREATE TABLE IF NOT EXISTS `zipcodes` (
  `Zipcode_id` int(8) NOT NULL,
  `zipcode` varchar(6) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `zipcodes`
--

INSERT INTO `zipcodes` (`Zipcode_id`, `zipcode`) VALUES
(6, '1025'),
(4, '1031'),
(5, '1092'),
(7, '1111'),
(10, '4865'),
(8, '5555');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`Address_id`);

--
-- A tábla indexei `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`Booking_id`);

--
-- A tábla indexei `booking_status`
--
ALTER TABLE `booking_status`
  ADD PRIMARY KEY (`Booking_status_id`);

--
-- A tábla indexei `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`City_id`),
  ADD UNIQUE KEY `City_name` (`City_name`);

--
-- A tábla indexei `extras`
--
ALTER TABLE `extras`
  ADD PRIMARY KEY (`Extra_id`);

--
-- A tábla indexei `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`Guest_id`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- A tábla indexei `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`Room_id`);

--
-- A tábla indexei `room_status`
--
ALTER TABLE `room_status`
  ADD PRIMARY KEY (`Room_status_id`);

--
-- A tábla indexei `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`Service_id`);

--
-- A tábla indexei `streets`
--
ALTER TABLE `streets`
  ADD PRIMARY KEY (`Street_id`);

--
-- A tábla indexei `zipcodes`
--
ALTER TABLE `zipcodes`
  ADD PRIMARY KEY (`Zipcode_id`),
  ADD UNIQUE KEY `zipcode` (`zipcode`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `addresses`
--
ALTER TABLE `addresses`
  MODIFY `Address_id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT a táblához `bookings`
--
ALTER TABLE `bookings`
  MODIFY `Booking_id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT a táblához `booking_status`
--
ALTER TABLE `booking_status`
  MODIFY `Booking_status_id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT a táblához `cities`
--
ALTER TABLE `cities`
  MODIFY `City_id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT a táblához `extras`
--
ALTER TABLE `extras`
  MODIFY `Extra_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT a táblához `guests`
--
ALTER TABLE `guests`
  MODIFY `Guest_id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT a táblához `rooms`
--
ALTER TABLE `rooms`
  MODIFY `Room_id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT a táblához `room_status`
--
ALTER TABLE `room_status`
  MODIFY `Room_status_id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT a táblához `services`
--
ALTER TABLE `services`
  MODIFY `Service_id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT a táblához `streets`
--
ALTER TABLE `streets`
  MODIFY `Street_id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT a táblához `zipcodes`
--
ALTER TABLE `zipcodes`
  MODIFY `Zipcode_id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
