-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.4.3 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para inventario_ti
CREATE DATABASE IF NOT EXISTS `inventario_ti` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventario_ti`;

-- Volcando estructura para tabla inventario_ti.areas
CREATE TABLE IF NOT EXISTS `areas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `estado` enum('Activo','Inactivo') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.areas: ~4 rows (aproximadamente)
DELETE FROM `areas`;
INSERT INTO `areas` (`id`, `nombre`, `estado`) VALUES
	(1, 'GERENCIA', 'Activo'),
	(2, 'ADMINISTRACIÓN', 'Activo'),
	(3, 'GESTIÓN HUMANA', 'Activo'),
	(4, 'SISTEMAS', 'Activo'),
	(5, 'LOGISTICA', 'Activo');

-- Volcando estructura para tabla inventario_ti.asignaciones
CREATE TABLE IF NOT EXISTS `asignaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_equipo` int NOT NULL,
  `id_empleado` int NOT NULL,
  `fecha_entrega` datetime NOT NULL,
  `fecha_devolucion` datetime DEFAULT NULL,
  `estado_asignacion` enum('Activa','Finalizada') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Activa',
  `observaciones_entrega` text COLLATE utf8mb4_general_ci,
  `observaciones_devolucion` text COLLATE utf8mb4_general_ci,
  `acta_firmada_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `acta_devolucion_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `imagen_devolucion_1` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `imagen_devolucion_2` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `imagen_devolucion_3` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_equipo_asignado` (`id_equipo`),
  KEY `fk_empleado_asignado` (`id_empleado`),
  CONSTRAINT `fk_empleado_asignado` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_equipo_asignado` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.asignaciones: ~3 rows (aproximadamente)
DELETE FROM `asignaciones`;
INSERT INTO `asignaciones` (`id`, `id_equipo`, `id_empleado`, `fecha_entrega`, `fecha_devolucion`, `estado_asignacion`, `observaciones_entrega`, `observaciones_devolucion`, `acta_firmada_path`, `acta_devolucion_path`, `imagen_devolucion_1`, `imagen_devolucion_2`, `imagen_devolucion_3`) VALUES
	(1, 1, 1, '2025-11-08 06:59:52', '2025-11-09 07:48:00', 'Finalizada', 'asignacion 1', 'Estado al recibir: Bueno.\nObservaciones: ', 'acta_1_1762670869.pdf', 'acta_devolucion_1_1762752935.pdf', '1762674646_2025-05-20_21h08_48.png', '1762674646_2025-05-20_21h16_13.png', '1762674646_2025-05-20_21h34_39.png'),
	(2, 2, 1, '2025-11-09 07:15:25', NULL, 'Activa', 'otro', NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 4, 2, '2025-11-22 22:55:56', NULL, 'Activa', 'NUEVO EMPLEADO', NULL, 'acta_3_1763852445.pdf', NULL, NULL, NULL, NULL);

