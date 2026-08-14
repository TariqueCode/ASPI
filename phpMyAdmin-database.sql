-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 14, 2026 at 10:01 PM
-- Server version: 10.11.16-MariaDB
-- PHP Version: 8.4.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pachanda_aspi`
--

-- --------------------------------------------------------

--
-- Table structure for table `admissions`
--

CREATE TABLE `admissions` (
  `id` int(11) NOT NULL,
  `student_name` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `course_type` varchar(50) DEFAULT NULL,
  `course_name` varchar(255) DEFAULT NULL,
  `ssc_gpa` varchar(10) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admissions`
--

INSERT INTO `admissions` (`id`, `student_name`, `phone`, `course_type`, `course_name`, `ssc_gpa`, `is_read`, `created_at`) VALUES
(1, 'Muhammad Saiful Islam', '01613723666', 'diploma', 'কম্পিউটার সায়েন্স অ্যান্ড টেকনোলজি', '5.00', 1, '2026-08-13 15:16:34');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `level` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `type`, `title`, `level`) VALUES
(71, 'nsda', 'অটোক্যাড 2D & 3D', 'লেভেল - ৩'),
(72, 'nsda', 'ইলেকট্রিক্যাল ইন্সটলেশন এন্ড মেইনটেন্যান্স', 'লেভেল - ২'),
(73, 'nsda', 'গ্রাফিক্স ডিজাইন ফর ফ্রিল্যান্সিং', 'লেভেল - ৩'),
(74, 'nsda', 'গ্রাফিক্স ডিজাইন', 'লেভেল - ৩'),
(75, 'nsda', 'কম্পিউটার অপারেশন', 'লেভেল - ৩'),
(76, 'diploma', 'ইলেকট্রিক্যাল টেকনোলজি', '৪ বছর'),
(77, 'diploma', 'কম্পিউটার সায়েন্স অ্যান্ড টেকনোলজি', '৪ বছর');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `file_url` varchar(255) DEFAULT NULL,
  `showInMarquee` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `name`, `designation`, `message`, `image_url`) VALUES
(15, 'আফনান ইসলাম', 'চেয়ারম্যান - আসহাব সিরাজ ফাউন্ডেশন', '“আধুনিক প্রযুক্তি ও বাস্তবভিত্তিক শিক্ষার সমন্বয়ে শিক্ষার্থীদের যোগ্য ও কর্মদক্ষ করে গড়ে তোলাই আমাদের প্রত্যয়। একটি দক্ষ ও সমৃদ্ধ সমাজ বিনির্মাণে আসহাব সিরাজ পলিটেকনিক ইনস্টিটিউট গুরুত্বপূর্ণ ভূমিকা রাখবে—ইনশাআল্লাহ।”', 'assets/uploads/1786632189_4076.jpg'),
(16, ' নুরুল ইসলাম', 'সভাপতি', '“মানসম্মত কারিগরি শিক্ষার মাধ্যমে দক্ষ, সুশিক্ষিত ও নৈতিক মানবসম্পদ গড়ে তোলাই আমাদের মূল লক্ষ্য। শিক্ষার্থীদের সম্ভাবনাকে বিকশিত করে তাদের আত্মনির্ভরশীল ভবিষ্যৎ গড়ার পথ সুগম করতে আমরা প্রতিশ্রুতিবদ্ধ।”', 'assets/uploads/1786632160_7795.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `notices`
--

CREATE TABLE `notices` (
  `id` int(11) NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT 'সাধারণ',
  `title` varchar(255) DEFAULT NULL,
  `file_url` varchar(255) DEFAULT NULL,
  `isNew` tinyint(1) DEFAULT 0,
  `showInMarquee` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notices`
--

INSERT INTO `notices` (`id`, `date`, `category`, `title`, `file_url`, `isNew`, `showInMarquee`) VALUES
(11, '১০ আগস্ট, ২০২৬', 'সাধারণ', 'ডিপ্লোমা ইন ইঞ্জিনিয়ারিং-এ ভর্তি বিজ্ঞপ্তি', 'assets/uploads/1786630738_9875.png', 1, 1),
(12, '১০ আগস্ট, ২০২৬', 'সাধারণ', 'NSDA শর্ট কোর্সে - ভর্তি বিজ্ঞপ্তি', 'assets/uploads/1786630823_7175.png', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `setting_key` varchar(50) NOT NULL,
  `setting_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`setting_key`, `setting_value`) VALUES
('address', 'দক্ষিণ হাশিমপুর (জামিরজুরী রাস্তার মাথা), দোহাজারী, চন্দনাইশ, চট্টগ্রাম'),
('admissionNotice', ''),
('admissionOpen', '0'),
('custom_font', 'assets/uploads/1786621310_3881.ttf'),
('email', 'ctgaspi@gmail.com'),
('font_size', '16'),
('logo', 'assets/uploads/1786630227_1784.png'),
('phone', '+৮৮০ ১৮৪৭-৩১০৩১০'),
('principal_img', ''),
('principal_msg', 'কারিগরি শিক্ষায় শিক্ষিত জাতিই পারে দেশের প্রকৃত উন্নয়ন সাধন করতে। আধুনিক প্রযুক্তিনির্ভর শিক্ষায় আমরা বদ্ধপরিকর।');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `deg` varchar(100) DEFAULT NULL,
  `dept` varchar(100) DEFAULT NULL,
  `file_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admissions`
--
ALTER TABLE `admissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notices`
--
ALTER TABLE `notices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admissions`
--
ALTER TABLE `admissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `notices`
--
ALTER TABLE `notices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
