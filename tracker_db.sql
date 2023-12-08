-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: mysql
-- Tiempo de generación: 08-12-2023 a las 18:24:18
-- Versión del servidor: 8.1.0
-- Versión de PHP: 8.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tracker_db`
--

DELIMITER $$
--
-- Procedimientos
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
-- Estructura de tabla para la tabla `tbl_category`
--

CREATE TABLE `tbl_category` (
  `id` int NOT NULL,
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_category`
--

INSERT INTO `tbl_category` (`id`, `category`, `description`) VALUES
(1, 'Security', 'Your issue is security-related, there was a security attact, you detected a security flaw.'),
(2, 'Interface', 'Your issue is interface-related, you detected a bug in the interface or you think there is something to improve.'),
(3, 'Backend', 'Your issue is backend-related, you received an error in your request, a server error.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_gender`
--

CREATE TABLE `tbl_gender` (
  `id` int NOT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_gender`
--

INSERT INTO `tbl_gender` (`id`, `gender`) VALUES
(1, 'Male'),
(2, 'Female');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_module`
--

CREATE TABLE `tbl_module` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `page` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `icon` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order` int NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_module`
--

INSERT INTO `tbl_module` (`id`, `name`, `page`, `icon`, `order`, `status`) VALUES
(1, 'Home', '/home', 'home', 1, 1),
(2, 'Register', '/register-ticket', 'add', 2, 1),
(3, 'Reports', '/reports', 'book', 4, 1),
(4, 'Tickets', '/tickets', 'confirmation_number', 3, 1),
(5, 'Users', '/users', 'people_alt', 5, 1),
(6, 'Your Tickets', '/your-tickets', 'receipt', 6, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_platform`
--

CREATE TABLE `tbl_platform` (
  `id` int NOT NULL,
  `platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_platform`
--

INSERT INTO `tbl_platform` (`id`, `platform`) VALUES
(1, 'Windows'),
(2, 'Mac'),
(3, 'Linux');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_profile`
--

CREATE TABLE `tbl_profile` (
  `id` int NOT NULL,
  `profile` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_profile`
--

INSERT INTO `tbl_profile` (`id`, `profile`, `status`) VALUES
(1, 'admin', 1),
(2, 'developer', 1),
(3, 'client', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_profile_module`
--

CREATE TABLE `tbl_profile_module` (
  `id` int NOT NULL,
  `id_profile` int NOT NULL,
  `id_module` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_profile_module`
--

INSERT INTO `tbl_profile_module` (`id`, `id_profile`, `id_module`) VALUES
(1, 1, 1),
(3, 1, 3),
(5, 2, 4),
(6, 1, 4),
(7, 1, 5),
(8, 2, 2),
(10, 3, 6),
(11, 3, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_register`
--

CREATE TABLE `tbl_register` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `percentage` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_register`
--

INSERT INTO `tbl_register` (`id`, `description`, `percentage`) VALUES
('202308212046363ttWh9p8mJrUnHgxZF', 'Updated some features to solve the ticket.', '55%');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_severity`
--

CREATE TABLE `tbl_severity` (
  `id` int NOT NULL,
  `severity` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_severity`
--

INSERT INTO `tbl_severity` (`id`, `severity`) VALUES
(1, 'High'),
(2, 'Medium'),
(3, 'Low');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_status`
--

CREATE TABLE `tbl_status` (
  `id` int NOT NULL,
  `status` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_status`
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
-- Estructura de tabla para la tabla `tbl_system`
--

CREATE TABLE `tbl_system` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_platform` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_system`
--

INSERT INTO `tbl_system` (`id`, `name`, `id_platform`) VALUES
(1, 'System A', 1),
(2, 'System B', 2),
(3, 'System C', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tickets`
--

CREATE TABLE `tbl_tickets` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_status` int NOT NULL,
  `id_category` int NOT NULL,
  `id_severity` int NOT NULL,
  `issue` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `id_dev` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_system` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_tickets`
--

INSERT INTO `tbl_tickets` (`id`, `id_status`, `id_category`, `id_severity`, `issue`, `start_date`, `end_date`, `last_update`, `id_dev`, `id_user`, `id_system`, `created_at`, `summary`) VALUES
('20231108184440cFLQzJO9GFOoSgEbt2', 7, 2, 1, 'SOME ISSUE', '2023-11-08', '2023-11-09', '2023-11-27 04:16:37', '20230830230852ss0HCw9ur5jx5RXuyv', '202308212046363ttWh8p8mJrUnHgxZM', 2, NULL, NULL),
('20231118121245AzHeD9tsz5ZRqEkdvu', 1, 2, 3, '', '2023-11-01', NULL, NULL, '20230830222956ecfjBd29OjGqmmcqWn', '202308212046363ttWh8p8mJrUnHgxZM', 1, NULL, NULL),
('20231121134847v6ttk2QxoDBZDtd01e', 1, 2, 3, '', '2023-11-21', NULL, '2023-11-21 01:48:53', '202311200938305UlWKWP43ydprukqPc', '202308212046363ttWh8p8mJrUnHgxZM', 1, NULL, NULL),
('202311221227502tUXc8ofPD7tYIj2CN', 1, 2, 2, '', '2023-11-22', NULL, NULL, '202311200938305UlWKWP43ydprukqPc', '202308212046363ttWh8p8mJrUnHgxZM', 1, '2023-11-22 12:22:18', NULL),
('202311271505047qMs1jMOl31FobqkJt', 1, 1, 2, 'TRY', NULL, NULL, NULL, '202311200938305UlWKWP43ydprukqPc', '20231101023234BwRdtVCZNXVvIsxKO9', 1, '2023-11-27 15:05:01', NULL),
('202311271517336Ni3KQXWWgWNn5sKeq', 1, 1, 3, 'TRYING', NULL, NULL, NULL, '202311200938305UlWKWP43ydprukqPc', '20231101023234BwRdtVCZNXVvIsxKO9', 2, '2023-11-27 15:05:01', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_gender` int NOT NULL,
  `register_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `name`, `first_name`, `last_name`, `status`, `email`, `password`, `phone`, `picture`, `id_gender`, `register_date`) VALUES
('202308212046363ttWh8p8mJrUnHgxZM', 'Freddy', 'Flores', 'Chavarria', 1, 'freddy@mail.com', 'pbkdf2:sha256:600000$0YJBVVjVEXlhZN6ABqRPVqi9seDvMM$98bbc3bceafd6ca6694ec3d66ca0dda940a1f177d17c0c7fff2a4cf1b546cec2', '5587237022', 'test.jpg', 1, '2023-08-30 22:09:53'),
('20230830222956ecfjBd29OjGqmmcqWn', 'Saul', 'Suarez', 'Smerlinder', 1, 'saul@mail.com', 'pbkdf2:sha256:600000$noOza5D55O4DOg5V0GU9ohmX2OB6Od$f045e55d0ea5dd96bad0347bb3f1eed4bddd675c66b289bdd227ec633d090121', '2398472986', 'test.jpg', 1, '2023-08-30 22:29:56'),
('20230830230852ss0HCw9ur5jx5RXuyv', 'Edwin', 'Vasquez', 'Crackdona', 1, 'edwin@mail.com', 'pbkdf2:sha256:600000$XAvVVO3lM9NdlGCzHPkz41lwGDj0Dd$72daea4eee6b26bb497530ee7e71c28cdfdf3b37d29523f47af074350eda0ba7', '1234567890', 'test.jpg', 1, '2023-08-30 23:08:52'),
('20231020115302nK75HPANjQUkw8yCmt', 'Javier', 'Vega', 'Monzon', 1, 'javier@mail.com', 'pbkdf2:sha256:600000$VwFvGTFyFk3aK8r6IP4ZzuZBhpmurr$02b513eaeb35885f463853a6ebcf67fbfc8ed3af4477bb8bc23f6a73e0e7b6ff', '5589632563', 'test.jpg', 1, '2023-10-20 17:53:02'),
('20231101023234BwRdtVCZNXVvIsxKO9', 'Freddy', 'Flores', 'Chavarria', 1, 'fmarcelfc@gmail.com', 'pbkdf2:sha256:600000$0YJBVVjVEXlhZN6ABqRPVqi9seDvMM$98bbc3bceafd6ca6694ec3d66ca0dda940a1f177d17c0c7fff2a4cf1b546cec2', '5587237022', 'example.jpg', 1, '2023-11-01 02:32:34'),
('20231108161207GdOodIieTG2DDVijDC', 'Javier', 'Leiva', 'Martinez', 1, 'leiva@mail.com', 'pbkdf2:sha256:600000$d30zGD5SsR9Air2wi4N0PMeDf59qKN$91bddadbd1196cda85ed48a6b9b7cd17341a76ddcfd4bcf2e90a94bd1c955cec', '5595364856', 'example.jpg', 2, '2023-11-08 16:12:07'),
('20231108164014dV7gs3pCg43YLtB9G3', 'Freddy', 'Flores', 'Chavarria', 1, 'javier@jamail.com', 'pbkdf2:sha256:600000$CoqLsUA4sS1s7keQKuuYXCRdSf6ANQ$1ad5626d15e432931a0065865d0bbce51f014eede0d539e44c77f8781f8108f6', '5587237022', 'example.jpg', 1, '2023-11-08 16:40:14'),
('20231108164157f5P84yN9KneGFsbgGV', 'Freddy', 'Flores', 'Chavarria', 1, 'javier@imail.com', 'pbkdf2:sha256:600000$nr6aDLtkliE2HfGzW9a59uCRP1CelG$774a7957256e77c55f4a5cf1b15aa4bdd1ce229d9cf4e4a19ec1ecab267436e7', '5587237022', 'example.jpg', 1, '2023-11-08 16:41:57'),
('202311200938305UlWKWP43ydprukqPc', 'Unassigned', 'Ticket', ' ', 1, 'noticket@mail.com', 'pbkdf2:sha256:600000$4VsXy4gBqH4wXZAqAECxj8HC321v1E$42fdc4b982bd619b470738ec7a75ac650dd2a2d1644f186329b9889b4dd5ce3b', '1234567890', 'nopicture.jpg', 1, '2023-11-20 15:38:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_user_profile`
--

CREATE TABLE `tbl_user_profile` (
  `id` int NOT NULL,
  `id_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_profile` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbl_user_profile`
--

INSERT INTO `tbl_user_profile` (`id`, `id_user`, `id_profile`) VALUES
(1, '202308212046363ttWh8p8mJrUnHgxZM', 1),
(3, '20231020115302nK75HPANjQUkw8yCmt', 3),
(4, '20230830230852ss0HCw9ur5jx5RXuyv', 2),
(5, '20230830222956ecfjBd29OjGqmmcqWn', 2),
(6, '20231101023234BwRdtVCZNXVvIsxKO9', 3),
(7, '20231108161207GdOodIieTG2DDVijDC', 3),
(8, '20231108164014dV7gs3pCg43YLtB9G3', 3),
(9, '20231108164157f5P84yN9KneGFsbgGV', 3),
(10, '202311200938305UlWKWP43ydprukqPc', 3),
(11, '202311200938305UlWKWP43ydprukqPc', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_category`
--
ALTER TABLE `tbl_category`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_gender`
--
ALTER TABLE `tbl_gender`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_module`
--
ALTER TABLE `tbl_module`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_platform`
--
ALTER TABLE `tbl_platform`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_profile`
--
ALTER TABLE `tbl_profile`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_profile_module`
--
ALTER TABLE `tbl_profile_module`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_profile` (`id_profile`),
  ADD KEY `id_module` (`id_module`);

--
-- Indices de la tabla `tbl_register`
--
ALTER TABLE `tbl_register`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_severity`
--
ALTER TABLE `tbl_severity`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_status`
--
ALTER TABLE `tbl_status`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_system`
--
ALTER TABLE `tbl_system`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_plataform` (`id_platform`);

--
-- Indices de la tabla `tbl_tickets`
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
-- Indices de la tabla `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_gender` (`id_gender`);

--
-- Indices de la tabla `tbl_user_profile`
--
ALTER TABLE `tbl_user_profile`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_profile` (`id_profile`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_category`
--
ALTER TABLE `tbl_category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbl_gender`
--
ALTER TABLE `tbl_gender`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbl_module`
--
ALTER TABLE `tbl_module`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tbl_platform`
--
ALTER TABLE `tbl_platform`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbl_profile`
--
ALTER TABLE `tbl_profile`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbl_profile_module`
--
ALTER TABLE `tbl_profile_module`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tbl_severity`
--
ALTER TABLE `tbl_severity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbl_status`
--
ALTER TABLE `tbl_status`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tbl_system`
--
ALTER TABLE `tbl_system`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbl_user_profile`
--
ALTER TABLE `tbl_user_profile`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_profile_module`
--
ALTER TABLE `tbl_profile_module`
  ADD CONSTRAINT `fk_module_profile` FOREIGN KEY (`id_profile`) REFERENCES `tbl_profile` (`id`),
  ADD CONSTRAINT `fk_profile_module` FOREIGN KEY (`id_module`) REFERENCES `tbl_module` (`id`);

--
-- Filtros para la tabla `tbl_system`
--
ALTER TABLE `tbl_system`
  ADD CONSTRAINT `tbl_system_ibfk_1` FOREIGN KEY (`id_platform`) REFERENCES `tbl_platform` (`id`);

--
-- Filtros para la tabla `tbl_tickets`
--
ALTER TABLE `tbl_tickets`
  ADD CONSTRAINT `tbl_tickets_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_2` FOREIGN KEY (`id_status`) REFERENCES `tbl_status` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_3` FOREIGN KEY (`id_category`) REFERENCES `tbl_category` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_4` FOREIGN KEY (`id_severity`) REFERENCES `tbl_severity` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_5` FOREIGN KEY (`id_system`) REFERENCES `tbl_system` (`id`),
  ADD CONSTRAINT `tbl_tickets_ibfk_6` FOREIGN KEY (`id_dev`) REFERENCES `tbl_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD CONSTRAINT `tbl_users_ibfk_1` FOREIGN KEY (`id_gender`) REFERENCES `tbl_gender` (`id`);

--
-- Filtros para la tabla `tbl_user_profile`
--
ALTER TABLE `tbl_user_profile`
  ADD CONSTRAINT `tbl_user_profile_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `tbl_users` (`id`),
  ADD CONSTRAINT `tbl_user_profile_ibfk_2` FOREIGN KEY (`id_profile`) REFERENCES `tbl_profile` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
