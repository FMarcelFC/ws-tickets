-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Nov 17, 2023 at 06:58 PM
-- Server version: 8.1.0
-- PHP Version: 8.2.11

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

        INSERT INTO tbl_user_profile(id_user, id_profile)
        VALUES (p_id, p_id_profile);

        SELECT 0 AS errno, 'Registro insertado' AS msg;
    END;
    COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_category`
--

CREATE TABLE `tbl_category` (
  `id` int NOT NULL,
  `category` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
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
  `id` int NOT NULL,
  `gender` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
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
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `page` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `icon` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `order` int NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_module`
--

INSERT INTO `tbl_module` (`id`, `name`, `page`, `icon`, `order`, `status`) VALUES
(1, 'Home', '/home', 'home', 1, 1),
(2, 'Profile', '/profile', 'person', 2, 1),
(3, 'Reports', '/reports', 'book', 4, 1),
(4, 'Tickets', '/tickets', 'confirmation_number', 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_platform`
--

CREATE TABLE `tbl_platform` (
  `id` int NOT NULL,
  `platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_platform`
--

INSERT INTO `tbl_platform` (`id`, `platform`) VALUES
(1, 'Windows'),
(2, 'Mac'),
(3, 'Linux');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_profile`
--

CREATE TABLE `tbl_profile` (
  `id` int NOT NULL,
  `profile` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
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
  `id_profile` int NOT NULL,
  `id_module` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_profile_module`
--

INSERT INTO `tbl_profile_module` (`id_profile`, `id_module`) VALUES
(1, 1),
(1, 2),
(1, 3),
(3, 1),
(2, 4),
(1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_register`
--

CREATE TABLE `tbl_register` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `percentage` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_register`
--

INSERT INTO `tbl_register` (`id`, `description`, `percentage`) VALUES
('202308212046363ttWh9p8mJrUnHgxZF', 'Updated some features to solve the ticket.', '55%');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_scan`
--

CREATE TABLE `tbl_scan` (
  `id` int NOT NULL,
  `info` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `type` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_scan`
--

INSERT INTO `tbl_scan` (`id`, `info`, `type`) VALUES
(1, 'https://stackoverflow.com/', 1),
(2, 'https://app.quicktype.io/', 1),
(3, 'WIFI:T:WPA;S:Hola;P:hola1234567;H:;;', 0),
(4, 'WIFI:T:WPA;S:Hola;P:hola1234567;H:;;', 0),
(5, 'WIFI:T:WPA;S:Hola;P:hola1234567;H:;;', 0),
(6, 'WIFI:T:WPA;S:Hola;P:hola1234567;H:;;', 0),
(7, 'WIFI:T:WPA;S:Hola;P:hola1234567;H:;;', 0),
(8, 'WIFI:T:WPA;S:Hola;P:hola1234567;H:;;', 0),
(9, 'WIFI:T:WPA;S:Hola;P:hola1234567;H:;;', 0),
(10, 'https://github.com/', 1),
(11, 'WIFI:T:WPA;S:Hola;P:hola1234567;H:;;', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_severity`
--

CREATE TABLE `tbl_severity` (
  `id` int NOT NULL,
  `severity` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
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
  `id` int NOT NULL,
  `status` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
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
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `id_platform` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_system`
--

INSERT INTO `tbl_system` (`id`, `name`, `id_platform`) VALUES
(1, 'System A', 1),
(2, 'System B', 2),
(3, 'System C', 3);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_tickets`
--

CREATE TABLE `tbl_tickets` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `id_status` int NOT NULL,
  `id_category` int NOT NULL,
  `id_severity` int NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `id_dev` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `id_user` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `id_system` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_tickets`
--

INSERT INTO `tbl_tickets` (`id`, `id_status`, `id_category`, `id_severity`, `start_date`, `end_date`, `last_update`, `id_dev`, `id_user`, `id_system`, `created_at`, `summary`) VALUES
('20231108184440cFLQzJO9GFOoSgEbt2', 7, 2, 2, '2023-11-08', '2023-11-09', '2023-11-08 01:09:52', '20230830230852ss0HCw9ur5jx5RXuyv', '202308212046363ttWh8p8mJrUnHgxZM', 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `email` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `picture` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `id_gender` int NOT NULL,
  `register_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `name`, `first_name`, `last_name`, `status`, `email`, `password`, `phone`, `picture`, `id_gender`, `register_date`) VALUES
('202308212046363ttWh8p8mJrUnHgxZM', 'Freddy', 'Flores', 'Chavarria', 1, 'freddy@mail.com', 'pbkdf2:sha256:600000$0YJBVVjVEXlhZN6ABqRPVqi9seDvMM$98bbc3bceafd6ca6694ec3d66ca0dda940a1f177d17c0c7fff2a4cf1b546cec2', '5587237022', 'test.jpg', 1, '2023-08-30 22:09:53'),
('20230830222956ecfjBd29OjGqmmcqWn', 'Saul', 'Suarez', 'Smerlinder', 1, 'saul@mail.com', 'pbkdf2:sha256:600000$noOza5D55O4DOg5V0GU9ohmX2OB6Od$f045e55d0ea5dd96bad0347bb3f1eed4bddd675c66b289bdd227ec633d090121', '2398472986', 'test.jpg', 1, '2023-08-30 22:29:56'),
('20230830230852ss0HCw9ur5jx5RXuyv', 'Edwin', 'Vasquez', 'Crackdona', 1, 'edwin@mail.com', 'pbkdf2:sha256:600000$Pc8dn6IrFi8SHopL7GUAyOMBEkINfV$ac425b2d0659001b804d3a6baa84f8dea3541f625a20ab69eb0f8476dae0408b', '1234567890', 'test.jpg', 1, '2023-08-30 23:08:52'),
('20231020115302nK75HPANjQUkw8yCmt', 'Javier', 'Vega', 'Monzon', 1, 'javier@mail.com', 'pbkdf2:sha256:600000$VwFvGTFyFk3aK8r6IP4ZzuZBhpmurr$02b513eaeb35885f463853a6ebcf67fbfc8ed3af4477bb8bc23f6a73e0e7b6ff', '5589632563', 'test.jpg', 1, '2023-10-20 17:53:02'),
('20231101023234BwRdtVCZNXVvIsxKO9', 'Freddy', 'Flores', 'Chavarria', 1, 'fmarcelfc@gmail.com', 'pbkdf2:sha256:600000$LsDtxhqGhGQUnTmqyLYp937KHptHes$c868866f088c1adbe5e56787d41ed4a1f2c4d2a6c1312fa4a789914cde19c7b2', '5587237022', 'example.jpg', 1, '2023-11-01 02:32:34'),
('20231108161207GdOodIieTG2DDVijDC', 'Javier', 'Leiva', 'Martinez', 1, 'leiva@mail.com', 'pbkdf2:sha256:600000$d30zGD5SsR9Air2wi4N0PMeDf59qKN$91bddadbd1196cda85ed48a6b9b7cd17341a76ddcfd4bcf2e90a94bd1c955cec', '5595364856', 'example.jpg', 2, '2023-11-08 16:12:07'),
('20231108164014dV7gs3pCg43YLtB9G3', 'Freddy', 'Flores', 'Chavarria', 1, 'javier@jamail.com', 'pbkdf2:sha256:600000$CoqLsUA4sS1s7keQKuuYXCRdSf6ANQ$1ad5626d15e432931a0065865d0bbce51f014eede0d539e44c77f8781f8108f6', '5587237022', 'example.jpg', 1, '2023-11-08 16:40:14'),
('20231108164157f5P84yN9KneGFsbgGV', 'Freddy', 'Flores', 'Chavarria', 1, 'javier@imail.com', 'pbkdf2:sha256:600000$nr6aDLtkliE2HfGzW9a59uCRP1CelG$774a7957256e77c55f4a5cf1b15aa4bdd1ce229d9cf4e4a19ec1ecab267436e7', '5587237022', 'example.jpg', 1, '2023-11-08 16:41:57');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user_profile`
--

CREATE TABLE `tbl_user_profile` (
  `id_user` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `id_profile` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_user_profile`
--

INSERT INTO `tbl_user_profile` (`id_user`, `id_profile`) VALUES
('202308212046363ttWh8p8mJrUnHgxZM', 1),
('20230830230852ss0HCw9ur5jx5RXuyv', 1),
('20231020115302nK75HPANjQUkw8yCmt', 3),
('20230830230852ss0HCw9ur5jx5RXuyv', 2),
('20230830222956ecfjBd29OjGqmmcqWn', 2),
('20231101023234BwRdtVCZNXVvIsxKO9', 3),
('20231108161207GdOodIieTG2DDVijDC', 3),
('20231108164014dV7gs3pCg43YLtB9G3', 3),
('20231108164157f5P84yN9KneGFsbgGV', 3);

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
-- Indexes for table `tbl_platform`
--
ALTER TABLE `tbl_platform`
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
-- Indexes for table `tbl_scan`
--
ALTER TABLE `tbl_scan`
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
  ADD KEY `id_plataform` (`id_platform`);

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
  ADD KEY `id_system` (`id_system`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_gender` (`id_gender`);

--
-- Indexes for table `tbl_user_profile`
--
ALTER TABLE `tbl_user_profile`
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_profile` (`id_profile`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_category`
--
ALTER TABLE `tbl_category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_gender`
--
ALTER TABLE `tbl_gender`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_module`
--
ALTER TABLE `tbl_module`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_platform`
--
ALTER TABLE `tbl_platform`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_profile`
--
ALTER TABLE `tbl_profile`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_scan`
--
ALTER TABLE `tbl_scan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tbl_severity`
--
ALTER TABLE `tbl_severity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_status`
--
ALTER TABLE `tbl_status`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_system`
--
ALTER TABLE `tbl_system`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
-- Constraints for table `tbl_system`
--
ALTER TABLE `tbl_system`
  ADD CONSTRAINT `tbl_system_ibfk_1` FOREIGN KEY (`id_platform`) REFERENCES `tbl_platform` (`id`);

--
-- Constraints for table `tbl_tickets`
--
ALTER TABLE `tbl_tickets`
  ADD CONSTRAINT `tbl_tickets_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_2` FOREIGN KEY (`id_status`) REFERENCES `tbl_status` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_3` FOREIGN KEY (`id_category`) REFERENCES `tbl_category` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_4` FOREIGN KEY (`id_severity`) REFERENCES `tbl_severity` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_5` FOREIGN KEY (`id_system`) REFERENCES `tbl_system` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_6` FOREIGN KEY (`id_dev`) REFERENCES `tbl_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD CONSTRAINT `tbl_users_ibfk_1` FOREIGN KEY (`id_gender`) REFERENCES `tbl_gender` (`id`);

--
-- Constraints for table `tbl_user_profile`
--
ALTER TABLE `tbl_user_profile`
  ADD CONSTRAINT `tbl_user_profile_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id`),
  ADD CONSTRAINT `tbl_user_profile_ibfk_2` FOREIGN KEY (`id_profile`) REFERENCES `tbl_profile` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
