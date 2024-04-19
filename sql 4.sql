-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Temps de generació: 03-04-2024 a les 21:58:08
-- Versió del servidor: 10.4.19-MariaDB
-- Versió de PHP: 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de dades: `tienda_moviles`
--
CREATE DATABASE IF NOT EXISTS `tienda_moviles` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `tienda_moviles`;

-- --------------------------------------------------------

--
-- Estructura de la taula `clientes`
--

CREATE TABLE IF NOT EXISTS `clientes` (
  `id_cliente` int(5) NOT NULL AUTO_INCREMENT,
  `nombre_cliente` varchar(25) NOT NULL,
  `apellido_cliente` varchar(50) NOT NULL,
  `cif_cliente` varchar(10) NOT NULL,
  `id_poblaciones` int(5) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  KEY `clientes_poblacion_id_poblacion` (`id_poblaciones`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;

--
-- Bolcament de dades per a la taula `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre_cliente`, `apellido_cliente`, `cif_cliente`, `id_poblaciones`) VALUES
(1, 'Bill', 'Gates', '1111111111', 1),
(2, 'Elon ', 'Musk', '2222222222', 2),
(3, 'Jeff', 'Bezzos', '333333333', 2),
(4, 'Tim', 'Berners', '4444444444', 2),
(5, 'Francisco', 'Fernández', '98237768M', 7),
(6, 'María Isabel', 'Redondo', '18780120D', 9),
(7, 'Juan', 'Medina', '95978318O', 7),
(8, 'Rosa María', 'Santos', '91436690N', 3),
(9, 'Alejandro', 'Guerrero', '98147971C', 1),
(10, 'Carmen', 'Gutiérrez', '55309407B', 7),
(11, 'Rafael', 'Blanco', '64176764G', 2),
(12, 'Juana', 'Ramírez', '01027845U', 3),
(13, 'José Luis', 'Sanz', '59667257L', 10),
(14, 'Rosa María', 'Pérez', '17079624F', 4),
(15, 'Rafael', 'Vázquez', '25138048C', 3),
(16, 'María Teresa', 'Castro', '66491162A', 10),
(17, 'José', 'Garrido', '55701019R', 2),
(18, 'Rosa María', 'Delgado', '78079413Q', 8),
(19, 'Daniel', 'Gil', '65753196X', 7),
(20, 'Isabel', 'Redondo', '08981327Y', 1),
(21, 'Miguel Ángel', 'Domínguez', '59975391C', 8),
(22, 'María', 'Fernández', '07863159O', 3),
(23, 'Pedro', 'Vázquez', '55273950J', 2),
(24, 'Ana', 'Gil', '66691115M', 3);

-- --------------------------------------------------------

--
-- Estructura de la taula `facturas`
--

CREATE TABLE IF NOT EXISTS `facturas` (
  `id_factura` int(8) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(5) NOT NULL,
  `id_producto` int(5) NOT NULL,
  `cantidad` decimal(8,2) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id_factura`),
  KEY `id_cliente_factura` (`id_cliente`),
  KEY `id_producto_factura` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

--
-- Bolcament de dades per a la taula `facturas`
--

INSERT INTO `facturas` (`id_factura`, `id_cliente`, `id_producto`, `cantidad`, `fecha`) VALUES
(1, 2, 3, '1.00', '2024-04-02'),
(2, 3, 4, '2.00', '2024-04-01'),
(3, 4, 8, '4.00', '2024-03-02'),
(4, 2, 5, '3.00', '2024-02-02'),
(5, 3, 2, '1.00', '2024-04-03'),
(6, 4, 5, '2.00', '2024-03-22'),
(7, 3, 3, '1.00', '2024-04-02'),
(8, 1, 3, '1.00', '2024-04-02'),
(9, 4, 3, '1.00', '2024-04-02'),
(10, 1, 3, '1.00', '2024-04-02'),
(11, 1, 6, '1.00', '2024-04-01'),
(12, 2, 4, '1.00', '2024-01-02'),
(13, 2, 3, '8.00', '2023-10-02'),
(14, 18, 12, '1.00', '2023-12-20'),
(15, 15, 13, '2.00', '2023-11-28'),
(16, 12, 5, '1.00', '2023-10-06'),
(17, 14, 10, '1.00', '2023-12-14'),
(18, 10, 10, '1.00', '2023-12-21'),
(19, 9, 10, '1.00', '2024-01-05'),
(20, 9, 5, '3.00', '2024-01-18');

-- --------------------------------------------------------

--
-- Estructura de la taula `familia_producto`
--

CREATE TABLE IF NOT EXISTS `familia_producto` (
  `id_familia_producto` int(5) NOT NULL AUTO_INCREMENT,
  `nombre_familia` varchar(30) NOT NULL,
  PRIMARY KEY (`id_familia_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Bolcament de dades per a la taula `familia_producto`
--

INSERT INTO `familia_producto` (`id_familia_producto`, `nombre_familia`) VALUES
(1, 'Smartphone Apple'),
(2, 'Smartphone Android'),
(3, 'Tablet Apple'),
(4, 'Tablet Android'),
(5, 'Otros');

-- --------------------------------------------------------

--
-- Estructura de la taula `poblaciones`
--

CREATE TABLE IF NOT EXISTS `poblaciones` (
  `id_poblaciones` int(5) NOT NULL AUTO_INCREMENT,
  `nombre_poblacion` varchar(30) NOT NULL,
  PRIMARY KEY (`id_poblaciones`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

--
-- Bolcament de dades per a la taula `poblaciones`
--

INSERT INTO `poblaciones` (`id_poblaciones`, `nombre_poblacion`) VALUES
(1, 'Seattle'),
(2, 'Barcelona'),
(3, 'Cornellà'),
(4, 'Hospitalet de Llobregat'),
(5, 'El Prat de Llobregat'),
(6, 'París'),
(7, 'Roma'),
(8, 'Berlín'),
(9, 'Berna'),
(10, 'Basilea');

-- --------------------------------------------------------

--
-- Estructura de la taula `productos`
--

CREATE TABLE IF NOT EXISTS `productos` (
  `id_producto` int(5) NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(30) NOT NULL,
  `id_familia_producto` int(5) NOT NULL,
  `precio_producto` decimal(8,2) NOT NULL,
  `iva_producto` decimal(3,2) NOT NULL DEFAULT 0.21,
  `id_proveedor` int(5) NOT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `id_productos_familia` (`id_familia_producto`),
  KEY `id_proveedores_productos` (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

--
-- Bolcament de dades per a la taula `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre_producto`, `id_familia_producto`, `precio_producto`, `iva_producto`, `id_proveedor`) VALUES
(1, 'IPhone 15 Plus', 1, '1500.00', '0.21', 3),
(2, 'IPhone 14', 1, '1000.00', '0.21', 1),
(3, 'IPhone 12 Plus', 1, '500.00', '0.21', 3),
(4, 'IPhone 15', 1, '1200.00', '0.21', 3),
(5, 'Samsung S24', 2, '1200.00', '0.21', 4),
(6, 'Xiaomi Redmi 12', 2, '800.00', '0.21', 1),
(7, 'Samsung S22 Pro', 2, '1000.00', '0.21', 1),
(8, 'Ipad 2022', 3, '500.00', '0.21', 3),
(9, 'Apple Watch', 5, '650.00', '0.21', 3),
(10, 'Samsung Smart TV', 5, '980.50', '0.21', 4),
(11, 'Samsung Galaxy Tab S9', 4, '880.00', '0.21', 10),
(12, 'Macbook Pro M3', 5, '2500.00', '0.21', 11),
(13, 'Macbook Pro M2', 5, '2000.00', '0.21', 6),
(14, 'Macbook Pro M1', 5, '1500.00', '0.21', 3),
(15, 'Xiaomi Pad', 4, '420.00', '0.21', 11),
(16, 'Xiaomi 12', 2, '690.00', '0.21', 5),
(17, 'Samsung A14', 2, '170.00', '0.21', 1),
(18, 'Huawei P30', 2, '530.00', '0.21', 6),
(19, 'Samsung Galaxy Tab S9 Pro', 4, '1200.00', '0.21', 6),
(20, 'Oppo A52', 2, '450.00', '0.21', 6);

-- --------------------------------------------------------

--
-- Estructura de la taula `proveedores`
--

CREATE TABLE IF NOT EXISTS `proveedores` (
  `id_proveedor` int(5) NOT NULL AUTO_INCREMENT,
  `nombre_proveedor` varchar(30) NOT NULL,
  `id_poblaciones` int(5) NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  KEY `id_poblaciones_proveedor` (`id_poblaciones`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;

--
-- Bolcament de dades per a la taula `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre_proveedor`, `id_poblaciones`) VALUES
(1, 'Amazon', 1),
(2, 'Ali Express', 2),
(3, 'Apple Store', 1),
(4, 'Samsung Store', 2),
(5, 'Xiaomi', 1),
(6, 'Media Markt', 2),
(7, 'Bueno, bonito, barato', 5),
(8, 'Lidl', 8),
(9, 'Aldi', 8),
(10, 'Worten', 8),
(11, 'El Corte Inglés', 2),
(12, 'Phone House', 2),
(13, 'Mobile House', 8),
(14, 'Movistar', 2),
(15, 'Vodafone', 3),
(16, 'O2', 3),
(17, 'PC Componentes', 4),
(18, 'FNAC', 6),
(19, 'Miravia', 6),
(20, 'Jazztel', 8);

--
-- Restriccions per a les taules bolcades
--

--
-- Restriccions per a la taula `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_poblacion_id_poblacion` FOREIGN KEY (`id_poblaciones`) REFERENCES `poblaciones` (`id_poblaciones`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restriccions per a la taula `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `id_cliente_factura` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_producto_factura` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restriccions per a la taula `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `id_productos_familia` FOREIGN KEY (`id_familia_producto`) REFERENCES `familia_producto` (`id_familia_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_proveedores_productos` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restriccions per a la taula `proveedores`
--
ALTER TABLE `proveedores`
  ADD CONSTRAINT `id_poblaciones_proveedor` FOREIGN KEY (`id_poblaciones`) REFERENCES `poblaciones` (`id_poblaciones`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;