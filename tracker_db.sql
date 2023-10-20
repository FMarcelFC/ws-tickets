-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 31, 2023 at 07:13 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tracker_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_user` (IN `p_id` VARCHAR(255), IN `p_name` VARCHAR(255), IN `p_first_name` VARCHAR(255), IN `p_last_name` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_password` VARCHAR(255), IN `p_phone` VARCHAR(20), IN `p_picture` VARCHAR(255), IN `p_id_profile` INT, IN `p_id_gender` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @message_text = MESSAGE_TEXT;
        
        ROLLBACK;
        
        SELECT @errno AS errno, @message_text AS msg;
    END;

    START TRANSACTION;
    BEGIN
        INSERT INTO tbl_users(id, name, first_name, last_name, email, password, phone, picture, id_gender)
        VALUES (p_id, p_name, p_first_name, p_last_name, p_email, p_password, p_phone, p_picture, p_id_gender);

        INSERT INTO user_profile(id_user, id_profile)
        VALUES (p_id, p_id_profile);

        SELECT 'Registro insertado' AS msg;
    END;
    COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_category`
--

CREATE TABLE `tbl_category` (
  `id` int(11) NOT NULL,
  `category` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_category`
--

INSERT INTO `tbl_category` (`id`, `category`) VALUES
(1, 'Security'),
(2, 'Interface'),
(3, 'Backend');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_gender`
--

CREATE TABLE `tbl_gender` (
  `id` int(255) NOT NULL,
  `gender` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_gender`
--

INSERT INTO `tbl_gender` (`id`, `gender`) VALUES
(1, 'Male'),
(2, 'Female');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_module`
--

CREATE TABLE `tbl_module` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `page` varchar(255) NOT NULL,
  `icon` varchar(128) NOT NULL,
  `order` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_module`
--

