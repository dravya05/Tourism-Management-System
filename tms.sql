-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 20, 2022 at 04:50 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tms`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `costperpersonupdate` ()  UPDATE tblbooking, tbltourpackages 
SET tblbooking.Costperperson = tbltourpackages.PackagePrice
WHERE tblbooking.PackageId = tbltourpackages.PackageId$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalcostupdate` ()  UPDATE tblbooking 
set TotalCost=Costperperson*NoOfPeople$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `updationDate` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `UserName`, `Password`, `updationDate`) VALUES
(1, 'admin', 'f925916e2754e5e03f75dd58a5733251', '2022-01-06 11:18:49');

-- --------------------------------------------------------

--
-- Table structure for table `tblbooking`
--

CREATE TABLE `tblbooking` (
  `BookingId` int(11) NOT NULL,
  `PackageId` int(11) DEFAULT NULL,
  `UserEmail` varchar(100) DEFAULT NULL,
  `FromDate` varchar(100) DEFAULT NULL,
  `ToDate` varchar(100) NOT NULL,
  `Comment` mediumtext DEFAULT NULL,
  `Costperperson` int(11) NOT NULL,
  `NoOfPeople` int(11) NOT NULL,
  `TotalCost` int(11) NOT NULL,
  `RegDate` timestamp NULL DEFAULT current_timestamp(),
  `status` int(11) DEFAULT NULL,
  `CancelledBy` varchar(5) DEFAULT NULL,
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblbooking`
--

INSERT INTO `tblbooking` (`BookingId`, `PackageId`, `UserEmail`, `FromDate`, `ToDate`, `Comment`, `Costperperson`, `NoOfPeople`, `TotalCost`, `RegDate`, `status`, `CancelledBy`, `UpdationDate`) VALUES
(1, 1, 'arya@gmail.com', '2022-01-21', '2022-01-28', 'Refreshment out of city life', 32450, 5, 162250, '2022-01-19 20:24:49', 0, NULL, '2022-01-19 20:24:49'),
(2, 2, 'alia@gmail.com', '2022-01-23', '2022-01-27', 'Refreshment out of city life', 25000, 6, 150000, '2022-01-19 20:29:28', 0, NULL, '2022-01-19 20:29:29'),
(3, 3, 'vidya@gmail.com', '2022-02-09', '2022-02-12', 'Traveling in the toy train ', 31680, 3, 95040, '2022-01-19 20:30:54', 0, NULL, '2022-01-19 20:30:54'),
(4, 4, 'amar@gmail.com', '2022-03-08', '2022-03-13', 'Sightseeing', 30000, 4, 120000, '2022-01-19 20:32:51', 0, NULL, '2022-01-19 20:32:51'),
(5, 5, 'ajith@gmail.com', '2022-02-21', '2022-02-24', 'Exploring the magnificent monuments', 17500, 3, 52500, '2022-01-19 20:34:40', 0, NULL, '2022-01-19 20:34:41'),
(6, 4, 'vidya@gmail.com', '2022-03-07', '2022-03-12', 'Nature sightseeing', 30000, 5, 150000, '2022-01-20 13:47:28', 0, NULL, '2022-01-20 13:47:28'),
(9, 4, 'alia@gmail.com', '2022-04-12', '2022-04-17', 'Nature sightseeing', 30000, 2, 60000, '2022-01-20 14:52:11', 0, NULL, '2022-01-20 14:52:13');

--
-- Triggers `tblbooking`
--
DELIMITER $$
CREATE TRIGGER `datetrig` AFTER INSERT ON `tblbooking` FOR EACH ROW BEGIN
    IF (NEW.FromDate < now()) THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Warning: From Date is less than today!!!';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblenquiry`
--

CREATE TABLE `tblenquiry` (
  `id` int(11) NOT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  `EmailId` varchar(100) DEFAULT NULL,
  `MobileNumber` char(10) DEFAULT NULL,
  `Subject` varchar(100) DEFAULT NULL,
  `Description` mediumtext DEFAULT NULL,
  `PostingDate` timestamp NULL DEFAULT current_timestamp(),
  `Status` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblenquiry`
--

INSERT INTO `tblenquiry` (`id`, `FullName`, `EmailId`, `MobileNumber`, `Subject`, `Description`, `PostingDate`, `Status`) VALUES
(1, 'Ajith Shetty', 'ajith@gmail.com', '9032145678', 'Regarding Food', 'Will the food be hygienic ? Can we bring some of our own snacks?', '2022-01-20 14:17:31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tblissues`
--

CREATE TABLE `tblissues` (
  `id` int(11) NOT NULL,
  `UserEmail` varchar(100) DEFAULT NULL,
  `Issue` varchar(100) DEFAULT NULL,
  `Description` mediumtext DEFAULT NULL,
  `PostingDate` timestamp NULL DEFAULT current_timestamp(),
  `AdminRemark` mediumtext DEFAULT NULL,
  `AdminremarkDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblissues`
--

INSERT INTO `tblissues` (`id`, `UserEmail`, `Issue`, `Description`, `PostingDate`, `AdminRemark`, `AdminremarkDate`) VALUES
(1, 'ajith@gmail.com', 'Booking Issues', 'The amount is debited from account but it shows payment pending in the website', '2022-01-20 14:21:10', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tblpages`
--

CREATE TABLE `tblpages` (
  `id` int(11) NOT NULL,
  `type` varchar(255) DEFAULT '',
  `detail` longtext DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tblpages`
--

INSERT INTO `tblpages` (`id`, `type`, `detail`) VALUES
(1, 'Terms', '<P align=justify><FONT size=2><STRONG><FONT color=#000000>The Booking:<br>\r\nYour contract is with New World Travel. A contract exists between us when we have confirmed you on our tour of your choice and we have received your signed booking form and deposits. All the relevant section must be correctly and fully completed. We can only accept booking form signed as this confirms that you and other people on the tour accept our booking terms and condition and are entering into the contract.\r\n<br><br>\r\nPayments:<br>\r\nFor the services contracted, 50% advance payment should be made to hold the booking on a confirmed basis and the balance amount can be paid at least 7 days prior to your date of departure from your country. We hold the right to decide upon the amount to be paid as an advance payment, based on the nature of services and the time left for the commencement of the services. Apart from the above in some cases like special train journeys, hotel or resort bookings during the peak season (X-Mas, New Year) full payment is required to be sent in advance.\r\n<br><br>\r\nCancellations:<br>\r\nIf you or any member of your party wishes to cancel your holiday, you must notify us in writing, in any case the date of cancellation will be at the date on which notice is received by New World Travel. As this incurs administrative cost and retention charges by hotel, the cancellation charges will apply on the following scale:<br>\r\n30 days or more 50% of Deposit<br>\r\n15 – 30 days 100% of Deposit<br>\r\n8 – 15 days 80% of Tour Cost<br>\r\n1 – 7 days 100% of Tour Cost<br>\r\n<br>\r\nResponsibilities:<br>\r\na) The Company does not own or manage the aircraft, accommodation, restaurants and other facilities used in conjunction with the tours arranged. While the Company has exercised care in selecting providers of travel, accommodation, restaurants and other facilities, the Company have not had the opportunity to inspect and do not represent that such aircraft, accommodation, restaurants, and other facilities and services have been inspected.<br>\r\nb) The Company is not responsible if you or any member of your party suffer death, illness or injury as a result of any failure to perform or improper performance of any part of our contract with you where such failure is attributable to (i) the acts and/or omissions of any member of the party, or (ii) those of a third party not connected with the provision of your holiday, or (iii) an event which neither the Company or the service provider could have foreseen or prevented even with due care.<br>\r\nc) Should any member of your party suffer illness, injury or death through misadventure arising out of an activity, which does not form part of the holiday the Company has arranged for you the Company cannot accept liability. The Company will offer general assistance where appropriate.<br>\r\nd) The Company regret that no refund will be made on unused tickets where travel, sporting event or other types of ticket, unless a refund can be obtained from the carrier or provider.<br>\r\ne) All equipment and personal effects shall be all times and in all circumstances at the owner’s risk. The Company cannot accept responsibility for any loss or damage or delay to your luggage or effects unless directly caused by the negligence of one of our representatives.</FONT></P>'),
(2, 'Aboutus', '										<span style=\"color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;\">“Travel is the main thing you purchase that makes you more extravagant”. We, at ‘New World Travel’, swear by this and put stock in satisfying travel dreams that make you perpetually rich constantly.<br><br>\r\nWe have been moving excellent encounters for a considerable length of time through our cutting-edge planned occasion bundles and other fundamental travel administrations. We rouse our clients to carry on with a rich life, brimming with extraordinary travel encounters.<br><br>\r\nTo guarantee that you have a satisfying occasion and healthy encounters, all our vacation administrations are available to your no matter what. On your universal occasion, we guarantee that you are very much outfitted with outside trade, visa, and travel protection.<br><br>\r\nWe offer the best limits on our top-rated visit bundles to clients who pick our viable administrations over and over. How about we remind you indeed that we don’t expect to be your visit and travel specialists; we endeavor to be your vacation accomplices until the end of time.<br><br>\r\n-By <br>\r\n1.Deethya J Reddy (1RN19IS055)<br>\r\n2.Dravyashree M (1RN19IS059)<br>\r\n</span>'),
(3, 'Contact', '										<span style=\"color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;\">Mob :+91 8618697092<br>Tel : 080-28482876<br>Email-id : newworldtravel@gmail.com</span>');

-- --------------------------------------------------------

--
-- Table structure for table `tbltourpackages`
--

CREATE TABLE `tbltourpackages` (
  `PackageId` int(11) NOT NULL,
  `PackageName` varchar(200) DEFAULT NULL,
  `PackageType` varchar(150) DEFAULT NULL,
  `PackageLocation` varchar(100) DEFAULT NULL,
  `PackagePrice` varchar(75) DEFAULT NULL,
  `PackageFeatures` varchar(255) DEFAULT NULL,
  `PackageDetails` mediumtext DEFAULT NULL,
  `PackageImage` varchar(100) DEFAULT NULL,
  `Creationdate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbltourpackages`
--

INSERT INTO `tbltourpackages` (`PackageId`, `PackageName`, `PackageType`, `PackageLocation`, `PackagePrice`, `PackageFeatures`, `PackageDetails`, `PackageImage`, `Creationdate`, `UpdationDate`) VALUES
(1, 'Uttarakhand - Rivers, Lakes and Corbett National Park', 'Family ', 'Uttarakhand , India', '32450 ', 'Five star accomodation , Rafting , Safari  , Breakfast/Lunch/Snacks/Dinner included', '8N/9D   \r\n\r\n1N Haridwar 1N Rishikesh 2N Mussoorie 2N Corbett 2N Nainital\r\n\r\nSightseeing in Haridwar - \r\n•Har Ki Pauri\r\n\r\nSightseeing in Rishikesh -\r\n•Laxman Jhula\r\n•Bharat Mandir\r\n•Rafting : Brahampuri To Ram Jhula (Shortest - 8 Kms)\r\n\r\nSightseeing in Mussoorie - \r\n•Jwalaji Temple\r\n•Mall road\r\n•Lake Mist\r\n•Kempty Falls\r\nCorbett National Park - Jeep Safari\r\n\r\nSightseeing in Nainital - \r\n•Nainital Zoo\r\n•Eco Cave Garden\r\n•Naina devi Temple\r\n•Mall road\r\n•Naini Lake\r\n\r\nAccomodation:\r\nHotel Alpana @ Har ki Pauri Road \r\nThe Hideaway Bedzzz\' Rishikesh By Leisure Hotels\r\nAmara Hill Queen \r\nTejomaya Jungle Retreat\r\nSwiss Cottage\r\n\r\nTravel:\r\nFlight to Dehradun\r\nLocal transport for sightseeing \r\n\r\n*-Includes taxes,flight charges,etc\r\n', 'uttarakhand-640.jpg', '2022-01-13 14:31:44', '2022-01-19 16:44:24'),
(2, 'Goa Special', 'Family and Friends', 'Goa ,India', '25000 ', 'Flights, Sightseeing , Transfers , Breakfast/Lunch/Snacks/Dinner included ', '4N/5D \r\n\r\nNorth Goa Sightseeing with Private Transfers -\r\n•Dolphin Trip\r\n•Evening Mandovi River Cruise\r\n\r\nSouth Goa Sightseeing (Private Transfers) -\r\n•Pristine beaches, Portuguese architecture, shopping and the old world charm - South Goa offers it all Visit Shree Manguesh Temple, Old Goa Churches - Ce Cathedral and Basilica of Bom Jesus, Dona Paula and Miramar Beach.\r\n\r\nEnjoy shopping at Panjim.\r\n\r\nAccomodation:\r\nKyriad Prestige Calangute Goa.\r\n\r\nTravel:\r\nFlight to Goa\r\n\r\n*-Includes Flight charges,accomodation,etc', 'download (3).jpeg', '2021-10-12 15:24:26', '2022-01-19 16:45:31'),
(3, 'Trip to Darjeeling - Experience a Heritage Toy Train', 'Family & Couple', 'Darjeeling , India', '31680 ', 'Five star accomodation , Breakfast/Lunch/Snacks/Dinner included', '3N/4D \r\n\r\nSightseeing in Darjeeling:\r\n•Tiger Hill\r\n•Himalayan Mountaineering Institute\r\n•Himalayan Zoological park\r\n•Peace Pagoda\r\n•Tibetan Refugee Centre\r\n•Tezing Rock\r\n•Gombu Rock\r\n•Happy valley Tea Estate\r\n•Toy Train Ride in Darjeeling - A UNESCO World Heritage Site, a Toy Train Ride in Darjeeling is an exciting experience. As you reach the railway station, collect your tickets and hop into the train for a joyful ride. Enjoy a wonderful time on an exciting ride and complete your experience feeling delightful.\r\n•Mirik - A two-hour drive away from Siliguri, Mirik is a small tourist point located in the hills of Darjeeling. The drive to Mirik is extremely scenic and cuts through lush tea gardens and mountain landscapes. The main attraction of Mirik is Sumendu lake, an ideal place to enjoy boating and long walks. Ramitey Dandra, a famous sightseeing point in Mirik, is known for offering a picturesque view of snow-capped Kanchenjunga.\r\n\r\nAccomodation: \r\nSilver Star Boutique Hotel by Sumi Yashshree.\r\n\r\nTravel:\r\nFlight to Bagdogra.\r\n\r\n*-Includes Flight charges , accomodation ,etc', 'download4.jpeg', '2021-11-23 16:00:58', '2022-01-19 16:46:46'),
(4, 'Exotic Kerala Trip', 'Family and Couple', 'Kerala , India', '30000 ', 'Relax in a hotel/houseboat with a picturesque view , Five star Accomodation', '5N/6D 1N Cochin 2N Munnar 1N Thekkady 1N Allepey\r\n\r\nSightseeing in Cochin\r\n•Fort Cochin\r\n•Jewish Synagogue\r\n•Dutch Palace\r\n•St. Francis Church\r\n•Chinese Fishing Nets\r\n\r\nSightseeing in Munnar\r\n•Valara Waterfalls\r\n•Tata Tea Museum\r\n•Eravikulam national park\r\n•Mattupetty Dam\r\n•Echo Point\r\n\r\nEvening Tea and Snacks at Karadippara Viewpoint with Private Transfers- Enjoy watching a beautiful sunset with delicious snacks at the famous Karadippara Viewpoint. You will be picked up in the evening from the hotel in Munnar in a private vehicle to embark on a scenic drive. A steaming bowl of your favorite instant noodles with a hot cup of tea will add a streak of flavor to your rendezvous with nature.\r\n\r\nSightseeing in Thekkady\r\n•Chillies Spice Garden\r\n•Periyar Lake\r\n•Periyar Wildlife Sanctuary\r\n\r\nTea Factory Visit with Tea Tasting Plantation walk\r\n\r\nSightseeing in Allepey\r\n•Alappuzha Beach\r\n•Mullakkal Rajarajeswari Temple\r\n\r\nAccomodation:\r\nDiana Heights \r\nSouthern Panorama Indriya Resorts\r\nThe Mountain Courtyard Thekkady\r\nUday Backwater Resort.\r\n\r\nTravel:\r\nFlight to Cochin.\r\n\r\n*-Includes Flight charges , accomodation ,etc', 'images.jpg', '2021-11-11 22:39:37', '2022-01-19 16:47:55'),
(5, 'Historical Jaipur - Land of Maharajas !', 'Family & Couple', 'Jaipur , India', '17500 ', ' Bhangarh Excursion, Camel ride , Five star accomodation , Breakfast/Lunch/Snacks/Dinner included', '3N/4D \r\n\r\nSightseeing in Jaipur:\r\n•Hawa Mahal\r\n•City Palace\r\n•Jantar Mantar\r\n•Amer Fort\r\n•Jaipur Desert Safari\r\nDay Trip to Bhangarh from Jaipur - for upto 4 Pax - Enjoy a full-day excursion to Bhangarh from Jaipur.\r\n\r\nAccomodation:\r\nRatnawali A Vegetarian Heritage Hotel \r\n\r\nTravel: \r\nFlight to Jaipur\r\n\r\n*-Includes Flight charges,Accomodation,etc', 'download (3.jpeg', '2021-12-11 22:42:10', '2022-01-19 16:48:28'),
(6, 'Shimla and Manali Trip', 'Family and Couple', 'Shimla , Manali , India', ' 46900', 'Open Air Lunch, Five star accomodation ', '7N/8D 1N New Delhi 2N Shimla 3N Manali 1N Chandigarh\r\n\r\nSightseeing in New Delhi\r\n•Qutab Minar\r\n•Lotus Temple\r\n•India Gate\r\n\r\nSightseeing in Shimla\r\n•Pinjore Gardens\r\n•Kufri\r\n•Indira Bunglow\r\n\r\nSightseeing in Manali\r\n•Pandoh Dam\r\n•Solang Valley\r\n•Romantic Open Air Lunch by River Beas - Spend a memorable time with your loved one near River Beas in Manali. A private table will be set up for you two, at the location overlooking the Beas river. Sit back and relax, savour a delicious lunch and enjoy beautiful moments of togetherness.The serene atmosphere and an ideal setting will add to the whole experience of dining at a riverside.\r\n•Hadimba Temple\r\n•Tibetan Monastery\r\n•Vashishth Kund\r\n\r\nSightseeing in Chandigarh\r\n•Rock Garden\r\n•Rose Garden\r\n\r\nAccomodation:\r\nLemon Tree Premier Delhi Airport, New Delhi \r\nKamna Hill Resort, Shimla\r\nThe Holiday Resorts, Cottages & Spa, Manali\r\nRegenta Central Cassia, Chandigarh\r\n\r\nTravel:\r\nFlight to New Delhi\r\n\r\n*-Includes Flight charges, Accomodation ,etc', 'download3).jpeg', '2021-12-22 08:01:08', '2022-01-19 16:49:21');

-- --------------------------------------------------------

--
-- Table structure for table `tblusers`
--

CREATE TABLE `tblusers` (
  `id` int(11) NOT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  `MobileNumber` char(10) DEFAULT NULL,
  `EmailId` varchar(70) DEFAULT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblusers`
--

INSERT INTO `tblusers` (`id`, `FullName`, `MobileNumber`, `EmailId`, `Password`, `RegDate`, `UpdationDate`) VALUES
(1, 'Arya Bhat', '9876543210', 'arya@gmail.com', '5882985c8b1e2dce2763072d56a1d6e5', '2022-01-14 16:44:22', NULL),
(2, 'Alia Sen', '9012345678', 'alia@gmail.com', '86c8c6c90abd00c209e39736da1ec1fd', '2022-01-14 16:45:01', NULL),
(3, 'Vidya Singh', '9786543201', 'vidya@gmail.com', '4dc13c8aa6371cbcb715d66f351ca293', '2022-01-14 16:45:57', NULL),
(4, 'Amar Verma', '9102345678', 'amar@gmail.com', '36341cbb9c5a51ba81e855523de49dfd', '2022-01-14 16:46:37', NULL),
(5, 'Ajith Shetty', '9032145678', 'ajith@gmail.com', '9e423cca0e2efab9aa09a13c778a8ced', '2022-01-14 16:47:33', NULL),
(6, NULL, NULL, NULL, 'd41d8cd98f00b204e9800998ecf8427e', '2022-01-20 14:21:10', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblbooking`
--
ALTER TABLE `tblbooking`
  ADD PRIMARY KEY (`BookingId`),
  ADD KEY `foreign key 1` (`PackageId`);

--
-- Indexes for table `tblenquiry`
--
ALTER TABLE `tblenquiry`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblissues`
--
ALTER TABLE `tblissues`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblpages`
--
ALTER TABLE `tblpages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbltourpackages`
--
ALTER TABLE `tbltourpackages`
  ADD PRIMARY KEY (`PackageId`);

--
-- Indexes for table `tblusers`
--
ALTER TABLE `tblusers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `EmailId` (`EmailId`),
  ADD KEY `EmailId_2` (`EmailId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblbooking`
--
ALTER TABLE `tblbooking`
  MODIFY `BookingId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tblenquiry`
--
ALTER TABLE `tblenquiry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblissues`
--
ALTER TABLE `tblissues`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblpages`
--
ALTER TABLE `tblpages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbltourpackages`
--
ALTER TABLE `tbltourpackages`
  MODIFY `PackageId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tblusers`
--
ALTER TABLE `tblusers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblbooking`
--
ALTER TABLE `tblbooking`
  ADD CONSTRAINT `foreign key 1` FOREIGN KEY (`PackageId`) REFERENCES `tbltourpackages` (`PackageId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
