CREATE DATABASE  IF NOT EXISTS `notificaciones` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `notificaciones`;
-- MySQL dump 10.13  Distrib 5.7.12, for linux-glibc2.5 (x86_64)
--
-- Host: 172.20.5.84    Database: notificaciones
-- ------------------------------------------------------
-- Server version	5.6.24

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
-- Table structure for table `Notificables`
--

DROP TABLE IF EXISTS `Notificables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Notificables` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET latin1 NOT NULL,
  `user` varchar(45) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `telefono` varchar(12) CHARACTER SET latin1 NOT NULL DEFAULT '' COMMENT 'Tabla de personas notificables, no podrá remitirse ninguna notificación a nadie que no esté aquí habilitado',
  `aliasTelegram` varchar(200) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `aliasTwitter` varchar(200) CHARACTER SET latin1 NOT NULL,
  `email` varchar(200) CHARACTER SET latin1 NOT NULL COMMENT 'Tabla de personas notificables, no se podrá notificar a nadie que no esté aquí habilitado.',
  `activo` int(10) unsigned NOT NULL DEFAULT '1',
  `apps` varchar(300) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `user` (`user`),
  KEY `app` (`apps`(255))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Notificacion`
--

DROP TABLE IF EXISTS `Notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Notificacion` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `maquina` varchar(200) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `app` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `mensaje` varchar(300) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `stacktrace` varchar(1000) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` char(1) CHARACTER SET latin1 NOT NULL DEFAULT 'P',
  `idTipo` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `app` (`app`),
  KEY `maquina` (`maquina`),
  KEY `fecha` (`fecha`),
  KEY `estado` (`estado`)
) ENGINE=InnoDB AUTO_INCREMENT=796 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TipoNotificacion`
--

DROP TABLE IF EXISTS `TipoNotificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TipoNotificacion` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) CHARACTER SET latin1 NOT NULL,
  `criticidad` int(10) unsigned NOT NULL DEFAULT '10',
  `prioridad` int(10) unsigned NOT NULL DEFAULT '10',
  `sistema` varchar(10) CHARACTER SET latin1 NOT NULL DEFAULT 'EMAIL',
  `canal` varchar(200) CHARACTER SET latin1 NOT NULL DEFAULT '' COMMENT 'Tabla de Tipos posibles de Notificación, que se calcularán en función del par CRITICIDAD-PRIORIDAD',
  `app` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `activo` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `app` (`app`,`criticidad`,`prioridad`,`activo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `configuracion`
--

DROP TABLE IF EXISTS `configuracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuracion` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `grupo` varchar(50) NOT NULL DEFAULT 'COMMON',
  `parametro` varchar(50) NOT NULL,
  `valor` varchar(300) NOT NULL DEFAULT '',
  `entorno` varchar(1) NOT NULL DEFAULT 'D',
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `entorno` (`entorno`),
  KEY `grupo` (`entorno`,`grupo`),
  KEY `parametro` (`entorno`,`grupo`,`parametro`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'notificaciones'
--

--
-- Dumping routines for database 'notificaciones'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-14  8:29:23
