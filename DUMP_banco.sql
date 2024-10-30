-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: wktechnology
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `CODIGO` int NOT NULL,
  `NOME` varchar(50) NOT NULL,
  `CIDADE` varchar(50) NOT NULL,
  `UF` char(2) NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Ana Silva','São Paulo','SP'),(2,'Bruno Costa','Rio de Janeiro','RJ'),(3,'Carla Souza','Belo Horizonte','MG'),(4,'Daniel Oliveira','Porto Alegre','RS'),(5,'Eduardo Lima','Curitiba','PR'),(6,'Fernanda Alves','Salvador','BA'),(7,'Gabriel Pereira','Fortaleza','CE'),(8,'Helena Rocha','Brasília','DF'),(9,'Igor Mendes','Manaus','AM'),(10,'Juliana Santos','Recife','PE'),(11,'Lucas Ferreira','Belém','PA'),(12,'Mariana Gomes','Goiânia','GO'),(13,'Nicolas Ribeiro','Florianópolis','SC'),(14,'Olivia Martins','Vitória','ES'),(15,'Pedro Almeida','Campo Grande','MS'),(16,'Quintino Barbosa','São Luís','MA'),(17,'Rafaela Cardoso','Maceió','AL'),(18,'Samuel Teixeira','Natal','RN'),(19,'Tatiana Fernandes','João Pessoa','PB'),(20,'Vinícius Araújo','Aracaju','SE');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `NUMERO_PEDIDO` int NOT NULL,
  `DATA_EMISSAO` datetime NOT NULL,
  `CODIGO_CLIENTE` int NOT NULL,
  `VALOR_TOTAL` decimal(10,2) NOT NULL,
  PRIMARY KEY (`NUMERO_PEDIDO`),
  KEY `CODIGO_CLIENTE` (`CODIGO_CLIENTE`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`CODIGO_CLIENTE`) REFERENCES `clientes` (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,'2024-10-29 00:00:00',1,18.00),(2,'2024-10-29 00:00:00',6,19.15),(3,'2024-06-09 00:00:00',3,2.40),(4,'2024-06-05 00:00:00',15,14.40);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_produtos`
--

DROP TABLE IF EXISTS `pedidos_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_produtos` (
  `CODIGO` int NOT NULL AUTO_INCREMENT,
  `NUMERO_PEDIDO` int DEFAULT NULL,
  `CODIGO_PRODUTO` int DEFAULT NULL,
  `QUANTIDADE` int DEFAULT NULL,
  `VALOR_UNITARIO` decimal(10,2) DEFAULT NULL,
  `VALOR_TOTAL` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`CODIGO`),
  KEY `NUMERO_PEDIDO` (`NUMERO_PEDIDO`),
  KEY `CODIGO_PRODUTO` (`CODIGO_PRODUTO`),
  CONSTRAINT `pedidos_produtos_ibfk_1` FOREIGN KEY (`NUMERO_PEDIDO`) REFERENCES `pedidos` (`NUMERO_PEDIDO`),
  CONSTRAINT `pedidos_produtos_ibfk_2` FOREIGN KEY (`CODIGO_PRODUTO`) REFERENCES `produtos` (`CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_produtos`
--

LOCK TABLES `pedidos_produtos` WRITE;
/*!40000 ALTER TABLE `pedidos_produtos` DISABLE KEYS */;
INSERT INTO `pedidos_produtos` VALUES (1,1,1,2,2.00,3.00),(2,1,3,20,1.00,15.00),(6,2,12,2,3.00,6.00),(7,2,4,2,1.00,2.00),(8,2,1,5,1.00,7.00),(9,2,11,1,4.00,4.00),(11,3,2,3,1.00,2.00),(12,4,2,18,0.80,14.40);
/*!40000 ALTER TABLE `pedidos_produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `CODIGO` int NOT NULL,
  `DESCRICAO` varchar(50) NOT NULL,
  `PRECO` float NOT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Caneta Esferográfica',1.5),(2,'Lápis',0.8),(3,'Borracha',0.6),(4,'Apontador',1.2),(5,'Caderno',10),(6,'Bloco de Notas',5),(7,'Marcador de Texto',3.5),(8,'Grampeador',15),(9,'Caixa de Grampos',2.5),(10,'Tesoura',7),(11,'Régua',2),(12,'Cola Branca',3),(13,'Fita Adesiva',4),(14,'Papel Sulfite',20),(15,'Pasta Plástica',2.5),(16,'Envelope',1),(17,'Clips de Papel',1.5),(18,'Prendedor de Papel',2),(19,'Calculadora',25),(20,'Agenda',12),(21,'Carimbo',8),(22,'Tinta para Carimbo',5),(23,'Papel Cartão',3),(24,'Papel Crepom',2),(25,'Papel Contact',6),(26,'Papel Vegetal',4),(27,'Papel A4',15),(28,'Papel A3',25),(29,'Papel A5',10),(30,'Pasta Suspensa',3),(31,'Porta Lápis',5),(32,'Porta Canetas',4),(33,'Porta Clips',3),(34,'Porta Documentos',8),(35,'Porta Cartões',6),(36,'Porta Recados',4),(37,'Porta Etiquetas',5),(38,'Porta CDs',7),(39,'Porta DVDs',8),(40,'Porta Revistas',10);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-29 22:38:17
