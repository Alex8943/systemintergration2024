-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: kea_library
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Temporary view structure for view `author_books`
--

DROP TABLE IF EXISTS `author_books`;
/*!50001 DROP VIEW IF EXISTS `author_books`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `author_books` AS SELECT 
 1 AS `title`,
 1 AS `username`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `author_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `total_books` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'J.R.R. Tolkien',9),(2,'William Shakespeare',6),(3,'Charles Dickens',10),(4,'Toni Morrison',5),(5,'Johnny sins',6),(6,'J.R.R. Tolkien',5),(7,'William Shakespeare',3),(8,'Charles Dickens',7),(9,'Toni Morrison',2),(10,'Johnny sins',4);
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_interactions`
--

DROP TABLE IF EXISTS `book_interactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_interactions` (
  `book_interaction_id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `user_id` int NOT NULL,
  `interaction_type` varchar(45) NOT NULL,
  PRIMARY KEY (`book_interaction_id`),
  KEY `book_id_idx` (`book_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `book_id_bi` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  CONSTRAINT `user_id_bi` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_interactions`
--

LOCK TABLES `book_interactions` WRITE;
/*!40000 ALTER TABLE `book_interactions` DISABLE KEYS */;
INSERT INTO `book_interactions` VALUES (1,1,2,'Bookmark'),(2,2,3,'Borrowed'),(3,3,4,'Has_Borrowed'),(4,4,5,'Bookmark'),(5,5,1,'Borrowed'),(6,6,2,'Has_Borrowed'),(7,7,3,'Bookmark'),(8,8,4,'Borrowed'),(9,9,5,'Has_Borrowed'),(10,10,1,'Bookmark');
/*!40000 ALTER TABLE `book_interactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_available_amount_books` AFTER INSERT ON `book_interactions` FOR EACH ROW BEGIN
	IF NEW.interaction_type = 'Borrowed' THEN
		UPDATE books
			SET available_amount = available_amount - 1
			WHERE book_id = NEW.book_id;
	END IF;
	IF NEW.interaction_type = 'Returned' THEN
		UPDATE books
			SET available_amount = available_amount + 1
			WHERE book_id = NEW.book_id;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `picture` varchar(45) DEFAULT NULL,
  `summary` varchar(800) NOT NULL,
  `pages` int NOT NULL DEFAULT '0',
  `amount` int NOT NULL DEFAULT '1',
  `available_amount` int NOT NULL DEFAULT '1',
  `author_id` int NOT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `book_id_UNIQUE` (`book_id`),
  KEY `author_id_idx` (`author_id`),
  CONSTRAINT `author_id_books` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Necronomicon','book1.jpg','The \'Necronomicon\' is an enigmatic grimoire that looms large in H.P. Lovecraft\'s cosmic horror tales. It\'s a dark and forbidden tome of eldritch knowledge, often tied to otherworldly horrors, arcane rituals, and forbidden lore. Its mere mention sends shivers down the spine of those who delve into the eerie and mysterious realms of Lovecraftian fiction.',300,5,3,1),(2,'Pride and prejudice','book2.jpg','Jane Austen\'s timeless classic, \'Pride and Prejudice\', unfolds in 19th-century England, where spirited Elizabeth Bennet navigates the complexities of love and social class. Her fiery encounters with the enigmatic Mr. Darcy, set against a backdrop of societal conventions, create a tale of wit, romance, and personal growth. Austen\'s astute observations of human nature make this novel a cherished work in the canon of world literature.',250,4,1,2),(3,'Omringet af idioter','book3.jpg','In \'Surrounded by Idiots,\' Thomas Erikson offers a guide to understanding diverse personality types. Drawing from the DISC model, the book categorizes individuals into four main behavioral types: Dominance, Influence, Steadiness, and Conscientiousness. It empowers readers to comprehend why people behave as they do and equips them with practical strategies for effective communication in both personal and professional relationships.',400,7,5,3),(4,'UML for beginners','book4.jpg','\'UML for Beginners\' introduces the Unified Modeling Language (UML) to newcomers in the realm of software development. This book provides a clear, structured approach to learning UML, covering its fundamental principles, diagram types, and notations. It equips readers, whether students, aspiring developers, or professionals, with the knowledge needed to design and convey complex software systems.',150,2,1,1),(5,'To Kill a Mockingbird','book5.jpg','Harper Lee\'s masterpiece, \'To Kill a Mockingbird,\' is a poignant exploration of justice, morality, and the impact of racial prejudice in the American South during the Great Depression. Narrated by young Scout Finch, the story revolves around her father, Atticus Finch, a lawyer who defends a black man unjustly accused of assaulting a white woman. The novel delves into societal biases and the significance of moral courage in the face of injustice, enduring as a classic that champions empathy, compassion, and the pursuit of justice.',280,6,3,4),(6,'1984','book6.jpg','George Orwell\'s dystopian masterpiece explores a world where totalitarian rule, surveillance, and propaganda shape reality. The novel delves into the harrowing consequences of thought control and the pursuit of individualism.',350,3,2,2),(7,'The Great Gatsby','book7.jpg','F. Scott Fitzgerald\'s classic delves into the excesses of the Roaring Twenties, centering on the enigmatic Jay Gatsby\'s unrequited love for Daisy Buchanan. The novel probes themes of wealth, ambition, and the American Dream.',220,4,3,3),(8,'The Hobbit','book8.jpg','J.R.R. Tolkien\'s whimsical adventure introduces the unassuming Bilbo Baggins, who embarks on an epic quest to reclaim treasure guarded by the fearsome dragon Smaug.',270,5,3,4),(9,'The Lord of the Rings','book9.jpg','Tolkien\'s epic trilogy chronicles the epic journey to destroy the One Ring and thwart the dark lord Sauron. The story explores themes of heroism, friendship, and the struggle between good and evil in Middle-earth.',180,2,1,5),(10,'Brave New World','book10.jpg','Aldous Huxley\'s dystopian vision presents a world where technology and a culture of conformity have eliminated suffering and discomfort. Yet, the novel uncovers the price of this utopian existence.',320,6,5,1),(11,'The Da Vinci Code','book11.jpg','Dan Brown\'s thriller unravels a complex mystery involving art, religion, and hidden codes. Harvard professor Robert Langdon races against time to solve a murder and uncover a centuries-old secret.',280,4,3,2),(12,'The Girl with the Dragon Tattoo','book12.jpg','Stieg Larsson\'s gripping mystery follows investigative journalist Mikael Blomkvist and computer hacker Lisbeth Salander as they delve into a chilling decades-old disappearance case, revealing dark secrets in the process.',410,7,6,3),(13,'The Alchemist','book13.jpg','Paulo Coelho\'s allegorical novel tells the story of Santiago, a shepherd on a journey to fulfill his personal legend. Through adventure and self-discovery, he learns the value of following one\'s dreams.',240,3,2,4),(14,'The Catcher in the Rye','book14.jpg','J.D. Salinger\'s iconic novel narrates the experiences of Holden Caulfield, a disenchanted teenager navigating the complexities of adulthood in New York City. The story explores themes of innocence, alienation, and identity.',190,2,2,5),(15,'Moby-Dick','book15.jpg','Herman Melville\'s epic adventure chronicles Captain Ahab\'s relentless pursuit of the great white whale, Moby Dick. The novel delves into themes of obsession, revenge, and the power of nature.',340,5,4,1);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_total_books_author` AFTER INSERT ON `books` FOR EACH ROW BEGIN
	UPDATE authors
		SET total_books = total_books + 1
		WHERE author_id = NEW.author_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `favorited_authors`
--

DROP TABLE IF EXISTS `favorited_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorited_authors` (
  `favorited_id` int NOT NULL AUTO_INCREMENT,
  `author_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`favorited_id`),
  KEY `author_id_idx` (`author_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `author_id_fa` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`),
  CONSTRAINT `user_id_fa` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorited_authors`
--

LOCK TABLES `favorited_authors` WRITE;
/*!40000 ALTER TABLE `favorited_authors` DISABLE KEYS */;
INSERT INTO `favorited_authors` VALUES (1,1,1),(2,2,3),(3,3,2),(4,4,2),(5,5,4),(6,1,1),(7,2,3),(8,3,2),(9,4,2),(10,5,4);
/*!40000 ALTER TABLE `favorited_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `most_popular`
--

DROP TABLE IF EXISTS `most_popular`;
/*!50001 DROP VIEW IF EXISTS `most_popular`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `most_popular` AS SELECT 
 1 AS `title`,
 1 AS `stars`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `stars` int NOT NULL DEFAULT '3',
  `user_id` int NOT NULL,
  `book_id` int NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `user_id_idx` (`user_id`),
  KEY `book_id_idx` (`book_id`),
  CONSTRAINT `book_id_reviews` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  CONSTRAINT `user_id_reviews` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,4,1,1),(2,5,2,2),(3,3,3,3),(4,4,4,4),(5,5,5,5),(6,4,1,6),(7,5,2,7),(8,3,3,8),(9,4,4,9),(10,5,5,10),(11,4,1,11),(12,5,2,12),(13,3,3,13),(14,4,4,14),(15,5,5,15);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_books`
--

DROP TABLE IF EXISTS `tag_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag_books` (
  `tag_book_id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`tag_book_id`),
  KEY `book_id_idx` (`book_id`),
  KEY `tag_id_idx` (`tag_id`),
  CONSTRAINT `book_id_tb` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  CONSTRAINT `tag_id_tb` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_books`
--

LOCK TABLES `tag_books` WRITE;
/*!40000 ALTER TABLE `tag_books` DISABLE KEYS */;
INSERT INTO `tag_books` VALUES (1,1,1),(2,4,3),(3,8,9),(4,4,4),(5,2,7),(6,3,3),(7,7,6),(8,6,2),(9,1,8),(10,3,10);
/*!40000 ALTER TABLE `tag_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `tag_description` varchar(45) DEFAULT 'Description missing',
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'Fantasy','Books of the fantasy genre'),(2,'Science Fiction','Books of the science fiction genre'),(3,'Mystery','Books of the mystery genre'),(4,'Romance','Books of the romance genre'),(5,'Horror','Books of the horror genre'),(6,'Adventure','Books of the adventure genre'),(7,'Non-Fiction','Non-fiction books'),(8,'Biography','Books about real people'),(9,'History','Books about historical events'),(10,'Self-Help','Self-help and personal development books');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_names`
--

DROP TABLE IF EXISTS `user_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_names` (
  `name_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  PRIMARY KEY (`name_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_names`
--

LOCK TABLES `user_names` WRITE;
/*!40000 ALTER TABLE `user_names` DISABLE KEYS */;
INSERT INTO `user_names` VALUES (1,'John','Doe'),(2,'Jane','Smith'),(3,'Robert','Johnson'),(4,'Emily','Wilson'),(5,'Michael','Brown'),(6,'John','Doe'),(7,'Jane','Smith'),(8,'Robert','Johnson'),(9,'Emily','Wilson'),(10,'Michael','Brown'),(11,'John','Doe'),(12,'Jane','Smith'),(13,'Robert','Johnson'),(14,'Emily','Wilson'),(15,'Michael','Brown'),(16,'John','Doe'),(17,'Jane','Smith'),(18,'Robert','Johnson'),(19,'Emily','Wilson'),(20,'Michael','Brown'),(21,'John','Doe'),(22,'Jane','Smith'),(23,'Robert','Johnson'),(24,'Emily','Wilson'),(25,'Michael','Brown'),(26,'John','Doe'),(27,'Jane','Smith'),(28,'Robert','Johnson'),(29,'Emily','Wilson'),(30,'Michael','Brown'),(31,'John','Doe'),(32,'Jane','Smith'),(33,'Robert','Johnson'),(34,'Emily','Wilson'),(35,'Michael','Brown'),(36,'John','Doe'),(37,'Jane','Smith'),(38,'Robert','Johnson'),(39,'Emily','Wilson'),(40,'Michael','Brown');
/*!40000 ALTER TABLE `user_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2023-09-04 08:00:00',0,NULL),(2,'2023-09-04 09:30:00',1,'2023-09-05 12:45:00'),(3,'2023-09-04 10:15:00',0,NULL),(4,'2023-09-04 11:20:00',0,NULL),(5,'2023-09-04 12:00:00',0,NULL),(6,'2023-09-04 08:00:00',0,NULL),(7,'2023-09-04 09:30:00',1,'2023-09-05 12:45:00'),(8,'2023-09-04 10:15:00',0,NULL),(9,'2023-09-04 11:20:00',0,NULL),(10,'2023-09-04 12:00:00',0,NULL),(11,'2023-09-04 08:00:00',0,NULL),(12,'2023-09-04 09:30:00',1,'2023-09-05 12:45:00'),(13,'2023-09-04 10:15:00',0,NULL),(14,'2023-09-04 11:20:00',0,NULL),(15,'2023-09-04 12:00:00',0,NULL),(16,'2023-09-04 08:00:00',0,NULL),(17,'2023-09-04 09:30:00',1,'2023-09-05 12:45:00'),(18,'2023-09-04 10:15:00',0,NULL),(19,'2023-09-04 11:20:00',0,NULL),(20,'2023-09-04 12:00:00',0,NULL),(21,'2023-09-04 08:00:00',0,NULL),(22,'2023-09-04 09:30:00',1,'2023-09-05 12:45:00'),(23,'2023-09-04 10:15:00',0,NULL),(24,'2023-09-04 11:20:00',0,NULL),(25,'2023-09-04 12:00:00',0,NULL),(26,'2023-09-04 08:00:00',0,NULL),(27,'2023-09-04 09:30:00',1,'2023-09-05 12:45:00'),(28,'2023-09-04 10:15:00',0,NULL),(29,'2023-09-04 11:20:00',0,NULL),(30,'2023-09-04 12:00:00',0,NULL),(31,'2023-09-04 08:00:00',0,NULL),(32,'2023-09-04 09:30:00',1,'2023-09-05 12:45:00'),(33,'2023-09-04 10:15:00',0,NULL),(34,'2023-09-04 11:20:00',0,NULL),(35,'2023-09-04 12:00:00',0,NULL),(36,'2023-09-04 08:00:00',0,NULL),(37,'2023-09-04 09:30:00',1,'2023-09-05 12:45:00'),(38,'2023-09-04 10:15:00',0,NULL),(39,'2023-09-04 11:20:00',0,NULL),(40,'2023-09-04 12:00:00',0,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_data`
--

DROP TABLE IF EXISTS `users_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_data` (
  `users_data_id` int NOT NULL AUTO_INCREMENT,
  `name_id` int NOT NULL,
  `user_id` int NOT NULL,
  `email` varchar(45) NOT NULL,
  `pass` varchar(90) NOT NULL,
  `snap_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`users_data_id`),
  UNIQUE KEY `email` (`email`),
  KEY `user_id_idx` (`user_id`),
  KEY `name_id_idx` (`name_id`),
  CONSTRAINT `name_id_ud` FOREIGN KEY (`name_id`) REFERENCES `user_names` (`name_id`),
  CONSTRAINT `user_id_ud` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_data`
--

LOCK TABLES `users_data` WRITE;
/*!40000 ALTER TABLE `users_data` DISABLE KEYS */;
INSERT INTO `users_data` VALUES (1,1,1,'john.doe@example.com','$2b$10$yNt4jhBZv623HhvhA6zHROoIvPUiJ6qdbZSKdRxiP8TZQuitf1H6a','2023-09-04 08:15:00'),(2,2,2,'jane.smith@example.com','$2b$10$r9Rm423XTtKDn8TXdk7RkuyrVEv5.9gpQ0l7kQjFyc1LxObiygJgC','2023-09-04 09:45:00'),(3,3,3,'robert.johnson@example.com','$2b$10$wRDHlQj9teTa7sjapbwdguAbUEMTMY2dgpmlcncXcMANB4CQ17sx2','2023-09-04 10:30:00'),(4,4,4,'emily.wilson@example.com','$2b$10$jnyf8xRjzvEkvo1xI/DVH..qh17KlAJoTsosWQEkRxkOqtcA9YcJi','2023-09-04 11:25:00'),(5,5,5,'michael.brown@example.com','$2b$10$866vbIssq8bYWpZ.94Zezukztn9NAQmk6VCyvl7O4IjuWfjVKC7ia','2023-09-04 12:10:00');
/*!40000 ALTER TABLE `users_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `author_books`
--

/*!50001 DROP VIEW IF EXISTS `author_books`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `author_books` AS select `b`.`title` AS `title`,`a`.`username` AS `username` from (`authors` `a` join `books` `b`) where (`a`.`author_id` = `b`.`author_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `most_popular`
--

/*!50001 DROP VIEW IF EXISTS `most_popular`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `most_popular` AS select `books`.`title` AS `title`,`reviews`.`stars` AS `stars` from (`books` join `reviews`) where (`reviews`.`stars` >= 4) */;
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

-- Dump completed on 2024-05-30 20:25:06