-- Volcando estructura para tabla inventario_ti.bajas
CREATE TABLE IF NOT EXISTS `bajas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_equipo` int NOT NULL,
  `fecha_baja` date NOT NULL,
  `motivo` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `observaciones` text COLLATE utf8mb4_general_ci,
  `acta_baja_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descripcion_motivo` text COLLATE utf8mb4_general_ci,
  `id_usuario_responsable` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_equipo_baja` (`id_equipo`),
  CONSTRAINT `fk_equipo_baja` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.bajas: ~0 rows (aproximadamente)
DELETE FROM `bajas`;
INSERT INTO `bajas` (`id`, `id_equipo`, `fecha_baja`, `motivo`, `observaciones`, `acta_baja_path`, `descripcion_motivo`, `id_usuario_responsable`) VALUES
	(1, 1, '2025-11-12', 'Dañado sin reparación', 'no funciona', 'acta_baja_1_1762928227.pdf', NULL, NULL);

-- Volcando estructura para tabla inventario_ti.cargos
CREATE TABLE IF NOT EXISTS `cargos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_area` int NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `estado` enum('Activo','Inactivo') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `fk_cargo_area` (`id_area`),
  CONSTRAINT `fk_cargo_area` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.cargos: ~8 rows (aproximadamente)
DELETE FROM `cargos`;
INSERT INTO `cargos` (`id`, `id_area`, `nombre`, `estado`) VALUES
	(1, 1, 'GERENTE DE SUCURSAL', 'Activo'),
	(2, 2, 'JEFE ADMINISTRATIVO', 'Activo'),
	(3, 2, 'ASISTENTE ADMINISTRATIVO', 'Activo'),
	(4, 3, 'JEFE DE RR.HH.', 'Activo'),
	(5, 5, 'JEFE DE LOGISTICA', 'Activo'),
	(6, 5, 'AUXILIAR DE ALMACEN', 'Activo'),
	(7, 4, 'JEFE DE TI', 'Activo'),
	(8, 4, 'ASISTENTE DE TI', 'Activo');

-- Volcando estructura para tabla inventario_ti.configuracion
CREATE TABLE IF NOT EXISTS `configuracion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `valor` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clave_unica` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.configuracion: ~0 rows (aproximadamente)
DELETE FROM `configuracion`;
INSERT INTO `configuracion` (`id`, `clave`, `valor`) VALUES
	(1, 'moneda_simbolo', 'USD');

-- Volcando estructura para tabla inventario_ti.empleados
CREATE TABLE IF NOT EXISTS `empleados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_sucursal` int NOT NULL,
  `dni` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `nombres` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `apellidos` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `id_cargo` int DEFAULT NULL,
  `id_area` int DEFAULT NULL,
  `estado` enum('Activo','Inactivo') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dni` (`dni`),
  KEY `fk_empleado_cargo` (`id_cargo`),
  KEY `fk_empleado_area` (`id_area`),
  KEY `fk_empleado_sucursal` (`id_sucursal`),
  CONSTRAINT `fk_empleado_area` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_empleado_cargo` FOREIGN KEY (`id_cargo`) REFERENCES `cargos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_empleado_sucursal` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.empleados: ~1 rows (aproximadamente)
DELETE FROM `empleados`;
INSERT INTO `empleados` (`id`, `id_sucursal`, `dni`, `nombres`, `apellidos`, `id_cargo`, `id_area`, `estado`) VALUES
	(1, 1, '41414141', 'CARLOS', 'RAMIREZ', 2, 2, 'Activo'),
	(2, 1, '40404040', 'VICTOR', 'RAMOS', 2, 2, 'Activo');

-- Volcando estructura para tabla inventario_ti.equipos
CREATE TABLE IF NOT EXISTS `equipos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_sucursal` int NOT NULL,
  `codigo_inventario` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `id_tipo_equipo` int NOT NULL,
  `id_marca` int NOT NULL,
  `id_modelo` int NOT NULL,
  `numero_serie` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `caracteristicas` text COLLATE utf8mb4_general_ci,
  `tipo_adquisicion` enum('Propio','Arrendado','Prestamo') COLLATE utf8mb4_general_ci NOT NULL,
  `fecha_adquisicion` date DEFAULT NULL,
  `proveedor` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado` enum('Disponible','Asignado','En Reparacion','De Baja') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Disponible',
  `observaciones` text COLLATE utf8mb4_general_ci,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_inventario` (`codigo_inventario`),
  UNIQUE KEY `numero_serie` (`numero_serie`),
  KEY `fk_equipo_tipo` (`id_tipo_equipo`),
  KEY `fk_equipo_marca` (`id_marca`),
  KEY `fk_equipo_modelo` (`id_modelo`),
  KEY `fk_equipo_sucursal` (`id_sucursal`),
  CONSTRAINT `fk_equipo_marca` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`),
  CONSTRAINT `fk_equipo_modelo` FOREIGN KEY (`id_modelo`) REFERENCES `modelos` (`id`),
  CONSTRAINT `fk_equipo_sucursal` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id`),
  CONSTRAINT `fk_equipo_tipo` FOREIGN KEY (`id_tipo_equipo`) REFERENCES `tipos_equipo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.equipos: ~4 rows (aproximadamente)
