-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 23, 2017 at 07:16 PM
-- Server version: 5.7.19-0ubuntu0.16.04.1
-- PHP Version: 7.0.22-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `phsample`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `saveprogram` (IN `programname` VARCHAR(100), IN `programdescription` VARCHAR(500), IN `programcategory` VARCHAR(100), IN `imagecode` TEXT, IN `imageurl` TEXT, IN `code` MEDIUMTEXT, IN `exampleoutput` MEDIUMTEXT, IN `difficultylevel` TINYINT(1), IN `input` MEDIUMTEXT, IN `output` MEDIUMTEXT, IN `runnable` VARCHAR(1))  MODIFIES SQL DATA
BEGIN
    
    INSERT INTO program (program_name, program_description, program_category, description_image_base64, description_image_url) values (programname, programdescription, programcategory, imagecode, imageurl);
    
    SET @program_id = LAST_INSERT_ID();
    
    INSERT INTO program_details (lang_id, prog_id, code, exampleoutput, difficultylevel, isrunnable) values (1, @program_id, code, exampleoutput, difficultylevel, runnable);
    
    SET @program_detail_id = LAST_INSERT_ID();
    
    INSERT INTO program_io (prog_id, input, output) VALUES (@program_detail_id, input, output);
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `cat_name` varchar(100) NOT NULL,
  `category_sequence` int(11) NOT NULL,
  `featureid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `cat_name`, `category_sequence`, `featureid`) VALUES
(1, 'Introduction', 0, 1),
(2, 'Basics', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `feature`
--

CREATE TABLE `feature` (
  `id` int(11) NOT NULL,
  `feature_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE `language` (
  `id` int(11) NOT NULL,
  `lang_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`id`, `lang_name`) VALUES
(1, 'Java'),
(2, 'PHP'),
(3, 'HTML'),
(4, 'CSS');

-- --------------------------------------------------------

--
-- Table structure for table `program`
--

CREATE TABLE `program` (
  `id` int(11) NOT NULL,
  `program_name` varchar(100) NOT NULL,
  `program_description` varchar(500) NOT NULL,
  `program_category` int(11) NOT NULL,
  `description_image_base64` varchar(1000) NOT NULL,
  `description_image_url` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `program`
--

INSERT INTO `program` (`id`, `program_name`, `program_description`, `program_category`, `description_image_base64`, `description_image_url`) VALUES
(1, 'First Program', 'First Program Description', 1, '', ''),
(2, 'First Program', 'First Program Description', 1, '', ''),
(3, 'Second Program', 'Second Program Description', 1, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `program_details`
--

CREATE TABLE `program_details` (
  `id` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL,
  `prog_id` int(11) NOT NULL,
  `code` mediumtext NOT NULL,
  `codewithoutcomments` mediumtext,
  `codewithoutlogic` mediumtext,
  `exampleoutput` mediumtext,
  `difficultylevel` int(2) NOT NULL,
  `exampleoutputtype` varchar(100) DEFAULT NULL,
  `isrunnable` char(1) NOT NULL,
  `canbeusedforchallenges` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `program_details`
--

INSERT INTO `program_details` (`id`, `lang_id`, `prog_id`, `code`, `codewithoutcomments`, `codewithoutlogic`, `exampleoutput`, `difficultylevel`, `exampleoutputtype`, `isrunnable`, `canbeusedforchallenges`) VALUES
(1, 1, 1, '12345', NULL, NULL, 'Hello World', 1, NULL, 'Y', NULL),
(2, 1, 2, '12345', NULL, NULL, 'Hello World', 1, NULL, 'Y', NULL),
(3, 1, 3, '<div>Hello</div>', NULL, NULL, 'Hello World', 1, NULL, 'N', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `program_io`
--

CREATE TABLE `program_io` (
  `id` int(11) NOT NULL,
  `prog_id` int(11) NOT NULL,
  `input` varchar(500) NOT NULL,
  `output` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `program_io`
--

INSERT INTO `program_io` (`id`, `prog_id`, `input`, `output`) VALUES
(1, 1, 'echo Hello', 'Hello World'),
(2, 2, 'echo Hello', 'Hello World'),
(3, 3, 'TEst', 'Data');

-- --------------------------------------------------------

--
-- Table structure for table `requesting`
--

CREATE TABLE `requesting` (
  `id` int(11) NOT NULL,
  `versionno` int(11) NOT NULL,
  `client` varchar(50) NOT NULL,
  `appname` varchar(100) NOT NULL,
  `language` varchar(100) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `requesting`
--

INSERT INTO `requesting` (`id`, `versionno`, `client`, `appname`, `language`, `timestamp`) VALUES
(1, 123, 'ios', 'java learn', 'java', '2017-09-23 19:13:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feature`
--
ALTER TABLE `feature`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `program`
--
ALTER TABLE `program`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `program_details`
--
ALTER TABLE `program_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `program_io`
--
ALTER TABLE `program_io`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `requesting`
--
ALTER TABLE `requesting`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `feature`
--
ALTER TABLE `feature`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `language`
--
ALTER TABLE `language`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `program`
--
ALTER TABLE `program`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `program_details`
--
ALTER TABLE `program_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `program_io`
--
ALTER TABLE `program_io`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `requesting`
--
ALTER TABLE `requesting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
