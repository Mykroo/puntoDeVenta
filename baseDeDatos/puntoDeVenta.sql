CREATE DATABASE  IF NOT EXISTS `puntodeventa` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `puntodeventa`;
-- MySQL dump 10.13  Distrib 5.6.24, for linux-glibc2.5 (x86_64)
--
-- Host: localhost    Database: puntodeventa
-- ------------------------------------------------------
-- Server version	5.6.27-0ubuntu0.15.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abono`
--

DROP TABLE IF EXISTS `abono`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abono` (
  `idAbono` int(11) NOT NULL,
  `idCompraTotal` int(11) NOT NULL,
  `cantidad` float NOT NULL,
  `fecha` datetime NOT NULL,
  `idUsuario` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idAbono`,`idCompraTotal`),
  KEY `fk_abono_idCompraTotal_idx` (`idCompraTotal`),
  KEY `fk_abono_idUsuario_idx` (`idUsuario`),
  CONSTRAINT `fk_abono_idCompraTotal` FOREIGN KEY (`idCompraTotal`) REFERENCES `compratotal` (`idCompraTotal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_abono_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abono`
--

LOCK TABLES `abono` WRITE;
/*!40000 ALTER TABLE `abono` DISABLE KEYS */;
INSERT INTO `abono` VALUES (1,13,1,'2015-11-26 02:17:05',1),(2,1,1000,'2015-11-26 02:18:31',1),(3,2,1,'2015-11-26 02:19:06',1),(3,7,1,'2015-11-26 02:19:06',1),(3,8,1,'2015-11-26 02:19:06',1),(3,9,1,'2015-11-26 02:19:06',1),(3,10,3,'2015-11-26 02:19:06',1),(3,11,2,'2015-11-26 02:19:06',1),(3,12,2,'2015-11-26 02:19:06',1),(4,10,100,'2015-11-26 02:25:24',1),(5,6,980,'2015-11-26 02:25:55',1),(5,10,20,'2015-11-26 02:25:55',1),(6,6,1,'2015-11-26 02:26:47',1);
/*!40000 ALTER TABLE `abono` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `idcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(45) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Vestir',1),(2,'Deportiva',0),(3,'Deportiva',0),(4,'Niño',1);
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellidoPaterno` varchar(45) NOT NULL,
  `apellidoMaterno` varchar(45) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `email` varchar(45) NOT NULL,
  `idEstado` int(2) NOT NULL,
  `idMunicipio` int(5) NOT NULL,
  `colonia` varchar(45) NOT NULL,
  `calle` varchar(45) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `cp` char(5) NOT NULL,
  `rfc` char(13) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idcliente`),
  KEY `fk_cliente_idEstado_idx` (`idEstado`),
  KEY `fk_cliente_idMunicipio_idx` (`idMunicipio`),
  CONSTRAINT `fk_cliente_idEstado` FOREIGN KEY (`idEstado`) REFERENCES `estados` (`idestado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_idMunicipio` FOREIGN KEY (`idMunicipio`) REFERENCES `municipios` (`idmunicipio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Cliente','General','','','',1,1,'','','','','',1),(2,'Enrique','Peña','Nieto','4498873212','penanieto@gob.org',15,748,'Pinos','Reforma','12','10000','DSH7DH87HGDW3',1);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compraproducto`
--

DROP TABLE IF EXISTS `compraproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compraproducto` (
  `idcompraProducto` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idProducto` int(10) unsigned NOT NULL,
  `cantidad` int(10) unsigned NOT NULL,
  `precioU` float unsigned NOT NULL,
  `idCompraTotal` int(11) NOT NULL,
  PRIMARY KEY (`idcompraProducto`,`idCompraTotal`),
  KEY `fk_compraproducto_idProducto_idx` (`idProducto`),
  KEY `fk_compraproducto_idCompraTotal_idx` (`idCompraTotal`),
  CONSTRAINT `fk_compraproducto_idCompraTotal` FOREIGN KEY (`idCompraTotal`) REFERENCES `compratotal` (`idCompraTotal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_compraproducto_idProducto` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compraproducto`
--

LOCK TABLES `compraproducto` WRITE;
/*!40000 ALTER TABLE `compraproducto` DISABLE KEYS */;
INSERT INTO `compraproducto` VALUES (1,2,12,107.08,1),(2,2,10,0.1,2),(3,2,2,150,3),(4,2,2,1.5,4),(5,3,3,404,4),(6,2,23,25.57,5),(7,3,12,125,6),(8,2,24,150,6),(9,2,1,1,7),(10,2,1,1,8),(11,2,1,1,9),(12,5,38,3.24,10),(13,5,1,2,11),(14,3,1,2,12),(15,6,1,1,13);
/*!40000 ALTER TABLE `compraproducto` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `puntodeventa`.`compraproducto_AFTER_INSERT` AFTER INSERT ON `compraproducto` FOR EACH ROW
BEGIN
	update producto set stock = (stock+new.cantidad) where idProducto = new.idProducto;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `compratotal`
--

DROP TABLE IF EXISTS `compratotal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compratotal` (
  `idCompraTotal` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(10) unsigned NOT NULL,
  `total` float NOT NULL DEFAULT '0',
  `fecha` datetime NOT NULL,
  `folioNota` varchar(45) NOT NULL,
  `idProveedor` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idCompraTotal`),
  KEY `fk_compratotal_idUsuario_idx` (`idUsuario`),
  KEY `fk_compratotal_idProveedor_idx` (`idProveedor`),
  CONSTRAINT `fk_compratotal_idProveedor` FOREIGN KEY (`idProveedor`) REFERENCES `proveedor` (`idproveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_compratotal_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compratotal`
--

LOCK TABLES `compratotal` WRITE;
/*!40000 ALTER TABLE `compratotal` DISABLE KEYS */;
INSERT INTO `compratotal` VALUES (1,1,1285,'2015-11-17 01:25:29','jeje',1),(2,1,1,'2015-11-17 01:26:06','jeje',1),(3,1,300,'2015-11-17 12:05:28','4TY7ER3',1),(4,1,1215,'2015-11-17 12:10:15','',1),(5,1,588,'2015-11-17 12:18:11','jooi8',1),(6,1,5100,'2015-11-17 12:20:58','HolaQueAse',1),(7,1,1,'2015-11-17 12:21:48',';',1),(8,1,1,'2015-11-17 12:25:00','ricardo',1),(9,1,1,'2015-11-17 12:28:02','sdsd',1),(10,1,123,'2015-11-17 12:29:09','',1),(11,1,2,'2015-11-17 12:31:20','1',1),(12,1,2,'2015-11-17 12:33:46','12',1),(13,1,1,'2015-11-24 14:26:49','F78ydqw',3);
/*!40000 ALTER TABLE `compratotal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `deuda`
--

DROP TABLE IF EXISTS `deuda`;
/*!50001 DROP VIEW IF EXISTS `deuda`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `deuda` AS SELECT 
 1 AS `idcompratotal`,
 1 AS `fecha`,
 1 AS `folioNota`,
 1 AS `total`,
 1 AS `abono`,
 1 AS `deuda`,
 1 AS `idproveedor`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estados` (
  `idestado` int(2) NOT NULL,
  `estado` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idestado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` VALUES (1,'Aguascalientes'),(2,'Baja California'),(3,'Baja California Sur'),(4,'Campeche'),(5,'Coahuila'),(6,'Colima'),(7,'Chiapas'),(8,'Chihuahua'),(9,'Distrito Federal'),(10,'Durango'),(11,'Guanajuato'),(12,'Guerrero'),(13,'Hidalgo'),(14,'Jalisco'),(15,'México'),(16,'Michoacán'),(17,'Morelos'),(18,'Nayarit'),(19,'Nuevo León'),(20,'Oaxaca'),(21,'Puebla'),(22,'Querétaro'),(23,'Quintana Roo'),(24,'San Luis Potosí'),(25,'Sinaloa'),(26,'Sonora'),(27,'Tabasco'),(28,'Tamaulipas'),(29,'Tlaxcala'),(30,'Veracruz'),(31,'Yucatán'),(32,'Zacatecas');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fondocaja`
--

DROP TABLE IF EXISTS `fondocaja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fondocaja` (
  `idfondoCaja` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` float NOT NULL DEFAULT '0',
  `fecha` datetime DEFAULT NULL,
  `idUsuario` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idfondoCaja`),
  KEY `fk_fondoCaja_idUsuario_idx` (`idUsuario`),
  CONSTRAINT `fk_fondoCaja_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fondocaja`
--

LOCK TABLES `fondocaja` WRITE;
/*!40000 ALTER TABLE `fondocaja` DISABLE KEYS */;
INSERT INTO `fondocaja` VALUES (35,0,'2015-11-24 11:28:22',1);
/*!40000 ALTER TABLE `fondocaja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iniciosdesesion`
--

DROP TABLE IF EXISTS `iniciosdesesion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iniciosdesesion` (
  `IdInicio` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) unsigned DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`IdInicio`),
  KEY `fk_iniciosdesesion_idUsuario_idx` (`idUsuario`),
  CONSTRAINT `fk_iniciosdesesion_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iniciosdesesion`
--

LOCK TABLES `iniciosdesesion` WRITE;
/*!40000 ALTER TABLE `iniciosdesesion` DISABLE KEYS */;
INSERT INTO `iniciosdesesion` VALUES (1,1,'2015-11-04 21:47:12'),(2,1,'2015-11-05 10:07:38'),(3,1,'2015-11-10 08:21:09'),(4,1,'2015-11-10 09:32:34'),(5,1,'2015-11-10 12:01:56'),(6,1,'2015-11-10 12:01:56'),(7,1,'2015-11-10 12:01:56'),(8,1,'2015-11-10 12:01:56'),(9,1,'2015-11-10 12:19:04'),(10,1,'2015-11-10 13:04:28'),(11,1,'2015-11-12 10:55:42'),(12,1,'2015-11-12 11:59:15'),(13,1,'2015-11-12 12:35:12'),(14,1,'2015-11-12 15:17:53'),(15,1,'2015-11-13 09:58:03'),(16,1,'2015-11-13 09:58:03'),(17,1,'2015-11-13 10:28:21'),(18,1,'2015-11-16 18:51:23'),(19,1,'2015-11-16 19:36:26'),(20,1,'2015-11-16 20:44:06'),(21,1,'2015-11-17 00:27:09'),(22,1,'2015-11-17 11:58:11'),(23,1,'2015-11-17 11:58:11'),(24,1,'2015-11-17 12:33:26'),(25,4,'2015-11-17 18:40:05'),(26,5,'2015-11-17 18:55:50'),(27,4,'2015-11-17 20:13:50'),(28,1,'2015-11-18 08:26:51'),(29,1,'2015-11-18 08:26:51'),(30,4,'2015-11-18 08:28:18'),(31,1,'2015-11-18 09:11:22'),(32,4,'2015-11-18 10:26:25'),(33,1,'2015-11-18 11:03:03'),(34,1,'2015-11-20 07:14:50'),(35,1,'2015-11-20 09:10:50'),(36,1,'2015-11-20 09:13:46'),(37,1,'2015-11-20 09:45:41'),(38,1,'2015-11-20 11:40:01'),(39,1,'2015-11-20 11:55:01'),(40,1,'2015-11-20 12:11:03'),(41,1,'2015-11-20 12:13:50'),(42,1,'2015-11-20 13:07:51'),(43,1,'2015-11-20 13:07:51'),(44,1,'2015-11-20 13:07:51'),(45,1,'2015-11-20 13:07:51'),(46,1,'2015-11-20 13:07:51'),(47,1,'2015-11-20 13:07:51'),(48,1,'2015-11-20 13:33:49'),(49,1,'2015-11-20 14:24:03'),(50,1,'2015-11-20 14:24:03'),(51,1,'2015-11-20 14:31:25'),(52,1,'2015-11-20 14:41:10'),(53,1,'2015-11-20 16:32:53'),(54,1,'2015-11-20 15:49:38'),(55,5,'2015-11-20 15:53:04'),(56,5,'2015-11-20 15:59:33'),(57,1,'2015-11-20 22:13:42'),(58,1,'2015-11-20 22:13:42'),(59,1,'2015-11-20 22:32:12'),(60,1,'2015-11-20 22:40:36'),(61,1,'2015-11-20 23:56:01'),(62,1,'2015-11-22 22:36:30'),(63,1,'2015-11-22 22:36:30'),(64,1,'2015-11-22 22:36:31'),(65,1,'2015-11-22 23:33:44'),(66,1,'2015-11-22 23:39:43'),(67,1,'2015-11-23 23:10:53'),(68,1,'2015-11-23 23:20:09'),(69,1,'2015-11-24 00:13:56'),(70,1,'2015-11-24 01:01:08'),(71,1,'2015-11-24 01:37:37'),(72,1,'2015-11-24 02:03:16'),(73,1,'2015-11-24 02:04:49'),(74,1,'2015-11-24 02:04:49'),(75,1,'2015-11-24 11:25:49'),(76,1,'2015-11-24 11:25:49'),(77,1,'2015-11-24 13:35:16'),(78,1,'2015-11-24 13:47:13'),(79,1,'2015-11-24 23:07:36'),(80,1,'2015-11-24 23:07:36'),(81,4,'2015-11-25 01:46:43'),(82,1,'2015-11-25 12:14:22'),(83,1,'2015-11-25 22:44:55'),(84,1,'2015-11-25 22:44:55'),(85,1,'2015-11-25 23:03:45'),(86,1,'2015-11-25 23:36:37');
/*!40000 ALTER TABLE `iniciosdesesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas`
--

DROP TABLE IF EXISTS `marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marcas` (
  `idmarca` int(11) NOT NULL AUTO_INCREMENT,
  `marca` varchar(45) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idmarca`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas`
--

LOCK TABLES `marcas` WRITE;
/*!40000 ALTER TABLE `marcas` DISABLE KEYS */;
INSERT INTO `marcas` VALUES (1,'Adidas',1),(2,'asd',0),(3,'asdasd',0),(4,'e2312',0),(5,'123',0),(6,'Hurley',0),(7,'gfdfgg',0),(8,'Holi',0),(9,'Nike',1);
/*!40000 ALTER TABLE `marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientoscaja`
--

DROP TABLE IF EXISTS `movimientoscaja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movimientoscaja` (
  `idMovimiento` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` char(1) NOT NULL,
  `cantidad` float unsigned NOT NULL,
  `concepto` varchar(60) NOT NULL,
  `fecha` datetime NOT NULL,
  `idUsuario` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idMovimiento`),
  KEY `fk_movimientosCaja_idUsuario_idx` (`idUsuario`),
  CONSTRAINT `fk_movimientosCaja_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientoscaja`
--

LOCK TABLES `movimientoscaja` WRITE;
/*!40000 ALTER TABLE `movimientoscaja` DISABLE KEYS */;
INSERT INTO `movimientoscaja` VALUES (1,'1',100,'Comida','2015-11-20 10:45:43',1),(2,'2',200,'Me los encontré :D','2015-11-20 10:46:17',1),(4,'1',3,'Chicle','2015-11-20 10:50:26',1),(5,'2',200,'Clavel','2015-11-20 10:52:06',1),(6,'1',200,'Clavelito','2015-11-20 10:52:37',1),(8,'2',200,'PosS NomaZz JehEJe!!','2015-11-24 02:15:09',1);
/*!40000 ALTER TABLE `movimientoscaja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `municipios`
--

DROP TABLE IF EXISTS `municipios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `municipios` (
  `idmunicipio` int(11) NOT NULL,
  `municipio` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `idestado` int(2) NOT NULL,
  PRIMARY KEY (`idmunicipio`),
  KEY `fk_municipios_idEstado_idx` (`idestado`),
  CONSTRAINT `fk_municipios_idEstado` FOREIGN KEY (`idestado`) REFERENCES `estados` (`idestado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `municipios`
--

LOCK TABLES `municipios` WRITE;
/*!40000 ALTER TABLE `municipios` DISABLE KEYS */;
INSERT INTO `municipios` VALUES (1,'Aguascalientes',1),(2,'Asientos',1),(3,'Calvillo',1),(4,'Cosío',1),(5,'Jesús María',1),(6,'Pabellón de Arteaga',1),(7,'Rincón de Romos',1),(8,'San José de Gracia',1),(9,'Tepezalá',1),(10,'El Llano',1),(11,'San Francisco de los Romo',1),(12,'Ensenada',2),(13,'Mexicali',2),(14,'Tecate',2),(15,'Tijuana',2),(16,'Playas de Rosarito',2),(17,'Comondú',3),(18,'Mulegé',3),(19,'La Paz',3),(20,'Los Cabos',3),(21,'Loreto',3),(22,'Calkiní',4),(23,'Campeche',4),(24,'Carmen',4),(25,'Champotón',4),(26,'Hecelchakán',4),(27,'Hopelchén',4),(28,'Palizada',4),(29,'Tenabo',4),(30,'Escárcega',4),(31,'Calakmul',4),(32,'Candelaria',4),(33,'Abasolo',5),(34,'Acuña',5),(35,'Allende',5),(36,'Arteaga',5),(37,'Candela',5),(38,'Castaños',5),(39,'Cuatro Ciénegas',5),(40,'Escobedo',5),(41,'Francisco I. Madero',5),(42,'Frontera',5),(43,'General Cepeda',5),(44,'Guerrero',5),(45,'Hidalgo',5),(46,'Jiménez',5),(47,'Juárez',5),(48,'Lamadrid',5),(49,'Matamoros',5),(50,'Monclova',5),(51,'Morelos',5),(52,'Múzquiz',5),(53,'Nadadores',5),(54,'Nava',5),(55,'Ocampo',5),(56,'Parras',5),(57,'Piedras Negras',5),(58,'Progreso',5),(59,'Ramos Arizpe',5),(60,'Sabinas',5),(61,'Sacramento',5),(62,'Saltillo',5),(63,'San Buenaventura',5),(64,'San Juan de Sabinas',5),(65,'San Pedro',5),(66,'Sierra Mojada',5),(67,'Torreón',5),(68,'Viesca',5),(69,'Villa Unión',5),(70,'Zaragoza',5),(71,'Armería',6),(72,'Colima',6),(73,'Comala',6),(74,'Coquimatlán',6),(75,'Cuauhtémoc',6),(76,'Ixtlahuacán',6),(77,'Manzanillo',6),(78,'Minatitlán',6),(79,'Tecomán',6),(80,'Villa de Álvarez',6),(81,'Acacoyagua',7),(82,'Acala',7),(83,'Acapetahua',7),(84,'Altamirano',7),(85,'Amatán',7),(86,'Amatenango de la Frontera',7),(87,'Amatenango del Valle',7),(88,'Angel Albino Corzo',7),(89,'Arriaga',7),(90,'Bejucal de Ocampo',7),(91,'Bella Vista',7),(92,'Berriozábal',7),(93,'Bochil',7),(94,'El Bosque',7),(95,'Cacahoatán',7),(96,'Catazajá',7),(97,'Cintalapa',7),(98,'Coapilla',7),(99,'Comitán de Domínguez',7),(100,'La Concordia',7),(101,'Copainalá',7),(102,'Chalchihuitán',7),(103,'Chamula',7),(104,'Chanal',7),(105,'Chapultenango',7),(106,'Chenalhó',7),(107,'Chiapa de Corzo',7),(108,'Chiapilla',7),(109,'Chicoasén',7),(110,'Chicomuselo',7),(111,'Chilón',7),(112,'Escuintla',7),(113,'Francisco León',7),(114,'Frontera Comalapa',7),(115,'Frontera Hidalgo',7),(116,'La Grandeza',7),(117,'Huehuetán',7),(118,'Huixtán',7),(119,'Huitiupán',7),(120,'Huixtla',7),(121,'La Independencia',7),(122,'Ixhuatán',7),(123,'Ixtacomitán',7),(124,'Ixtapa',7),(125,'Ixtapangajoya',7),(126,'Jiquipilas',7),(127,'Jitotol',7),(128,'Juárez',7),(129,'Larráinzar',7),(130,'La Libertad',7),(131,'Mapastepec',7),(132,'Las Margaritas',7),(133,'Mazapa de Madero',7),(134,'Mazatán',7),(135,'Metapa',7),(136,'Mitontic',7),(137,'Motozintla',7),(138,'Nicolás Ruíz',7),(139,'Ocosingo',7),(140,'Ocotepec',7),(141,'Ocozocoautla de Espinosa',7),(142,'Ostuacán',7),(143,'Osumacinta',7),(144,'Oxchuc',7),(145,'Palenque',7),(146,'Pantelhó',7),(147,'Pantepec',7),(148,'Pichucalco',7),(149,'Pijijiapan',7),(150,'El Porvenir',7),(151,'Villa Comaltitlán',7),(152,'Pueblo Nuevo Solistahuacán',7),(153,'Rayón',7),(154,'Reforma',7),(155,'Las Rosas',7),(156,'Sabanilla',7),(157,'Salto de Agua',7),(158,'San Cristóbal de las Casas',7),(159,'San Fernando',7),(160,'Siltepec',7),(161,'Simojovel',7),(162,'Sitalá',7),(163,'Socoltenango',7),(164,'Solosuchiapa',7),(165,'Soyaló',7),(166,'Suchiapa',7),(167,'Suchiate',7),(168,'Sunuapa',7),(169,'Tapachula',7),(170,'Tapalapa',7),(171,'Tapilula',7),(172,'Tecpatán',7),(173,'Tenejapa',7),(174,'Teopisca',7),(175,'Tila',7),(176,'Tonalá',7),(177,'Totolapa',7),(178,'La Trinitaria',7),(179,'Tumbalá',7),(180,'Tuxtla Gutiérrez',7),(181,'Tuxtla Chico',7),(182,'Tuzantán',7),(183,'Tzimol',7),(184,'Unión Juárez',7),(185,'Venustiano Carranza',7),(186,'Villa Corzo',7),(187,'Villaflores',7),(188,'Yajalón',7),(189,'San Lucas',7),(190,'Zinacantán',7),(191,'San Juan Cancuc',7),(192,'Aldama',7),(193,'Benemérito de las Américas',7),(194,'Maravilla Tenejapa',7),(195,'Marqués de Comillas',7),(196,'Montecristo de Guerrero',7),(197,'San Andrés Duraznal',7),(198,'Santiago el Pinar',7),(199,'Ahumada',8),(200,'Aldama',8),(201,'Allende',8),(202,'Aquiles Serdán',8),(203,'Ascensión',8),(204,'Bachíniva',8),(205,'Balleza',8),(206,'Batopilas',8),(207,'Bocoyna',8),(208,'Buenaventura',8),(209,'Camargo',8),(210,'Carichí',8),(211,'Casas Grandes',8),(212,'Coronado',8),(213,'Coyame del Sotol',8),(214,'La Cruz',8),(215,'Cuauhtémoc',8),(216,'Cusihuiriachi',8),(217,'Chihuahua',8),(218,'Chínipas',8),(219,'Delicias',8),(220,'Dr. Belisario Domínguez',8),(221,'Galeana',8),(222,'Santa Isabel',8),(223,'Gómez Farías',8),(224,'Gran Morelos',8),(225,'Guachochi',8),(226,'Guadalupe',8),(227,'Guadalupe y Calvo',8),(228,'Guazapares',8),(229,'Guerrero',8),(230,'Hidalgo del Parral',8),(231,'Huejotitán',8),(232,'Ignacio Zaragoza',8),(233,'Janos',8),(234,'Jiménez',8),(235,'Juárez',8),(236,'Julimes',8),(237,'López',8),(238,'Madera',8),(239,'Maguarichi',8),(240,'Manuel Benavides',8),(241,'Matachí',8),(242,'Matamoros',8),(243,'Meoqui',8),(244,'Morelos',8),(245,'Moris',8),(246,'Namiquipa',8),(247,'Nonoava',8),(248,'Nuevo Casas Grandes',8),(249,'Ocampo',8),(250,'Ojinaga',8),(251,'Praxedis G. Guerrero',8),(252,'Riva Palacio',8),(253,'Rosales',8),(254,'Rosario',8),(255,'San Francisco de Borja',8),(256,'San Francisco de Conchos',8),(257,'San Francisco del Oro',8),(258,'Santa Bárbara',8),(259,'Satevó',8),(260,'Saucillo',8),(261,'Temósachic',8),(262,'El Tule',8),(263,'Urique',8),(264,'Uruachi',8),(265,'Valle de Zaragoza',8),(266,'Azcapotzalco',9),(267,'Coyoacán',9),(268,'Cuajimalpa de Morelos',9),(269,'Gustavo A. Madero',9),(270,'Iztacalco',9),(271,'Iztapalapa',9),(272,'La Magdalena Contreras',9),(273,'Milpa Alta',9),(274,'Álvaro Obregón',9),(275,'Tláhuac',9),(276,'Tlalpan',9),(277,'Xochimilco',9),(278,'Benito Juárez',9),(279,'Cuauhtémoc',9),(280,'Miguel Hidalgo',9),(281,'Venustiano Carranza',9),(282,'Canatlán',10),(283,'Canelas',10),(284,'Coneto de Comonfort',10),(285,'Cuencamé',10),(286,'Durango',10),(287,'General Simón Bolívar',10),(288,'Gómez Palacio',10),(289,'Guadalupe Victoria',10),(290,'Guanaceví',10),(291,'Hidalgo',10),(292,'Indé',10),(293,'Lerdo',10),(294,'Mapimí',10),(295,'Mezquital',10),(296,'Nazas',10),(297,'Nombre de Dios',10),(298,'Ocampo',10),(299,'El Oro',10),(300,'Otáez',10),(301,'Pánuco de Coronado',10),(302,'Peñón Blanco',10),(303,'Poanas',10),(304,'Pueblo Nuevo',10),(305,'Rodeo',10),(306,'San Bernardo',10),(307,'San Dimas',10),(308,'San Juan de Guadalupe',10),(309,'San Juan del Río',10),(310,'San Luis del Cordero',10),(311,'San Pedro del Gallo',10),(312,'Santa Clara',10),(313,'Santiago Papasquiaro',10),(314,'Súchil',10),(315,'Tamazula',10),(316,'Tepehuanes',10),(317,'Tlahualilo',10),(318,'Topia',10),(319,'Vicente Guerrero',10),(320,'Nuevo Ideal',10),(321,'Abasolo',11),(322,'Acámbaro',11),(323,'San Miguel de Allende',11),(324,'Apaseo el Alto',11),(325,'Apaseo el Grande',11),(326,'Atarjea',11),(327,'Celaya',11),(328,'Manuel Doblado',11),(329,'Comonfort',11),(330,'Coroneo',11),(331,'Cortazar',11),(332,'Cuerámaro',11),(333,'Doctor Mora',11),(334,'Dolores Hidalgo Cuna de la Independencia Naci',11),(335,'Guanajuato',11),(336,'Huanímaro',11),(337,'Irapuato',11),(338,'Jaral del Progreso',11),(339,'Jerécuaro',11),(340,'León',11),(341,'Moroleón',11),(342,'Ocampo',11),(343,'Pénjamo',11),(344,'Pueblo Nuevo',11),(345,'Purísima del Rincón',11),(346,'Romita',11),(347,'Salamanca',11),(348,'Salvatierra',11),(349,'San Diego de la Unión',11),(350,'San Felipe',11),(351,'San Francisco del Rincón',11),(352,'San José Iturbide',11),(353,'San Luis de la Paz',11),(354,'Santa Catarina',11),(355,'Santa Cruz de Juventino Rosas',11),(356,'Santiago Maravatío',11),(357,'Silao',11),(358,'Tarandacuao',11),(359,'Tarimoro',11),(360,'Tierra Blanca',11),(361,'Uriangato',11),(362,'Valle de Santiago',11),(363,'Victoria',11),(364,'Villagrán',11),(365,'Xichú',11),(366,'Yuriria',11),(367,'Acapulco de Juárez',12),(368,'Ahuacuotzingo',12),(369,'Ajuchitlán del Progreso',12),(370,'Alcozauca de Guerrero',12),(371,'Alpoyeca',12),(372,'Apaxtla',12),(373,'Arcelia',12),(374,'Atenango del Río',12),(375,'Atlamajalcingo del Monte',12),(376,'Atlixtac',12),(377,'Atoyac de Álvarez',12),(378,'Ayutla de los Libres',12),(379,'Azoyú',12),(380,'Benito Juárez',12),(381,'Buenavista de Cuéllar',12),(382,'Coahuayutla de José María Izazaga',12),(383,'Cocula',12),(384,'Copala',12),(385,'Copalillo',12),(386,'Copanatoyac',12),(387,'Coyuca de Benítez',12),(388,'Coyuca de Catalán',12),(389,'Cuajinicuilapa',12),(390,'Cualác',12),(391,'Cuautepec',12),(392,'Cuetzala del Progreso',12),(393,'Cutzamala de Pinzón',12),(394,'Chilapa de Álvarez',12),(395,'Chilpancingo de los Bravo',12),(396,'Florencio Villarreal',12),(397,'General Canuto A. Neri',12),(398,'General Heliodoro Castillo',12),(399,'Huamuxtitlán',12),(400,'Huitzuco de los Figueroa',12),(401,'Iguala de la Independencia',12),(402,'Igualapa',12),(403,'Ixcateopan de Cuauhtémoc',12),(404,'Zihuatanejo de Azueta',12),(405,'Juan R. Escudero',12),(406,'Leonardo Bravo',12),(407,'Malinaltepec',12),(408,'Mártir de Cuilapan',12),(409,'Metlatónoc',12),(410,'Mochitlán',12),(411,'Olinalá',12),(412,'Ometepec',12),(413,'Pedro Ascencio Alquisiras',12),(414,'Petatlán',12),(415,'Pilcaya',12),(416,'Pungarabato',12),(417,'Quechultenango',12),(418,'San Luis Acatlán',12),(419,'San Marcos',12),(420,'San Miguel Totolapan',12),(421,'Taxco de Alarcón',12),(422,'Tecoanapa',12),(423,'Técpan de Galeana',12),(424,'Teloloapan',12),(425,'Tepecoacuilco de Trujano',12),(426,'Tetipac',12),(427,'Tixtla de Guerrero',12),(428,'Tlacoachistlahuaca',12),(429,'Tlacoapa',12),(430,'Tlalchapa',12),(431,'Tlalixtaquilla de Maldonado',12),(432,'Tlapa de Comonfort',12),(433,'Tlapehuala',12),(434,'La Unión de Isidoro Montes de Oca',12),(435,'Xalpatláhuac',12),(436,'Xochihuehuetlán',12),(437,'Xochistlahuaca',12),(438,'Zapotitlán Tablas',12),(439,'Zirándaro',12),(440,'Zitlala',12),(441,'Eduardo Neri',12),(442,'Acatepec',12),(443,'Marquelia',12),(444,'Cochoapa el Grande',12),(445,'José Joaquin de Herrera',12),(446,'Juchitán',12),(447,'Iliatenco',12),(448,'Acatlán',13),(449,'Acaxochitlán',13),(450,'Actopan',13),(451,'Agua Blanca de Iturbide',13),(452,'Ajacuba',13),(453,'Alfajayucan',13),(454,'Almoloya',13),(455,'Apan',13),(456,'El Arenal',13),(457,'Atitalaquia',13),(458,'Atlapexco',13),(459,'Atotonilco el Grande',13),(460,'Atotonilco de Tula',13),(461,'Calnali',13),(462,'Cardonal',13),(463,'Cuautepec de Hinojosa',13),(464,'Chapantongo',13),(465,'Chapulhuacán',13),(466,'Chilcuautla',13),(467,'Eloxochitlán',13),(468,'Emiliano Zapata',13),(469,'Epazoyucan',13),(470,'Francisco I. Madero',13),(471,'Huasca de Ocampo',13),(472,'Huautla',13),(473,'Huazalingo',13),(474,'Huehuetla',13),(475,'Huejutla de Reyes',13),(476,'Huichapan',13),(477,'Ixmiquilpan',13),(478,'Jacala de Ledezma',13),(479,'Jaltocán',13),(480,'Juárez Hidalgo',13),(481,'Lolotla',13),(482,'Metepec',13),(483,'San Agustín Metzquititlán',13),(484,'Metztitlán',13),(485,'Mineral del Chico',13),(486,'Mineral del Monte',13),(487,'La Misión',13),(488,'Mixquiahuala de Juárez',13),(489,'Molango de Escamilla',13),(490,'Nicolás Flores',13),(491,'Nopala de Villagrán',13),(492,'Omitlán de Juárez',13),(493,'San Felipe Orizatlán',13),(494,'Pacula',13),(495,'Pachuca de Soto',13),(496,'Pisaflores',13),(497,'Progreso de Obregón',13),(498,'Mineral de la Reforma',13),(499,'San Agustín Tlaxiaca',13),(500,'San Bartolo Tutotepec',13),(501,'San Salvador',13),(502,'Santiago de Anaya',13),(503,'Santiago Tulantepec de Lugo Guerrero',13),(504,'Singuilucan',13),(505,'Tasquillo',13),(506,'Tecozautla',13),(507,'Tenango de Doria',13),(508,'Tepeapulco',13),(509,'Tepehuacán de Guerrero',13),(510,'Tepeji del Río de Ocampo',13),(511,'Tepetitlán',13),(512,'Tetepango',13),(513,'Villa de Tezontepec',13),(514,'Tezontepec de Aldama',13),(515,'Tianguistengo',13),(516,'Tizayuca',13),(517,'Tlahuelilpan',13),(518,'Tlahuiltepa',13),(519,'Tlanalapa',13),(520,'Tlanchinol',13),(521,'Tlaxcoapan',13),(522,'Tolcayuca',13),(523,'Tula de Allende',13),(524,'Tulancingo de Bravo',13),(525,'Xochiatipan',13),(526,'Xochicoatlán',13),(527,'Yahualica',13),(528,'Zacualtipán de Ángeles',13),(529,'Zapotlán de Juárez',13),(530,'Zempoala',13),(531,'Zimapán',13),(532,'Acatic',14),(533,'Acatlán de Juárez',14),(534,'Ahualulco de Mercado',14),(535,'Amacueca',14),(536,'Amatitán',14),(537,'Ameca',14),(538,'San Juanito de Escobedo',14),(539,'Arandas',14),(540,'El Arenal',14),(541,'Atemajac de Brizuela',14),(542,'Atengo',14),(543,'Atenguillo',14),(544,'Atotonilco el Alto',14),(545,'Atoyac',14),(546,'Autlán de Navarro',14),(547,'Ayotlán',14),(548,'Ayutla',14),(549,'La Barca',14),(550,'Bolaños',14),(551,'Cabo Corrientes',14),(552,'Casimiro Castillo',14),(553,'Cihuatlán',14),(554,'Zapotlán el Grande',14),(555,'Cocula',14),(556,'Colotlán',14),(557,'Concepción de Buenos Aires',14),(558,'Cuautitlán de García Barragán',14),(559,'Cuautla',14),(560,'Cuquío',14),(561,'Chapala',14),(562,'Chimaltitán',14),(563,'Chiquilistlán',14),(564,'Degollado',14),(565,'Ejutla',14),(566,'Encarnación de Díaz',14),(567,'Etzatlán',14),(568,'El Grullo',14),(569,'Guachinango',14),(570,'Guadalajara',14),(571,'Hostotipaquillo',14),(572,'Huejúcar',14),(573,'Huejuquilla el Alto',14),(574,'La Huerta',14),(575,'Ixtlahuacán de los Membrillos',14),(576,'Ixtlahuacán del Río',14),(577,'Jalostotitlán',14),(578,'Jamay',14),(579,'Jesús María',14),(580,'Jilotlán de los Dolores',14),(581,'Jocotepec',14),(582,'Juanacatlán',14),(583,'Juchitlán',14),(584,'Lagos de Moreno',14),(585,'El Limón',14),(586,'Magdalena',14),(587,'Santa María del Oro',14),(588,'La Manzanilla de la Paz',14),(589,'Mascota',14),(590,'Mazamitla',14),(591,'Mexticacán',14),(592,'Mezquitic',14),(593,'Mixtlán',14),(594,'Ocotlán',14),(595,'Ojuelos de Jalisco',14),(596,'Pihuamo',14),(597,'Poncitlán',14),(598,'Puerto Vallarta',14),(599,'Villa Purificación',14),(600,'Quitupan',14),(601,'El Salto',14),(602,'San Cristóbal de la Barranca',14),(603,'San Diego de Alejandría',14),(604,'San Juan de los Lagos',14),(605,'San Julián',14),(606,'San Marcos',14),(607,'San Martín de Bolaños',14),(608,'San Martín Hidalgo',14),(609,'San Miguel el Alto',14),(610,'Gómez Farías',14),(611,'San Sebastián del Oeste',14),(612,'Santa María de los Ángeles',14),(613,'Sayula',14),(614,'Tala',14),(615,'Talpa de Allende',14),(616,'Tamazula de Gordiano',14),(617,'Tapalpa',14),(618,'Tecalitlán',14),(619,'Tecolotlán',14),(620,'Techaluta de Montenegro',14),(621,'Tenamaxtlán',14),(622,'Teocaltiche',14),(623,'Teocuitatlán de Corona',14),(624,'Tepatitlán de Morelos',14),(625,'Tequila',14),(626,'Teuchitlán',14),(627,'Tizapán el Alto',14),(628,'Tlajomulco de Zúñiga',14),(629,'Tlaquepaque',14),(630,'Tolimán',14),(631,'Tomatlán',14),(632,'Tonalá',14),(633,'Tonaya',14),(634,'Tonila',14),(635,'Totatiche',14),(636,'Tototlán',14),(637,'Tuxcacuesco',14),(638,'Tuxcueca',14),(639,'Tuxpan',14),(640,'Unión de San Antonio',14),(641,'Unión de Tula',14),(642,'Valle de Guadalupe',14),(643,'Valle de Juárez',14),(644,'San Gabriel',14),(645,'Villa Corona',14),(646,'Villa Guerrero',14),(647,'Villa Hidalgo',14),(648,'Cañadas de Obregón',14),(649,'Yahualica de González Gallo',14),(650,'Zacoalco de Torres',14),(651,'Zapopan',14),(652,'Zapotiltic',14),(653,'Zapotitlán de Vadillo',14),(654,'Zapotlán del Rey',14),(655,'Zapotlanejo',14),(656,'San Ignacio Cerro Gordo',14),(657,'Acambay',15),(658,'Acolman',15),(659,'Aculco',15),(660,'Almoloya de Alquisiras',15),(661,'Almoloya de Juárez',15),(662,'Almoloya del Río',15),(663,'Amanalco',15),(664,'Amatepec',15),(665,'Amecameca',15),(666,'Apaxco',15),(667,'Atenco',15),(668,'Atizapán',15),(669,'Atizapán de Zaragoza',15),(670,'Atlacomulco',15),(671,'Atlautla',15),(672,'Axapusco',15),(673,'Ayapango',15),(674,'Calimaya',15),(675,'Capulhuac',15),(676,'Coacalco de Berriozábal',15),(677,'Coatepec Harinas',15),(678,'Cocotitlán',15),(679,'Coyotepec',15),(680,'Cuautitlán',15),(681,'Chalco',15),(682,'Chapa de Mota',15),(683,'Chapultepec',15),(684,'Chiautla',15),(685,'Chicoloapan',15),(686,'Chiconcuac',15),(687,'Chimalhuacán',15),(688,'Donato Guerra',15),(689,'Ecatepec de Morelos',15),(690,'Ecatzingo',15),(691,'Huehuetoca',15),(692,'Hueypoxtla',15),(693,'Huixquilucan',15),(694,'Isidro Fabela',15),(695,'Ixtapaluca',15),(696,'Ixtapan de la Sal',15),(697,'Ixtapan del Oro',15),(698,'Ixtlahuaca',15),(699,'Xalatlaco',15),(700,'Jaltenco',15),(701,'Jilotepec',15),(702,'Jilotzingo',15),(703,'Jiquipilco',15),(704,'Jocotitlán',15),(705,'Joquicingo',15),(706,'Juchitepec',15),(707,'Lerma',15),(708,'Malinalco',15),(709,'Melchor Ocampo',15),(710,'Metepec',15),(711,'Mexicaltzingo',15),(712,'Morelos',15),(713,'Naucalpan de Juárez',15),(714,'Nezahualcóyotl',15),(715,'Nextlalpan',15),(716,'Nicolás Romero',15),(717,'Nopaltepec',15),(718,'Ocoyoacac',15),(719,'Ocuilan',15),(720,'El Oro',15),(721,'Otumba',15),(722,'Otzoloapan',15),(723,'Otzolotepec',15),(724,'Ozumba',15),(725,'Papalotla',15),(726,'La Paz',15),(727,'Polotitlán',15),(728,'Rayón',15),(729,'San Antonio la Isla',15),(730,'San Felipe del Progreso',15),(731,'San Martín de las Pirámides',15),(732,'San Mateo Atenco',15),(733,'San Simón de Guerrero',15),(734,'Santo Tomás',15),(735,'Soyaniquilpan de Juárez',15),(736,'Sultepec',15),(737,'Tecámac',15),(738,'Tejupilco',15),(739,'Temamatla',15),(740,'Temascalapa',15),(741,'Temascalcingo',15),(742,'Temascaltepec',15),(743,'Temoaya',15),(744,'Tenancingo',15),(745,'Tenango del Aire',15),(746,'Tenango del Valle',15),(747,'Teoloyucán',15),(748,'Teotihuacán',15),(749,'Tepetlaoxtoc',15),(750,'Tepetlixpa',15),(751,'Tepotzotlán',15),(752,'Tequixquiac',15),(753,'Texcaltitlán',15),(754,'Texcalyacac',15),(755,'Texcoco',15),(756,'Tezoyuca',15),(757,'Tianguistenco',15),(758,'Timilpan',15),(759,'Tlalmanalco',15),(760,'Tlalnepantla de Baz',15),(761,'Tlatlaya',15),(762,'Toluca',15),(763,'Tonatico',15),(764,'Tultepec',15),(765,'Tultitlán',15),(766,'Valle de Bravo',15),(767,'Villa de Allende',15),(768,'Villa del Carbón',15),(769,'Villa Guerrero',15),(770,'Villa Victoria',15),(771,'Xonacatlán',15),(772,'Zacazonapan',15),(773,'Zacualpan',15),(774,'Zinacantepec',15),(775,'Zumpahuacán',15),(776,'Zumpango',15),(777,'Cuautitlán Izcalli',15),(778,'Valle de Chalco Solidaridad',15),(779,'Luvianos',15),(780,'San José del Rincón',15),(781,'Tonanitla',15),(782,'Acuitzio',16),(783,'Aguililla',16),(784,'Álvaro Obregón',16),(785,'Angamacutiro',16),(786,'Angangueo',16),(787,'Apatzingán',16),(788,'Aporo',16),(789,'Aquila',16),(790,'Ario',16),(791,'Arteaga',16),(792,'Briseñas',16),(793,'Buenavista',16),(794,'Carácuaro',16),(795,'Coahuayana',16),(796,'Coalcomán de Vázquez Pallares',16),(797,'Coeneo',16),(798,'Contepec',16),(799,'Copándaro',16),(800,'Cotija',16),(801,'Cuitzeo',16),(802,'Charapan',16),(803,'Charo',16),(804,'Chavinda',16),(805,'Cherán',16),(806,'Chilchota',16),(807,'Chinicuila',16),(808,'Chucándiro',16),(809,'Churintzio',16),(810,'Churumuco',16),(811,'Ecuandureo',16),(812,'Epitacio Huerta',16),(813,'Erongarícuaro',16),(814,'Gabriel Zamora',16),(815,'Hidalgo',16),(816,'La Huacana',16),(817,'Huandacareo',16),(818,'Huaniqueo',16),(819,'Huetamo',16),(820,'Huiramba',16),(821,'Indaparapeo',16),(822,'Irimbo',16),(823,'Ixtlán',16),(824,'Jacona',16),(825,'Jiménez',16),(826,'Jiquilpan',16),(827,'Juárez',16),(828,'Jungapeo',16),(829,'Lagunillas',16),(830,'Madero',16),(831,'Maravatío',16),(832,'Marcos Castellanos',16),(833,'Lázaro Cárdenas',16),(834,'Morelia',16),(835,'Morelos',16),(836,'Múgica',16),(837,'Nahuatzen',16),(838,'Nocupétaro',16),(839,'Nuevo Parangaricutiro',16),(840,'Nuevo Urecho',16),(841,'Numarán',16),(842,'Ocampo',16),(843,'Pajacuarán',16),(844,'Panindícuaro',16),(845,'Parácuaro',16),(846,'Paracho',16),(847,'Pátzcuaro',16),(848,'Penjamillo',16),(849,'Peribán',16),(850,'La Piedad',16),(851,'Purépero',16),(852,'Puruándiro',16),(853,'Queréndaro',16),(854,'Quiroga',16),(855,'Cojumatlán de Régules',16),(856,'Los Reyes',16),(857,'Sahuayo',16),(858,'San Lucas',16),(859,'Santa Ana Maya',16),(860,'Salvador Escalante',16),(861,'Senguio',16),(862,'Susupuato',16),(863,'Tacámbaro',16),(864,'Tancítaro',16),(865,'Tangamandapio',16),(866,'Tangancícuaro',16),(867,'Tanhuato',16),(868,'Taretan',16),(869,'Tarímbaro',16),(870,'Tepalcatepec',16),(871,'Tingambato',16),(872,'Tingüindín',16),(873,'Tiquicheo de Nicolás Romero',16),(874,'Tlalpujahua',16),(875,'Tlazazalca',16),(876,'Tocumbo',16),(877,'Tumbiscatío',16),(878,'Turicato',16),(879,'Tuxpan',16),(880,'Tuzantla',16),(881,'Tzintzuntzan',16),(882,'Tzitzio',16),(883,'Uruapan',16),(884,'Venustiano Carranza',16),(885,'Villamar',16),(886,'Vista Hermosa',16),(887,'Yurécuaro',16),(888,'Zacapu',16),(889,'Zamora',16),(890,'Zináparo',16),(891,'Zinapécuaro',16),(892,'Ziracuaretiro',16),(893,'Zitácuaro',16),(894,'José Sixto Verduzco',16),(895,'Amacuzac',17),(896,'Atlatlahucan',17),(897,'Axochiapan',17),(898,'Ayala',17),(899,'Coatlán del Río',17),(900,'Cuautla',17),(901,'Cuernavaca',17),(902,'Emiliano Zapata',17),(903,'Huitzilac',17),(904,'Jantetelco',17),(905,'Jiutepec',17),(906,'Jojutla',17),(907,'Jonacatepec',17),(908,'Mazatepec',17),(909,'Miacatlán',17),(910,'Ocuituco',17),(911,'Puente de Ixtla',17),(912,'Temixco',17),(913,'Tepalcingo',17),(914,'Tepoztlán',17),(915,'Tetecala',17),(916,'Tetela del Volcán',17),(917,'Tlalnepantla',17),(918,'Tlaltizapán',17),(919,'Tlaquiltenango',17),(920,'Tlayacapan',17),(921,'Totolapan',17),(922,'Xochitepec',17),(923,'Yautepec',17),(924,'Yecapixtla',17),(925,'Zacatepec',17),(926,'Zacualpan',17),(927,'Temoac',17),(928,'Acaponeta',18),(929,'Ahuacatlán',18),(930,'Amatlán de Cañas',18),(931,'Compostela',18),(932,'Huajicori',18),(933,'Ixtlán del Río',18),(934,'Jala',18),(935,'Xalisco',18),(936,'Del Nayar',18),(937,'Rosamorada',18),(938,'Ruíz',18),(939,'San Blas',18),(940,'San Pedro Lagunillas',18),(941,'Santa María del Oro',18),(942,'Santiago Ixcuintla',18),(943,'Tecuala',18),(944,'Tepic',18),(945,'Tuxpan',18),(946,'La Yesca',18),(947,'Bahía de Banderas',18),(948,'Abasolo',19),(949,'Agualeguas',19),(950,'Los Aldamas',19),(951,'Allende',19),(952,'Anáhuac',19),(953,'Apodaca',19),(954,'Aramberri',19),(955,'Bustamante',19),(956,'Cadereyta Jiménez',19),(957,'Carmen',19),(958,'Cerralvo',19),(959,'Ciénega de Flores',19),(960,'China',19),(961,'Dr. Arroyo',19),(962,'Dr. Coss',19),(963,'Dr. González',19),(964,'Galeana',19),(965,'García',19),(966,'San Pedro Garza García',19),(967,'Gral. Bravo',19),(968,'Gral. Escobedo',19),(969,'Gral. Terán',19),(970,'Gral. Treviño',19),(971,'Gral. Zaragoza',19),(972,'Gral. Zuazua',19),(973,'Guadalupe',19),(974,'Los Herreras',19),(975,'Higueras',19),(976,'Hualahuises',19),(977,'Iturbide',19),(978,'Juárez',19),(979,'Lampazos de Naranjo',19),(980,'Linares',19),(981,'Marín',19),(982,'Melchor Ocampo',19),(983,'Mier y Noriega',19),(984,'Mina',19),(985,'Montemorelos',19),(986,'Monterrey',19),(987,'Parás',19),(988,'Pesquería',19),(989,'Los Ramones',19),(990,'Rayones',19),(991,'Sabinas Hidalgo',19),(992,'Salinas Victoria',19),(993,'San Nicolás de los Garza',19),(994,'Hidalgo',19),(995,'Santa Catarina',19),(996,'Santiago',19),(997,'Vallecillo',19),(998,'Villaldama',19),(999,'Abejones',20),(1000,'Acatlán de Pérez Figueroa',20),(1001,'Asunción Cacalotepec',20),(1002,'Asunción Cuyotepeji',20),(1003,'Asunción Ixtaltepec',20),(1004,'Asunción Nochixtlán',20),(1005,'Asunción Ocotlán',20),(1006,'Asunción Tlacolulita',20),(1007,'Ayotzintepec',20),(1008,'El Barrio de la Soledad',20),(1009,'Calihualá',20),(1010,'Candelaria Loxicha',20),(1011,'Ciénega de Zimatlán',20),(1012,'Ciudad Ixtepec',20),(1013,'Coatecas Altas',20),(1014,'Coicoyán de las Flores',20),(1015,'La Compañía',20),(1016,'Concepción Buenavista',20),(1017,'Concepción Pápalo',20),(1018,'Constancia del Rosario',20),(1019,'Cosolapa',20),(1020,'Cosoltepec',20),(1021,'Cuilápam de Guerrero',20),(1022,'Cuyamecalco Villa de Zaragoza',20),(1023,'Chahuites',20),(1024,'Chalcatongo de Hidalgo',20),(1025,'Chiquihuitlán de Benito Juárez',20),(1026,'Heroica Ciudad de Ejutla de Crespo',20),(1027,'Eloxochitlán de Flores Magón',20),(1028,'El Espinal',20),(1029,'Tamazulápam del Espíritu Santo',20),(1030,'Fresnillo de Trujano',20),(1031,'Guadalupe Etla',20),(1032,'Guadalupe de Ramírez',20),(1033,'Guelatao de Juárez',20),(1034,'Guevea de Humboldt',20),(1035,'Mesones Hidalgo',20),(1036,'Villa Hidalgo',20),(1037,'Heroica Ciudad de Huajuapan de León',20),(1038,'Huautepec',20),(1039,'Huautla de Jiménez',20),(1040,'Ixtlán de Juárez',20),(1041,'Heroica Ciudad de Juchitán de Zaragoza',20),(1042,'Loma Bonita',20),(1043,'Magdalena Apasco',20),(1044,'Magdalena Jaltepec',20),(1045,'Santa Magdalena Jicotlán',20),(1046,'Magdalena Mixtepec',20),(1047,'Magdalena Ocotlán',20),(1048,'Magdalena Peñasco',20),(1049,'Magdalena Teitipac',20),(1050,'Magdalena Tequisistlán',20),(1051,'Magdalena Tlacotepec',20),(1052,'Magdalena Zahuatlán',20),(1053,'Mariscala de Juárez',20),(1054,'Mártires de Tacubaya',20),(1055,'Matías Romero Avendaño',20),(1056,'Mazatlán Villa de Flores',20),(1057,'Miahuatlán de Porfirio Díaz',20),(1058,'Mixistlán de la Reforma',20),(1059,'Monjas',20),(1060,'Natividad',20),(1061,'Nazareno Etla',20),(1062,'Nejapa de Madero',20),(1063,'Ixpantepec Nieves',20),(1064,'Santiago Niltepec',20),(1065,'Oaxaca de Juárez',20),(1066,'Ocotlán de Morelos',20),(1067,'La Pe',20),(1068,'Pinotepa de Don Luis',20),(1069,'Pluma Hidalgo',20),(1070,'San José del Progreso',20),(1071,'Putla Villa de Guerrero',20),(1072,'Santa Catarina Quioquitani',20),(1073,'Reforma de Pineda',20),(1074,'La Reforma',20),(1075,'Reyes Etla',20),(1076,'Rojas de Cuauhtémoc',20),(1077,'Salina Cruz',20),(1078,'San Agustín Amatengo',20),(1079,'San Agustín Atenango',20),(1080,'San Agustín Chayuco',20),(1081,'San Agustín de las Juntas',20),(1082,'San Agustín Etla',20),(1083,'San Agustín Loxicha',20),(1084,'San Agustín Tlacotepec',20),(1085,'San Agustín Yatareni',20),(1086,'San Andrés Cabecera Nueva',20),(1087,'San Andrés Dinicuiti',20),(1088,'San Andrés Huaxpaltepec',20),(1089,'San Andrés Huayápam',20),(1090,'San Andrés Ixtlahuaca',20),(1091,'San Andrés Lagunas',20),(1092,'San Andrés Nuxiño',20),(1093,'San Andrés Paxtlán',20),(1094,'San Andrés Sinaxtla',20),(1095,'San Andrés Solaga',20),(1096,'San Andrés Teotilálpam',20),(1097,'San Andrés Tepetlapa',20),(1098,'San Andrés Yaá',20),(1099,'San Andrés Zabache',20),(1100,'San Andrés Zautla',20),(1101,'San Antonino Castillo Velasco',20),(1102,'San Antonino el Alto',20),(1103,'San Antonino Monte Verde',20),(1104,'San Antonio Acutla',20),(1105,'San Antonio de la Cal',20),(1106,'San Antonio Huitepec',20),(1107,'San Antonio Nanahuatípam',20),(1108,'San Antonio Sinicahua',20),(1109,'San Antonio Tepetlapa',20),(1110,'San Baltazar Chichicápam',20),(1111,'San Baltazar Loxicha',20),(1112,'San Baltazar Yatzachi el Bajo',20),(1113,'San Bartolo Coyotepec',20),(1114,'San Bartolomé Ayautla',20),(1115,'San Bartolomé Loxicha',20),(1116,'San Bartolomé Quialana',20),(1117,'San Bartolomé Yucuañe',20),(1118,'San Bartolomé Zoogocho',20),(1119,'San Bartolo Soyaltepec',20),(1120,'San Bartolo Yautepec',20),(1121,'San Bernardo Mixtepec',20),(1122,'San Blas Atempa',20),(1123,'San Carlos Yautepec',20),(1124,'San Cristóbal Amatlán',20),(1125,'San Cristóbal Amoltepec',20),(1126,'San Cristóbal Lachirioag',20),(1127,'San Cristóbal Suchixtlahuaca',20),(1128,'San Dionisio del Mar',20),(1129,'San Dionisio Ocotepec',20),(1130,'San Dionisio Ocotlán',20),(1131,'San Esteban Atatlahuca',20),(1132,'San Felipe Jalapa de Díaz',20),(1133,'San Felipe Tejalápam',20),(1134,'San Felipe Usila',20),(1135,'San Francisco Cahuacuá',20),(1136,'San Francisco Cajonos',20),(1137,'San Francisco Chapulapa',20),(1138,'San Francisco Chindúa',20),(1139,'San Francisco del Mar',20),(1140,'San Francisco Huehuetlán',20),(1141,'San Francisco Ixhuatán',20),(1142,'San Francisco Jaltepetongo',20),(1143,'San Francisco Lachigoló',20),(1144,'San Francisco Logueche',20),(1145,'San Francisco Nuxaño',20),(1146,'San Francisco Ozolotepec',20),(1147,'San Francisco Sola',20),(1148,'San Francisco Telixtlahuaca',20),(1149,'San Francisco Teopan',20),(1150,'San Francisco Tlapancingo',20),(1151,'San Gabriel Mixtepec',20),(1152,'San Ildefonso Amatlán',20),(1153,'San Ildefonso Sola',20),(1154,'San Ildefonso Villa Alta',20),(1155,'San Jacinto Amilpas',20),(1156,'San Jacinto Tlacotepec',20),(1157,'San Jerónimo Coatlán',20),(1158,'San Jerónimo Silacayoapilla',20),(1159,'San Jerónimo Sosola',20),(1160,'San Jerónimo Taviche',20),(1161,'San Jerónimo Tecóatl',20),(1162,'San Jorge Nuchita',20),(1163,'San José Ayuquila',20),(1164,'San José Chiltepec',20),(1165,'San José del Peñasco',20),(1166,'San José Estancia Grande',20),(1167,'San José Independencia',20),(1168,'San José Lachiguiri',20),(1169,'San José Tenango',20),(1170,'San Juan Achiutla',20),(1171,'San Juan Atepec',20),(1172,'Ánimas Trujano',20),(1173,'San Juan Bautista Atatlahuca',20),(1174,'San Juan Bautista Coixtlahuaca',20),(1175,'San Juan Bautista Cuicatlán',20),(1176,'San Juan Bautista Guelache',20),(1177,'San Juan Bautista Jayacatlán',20),(1178,'San Juan Bautista Lo de Soto',20),(1179,'San Juan Bautista Suchitepec',20),(1180,'San Juan Bautista Tlacoatzintepec',20),(1181,'San Juan Bautista Tlachichilco',20),(1182,'San Juan Bautista Tuxtepec',20),(1183,'San Juan Cacahuatepec',20),(1184,'San Juan Cieneguilla',20),(1185,'San Juan Coatzóspam',20),(1186,'San Juan Colorado',20),(1187,'San Juan Comaltepec',20),(1188,'San Juan Cotzocón',20),(1189,'San Juan Chicomezúchil',20),(1190,'San Juan Chilateca',20),(1191,'San Juan del Estado',20),(1192,'San Juan del Río',20),(1193,'San Juan Diuxi',20),(1194,'San Juan Evangelista Analco',20),(1195,'San Juan Guelavía',20),(1196,'San Juan Guichicovi',20),(1197,'San Juan Ihualtepec',20),(1198,'San Juan Juquila Mixes',20),(1199,'San Juan Juquila Vijanos',20),(1200,'San Juan Lachao',20),(1201,'San Juan Lachigalla',20),(1202,'San Juan Lajarcia',20),(1203,'San Juan Lalana',20),(1204,'San Juan de los Cués',20),(1205,'San Juan Mazatlán',20),(1206,'San Juan Mixtepec -Dto. 08 -',20),(1207,'San Juan Mixtepec -Dto. 26 -',20),(1208,'San Juan Ñumí',20),(1209,'San Juan Ozolotepec',20),(1210,'San Juan Petlapa',20),(1211,'San Juan Quiahije',20),(1212,'San Juan Quiotepec',20),(1213,'San Juan Sayultepec',20),(1214,'San Juan Tabaá',20),(1215,'San Juan Tamazola',20),(1216,'San Juan Teita',20),(1217,'San Juan Teitipac',20),(1218,'San Juan Tepeuxila',20),(1219,'San Juan Teposcolula',20),(1220,'San Juan Yaeé',20),(1221,'San Juan Yatzona',20),(1222,'San Juan Yucuita',20),(1223,'San Lorenzo',20),(1224,'San Lorenzo Albarradas',20),(1225,'San Lorenzo Cacaotepec',20),(1226,'San Lorenzo Cuaunecuiltitla',20),(1227,'San Lorenzo Texmelúcan',20),(1228,'San Lorenzo Victoria',20),(1229,'San Lucas Camotlán',20),(1230,'San Lucas Ojitlán',20),(1231,'San Lucas Quiaviní',20),(1232,'San Lucas Zoquiápam',20),(1233,'San Luis Amatlán',20),(1234,'San Marcial Ozolotepec',20),(1235,'San Marcos Arteaga',20),(1236,'San Martín de los Cansecos',20),(1237,'San Martín Huamelúlpam',20),(1238,'San Martín Itunyoso',20),(1239,'San Martín Lachilá',20),(1240,'San Martín Peras',20),(1241,'San Martín Tilcajete',20),(1242,'San Martín Toxpalan',20),(1243,'San Martín Zacatepec',20),(1244,'San Mateo Cajonos',20),(1245,'Capulálpam de Méndez',20),(1246,'San Mateo del Mar',20),(1247,'San Mateo Yoloxochitlán',20),(1248,'San Mateo Etlatongo',20),(1249,'San Mateo Nejápam',20),(1250,'San Mateo Peñasco',20),(1251,'San Mateo Piñas',20),(1252,'San Mateo Río Hondo',20),(1253,'San Mateo Sindihui',20),(1254,'San Mateo Tlapiltepec',20),(1255,'San Melchor Betaza',20),(1256,'San Miguel Achiutla',20),(1257,'San Miguel Ahuehuetitlán',20),(1258,'San Miguel Aloápam',20),(1259,'San Miguel Amatitlán',20),(1260,'San Miguel Amatlán',20),(1261,'San Miguel Coatlán',20),(1262,'San Miguel Chicahua',20),(1263,'San Miguel Chimalapa',20),(1264,'San Miguel del Puerto',20),(1265,'San Miguel del Río',20),(1266,'San Miguel Ejutla',20),(1267,'San Miguel el Grande',20),(1268,'San Miguel Huautla',20),(1269,'San Miguel Mixtepec',20),(1270,'San Miguel Panixtlahuaca',20),(1271,'San Miguel Peras',20),(1272,'San Miguel Piedras',20),(1273,'San Miguel Quetzaltepec',20),(1274,'San Miguel Santa Flor',20),(1275,'Villa Sola de Vega',20),(1276,'San Miguel Soyaltepec',20),(1277,'San Miguel Suchixtepec',20),(1278,'Villa Talea de Castro',20),(1279,'San Miguel Tecomatlán',20),(1280,'San Miguel Tenango',20),(1281,'San Miguel Tequixtepec',20),(1282,'San Miguel Tilquiápam',20),(1283,'San Miguel Tlacamama',20),(1284,'San Miguel Tlacotepec',20),(1285,'San Miguel Tulancingo',20),(1286,'San Miguel Yotao',20),(1287,'San Nicolás',20),(1288,'San Nicolás Hidalgo',20),(1289,'San Pablo Coatlán',20),(1290,'San Pablo Cuatro Venados',20),(1291,'San Pablo Etla',20),(1292,'San Pablo Huitzo',20),(1293,'San Pablo Huixtepec',20),(1294,'San Pablo Macuiltianguis',20),(1295,'San Pablo Tijaltepec',20),(1296,'San Pablo Villa de Mitla',20),(1297,'San Pablo Yaganiza',20),(1298,'San Pedro Amuzgos',20),(1299,'San Pedro Apóstol',20),(1300,'San Pedro Atoyac',20),(1301,'San Pedro Cajonos',20),(1302,'San Pedro Coxcaltepec Cántaros',20),(1303,'San Pedro Comitancillo',20),(1304,'San Pedro el Alto',20),(1305,'San Pedro Huamelula',20),(1306,'San Pedro Huilotepec',20),(1307,'San Pedro Ixcatlán',20),(1308,'San Pedro Ixtlahuaca',20),(1309,'San Pedro Jaltepetongo',20),(1310,'San Pedro Jicayán',20),(1311,'San Pedro Jocotipac',20),(1312,'San Pedro Juchatengo',20),(1313,'San Pedro Mártir',20),(1314,'San Pedro Mártir Quiechapa',20),(1315,'San Pedro Mártir Yucuxaco',20),(1316,'San Pedro Mixtepec -Dto. 22 -',20),(1317,'San Pedro Mixtepec -Dto. 26 -',20),(1318,'San Pedro Molinos',20),(1319,'San Pedro Nopala',20),(1320,'San Pedro Ocopetatillo',20),(1321,'San Pedro Ocotepec',20),(1322,'San Pedro Pochutla',20),(1323,'San Pedro Quiatoni',20),(1324,'San Pedro Sochiápam',20),(1325,'San Pedro Tapanatepec',20),(1326,'San Pedro Taviche',20),(1327,'San Pedro Teozacoalco',20),(1328,'San Pedro Teutila',20),(1329,'San Pedro Tidaá',20),(1330,'San Pedro Topiltepec',20),(1331,'San Pedro Totolápam',20),(1332,'Villa de Tututepec de Melchor Ocampo',20),(1333,'San Pedro Yaneri',20),(1334,'San Pedro Yólox',20),(1335,'San Pedro y San Pablo Ayutla',20),(1336,'Villa de Etla',20),(1337,'San Pedro y San Pablo Teposcolula',20),(1338,'San Pedro y San Pablo Tequixtepec',20),(1339,'San Pedro Yucunama',20),(1340,'San Raymundo Jalpan',20),(1341,'San Sebastián Abasolo',20),(1342,'San Sebastián Coatlán',20),(1343,'San Sebastián Ixcapa',20),(1344,'San Sebastián Nicananduta',20),(1345,'San Sebastián Río Hondo',20),(1346,'San Sebastián Tecomaxtlahuaca',20),(1347,'San Sebastián Teitipac',20),(1348,'San Sebastián Tutla',20),(1349,'San Simón Almolongas',20),(1350,'San Simón Zahuatlán',20),(1351,'Santa Ana',20),(1352,'Santa Ana Ateixtlahuaca',20),(1353,'Santa Ana Cuauhtémoc',20),(1354,'Santa Ana del Valle',20),(1355,'Santa Ana Tavela',20),(1356,'Santa Ana Tlapacoyan',20),(1357,'Santa Ana Yareni',20),(1358,'Santa Ana Zegache',20),(1359,'Santa Catalina Quierí',20),(1360,'Santa Catarina Cuixtla',20),(1361,'Santa Catarina Ixtepeji',20),(1362,'Santa Catarina Juquila',20),(1363,'Santa Catarina Lachatao',20),(1364,'Santa Catarina Loxicha',20),(1365,'Santa Catarina Mechoacán',20),(1366,'Santa Catarina Minas',20),(1367,'Santa Catarina Quiané',20),(1368,'Santa Catarina Tayata',20),(1369,'Santa Catarina Ticuá',20),(1370,'Santa Catarina Yosonotú',20),(1371,'Santa Catarina Zapoquila',20),(1372,'Santa Cruz Acatepec',20),(1373,'Santa Cruz Amilpas',20),(1374,'Santa Cruz de Bravo',20),(1375,'Santa Cruz Itundujia',20),(1376,'Santa Cruz Mixtepec',20),(1377,'Santa Cruz Nundaco',20),(1378,'Santa Cruz Papalutla',20),(1379,'Santa Cruz Tacache de Mina',20),(1380,'Santa Cruz Tacahua',20),(1381,'Santa Cruz Tayata',20),(1382,'Santa Cruz Xitla',20),(1383,'Santa Cruz Xoxocotlán',20),(1384,'Santa Cruz Zenzontepec',20),(1385,'Santa Gertrudis',20),(1386,'Santa Inés del Monte',20),(1387,'Santa Inés Yatzeche',20),(1388,'Santa Lucía del Camino',20),(1389,'Santa Lucía Miahuatlán',20),(1390,'Santa Lucía Monteverde',20),(1391,'Santa Lucía Ocotlán',20),(1392,'Santa María Alotepec',20),(1393,'Santa María Apazco',20),(1394,'Santa María la Asunción',20),(1395,'Heroica Ciudad de Tlaxiaco',20),(1396,'Ayoquezco de Aldama',20),(1397,'Santa María Atzompa',20),(1398,'Santa María Camotlán',20),(1399,'Santa María Colotepec',20),(1400,'Santa María Cortijo',20),(1401,'Santa María Coyotepec',20),(1402,'Santa María Chachoápam',20),(1403,'Villa de Chilapa de Díaz',20),(1404,'Santa María Chilchotla',20),(1405,'Santa María Chimalapa',20),(1406,'Santa María del Rosario',20),(1407,'Santa María del Tule',20),(1408,'Santa María Ecatepec',20),(1409,'Santa María Guelacé',20),(1410,'Santa María Guienagati',20),(1411,'Santa María Huatulco',20),(1412,'Santa María Huazolotitlán',20),(1413,'Santa María Ipalapa',20),(1414,'Santa María Ixcatlán',20),(1415,'Santa María Jacatepec',20),(1416,'Santa María Jalapa del Marqués',20),(1417,'Santa María Jaltianguis',20),(1418,'Santa María Lachixío',20),(1419,'Santa María Mixtequilla',20),(1420,'Santa María Nativitas',20),(1421,'Santa María Nduayaco',20),(1422,'Santa María Ozolotepec',20),(1423,'Santa María Pápalo',20),(1424,'Santa María Peñoles',20),(1425,'Santa María Petapa',20),(1426,'Santa María Quiegolani',20),(1427,'Santa María Sola',20),(1428,'Santa María Tataltepec',20),(1429,'Santa María Tecomavaca',20),(1430,'Santa María Temaxcalapa',20),(1431,'Santa María Temaxcaltepec',20),(1432,'Santa María Teopoxco',20),(1433,'Santa María Tepantlali',20),(1434,'Santa María Texcatitlán',20),(1435,'Santa María Tlahuitoltepec',20),(1436,'Santa María Tlalixtac',20),(1437,'Santa María Tonameca',20),(1438,'Santa María Totolapilla',20),(1439,'Santa María Xadani',20),(1440,'Santa María Yalina',20),(1441,'Santa María Yavesía',20),(1442,'Santa María Yolotepec',20),(1443,'Santa María Yosoyúa',20),(1444,'Santa María Yucuhiti',20),(1445,'Santa María Zacatepec',20),(1446,'Santa María Zaniza',20),(1447,'Santa María Zoquitlán',20),(1448,'Santiago Amoltepec',20),(1449,'Santiago Apoala',20),(1450,'Santiago Apóstol',20),(1451,'Santiago Astata',20),(1452,'Santiago Atitlán',20),(1453,'Santiago Ayuquililla',20),(1454,'Santiago Cacaloxtepec',20),(1455,'Santiago Camotlán',20),(1456,'Santiago Comaltepec',20),(1457,'Santiago Chazumba',20),(1458,'Santiago Choápam',20),(1459,'Santiago del Río',20),(1460,'Santiago Huajolotitlán',20),(1461,'Santiago Huauclilla',20),(1462,'Santiago Ihuitlán Plumas',20),(1463,'Santiago Ixcuintepec',20),(1464,'Santiago Ixtayutla',20),(1465,'Santiago Jamiltepec',20),(1466,'Santiago Jocotepec',20),(1467,'Santiago Juxtlahuaca',20),(1468,'Santiago Lachiguiri',20),(1469,'Santiago Lalopa',20),(1470,'Santiago Laollaga',20),(1471,'Santiago Laxopa',20),(1472,'Santiago Llano Grande',20),(1473,'Santiago Matatlán',20),(1474,'Santiago Miltepec',20),(1475,'Santiago Minas',20),(1476,'Santiago Nacaltepec',20),(1477,'Santiago Nejapilla',20),(1478,'Santiago Nundiche',20),(1479,'Santiago Nuyoó',20),(1480,'Santiago Pinotepa Nacional',20),(1481,'Santiago Suchilquitongo',20),(1482,'Santiago Tamazola',20),(1483,'Santiago Tapextla',20),(1484,'Villa Tejúpam de la Unión',20),(1485,'Santiago Tenango',20),(1486,'Santiago Tepetlapa',20),(1487,'Santiago Tetepec',20),(1488,'Santiago Texcalcingo',20),(1489,'Santiago Textitlán',20),(1490,'Santiago Tilantongo',20),(1491,'Santiago Tillo',20),(1492,'Santiago Tlazoyaltepec',20),(1493,'Santiago Xanica',20),(1494,'Santiago Xiacuí',20),(1495,'Santiago Yaitepec',20),(1496,'Santiago Yaveo',20),(1497,'Santiago Yolomécatl',20),(1498,'Santiago Yosondúa',20),(1499,'Santiago Yucuyachi',20),(1500,'Santiago Zacatepec',20),(1501,'Santiago Zoochila',20),(1502,'Nuevo Zoquiápam',20),(1503,'Santo Domingo Ingenio',20),(1504,'Santo Domingo Albarradas',20),(1505,'Santo Domingo Armenta',20),(1506,'Santo Domingo Chihuitán',20),(1507,'Santo Domingo de Morelos',20),(1508,'Santo Domingo Ixcatlán',20),(1509,'Santo Domingo Nuxaá',20),(1510,'Santo Domingo Ozolotepec',20),(1511,'Santo Domingo Petapa',20),(1512,'Santo Domingo Roayaga',20),(1513,'Santo Domingo Tehuantepec',20),(1514,'Santo Domingo Teojomulco',20),(1515,'Santo Domingo Tepuxtepec',20),(1516,'Santo Domingo Tlatayápam',20),(1517,'Santo Domingo Tomaltepec',20),(1518,'Santo Domingo Tonalá',20),(1519,'Santo Domingo Tonaltepec',20),(1520,'Santo Domingo Xagacía',20),(1521,'Santo Domingo Yanhuitlán',20),(1522,'Santo Domingo Yodohino',20),(1523,'Santo Domingo Zanatepec',20),(1524,'Santos Reyes Nopala',20),(1525,'Santos Reyes Pápalo',20),(1526,'Santos Reyes Tepejillo',20),(1527,'Santos Reyes Yucuná',20),(1528,'Santo Tomás Jalieza',20),(1529,'Santo Tomás Mazaltepec',20),(1530,'Santo Tomás Ocotepec',20),(1531,'Santo Tomás Tamazulapan',20),(1532,'San Vicente Coatlán',20),(1533,'San Vicente Lachixío',20),(1534,'San Vicente Nuñú',20),(1535,'Silacayoápam',20),(1536,'Sitio de Xitlapehua',20),(1537,'Soledad Etla',20),(1538,'Villa de Tamazulápam del Progreso',20),(1539,'Tanetze de Zaragoza',20),(1540,'Taniche',20),(1541,'Tataltepec de Valdés',20),(1542,'Teococuilco de Marcos Pérez',20),(1543,'Teotitlán de Flores Magón',20),(1544,'Teotitlán del Valle',20),(1545,'Teotongo',20),(1546,'Tepelmeme Villa de Morelos',20),(1547,'Tezoatlán de Segura y Luna',20),(1548,'San Jerónimo Tlacochahuaya',20),(1549,'Tlacolula de Matamoros',20),(1550,'Tlacotepec Plumas',20),(1551,'Tlalixtac de Cabrera',20),(1552,'Totontepec Villa de Morelos',20),(1553,'Trinidad Zaachila',20),(1554,'La Trinidad Vista Hermosa',20),(1555,'Unión Hidalgo',20),(1556,'Valerio Trujano',20),(1557,'San Juan Bautista Valle Nacional',20),(1558,'Villa Díaz Ordaz',20),(1559,'Yaxe',20),(1560,'Magdalena Yodocono de Porfirio Díaz',20),(1561,'Yogana',20),(1562,'Yutanduchi de Guerrero',20),(1563,'Villa de Zaachila',20),(1564,'Zapotitlán del Río',20),(1565,'Zapotitlán Lagunas',20),(1566,'Zapotitlán Palmas',20),(1567,'Santa Inés de Zaragoza',20),(1568,'Zimatlán de Álvarez',20),(1569,'Acajete',21),(1570,'Acateno',21),(1571,'Acatlán',21),(1572,'Acatzingo',21),(1573,'Acteopan',21),(1574,'Ahuacatlán',21),(1575,'Ahuatlán',21),(1576,'Ahuazotepec',21),(1577,'Ahuehuetitla',21),(1578,'Ajalpan',21),(1579,'Albino Zertuche',21),(1580,'Aljojuca',21),(1581,'Altepexi',21),(1582,'Amixtlán',21),(1583,'Amozoc',21),(1584,'Aquixtla',21),(1585,'Atempan',21),(1586,'Atexcal',21),(1587,'Atlixco',21),(1588,'Atoyatempan',21),(1589,'Atzala',21),(1590,'Atzitzihuacán',21),(1591,'Atzitzintla',21),(1592,'Axutla',21),(1593,'Ayotoxco de Guerrero',21),(1594,'Calpan',21),(1595,'Caltepec',21),(1596,'Camocuautla',21),(1597,'Caxhuacan',21),(1598,'Coatepec',21),(1599,'Coatzingo',21),(1600,'Cohetzala',21),(1601,'Cohuecan',21),(1602,'Coronango',21),(1603,'Coxcatlán',21),(1604,'Coyomeapan',21),(1605,'Coyotepec',21),(1606,'Cuapiaxtla de Madero',21),(1607,'Cuautempan',21),(1608,'Cuautinchán',21),(1609,'Cuautlancingo',21),(1610,'Cuayuca de Andrade',21),(1611,'Cuetzalan del Progreso',21),(1612,'Cuyoaco',21),(1613,'Chalchicomula de Sesma',21),(1614,'Chapulco',21),(1615,'Chiautla',21),(1616,'Chiautzingo',21),(1617,'Chiconcuautla',21),(1618,'Chichiquila',21),(1619,'Chietla',21),(1620,'Chigmecatitlán',21),(1621,'Chignahuapan',21),(1622,'Chignautla',21),(1623,'Chila',21),(1624,'Chila de la Sal',21),(1625,'Honey',21),(1626,'Chilchotla',21),(1627,'Chinantla',21),(1628,'Domingo Arenas',21),(1629,'Eloxochitlán',21),(1630,'Epatlán',21),(1631,'Esperanza',21),(1632,'Francisco Z. Mena',21),(1633,'General Felipe Ángeles',21),(1634,'Guadalupe',21),(1635,'Guadalupe Victoria',21),(1636,'Hermenegildo Galeana',21),(1637,'Huaquechula',21),(1638,'Huatlatlauca',21),(1639,'Huauchinango',21),(1640,'Huehuetla',21),(1641,'Huehuetlán el Chico',21),(1642,'Huejotzingo',21),(1643,'Hueyapan',21),(1644,'Hueytamalco',21),(1645,'Hueytlalpan',21),(1646,'Huitzilan de Serdán',21),(1647,'Huitziltepec',21),(1648,'Atlequizayan',21),(1649,'Ixcamilpa de Guerrero',21),(1650,'Ixcaquixtla',21),(1651,'Ixtacamaxtitlán',21),(1652,'Ixtepec',21),(1653,'Izúcar de Matamoros',21),(1654,'Jalpan',21),(1655,'Jolalpan',21),(1656,'Jonotla',21),(1657,'Jopala',21),(1658,'Juan C. Bonilla',21),(1659,'Juan Galindo',21),(1660,'Juan N. Méndez',21),(1661,'Lafragua',21),(1662,'Libres',21),(1663,'La Magdalena Tlatlauquitepec',21),(1664,'Mazapiltepec de Juárez',21),(1665,'Mixtla',21),(1666,'Molcaxac',21),(1667,'Cañada Morelos',21),(1668,'Naupan',21),(1669,'Nauzontla',21),(1670,'Nealtican',21),(1671,'Nicolás Bravo',21),(1672,'Nopalucan',21),(1673,'Ocotepec',21),(1674,'Ocoyucan',21),(1675,'Olintla',21),(1676,'Oriental',21),(1677,'Pahuatlán',21),(1678,'Palmar de Bravo',21),(1679,'Pantepec',21),(1680,'Petlalcingo',21),(1681,'Piaxtla',21),(1682,'Puebla',21),(1683,'Quecholac',21),(1684,'Quimixtlán',21),(1685,'Rafael Lara Grajales',21),(1686,'Los Reyes de Juárez',21),(1687,'San Andrés Cholula',21),(1688,'San Antonio Cañada',21),(1689,'San Diego la Mesa Tochimiltzingo',21),(1690,'San Felipe Teotlalcingo',21),(1691,'San Felipe Tepatlán',21),(1692,'San Gabriel Chilac',21),(1693,'San Gregorio Atzompa',21),(1694,'San Jerónimo Tecuanipan',21),(1695,'San Jerónimo Xayacatlán',21),(1696,'San José Chiapa',21),(1697,'San José Miahuatlán',21),(1698,'San Juan Atenco',21),(1699,'San Juan Atzompa',21),(1700,'San Martín Texmelucan',21),(1701,'San Martín Totoltepec',21),(1702,'San Matías Tlalancaleca',21),(1703,'San Miguel Ixitlán',21),(1704,'San Miguel Xoxtla',21),(1705,'San Nicolás Buenos Aires',21),(1706,'San Nicolás de los Ranchos',21),(1707,'San Pablo Anicano',21),(1708,'San Pedro Cholula',21),(1709,'San Pedro Yeloixtlahuaca',21),(1710,'San Salvador el Seco',21),(1711,'San Salvador el Verde',21),(1712,'San Salvador Huixcolotla',21),(1713,'San Sebastián Tlacotepec',21),(1714,'Santa Catarina Tlaltempan',21),(1715,'Santa Inés Ahuatempan',21),(1716,'Santa Isabel Cholula',21),(1717,'Santiago Miahuatlán',21),(1718,'Huehuetlán el Grande',21),(1719,'Santo Tomás Hueyotlipan',21),(1720,'Soltepec',21),(1721,'Tecali de Herrera',21),(1722,'Tecamachalco',21),(1723,'Tecomatlán',21),(1724,'Tehuacán',21),(1725,'Tehuitzingo',21),(1726,'Tenampulco',21),(1727,'Teopantlán',21),(1728,'Teotlalco',21),(1729,'Tepanco de López',21),(1730,'Tepango de Rodríguez',21),(1731,'Tepatlaxco de Hidalgo',21),(1732,'Tepeaca',21),(1733,'Tepemaxalco',21),(1734,'Tepeojuma',21),(1735,'Tepetzintla',21),(1736,'Tepexco',21),(1737,'Tepexi de Rodríguez',21),(1738,'Tepeyahualco',21),(1739,'Tepeyahualco de Cuauhtémoc',21),(1740,'Tetela de Ocampo',21),(1741,'Teteles de Avila Castillo',21),(1742,'Teziutlán',21),(1743,'Tianguismanalco',21),(1744,'Tilapa',21),(1745,'Tlacotepec de Benito Juárez',21),(1746,'Tlacuilotepec',21),(1747,'Tlachichuca',21),(1748,'Tlahuapan',21),(1749,'Tlaltenango',21),(1750,'Tlanepantla',21),(1751,'Tlaola',21),(1752,'Tlapacoya',21),(1753,'Tlapanalá',21),(1754,'Tlatlauquitepec',21),(1755,'Tlaxco',21),(1756,'Tochimilco',21),(1757,'Tochtepec',21),(1758,'Totoltepec de Guerrero',21),(1759,'Tulcingo',21),(1760,'Tuzamapan de Galeana',21),(1761,'Tzicatlacoyan',21),(1762,'Venustiano Carranza',21),(1763,'Vicente Guerrero',21),(1764,'Xayacatlán de Bravo',21),(1765,'Xicotepec',21),(1766,'Xicotlán',21),(1767,'Xiutetelco',21),(1768,'Xochiapulco',21),(1769,'Xochiltepec',21),(1770,'Xochitlán de Vicente Suárez',21),(1771,'Xochitlán Todos Santos',21),(1772,'Yaonáhuac',21),(1773,'Yehualtepec',21),(1774,'Zacapala',21),(1775,'Zacapoaxtla',21),(1776,'Zacatlán',21),(1777,'Zapotitlán',21),(1778,'Zapotitlán de Méndez',21),(1779,'Zaragoza',21),(1780,'Zautla',21),(1781,'Zihuateutla',21),(1782,'Zinacatepec',21),(1783,'Zongozotla',21),(1784,'Zoquiapan',21),(1785,'Zoquitlán',21),(1786,'Amealco de Bonfil',22),(1787,'Pinal de Amoles',22),(1788,'Arroyo Seco',22),(1789,'Cadereyta de Montes',22),(1790,'Colón',22),(1791,'Corregidora',22),(1792,'Ezequiel Montes',22),(1793,'Huimilpan',22),(1794,'Jalpan de Serra',22),(1795,'Landa de Matamoros',22),(1796,'El Marqués',22),(1797,'Pedro Escobedo',22),(1798,'Peñamiller',22),(1799,'Querétaro',22),(1800,'San Joaquín',22),(1801,'San Juan del Río',22),(1802,'Tequisquiapan',22),(1803,'Tolimán',22),(1804,'Cozumel',23),(1805,'Felipe Carrillo Puerto',23),(1806,'Isla Mujeres',23),(1807,'Othón P. Blanco',23),(1808,'Benito Juárez',23),(1809,'José María Morelos',23),(1810,'Lázaro Cárdenas',23),(1811,'Solidaridad',23),(1812,'Tulum',23),(1813,'Ahualulco',24),(1814,'Alaquines',24),(1815,'Aquismón',24),(1816,'Armadillo de los Infante',24),(1817,'Cárdenas',24),(1818,'Catorce',24),(1819,'Cedral',24),(1820,'Cerritos',24),(1821,'Cerro de San Pedro',24),(1822,'Ciudad del Maíz',24),(1823,'Ciudad Fernández',24),(1824,'Tancanhuitz',24),(1825,'Ciudad Valles',24),(1826,'Coxcatlán',24),(1827,'Charcas',24),(1828,'Ebano',24),(1829,'Guadalcázar',24),(1830,'Huehuetlán',24),(1831,'Lagunillas',24),(1832,'Matehuala',24),(1833,'Mexquitic de Carmona',24),(1834,'Moctezuma',24),(1835,'Rayón',24),(1836,'Rioverde',24),(1837,'Salinas',24),(1838,'San Antonio',24),(1839,'San Ciro de Acosta',24),(1840,'San Luis Potosí',24),(1841,'San Martín Chalchicuautla',24),(1842,'San Nicolás Tolentino',24),(1843,'Santa Catarina',24),(1844,'Santa María del Río',24),(1845,'Santo Domingo',24),(1846,'San Vicente Tancuayalab',24),(1847,'Soledad de Graciano Sánchez',24),(1848,'Tamasopo',24),(1849,'Tamazunchale',24),(1850,'Tampacán',24),(1851,'Tampamolón Corona',24),(1852,'Tamuín',24),(1853,'Tanlajás',24),(1854,'Tanquián de Escobedo',24),(1855,'Tierra Nueva',24),(1856,'Vanegas',24),(1857,'Venado',24),(1858,'Villa de Arriaga',24),(1859,'Villa de Guadalupe',24),(1860,'Villa de la Paz',24),(1861,'Villa de Ramos',24),(1862,'Villa de Reyes',24),(1863,'Villa Hidalgo',24),(1864,'Villa Juárez',24),(1865,'Axtla de Terrazas',24),(1866,'Xilitla',24),(1867,'Zaragoza',24),(1868,'Villa de Arista',24),(1869,'Matlapa',24),(1870,'El Naranjo',24),(1871,'Ahome',25),(1872,'Angostura',25),(1873,'Badiraguato',25),(1874,'Concordia',25),(1875,'Cosalá',25),(1876,'Culiacán',25),(1877,'Choix',25),(1878,'Elota',25),(1879,'Escuinapa',25),(1880,'El Fuerte',25),(1881,'Guasave',25),(1882,'Mazatlán',25),(1883,'Mocorito',25),(1884,'Rosario',25),(1885,'Salvador Alvarado',25),(1886,'San Ignacio',25),(1887,'Sinaloa',25),(1888,'Navolato',25),(1889,'Aconchi',26),(1890,'Agua Prieta',26),(1891,'Alamos',26),(1892,'Altar',26),(1893,'Arivechi',26),(1894,'Arizpe',26),(1895,'Atil',26),(1896,'Bacadéhuachi',26),(1897,'Bacanora',26),(1898,'Bacerac',26),(1899,'Bacoachi',26),(1900,'Bácum',26),(1901,'Banámichi',26),(1902,'Baviácora',26),(1903,'Bavispe',26),(1904,'Benjamín Hill',26),(1905,'Caborca',26),(1906,'Cajeme',26),(1907,'Cananea',26),(1908,'Carbó',26),(1909,'La Colorada',26),(1910,'Cucurpe',26),(1911,'Cumpas',26),(1912,'Divisaderos',26),(1913,'Empalme',26),(1914,'Etchojoa',26),(1915,'Fronteras',26),(1916,'Granados',26),(1917,'Guaymas',26),(1918,'Hermosillo',26),(1919,'Huachinera',26),(1920,'Huásabas',26),(1921,'Huatabampo',26),(1922,'Huépac',26),(1923,'Imuris',26),(1924,'Magdalena',26),(1925,'Mazatán',26),(1926,'Moctezuma',26),(1927,'Naco',26),(1928,'Nácori Chico',26),(1929,'Nacozari de García',26),(1930,'Navojoa',26),(1931,'Nogales',26),(1932,'Onavas',26),(1933,'Opodepe',26),(1934,'Oquitoa',26),(1935,'Pitiquito',26),(1936,'Puerto Peñasco',26),(1937,'Quiriego',26),(1938,'Rayón',26),(1939,'Rosario',26),(1940,'Sahuaripa',26),(1941,'San Felipe de Jesús',26),(1942,'San Javier',26),(1943,'San Luis Río Colorado',26),(1944,'San Miguel de Horcasitas',26),(1945,'San Pedro de la Cueva',26),(1946,'Santa Ana',26),(1947,'Santa Cruz',26),(1948,'Sáric',26),(1949,'Soyopa',26),(1950,'Suaqui Grande',26),(1951,'Tepache',26),(1952,'Trincheras',26),(1953,'Tubutama',26),(1954,'Ures',26),(1955,'Villa Hidalgo',26),(1956,'Villa Pesqueira',26),(1957,'Yécora',26),(1958,'General Plutarco Elías Calles',26),(1959,'Benito Juárez',26),(1960,'San Ignacio Río Muerto',26),(1961,'Balancán',27),(1962,'Cárdenas',27),(1963,'Centla',27),(1964,'Centro',27),(1965,'Comalcalco',27),(1966,'Cunduacán',27),(1967,'Emiliano Zapata',27),(1968,'Huimanguillo',27),(1969,'Jalapa',27),(1970,'Jalpa de Méndez',27),(1971,'Jonuta',27),(1972,'Macuspana',27),(1973,'Nacajuca',27),(1974,'Paraíso',27),(1975,'Tacotalpa',27),(1976,'Teapa',27),(1977,'Tenosique',27),(1978,'Abasolo',28),(1979,'Aldama',28),(1980,'Altamira',28),(1981,'Antiguo Morelos',28),(1982,'Burgos',28),(1983,'Bustamante',28),(1984,'Camargo',28),(1985,'Casas',28),(1986,'Ciudad Madero',28),(1987,'Cruillas',28),(1988,'Gómez Farías',28),(1989,'González',28),(1990,'Güémez',28),(1991,'Guerrero',28),(1992,'Gustavo Díaz Ordaz',28),(1993,'Hidalgo',28),(1994,'Jaumave',28),(1995,'Jiménez',28),(1996,'Llera',28),(1997,'Mainero',28),(1998,'El Mante',28),(1999,'Matamoros',28),(2000,'Méndez',28),(2001,'Mier',28),(2002,'Miguel Alemán',28),(2003,'Miquihuana',28),(2004,'Nuevo Laredo',28),(2005,'Nuevo Morelos',28),(2006,'Ocampo',28),(2007,'Padilla',28),(2008,'Palmillas',28),(2009,'Reynosa',28),(2010,'Río Bravo',28),(2011,'San Carlos',28),(2012,'San Fernando',28),(2013,'San Nicolás',28),(2014,'Soto la Marina',28),(2015,'Tampico',28),(2016,'Tula',28),(2017,'Valle Hermoso',28),(2018,'Victoria',28),(2019,'Villagrán',28),(2020,'Xicoténcatl',28),(2021,'Amaxac de Guerrero',29),(2022,'Apetatitlán de Antonio Carvajal',29),(2023,'Atlangatepec',29),(2024,'Atltzayanca',29),(2025,'Apizaco',29),(2026,'Calpulalpan',29),(2027,'El Carmen Tequexquitla',29),(2028,'Cuapiaxtla',29),(2029,'Cuaxomulco',29),(2030,'Chiautempan',29),(2031,'Muñoz de Domingo Arenas',29),(2032,'Españita',29),(2033,'Huamantla',29),(2034,'Hueyotlipan',29),(2035,'Ixtacuixtla de Mariano Matamoros',29),(2036,'Ixtenco',29),(2037,'Mazatecochco de José María Morelos',29),(2038,'Contla de Juan Cuamatzi',29),(2039,'Tepetitla de Lardizábal',29),(2040,'Sanctórum de Lázaro Cárdenas',29),(2041,'Nanacamilpa de Mariano Arista',29),(2042,'Acuamanala de Miguel Hidalgo',29),(2043,'Natívitas',29),(2044,'Panotla',29),(2045,'San Pablo del Monte',29),(2046,'Santa Cruz Tlaxcala',29),(2047,'Tenancingo',29),(2048,'Teolocholco',29),(2049,'Tepeyanco',29),(2050,'Terrenate',29),(2051,'Tetla de la Solidaridad',29),(2052,'Tetlatlahuca',29),(2053,'Tlaxcala',29),(2054,'Tlaxco',29),(2055,'Tocatlán',29),(2056,'Totolac',29),(2057,'Ziltlaltépec de Trinidad Sánchez Santos',29),(2058,'Tzompantepec',29),(2059,'Xaloztoc',29),(2060,'Xaltocan',29),(2061,'Papalotla de Xicohténcatl',29),(2062,'Xicohtzinco',29),(2063,'Yauhquemehcan',29),(2064,'Zacatelco',29),(2065,'Benito Juárez',29),(2066,'Emiliano Zapata',29),(2067,'Lázaro Cárdenas',29),(2068,'La Magdalena Tlaltelulco',29),(2069,'San Damián Texóloc',29),(2070,'San Francisco Tetlanohcan',29),(2071,'San Jerónimo Zacualpan',29),(2072,'San José Teacalco',29),(2073,'San Juan Huactzinco',29),(2074,'San Lorenzo Axocomanitla',29),(2075,'San Lucas Tecopilco',29),(2076,'Santa Ana Nopalucan',29),(2077,'Santa Apolonia Teacalco',29),(2078,'Santa Catarina Ayometla',29),(2079,'Santa Cruz Quilehtla',29),(2080,'Santa Isabel Xiloxoxtla',29),(2081,'Acajete',30),(2082,'Acatlán',30),(2083,'Acayucan',30),(2084,'Actopan',30),(2085,'Acula',30),(2086,'Acultzingo',30),(2087,'Camarón de Tejeda',30),(2088,'Alpatláhuac',30),(2089,'Alto Lucero de Gutiérrez Barrios',30),(2090,'Altotonga',30),(2091,'Alvarado',30),(2092,'Amatitlán',30),(2093,'Naranjos Amatlán',30),(2094,'Amatlán de los Reyes',30),(2095,'Angel R. Cabada',30),(2096,'La Antigua',30),(2097,'Apazapan',30),(2098,'Aquila',30),(2099,'Astacinga',30),(2100,'Atlahuilco',30),(2101,'Atoyac',30),(2102,'Atzacan',30),(2103,'Atzalan',30),(2104,'Tlaltetela',30),(2105,'Ayahualulco',30),(2106,'Banderilla',30),(2107,'Benito Juárez',30),(2108,'Boca del Río',30),(2109,'Calcahualco',30),(2110,'Camerino Z. Mendoza',30),(2111,'Carrillo Puerto',30),(2112,'Catemaco',30),(2113,'Cazones de Herrera',30),(2114,'Cerro Azul',30),(2115,'Citlaltépetl',30),(2116,'Coacoatzintla',30),(2117,'Coahuitlán',30),(2118,'Coatepec',30),(2119,'Coatzacoalcos',30),(2120,'Coatzintla',30),(2121,'Coetzala',30),(2122,'Colipa',30),(2123,'Comapa',30),(2124,'Córdoba',30),(2125,'Cosamaloapan de Carpio',30),(2126,'Cosautlán de Carvajal',30),(2127,'Coscomatepec',30),(2128,'Cosoleacaque',30),(2129,'Cotaxtla',30),(2130,'Coxquihui',30),(2131,'Coyutla',30),(2132,'Cuichapa',30),(2133,'Cuitláhuac',30),(2134,'Chacaltianguis',30),(2135,'Chalma',30),(2136,'Chiconamel',30),(2137,'Chiconquiaco',30),(2138,'Chicontepec',30),(2139,'Chinameca',30),(2140,'Chinampa de Gorostiza',30),(2141,'Las Choapas',30),(2142,'Chocamán',30),(2143,'Chontla',30),(2144,'Chumatlán',30),(2145,'Emiliano Zapata',30),(2146,'Espinal',30),(2147,'Filomeno Mata',30),(2148,'Fortín',30),(2149,'Gutiérrez Zamora',30),(2150,'Hidalgotitlán',30),(2151,'Huatusco',30),(2152,'Huayacocotla',30),(2153,'Hueyapan de Ocampo',30),(2154,'Huiloapan de Cuauhtémoc',30),(2155,'Ignacio de la Llave',30),(2156,'Ilamatlán',30),(2157,'Isla',30),(2158,'Ixcatepec',30),(2159,'Ixhuacán de los Reyes',30),(2160,'Ixhuatlán del Café',30),(2161,'Ixhuatlancillo',30),(2162,'Ixhuatlán del Sureste',30),(2163,'Ixhuatlán de Madero',30),(2164,'Ixmatlahuacan',30),(2165,'Ixtaczoquitlán',30),(2166,'Jalacingo',30),(2167,'Xalapa',30),(2168,'Jalcomulco',30),(2169,'Jáltipan',30),(2170,'Jamapa',30),(2171,'Jesús Carranza',30),(2172,'Xico',30),(2173,'Jilotepec',30),(2174,'Juan Rodríguez Clara',30),(2175,'Juchique de Ferrer',30),(2176,'Landero y Coss',30),(2177,'Lerdo de Tejada',30),(2178,'Magdalena',30),(2179,'Maltrata',30),(2180,'Manlio Fabio Altamirano',30),(2181,'Mariano Escobedo',30),(2182,'Martínez de la Torre',30),(2183,'Mecatlán',30),(2184,'Mecayapan',30),(2185,'Medellín',30),(2186,'Miahuatlán',30),(2187,'Las Minas',30),(2188,'Minatitlán',30),(2189,'Misantla',30),(2190,'Mixtla de Altamirano',30),(2191,'Moloacán',30),(2192,'Naolinco',30),(2193,'Naranjal',30),(2194,'Nautla',30),(2195,'Nogales',30),(2196,'Oluta',30),(2197,'Omealca',30),(2198,'Orizaba',30),(2199,'Otatitlán',30),(2200,'Oteapan',30),(2201,'Ozuluama de Mascareñas',30),(2202,'Pajapan',30),(2203,'Pánuco',30),(2204,'Papantla',30),(2205,'Paso del Macho',30),(2206,'Paso de Ovejas',30),(2207,'La Perla',30),(2208,'Perote',30),(2209,'Platón Sánchez',30),(2210,'Playa Vicente',30),(2211,'Poza Rica de Hidalgo',30),(2212,'Las Vigas de Ramírez',30),(2213,'Pueblo Viejo',30),(2214,'Puente Nacional',30),(2215,'Rafael Delgado',30),(2216,'Rafael Lucio',30),(2217,'Los Reyes',30),(2218,'Río Blanco',30),(2219,'Saltabarranca',30),(2220,'San Andrés Tenejapan',30),(2221,'San Andrés Tuxtla',30),(2222,'San Juan Evangelista',30),(2223,'Santiago Tuxtla',30),(2224,'Sayula de Alemán',30),(2225,'Soconusco',30),(2226,'Sochiapa',30),(2227,'Soledad Atzompa',30),(2228,'Soledad de Doblado',30),(2229,'Soteapan',30),(2230,'Tamalín',30),(2231,'Tamiahua',30),(2232,'Tampico Alto',30),(2233,'Tancoco',30),(2234,'Tantima',30),(2235,'Tantoyuca',30),(2236,'Tatatila',30),(2237,'Castillo de Teayo',30),(2238,'Tecolutla',30),(2239,'Tehuipango',30),(2240,'Álamo Temapache',30),(2241,'Tempoal',30),(2242,'Tenampa',30),(2243,'Tenochtitlán',30),(2244,'Teocelo',30),(2245,'Tepatlaxco',30),(2246,'Tepetlán',30),(2247,'Tepetzintla',30),(2248,'Tequila',30),(2249,'José Azueta',30),(2250,'Texcatepec',30),(2251,'Texhuacán',30),(2252,'Texistepec',30),(2253,'Tezonapa',30),(2254,'Tierra Blanca',30),(2255,'Tihuatlán',30),(2256,'Tlacojalpan',30),(2257,'Tlacolulan',30),(2258,'Tlacotalpan',30),(2259,'Tlacotepec de Mejía',30),(2260,'Tlachichilco',30),(2261,'Tlalixcoyan',30),(2262,'Tlalnelhuayocan',30),(2263,'Tlapacoyan',30),(2264,'Tlaquilpa',30),(2265,'Tlilapan',30),(2266,'Tomatlán',30),(2267,'Tonayán',30),(2268,'Totutla',30),(2269,'Tuxpan',30),(2270,'Tuxtilla',30),(2271,'Ursulo Galván',30),(2272,'Vega de Alatorre',30),(2273,'Veracruz',30),(2274,'Villa Aldama',30),(2275,'Xoxocotla',30),(2276,'Yanga',30),(2277,'Yecuatla',30),(2278,'Zacualpan',30),(2279,'Zaragoza',30),(2280,'Zentla',30),(2281,'Zongolica',30),(2282,'Zontecomatlán de López y Fuentes',30),(2283,'Zozocolco de Hidalgo',30),(2284,'Agua Dulce',30),(2285,'El Higo',30),(2286,'Nanchital de Lázaro Cárdenas del Río',30),(2287,'Tres Valles',30),(2288,'Carlos A. Carrillo',30),(2289,'Tatahuicapan de Juárez',30),(2290,'Uxpanapa',30),(2291,'San Rafael',30),(2292,'Santiago Sochiapan',30),(2293,'Abalá',31),(2294,'Acanceh',31),(2295,'Akil',31),(2296,'Baca',31),(2297,'Bokobá',31),(2298,'Buctzotz',31),(2299,'Cacalchén',31),(2300,'Calotmul',31),(2301,'Cansahcab',31),(2302,'Cantamayec',31),(2303,'Celestún',31),(2304,'Cenotillo',31),(2305,'Conkal',31),(2306,'Cuncunul',31),(2307,'Cuzamá',31),(2308,'Chacsinkín',31),(2309,'Chankom',31),(2310,'Chapab',31),(2311,'Chemax',31),(2312,'Chicxulub Pueblo',31),(2313,'Chichimilá',31),(2314,'Chikindzonot',31),(2315,'Chocholá',31),(2316,'Chumayel',31),(2317,'Dzán',31),(2318,'Dzemul',31),(2319,'Dzidzantún',31),(2320,'Dzilam de Bravo',31),(2321,'Dzilam González',31),(2322,'Dzitás',31),(2323,'Dzoncauich',31),(2324,'Espita',31),(2325,'Halachó',31),(2326,'Hocabá',31),(2327,'Hoctún',31),(2328,'Homún',31),(2329,'Huhí',31),(2330,'Hunucmá',31),(2331,'Ixil',31),(2332,'Izamal',31),(2333,'Kanasín',31),(2334,'Kantunil',31),(2335,'Kaua',31),(2336,'Kinchil',31),(2337,'Kopomá',31),(2338,'Mama',31),(2339,'Maní',31),(2340,'Maxcanú',31),(2341,'Mayapán',31),(2342,'Mérida',31),(2343,'Mocochá',31),(2344,'Motul',31),(2345,'Muna',31),(2346,'Muxupip',31),(2347,'Opichén',31),(2348,'Oxkutzcab',31),(2349,'Panabá',31),(2350,'Peto',31),(2351,'Progreso',31),(2352,'Quintana Roo',31),(2353,'Río Lagartos',31),(2354,'Sacalum',31),(2355,'Samahil',31),(2356,'Sanahcat',31),(2357,'San Felipe',31),(2358,'Santa Elena',31),(2359,'Seyé',31),(2360,'Sinanché',31),(2361,'Sotuta',31),(2362,'Sucilá',31),(2363,'Sudzal',31),(2364,'Suma',31),(2365,'Tahdziú',31),(2366,'Tahmek',31),(2367,'Teabo',31),(2368,'Tecoh',31),(2369,'Tekal de Venegas',31),(2370,'Tekantó',31),(2371,'Tekax',31),(2372,'Tekit',31),(2373,'Tekom',31),(2374,'Telchac Pueblo',31),(2375,'Telchac Puerto',31),(2376,'Temax',31),(2377,'Temozón',31),(2378,'Tepakán',31),(2379,'Tetiz',31),(2380,'Teya',31),(2381,'Ticul',31),(2382,'Timucuy',31),(2383,'Tinum',31),(2384,'Tixcacalcupul',31),(2385,'Tixkokob',31),(2386,'Tixmehuac',31),(2387,'Tixpéhual',31),(2388,'Tizimín',31),(2389,'Tunkás',31),(2390,'Tzucacab',31),(2391,'Uayma',31),(2392,'Ucú',31),(2393,'Umán',31),(2394,'Valladolid',31),(2395,'Xocchel',31),(2396,'Yaxcabá',31),(2397,'Yaxkukul',31),(2398,'Yobaín',31),(2399,'Apozol',32),(2400,'Apulco',32),(2401,'Atolinga',32),(2402,'Benito Juárez',32),(2403,'Calera',32),(2404,'Cañitas de Felipe Pescador',32),(2405,'Concepción del Oro',32),(2406,'Cuauhtémoc',32),(2407,'Chalchihuites',32),(2408,'Fresnillo',32),(2409,'Trinidad García de la Cadena',32),(2410,'Genaro Codina',32),(2411,'General Enrique Estrada',32),(2412,'General Francisco R. Murguía',32),(2413,'El Plateado de Joaquín Amaro',32),(2414,'General Pánfilo Natera',32),(2415,'Guadalupe',32),(2416,'Huanusco',32),(2417,'Jalpa',32),(2418,'Jerez',32),(2419,'Jiménez del Teul',32),(2420,'Juan Aldama',32),(2421,'Juchipila',32),(2422,'Loreto',32),(2423,'Luis Moya',32),(2424,'Mazapil',32),(2425,'Melchor Ocampo',32),(2426,'Mezquital del Oro',32),(2427,'Miguel Auza',32),(2428,'Momax',32),(2429,'Monte Escobedo',32),(2430,'Morelos',32),(2431,'Moyahua de Estrada',32),(2432,'Nochistlán de Mejía',32),(2433,'Noria de Ángeles',32),(2434,'Ojocaliente',32),(2435,'Pánuco',32),(2436,'Pinos',32),(2437,'Río Grande',32),(2438,'Sain Alto',32),(2439,'El Salvador',32),(2440,'Sombrerete',32),(2441,'Susticacán',32),(2442,'Tabasco',32),(2443,'Tepechitlán',32),(2444,'Tepetongo',32),(2445,'Teúl de González Ortega',32),(2446,'Tlaltenango de Sánchez Román',32),(2447,'Valparaíso',32),(2448,'Vetagrande',32),(2449,'Villa de Cos',32),(2450,'Villa García',32),(2451,'Villa González Ortega',32),(2452,'Villa Hidalgo',32),(2453,'Villanueva',32),(2454,'Zacatecas',32),(2455,'Trancoso',32),(2456,'Santa María de la Paz',32);
/*!40000 ALTER TABLE `municipios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `idproducto` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` int(11) unsigned NOT NULL DEFAULT '0',
  `descripcion` varchar(45) NOT NULL DEFAULT '',
  `idproveedor` int(10) unsigned NOT NULL DEFAULT '0',
  `precioVenta` float NOT NULL DEFAULT '0',
  `stock` int(11) NOT NULL DEFAULT '0',
  `idCategoria` int(11) DEFAULT NULL,
  `idMarca` int(11) DEFAULT NULL,
  `activo` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`idproducto`),
  KEY `FK_producto_idProveedor` (`idproveedor`),
  KEY `fk_producto_idCategoria_idx` (`idCategoria`),
  KEY `fk_producto_idMarca_idx` (`idMarca`),
  CONSTRAINT `fk_producto_idCategoria` FOREIGN KEY (`idCategoria`) REFERENCES `categorias` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_idMarca` FOREIGN KEY (`idMarca`) REFERENCES `marcas` (`idmarca`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_idProveedor` FOREIGN KEY (`idproveedor`) REFERENCES `proveedor` (`idproveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (2,1,'Pantalon mezclilla 514',1,399,44,4,1,1),(3,2,'Pantalon Gabardina',1,299,9,1,1,1),(4,3,'Gorra New Era',1,12.23,0,4,9,0),(5,4,'Cartera',1,66,0,4,9,1),(6,3,'Playera M/L',3,99,1,4,9,1);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productosfallados`
--

DROP TABLE IF EXISTS `productosfallados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productosfallados` (
  `idproductosFallados` int(11) NOT NULL AUTO_INCREMENT,
  `idProducto` int(10) unsigned NOT NULL,
  `defecto` varchar(60) NOT NULL,
  `fecha` datetime NOT NULL,
  `idUsuario` int(10) unsigned NOT NULL,
  PRIMARY KEY (`idproductosFallados`),
  KEY `fk_productosFallados_idProducto_idx` (`idProducto`),
  KEY `fk_productosFallados_idUsuario_idx` (`idUsuario`),
  CONSTRAINT `fk_productosFallados_idProducto` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productosFallados_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productosfallados`
--

LOCK TABLES `productosfallados` WRITE;
/*!40000 ALTER TABLE `productosfallados` DISABLE KEYS */;
/*!40000 ALTER TABLE `productosfallados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `idproveedor` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL DEFAULT '',
  `apellidoPaterno` varchar(45) DEFAULT NULL,
  `apellidoMaterno` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) NOT NULL DEFAULT '',
  `email` varchar(45) NOT NULL DEFAULT '',
  `idEstado` int(2) NOT NULL,
  `idMunicipio` int(5) NOT NULL DEFAULT '0',
  `colonia` varchar(45) NOT NULL DEFAULT '',
  `calle` varchar(45) NOT NULL DEFAULT '0',
  `numero` varchar(10) NOT NULL DEFAULT '0',
  `cp` char(5) NOT NULL DEFAULT '0',
  `rfc` char(13) DEFAULT '',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idproveedor`),
  KEY `fk_proveedor_idEstado_idx` (`idEstado`),
  KEY `fk_proveedor_idMunicipio_idx` (`idMunicipio`),
  CONSTRAINT `fk_proveedor_idEstado` FOREIGN KEY (`idEstado`) REFERENCES `estados` (`idestado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedor_idMunicipio` FOREIGN KEY (`idMunicipio`) REFERENCES `municipios` (`idmunicipio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'Ricardo','Esqueda','Guerrero','4951018528','ricardoeg66@gmail.com',14,650,'Camino Real','America','14','47250','EUGR940606F8',1),(2,'Kevin','Gonzalez','Medina','4492016754','kevin@gmail.com',1,1,'Centro','Lopez Mateos','12','20020','',0),(3,'pancho','lopez','lopez','4951018528','323232@fdsf.com',11,340,'3231','dsasdas','323','21321','',1);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `idusuario` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL DEFAULT '',
  `usuario` varchar(45) NOT NULL DEFAULT '',
  `password` varchar(45) NOT NULL DEFAULT '',
  `permiso` tinyint(1) NOT NULL DEFAULT '1',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Ricardo','ricesqgue','d78ab802677f335775b362eeae0b07c4',1,1),(2,'Kevin','kevin','9d5e3ecdeb4cdb7acfd63075ae046672',1,1),(3,'Mykro','mycro','a77283dbf982bdd17c13ca69ddca1867',1,1),(4,'Miguel Angel','cremas','554859af893ded25281939f34abefe4d',1,1),(5,'Miguel Angel','mykro','a1bc5f6861de2a9a505d66e5a1eac8f5',1,1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventaproducto`
--

DROP TABLE IF EXISTS `ventaproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventaproducto` (
  `idVentaProducto` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idProducto` int(10) unsigned NOT NULL DEFAULT '0',
  `cantidad` int(10) unsigned NOT NULL DEFAULT '0',
  `precioU` float unsigned NOT NULL DEFAULT '0',
  `idVentaTotal` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idVentaProducto`,`idVentaTotal`),
  KEY `fk_ventaproducto_idProducto_idx` (`idProducto`),
  KEY `fk_ventaproducto_idVentaTotal_idx` (`idVentaTotal`),
  CONSTRAINT `fk_ventaproducto_idProducto` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventaproducto_idVentaTotal` FOREIGN KEY (`idVentaTotal`) REFERENCES `ventatotal` (`idVentaTotal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventaproducto`
--

LOCK TABLES `ventaproducto` WRITE;
/*!40000 ALTER TABLE `ventaproducto` DISABLE KEYS */;
INSERT INTO `ventaproducto` VALUES (1,2,1,399,1),(2,3,1,299,2),(3,5,12,66,2),(4,5,26,66,3),(5,3,1,299,4),(6,2,1,399,5),(7,2,1,399,6),(8,5,1,66,7),(9,2,1,399,8),(10,2,2,399,9),(11,3,1,299,9),(12,2,1,399,10),(13,3,1,299,11),(14,2,1,399,12),(15,2,1,399,13),(16,2,1,399,14),(17,2,1,399,15),(18,2,3,399,16),(19,3,1,299,16),(20,2,12,399,17),(21,2,1,399,18),(22,2,1,399,19),(23,2,1,399,20),(24,2,2,399,21),(25,3,1,299,21),(26,2,1,399,22),(27,3,1,299,23);
/*!40000 ALTER TABLE `ventaproducto` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `puntodeventa`.`ventaproducto_AFTER_INSERT` AFTER INSERT ON `ventaproducto` FOR EACH ROW
BEGIN
	update producto set stock = (stock-new.cantidad) where new.idProducto = idProducto;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ventatotal`
--

DROP TABLE IF EXISTS `ventatotal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventatotal` (
  `idVentaTotal` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idUsuario` int(10) unsigned NOT NULL DEFAULT '0',
  `fecha` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `total` float NOT NULL DEFAULT '0',
  `descuento` float unsigned NOT NULL DEFAULT '0',
  `idCliente` int(11) NOT NULL,
  `pagoEfectivo` float NOT NULL DEFAULT '0',
  `pagoTarjeta` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`idVentaTotal`),
  KEY `FK_venta_usuario` (`idUsuario`),
  KEY `fk_ventatotal_idCliente_idx` (`idCliente`),
  CONSTRAINT `fk_ventatotal_idCliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventatotal_idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventatotal`
--

LOCK TABLES `ventatotal` WRITE;
/*!40000 ALTER TABLE `ventatotal` DISABLE KEYS */;
INSERT INTO `ventatotal` VALUES (1,1,'2015-11-18 12:44:30',399,0,1,399,0),(2,1,'2015-11-18 12:48:09',1091,91,1,200,800),(3,1,'2015-11-18 12:54:24',1716,16,1,700,1000),(4,1,'2015-11-18 12:55:08',299,0,1,299,0),(5,1,'2015-11-18 12:59:59',399,0,1,399,0),(6,1,'2015-11-18 13:00:20',399,0,1,100,299),(7,1,'2015-11-18 13:02:54',66,12,1,50,4),(8,1,'2015-11-18 13:03:20',399,122,1,277,0),(9,1,'2015-11-18 13:03:58',1097,12,1,1085,0),(10,1,'2015-11-18 13:05:14',399,0,1,399,0),(11,1,'2015-11-18 13:05:32',299,10,1,289,0),(12,1,'2015-11-20 12:06:48',399,0,1,399,0),(13,5,'2015-11-20 15:54:06',399,0,1,399,0),(14,1,'2015-11-22 22:38:26',399,0,1,399,0),(15,1,'2015-11-22 22:38:50',399,0,1,399,0),(16,1,'2015-11-24 02:13:15',1496,0,1,122,1374),(17,1,'2015-11-24 02:15:49',4788,1221,1,3567,0),(18,1,'2015-11-24 02:16:55',399,200,1,199,0),(19,1,'2015-11-24 02:17:14',399,0,1,399,0),(20,1,'2015-11-24 02:19:47',399,1,1,12,386),(21,1,'2015-11-24 13:48:05',1097,12,1,1085,0),(22,1,'2015-11-25 12:23:57',399,12,1,387,0),(23,1,'2015-11-25 12:25:16',299,0,1,0,299);
/*!40000 ALTER TABLE `ventatotal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'puntodeventa'
--

--
-- Dumping routines for database 'puntodeventa'
--
/*!50003 DROP FUNCTION IF EXISTS `fechaespanol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fechaespanol`(fecha date) RETURNS varchar(30) CHARSET latin1
begin
SET lc_time_names = 'es_MX';
return date_format(fecha,'%d de %M de %Y');
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `tipoMovCaja` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `tipoMovCaja`(tipo int) RETURNS varchar(8) CHARSET latin1
begin
if tipo = 1
then
return 'Salida';
else
return 'Entrada';
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `deuda`
--

/*!50001 DROP VIEW IF EXISTS `deuda`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `deuda` AS (select `c`.`idCompraTotal` AS `idcompratotal`,`c`.`fecha` AS `fecha`,`c`.`folioNota` AS `folioNota`,round(`c`.`total`,2) AS `total`,if(((select sum(`b`.`idAbono`) from `abono` `b` where (`b`.`idCompraTotal` = `c`.`idCompraTotal`)) is not null),(select round(sum(`a`.`cantidad`),2) from `abono` `a` where (`a`.`idCompraTotal` = `c`.`idCompraTotal`)),0) AS `abono`,round((`c`.`total` - if(((select sum(`b`.`idAbono`) from `abono` `b` where (`b`.`idCompraTotal` = `c`.`idCompraTotal`)) is not null),(select round(sum(`a`.`cantidad`),2) from `abono` `a` where (`a`.`idCompraTotal` = `c`.`idCompraTotal`)),0)),2) AS `deuda`,`c`.`idProveedor` AS `idproveedor` from `compratotal` `c` group by `c`.`idCompraTotal` having (`deuda` > 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-26  2:28:46