DELETE FROM `equipos`;
INSERT INTO `equipos` (`id`, `id_sucursal`, `codigo_inventario`, `id_tipo_equipo`, `id_marca`, `id_modelo`, `numero_serie`, `caracteristicas`, `tipo_adquisicion`, `fecha_adquisicion`, `proveedor`, `estado`, `observaciones`, `fecha_registro`) VALUES
	(1, 1, 'INVENTARIO2025- 001', 2, 1, 1, 'SERIE-001', 'PROCESADOR CORE I5 / RAM 16GB / SSD', 'Propio', '2025-11-07', 'PROVEEDOR 1', 'De Baja', 'EQUIPO NUEVO PARA EL GERENTE SUCURSAL 1', '2025-11-08 04:07:35'),
	(2, 1, 'INVENTARIO2025- 002', 1, 2, 3, 'SERIE-002', 'PROCESADOR CORE I5 / RAM 16GB /SSD', 'Arrendado', '2025-11-08', 'PROVEEDOR 2', 'Asignado', 'PARA BACKUP', '2025-11-08 22:36:50'),
	(3, 1, 'INVENTARIO2025- 003', 2, 3, 4, 'SERIE-003', '', 'Propio', '2025-11-19', 'PROVEEDOR 2', 'Disponible', '', '2025-11-19 16:24:03'),
	(4, 1, 'INVENTARIO2025- 004', 2, 4, 5, 'SERIE-004', 'PROCESADOR CORE I5 / RAM 16GB / SSD', 'Propio', '2025-11-21', 'PROVEEDOR 2', 'Asignado', 'EQUIPO PARA EL JEFE DE ADMINISTRACIÓN', '2025-11-22 22:48:00');

-- Volcando estructura para tabla inventario_ti.marcas
CREATE TABLE IF NOT EXISTS `marcas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `estado` enum('Activo','Inactivo') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.marcas: ~2 rows (aproximadamente)
DELETE FROM `marcas`;
INSERT INTO `marcas` (`id`, `nombre`, `estado`) VALUES
	(1, 'LENOVO', 'Activo'),
	(2, 'HP', 'Activo'),
	(3, 'ASUS', 'Activo'),
	(4, 'DELL', 'Activo');

-- Volcando estructura para tabla inventario_ti.modelos
CREATE TABLE IF NOT EXISTS `modelos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_marca` int NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `estado` enum('Activo','Inactivo') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id`),
  KEY `fk_modelo_marca` (`id_marca`),
  CONSTRAINT `fk_modelo_marca` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.modelos: ~4 rows (aproximadamente)
DELETE FROM `modelos`;
INSERT INTO `modelos` (`id`, `id_marca`, `nombre`, `estado`) VALUES
	(1, 1, 'LENOVO A-2025', 'Activo'),
	(2, 1, 'LENOVO-A1', 'Activo'),
	(3, 2, 'HP-V2025', 'Activo'),
	(4, 3, 'ASUS-2025', 'Activo'),
	(5, 4, 'DELL-2025', 'Activo');

-- Volcando estructura para tabla inventario_ti.reparaciones
CREATE TABLE IF NOT EXISTS `reparaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_equipo` int NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `fecha_salida` date DEFAULT NULL,
  `motivo` text COLLATE utf8mb4_general_ci NOT NULL,
  `proveedor_servicio` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT '0.00',
  `observaciones_salida` text COLLATE utf8mb4_general_ci,
  `estado_reparacion` enum('En Proceso','Finalizada') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'En Proceso',
  PRIMARY KEY (`id`),
  KEY `id_equipo` (`id_equipo`),
  CONSTRAINT `reparaciones_ibfk_1` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.reparaciones: ~4 rows (aproximadamente)
