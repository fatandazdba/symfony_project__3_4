-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.19-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para symfony_project__3_4
CREATE DATABASE IF NOT EXISTS `symfony_project__3_4` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `symfony_project__3_4`;

-- Volcando estructura para tabla symfony_project__3_4.accesorio
CREATE TABLE IF NOT EXISTS `accesorio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla symfony_project__3_4.accesorio: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `accesorio` DISABLE KEYS */;
REPLACE INTO `accesorio` (`id`, `nombre`, `cantidad`) VALUES
	(1, 'Accesorio 1', 21),
	(2, 'accesorio 2', 43),
	(3, 'accesorio 3', 13);
/*!40000 ALTER TABLE `accesorio` ENABLE KEYS */;

-- Volcando estructura para tabla symfony_project__3_4.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `foto` varchar(522) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla symfony_project__3_4.categoria: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
REPLACE INTO `categoria` (`id`, `nombre`, `descripcion`, `foto`) VALUES
	(1, 'categoria 1', 'descripcion de nueva categoria', '099d610eac102ebd2aee11c397d5e82a.png'),
	(2, 'ordenadores', 'Categoria de ordenadores', '9b96221e4748a9235c727f4f9d20e50c.png');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;

-- Volcando estructura para tabla symfony_project__3_4.producto
CREATE TABLE IF NOT EXISTS `producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `precio` double NOT NULL,
  `foto` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_A7BB06153397707A` (`categoria_id`),
  CONSTRAINT `FK_A7BB06153397707A` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla symfony_project__3_4.producto: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
REPLACE INTO `producto` (`id`, `nombre`, `descripcion`, `precio`, `foto`, `categoria_id`) VALUES
	(1, 'BANCOS DE TRABAJO', 'Las encimeras para bancos de trabajo combinables', 15.2, 'be22be2057d726f878409858add80635.jpeg', NULL),
	(2, 'Estanterías universales', 'En dos variantes de equipamiento (opcionalmente con soportes de estantería o pared lateral cerrado) y distintas alturas', 200, '4699bca9a4fb130cd4028fbf4bbb6522.png', NULL),
	(3, 'CARROS DE TALLER', 'El nuevo carro de taller L3627 de LISTA se ha optimizado con todas las características de equipamiento', 300, '4699bca9a4fb130cd4028fbf4bbb6522.png', NULL),
	(4, 'Estanterías de base móvil', 'Quien quiera obtener mucho espacio de almacenamiento en una superficie limitada', 100, '', NULL),
	(5, 'Bancos de trabajo de sistema', 'Los bancos de trabajo de sistema de LISTA son una solución económica y estable para puestos de trabajo en talleres y producción.', 200, 'be22be2057d726f878409858add80635.jpeg', NULL),
	(6, 'Armarios para contenedores y de gran capacidad', 'Con sus armarios para contenedores y de gran capacidad, LISTA le ofrece dos soluciones a medida', 500, '', NULL),
	(7, 'goma', 'edscripcionGoma', 0.15, 'be22be2057d726f878409858add80635.jpeg', NULL),
	(8, 'producto de categoria 1', 'producto de categoria 1', 54, 'b53c831b63ed44467e51559e5b64efa5.png', 1),
	(9, 'Lenovo', 'ordenador lenovo', 1000, 'dcea403c859209f026482a95f88e3666.jpeg', 2),
	(10, 'Producto con Accesorio', 'Producto con Accesorio', 12, '23cd0153e2992002e49ca28485fb70a1.png', 2);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;

-- Volcando estructura para tabla symfony_project__3_4.productos_accesorios
CREATE TABLE IF NOT EXISTS `productos_accesorios` (
  `producto_id` int(11) NOT NULL,
  `accesorio_id` int(11) NOT NULL,
  PRIMARY KEY (`producto_id`,`accesorio_id`),
  KEY `IDX_AE36355D7645698E` (`producto_id`),
  KEY `IDX_AE36355D5A9C8557` (`accesorio_id`),
  CONSTRAINT `FK_AE36355D5A9C8557` FOREIGN KEY (`accesorio_id`) REFERENCES `accesorio` (`id`),
  CONSTRAINT `FK_AE36355D7645698E` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla symfony_project__3_4.productos_accesorios: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `productos_accesorios` DISABLE KEYS */;
REPLACE INTO `productos_accesorios` (`producto_id`, `accesorio_id`) VALUES
	(10, 1),
	(10, 2),
	(10, 3);
/*!40000 ALTER TABLE `productos_accesorios` ENABLE KEYS */;

-- Volcando estructura para tabla symfony_project__3_4.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `apellidos` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `roles` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `plainPassword` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2265B05DE7927C74` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla symfony_project__3_4.usuario: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