INSERT INTO `tbl_module` (`id`, `name`, `page`, `icon`, `order`, `status`) VALUES
(1, 'Home', 'home.html', 'home', 1, 1),
(2, 'Profile', 'profile.html', 'person', 2, 1),
(3, 'Reports', 'reports.html', 'book', 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_plataform`
--

CREATE TABLE `tbl_plataform` (
  `id` int(11) NOT NULL,
  `plataform` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_plataform`
--

INSERT INTO `tbl_plataform` (`id`, `plataform`) VALUES
(1, 'Windows'),
(2, 'Mac'),
(3, 'Linux');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_profile`
--

CREATE TABLE `tbl_profile` (
  `id` int(11) NOT NULL,
  `profile` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_profile`
--

INSERT INTO `tbl_profile` (`id`, `profile`, `status`) VALUES
(1, 'admin', 1),
(2, 'developer', 1),
(3, 'client', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_profile_module`
--

CREATE TABLE `tbl_profile_module` (
  `id_profile` int(11) NOT NULL,
  `id_module` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_profile_module`
--

INSERT INTO `tbl_profile_module` (`id_profile`, `id_module`) VALUES
(1, 1),
(1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_register`
--

CREATE TABLE `tbl_register` (
  `id` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `percentage` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_severity`
--

CREATE TABLE `tbl_severity` (
  `id` int(11) NOT NULL,
  `severity` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_severity`
--

INSERT INTO `tbl_severity` (`id`, `severity`) VALUES
(1, 'High'),
(2, 'Medium'),
(3, 'Low');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_status`
--

CREATE TABLE `tbl_status` (
  `id` int(11) NOT NULL,
  `status` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_status`
--

INSERT INTO `tbl_status` (`id`, `status`) VALUES
(1, 'New'),
(2, 'Assigned'),
(3, 'Accepted'),
(4, 'Confirmed'),
(5, 'Rejected'),
(6, 'In progress'),
(7, 'Resolved');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_system`
--

CREATE TABLE `tbl_system` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `id_plataform` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_system`
--

INSERT INTO `tbl_system` (`id`, `name`, `id_plataform`) VALUES
(1, 'System A', 1),
(2, 'System B', 2),
(3, 'System C', 3);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_tickets`
--

CREATE TABLE `tbl_tickets` (
  `id` varchar(255) NOT NULL,
  `id_status` int(11) NOT NULL,
  `id_category` int(11) NOT NULL,
  `id_severity` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `last_update` datetime NOT NULL,
  `id_dev` varchar(255) NOT NULL,
  `id_user` varchar(255) NOT NULL,
  `id_system` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `id_register` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `picture` varchar(255) NOT NULL,
  `id_gender` int(11) NOT NULL,
  `register_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `name`, `first_name`, `last_name`, `status`, `email`, `password`, `phone`, `picture`, `id_gender`, `register_date`) VALUES
('202308212046363ttWh8p8mJrUnHgxZM', 'Freddy', 'Flores', 'Chavarria', 1, 'freddy@mail.com', 'pbkdf2:sha256:600000$0YJBVVjVEXlhZN6ABqRPVqi9seDvMM$98bbc3bceafd6ca6694ec3d66ca0dda940a1f177d17c0c7fff2a4cf1b546cec2', '5587237022', 'test.jpg', 1, '2023-08-30 22:09:53'),
('20230830222956ecfjBd29OjGqmmcqWn', 'Saul', 'Suarez', 'Smerlinder', 1, 'saul@mail.com', 'pbkdf2:sha256:600000$noOza5D55O4DOg5V0GU9ohmX2OB6Od$f045e55d0ea5dd96bad0347bb3f1eed4bddd675c66b289bdd227ec633d090121', '2398472986', 'test.jpg', 1, '2023-08-30 22:29:56'),
('20230830230852ss0HCw9ur5jx5RXuyv', 'Edwin', 'Vasquez', 'Crackdona', 1, 'edwin@mail.com', 'pbkdf2:sha256:600000$Pc8dn6IrFi8SHopL7GUAyOMBEkINfV$ac425b2d0659001b804d3a6baa84f8dea3541f625a20ab69eb0f8476dae0408b', '1234567890', 'test.jpg', 1, '2023-08-30 23:08:52');

-- --------------------------------------------------------

--
-- Table structure for table `user_profile`
--

CREATE TABLE `user_profile` (
  `id_user` varchar(255) NOT NULL,
  `id_profile` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_profile`
--

INSERT INTO `user_profile` (`id_user`, `id_profile`) VALUES
('202308212046363ttWh8p8mJrUnHgxZM', 1),
('20230830230852ss0HCw9ur5jx5RXuyv', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_category`
--
ALTER TABLE `tbl_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_gender`
--
ALTER TABLE `tbl_gender`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_module`
--
ALTER TABLE `tbl_module`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_plataform`
--
ALTER TABLE `tbl_plataform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_profile`
--
ALTER TABLE `tbl_profile`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_profile_module`
--
ALTER TABLE `tbl_profile_module`
  ADD KEY `id_profile` (`id_profile`),
  ADD KEY `id_module` (`id_module`);

--
-- Indexes for table `tbl_register`
--
ALTER TABLE `tbl_register`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_severity`
--
ALTER TABLE `tbl_severity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_status`
--
ALTER TABLE `tbl_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_system`
--
ALTER TABLE `tbl_system`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_plataform` (`id_plataform`);

--
-- Indexes for table `tbl_tickets`
--
ALTER TABLE `tbl_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_status` (`id_status`),
  ADD KEY `id_category` (`id_category`),
  ADD KEY `id_severity` (`id_severity`),
  ADD KEY `id_dev` (`id_dev`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_system` (`id_system`),
  ADD KEY `id_register` (`id_register`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_gender` (`id_gender`);

--
-- Indexes for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_profile` (`id_profile`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_category`
--
ALTER TABLE `tbl_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_gender`
--
ALTER TABLE `tbl_gender`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_module`
--
ALTER TABLE `tbl_module`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_plataform`
--
ALTER TABLE `tbl_plataform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_profile`
--
ALTER TABLE `tbl_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_severity`
--
ALTER TABLE `tbl_severity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_status`
--
ALTER TABLE `tbl_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_system`
--
ALTER TABLE `tbl_system`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_profile_module`
--
ALTER TABLE `tbl_profile_module`
  ADD CONSTRAINT `fk_module_profile` FOREIGN KEY (`id_profile`) REFERENCES `tbl_profile` (`id`),
  ADD CONSTRAINT `fk_profile_module` FOREIGN KEY (`id_module`) REFERENCES `tbl_module` (`id`);

--
-- Constraints for table `tbl_register`
--
ALTER TABLE `tbl_register`
  ADD CONSTRAINT `tbl_register_ibfk_1` FOREIGN KEY (`id`) REFERENCES `tbl_tickets` (`id_register`);

--
-- Constraints for table `tbl_system`
--
ALTER TABLE `tbl_system`
  ADD CONSTRAINT `tbl_system_ibfk_1` FOREIGN KEY (`id_plataform`) REFERENCES `tbl_plataform` (`id`);

--
-- Constraints for table `tbl_tickets`
--
ALTER TABLE `tbl_tickets`
  ADD CONSTRAINT `tbl_tickets_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_2` FOREIGN KEY (`id_status`) REFERENCES `tbl_status` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_3` FOREIGN KEY (`id_category`) REFERENCES `tbl_category` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_4` FOREIGN KEY (`id_severity`) REFERENCES `tbl_severity` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_5` FOREIGN KEY (`id_system`) REFERENCES `tbl_system` (`id`);

--
-- Constraints for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD CONSTRAINT `tbl_users_ibfk_1` FOREIGN KEY (`id_gender`) REFERENCES `tbl_gender` (`id`);

--
-- Constraints for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD CONSTRAINT `user_profile_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id`),
  ADD CONSTRAINT `user_profile_ibfk_2` FOREIGN KEY (`id_profile`) REFERENCES `tbl_profile` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