DELETE FROM `reparaciones`;
INSERT INTO `reparaciones` (`id`, `id_equipo`, `fecha_ingreso`, `fecha_salida`, `motivo`, `proveedor_servicio`, `costo`, `observaciones_salida`, `estado_reparacion`) VALUES
	(1, 3, '2025-10-01', '2025-10-01', 'no enciende', 'PROVEEDOR 1', 100.00, 'solucionado', 'Finalizada'),
	(2, 5, '2025-10-22', '2025-10-22', 'MANTENIMIENTO PREVENTIVO', 'PROVEEDOR 2', 30.00, 'MANTENIMIENTO CORRECTIVO REALIZADO', 'Finalizada'),
	(3, 1, '2025-11-10', '2025-11-10', 'Se envía para mantenimiento correctivo', 'PROVEEDOR 1', 50.00, 'Se realizó el mantenimiento correctivo al equipo computador', 'Finalizada'),
	(4, 1, '2025-11-10', '2025-11-12', 'repotenciación', 'PROVEEDOR 1', 100.00, 'terminado', 'Finalizada');

-- Volcando estructura para tabla inventario_ti.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.roles: ~2 rows (aproximadamente)
DELETE FROM `roles`;
INSERT INTO `roles` (`id`, `nombre_rol`) VALUES
	(1, 'Administrador'),
	(2, 'Usuario');

-- Volcando estructura para tabla inventario_ti.sucursales
CREATE TABLE IF NOT EXISTS `sucursales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `direccion` text COLLATE utf8mb4_general_ci,
  `telefono` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado` enum('Activo','Inactivo') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.sucursales: ~2 rows (aproximadamente)
DELETE FROM `sucursales`;
INSERT INTO `sucursales` (`id`, `nombre`, `direccion`, `telefono`, `estado`) VALUES
	(1, 'SUCURSAL #1', '', NULL, 'Activo'),
	(2, 'SUCURSAL #2', '', NULL, 'Activo');

-- Volcando estructura para tabla inventario_ti.tipos_equipo
CREATE TABLE IF NOT EXISTS `tipos_equipo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `estado` enum('Activo','Inactivo') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.tipos_equipo: ~9 rows (aproximadamente)
DELETE FROM `tipos_equipo`;
INSERT INTO `tipos_equipo` (`id`, `nombre`, `estado`) VALUES
	(1, 'DESKTOP', 'Activo'),
	(2, 'NOTEBOOK', 'Activo'),
	(3, 'LAPTOP', 'Activo'),
	(4, 'IMPRESORAS MATRICIALES', 'Activo'),
	(5, 'IMPRESORA A TINTA', 'Activo'),
	(6, 'IMPRESORAS LASER', 'Activo'),
	(7, 'IMPRESORAS MULTIFUNCIONALES', 'Activo'),
	(8, 'ALL IN ONE', 'Activo'),
	(9, 'TOUCH', 'Activo');

-- Volcando estructura para tabla inventario_ti.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_sucursal` int DEFAULT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_usuario_sucursal` (`id_sucursal`),
  CONSTRAINT `fk_usuario_sucursal` FOREIGN KEY (`id_sucursal`) REFERENCES `sucursales` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.usuarios: ~1 rows (aproximadamente)
DELETE FROM `usuarios`;
INSERT INTO `usuarios` (`id`, `id_sucursal`, `nombre`, `email`, `password`, `activo`, `fecha_creacion`) VALUES
	(1, NULL, 'Admin', 'admin@correo.com', '$2y$10$67jd7Gb0Tlp/FDj/43CQdOLmEj3eKVnP7uLeJ4X9Zp7y3BnOdywgW', 1, '2025-08-03 06:56:20');

-- Volcando estructura para tabla inventario_ti.usuario_roles
CREATE TABLE IF NOT EXISTS `usuario_roles` (
  `id_usuario` int NOT NULL,
  `id_rol` int NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_rol`),
  KEY `fk_rol` (`id_rol`),
  CONSTRAINT `fk_rol` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_ti.usuario_roles: ~1 rows (aproximadamente)
DELETE FROM `usuario_roles`;
INSERT INTO `usuario_roles` (`id_usuario`, `id_rol`) VALUES
	(1, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
