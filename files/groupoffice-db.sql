/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.3-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: groupoffice
-- ------------------------------------------------------
-- Server version	11.8.3-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `addressbook_address`
--

DROP TABLE IF EXISTS `addressbook_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_address` (
  `contactId` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `zipCode` varchar(50) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `countryCode` char(2) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL COMMENT 'ISO_3166 Alpha 2 code',
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  KEY `contactId` (`contactId`),
  CONSTRAINT `addressbook_address_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `addressbook_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_address`
--

LOCK TABLES `addressbook_address` WRITE;
/*!40000 ALTER TABLE `addressbook_address` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `addressbook_address` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `addressbook_addressbook`
--

DROP TABLE IF EXISTS `addressbook_addressbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_addressbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(190) NOT NULL,
  `aclId` int(11) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `filesFolderId` int(11) DEFAULT NULL,
  `salutationTemplate` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aclId` (`aclId`),
  KEY `createdBy` (`createdBy`),
  CONSTRAINT `addressbook_addressbook_ibfk_1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`),
  CONSTRAINT `addressbook_addressbook_ibfk_2` FOREIGN KEY (`createdBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_addressbook`
--

LOCK TABLES `addressbook_addressbook` WRITE;
/*!40000 ALTER TABLE `addressbook_addressbook` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `addressbook_addressbook` VALUES
(1,'Shared',10,1,NULL,'Dear [if {{contact.prefixes}}]{{contact.prefixes}}[else][if !{{contact.gender}}]Ms./Mr.[else][if {{contact.gender}}==\"M\"]Mr.[else]Ms.[/if][/if][/if][if {{contact.middleName}}] {{contact.middleName}}[/if] {{contact.lastName}}'),
(2,'Users',23,1,9,'Dear [if {{contact.prefixes}}]{{contact.prefixes}}[else][if !{{contact.gender}}]Ms./Mr.[else][if {{contact.gender}}==\"M\"]Mr.[else]Ms.[/if][/if][/if][if {{contact.middleName}}] {{contact.middleName}}[/if] {{contact.lastName}}');
/*!40000 ALTER TABLE `addressbook_addressbook` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `addressbook_contact`
--

DROP TABLE IF EXISTS `addressbook_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addressBookId` int(11) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `modifiedAt` datetime NOT NULL,
  `modifiedBy` int(11) DEFAULT NULL,
  `goUserId` int(11) DEFAULT NULL,
  `prefixes` varchar(191) DEFAULT NULL COMMENT 'Prefixes like ''Sir''',
  `initials` varchar(50) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `middleName` varchar(55) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `suffixes` varchar(191) DEFAULT NULL COMMENT 'Suffixes like ''Msc.''',
  `salutation` varchar(382) DEFAULT NULL,
  `gender` enum('M','F') DEFAULT NULL COMMENT 'M for Male, F for Female or null for unknown',
  `notes` text DEFAULT NULL,
  `isOrganization` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(191) NOT NULL DEFAULT '' COMMENT 'name field for companies and contacts. It should be the display name of first, middle and last name',
  `IBAN` varchar(50) DEFAULT NULL,
  `registrationNumber` varchar(100) DEFAULT NULL COMMENT 'Company trade registration number',
  `icd` varchar(4) DEFAULT NULL,
  `vatNo` varchar(50) DEFAULT NULL,
  `vatReverseCharge` tinyint(1) NOT NULL DEFAULT 0,
  `debtorNumber` varchar(50) DEFAULT NULL,
  `photoBlobId` binary(40) DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  `jobTitle` varchar(190) DEFAULT NULL,
  `department` varchar(200) DEFAULT NULL,
  `filesFolderId` int(11) DEFAULT NULL,
  `uid` varchar(512) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `vcardBlobId` binary(40) DEFAULT NULL,
  `uri` varchar(512) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `color` char(6) DEFAULT NULL,
  `nameBank` varchar(50) DEFAULT NULL,
  `BIC` varchar(11) DEFAULT NULL,
  `newsletterAllowed` tinyint(1) DEFAULT 1,
  `lastContactAt` datetime DEFAULT NULL,
  `actionAt` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `goUserId` (`goUserId`),
  KEY `owner` (`createdBy`),
  KEY `photoBlobId` (`photoBlobId`),
  KEY `addressBookId` (`addressBookId`),
  KEY `modifiedBy` (`modifiedBy`),
  KEY `vcardBlobId` (`vcardBlobId`),
  KEY `isOrganization` (`isOrganization`),
  KEY `name` (`name`),
  KEY `modifiedAt` (`modifiedAt`),
  KEY `lastName` (`lastName`),
  KEY `isOrganization_2` (`isOrganization`),
  KEY `addressbook_contact_addressBookId_lastName_index` (`addressBookId`,`lastName`),
  KEY `addressbook_contact_addressBookId_name_index` (`addressBookId`,`name`),
  KEY `addressbook_contact_isOrganization_index` (`isOrganization`),
  KEY `addressbook_contact_lastContactAt_index` (`lastContactAt`),
  KEY `addressbook_contact_actionAt_index` (`actionAt`),
  CONSTRAINT `addressbook_contact_ibfk_1` FOREIGN KEY (`addressBookId`) REFERENCES `addressbook_addressbook` (`id`),
  CONSTRAINT `addressbook_contact_ibfk_2` FOREIGN KEY (`photoBlobId`) REFERENCES `core_blob` (`id`),
  CONSTRAINT `addressbook_contact_ibfk_3` FOREIGN KEY (`modifiedBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `addressbook_contact_ibfk_4` FOREIGN KEY (`createdBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `addressbook_contact_ibfk_5` FOREIGN KEY (`goUserId`) REFERENCES `core_user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `addressbook_contact_ibfk_6` FOREIGN KEY (`vcardBlobId`) REFERENCES `core_blob` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_contact`
--

LOCK TABLES `addressbook_contact` WRITE;
/*!40000 ALTER TABLE `addressbook_contact` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `addressbook_contact` VALUES
(1,2,1,'2025-08-19 07:16:56','2025-08-19 07:26:10',1,1,'','','System','','Administrator','','Dear Ms./Mr. Administrator',NULL,NULL,0,'System Administrator','','',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'1-192.168.40.247-groupoffice',NULL,'1-192.168.40.247-groupoffice.vcf',NULL,'','',1,NULL,NULL);
/*!40000 ALTER TABLE `addressbook_contact` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `addressbook_contact_custom_fields`
--

DROP TABLE IF EXISTS `addressbook_contact_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_contact_custom_fields` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `addressbook_contact_custom_fields_ibfk_1` FOREIGN KEY (`id`) REFERENCES `addressbook_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_contact_custom_fields`
--

LOCK TABLES `addressbook_contact_custom_fields` WRITE;
/*!40000 ALTER TABLE `addressbook_contact_custom_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `addressbook_contact_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `addressbook_contact_group`
--

DROP TABLE IF EXISTS `addressbook_contact_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_contact_group` (
  `contactId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  PRIMARY KEY (`contactId`,`groupId`),
  KEY `groupId` (`groupId`),
  CONSTRAINT `addressbook_contact_group_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `addressbook_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `addressbook_contact_group_ibfk_2` FOREIGN KEY (`groupId`) REFERENCES `addressbook_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_contact_group`
--

LOCK TABLES `addressbook_contact_group` WRITE;
/*!40000 ALTER TABLE `addressbook_contact_group` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `addressbook_contact_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `addressbook_contact_star`
--

DROP TABLE IF EXISTS `addressbook_contact_star`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_contact_star` (
  `contactId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `modSeq` int(11) NOT NULL DEFAULT 0,
  `starred` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`contactId`,`userId`),
  KEY `addressbook_contact_star_ibfk_2` (`userId`),
  CONSTRAINT `addressbook_contact_star_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `addressbook_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `addressbook_contact_star_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_contact_star`
--

LOCK TABLES `addressbook_contact_star` WRITE;
/*!40000 ALTER TABLE `addressbook_contact_star` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `addressbook_contact_star` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `addressbook_date`
--

DROP TABLE IF EXISTS `addressbook_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_date` (
  `contactId` int(11) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'birthday',
  `date` date NOT NULL,
  KEY `contactId` (`contactId`),
  CONSTRAINT `addressbook_date_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `addressbook_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_date`
--

LOCK TABLES `addressbook_date` WRITE;
/*!40000 ALTER TABLE `addressbook_date` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `addressbook_date` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `addressbook_email_address`
--

DROP TABLE IF EXISTS `addressbook_email_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_email_address` (
  `contactId` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  KEY `contactId` (`contactId`),
  KEY `email` (`email`),
  CONSTRAINT `addressbook_email_address_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `addressbook_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_email_address`
--

LOCK TABLES `addressbook_email_address` WRITE;
/*!40000 ALTER TABLE `addressbook_email_address` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `addressbook_email_address` VALUES
(1,'work','groupofficeadmin@powermail.mydomainname.com');
/*!40000 ALTER TABLE `addressbook_email_address` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `addressbook_group`
--

DROP TABLE IF EXISTS `addressbook_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addressBookId` int(11) NOT NULL,
  `name` varchar(190) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `addressBookId` (`addressBookId`),
  CONSTRAINT `addressbook_group_ibfk_1` FOREIGN KEY (`addressBookId`) REFERENCES `addressbook_addressbook` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_group`
--

LOCK TABLES `addressbook_group` WRITE;
/*!40000 ALTER TABLE `addressbook_group` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `addressbook_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `addressbook_phone_number`
--

DROP TABLE IF EXISTS `addressbook_phone_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_phone_number` (
  `contactId` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `number` varchar(50) NOT NULL,
  KEY `contactId` (`contactId`),
  CONSTRAINT `addressbook_phone_number_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `addressbook_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_phone_number`
--

LOCK TABLES `addressbook_phone_number` WRITE;
/*!40000 ALTER TABLE `addressbook_phone_number` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `addressbook_phone_number` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `addressbook_portlet_birthday`
--

DROP TABLE IF EXISTS `addressbook_portlet_birthday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_portlet_birthday` (
  `userId` int(11) NOT NULL,
  `addressBookId` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`addressBookId`),
  KEY `addressbook_portlet_birthday_fk2` (`addressBookId`),
  CONSTRAINT `addressbook_portlet_birthday_fk1` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `addressbook_portlet_birthday_fk2` FOREIGN KEY (`addressBookId`) REFERENCES `addressbook_addressbook` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_portlet_birthday`
--

LOCK TABLES `addressbook_portlet_birthday` WRITE;
/*!40000 ALTER TABLE `addressbook_portlet_birthday` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `addressbook_portlet_birthday` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `addressbook_url`
--

DROP TABLE IF EXISTS `addressbook_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_url` (
  `contactId` int(11) NOT NULL,
  `type` varchar(190) NOT NULL,
  `url` varchar(255) NOT NULL,
  KEY `contactId` (`contactId`),
  CONSTRAINT `addressbook_url_ibfk_1` FOREIGN KEY (`contactId`) REFERENCES `addressbook_contact` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_url`
--

LOCK TABLES `addressbook_url` WRITE;
/*!40000 ALTER TABLE `addressbook_url` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `addressbook_url` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `addressbook_user_settings`
--

DROP TABLE IF EXISTS `addressbook_user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbook_user_settings` (
  `userId` int(11) NOT NULL,
  `defaultAddressBookId` int(11) DEFAULT NULL,
  `lastAddressBookId` int(11) DEFAULT NULL,
  `startIn` enum('allcontacts','starred','default','remember') NOT NULL DEFAULT 'allcontacts',
  PRIMARY KEY (`userId`),
  KEY `defaultAddressBookId` (`defaultAddressBookId`),
  CONSTRAINT `addressbook_user_settings_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `addressbook_user_settings_ibfk_2` FOREIGN KEY (`defaultAddressBookId`) REFERENCES `addressbook_addressbook` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook_user_settings`
--

LOCK TABLES `addressbook_user_settings` WRITE;
/*!40000 ALTER TABLE `addressbook_user_settings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `addressbook_user_settings` VALUES
(1,1,NULL,'allcontacts');
/*!40000 ALTER TABLE `addressbook_user_settings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `bookmarks_bookmark`
--

DROP TABLE IF EXISTS `bookmarks_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookmarks_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryId` int(11) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `content` text NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `logo` binary(40) DEFAULT NULL,
  `openExtern` tinyint(1) NOT NULL DEFAULT 1,
  `behaveAsModule` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `createdBy` (`createdBy`),
  KEY `categoryId` (`categoryId`),
  KEY `core_blob_bookmark_logo_idx` (`logo`),
  CONSTRAINT `bookmarks_bookmark_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bookmarks_bookmark_ibfk_2` FOREIGN KEY (`categoryId`) REFERENCES `bookmarks_category` (`id`),
  CONSTRAINT `core_blob_bookmark_logo` FOREIGN KEY (`logo`) REFERENCES `core_blob` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmarks_bookmark`
--

LOCK TABLES `bookmarks_bookmark` WRITE;
/*!40000 ALTER TABLE `bookmarks_bookmark` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `bookmarks_bookmark` VALUES
(3,1,1,'TechnoInfotech','https://technoinfotech.com','','c43a86de899293706941a9b10edcc3b5b1bb20d9',1,0),
(4,1,1,'Innovative Thinking, Practical Solutions - Deepen Dhulla','https://deependhulla.com','Innovative Thinking, Practical Solutions',NULL,1,0);
/*!40000 ALTER TABLE `bookmarks_bookmark` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `bookmarks_category`
--

DROP TABLE IF EXISTS `bookmarks_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookmarks_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) DEFAULT NULL,
  `aclId` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `aclId` (`aclId`),
  KEY `createdBy` (`createdBy`),
  CONSTRAINT `bookmarks_category_acl_ibfk_1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`),
  CONSTRAINT `bookmarks_category_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmarks_category`
--

LOCK TABLES `bookmarks_category` WRITE;
/*!40000 ALTER TABLE `bookmarks_category` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `bookmarks_category` VALUES
(1,1,11,'General');
/*!40000 ALTER TABLE `bookmarks_category` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_calendar`
--

DROP TABLE IF EXISTS `calendar_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_calendar` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `description` text DEFAULT NULL,
  `defaultColor` varchar(21) NOT NULL,
  `timeZone` varchar(45) DEFAULT NULL,
  `webcalUri` varchar(512) DEFAULT NULL,
  `groupId` int(10) unsigned DEFAULT NULL,
  `aclId` int(11) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `ownerId` int(11) DEFAULT NULL,
  `highestItemModSeq` varchar(32) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_calendar_calendar_calendar_resource_group_idx` (`groupId`),
  KEY `fk_calendar_calendar_core_acl1` (`aclId`),
  KEY `fk_calendar_calendar_core_user_creator` (`createdBy`),
  KEY `fk_calendar_calendar_core_user_owner` (`ownerId`),
  CONSTRAINT `fk_calendar_calendar_calendar_resource_group` FOREIGN KEY (`groupId`) REFERENCES `calendar_resource_group` (`id`),
  CONSTRAINT `fk_calendar_calendar_core_acl1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`),
  CONSTRAINT `fk_calendar_calendar_core_user_creator` FOREIGN KEY (`createdBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_calendar_calendar_core_user_owner` FOREIGN KEY (`ownerId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_calendar`
--

LOCK TABLES `calendar_calendar` WRITE;
/*!40000 ALTER TABLE `calendar_calendar` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_calendar` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_calendar_custom_fields`
--

DROP TABLE IF EXISTS `calendar_calendar_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_calendar_custom_fields` (
  `id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_calendar_cf1` FOREIGN KEY (`id`) REFERENCES `calendar_calendar` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_calendar_custom_fields`
--

LOCK TABLES `calendar_calendar_custom_fields` WRITE;
/*!40000 ALTER TABLE `calendar_calendar_custom_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_calendar_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_calendar_event`
--

DROP TABLE IF EXISTS `calendar_calendar_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_calendar_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventId` int(10) unsigned NOT NULL,
  `calendarId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `event_once_per_calendar` (`eventId`,`calendarId`),
  KEY `fk_calendar_calendar_event_calendar_event1_idx` (`eventId`),
  KEY `fk_calendar_calendar_event_calendar_calendar1_idx` (`calendarId`),
  CONSTRAINT `fk_calendar_calendar_event_calendar_calendar1` FOREIGN KEY (`calendarId`) REFERENCES `calendar_calendar` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_calendar_calendar_event_calendar_event1` FOREIGN KEY (`eventId`) REFERENCES `calendar_event` (`eventId`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_calendar_event`
--

LOCK TABLES `calendar_calendar_event` WRITE;
/*!40000 ALTER TABLE `calendar_calendar_event` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_calendar_event` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_calendar_user`
--

DROP TABLE IF EXISTS `calendar_calendar_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_calendar_user` (
  `id` int(10) unsigned NOT NULL,
  `userId` int(11) NOT NULL,
  `isSubscribed` tinyint(1) NOT NULL DEFAULT 0,
  `isVisible` tinyint(1) NOT NULL DEFAULT 0,
  `color` varchar(21) NOT NULL,
  `sortOrder` int(11) NOT NULL DEFAULT 0,
  `timeZone` varchar(45) DEFAULT NULL,
  `includeInAvailability` enum('all','attending','none') NOT NULL DEFAULT 'none',
  `modSeq` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`,`userId`),
  KEY `fk_calendar_calendar_user_core_user1` (`userId`),
  CONSTRAINT `fk_calendar_calendar_user_calendar_calendar1` FOREIGN KEY (`id`) REFERENCES `calendar_calendar` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_calendar_calendar_user_core_user1` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_calendar_user`
--

LOCK TABLES `calendar_calendar_user` WRITE;
/*!40000 ALTER TABLE `calendar_calendar_user` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_calendar_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_category`
--

DROP TABLE IF EXISTS `calendar_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `color` varchar(21) DEFAULT NULL,
  `ownerId` int(11) DEFAULT NULL,
  `calendarId` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`ownerId`),
  KEY `calendar_category_calendar_ibfk_9` (`calendarId`),
  CONSTRAINT `calendar_category_calendar_ibfk_9` FOREIGN KEY (`calendarId`) REFERENCES `calendar_calendar` (`id`) ON DELETE CASCADE,
  CONSTRAINT `calendar_category_ibfk_1` FOREIGN KEY (`ownerId`) REFERENCES `core_user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_category`
--

LOCK TABLES `calendar_category` WRITE;
/*!40000 ALTER TABLE `calendar_category` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_category` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_default_alert`
--

DROP TABLE IF EXISTS `calendar_default_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_default_alert` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `offset` varchar(20) DEFAULT NULL,
  `relativeTo` enum('start','end') NOT NULL DEFAULT 'start',
  `when` date DEFAULT NULL,
  `fk` int(10) unsigned NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`,`fk`,`userId`),
  KEY `fk_calendar_default_alert_calendar_calendar1_idx` (`fk`,`userId`),
  CONSTRAINT `fk_calendar_default_alert_calendar_calendar1` FOREIGN KEY (`fk`, `userId`) REFERENCES `calendar_calendar_user` (`id`, `userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_default_alert`
--

LOCK TABLES `calendar_default_alert` WRITE;
/*!40000 ALTER TABLE `calendar_default_alert` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_default_alert` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_default_alert_with_time`
--

DROP TABLE IF EXISTS `calendar_default_alert_with_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_default_alert_with_time` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `offset` varchar(20) DEFAULT NULL,
  `relativeTo` enum('start','end') NOT NULL DEFAULT 'start',
  `when` datetime DEFAULT NULL,
  `fk` int(10) unsigned NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`,`fk`,`userId`),
  KEY `fk_calendar_default_alert_with_time_calendar_calendar1_idx` (`fk`,`userId`),
  CONSTRAINT `fk_calendar_default_alert_with_time_calendar_calendar1` FOREIGN KEY (`fk`, `userId`) REFERENCES `calendar_calendar_user` (`id`, `userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_default_alert_with_time`
--

LOCK TABLES `calendar_default_alert_with_time` WRITE;
/*!40000 ALTER TABLE `calendar_default_alert_with_time` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_default_alert_with_time` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_event`
--

DROP TABLE IF EXISTS `calendar_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_event` (
  `eventId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prodId` varchar(100) NOT NULL DEFAULT 'Unknown',
  `uid` varchar(255) NOT NULL,
  `sequence` int(10) unsigned NOT NULL DEFAULT 1,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `location` text DEFAULT NULL,
  `locale` varchar(6) DEFAULT NULL,
  `showWithoutTime` tinyint(1) NOT NULL DEFAULT 0,
  `start` datetime NOT NULL COMMENT '@dbType=localdatetime',
  `timeZone` varchar(45) DEFAULT NULL,
  `duration` varchar(32) NOT NULL,
  `priority` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `privacy` enum('public','private','secret') NOT NULL DEFAULT 'public',
  `status` enum('confirmed','cancelled','tentative') NOT NULL DEFAULT 'confirmed',
  `recurrenceRule` text DEFAULT NULL,
  `firstOccurrence` datetime NOT NULL COMMENT '@dbType=localdatetime',
  `lastOccurrence` datetime DEFAULT NULL COMMENT '@dbType=localdatetime',
  `createdAt` datetime DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `modifiedBy` int(11) DEFAULT NULL,
  `isOrigin` tinyint(1) NOT NULL DEFAULT 1,
  `recurrenceId` varchar(24) DEFAULT NULL,
  `etag` varchar(100) DEFAULT NULL,
  `uri` varchar(512) DEFAULT NULL,
  `replyTo` varchar(100) DEFAULT NULL,
  `requestStatus` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`eventId`),
  KEY `calendar_event_firstOccurrence_index` (`firstOccurrence`),
  KEY `calendar_event_lastOccurrence_index` (`lastOccurrence`),
  KEY `fk_calendar_event_core_user1_idx` (`createdBy`),
  KEY `fk_calendar_event_core_user2_idx` (`modifiedBy`),
  KEY `fk_calendar_event_uid_index` (`uid`),
  CONSTRAINT `fk_calendar_event_core_user1` FOREIGN KEY (`createdBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_calendar_event_core_user2` FOREIGN KEY (`modifiedBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_event`
--

LOCK TABLES `calendar_event` WRITE;
/*!40000 ALTER TABLE `calendar_event` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_event` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_event_alert`
--

DROP TABLE IF EXISTS `calendar_event_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_event_alert` (
  `id` int(10) unsigned NOT NULL,
  `offset` varchar(20) DEFAULT NULL,
  `relativeTo` enum('start','end') DEFAULT 'start',
  `when` datetime DEFAULT NULL,
  `fk` int(10) unsigned NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`,`fk`,`userId`),
  KEY `fk_calendar_event_alert_calendar_event_user1_idx` (`fk`,`userId`),
  CONSTRAINT `fk_calendar_event_alert_calendar_event_user1` FOREIGN KEY (`fk`, `userId`) REFERENCES `calendar_event_user` (`eventId`, `userId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_event_alert`
--

LOCK TABLES `calendar_event_alert` WRITE;
/*!40000 ALTER TABLE `calendar_event_alert` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_event_alert` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_event_category`
--

DROP TABLE IF EXISTS `calendar_event_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_event_category` (
  `eventId` int(11) unsigned NOT NULL,
  `categoryId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`eventId`,`categoryId`),
  KEY `calendar_task_category_ibfk_2` (`categoryId`),
  CONSTRAINT `calendar_event_category_ibfk_2` FOREIGN KEY (`categoryId`) REFERENCES `calendar_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `calendar_task_category_ibfk_1` FOREIGN KEY (`eventId`) REFERENCES `calendar_event` (`eventId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_event_category`
--

LOCK TABLES `calendar_event_category` WRITE;
/*!40000 ALTER TABLE `calendar_event_category` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_event_category` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_event_custom_fields`
--

DROP TABLE IF EXISTS `calendar_event_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_event_custom_fields` (
  `id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_calendar_event_cf1` FOREIGN KEY (`id`) REFERENCES `calendar_event` (`eventId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_event_custom_fields`
--

LOCK TABLES `calendar_event_custom_fields` WRITE;
/*!40000 ALTER TABLE `calendar_event_custom_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_event_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_event_link`
--

DROP TABLE IF EXISTS `calendar_event_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_event_link` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventId` int(10) unsigned NOT NULL,
  `href` varchar(100) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `contentType` varchar(129) NOT NULL,
  `size` int(11) NOT NULL,
  `rel` varchar(50) NOT NULL,
  `blobId` binary(40) DEFAULT NULL,
  PRIMARY KEY (`id`,`eventId`),
  KEY `fk_event_attachment_calendar_event1_idx` (`eventId`),
  KEY `fk_calendar_event_link_core_blob1_idx` (`blobId`),
  CONSTRAINT `fk_calendar_event_link_core_blob1` FOREIGN KEY (`blobId`) REFERENCES `core_blob` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_attachment_calendar_event1` FOREIGN KEY (`eventId`) REFERENCES `calendar_event` (`eventId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_event_link`
--

LOCK TABLES `calendar_event_link` WRITE;
/*!40000 ALTER TABLE `calendar_event_link` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_event_link` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_event_location`
--

DROP TABLE IF EXISTS `calendar_event_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_event_location` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eventId` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `relativeTo` int(11) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`id`,`eventId`),
  KEY `fk_event_location_calendar_event1_idx` (`eventId`),
  CONSTRAINT `fk_event_location_calendar_event1` FOREIGN KEY (`eventId`) REFERENCES `calendar_event` (`eventId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_event_location`
--

LOCK TABLES `calendar_event_location` WRITE;
/*!40000 ALTER TABLE `calendar_event_location` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_event_location` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_event_related`
--

DROP TABLE IF EXISTS `calendar_event_related`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_event_related` (
  `type` int(11) NOT NULL,
  `uid` varchar(100) NOT NULL,
  `eventId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`type`,`uid`),
  KEY `fk_calendar_event_related_calendar_event1_idx` (`eventId`),
  CONSTRAINT `fk_calendar_event_related_calendar_event1` FOREIGN KEY (`eventId`) REFERENCES `calendar_event` (`eventId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_event_related`
--

LOCK TABLES `calendar_event_related` WRITE;
/*!40000 ALTER TABLE `calendar_event_related` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_event_related` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_event_user`
--

DROP TABLE IF EXISTS `calendar_event_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_event_user` (
  `eventId` int(10) unsigned NOT NULL,
  `userId` int(11) NOT NULL,
  `freeBusyStatus` enum('free','busy') DEFAULT 'busy',
  `color` varchar(21) DEFAULT NULL,
  `useDefaultAlerts` tinyint(1) DEFAULT 1,
  `veventBlobId` binary(40) DEFAULT NULL,
  `modSeq` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`eventId`,`userId`),
  KEY `fk_calendar_event_user_calendar_event1_idx` (`eventId`),
  KEY `fk_calendar_event_user_core_user1_idx` (`userId`),
  KEY `fk_calendar_event_user_core_blob1_idx` (`veventBlobId`),
  CONSTRAINT `fk_calendar_event_user_calendar_event1` FOREIGN KEY (`eventId`) REFERENCES `calendar_event` (`eventId`) ON DELETE CASCADE,
  CONSTRAINT `fk_calendar_event_user_core_blob1` FOREIGN KEY (`veventBlobId`) REFERENCES `core_blob` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_calendar_event_user_core_user1` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_event_user`
--

LOCK TABLES `calendar_event_user` WRITE;
/*!40000 ALTER TABLE `calendar_event_user` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_event_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_participant`
--

DROP TABLE IF EXISTS `calendar_participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_participant` (
  `id` varchar(128) NOT NULL,
  `eventId` int(10) unsigned NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `kind` enum('individual','group','location','resource','unknown') NOT NULL,
  `rolesMask` int(11) NOT NULL DEFAULT 0,
  `language` varchar(20) DEFAULT NULL,
  `participationStatus` enum('needs-action','tentative','accepted','declined','delegated') DEFAULT 'needs-action',
  `expectReply` tinyint(1) NOT NULL DEFAULT 0,
  `scheduleUpdated` datetime DEFAULT NULL,
  `scheduleStatus` varchar(255) DEFAULT NULL,
  `scheduleSecret` char(16) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  PRIMARY KEY (`id`,`eventId`),
  KEY `fk_participant_calendar_event1_idx` (`eventId`),
  CONSTRAINT `fk_participant_calendar_event1` FOREIGN KEY (`eventId`) REFERENCES `calendar_event` (`eventId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_participant`
--

LOCK TABLES `calendar_participant` WRITE;
/*!40000 ALTER TABLE `calendar_participant` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_participant` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_preferences`
--

DROP TABLE IF EXISTS `calendar_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_preferences` (
  `userId` int(11) NOT NULL,
  `weekViewGridSnap` int(11) DEFAULT NULL,
  `weekViewGridSize` int(11) NOT NULL DEFAULT 8,
  `defaultDuration` varchar(32) DEFAULT NULL,
  `autoUpdateInvitations` tinyint(1) NOT NULL DEFAULT 0,
  `autoAddInvitations` tinyint(1) NOT NULL DEFAULT 0,
  `markReadAndFileAutoAdd` tinyint(1) NOT NULL DEFAULT 0,
  `markReadAndFileAutoUpdate` tinyint(1) NOT NULL DEFAULT 0,
  `lastProcessed` varchar(11) NOT NULL DEFAULT '',
  `lastProcessedUid` bigint(20) NOT NULL DEFAULT 1,
  `showDeclined` tinyint(1) NOT NULL DEFAULT 1,
  `showWeekNumbers` tinyint(1) NOT NULL DEFAULT 1,
  `birthdaysAreVisible` tinyint(1) NOT NULL DEFAULT 0,
  `tasksAreVisible` tinyint(1) NOT NULL DEFAULT 0,
  `holidaysAreVisible` tinyint(1) NOT NULL DEFAULT 0,
  `showTooltips` tinyint(1) NOT NULL DEFAULT 1,
  `defaultCalendarId` int(10) unsigned DEFAULT NULL,
  `startView` enum('week','month','year','list') DEFAULT 'month',
  PRIMARY KEY (`userId`),
  CONSTRAINT `calendar_preferences_core_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_preferences`
--

LOCK TABLES `calendar_preferences` WRITE;
/*!40000 ALTER TABLE `calendar_preferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `calendar_preferences` VALUES
(1,15,8,NULL,0,1,0,0,'',1,1,1,0,0,0,1,NULL,'month');
/*!40000 ALTER TABLE `calendar_preferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_recurrence_override`
--

DROP TABLE IF EXISTS `calendar_recurrence_override`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_recurrence_override` (
  `fk` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `recurrenceId` datetime NOT NULL COMMENT '@dbType=localdatetime',
  `patch` mediumtext NOT NULL,
  PRIMARY KEY (`fk`,`recurrenceId`),
  KEY `fk_recurrence_override_calendar_event1_idx` (`fk`),
  CONSTRAINT `fk_recurrence_override_calendar_event1` FOREIGN KEY (`fk`) REFERENCES `calendar_event` (`eventId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_recurrence_override`
--

LOCK TABLES `calendar_recurrence_override` WRITE;
/*!40000 ALTER TABLE `calendar_recurrence_override` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_recurrence_override` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_resource_group`
--

DROP TABLE IF EXISTS `calendar_resource_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_resource_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `defaultOwnerId` int(11) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calendar_resource_group_core_user_id_fk` (`defaultOwnerId`),
  KEY `fk_calendar_resource_group_core_user_creator` (`createdBy`),
  CONSTRAINT `calendar_resource_group_core_user_id_fk` FOREIGN KEY (`defaultOwnerId`) REFERENCES `core_user` (`id`),
  CONSTRAINT `fk_calendar_resource_group_core_user_creator` FOREIGN KEY (`createdBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_resource_group`
--

LOCK TABLES `calendar_resource_group` WRITE;
/*!40000 ALTER TABLE `calendar_resource_group` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_resource_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `calendar_schedule_object`
--

DROP TABLE IF EXISTS `calendar_schedule_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_schedule_object` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `principaluri` varbinary(255) DEFAULT NULL,
  `calendardata` mediumblob DEFAULT NULL,
  `uri` varbinary(200) DEFAULT NULL,
  `lastmodified` int(11) unsigned DEFAULT NULL,
  `etag` varbinary(32) DEFAULT NULL,
  `size` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_schedule_object`
--

LOCK TABLES `calendar_schedule_object` WRITE;
/*!40000 ALTER TABLE `calendar_schedule_object` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `calendar_schedule_object` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `comments_comment`
--

DROP TABLE IF EXISTS `comments_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL,
  `date` datetime NOT NULL,
  `entityId` int(11) NOT NULL,
  `entityTypeId` int(11) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `modifiedBy` int(11) DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  `text` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci DEFAULT NULL,
  `section` varchar(50) DEFAULT NULL,
  `mimeMessageId` varchar(255) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `fk_comments_comment_core_entity_type_idx` (`entityId`),
  KEY `fk_comments_comment_core_user1_idx` (`createdBy`),
  KEY `fk_comments_comment_core_user2_idx` (`modifiedBy`),
  KEY `section` (`section`),
  KEY `comments_comment_mimeMessageId_index` (`mimeMessageId`),
  KEY `comments_comment_core_entity_id_fk` (`entityTypeId`),
  CONSTRAINT `comments_comment_core_entity_id_fk` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_comments_comment_core_user1` FOREIGN KEY (`createdBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_comments_comment_core_user2` FOREIGN KEY (`modifiedBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_comment`
--

LOCK TABLES `comments_comment` WRITE;
/*!40000 ALTER TABLE `comments_comment` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `comments_comment` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `comments_comment_attachment`
--

DROP TABLE IF EXISTS `comments_comment_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_comment_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `commentId` int(11) NOT NULL,
  `blobId` binary(40) DEFAULT NULL,
  `name` varchar(190) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_comment_attachment_comments_comment_id_fk` (`commentId`),
  KEY `comments_comment_attachment_core_blob_id_fk` (`blobId`),
  CONSTRAINT `comments_comment_attachment_comments_comment_id_fk` FOREIGN KEY (`commentId`) REFERENCES `comments_comment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_comment_attachment_core_blob_id_fk` FOREIGN KEY (`blobId`) REFERENCES `core_blob` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_comment_attachment`
--

LOCK TABLES `comments_comment_attachment` WRITE;
/*!40000 ALTER TABLE `comments_comment_attachment` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `comments_comment_attachment` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `comments_comment_image`
--

DROP TABLE IF EXISTS `comments_comment_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_comment_image` (
  `commentId` int(11) NOT NULL,
  `blobId` binary(40) NOT NULL,
  PRIMARY KEY (`commentId`,`blobId`),
  KEY `blobId` (`blobId`),
  CONSTRAINT `comments_comment_image_ibfk_1` FOREIGN KEY (`blobId`) REFERENCES `core_blob` (`id`),
  CONSTRAINT `comments_comment_image_ibfk_2` FOREIGN KEY (`commentId`) REFERENCES `comments_comment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_comment_image`
--

LOCK TABLES `comments_comment_image` WRITE;
/*!40000 ALTER TABLE `comments_comment_image` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `comments_comment_image` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `comments_comment_label`
--

DROP TABLE IF EXISTS `comments_comment_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_comment_label` (
  `labelId` int(11) NOT NULL,
  `commentId` int(11) NOT NULL,
  PRIMARY KEY (`labelId`,`commentId`),
  KEY `fk_comments_label_has_comments_comment_comments_comment1_idx` (`commentId`),
  KEY `fk_comments_label_has_comments_comment_comments_label1_idx` (`labelId`),
  CONSTRAINT `fk_comments_label_has_comments_comment_comments_comment1` FOREIGN KEY (`commentId`) REFERENCES `comments_comment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_comments_label_has_comments_comment_comments_label1` FOREIGN KEY (`labelId`) REFERENCES `comments_label` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_comment_label`
--

LOCK TABLES `comments_comment_label` WRITE;
/*!40000 ALTER TABLE `comments_comment_label` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `comments_comment_label` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `comments_label`
--

DROP TABLE IF EXISTS `comments_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(127) NOT NULL DEFAULT '',
  `color` char(6) NOT NULL DEFAULT '243a80',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_label`
--

LOCK TABLES `comments_label` WRITE;
/*!40000 ALTER TABLE `comments_label` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `comments_label` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_acl`
--

DROP TABLE IF EXISTS `core_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_acl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ownedBy` int(11) DEFAULT NULL,
  `usedIn` varchar(190) DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  `entityTypeId` int(11) DEFAULT NULL,
  `entityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_acl_ibfk_1` (`entityTypeId`),
  KEY `ownedBy` (`ownedBy`),
  CONSTRAINT `core_acl_ibfk_1` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE SET NULL,
  CONSTRAINT `core_acl_ibfk_2` FOREIGN KEY (`ownedBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_acl`
--

LOCK TABLES `core_acl` WRITE;
/*!40000 ALTER TABLE `core_acl` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_acl` VALUES
(1,1,'core_group.aclId','2025-08-19 07:16:40',11,1),
(2,1,'core_group.aclId','2025-08-19 07:16:40',11,2),
(3,1,'core_group.aclId','2025-08-19 07:16:40',11,3),
(4,1,'core_group.aclId','2025-08-19 07:16:40',11,4),
(5,1,'core_entity.defaultAclId','2025-08-19 07:16:40',8,NULL),
(6,1,'core_entity.defaultAclId','2025-08-19 07:16:40',10,NULL),
(7,1,'core_entity.defaultAclId','2025-08-19 07:16:40',11,NULL),
(8,1,'go_templates.acl_id','2025-08-19 07:16:40',26,1),
(9,1,'core_entity.defaultAclId','2025-08-19 07:16:40',26,NULL),
(10,1,'addressbook_addressbook.aclId','2025-08-19 07:16:41',27,1),
(11,1,'bookmarks_category.aclId','2025-08-19 07:16:41',31,1),
(12,1,'core_entity.defaultAclId','2025-08-19 07:16:46',32,NULL),
(13,1,'notes_note_book.aclId','2025-08-19 07:16:46',40,65),
(14,1,'fs_templates.acl_id','2025-08-19 07:16:47',47,1),
(15,1,'core_entity.defaultAclId','2025-08-19 07:16:47',47,NULL),
(16,1,'fs_templates.acl_id','2025-08-19 07:16:47',47,2),
(17,1,'core_module.shadowAclId','2025-08-19 07:16:47',14,14),
(18,1,'fs_folders.acl_id','2025-08-19 07:16:47',46,2),
(19,1,'core_entity.defaultAclId','2025-08-19 07:16:47',46,NULL),
(20,1,'fs_folders.acl_id','2025-08-19 07:16:47',46,3),
(21,1,'fs_folders.acl_id','2025-08-19 07:16:47',46,4),
(22,1,'core_entity.defaultAclId','2025-08-19 07:16:56',27,NULL),
(23,1,'addressbook_addressbook.aclId','2025-08-19 07:16:56',27,2),
(24,1,'core_entity.defaultAclId','2025-08-19 07:16:56',43,NULL),
(25,1,'tasks_tasklist.aclId','2025-08-19 07:16:56',43,1),
(26,1,'core_module.shadowAclId','2025-08-19 07:17:16',14,7),
(27,1,'core_entity.defaultAclId','2025-08-19 07:17:17',19,NULL),
(28,1,'core_entity.defaultAclId','2025-08-19 07:17:17',22,NULL),
(29,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,1),
(30,1,'core_entity.defaultAclId','2025-08-19 07:17:17',27,NULL),
(31,1,'fs_folders.acl_id','2025-08-19 07:30:12',46,8),
(32,1,'core_entity.defaultAclId','2025-08-19 07:17:17',31,NULL),
(33,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,3),
(34,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,4),
(35,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,5),
(36,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,6),
(37,1,'core_entity.defaultAclId','2025-08-19 07:17:17',38,NULL),
(38,1,'core_entity.defaultAclId','2025-08-19 07:17:17',40,NULL),
(39,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,8),
(40,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,9),
(41,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,10),
(42,1,'core_entity.defaultAclId','2025-08-19 07:17:17',43,NULL),
(43,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,11),
(44,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,12),
(45,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,13),
(46,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,15),
(47,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,16),
(48,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,17),
(49,1,'core_module.shadowAclId','2025-08-19 07:17:17',14,18),
(50,1,'core_entity.defaultAclId','2025-08-19 07:17:20',19,NULL),
(51,1,'core_entity.defaultAclId','2025-08-19 07:17:20',22,NULL),
(52,1,'core_entity.defaultAclId','2025-08-19 07:17:44',19,NULL),
(53,1,'core_entity.defaultAclId','2025-08-19 07:17:44',22,NULL),
(54,1,'core_entity.defaultAclId','2025-08-19 07:17:46',19,NULL),
(55,1,'core_entity.defaultAclId','2025-08-19 07:17:46',22,NULL),
(56,1,'core_module.shadowAclId','2025-08-19 07:18:15',14,19),
(57,1,'core_module.shadowAclId','2025-08-19 07:18:32',14,20),
(58,1,'core_module.shadowAclId','2025-08-19 07:18:46',14,21),
(59,1,'core_module.shadowAclId','2025-08-19 07:18:57',14,22),
(60,1,'core_module.shadowAclId','2025-08-19 07:19:32',14,23),
(61,1,'core_module.shadowAclId','2025-08-19 07:19:37',14,24);
/*!40000 ALTER TABLE `core_acl` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_acl_group`
--

DROP TABLE IF EXISTS `core_acl_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_acl_group` (
  `aclId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL DEFAULT 0,
  `level` tinyint(4) NOT NULL DEFAULT 10,
  PRIMARY KEY (`aclId`,`groupId`),
  KEY `level` (`level`),
  KEY `groupId` (`groupId`),
  CONSTRAINT `core_acl_group_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_acl_group_ibfk_2` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_acl_group`
--

LOCK TABLES `core_acl_group` WRITE;
/*!40000 ALTER TABLE `core_acl_group` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_acl_group` VALUES
(1,1,10),
(2,2,10),
(3,3,10),
(4,4,10),
(5,2,10),
(7,2,10),
(8,3,10),
(11,3,10),
(12,3,10),
(14,3,10),
(16,3,10),
(17,3,10),
(23,3,10),
(29,2,10),
(31,3,10),
(33,3,10),
(35,3,10),
(36,3,10),
(39,3,10),
(40,3,10),
(43,3,10),
(44,3,10),
(45,3,10),
(46,3,10),
(47,3,10),
(48,3,10),
(59,3,10),
(61,3,10),
(6,2,30),
(10,3,40),
(13,3,40),
(20,3,40),
(21,1,50);
/*!40000 ALTER TABLE `core_acl_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_acl_group_changes`
--

DROP TABLE IF EXISTS `core_acl_group_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_acl_group_changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aclId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `modSeq` int(11) NOT NULL,
  `granted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `aclId` (`aclId`,`groupId`,`modSeq`),
  KEY `group` (`groupId`),
  CONSTRAINT `all` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `group` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_acl_group_changes`
--

LOCK TABLES `core_acl_group_changes` WRITE;
/*!40000 ALTER TABLE `core_acl_group_changes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_acl_group_changes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_alert`
--

DROP TABLE IF EXISTS `core_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_alert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entityTypeId` int(11) NOT NULL,
  `entityId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `triggerAt` datetime NOT NULL,
  `staleAt` datetime DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `recurrenceId` varchar(32) DEFAULT NULL,
  `data` text DEFAULT NULL,
  `sendMail` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_alert_entityTypeId_entityId_tag_userId_uindex` (`entityTypeId`,`entityId`,`tag`,`userId`),
  KEY `dk_alert_entityType_idx` (`entityTypeId`),
  KEY `fk_alert_user_idx` (`userId`),
  CONSTRAINT `fk_alert_entityType` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_alert_user` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_alert`
--

LOCK TABLES `core_alert` WRITE;
/*!40000 ALTER TABLE `core_alert` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_alert` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_auth_allow_group`
--

DROP TABLE IF EXISTS `core_auth_allow_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_auth_allow_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `ipPattern` varchar(50) NOT NULL COMMENT 'IP Address. Wildcards can be used where * matches anything and ? matches exactly one character',
  PRIMARY KEY (`id`),
  KEY `groupId` (`groupId`),
  CONSTRAINT `core_auth_allow_group_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_auth_allow_group`
--

LOCK TABLES `core_auth_allow_group` WRITE;
/*!40000 ALTER TABLE `core_auth_allow_group` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_auth_allow_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_auth_method`
--

DROP TABLE IF EXISTS `core_auth_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_auth_method` (
  `id` varchar(100) NOT NULL,
  `moduleId` int(11) NOT NULL,
  `sortOrder` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `moduleId` (`moduleId`),
  KEY `moduleId_sortOrder` (`moduleId`,`sortOrder`),
  CONSTRAINT `core_auth_method_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `core_module` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_auth_method`
--

LOCK TABLES `core_auth_method` WRITE;
/*!40000 ALTER TABLE `core_auth_method` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_auth_method` VALUES
('password',1,1),
('forcepasswordchange',1,2),
('otpauthenticator',9,3),
('imap',21,4),
('openid',23,5);
/*!40000 ALTER TABLE `core_auth_method` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_auth_password`
--

DROP TABLE IF EXISTS `core_auth_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_auth_password` (
  `userId` int(11) NOT NULL,
  `password` varchar(190) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `core_auth_password_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_auth_password`
--

LOCK TABLES `core_auth_password` WRITE;
/*!40000 ALTER TABLE `core_auth_password` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_auth_password` VALUES
(1,'$2y$10$ovVGQ8FLS8Q8xmaWrUMDouaChbxQoCHrgEUfSpc65RWc0DcASfbzW');
/*!40000 ALTER TABLE `core_auth_password` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_auth_remember_me`
--

DROP TABLE IF EXISTS `core_auth_remember_me`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_auth_remember_me` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(190) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `series` varchar(190) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `expiresAt` datetime DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `clientId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_auth_remember_me_series_index` (`series`),
  KEY `core_auth_remember_me_core_user_id_fk` (`userId`),
  KEY `fk_core_auth_remember_me_core_client1_idx` (`clientId`),
  CONSTRAINT `core_auth_remember_me_core_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_core_auth_remember_me_core_client1` FOREIGN KEY (`clientId`) REFERENCES `core_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_auth_remember_me`
--

LOCK TABLES `core_auth_remember_me` WRITE;
/*!40000 ALTER TABLE `core_auth_remember_me` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_auth_remember_me` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_auth_token`
--

DROP TABLE IF EXISTS `core_auth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_auth_token` (
  `loginToken` varchar(100) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `accessToken` varchar(100) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `CSRFToken` varchar(100) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `expiresAt` datetime DEFAULT NULL,
  `passedAuthenticators` varchar(190) DEFAULT NULL,
  `clientId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`loginToken`),
  UNIQUE KEY `core_auth_token_pk` (`accessToken`),
  KEY `fk_core_auth_token_core_client1_idx` (`clientId`),
  KEY `fk_core_auth_token_core_user1_idx` (`userId`),
  CONSTRAINT `fk_core_auth_token_core_client1` FOREIGN KEY (`clientId`) REFERENCES `core_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_core_auth_token_core_user1` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_auth_token`
--

LOCK TABLES `core_auth_token` WRITE;
/*!40000 ALTER TABLE `core_auth_token` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_auth_token` VALUES
('68a424e884ea5d2ae4fa153237e264680b719d967ab04','68a424fd08b0959e19f7573eebbb7967268508a6701f4','68a424fd08b0f5213b36b4ad6c29ca20d36486c9a5183',1,'2025-08-19 07:16:56','2025-08-20 07:37:44','password|forcepasswordchange',1);
/*!40000 ALTER TABLE `core_auth_token` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_blob`
--

DROP TABLE IF EXISTS `core_blob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_blob` (
  `id` binary(40) NOT NULL,
  `type` varchar(129) NOT NULL,
  `size` bigint(20) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  `staleAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staleAt` (`staleAt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_blob`
--

LOCK TABLES `core_blob` WRITE;
/*!40000 ALTER TABLE `core_blob` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_blob` VALUES
('c43a86de899293706941a9b10edcc3b5b1bb20d9','image/x-icon',530,'technoinfotech_com.ico','2025-08-19 07:22:00','2025-08-19 07:22:00','2025-08-19 08:22:00'),
('f384ee1dd8a66f36a425dce7b08992d7a6a68c36','image/x-icon',696,'www_group-office_com.ico','2025-08-19 07:16:42','2025-08-19 07:16:42','2025-08-19 08:16:42');
/*!40000 ALTER TABLE `core_blob` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_change`
--

DROP TABLE IF EXISTS `core_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_change` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entityId` varchar(100) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `entityTypeId` int(11) NOT NULL,
  `modSeq` int(11) NOT NULL,
  `aclId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `destroyed` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `aclId` (`aclId`),
  KEY `entityTypeId` (`entityTypeId`),
  KEY `entityId` (`entityId`),
  KEY `core_change_modSeq_entityTypeId_entityId_destroyed_index` (`modSeq`,`entityTypeId`,`entityId`,`destroyed`),
  CONSTRAINT `core_change_ibfk_1` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_change_ibfk_2` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_change`
--

LOCK TABLES `core_change` WRITE;
/*!40000 ALTER TABLE `core_change` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_change` VALUES
(65,'2',6,1,29,'2025-08-19 13:01:02',0),
(66,'2',6,2,29,'2025-08-19 13:06:01',0),
(67,'2',6,3,29,'2025-08-19 13:11:01',0),
(68,'2',6,4,29,'2025-08-19 13:16:01',0);
/*!40000 ALTER TABLE `core_change` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_change_user`
--

DROP TABLE IF EXISTS `core_change_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_change_user` (
  `userId` int(11) NOT NULL,
  `entityId` int(11) NOT NULL,
  `entityTypeId` int(11) NOT NULL,
  `modSeq` int(11) NOT NULL,
  PRIMARY KEY (`userId`,`entityId`,`entityTypeId`),
  KEY `entityTypeId` (`entityTypeId`),
  KEY `core_change_user_modSeq_userId_entityTypeId_entityId_index` (`modSeq`,`userId`,`entityTypeId`),
  CONSTRAINT `core_change_user_ibfk_1` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_change_user_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_change_user`
--

LOCK TABLES `core_change_user` WRITE;
/*!40000 ALTER TABLE `core_change_user` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_change_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_change_user_modseq`
--

DROP TABLE IF EXISTS `core_change_user_modseq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_change_user_modseq` (
  `userId` int(11) NOT NULL,
  `entityTypeId` int(11) NOT NULL,
  `highestModSeq` int(11) NOT NULL DEFAULT 0,
  `lowestModSeq` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`userId`,`entityTypeId`),
  KEY `entityTypeId` (`entityTypeId`),
  CONSTRAINT `core_change_user_modseq_ibfk_1` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_change_user_modseq_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_change_user_modseq`
--

LOCK TABLES `core_change_user_modseq` WRITE;
/*!40000 ALTER TABLE `core_change_user_modseq` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_change_user_modseq` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_client`
--

DROP TABLE IF EXISTS `core_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_client` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deviceId` varchar(80) NOT NULL,
  `platform` varchar(45) NOT NULL,
  `name` varchar(80) NOT NULL,
  `version` varchar(190) NOT NULL,
  `ip` varchar(45) NOT NULL,
  `lastSeen` datetime NOT NULL,
  `createdAt` datetime NOT NULL,
  `status` enum('new','allowed','denied') NOT NULL DEFAULT 'new',
  `needResync` tinyint(1) DEFAULT 0,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_client_core_user_id_fk` (`userId`),
  CONSTRAINT `core_client_core_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_client`
--

LOCK TABLES `core_client` WRITE;
/*!40000 ALTER TABLE `core_client` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_client` VALUES
(1,'-','Macintosh','Chrome','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36','192.168.190.3','2025-08-19 07:16:56','2025-08-19 07:16:56','allowed',0,1);
/*!40000 ALTER TABLE `core_client` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_cron_job`
--

DROP TABLE IF EXISTS `core_cron_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_cron_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moduleId` int(11) NOT NULL,
  `description` varchar(190) NOT NULL,
  `name` varchar(190) NOT NULL,
  `expression` varchar(190) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `nextRunAt` datetime DEFAULT NULL,
  `lastRunAt` datetime DEFAULT NULL,
  `runningSince` datetime DEFAULT NULL,
  `lastError` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `moduleId` (`moduleId`),
  CONSTRAINT `core_cron_job_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `core_module` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_cron_job`
--

LOCK TABLES `core_cron_job` WRITE;
/*!40000 ALTER TABLE `core_cron_job` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_cron_job` VALUES
(1,1,'Garbage collection','GarbageCollection','0 0 * * *',1,'2025-08-20 00:00:00',NULL,NULL,NULL),
(2,4,'ScanEmailForInvites','ScanEmailForInvites','*/5 * * * *',1,'2025-08-19 09:51:00','2025-08-19 09:46:01',NULL,NULL);
/*!40000 ALTER TABLE `core_cron_job` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_customfields_field`
--

DROP TABLE IF EXISTS `core_customfields_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_customfields_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldSetId` int(11) NOT NULL,
  `modSeq` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `databaseName` varchar(190) DEFAULT NULL,
  `type` varchar(100) NOT NULL DEFAULT 'Text',
  `sortOrder` int(11) NOT NULL DEFAULT 0,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `relatedFieldCondition` text DEFAULT NULL,
  `conditionallyHidden` tinyint(1) NOT NULL DEFAULT 0,
  `conditionallyRequired` tinyint(1) NOT NULL DEFAULT 0,
  `hint` varchar(190) DEFAULT NULL,
  `exclude_from_grid` tinyint(1) NOT NULL DEFAULT 0,
  `unique_values` tinyint(1) NOT NULL DEFAULT 0,
  `prefix` varchar(32) NOT NULL DEFAULT '',
  `suffix` varchar(32) NOT NULL DEFAULT '',
  `options` text DEFAULT NULL,
  `hiddenInGrid` tinyint(1) NOT NULL DEFAULT 1,
  `filterable` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `type` (`fieldSetId`),
  KEY `modSeq` (`modSeq`),
  CONSTRAINT `core_customfields_field_ibfk_1` FOREIGN KEY (`fieldSetId`) REFERENCES `core_customfields_field_set` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_customfields_field`
--

LOCK TABLES `core_customfields_field` WRITE;
/*!40000 ALTER TABLE `core_customfields_field` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_customfields_field` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_customfields_field_set`
--

DROP TABLE IF EXISTS `core_customfields_field_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_customfields_field_set` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modSeq` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `entityId` int(11) NOT NULL,
  `aclId` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `sortOrder` tinyint(4) NOT NULL DEFAULT 0,
  `filter` text DEFAULT NULL,
  `isTab` tinyint(1) NOT NULL DEFAULT 0,
  `collapseIfEmpty` tinyint(1) NOT NULL DEFAULT 0,
  `columns` tinyint(4) NOT NULL DEFAULT 2,
  `parentFieldSetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entityId` (`entityId`),
  KEY `aclId` (`aclId`),
  KEY `modSeq` (`modSeq`),
  KEY `core_customfields_field_set_core_customfields_field_set_id_fk` (`parentFieldSetId`),
  CONSTRAINT `core_customfields_field_set_core_customfields_field_set_id_fk` FOREIGN KEY (`parentFieldSetId`) REFERENCES `core_customfields_field_set` (`id`) ON DELETE SET NULL,
  CONSTRAINT `core_customfields_field_set_ibfk_1` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_customfields_field_set_ibfk_2` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_customfields_field_set`
--

LOCK TABLES `core_customfields_field_set` WRITE;
/*!40000 ALTER TABLE `core_customfields_field_set` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_customfields_field_set` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_customfields_select_option`
--

DROP TABLE IF EXISTS `core_customfields_select_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_customfields_select_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `foregroundColor` varchar(6) DEFAULT NULL,
  `backgroundColor` varchar(6) DEFAULT NULL,
  `renderMode` varchar(20) DEFAULT NULL,
  `sortOrder` int(11) unsigned DEFAULT 0,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `field_id` (`fieldId`),
  KEY `parentId` (`parentId`),
  CONSTRAINT `core_customfields_select_option_ibfk_1` FOREIGN KEY (`fieldId`) REFERENCES `core_customfields_field` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_customfields_select_option_ibfk_2` FOREIGN KEY (`fieldId`) REFERENCES `core_customfields_field` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_customfields_select_option_ibfk_3` FOREIGN KEY (`parentId`) REFERENCES `core_customfields_select_option` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_customfields_select_option`
--

LOCK TABLES `core_customfields_select_option` WRITE;
/*!40000 ALTER TABLE `core_customfields_select_option` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_customfields_select_option` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_email_template`
--

DROP TABLE IF EXISTS `core_email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_email_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moduleId` int(11) NOT NULL,
  `key` varchar(20) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `language` varchar(20) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT 'en',
  `name` varchar(190) NOT NULL,
  `subject` varchar(190) DEFAULT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_email_template_moduleId_key_index` (`moduleId`,`key`),
  KEY `moduleId` (`moduleId`),
  CONSTRAINT `core_email_template_ibfk_2` FOREIGN KEY (`moduleId`) REFERENCES `core_module` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_email_template`
--

LOCK TABLES `core_email_template` WRITE;
/*!40000 ALTER TABLE `core_email_template` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_email_template` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_email_template_attachment`
--

DROP TABLE IF EXISTS `core_email_template_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_email_template_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `emailTemplateId` int(11) NOT NULL,
  `blobId` binary(40) NOT NULL,
  `name` varchar(190) NOT NULL,
  `inline` tinyint(1) NOT NULL DEFAULT 0,
  `attachment` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `templateId` (`emailTemplateId`),
  KEY `blobId` (`blobId`),
  CONSTRAINT `core_email_template_attachment_ibfk_1` FOREIGN KEY (`blobId`) REFERENCES `core_blob` (`id`),
  CONSTRAINT `core_email_template_attachment_ibfk_2` FOREIGN KEY (`emailTemplateId`) REFERENCES `core_email_template` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_email_template_attachment`
--

LOCK TABLES `core_email_template_attachment` WRITE;
/*!40000 ALTER TABLE `core_email_template_attachment` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_email_template_attachment` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_entity`
--

DROP TABLE IF EXISTS `core_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moduleId` int(11) DEFAULT NULL,
  `name` varchar(190) NOT NULL,
  `clientName` varchar(190) DEFAULT NULL,
  `highestModSeq` int(11) NOT NULL DEFAULT 0,
  `defaultAclId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clientName` (`clientName`),
  UNIQUE KEY `name` (`name`,`moduleId`) USING BTREE,
  KEY `moduleId` (`moduleId`),
  KEY `core_entity_ibfk_2` (`defaultAclId`),
  CONSTRAINT `core_entity_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `core_module` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_entity_ibfk_2` FOREIGN KEY (`defaultAclId`) REFERENCES `core_acl` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_entity`
--

LOCK TABLES `core_entity` WRITE;
/*!40000 ALTER TABLE `core_entity` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_entity` VALUES
(1,1,'Method','Method',0,NULL),
(2,1,'Blob','Blob',0,NULL),
(3,1,'Acl','Acl',0,NULL),
(4,1,'Alert','Alert',0,NULL),
(5,1,'AuthAllowGroup','AuthAllowGroup',0,NULL),
(6,1,'CronJobSchedule','CronJobSchedule',4,NULL),
(7,1,'EmailTemplate','EmailTemplate',0,NULL),
(8,1,'EntityFilter','EntityFilter',0,5),
(9,1,'Field','Field',0,NULL),
(10,1,'FieldSet','FieldSet',0,6),
(11,1,'Group','Group',0,7),
(12,1,'ImportMapping','ImportMapping',0,NULL),
(13,1,'Link','Link',0,NULL),
(14,1,'Module','Module',0,NULL),
(15,1,'OauthAccessToken','OauthAccessToken',0,NULL),
(16,1,'OauthAuthCode','OauthAuthCode',0,NULL),
(17,1,'OauthClient','OauthClient',0,NULL),
(18,1,'PdfTemplate','PdfTemplate',0,NULL),
(19,1,'Principal','Principal',0,54),
(20,1,'RememberMe','RememberMe',0,NULL),
(21,1,'Search','Search',0,NULL),
(22,1,'SmtpAccount','SmtpAccount',0,55),
(23,1,'SpreadSheetExport','SpreadSheetExport',0,NULL),
(24,1,'Token','Token',0,NULL),
(25,1,'User','User',0,NULL),
(26,1,'Template','Template',0,9),
(27,2,'AddressBook','AddressBook',0,30),
(28,2,'Contact','Contact',0,NULL),
(29,2,'Group','AddressBookGroup',0,NULL),
(30,3,'Bookmark','Bookmark',0,NULL),
(31,3,'Category','BookmarksCategory',0,32),
(32,4,'Calendar','Calendar',0,12),
(33,4,'CalendarEvent','CalendarEvent',0,NULL),
(34,4,'Category','CalendarCategory',0,NULL),
(35,4,'ResourceGroup','ResourceGroup',0,NULL),
(36,6,'Comment','Comment',0,NULL),
(37,6,'Label','CommentLabel',0,NULL),
(38,7,'LogEntry','LogEntry',0,37),
(39,8,'Note','Note',0,NULL),
(40,8,'NoteBook','NoteBook',0,38),
(41,11,'Category','TaskCategory',0,NULL),
(42,11,'Task','Task',0,NULL),
(43,11,'TaskList','TaskList',0,42),
(44,11,'TaskListGrouping','TaskListGrouping',0,NULL),
(45,14,'File','File',0,NULL),
(46,14,'Folder','Folder',0,19),
(47,14,'Template','FilesTemplate',0,15),
(48,21,'Server','ImapAuthServer',0,NULL),
(49,23,'DefaultClient','DefaultClient',0,NULL),
(50,23,'Oauth2Client','Oauth2Client',0,NULL);
/*!40000 ALTER TABLE `core_entity` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_entity_filter`
--

DROP TABLE IF EXISTS `core_entity_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_entity_filter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entityTypeId` int(11) NOT NULL,
  `name` varchar(190) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `filter` text DEFAULT NULL,
  `aclId` int(11) NOT NULL,
  `type` enum('fixed','variable') NOT NULL DEFAULT 'fixed',
  PRIMARY KEY (`id`),
  KEY `aclid` (`aclId`),
  KEY `createdBy` (`createdBy`),
  KEY `entityTypeId` (`entityTypeId`),
  CONSTRAINT `core_entity_filter_ibfk_1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`),
  CONSTRAINT `core_entity_filter_ibfk_2` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_entity_filter`
--

LOCK TABLES `core_entity_filter` WRITE;
/*!40000 ALTER TABLE `core_entity_filter` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_entity_filter` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_group`
--

DROP TABLE IF EXISTS `core_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(190) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `aclId` int(11) DEFAULT NULL,
  `isUserGroupFor` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `isUserGroupFor` (`isUserGroupFor`),
  KEY `aclId` (`aclId`),
  CONSTRAINT `core_group_ibfk_1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`),
  CONSTRAINT `core_group_ibfk_2` FOREIGN KEY (`isUserGroupFor`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_group`
--

LOCK TABLES `core_group` WRITE;
/*!40000 ALTER TABLE `core_group` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_group` VALUES
(1,'Admins',1,1,NULL),
(2,'Everyone',1,2,NULL),
(3,'Internal',1,3,NULL),
(4,'groupofficeadmin',1,4,1);
/*!40000 ALTER TABLE `core_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_group_default_group`
--

DROP TABLE IF EXISTS `core_group_default_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_group_default_group` (
  `groupId` int(11) NOT NULL,
  PRIMARY KEY (`groupId`),
  CONSTRAINT `core_group_default_group_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_group_default_group`
--

LOCK TABLES `core_group_default_group` WRITE;
/*!40000 ALTER TABLE `core_group_default_group` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_group_default_group` VALUES
(3);
/*!40000 ALTER TABLE `core_group_default_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_import_mapping`
--

DROP TABLE IF EXISTS `core_import_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_import_mapping` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entityTypeId` int(11) DEFAULT NULL,
  `checksum` char(32) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `name` varchar(120) NOT NULL DEFAULT '(unnamed)',
  `mapping` text DEFAULT NULL,
  `updateBy` varchar(100) DEFAULT NULL,
  `dateFormat` varchar(20) DEFAULT NULL,
  `timeFormat` varchar(20) DEFAULT NULL,
  `decimalSeparator` char(1) DEFAULT NULL,
  `thousandsSeparator` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_import_mapping_core_entity_null_fk` (`entityTypeId`),
  CONSTRAINT `core_import_mapping_core_entity_null_fk` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_import_mapping`
--

LOCK TABLES `core_import_mapping` WRITE;
/*!40000 ALTER TABLE `core_import_mapping` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_import_mapping` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_link`
--

DROP TABLE IF EXISTS `core_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fromEntityTypeId` int(11) NOT NULL,
  `fromId` int(11) NOT NULL,
  `toEntityTypeId` int(11) NOT NULL,
  `toId` int(11) NOT NULL,
  `description` varchar(190) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `modSeq` int(11) DEFAULT NULL,
  `folderId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fromEntityId` (`fromEntityTypeId`,`fromId`,`toEntityTypeId`,`toId`) USING BTREE,
  KEY `toEntity` (`toEntityTypeId`),
  KEY `fromEntityTypeId` (`fromEntityTypeId`),
  KEY `fromId` (`fromId`),
  KEY `toEntityTypeId` (`toEntityTypeId`),
  KEY `toId` (`toId`),
  CONSTRAINT `fromEntity` FOREIGN KEY (`fromEntityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `toEntity` FOREIGN KEY (`toEntityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_link`
--

LOCK TABLES `core_link` WRITE;
/*!40000 ALTER TABLE `core_link` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_link` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_module`
--

DROP TABLE IF EXISTS `core_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `package` varchar(100) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `admin_menu` tinyint(1) NOT NULL DEFAULT 0,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `modifiedAt` datetime DEFAULT NULL,
  `modSeq` int(11) DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `shadowAclId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`package`),
  KEY `core_module_core_acl_id_fk` (`shadowAclId`),
  CONSTRAINT `core_module_core_acl_id_fk` FOREIGN KEY (`shadowAclId`) REFERENCES `core_acl` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_module`
--

LOCK TABLES `core_module` WRITE;
/*!40000 ALTER TABLE `core_module` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_module` VALUES
(1,'core','core',419,0,0,1,NULL,NULL,NULL,29),
(2,'addressbook','community',95,101,0,1,NULL,NULL,NULL,31),
(3,'bookmarks','community',11,102,0,1,NULL,NULL,NULL,33),
(4,'calendar','community',28,103,0,1,NULL,NULL,NULL,34),
(5,'carddav','community',0,104,0,1,NULL,NULL,NULL,35),
(6,'comments','community',40,105,0,1,NULL,NULL,NULL,36),
(7,'history','community',15,106,0,1,NULL,NULL,NULL,26),
(8,'notes','community',60,107,0,1,NULL,NULL,NULL,39),
(9,'otp','community',8,108,0,1,NULL,NULL,NULL,40),
(10,'pwned','community',0,109,0,1,NULL,NULL,NULL,41),
(11,'tasks','community',64,110,0,1,NULL,NULL,NULL,43),
(12,'dav',NULL,1,111,0,1,'2025-08-19 07:16:46',NULL,NULL,44),
(13,'email',NULL,122,111,0,1,'2025-08-19 07:16:46',NULL,NULL,45),
(14,'files',NULL,150,111,0,1,'2025-08-19 07:16:47',NULL,NULL,17),
(15,'sieve',NULL,0,111,0,1,'2025-08-19 07:16:47',NULL,NULL,46),
(16,'summary',NULL,32,111,0,1,'2025-08-19 07:16:47',NULL,NULL,47),
(17,'sync',NULL,59,111,0,1,'2025-08-19 07:16:47',NULL,NULL,48),
(18,'zpushadmin',NULL,8,111,1,1,'2025-08-19 07:16:47',NULL,NULL,49),
(19,'customcss',NULL,0,111,1,1,'2025-08-19 07:18:15',NULL,NULL,56),
(20,'googleauthenticator','community',8,111,0,1,NULL,NULL,NULL,57),
(21,'imapauthenticator','community',1,112,0,1,NULL,NULL,NULL,58),
(22,'reminders',NULL,0,113,0,1,'2025-08-19 07:18:57',NULL,NULL,59),
(23,'oauth2client','community',7,113,0,1,NULL,NULL,NULL,60),
(24,'smime',NULL,16,114,0,1,'2025-08-19 07:19:36',NULL,NULL,61);
/*!40000 ALTER TABLE `core_module` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_oauth_access_token`
--

DROP TABLE IF EXISTS `core_oauth_access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_oauth_access_token` (
  `identifier` varchar(128) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `expiryDateTime` datetime DEFAULT NULL,
  `userIdentifier` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  PRIMARY KEY (`identifier`),
  KEY `userIdentifier` (`userIdentifier`),
  KEY `clientId` (`clientId`),
  CONSTRAINT `core_oauth_access_token_ibfk_2` FOREIGN KEY (`userIdentifier`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_oauth_access_token_ibfk_3` FOREIGN KEY (`clientId`) REFERENCES `core_oauth_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_oauth_access_token`
--

LOCK TABLES `core_oauth_access_token` WRITE;
/*!40000 ALTER TABLE `core_oauth_access_token` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_oauth_access_token` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_oauth_auth_codes`
--

DROP TABLE IF EXISTS `core_oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_oauth_auth_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `identifier` varchar(128) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `userIdentifier` int(11) NOT NULL,
  `expiryDateTime` datetime NOT NULL,
  `nonce` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_oauth_auth_codes`
--

LOCK TABLES `core_oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `core_oauth_auth_codes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_oauth_client`
--

DROP TABLE IF EXISTS `core_oauth_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_oauth_client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(128) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `isConfidential` tinyint(1) NOT NULL,
  `name` varchar(128) NOT NULL,
  `redirectUri` text NOT NULL,
  `secret` varchar(128) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_oauth_client`
--

LOCK TABLES `core_oauth_client` WRITE;
/*!40000 ALTER TABLE `core_oauth_client` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_oauth_client` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_pdf_block`
--

DROP TABLE IF EXISTS `core_pdf_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_pdf_block` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pdfTemplateId` bigint(20) unsigned NOT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `align` enum('L','C','R','J') NOT NULL DEFAULT 'L',
  `content` text NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'text',
  PRIMARY KEY (`id`),
  KEY `pdfTemplateId` (`pdfTemplateId`),
  CONSTRAINT `core_pdf_block_ibfk_1` FOREIGN KEY (`pdfTemplateId`) REFERENCES `core_pdf_template` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_pdf_block`
--

LOCK TABLES `core_pdf_block` WRITE;
/*!40000 ALTER TABLE `core_pdf_block` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_pdf_block` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_pdf_template`
--

DROP TABLE IF EXISTS `core_pdf_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_pdf_template` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `moduleId` int(11) NOT NULL,
  `key` varchar(20) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `language` varchar(20) NOT NULL DEFAULT 'en',
  `name` varchar(50) NOT NULL,
  `stationaryBlobId` binary(40) DEFAULT NULL,
  `logoBlobId` binary(40) DEFAULT NULL,
  `landscape` tinyint(1) NOT NULL DEFAULT 0,
  `pageSize` varchar(20) NOT NULL DEFAULT 'A4',
  `measureUnit` enum('mm','pt','cm','in') NOT NULL DEFAULT 'mm',
  `marginTop` decimal(19,4) NOT NULL DEFAULT 20.0000,
  `marginRight` decimal(19,4) NOT NULL DEFAULT 10.0000,
  `marginBottom` decimal(19,4) NOT NULL DEFAULT 20.0000,
  `marginLeft` decimal(19,4) NOT NULL DEFAULT 10.0000,
  `header` text DEFAULT NULL,
  `headerX` decimal(19,4) DEFAULT 0.0000,
  `headerY` decimal(19,4) DEFAULT 10.0000,
  `footer` text DEFAULT NULL,
  `footerX` decimal(19,4) DEFAULT 0.0000,
  `footerY` decimal(19,4) DEFAULT -20.0000,
  `fontFamily` varchar(100) NOT NULL DEFAULT 'dejavusans',
  `fontSize` tinyint(4) DEFAULT 10,
  PRIMARY KEY (`id`),
  KEY `core_pdf_template_core_blob_id_fk` (`logoBlobId`),
  KEY `core_pdf_template_key_index` (`moduleId`,`key`),
  KEY `stationaryBlobId` (`stationaryBlobId`),
  CONSTRAINT `core_pdf_template_core_blob_id_fk` FOREIGN KEY (`logoBlobId`) REFERENCES `core_blob` (`id`),
  CONSTRAINT `core_pdf_template_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `core_module` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_pdf_template_ibfk_2` FOREIGN KEY (`stationaryBlobId`) REFERENCES `core_blob` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_pdf_template`
--

LOCK TABLES `core_pdf_template` WRITE;
/*!40000 ALTER TABLE `core_pdf_template` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_pdf_template` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_permission`
--

DROP TABLE IF EXISTS `core_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_permission` (
  `moduleId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `rights` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`moduleId`,`groupId`),
  KEY `fk_permission_group_idx` (`groupId`),
  CONSTRAINT `fk_permission_group` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_permission_module` FOREIGN KEY (`moduleId`) REFERENCES `core_module` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_permission`
--

LOCK TABLES `core_permission` WRITE;
/*!40000 ALTER TABLE `core_permission` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_permission` VALUES
(1,2,0),
(2,3,2),
(3,3,0),
(5,3,0),
(6,3,0),
(8,3,1),
(9,3,0),
(11,3,1),
(12,3,0),
(13,3,0),
(14,3,2),
(15,3,0),
(16,3,0),
(17,3,0),
(22,3,0),
(24,3,0);
/*!40000 ALTER TABLE `core_permission` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_principal`
--

DROP TABLE IF EXISTS `core_principal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_principal` (
  `id` varchar(60) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `type` enum('individual','group','resource','location','other') DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `timeZone` varchar(129) DEFAULT NULL,
  `entityTypeId` int(11) NOT NULL,
  `avatarId` binary(40) DEFAULT NULL,
  `entityId` int(10) unsigned NOT NULL,
  `aclId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_core_entity_id` (`entityTypeId`),
  KEY `index_core_blob_id` (`avatarId`),
  KEY `fk_core_principal_core_acl1` (`aclId`),
  CONSTRAINT `fk_core_principal_core_acl1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`),
  CONSTRAINT `lnk_core_blob_core_principal` FOREIGN KEY (`avatarId`) REFERENCES `core_blob` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `lnk_core_entity_core_principal` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_principal`
--

LOCK TABLES `core_principal` WRITE;
/*!40000 ALTER TABLE `core_principal` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_principal` VALUES
('1','System Administrator','groupofficeadmin@powermail.mydomainname.com','individual','groupofficeadmin','Asia/Calcutta',25,NULL,1,4),
('Contact:1','System Administrator','groupofficeadmin@powermail.mydomainname.com','individual','Contact ',NULL,28,NULL,1,23);
/*!40000 ALTER TABLE `core_principal` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_search`
--

DROP TABLE IF EXISTS `core_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entityId` int(11) NOT NULL,
  `moduleId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(190) NOT NULL DEFAULT '',
  `entityTypeId` int(11) NOT NULL,
  `filter` varchar(190) DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  `aclId` int(11) NOT NULL,
  `rebuild` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`entityTypeId`),
  KEY `acl_id` (`aclId`),
  KEY `moduleId` (`moduleId`),
  KEY `entityTypeId` (`entityTypeId`),
  KEY `core_search_entityTypeId_filter_modifiedAt_aclId_index` (`entityTypeId`,`filter`,`modifiedAt`,`aclId`),
  KEY `core_search_filter_index` (`filter`),
  CONSTRAINT `core_search_ibfk_1` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `core_search_ibfk_2` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_search`
--

LOCK TABLES `core_search` WRITE;
/*!40000 ALTER TABLE `core_search` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_search` VALUES
(1,2,14,'groupofficeadmin','users/groupofficeadmin',46,NULL,'2025-08-19 07:16:47',18,0),
(2,3,14,'Public','users/groupofficeadmin/Public',46,NULL,'2025-08-19 07:16:47',20,0),
(3,1,2,'System Administrator','Users',28,'isContact','2025-08-19 07:26:10',23,0),
(4,6,14,'customcss','public/customcss',46,NULL,'2025-08-19 07:19:50',17,0),
(5,9,14,'Users','addressbook/Users',46,NULL,'2025-08-19 07:30:12',23,0);
/*!40000 ALTER TABLE `core_search` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_search_word`
--

DROP TABLE IF EXISTS `core_search_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_search_word` (
  `searchId` int(11) NOT NULL,
  `word` varchar(100) NOT NULL,
  PRIMARY KEY (`word`,`searchId`),
  KEY `searchId` (`searchId`),
  CONSTRAINT `core_search_word_ibfk_1` FOREIGN KEY (`searchId`) REFERENCES `core_search` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_search_word`
--

LOCK TABLES `core_search_word` WRITE;
/*!40000 ALTER TABLE `core_search_word` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_search_word` VALUES
(1,'2'),
(1,'folder'),
(1,'groupofficeadmin'),
(1,'users/groupofficeadmin'),
(2,'3'),
(2,'folder'),
(2,'public'),
(2,'users/groupofficeadmin/public'),
(3,'1'),
(3,'administrator'),
(3,'com'),
(3,'groupofficeadmin@powermail.mydomainname.com'),
(3,'mydomainname'),
(3,'powermail'),
(3,'system'),
(4,'6'),
(4,'customcss'),
(4,'folder'),
(4,'public/customcss'),
(5,'9'),
(5,'addressbook/users'),
(5,'folder'),
(5,'users');
/*!40000 ALTER TABLE `core_search_word` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_setting`
--

DROP TABLE IF EXISTS `core_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_setting` (
  `moduleId` int(11) NOT NULL,
  `name` varchar(190) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`moduleId`,`name`),
  CONSTRAINT `module` FOREIGN KEY (`moduleId`) REFERENCES `core_module` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_setting`
--

LOCK TABLES `core_setting` WRITE;
/*!40000 ALTER TABLE `core_setting` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_setting` VALUES
(1,'cacheClearedAt','1755588624'),
(1,'corsAllowOrigin',''),
(1,'databaseVersion','25.0.41'),
(1,'demoDataAsked','1'),
(1,'language','en'),
(1,'locale','C.utf8'),
(1,'lostPasswordURL','0'),
(1,'smtpEncryption',NULL),
(1,'smtpHost','127.0.0.1'),
(1,'smtpPassword',NULL),
(1,'smtpPort','25'),
(1,'systemEmail','postmaster@powermail.mydomainname.com'),
(1,'URL','https://powermail.mydomainname.com/groupoffice/'),
(1,'userAddressBookId','2'),
(1,'welcomeShown','1'),
(2,'autoLinkAddressBookIds',NULL),
(4,'videoJwtSecret','');
/*!40000 ALTER TABLE `core_setting` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_smtp_account`
--

DROP TABLE IF EXISTS `core_smtp_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_smtp_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moduleId` int(11) NOT NULL,
  `aclId` int(11) NOT NULL,
  `hostname` varchar(190) NOT NULL,
  `port` int(11) NOT NULL DEFAULT 587,
  `username` varchar(190) DEFAULT NULL,
  `password` text DEFAULT NULL,
  `encryption` enum('tls','ssl') DEFAULT 'tls',
  `verifyCertificate` tinyint(1) NOT NULL DEFAULT 1,
  `fromName` varchar(190) NOT NULL,
  `fromEmail` varchar(190) NOT NULL,
  `maxMessagesPerMinute` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `moduleId` (`moduleId`),
  KEY `aclId` (`aclId`),
  CONSTRAINT `core_smtp_account_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `core_module` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_smtp_account_ibfk_2` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_smtp_account`
--

LOCK TABLES `core_smtp_account` WRITE;
/*!40000 ALTER TABLE `core_smtp_account` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_smtp_account` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_spreadsheet_export`
--

DROP TABLE IF EXISTS `core_spreadsheet_export`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_spreadsheet_export` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `entityTypeId` int(11) NOT NULL,
  `name` varchar(190) NOT NULL,
  `columns` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `entityTypeId` (`entityTypeId`),
  KEY `name` (`name`),
  CONSTRAINT `core_spreadsheet_export_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_spreadsheet_export_ibfk_2` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_spreadsheet_export`
--

LOCK TABLES `core_spreadsheet_export` WRITE;
/*!40000 ALTER TABLE `core_spreadsheet_export` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_spreadsheet_export` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_user`
--

DROP TABLE IF EXISTS `core_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(190) NOT NULL,
  `displayName` varchar(190) NOT NULL,
  `avatarId` binary(40) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `email` varchar(100) NOT NULL,
  `recoveryEmail` varchar(100) NOT NULL,
  `recoveryHash` varchar(40) DEFAULT NULL,
  `recoverySendAt` datetime DEFAULT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  `dateFormat` varchar(20) NOT NULL DEFAULT 'd-m-Y',
  `shortDateInList` tinyint(1) NOT NULL DEFAULT 1,
  `timeFormat` varchar(10) NOT NULL DEFAULT 'G:i',
  `thousandsSeparator` varchar(1) NOT NULL DEFAULT '.',
  `decimalSeparator` varchar(1) NOT NULL DEFAULT ',',
  `currency` char(3) NOT NULL DEFAULT '',
  `loginCount` int(11) NOT NULL DEFAULT 0,
  `max_rows_list` tinyint(4) NOT NULL DEFAULT 20,
  `timezone` varchar(50) NOT NULL DEFAULT 'Europe/Amsterdam',
  `start_module` varchar(50) NOT NULL DEFAULT 'summary',
  `language` varchar(20) NOT NULL DEFAULT 'en',
  `theme` varchar(20) NOT NULL DEFAULT 'Paper',
  `themeColorScheme` enum('light','dark','system') NOT NULL DEFAULT 'light',
  `firstWeekday` tinyint(4) NOT NULL DEFAULT 1,
  `sort_name` varchar(20) NOT NULL DEFAULT 'first_name',
  `muser_id` int(11) NOT NULL DEFAULT 0,
  `mute_sound` tinyint(1) NOT NULL DEFAULT 0,
  `mute_reminder_sound` tinyint(1) NOT NULL DEFAULT 0,
  `mute_new_mail_sound` tinyint(1) NOT NULL DEFAULT 0,
  `show_smilies` tinyint(1) NOT NULL DEFAULT 1,
  `auto_punctuation` tinyint(1) NOT NULL DEFAULT 0,
  `listSeparator` char(3) NOT NULL DEFAULT ';',
  `textSeparator` char(3) NOT NULL DEFAULT '"',
  `files_folder_id` int(11) NOT NULL DEFAULT 0,
  `disk_quota` bigint(20) DEFAULT NULL,
  `disk_usage` bigint(20) NOT NULL DEFAULT 0,
  `mail_reminders` tinyint(1) NOT NULL DEFAULT 0,
  `holidayset` varchar(10) DEFAULT NULL,
  `sort_email_addresses_by_time` tinyint(1) NOT NULL DEFAULT 0,
  `no_reminders` tinyint(1) NOT NULL DEFAULT 0,
  `homeDir` varchar(190) NOT NULL,
  `confirmOnMove` tinyint(1) NOT NULL DEFAULT 0,
  `passwordModifiedAt` datetime DEFAULT NULL,
  `forcePasswordChange` tinyint(1) NOT NULL DEFAULT 0,
  `enableSendShortcut` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `fk_user_avatar_id_idx` (`avatarId`),
  KEY `email` (`email`),
  CONSTRAINT `fk_user_avatar_id` FOREIGN KEY (`avatarId`) REFERENCES `core_blob` (`id`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user`
--

LOCK TABLES `core_user` WRITE;
/*!40000 ALTER TABLE `core_user` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_user` VALUES
(1,'groupofficeadmin','System Administrator',NULL,1,'groupofficeadmin@powermail.mydomainname.com','groupofficeadmin@powermail.mydomainname.com',NULL,NULL,'2025-08-19 07:17:17','2025-08-19 07:16:40','2025-08-19 07:28:24','d-m-Y',1,'G:i','.',',','‚Ç¨',1,50,'Asia/Calcutta','summary','en_gb','Paper','light',1,'first_name',0,0,0,0,1,0,';','\"',0,NULL,0,0,NULL,0,0,'users/groupofficeadmin',0,'2025-08-19 07:17:17',0,1);
/*!40000 ALTER TABLE `core_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_user_custom_fields`
--

DROP TABLE IF EXISTS `core_user_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_user_custom_fields` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `core_user_custom_fields_ibfk_1` FOREIGN KEY (`id`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user_custom_fields`
--

LOCK TABLES `core_user_custom_fields` WRITE;
/*!40000 ALTER TABLE `core_user_custom_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_user_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_user_default_group`
--

DROP TABLE IF EXISTS `core_user_default_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_user_default_group` (
  `groupId` int(11) NOT NULL,
  PRIMARY KEY (`groupId`),
  CONSTRAINT `core_user_default_group_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user_default_group`
--

LOCK TABLES `core_user_default_group` WRITE;
/*!40000 ALTER TABLE `core_user_default_group` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_user_default_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_user_group`
--

DROP TABLE IF EXISTS `core_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_user_group` (
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`groupId`,`userId`),
  KEY `userId` (`userId`),
  CONSTRAINT `core_user_group_ibfk_1` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `core_user_group_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user_group`
--

LOCK TABLES `core_user_group` WRITE;
/*!40000 ALTER TABLE `core_user_group` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_user_group` VALUES
(1,1),
(2,1),
(4,1);
/*!40000 ALTER TABLE `core_user_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `dav_locks`
--

DROP TABLE IF EXISTS `dav_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dav_locks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owner` varchar(100) DEFAULT NULL,
  `timeout` int(10) unsigned DEFAULT NULL,
  `created` int(11) DEFAULT NULL,
  `token` varbinary(100) DEFAULT NULL,
  `scope` tinyint(4) DEFAULT NULL,
  `depth` tinyint(4) DEFAULT NULL,
  `uri` varbinary(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`),
  KEY `uri` (`uri`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dav_locks`
--

LOCK TABLES `dav_locks` WRITE;
/*!40000 ALTER TABLE `dav_locks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `dav_locks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `em_accounts`
--

DROP TABLE IF EXISTS `em_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `acl_id` int(11) NOT NULL DEFAULT 0,
  `host` varchar(100) DEFAULT NULL,
  `port` int(11) NOT NULL DEFAULT 0,
  `deprecated_use_ssl` tinyint(1) NOT NULL DEFAULT 0,
  `novalidate_cert` tinyint(1) NOT NULL DEFAULT 0,
  `username` varchar(190) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `imap_encryption` char(3) NOT NULL,
  `imap_allow_self_signed` tinyint(1) NOT NULL DEFAULT 1,
  `mbroot` varchar(30) NOT NULL DEFAULT '',
  `sent` varchar(100) DEFAULT 'Sent',
  `drafts` varchar(100) DEFAULT 'Drafts',
  `trash` varchar(100) NOT NULL DEFAULT 'Trash',
  `spam` varchar(100) NOT NULL DEFAULT 'Spam',
  `smtp_host` varchar(100) DEFAULT NULL,
  `smtp_port` int(11) NOT NULL,
  `smtp_encryption` char(10) NOT NULL,
  `smtp_allow_self_signed` tinyint(1) NOT NULL DEFAULT 0,
  `smtp_username` varchar(190) DEFAULT NULL,
  `smtp_password` varchar(512) NOT NULL DEFAULT '',
  `password_encrypted` tinyint(4) NOT NULL DEFAULT 0,
  `ignore_sent_folder` tinyint(1) NOT NULL DEFAULT 0,
  `save_sent` tinyint(1) NOT NULL DEFAULT 1,
  `sieve_port` int(11) NOT NULL,
  `sieve_usetls` tinyint(1) NOT NULL DEFAULT 1,
  `check_mailboxes` text DEFAULT NULL,
  `do_not_mark_as_read` tinyint(1) NOT NULL DEFAULT 0,
  `signature_below_reply` tinyint(1) NOT NULL DEFAULT 0,
  `full_reply_headers` tinyint(1) NOT NULL DEFAULT 0,
  `force_smtp_login` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_accounts`
--

LOCK TABLES `em_accounts` WRITE;
/*!40000 ALTER TABLE `em_accounts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `em_accounts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `em_accounts_collapsed`
--

DROP TABLE IF EXISTS `em_accounts_collapsed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_accounts_collapsed` (
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`account_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_accounts_collapsed`
--

LOCK TABLES `em_accounts_collapsed` WRITE;
/*!40000 ALTER TABLE `em_accounts_collapsed` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `em_accounts_collapsed` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `em_accounts_sort`
--

DROP TABLE IF EXISTS `em_accounts_sort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_accounts_sort` (
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  PRIMARY KEY (`account_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_accounts_sort`
--

LOCK TABLES `em_accounts_sort` WRITE;
/*!40000 ALTER TABLE `em_accounts_sort` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `em_accounts_sort` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `em_aliases`
--

DROP TABLE IF EXISTS `em_aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_aliases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `signature` text DEFAULT NULL,
  `default` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_aliases`
--

LOCK TABLES `em_aliases` WRITE;
/*!40000 ALTER TABLE `em_aliases` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `em_aliases` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `em_contacts_last_mail_times`
--

DROP TABLE IF EXISTS `em_contacts_last_mail_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_contacts_last_mail_times` (
  `contact_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `last_mail_time` int(11) NOT NULL,
  PRIMARY KEY (`contact_id`,`user_id`),
  KEY `em_contacts_last_mail_times_core_user_id_fk` (`user_id`),
  KEY `last_mail_time` (`last_mail_time`),
  CONSTRAINT `em_contacts_last_mail_times_addressbook_addressbook_id_fk` FOREIGN KEY (`contact_id`) REFERENCES `addressbook_contact` (`id`) ON DELETE CASCADE,
  CONSTRAINT `em_contacts_last_mail_times_core_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_contacts_last_mail_times`
--

LOCK TABLES `em_contacts_last_mail_times` WRITE;
/*!40000 ALTER TABLE `em_contacts_last_mail_times` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `em_contacts_last_mail_times` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `em_filters`
--

DROP TABLE IF EXISTS `em_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_filters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `field` varchar(20) DEFAULT NULL,
  `keyword` varchar(100) DEFAULT NULL,
  `folder` varchar(100) DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT 0,
  `mark_as_read` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_filters`
--

LOCK TABLES `em_filters` WRITE;
/*!40000 ALTER TABLE `em_filters` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `em_filters` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `em_folders`
--

DROP TABLE IF EXISTS `em_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_folders` (
  `id` int(11) NOT NULL DEFAULT 0,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `subscribed` enum('0','1') NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `delimiter` char(1) NOT NULL DEFAULT '',
  `sort_order` tinyint(4) NOT NULL DEFAULT 0,
  `msgcount` int(11) NOT NULL DEFAULT 0,
  `unseen` int(11) NOT NULL DEFAULT 0,
  `auto_check` enum('0','1') NOT NULL DEFAULT '0',
  `can_have_children` tinyint(1) NOT NULL,
  `no_select` tinyint(1) DEFAULT NULL,
  `sort` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_folders`
--

LOCK TABLES `em_folders` WRITE;
/*!40000 ALTER TABLE `em_folders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `em_folders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `em_folders_expanded`
--

DROP TABLE IF EXISTS `em_folders_expanded`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_folders_expanded` (
  `folder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`folder_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_folders_expanded`
--

LOCK TABLES `em_folders_expanded` WRITE;
/*!40000 ALTER TABLE `em_folders_expanded` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `em_folders_expanded` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `em_labels`
--

DROP TABLE IF EXISTS `em_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_labels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `flag` varchar(100) NOT NULL,
  `color` varchar(6) NOT NULL,
  `account_id` int(11) NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_labels`
--

LOCK TABLES `em_labels` WRITE;
/*!40000 ALTER TABLE `em_labels` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `em_labels` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `em_links`
--

DROP TABLE IF EXISTS `em_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `from` varchar(255) DEFAULT NULL,
  `to` text DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `time` int(11) NOT NULL DEFAULT 0,
  `path` varchar(255) DEFAULT NULL,
  `has_attachments` tinyint(1) DEFAULT 0,
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL DEFAULT 0,
  `muser_id` int(11) NOT NULL DEFAULT 0,
  `acl_id` int(11) NOT NULL,
  `uid` varchar(350) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `account_id` (`user_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_links`
--

LOCK TABLES `em_links` WRITE;
/*!40000 ALTER TABLE `em_links` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `em_links` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `em_messages_cache`
--

DROP TABLE IF EXISTS `em_messages_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_messages_cache` (
  `folder_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `new` enum('0','1') NOT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `from` varchar(100) DEFAULT NULL,
  `size` int(11) NOT NULL,
  `udate` int(11) NOT NULL,
  `attachments` enum('0','1') NOT NULL,
  `flagged` enum('0','1') NOT NULL,
  `answered` enum('0','1') NOT NULL,
  `forwarded` tinyint(1) NOT NULL,
  `priority` tinyint(4) NOT NULL,
  `to` varchar(255) DEFAULT NULL,
  `serialized_message_object` mediumtext NOT NULL,
  PRIMARY KEY (`folder_id`,`uid`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_messages_cache`
--

LOCK TABLES `em_messages_cache` WRITE;
/*!40000 ALTER TABLE `em_messages_cache` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `em_messages_cache` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `em_portlet_folders`
--

DROP TABLE IF EXISTS `em_portlet_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_portlet_folders` (
  `account_id` int(11) NOT NULL,
  `folder_name` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  PRIMARY KEY (`account_id`,`folder_name`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `em_portlet_folders`
--

LOCK TABLES `em_portlet_folders` WRITE;
/*!40000 ALTER TABLE `em_portlet_folders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `em_portlet_folders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `email_default_email_account_templates`
--

DROP TABLE IF EXISTS `email_default_email_account_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_default_email_account_templates` (
  `account_id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`account_id`),
  KEY `template_id` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_default_email_account_templates`
--

LOCK TABLES `email_default_email_account_templates` WRITE;
/*!40000 ALTER TABLE `email_default_email_account_templates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `email_default_email_account_templates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `email_default_email_templates`
--

DROP TABLE IF EXISTS `email_default_email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_default_email_templates` (
  `user_id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  KEY `template_id` (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_default_email_templates`
--

LOCK TABLES `email_default_email_templates` WRITE;
/*!40000 ALTER TABLE `email_default_email_templates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `email_default_email_templates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `emp_folders`
--

DROP TABLE IF EXISTS `emp_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp_folders` (
  `folder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  PRIMARY KEY (`folder_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_folders`
--

LOCK TABLES `emp_folders` WRITE;
/*!40000 ALTER TABLE `emp_folders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `emp_folders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_bookmarks`
--

DROP TABLE IF EXISTS `fs_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_bookmarks` (
  `folder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`folder_id`,`user_id`),
  KEY `fs_bookmarks_core_user_id_fk` (`user_id`),
  CONSTRAINT `fs_bookmarks_core_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fs_bookmarks_fs_folders_folder_id_fk` FOREIGN KEY (`folder_id`) REFERENCES `fs_folders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_bookmarks`
--

LOCK TABLES `fs_bookmarks` WRITE;
/*!40000 ALTER TABLE `fs_bookmarks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_bookmarks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_filehandlers`
--

DROP TABLE IF EXISTS `fs_filehandlers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_filehandlers` (
  `user_id` int(11) NOT NULL,
  `extension` varchar(20) NOT NULL,
  `cls` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`,`extension`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_filehandlers`
--

LOCK TABLES `fs_filehandlers` WRITE;
/*!40000 ALTER TABLE `fs_filehandlers` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_filehandlers` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_files`
--

DROP TABLE IF EXISTS `fs_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `folder_id` int(11) NOT NULL,
  `name` varchar(260) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `locked_user_id` int(11) NOT NULL DEFAULT 0,
  `lock_id` varchar(192) DEFAULT NULL,
  `status_id` int(11) NOT NULL DEFAULT 0,
  `ctime` int(11) NOT NULL DEFAULT 0,
  `mtime` int(11) NOT NULL DEFAULT 0,
  `muser_id` int(11) NOT NULL DEFAULT 0,
  `size` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `extension` varchar(20) NOT NULL,
  `expire_time` int(11) NOT NULL DEFAULT 0,
  `random_code` char(11) DEFAULT NULL,
  `delete_when_expired` tinyint(1) NOT NULL DEFAULT 0,
  `content_expire_date` int(11) DEFAULT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `folder_id_2` (`folder_id`,`name`),
  KEY `folder_id` (`folder_id`),
  KEY `name` (`name`),
  KEY `extension` (`extension`),
  KEY `mtime` (`mtime`),
  KEY `content_expire_date` (`content_expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_files`
--

LOCK TABLES `fs_files` WRITE;
/*!40000 ALTER TABLE `fs_files` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_files` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_files_custom_fields`
--

DROP TABLE IF EXISTS `fs_files_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_files_custom_fields` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fs_files_custom_fields_ibfk_1` FOREIGN KEY (`id`) REFERENCES `fs_files` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_files_custom_fields`
--

LOCK TABLES `fs_files_custom_fields` WRITE;
/*!40000 ALTER TABLE `fs_files_custom_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_files_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_folder_pref`
--

DROP TABLE IF EXISTS `fs_folder_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_folder_pref` (
  `folder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `thumbs` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`folder_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_folder_pref`
--

LOCK TABLES `fs_folder_pref` WRITE;
/*!40000 ALTER TABLE `fs_folder_pref` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_folder_pref` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_folders`
--

DROP TABLE IF EXISTS `fs_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_folders` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `name` varchar(260) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT 0,
  `acl_id` int(11) NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `thumbs` tinyint(1) NOT NULL DEFAULT 1,
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `muser_id` int(11) NOT NULL DEFAULT 0,
  `quota_user_id` int(11) NOT NULL DEFAULT 0,
  `readonly` tinyint(1) NOT NULL DEFAULT 0,
  `cm_state` text DEFAULT NULL,
  `apply_state` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parent_id_3` (`parent_id`,`name`),
  KEY `name` (`name`),
  KEY `parent_id` (`parent_id`),
  KEY `visible` (`visible`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_folders`
--

LOCK TABLES `fs_folders` WRITE;
/*!40000 ALTER TABLE `fs_folders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fs_folders` VALUES
(1,1,0,'users',0,17,NULL,1,1755587807,1755587807,1,1,1,NULL,0),
(1,2,1,'groupofficeadmin',1,18,NULL,1,1755587807,1755587807,1,1,1,NULL,0),
(1,3,2,'Public',0,20,NULL,1,1755587807,1755587807,1,1,0,NULL,0),
(1,4,0,'trash',1,21,NULL,1,1755587807,1755587807,1,1,1,NULL,0),
(1,5,0,'public',0,17,NULL,1,1755587990,1755587990,1,1,1,NULL,0),
(1,6,5,'customcss',0,0,NULL,1,1755587990,1755587990,1,1,0,NULL,0),
(1,7,0,'log',0,17,NULL,1,1755588002,1755588002,1,1,1,NULL,0),
(1,8,0,'addressbook',0,31,NULL,1,1755588612,1755588612,1,1,0,NULL,0),
(1,9,8,'Users',0,23,NULL,1,1755588612,1755588612,1,1,1,NULL,0);
/*!40000 ALTER TABLE `fs_folders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_folders_custom_fields`
--

DROP TABLE IF EXISTS `fs_folders_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_folders_custom_fields` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fs_folders_custom_fields_ibfk_1` FOREIGN KEY (`id`) REFERENCES `fs_folders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_folders_custom_fields`
--

LOCK TABLES `fs_folders_custom_fields` WRITE;
/*!40000 ALTER TABLE `fs_folders_custom_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_folders_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_new_files`
--

DROP TABLE IF EXISTS `fs_new_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_new_files` (
  `file_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  KEY `file_id` (`file_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_new_files`
--

LOCK TABLES `fs_new_files` WRITE;
/*!40000 ALTER TABLE `fs_new_files` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_new_files` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_notification_messages`
--

DROP TABLE IF EXISTS `fs_notification_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_notification_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `modified_user_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `arg1` varchar(255) NOT NULL,
  `arg2` varchar(255) NOT NULL,
  `mtime` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_notification_messages`
--

LOCK TABLES `fs_notification_messages` WRITE;
/*!40000 ALTER TABLE `fs_notification_messages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_notification_messages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_notifications`
--

DROP TABLE IF EXISTS `fs_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_notifications` (
  `folder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`folder_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_notifications`
--

LOCK TABLES `fs_notifications` WRITE;
/*!40000 ALTER TABLE `fs_notifications` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_notifications` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_shared_cache`
--

DROP TABLE IF EXISTS `fs_shared_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_shared_cache` (
  `user_id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `path` text NOT NULL,
  PRIMARY KEY (`user_id`,`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_shared_cache`
--

LOCK TABLES `fs_shared_cache` WRITE;
/*!40000 ALTER TABLE `fs_shared_cache` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_shared_cache` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_shared_root_folders`
--

DROP TABLE IF EXISTS `fs_shared_root_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_shared_root_folders` (
  `user_id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`folder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_shared_root_folders`
--

LOCK TABLES `fs_shared_root_folders` WRITE;
/*!40000 ALTER TABLE `fs_shared_root_folders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_shared_root_folders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_status_history`
--

DROP TABLE IF EXISTS `fs_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_status_history` (
  `id` int(11) NOT NULL DEFAULT 0,
  `link_id` int(11) NOT NULL DEFAULT 0,
  `status_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `ctime` int(11) NOT NULL DEFAULT 0,
  `comments` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `link_id` (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_status_history`
--

LOCK TABLES `fs_status_history` WRITE;
/*!40000 ALTER TABLE `fs_status_history` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_status_history` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_statuses`
--

DROP TABLE IF EXISTS `fs_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_statuses` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_statuses`
--

LOCK TABLES `fs_statuses` WRITE;
/*!40000 ALTER TABLE `fs_statuses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_statuses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_templates`
--

DROP TABLE IF EXISTS `fs_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `acl_id` int(11) NOT NULL,
  `content` mediumblob NOT NULL,
  `extension` char(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_templates`
--

LOCK TABLES `fs_templates` WRITE;
/*!40000 ALTER TABLE `fs_templates` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fs_templates` VALUES
(1,1,'Microsoft Word document',14,'PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0_rels/.rels≠íMKAÜÔ˝CÓ›l+à»Œˆ\"Bo\"ıÑôÏÓ–Œ3i≠ˇﬁA\n∫Pä†«ºyÛ“mŒ˛†NúããA√™iAq0—∫0jx€=/`”/∫W>ê‘Jô\\*™ﬁÑ¢aIèà≈LÏ©41q®õ!fOR«<b\"≥ßëq›∂˜ò2†ü1’÷j»[ªµ˚H¸76z≤$Ñ&f^¶\\Ø≥8.Nyd—`£y©q˘j4ïx]h˝{°8ŒS4GœAÆyÒY8X∂∑ï(•[Fwˇi4o|Àº«l—^‚ãÕ¢√ŸÙüPKË–#Ÿ\0\0\0=\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/_rels/document.xml.rels≠ëM\n¬0Ö˜û\"Ãﬁ¶Uë¶nDp+ı\01ù∂¡6	…(z{äZ(‚¬Â¸}Ô1/__˚é]–mçÄ,IÅ°Q∂“¶p(∑”%¨ãIæ«NR\\	≠vÅ≈¥Dn≈yP-ˆ2$÷°âì⁄˙^R,}√ùT\'Ÿ ü•ÈÇ˚O&€U¸Æ Äï7áø∞m]kÖ´Œ=\Z\Zë‡ÅnÜHîæA®ì»>.?˚ß|m\rïÚÿ·€¡´ıÕƒ¸Ø?@¢òÂÁûùßÖIŒ·wPK˘/0¿≈\0\0\0\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/settings.xmlEéK¬0D˜ú\"Úí≤‡Së≤„¿Bk†RbG±°¿È	+ñ£73zª˝+EÛƒ\"#ìáf·¿ ı<åtÛp>Ê0¢ÅÜô–√ˆ›l7µÇ™µ%¶>ê¥ìáªjn≠ï˛é)»Ç3ReW.)hçÂf\'.C.‹£Hù¶hóŒ≠l\n#AW/?Ã…Lm∆“#i’iÿ\ZQO·rTŒµÚ—√⁄mÿ˛]∫/PKe˙÷\"•\0\0\0–\0\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/fontTable.xml≠ê¡N√0ÜÔ<Eî;KŸM’∫		q‰\0„º‘]#%qáÜæ=Y€ù(“@ª%ˆÔˇ˚ÌÌ˛ÀY—c`Cæí´B\nÙöj„Oï¸8º‹o§‡æK+9 À˝Ónõ Ü|dë«=ó°ímå]©Îä:Ùπ◊PpÛ7ú5ç—¯L˙”°èj]è*†Öò—‹öéÂÏñÆqKÍ.êFÊú’Ÿ…œÅÒr7ß©Ù‡rËÉq»‚ìx#ì@∑œöl%ãB™qú±√•\ZF˘ÿËL‘Ì•ﬁC0p¥xn©	ˆ˙>∏#ŸE÷˙÷¨ß,YF-Æ≈…0ˇu≈-77øÂØ˚-£˛¥ﬂ¸‡›7PKëàZ]\0\0\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/styles.xml•TQo⁄0~ﬂØà¸Nh£5Tå©	±©–Ω…Aº9∂Âs\ZËØüíj¥†xâÌÛ›ÂæÔ;ﬂ˝√6¡\Z‚JF¨s”f X%\\n\"ˆº|lıY@dBIåÿâ=ø‹≤;Å∏xIÉ\"b©µzÜßò›(ç“›≠ï…¿∫£ŸÑÖ2â6*F\"ó>a∑›ÓÖp…Üu¬†ZßIƒ ç+®ÿùvˇ÷``c@ß•ªÑÃ{øÄàÿ\\C.l∞,,ØqkÎÎ*Qi◊øå_\nû®b¨§5J‘nkTESÆµquér´&;ù¢§⁄Àöºt\nﬂrôjytÈºPÃyƒñ<s¸Ã±ûT“„à)b3ïrL∏L∏7!ê‚¸ŒÉHÚÈH“ë,ey± ‘Å´±™˙µ∂uø÷ñ1Ω∑	êg[Òƒ•Oyk:?¨„5mçKSÖ≤ıº®ñ@√J°”íuæ5—lÇ‡ªl_”\nìüÚò`ÑÏÙî¸ã®ÁŒgèWCÃKx∞∂h\\GwÀZ°kDÙ¥k•uA9à≈[»a|™Ô»p™∫è}/Zˇàh˝3πÔ5·~È9˝Æí›’ÏF¯•tüÅ¯∂	‚\'{\Zl\rÍ#⁄€ˇ–ûÓà˜pûd˝&\0∆†≠õ—÷?¨öl3.qûg+7˙Ωº˙Â·©˝wLçgÿ‹ﬁ5·v*‹^¿Ï]fØlözG√PK’îqË\0\0´\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/document.xmlçRÀn¬0º˜+\"ﬂ¡°TàF.®∑VH–0Œ&±d{#{!–ØØM–K≈≈õ—Ãæ&ª⁄\\åNŒ‡ºBõ≥Ÿ4e	XâÖ≤UŒæì%K<	[çrvœ6ÎóUõ(O,%°ÇıÊÏ‰lÊe\rF¯âQ“°«í&MÜe©$ÙÅı.g5Qìqﬁ\'M±∏ù†´xó≤Ì{Ò◊4]pZPò◊◊™ÒCµÛ˝œF∫ˆôÆ-∫¢q(¡˚`Ñ—]_#îÀÃ“\'éu∆åÊôŒÖÌCÀøÉl;í≠É˝G,Æ16∑gÁnaOW\rIõùÖŒôè e|Ω‚£¢{‚7àù\"R$uJ∫6c%⁄â\nb≠ ¨ˆ?Å©√π,ñÛpm4u6{OÉ‡S∏$éHÑ&RÛ∑®*	¬_O#®Nt5àb\ZJ∫\'9U’ê∞ÈAﬂÍÎd›®•	∫§2Bwl4vÁêÜ=J°}øÖï∂ Öu√!\rºvácÔ◊`úÊ˜ã_ˇPKó˙Åly\0\06\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0docProps/app.xmlù–=k√0‡Ωø¬à¨∂TcL≤BCÈh∑t3ätN¨§sp˛}’öÃè˜xxÔ¯v±SqÅòåwy¨)¿)Øç;v‰Ω)◊§H(ùñìw–ë+$≤¸-˙\0\r§\".u‰Ñ6î&u+Sïcóì—G+1èÒH˝8\Zœ^Õ“ö±ñ¬Ç‡4Ë2¸Å‰W‹\\ø®ˆÍª_˙ËØ!{Ç˜Â‘Çqz¯SìQÛÒbo^4⁄T¨™´zµ7n^Üœu;¥Mq∑0‰∂gPH∆,[Ìf3È≤ÊÙﬁ„Ùˆ#ÒPK(Îõ‚\0\0\0h\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0docProps/core.xmlmë[O¬0ÜÔ˝KÔ∑∂ Dõm\\h∏íƒDåÜª¶˚’ıê∂2¯˜∂&\ZÓ˙Â}˙ÙñãΩÍ≤8/çÆ- @”H›VËuΩÃÔPÊ◊\rÔåÜ\n¿£E}S\nÀÑqÏå$¯,ä¥g¬VhÇe{±≈}	√„qt-∂\\|ÒÑê9Vx√«Iò€—àN FåJ˚Ì∫A–(–¡cZP¸À*ÆÓ8át\0ß¸UxHFrÔÂHı}_Ù”Åã˜ß¯}ıÙ2<5ó:}ï\0Tó\'5xÄ&ãvºÿ9yõ><Æó®û:Õ…,ßÛ5%lvœncdS‚ä‰<Æç´W‡‰ßŒ“π.Vï‡1K›8ÿ…TiMJ|9”ﬂ‚ÍPKø¬i\0\0\0\0PK\0\0H∞B\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0[Content_Types].xmlΩî1O√0Ö˜˛ä»+JBI: 1Bá0#c_ãƒ∂|¶¥ˇûsh#®¥∞X≤¸Ó}œÁìãÂfËì5x‘÷îÏ<ÀYFZ•M[≤á˙6ΩbÀjQ‘[òê÷`…∫‹5Á(;f÷Å°ì∆˙A⁄˙ñ;!üE¸\"œ/π¥&Ä	ià¨*Ó	ÁµÇd%|∏îå?zËëgqe…Õ{AdñL8◊k)Â„k£>—“)Vé\ZÏ¥√30˛=È’zµ√)+_e$ˇ74B‘\\å–üÒl”h	SËËÊºïÄH~tÉΩÛlÑÜ†µxÍ·Ù&Î˘>Ñm—Ö—wˇÒÌO`:Ñ6árêpÂ≠CN¿£c¿Ü*®î≤8AÓ¡ƒñ÷ˇbˆ£´øˇãÍ\rPKcÓ§a*\0\0^\0\0PK\0\0\0H∞BË–#Ÿ\0\0\0=\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0_rels/.relsPK\0\0\0H∞B˘/0¿≈\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/_rels/document.xml.relsPK\0\0\0H∞Be˙÷\"•\0\0\0–\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0!\0\0word/settings.xmlPK\0\0\0H∞BëàZ]\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0word/fontTable.xmlPK\0\0\0H∞B’îqË\0\0´\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0F\0\0word/styles.xmlPK\0\0\0H∞Bó˙Åly\0\06\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0õ\0\0word/document.xmlPK\0\0\0H∞B(Îõ‚\0\0\0h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0S\0\0docProps/app.xmlPK\0\0\0H∞Bø¬i\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0s	\0\0docProps/core.xmlPK\0\0\0H∞BcÓ§a*\0\0^\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0—\n\0\0[Content_Types].xmlPK\0\0\0\0	\0	\0<\0\0<\0\0\0\0','docx'),
(2,1,'Open-Office Text document',16,'PK\0\0\0\0\0K;\Z9^∆2\'\0\0\0\'\0\0\0\0\0\0mimetypeapplication/vnd.oasis.opendocument.textPK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0\0Configurations2/statusbar/PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\'\0\0\0Configurations2/accelerator/current.xml\0PK\0\0\0\0\0\0\0\0\0\0\0PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/floater/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0\0Configurations2/popupmenu/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/progressbar/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/menubar/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/toolbar/PK\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/images/Bitmaps/PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0content.xml•VÀn!›˜+F,∫c\']$Sè£JQ•JIMZuKÄ±iyLÅÒÿ_û1N2	í7∂πúsπús/ovÇ[™\rS≤ãŸTbEò\\◊‡Á„◊Ú\n‹¨>,U”0L+¢p\'®¥%V“∫Ô¬±•©‚l\r:-+Ö3ïDÇö ‚JµT¨*EWa≠1vœ≥Èú≤-›Ÿ\\≤«ûp—S˛ ú≤âF}.Ÿcù®)ΩQπ‰ù·e£úÍ¢Eñ=´b«ô¸[Éçµmaﬂ˜≥˛r¶Ù\Z.ÆØØaò∆#ÆÌ4(Ç!Â‘/f‡b∂ÄVPãrÎÛÿ¥$Ÿâ\'™≥•AΩp’l◊Ÿ±]OHÉ7Hg˜F\0ü⁄{IÚÌΩ$)W ªô‰\nﬁª…qwÏ-r◊Úÿ©∞fmˆ6#:Â+•∆R=!–PÓ≈|˛	∆qÇÓﬂÑ˜öY™8~é«£‚Jº&ö√-†CîtÎ€tl|/Ñô \\¿8=Ç\rôL˝˚˛Óo®@G0{\\2i,íGe\ZF˘–0„F^–]K5Û6 Ó4ÒõQ§q)úT™≠í—ô9πô`5\\√—B«@„Æ„≤AòñÑbnVÀxú∆p«æî\Z<∫2LÒùˆ≈%êÖ;?T0æØ¡G‘*Û˘.Aqí⁄„À5ïnoŒe}»wD¥Ãbw∂H3y¯vi_åøR–ü^⁄ÙÃòsñæ•–ØÆx@“L*í`2‘0{c©xØ&8e·!é:ÎTµó!Ob˙ì\"˚q‡∂’2<oÜ˛Î‹>&z,Bà0”r¥/Ug›AKÓNØÅkæ0e˘∆yg¨v(ÈÀ=+Ÿ„∞ÈÛ≤∏üg\'πçœqp`Zµ6RÇÚe$>∏#Oê&©wQ|x‚ú¯À¥˙PK’\0=@ê\0\0s	\0\0PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0styles.xmlÕYKè€6æ˜W*⁄mÀªõÆ›ÏEã¢íö¥◊Äñhã	E\n$eŸ˘ıí¢DÀíW˚H·=, ŒpÊ„<…ÒÎ7˚úMvD**¯]OÁ—ÑD§îoÔ¢?˛ân£7˜?ºõ\rM»*IôÆë“F‘6sµrƒª®î|%∞¢j≈qN‘J\'+QÓ7≠BÓïUÂV¨∞±€-s∏[ìΩªŸÌ≈ÎÒö-s∏;ï∏\ZªŸÇM√Ì1vÛ^1¥(yÅ5Ì†ÿ3 ø‹Eô÷≈j6´™jZ]MÖ‹Œ‚Âr9≥‘p“•dñ+MfÑ£LÕ‚i<Ûº9—x,>√B‚eæ&r¥i∞∆\'^UªÌËàÿmLìdXéé\rÀ|Ïﬁ´tº{Ø“poéu6‡ì€Ÿ; ⁄Ôﬁ∂± Û±∫Ôë©Iã—«t‹·~!D’lp	j·.ÊÛÎô˚∏´≥Ïï§ö»Ä=9Àû`ñ4yü—Ä/û\";¶—§.!AŸä£{_£6Í”\'•$aÍ˛µã≠fy‚æççÓ¢è,5yO™…?\"«<ö@0y÷ú≤√]Ù3.Ñ˙µ√Á£…ëh√è∂ÑI·»≤ñ◊rT\';,©©$—Ï<¥ﬂÄçı\0ÚÎ√™UEïzéÍ?»g¸_9˘Äπ\Z¥H¿3¬\ZÍ†4…¬4raΩÓ∫é«ûí\r.Y›ãº‰\Z„V‚\"£I‰yÎoTHàA©)8”T‰ï p**Ú—hÕßW	‡Ï!:D\rÂAu%H8Å⁄é2!ÈWÄéôa]‹ûeﬁ…)+$ÏX©\'¨=2k≥08GEuÜ\\∑‹`¶Ç((∞ƒ÷B°}…#\\jat@h–î«äYëaØ¿¬XKÇ°)\r.◊ûb Å¡ñã∂3âÙ˙((Oâ©RÊV∆ÉÙ°˚ÇßE°Lú√nÿ\rÓì”îäÄ∏Ò™Uû&†OiYB}€áH—ØÄ4^⁄Æ1Ã∑%ﬁ¬gv!%◊¬·˝€Ê¯DCÕC_à‰∫ú“»DPõ±©VÛÈM—ÿ«ã˜‘Ø˚Ω\'’ä<Öﬁ#‘t>FˆpGhCÌ€–¨‡÷¨Gy5&Ÿ\Z?Dg\nLóäåph‘Ç#Ü”lf—‡˝ú6\'wE…]:Åê°}¿—¡¶(îRHOnîƒ”≈M‹fÕqË`œ6eû_ÅÁöœ˜å@£“G“q}ˇŒQj7±vVıK≈rjƒín¸Iíc ëπˆ˘ \\ú0• :,œH˚Ç+\Z#aπ∆ZHì&Ë†êC1\\(—œUå§®: a•ì°_)ê[¢3sÉ7¯ê‚P°ÏêO)ñi4X(º˚V\n‡A2µ©u*Ô/Ç” ß≈¡BÛ8E˝P∏…€ê·#,|ZÃ?≠EzËÉıPIÀ±Ñz&+L◊Ω^ÿÆ€ÆØÖ÷ÊV\r9^‘$kc€çπÌ∆òU¯†™-A·®ØÄùrq›ÊÃ”2æW¿c3◊iÊÅ@È3>î„Ç·C‡ûIH~éÛüÏ◊Û>}‹∑–iûré31 å»Ås‰Ë≈c|Ù;.L)|A˚JâôXmˆ%ñùÌ∏…ÉΩH™¶[äΩ¯¡ƒ|8Ÿz∞[sÉ*\nwqx[ú5Ô—ö§¶mÓÌ}¡ˆÜ^Ìøø·nΩAÔQ+Ô¨˜^»è\n_+Yî⁄Ω!z÷ŸVwG√,Ä∏¶5î92≥%π9ü…Øzk˜Ä95óÿ5P⁄$ºo„∫$iâkq°∏Æ.◊ıÖ‚∫πP\\Ø.◊/äÎˆBq-/W<ˇˇÅìB¥\\h¢†âÚ\r›ñ“>Ó&\r’≠m#Ñ6ﬂ}¿„∫yπQﬁ≥“†™˝FÖ\n°®∂Ci;/˜∏ég\nFûÀõçGHx:êˆÙ‚çEZ}j˚µÄ⁄ÁÕrŸéG˙¨Si≠¿»F◊4 ih251òˆZiÌê◊<9A&Mê\'¯õ∆ºç‡›£˚Më«QOÁNg)MÕœ2ã˘tÈ‚	°€ÃºÓó”WgéX+j$$Ö£‡⁄◊B¬ïñÍ®{q∏¥vñçëNe\rih’•∫\0D9ﬁ7ß1œñv–_3(RxqŒ\ZÛÈ<æmï¯îCk\'∑¸Ü\'û«=<xcÜN},8˝\\*ÌºÌb¿≠KHVÔÜõü⁄1éùì˝8∑Q8‚Ìs®?TF∞ïÿèYx“`ÒTPyß°Vr¨\Zç∂z—H:;Ì1∑!\Z|G˙¨ˇ«ı˚oPKÍÑE—}\0\0ú\0\0PK\0\0\0\0\0K;\Z9ëgä≤\0\0\0\0\0\0\0meta.xml<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<office:document-meta xmlns:office=\"urn:oasis:names:tc:opendocument:xmlns:office:1.0\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:meta=\"urn:oasis:names:tc:opendocument:xmlns:meta:1.0\" xmlns:ooo=\"http://openoffice.org/2004/office\" office:version=\"1.1\"><office:meta><meta:generator>OpenOffice.org/2.4$Linux OpenOffice.org_project/680m17$Build-9310</meta:generator><meta:initial-creator>Merijn Schering</meta:initial-creator><meta:creation-date>2008-08-26T09:26:02</meta:creation-date><meta:editing-cycles>0</meta:editing-cycles><meta:editing-duration>PT0S</meta:editing-duration><meta:user-defined meta:name=\"Info 1\"/><meta:user-defined meta:name=\"Info 2\"/><meta:user-defined meta:name=\"Info 3\"/><meta:user-defined meta:name=\"Info 4\"/><meta:document-statistic meta:table-count=\"0\" meta:image-count=\"0\" meta:object-count=\"0\" meta:page-count=\"1\" meta:paragraph-count=\"0\" meta:word-count=\"0\" meta:character-count=\"0\"/></office:meta></office:document-meta>PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Thumbnails/thumbnail.pngÎsÁÂí‚b``‡ıÙp	“[8ÿÄ¨Ø Ê∑òˆ{∫8ÜTÃy{i#\'ÉœÅ\r|?ˇ?˝“Èt–Cº‚√õwçì~ 2¨ü9K&xrrVëèoﬂ ìÜ¶ñÀ‘é_y2cTpTp¿≈œÂ≤˝3\nˇ*L—ûÆ~.Îúö\0PKÑ◊É£|\0\0\0¯\0\0PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0settings.xmlµYQs‚8~ø_—…;JoÔ ¥Ï∫Ï±•Ö∫ù€7ì»’±2∂S‡ﬂüÏÑN°K	~¢Ml…í•ÔìîÎØ´òüΩÄTäØ~^ÛŒ@Fb~„=N∫ïøΩØ≠?Æq6ãhÜ§1]Q†5-Qg¥]®fˆ˙∆K•h\"Sëj\nÉjÍ†â	àÕ∂Ê€’M´,{≤‚ëxæÒZ\'Õjuπ\\û/Á(Á’˙’’U’æ›,\rPÃ¢˘°™≤’oU!‚´\"≥!;åUvQ´]V≥ˇΩ≥¸êo\\S˜Z?lÃo]Á\n≤üJ§!6æ9Àõ£›x§≤˘¡Ú’k^—æ˜{~“z_õ`‚mﬁËuBo\"°ΩVÌ∫∫+·p©}òÈ\"±ïz≠^˚´úÏß(‘ã\"·óçã∆üÂdˇ—|QxÚãz˝ÍH·„.GRêAg¡ƒ‘ñÇ)\"&ºññ)ß£\'⁄ó\nÓ1Ñ}“gå´É≈WbñT\"¬\n¬]_Gò›Cπ!◊áyºnUiI·ÎµL0_ì˚¢ØQ´ïê∫\'S U—îÉõ\\±¢Où‹VËh_ä4\Zıã/•D∑Qkå˜•_„8Ÿø„	I⁄éµ „}aÑvY†Qã≠◊é‹Sc‡hªíëÀﬂ&Êæ◊yÆ/ b9úä≤©döàÌ3ú‰á·êI6a\n„ÑNéîCÇ=√ª∞ç?«AÂ{˘ÉT§Ôì˛o<Ti<˘Å1%¥ı©ryLB¶ãêã%ı-NÙz»‹p÷\\†Ñn$ï&3†G(tO∏tÒØ§¨Ÿ¡8ë†LÈurl∞éì~‡tØ„Jòë›xW∞Aúp˙€QûY“ËÉN∑π‰ñP [úÃf.|eÌ0Î(äÛ n(QlS<›¡z[SÂ≤	&◊^ı¿#[tpﬁ¸†]î€D{™”~™1QGaŸA‚2‰NºC‚AÜ˚\'o1É7∫FÂã∞ÕôxV‰tÉt∆Éî[ztæ®≠Ü˝ºp$ºıëÖ#`!\næËßAS‰¸?Aõ‡.nõt}[—u∆˚dëìz√Oæ~T oôfßﬂ5%ÜÀÑ≥¯ô\r)¢√Qù¶ø‹UÚù„îÒ€|æb\nt–Swtﬂæäò¶\"–©´4Ùy4ºcç…UÙëö„oß√£ƒWØeç/ mü$-ï]æ∂‰Í¬èùTJ∫&‘ÕÔSÏ`M÷“Äó∑¯Ä∫√ùJ∏ïl9ò˛ß¬∞∂É„[T·Ú¿EYì”»√nw∏?¨å.[ïBL©¢‰V˙I≤d »≠é.äRÊñﬂ1pVœŸÑ´∂DıŸ^Å»çßL˘∂¯M£[ûIﬂ∂”æk*–NÔ¥Wì6Åñ∏±…Çƒ®W0¶˘ZKSTQÀÿE\'WïuAUB5≥+˘ﬂ…_ã≤•DÒ¡9.≠ÍD;L¿p–{*†÷:f\",h´ÀÌ≈ˇHïéfkì6Í)“ã{&R∆€ÿ≥éP#0u˙L0O8Ãfä±M©‡&}rt6∂òoY¶ŒbkL∑Õ⁄Ã·≥	\nyjŒTÜ\\NuÚQ≈⁄,xûKL≈ﬁ¡ﬁ©£ºªõ2«ŒF›Ù±‘tœù–ΩXQ‹$Rıõ˛ÈìÛj;oÆÓ|≠Ó˚L‹˙PKtëá€\0\0h\0\0PK\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0META-INF/manifest.xmlµïKj√0@˜=Ö—ﬁV€U1q-ÙÈ&ÚÿËáfí€W‰”6î¶X;	§˜F#Õh±⁄[SÌ0íˆÆOÕ£®–)ﬂk7v‚c˝^øà’Úaa¡Èâ€”† ˚ùßùH—µHSÎ¿\"µ¨Z–ı^%ãé€ØÎ€…¥|®.‡A¨Û¬x®.2Ï5‘|ÿ	¡hú„î;◊7GWs≠h˜,.ªádLÄ∑ùêBﬁ%ªMyÛn–cä« ËY\'⁄@,É•–`û˙(Uäq:bŒbqW¡`<0ÇR»O ¬G?F§r7=Ö^ŒﬁõbpmaDíØö-*Í∏ì˝Ω_PrSı4I7ÍZ∑ÓîOùHNµzû˝¸øb˛ùK|0H≥c-2Ã÷x÷€d7¥!…ßa‹87|ﬁƒ\"s˛œ©]»ˇ·ÚPK5b◊9>\0\0J\0\0PK\0\0\0\0\0\0K;\Z9^∆2\'\0\0\0\'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0mimetypePK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0\0\0\0\0\0\0\0\0\0\0\0M\0\0\0Configurations2/statusbar/PK\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\'\0\0\0\0\0\0\0\0\0\0\0\0\0Ö\0\0\0Configurations2/accelerator/current.xmlPK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‹\0\0\0Configurations2/floater/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/popupmenu/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0J\0\0Configurations2/progressbar/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Ñ\0\0Configurations2/menubar/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0∫\0\0Configurations2/toolbar/PK\0\0\0\0\0\0K;\Z9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Configurations2/images/Bitmaps/PK\0\0\0\0K;\Z9’\0=@ê\0\0s	\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0-\0\0content.xmlPK\0\0\0\0K;\Z9ÍÑE—}\0\0ú\0\0\n\0\0\0\0\0\0\0\0\0\0\0\0\0ˆ\0\0styles.xmlPK\0\0\0\0\0\0K;\Z9ëgä≤\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0´\0\0meta.xmlPK\0\0\0\0K;\Z9Ñ◊É£|\0\0\0¯\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ﬂ\0\0Thumbnails/thumbnail.pngPK\0\0\0\0K;\Z9tëá€\0\0h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0°\0\0settings.xmlPK\0\0\0\0K;\Z95b◊9>\0\0J\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0∂\0\0META-INF/manifest.xmlPK\0\0\0\0\0\0Ó\0\07\0\0\0\0','odt');
/*!40000 ALTER TABLE `fs_templates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_trash`
--

DROP TABLE IF EXISTS `fs_trash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_trash` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parentId` int(11) unsigned NOT NULL,
  `aclId` int(11) NOT NULL DEFAULT 0,
  `entityId` int(11) NOT NULL,
  `entityTypeId` int(11) NOT NULL,
  `deletedBy` int(11) NOT NULL,
  `deletedAt` datetime DEFAULT current_timestamp(),
  `name` varchar(260) NOT NULL,
  `fullPath` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fs_trash_ibfk_1` (`aclId`),
  KEY `fs_trash_ibfk_2` (`deletedBy`),
  KEY `fs_trash_ibfk_3` (`entityTypeId`),
  CONSTRAINT `fs_trash_ibfk_1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fs_trash_ibfk_2` FOREIGN KEY (`deletedBy`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fs_trash_ibfk_3` FOREIGN KEY (`entityTypeId`) REFERENCES `core_entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_trash`
--

LOCK TABLES `fs_trash` WRITE;
/*!40000 ALTER TABLE `fs_trash` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_trash` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `fs_versions`
--

DROP TABLE IF EXISTS `fs_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fs_versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_id` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `path` varchar(255) NOT NULL,
  `version` int(11) NOT NULL DEFAULT 1,
  `size_bytes` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `file_id` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fs_versions`
--

LOCK TABLES `fs_versions` WRITE;
/*!40000 ALTER TABLE `fs_versions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fs_versions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_address_format`
--

DROP TABLE IF EXISTS `go_address_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_address_format` (
  `id` int(11) NOT NULL,
  `format` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_address_format`
--

LOCK TABLES `go_address_format` WRITE;
/*!40000 ALTER TABLE `go_address_format` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_address_format` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_advanced_searches`
--

DROP TABLE IF EXISTS `go_advanced_searches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_advanced_searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `acl_id` int(11) NOT NULL DEFAULT 0,
  `data` text DEFAULT NULL,
  `model_name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_advanced_searches`
--

LOCK TABLES `go_advanced_searches` WRITE;
/*!40000 ALTER TABLE `go_advanced_searches` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_advanced_searches` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_cache`
--

DROP TABLE IF EXISTS `go_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_cache` (
  `user_id` int(11) NOT NULL,
  `key` varchar(190) NOT NULL DEFAULT '',
  `content` longtext DEFAULT NULL,
  `mtime` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`key`),
  KEY `mtime` (`mtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cache`
--

LOCK TABLES `go_cache` WRITE;
/*!40000 ALTER TABLE `go_cache` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_cache` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_cf_setting_tabs`
--

DROP TABLE IF EXISTS `go_cf_setting_tabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_cf_setting_tabs` (
  `cf_category_id` int(11) NOT NULL,
  PRIMARY KEY (`cf_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cf_setting_tabs`
--

LOCK TABLES `go_cf_setting_tabs` WRITE;
/*!40000 ALTER TABLE `go_cf_setting_tabs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_cf_setting_tabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_clients`
--

DROP TABLE IF EXISTS `go_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `footprint` varchar(190) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ip` varchar(45) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  `last_active` int(11) NOT NULL,
  `in_use` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_footprint` (`footprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_clients`
--

LOCK TABLES `go_clients` WRITE;
/*!40000 ALTER TABLE `go_clients` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_clients` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_countries`
--

DROP TABLE IF EXISTS `go_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_countries` (
  `id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(64) DEFAULT NULL,
  `iso_code_2` char(2) NOT NULL DEFAULT '',
  `iso_code_3` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_countries`
--

LOCK TABLES `go_countries` WRITE;
/*!40000 ALTER TABLE `go_countries` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_countries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_cron`
--

DROP TABLE IF EXISTS `go_cron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_cron` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `minutes` varchar(100) NOT NULL DEFAULT '1',
  `hours` varchar(100) NOT NULL DEFAULT '1',
  `monthdays` varchar(100) NOT NULL DEFAULT '*',
  `months` varchar(100) NOT NULL DEFAULT '*',
  `weekdays` varchar(100) NOT NULL DEFAULT '*',
  `years` varchar(100) NOT NULL DEFAULT '*',
  `job` varchar(255) NOT NULL,
  `runonce` tinyint(1) NOT NULL DEFAULT 0,
  `nextrun` int(11) NOT NULL DEFAULT 0,
  `lastrun` int(11) NOT NULL DEFAULT 0,
  `completedat` int(11) NOT NULL DEFAULT 0,
  `error` text DEFAULT NULL,
  `autodestroy` tinyint(1) NOT NULL DEFAULT 0,
  `params` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nextrun_active` (`nextrun`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cron`
--

LOCK TABLES `go_cron` WRITE;
/*!40000 ALTER TABLE `go_cron` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `go_cron` VALUES
(1,'Email Reminders',1,'*/5','*','*','*','*','*','GO\\Base\\Cron\\EmailReminders',0,1755589800,1755589501,1755589502,NULL,0,'[]'),
(2,'Calculate disk usage',1,'1','1','*','*','*','*','GO\\Base\\Cron\\CalculateDiskUsage',0,1755651660,0,0,NULL,0,'[]');
/*!40000 ALTER TABLE `go_cron` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_cron_groups`
--

DROP TABLE IF EXISTS `go_cron_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_cron_groups` (
  `cronjob_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`cronjob_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cron_groups`
--

LOCK TABLES `go_cron_groups` WRITE;
/*!40000 ALTER TABLE `go_cron_groups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_cron_groups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_cron_users`
--

DROP TABLE IF EXISTS `go_cron_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_cron_users` (
  `cronjob_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`cronjob_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_cron_users`
--

LOCK TABLES `go_cron_users` WRITE;
/*!40000 ALTER TABLE `go_cron_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_cron_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_holidays`
--

DROP TABLE IF EXISTS `go_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_holidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `region` varchar(10) NOT NULL DEFAULT '',
  `free_day` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_holidays`
--

LOCK TABLES `go_holidays` WRITE;
/*!40000 ALTER TABLE `go_holidays` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_holidays` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_links_em_links`
--

DROP TABLE IF EXISTS `go_links_em_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_links_em_links` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_em_links`
--

LOCK TABLES `go_links_em_links` WRITE;
/*!40000 ALTER TABLE `go_links_em_links` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_links_em_links` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_links_fs_files`
--

DROP TABLE IF EXISTS `go_links_fs_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_links_fs_files` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_fs_files`
--

LOCK TABLES `go_links_fs_files` WRITE;
/*!40000 ALTER TABLE `go_links_fs_files` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_links_fs_files` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_links_fs_folders`
--

DROP TABLE IF EXISTS `go_links_fs_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_links_fs_folders` (
  `id` int(11) NOT NULL,
  `folder_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`,`model_id`,`model_type_id`),
  KEY `id` (`id`,`folder_id`),
  KEY `ctime` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_links_fs_folders`
--

LOCK TABLES `go_links_fs_folders` WRITE;
/*!40000 ALTER TABLE `go_links_fs_folders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_links_fs_folders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_reminders`
--

DROP TABLE IF EXISTS `go_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_reminders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL,
  `model_type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `time` int(11) NOT NULL,
  `vtime` int(11) NOT NULL DEFAULT 0,
  `snooze_time` int(11) NOT NULL,
  `manual` tinyint(1) NOT NULL DEFAULT 0,
  `text` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_reminders`
--

LOCK TABLES `go_reminders` WRITE;
/*!40000 ALTER TABLE `go_reminders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_reminders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_reminders_users`
--

DROP TABLE IF EXISTS `go_reminders_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_reminders_users` (
  `reminder_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `mail_sent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`reminder_id`,`user_id`),
  KEY `user_id_time` (`user_id`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_reminders_users`
--

LOCK TABLES `go_reminders_users` WRITE;
/*!40000 ALTER TABLE `go_reminders_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_reminders_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_saved_exports`
--

DROP TABLE IF EXISTS `go_saved_exports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_saved_exports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `class_name` varchar(255) NOT NULL,
  `view` varchar(255) NOT NULL,
  `export_columns` text DEFAULT NULL,
  `orientation` enum('V','H') NOT NULL DEFAULT 'V',
  `include_column_names` tinyint(1) NOT NULL DEFAULT 1,
  `use_db_column_names` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_saved_exports`
--

LOCK TABLES `go_saved_exports` WRITE;
/*!40000 ALTER TABLE `go_saved_exports` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_saved_exports` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_saved_search_queries`
--

DROP TABLE IF EXISTS `go_saved_search_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_saved_search_queries` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sql` text NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_saved_search_queries`
--

LOCK TABLES `go_saved_search_queries` WRITE;
/*!40000 ALTER TABLE `go_saved_search_queries` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_saved_search_queries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_search_sync`
--

DROP TABLE IF EXISTS `go_search_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_search_sync` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `module` varchar(50) NOT NULL DEFAULT '',
  `last_sync_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_search_sync`
--

LOCK TABLES `go_search_sync` WRITE;
/*!40000 ALTER TABLE `go_search_sync` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_search_sync` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_settings`
--

DROP TABLE IF EXISTS `go_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_settings` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT '',
  `value` longtext DEFAULT NULL,
  PRIMARY KEY (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_settings`
--

LOCK TABLES `go_settings` WRITE;
/*!40000 ALTER TABLE `go_settings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `go_settings` VALUES
(0,'cron_last_run','1755589621'),
(1,'cron_last_run','1755588601'),
(1,'email_always_request_notification','0'),
(1,'email_always_respond_to_notifications','0'),
(1,'email_font_size','14px'),
(1,'email_show_bcc','0'),
(1,'email_show_cc','1'),
(1,'email_show_from','1'),
(1,'email_skip_unknown_recipients','0'),
(1,'email_sort_email_addresses_by_time','1'),
(1,'email_use_plain_text_markup','0'),
(1,'use_desktop_composer','0');
/*!40000 ALTER TABLE `go_settings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_state`
--

DROP TABLE IF EXISTS `go_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_state` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`name`),
  CONSTRAINT `go_state_core_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_state`
--

LOCK TABLES `go_state` WRITE;
/*!40000 ALTER TABLE `go_state` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `go_state` VALUES
(1,'open-modules','a%3As%253Aaddressbook%5Es%253Acalendar%5Es%253Anotes%5Es%253Atasks%5Es%253Asummary%5Es%253Afiles%5Es%253Aemail%5Es%253Areminders'),
(1,'task-lists-grid','o%3Acolumns%3Da%253Ao%25253Aid%25253Ds%2525253Achecker%25255Ewidth%25253Dn%2525253A35%255Eo%25253Aid%25253Ds%2525253Aname%25255Ewidth%25253Dn%2525253A187%255Eo%25253Aid%25253Dn%2525253A2%25255Ewidth%25253Dn%2525253A36%255Eo%25253Aid%25253Ds%2525253Agroup%25255Ewidth%25253Dn%2525253A187%25255Ehidden%25253Db%2525253A1%5Esort%3Do%253Afield%253Ds%25253AsortOrder%255Edirection%253Ds%25253AASC%5Egroup%3Ds%253Agroup%5Ecollapsed%3Db%253A0'),
(1,'tasks-status-filter','s%3Atoday');
/*!40000 ALTER TABLE `go_state` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_template_group`
--

DROP TABLE IF EXISTS `go_template_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_template_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_template_group`
--

LOCK TABLES `go_template_group` WRITE;
/*!40000 ALTER TABLE `go_template_group` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_template_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_templates`
--

DROP TABLE IF EXISTS `go_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `type` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(100) DEFAULT NULL,
  `acl_id` int(11) NOT NULL DEFAULT 0,
  `content` longblob NOT NULL,
  `filename` varchar(100) DEFAULT NULL,
  `extension` varchar(4) NOT NULL DEFAULT '',
  `group_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_go_templates_go_template_group_idx` (`group_id`),
  CONSTRAINT `fk_go_templates_go_template_group` FOREIGN KEY (`group_id`) REFERENCES `go_template_group` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_templates`
--

LOCK TABLES `go_templates` WRITE;
/*!40000 ALTER TABLE `go_templates` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `go_templates` VALUES
(1,1,0,'Default',8,'Date: Tue, 19 Aug 2025 07:16:40 +0000\r\nTo: undisclosed-recipients:;\r\nFrom: Group-Office <admin@intermesh.dev>\r\nSubject: \r\nMessage-ID: <adb82cce3966ad93318d950a4c8d944b@192.168.40.247>\r\nX-Mailer: Group-Office\r\nMIME-Version: 1.0\r\nContent-Type: multipart/alternative;\r\n boundary=\"b1=_3mizj6xARcAqER82RRfONjAyBUDZ1HeiuPrz4JCc\"\r\nContent-Transfer-Encoding: 8bit\r\n\r\n--b1=_3mizj6xARcAqER82RRfONjAyBUDZ1HeiuPrz4JCc\r\nContent-Type: text/plain; charset=us-ascii\r\n\r\nHi {contact:firstName},\r\n\r\n{body}\r\n\r\nBest regards\r\n\r\n\r\n{user:displayName}\r\n\r\n--b1=_3mizj6xARcAqER82RRfONjAyBUDZ1HeiuPrz4JCc\r\nContent-Type: text/html; charset=us-ascii\r\n\r\nHi<gotpl if=\"contact:firstName\"> {contact:firstName},</gotpl><br />\r\n<br />\r\n{body}<br />\r\n<br />\r\nBest regards<br />\r\n<br />\r\n<br />\r\n{user:displayName}<br />\r\n\r\n\r\n--b1=_3mizj6xARcAqER82RRfONjAyBUDZ1HeiuPrz4JCc--\r\n',NULL,'',NULL);
/*!40000 ALTER TABLE `go_templates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `go_working_weeks`
--

DROP TABLE IF EXISTS `go_working_weeks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `go_working_weeks` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `mo_work_hours` double NOT NULL DEFAULT 8,
  `tu_work_hours` double NOT NULL DEFAULT 8,
  `we_work_hours` double NOT NULL DEFAULT 8,
  `th_work_hours` double NOT NULL DEFAULT 8,
  `fr_work_hours` double NOT NULL DEFAULT 8,
  `sa_work_hours` double NOT NULL DEFAULT 0,
  `su_work_hours` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `go_working_weeks`
--

LOCK TABLES `go_working_weeks` WRITE;
/*!40000 ALTER TABLE `go_working_weeks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `go_working_weeks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `history_log_entry`
--

DROP TABLE IF EXISTS `history_log_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_log_entry` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `action` int(11) DEFAULT NULL,
  `description` varchar(384) DEFAULT NULL,
  `changes` text DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `aclId` int(11) DEFAULT NULL,
  `removeAcl` tinyint(1) NOT NULL DEFAULT 0,
  `entityTypeId` int(11) NOT NULL,
  `entityId` varchar(100) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `remoteIp` varchar(50) DEFAULT NULL,
  `requestId` varchar(190) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_log_entry_core_user_idx` (`createdBy`),
  KEY `fk_log_entry_core_acl1_idx` (`aclId`),
  KEY `fk_log_entry_core_entity1_idx` (`entityTypeId`),
  KEY `entityId` (`entityId`),
  KEY `history_log_entry_createdAt_index` (`createdAt`),
  KEY `history_log_entry_removeAcl_action_index` (`removeAcl`,`action`),
  CONSTRAINT `fk_log_entry_core_acl1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_log_entry`
--

LOCK TABLES `history_log_entry` WRITE;
/*!40000 ALTER TABLE `history_log_entry` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `history_log_entry` VALUES
(1,1,'Users','{\"id\":\"2\",\"name\":\"Users\",\"salutationTemplate\":\"Dear [if {{contact.prefixes}}]{{contact.prefixes}}[else][if !{{contact.gender}}]Ms.\\/Mr.[else][if {{contact.gender}}==\\\"M\\\"]Mr.[else]Ms.[\\/if][\\/if][\\/if][if {{contact.middleName}}] {{contact.middleName}}[\\/if] {{contact.lastName}}\"}','2025-08-19 07:16:56',1,23,0,27,'2','192.168.190.3','auth.php'),
(2,1,'System Administrator','{\"id\":\"1\",\"addressBookId\":\"2\",\"goUserId\":\"1\",\"firstName\":\"System\",\"lastName\":\"Administrator\",\"name\":\"System Administrator\",\"uid\":\"1-192.168.40.247-groupoffice\",\"uri\":\"1-192.168.40.247-groupoffice.vcf\",\"emailAddresses\":[{\"type\":\"work\",\"email\":\"postmaster@powermail.mydomainname.com\"}]}','2025-08-19 07:16:56',1,23,0,28,'1','192.168.190.3','auth.php'),
(3,1,'System Administrator','{\"id\":\"1\",\"role\":1,\"name\":\"System Administrator\",\"defaultColor\":\"002200\",\"color\":\"002200\",\"isVisible\":true,\"isSubscribed\":true,\"_forUserId\":1}','2025-08-19 07:16:56',1,25,0,43,'1','192.168.190.3','auth.php'),
(4,2,'System Administrator','{\"forcePasswordChange\":[true,false],\"addressBookSettings\":[{\"defaultAddressBookId\":1,\"sortBy\":\"name\",\"userId\":1,\"startIn\":\"allcontacts\",\"lastAddressBookId\":null},{\"defaultAddressBookId\":1,\"sortBy\":\"name\",\"userId\":1,\"startIn\":\"allcontacts\",\"lastAddressBookId\":null}],\"calendarPreferences\":[{\"userId\":1,\"useTimeZones\":false,\"showWeekNumbers\":true,\"showTooltips\":true,\"showDeclined\":true,\"birthdaysAreVisible\":false,\"tasksAreVisible\":false,\"holidaysAreVisible\":false,\"defaultCalendarId\":null,\"autoAddInvitations\":true,\"markReadAndFileAutoAdd\":false,\"autoUpdateInvitations\":false,\"markReadAndFileAutoUpdate\":false,\"lastProcessed\":\"\",\"lastProcessedUid\":1,\"weekViewGridSnap\":15,\"weekViewGridSize\":8,\"startView\":\"month\",\"defaultDuration\":null},{\"userId\":1,\"useTimeZones\":false,\"showWeekNumbers\":true,\"showTooltips\":true,\"showDeclined\":true,\"birthdaysAreVisible\":false,\"tasksAreVisible\":false,\"holidaysAreVisible\":false,\"defaultCalendarId\":null,\"autoAddInvitations\":true,\"markReadAndFileAutoAdd\":false,\"autoUpdateInvitations\":false,\"markReadAndFileAutoUpdate\":false,\"lastProcessed\":\"\",\"lastProcessedUid\":1,\"weekViewGridSnap\":15,\"weekViewGridSize\":8,\"startView\":\"month\",\"defaultDuration\":null}],\"notesSettings\":[{\"defaultNoteBookId\":65,\"lastNoteBookIds\":[65],\"userId\":1,\"rememberLastItems\":true},{\"defaultNoteBookId\":65,\"lastNoteBookIds\":[65],\"userId\":1,\"rememberLastItems\":true}],\"tasksSettings\":[{\"defaultTasklistId\":\"1\",\"lastTasklistIds\":[\"1\"],\"userId\":\"1\",\"rememberLastItems\":true,\"defaultDate\":false},{\"defaultTasklistId\":\"1\",\"lastTasklistIds\":[\"1\"],\"userId\":\"1\",\"rememberLastItems\":true,\"defaultDate\":false}],\"emailSettings\":[{\"id\":\"1\",\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1},{\"id\":1,\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1}],\"syncSettings\":[{\"user_id\":\"1\",\"account_id\":0,\"noteBooks\":[{\"userId\":\"1\",\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":\"1\",\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":\"1\",\"tasklistId\":1,\"isDefault\":true}]},{\"user_id\":\"1\",\"account_id\":0,\"noteBooks\":[],\"addressBooks\":[],\"allowDeletes\":true,\"tasklists\":[]}]}','2025-08-19 07:16:56',1,4,0,25,'1','192.168.190.3','auth.php'),
(5,6,'groupofficeadmin [192.168.190.3]',NULL,'2025-08-19 07:17:16',1,26,0,25,NULL,'192.168.190.3','auth.php'),
(6,2,'System Administrator','{\"passwordModifiedAt\":[\"2025-08-19T07:17:16+00:00\",\"2025-08-19T07:16:40+00:00\"],\"forcePasswordChange\":[false,true],\"password\":[\"MASKED\",\"MASKED\"],\"tasksSettings\":[{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":\"1\",\"rememberLastItems\":true,\"defaultDate\":false},{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":1,\"rememberLastItems\":true,\"defaultDate\":false}],\"emailSettings\":[{\"id\":\"1\",\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1},{\"id\":1,\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1}],\"syncSettings\":[{\"user_id\":\"1\",\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]},{\"user_id\":1,\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]}]}','2025-08-19 07:17:17',1,4,0,25,'1','192.168.190.3','auth.php'),
(7,2,'System Administrator','{\"lastLogin\":[\"2025-08-19T07:17:17+00:00\",null],\"loginCount\":[1,0],\"passwordModifiedAt\":[\"2025-08-19T07:17:17+00:00\",\"2025-08-19T07:17:16+00:00\"],\"password\":[\"MASKED\",\"MASKED\"]}','2025-08-19 07:17:17',1,4,0,25,'1','192.168.190.3','auth.php'),
(8,4,'groupofficeadmin [192.168.190.3]',NULL,'2025-08-19 07:17:17',1,4,0,25,'1','192.168.190.3','auth.php'),
(9,1,'googleauthenticator','{\"id\":\"20\",\"name\":\"googleauthenticator\",\"package\":\"community\",\"version\":8,\"sort_order\":111}','2025-08-19 07:18:32',1,29,0,14,'20','192.168.190.3','JMAP Module/install'),
(10,1,'imapauthenticator','{\"id\":\"21\",\"name\":\"imapauthenticator\",\"package\":\"community\",\"version\":1,\"sort_order\":112}','2025-08-19 07:18:46',1,29,0,14,'21','192.168.190.3','JMAP Module/install'),
(11,1,'oauth2client','{\"id\":\"23\",\"name\":\"oauth2client\",\"package\":\"community\",\"version\":7,\"sort_order\":113}','2025-08-19 07:19:32',1,29,0,14,'23','192.168.190.3','JMAP Module/install'),
(12,1,'public','{\"user_id\":1,\"parent_id\":0,\"name\":\"public\",\"visible\":0,\"acl_id\":17,\"thumbs\":1,\"ctime\":1755587990,\"mtime\":1755587990,\"muser_id\":1,\"quota_user_id\":1,\"readonly\":1,\"apply_state\":0,\"id\":5}','2025-08-19 07:19:50',1,17,0,46,'5','192.168.190.3','modulescripts.php'),
(13,1,'customcss','{\"user_id\":1,\"parent_id\":5,\"name\":\"customcss\",\"visible\":0,\"acl_id\":0,\"thumbs\":1,\"ctime\":1755587990,\"mtime\":1755587990,\"muser_id\":1,\"quota_user_id\":1,\"readonly\":0,\"apply_state\":0,\"id\":6}','2025-08-19 07:19:50',1,17,0,46,'6','192.168.190.3','modulescripts.php'),
(14,1,'log','{\"user_id\":1,\"parent_id\":0,\"name\":\"log\",\"visible\":0,\"acl_id\":17,\"thumbs\":1,\"ctime\":1755588002,\"mtime\":1755588002,\"muser_id\":1,\"quota_user_id\":1,\"readonly\":1,\"apply_state\":0,\"id\":7}','2025-08-19 07:20:02',1,17,0,46,'7','192.168.190.3','index.php?r=files/folder/tree'),
(15,3,'Group-Office',NULL,'2025-08-19 07:20:43',1,11,0,30,'1','192.168.190.3','JMAP Bookmark/set'),
(16,3,'Intermesh',NULL,'2025-08-19 07:20:47',1,11,0,30,'2','192.168.190.3','JMAP Bookmark/set'),
(17,1,'TechnoInfotech','{\"id\":\"3\",\"categoryId\":\"1\",\"name\":\"TechnoInfotech\",\"content\":\"https:\\/\\/technoinfotech.com\",\"logo\":\"c43a86de899293706941a9b10edcc3b5b1bb20d9\"}','2025-08-19 07:22:08',1,11,0,30,'3','192.168.190.3','JMAP Bookmark/set'),
(18,1,'Innovative Thinking, Practical Solutions - Deepen Dhulla','{\"id\":\"4\",\"categoryId\":\"1\",\"name\":\"Innovative Thinking, Practical Solutions - Deepen Dhulla\",\"content\":\"https:\\/\\/deependhulla.com\",\"description\":\"Innovative Thinking, Practical Solutions\"}','2025-08-19 07:22:22',1,11,0,30,'4','192.168.190.3','JMAP Bookmark/set'),
(19,1,'go\\modules\\community\\imapauthenticator\\model\\Server','{\"id\":\"3\",\"imapHostname\":\"127.0.0.1\",\"smtpHostname\":\"127.0.0.1\",\"smtpUseUserCredentials\":true,\"smtpEncryption\":\"tls\",\"domains\":[{\"id\":\"3\",\"serverId\":\"3\",\"name\":\"*\"}],\"groups\":[{\"groupId\":3,\"serverId\":3},{\"groupId\":2,\"serverId\":3}]}','2025-08-19 07:25:02',1,58,0,48,'3','192.168.190.3','JMAP ImapAuthServer/set'),
(20,2,'go\\modules\\community\\imapauthenticator\\model\\Server','{\"groups\":[[{\"groupId\":3,\"serverId\":3}],[{\"groupId\":2,\"serverId\":3},{\"groupId\":3,\"serverId\":3}]]}','2025-08-19 07:25:18',1,58,0,48,'3','192.168.190.3','JMAP ImapAuthServer/set'),
(21,2,'System Administrator','{\"emailAddresses\":[[{\"type\":\"work\",\"email\":\"groupofficeadmin@powermail.mydomainname.com\"}],[{\"type\":\"work\",\"email\":\"postmaster@powermail.mydomainname.com\"}]]}','2025-08-19 07:26:10',1,23,0,28,'1','192.168.190.3','JMAP User/set'),
(22,2,'System Administrator','{\"email\":[\"groupofficeadmin@powermail.mydomainname.com\",\"postmaster@powermail.mydomainname.com\"],\"recoveryEmail\":[\"groupofficeadmin@powermail.mydomainname.com\",\"postmaster@powermail.mydomainname.com\"],\"tasksSettings\":[{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":\"1\",\"rememberLastItems\":true,\"defaultDate\":false},{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":1,\"rememberLastItems\":true,\"defaultDate\":false}],\"emailSettings\":[{\"id\":\"1\",\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1},{\"id\":1,\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1}],\"syncSettings\":[{\"user_id\":\"1\",\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]},{\"user_id\":1,\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]}]}','2025-08-19 07:26:10',1,4,0,25,'1','192.168.190.3','JMAP User/set'),
(23,2,'System Administrator','{\"tasksSettings\":[{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":\"1\",\"rememberLastItems\":true,\"defaultDate\":false},{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":1,\"rememberLastItems\":true,\"defaultDate\":false}],\"emailSettings\":[{\"id\":\"1\",\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1},{\"id\":1,\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1}],\"syncSettings\":[{\"user_id\":\"1\",\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]},{\"user_id\":1,\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]}]}','2025-08-19 07:26:10',1,4,0,25,'1','192.168.190.3','JMAP User/set'),
(24,2,'System Administrator','{\"timezone\":[\"Asia\\/Calcutta\",\"Europe\\/Amsterdam\"],\"theme\":[\"Compact\",\"Paper\"],\"tasksSettings\":[{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":\"1\",\"rememberLastItems\":true,\"defaultDate\":false},{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":1,\"rememberLastItems\":true,\"defaultDate\":false}],\"emailSettings\":[{\"id\":\"1\",\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1},{\"id\":1,\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1}],\"syncSettings\":[{\"user_id\":\"1\",\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]},{\"user_id\":1,\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]}]}','2025-08-19 07:27:53',1,4,0,25,'1','192.168.190.3','JMAP User/set'),
(25,2,'System Administrator','{\"tasksSettings\":[{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":\"1\",\"rememberLastItems\":true,\"defaultDate\":false},{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":1,\"rememberLastItems\":true,\"defaultDate\":false}],\"emailSettings\":[{\"id\":\"1\",\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1},{\"id\":1,\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1}],\"syncSettings\":[{\"user_id\":\"1\",\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]},{\"user_id\":1,\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]}]}','2025-08-19 07:27:53',1,4,0,25,'1','192.168.190.3','JMAP User/set'),
(26,2,'System Administrator','{\"theme\":[\"Paper\",\"Compact\"],\"tasksSettings\":[{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":\"1\",\"rememberLastItems\":true,\"defaultDate\":false},{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":1,\"rememberLastItems\":true,\"defaultDate\":false}],\"emailSettings\":[{\"id\":\"1\",\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1},{\"id\":1,\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1}],\"syncSettings\":[{\"user_id\":\"1\",\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]},{\"user_id\":1,\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]}]}','2025-08-19 07:28:24',1,4,0,25,'1','192.168.190.3','JMAP User/set'),
(27,2,'System Administrator','{\"tasksSettings\":[{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":\"1\",\"rememberLastItems\":true,\"defaultDate\":false},{\"defaultTasklistId\":1,\"lastTasklistIds\":[1],\"userId\":1,\"rememberLastItems\":true,\"defaultDate\":false}],\"emailSettings\":[{\"id\":\"1\",\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1},{\"id\":1,\"use_desktop_composer\":false,\"use_html_markup\":true,\"show_from\":true,\"show_cc\":true,\"show_bcc\":false,\"skip_unknown_recipients\":false,\"always_request_notification\":false,\"always_respond_to_notifications\":false,\"font_size\":\"14px\",\"sort_email_addresses_by_time\":true,\"defaultTemplateId\":1}],\"syncSettings\":[{\"user_id\":\"1\",\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]},{\"user_id\":1,\"account_id\":0,\"noteBooks\":[{\"userId\":1,\"noteBookId\":65,\"isDefault\":true}],\"addressBooks\":[{\"userId\":1,\"addressBookId\":1,\"isDefault\":true}],\"allowDeletes\":true,\"tasklists\":[{\"userId\":1,\"tasklistId\":1,\"isDefault\":true}]}]}','2025-08-19 07:28:24',1,4,0,25,'1','192.168.190.3','JMAP User/set'),
(28,8,'From: postmaster@powermail.mydomainname.com, To: postmaster@powermail.mydomainname.com, Subject: Test message, Id: 247c8fd7d21c78196861c282aff2f5f4@192.168.40.247',NULL,'2025-08-19 07:28:57',1,4,0,25,'1','192.168.190.3','JMAP core/Settings/sendTestMessage');
/*!40000 ALTER TABLE `history_log_entry` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `imapauth_server`
--

DROP TABLE IF EXISTS `imapauth_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `imapauth_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imapHostname` varchar(190) NOT NULL,
  `imapPort` int(11) NOT NULL DEFAULT 143,
  `imapEncryption` enum('tls','ssl') DEFAULT 'tls',
  `imapValidateCertificate` tinyint(1) NOT NULL DEFAULT 1,
  `removeDomainFromUsername` tinyint(1) NOT NULL DEFAULT 0,
  `smtpHostname` varchar(190) NOT NULL,
  `smtpPort` int(11) NOT NULL DEFAULT 587,
  `smtpUsername` varchar(190) DEFAULT NULL,
  `smtpPassword` varchar(512) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `smtpUseUserCredentials` tinyint(1) NOT NULL DEFAULT 0,
  `smtpEncryption` enum('tls','ssl') DEFAULT NULL,
  `smtpValidateCertificate` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imapauth_server`
--

LOCK TABLES `imapauth_server` WRITE;
/*!40000 ALTER TABLE `imapauth_server` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `imapauth_server` VALUES
(3,'127.0.0.1',143,'tls',0,0,'127.0.0.1',587,NULL,NULL,1,'tls',0);
/*!40000 ALTER TABLE `imapauth_server` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `imapauth_server_domain`
--

DROP TABLE IF EXISTS `imapauth_server_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `imapauth_server_domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverId` int(11) NOT NULL,
  `name` varchar(190) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `serverId` (`serverId`),
  CONSTRAINT `imapauth_server_domain_ibfk_1` FOREIGN KEY (`serverId`) REFERENCES `imapauth_server` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imapauth_server_domain`
--

LOCK TABLES `imapauth_server_domain` WRITE;
/*!40000 ALTER TABLE `imapauth_server_domain` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `imapauth_server_domain` VALUES
(3,3,'*');
/*!40000 ALTER TABLE `imapauth_server_domain` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `imapauth_server_group`
--

DROP TABLE IF EXISTS `imapauth_server_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `imapauth_server_group` (
  `serverId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  PRIMARY KEY (`serverId`,`groupId`),
  KEY `groupId` (`groupId`),
  CONSTRAINT `imapauth_server_group_ibfk_1` FOREIGN KEY (`serverId`) REFERENCES `imapauth_server` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `imapauth_server_group_ibfk_2` FOREIGN KEY (`groupId`) REFERENCES `core_group` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imapauth_server_group`
--

LOCK TABLES `imapauth_server_group` WRITE;
/*!40000 ALTER TABLE `imapauth_server_group` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `imapauth_server_group` VALUES
(3,3);
/*!40000 ALTER TABLE `imapauth_server_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `notes_note`
--

DROP TABLE IF EXISTS `notes_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes_note` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `noteBookId` int(11) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `modifiedBy` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `content` mediumtext DEFAULT NULL,
  `filesFolderId` int(11) DEFAULT NULL,
  `password` varchar(255) DEFAULT '',
  `createdAt` datetime DEFAULT NULL,
  `modifiedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`createdBy`),
  KEY `category_id` (`noteBookId`),
  KEY `modifiedBy` (`modifiedBy`),
  CONSTRAINT `notes_note_ibfk_1` FOREIGN KEY (`noteBookId`) REFERENCES `notes_note_book` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notes_note_ibfk_2` FOREIGN KEY (`createdBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `notes_note_ibfk_3` FOREIGN KEY (`modifiedBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes_note`
--

LOCK TABLES `notes_note` WRITE;
/*!40000 ALTER TABLE `notes_note` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `notes_note` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `notes_note_book`
--

DROP TABLE IF EXISTS `notes_note_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes_note_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deletedAt` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `aclId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `filesFolderId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aclId` (`aclId`),
  KEY `createdBy` (`createdBy`),
  CONSTRAINT `notes_note_book_ibfk_1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`),
  CONSTRAINT `notes_note_book_ibfk_2` FOREIGN KEY (`createdBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes_note_book`
--

LOCK TABLES `notes_note_book` WRITE;
/*!40000 ALTER TABLE `notes_note_book` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `notes_note_book` VALUES
(65,NULL,1,13,'Shared',NULL);
/*!40000 ALTER TABLE `notes_note_book` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `notes_note_custom_fields`
--

DROP TABLE IF EXISTS `notes_note_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes_note_custom_fields` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `notes_note_custom_fields_ibfk_1` FOREIGN KEY (`id`) REFERENCES `notes_note` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes_note_custom_fields`
--

LOCK TABLES `notes_note_custom_fields` WRITE;
/*!40000 ALTER TABLE `notes_note_custom_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `notes_note_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `notes_note_image`
--

DROP TABLE IF EXISTS `notes_note_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes_note_image` (
  `noteId` int(11) NOT NULL,
  `blobId` binary(40) NOT NULL,
  PRIMARY KEY (`noteId`,`blobId`),
  KEY `blobId` (`blobId`),
  CONSTRAINT `notes_note_image_ibfk_1` FOREIGN KEY (`blobId`) REFERENCES `core_blob` (`id`),
  CONSTRAINT `notes_note_image_ibfk_2` FOREIGN KEY (`noteId`) REFERENCES `notes_note` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes_note_image`
--

LOCK TABLES `notes_note_image` WRITE;
/*!40000 ALTER TABLE `notes_note_image` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `notes_note_image` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `notes_user_settings`
--

DROP TABLE IF EXISTS `notes_user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes_user_settings` (
  `userId` int(11) NOT NULL,
  `defaultNoteBookId` int(11) DEFAULT NULL,
  `rememberLastItems` tinyint(1) DEFAULT 0,
  `lastNoteBookIds` varchar(255) DEFAULT '',
  PRIMARY KEY (`userId`),
  KEY `defaultNoteBookId` (`defaultNoteBookId`),
  CONSTRAINT `notes_user_settings_ibfk_1` FOREIGN KEY (`defaultNoteBookId`) REFERENCES `notes_note_book` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notes_user_settings_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes_user_settings`
--

LOCK TABLES `notes_user_settings` WRITE;
/*!40000 ALTER TABLE `notes_user_settings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `notes_user_settings` VALUES
(1,65,1,'');
/*!40000 ALTER TABLE `notes_user_settings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `oauth2client_account`
--

DROP TABLE IF EXISTS `oauth2client_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2client_account` (
  `accountId` int(11) NOT NULL,
  `oauth2ClientId` int(11) unsigned NOT NULL,
  `token` text DEFAULT NULL,
  `refreshToken` text DEFAULT NULL,
  `expires` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`accountId`),
  KEY `accountId` (`accountId`),
  KEY `oauth2client_account_ibfk_1` (`oauth2ClientId`),
  CONSTRAINT `oauth2client_account_ibfk_1` FOREIGN KEY (`oauth2ClientId`) REFERENCES `oauth2client_oauth2client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth2client_account_ibfk_2` FOREIGN KEY (`accountId`) REFERENCES `em_accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2client_account`
--

LOCK TABLES `oauth2client_account` WRITE;
/*!40000 ALTER TABLE `oauth2client_account` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `oauth2client_account` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `oauth2client_default_client`
--

DROP TABLE IF EXISTS `oauth2client_default_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2client_default_client` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(190) NOT NULL,
  `authenticationMethod` varchar(20) NOT NULL,
  `imapHost` varchar(190) NOT NULL,
  `imapPort` smallint(5) unsigned NOT NULL,
  `imapEncryption` varchar(10) DEFAULT '',
  `smtpHost` varchar(190) NOT NULL,
  `smtpPort` smallint(5) unsigned NOT NULL,
  `smtpEncryption` varchar(10) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2client_default_client`
--

LOCK TABLES `oauth2client_default_client` WRITE;
/*!40000 ALTER TABLE `oauth2client_default_client` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `oauth2client_default_client` VALUES
(1,'Google','GoogleOauth2','imap.gmail.com',993,'ssl','smtp.gmail.com',465,'ssl'),
(2,'Azure','Azure','outlook.office365.com',993,'ssl','smtp.office365.com',587,'tls');
/*!40000 ALTER TABLE `oauth2client_default_client` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `oauth2client_oauth2client`
--

DROP TABLE IF EXISTS `oauth2client_oauth2client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2client_oauth2client` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(190) NOT NULL,
  `defaultClientId` int(11) unsigned DEFAULT NULL,
  `clientId` varchar(190) NOT NULL,
  `clientSecret` varchar(190) NOT NULL,
  `projectId` varchar(190) NOT NULL,
  `openId` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `oauth2client_oauth2client_openId_index` (`openId`),
  KEY `defaultClientId` (`defaultClientId`),
  CONSTRAINT `oauth2client_oauth2client_ibfk_1` FOREIGN KEY (`defaultClientId`) REFERENCES `oauth2client_default_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2client_oauth2client`
--

LOCK TABLES `oauth2client_oauth2client` WRITE;
/*!40000 ALTER TABLE `oauth2client_oauth2client` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `oauth2client_oauth2client` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `oauth2client_openid_user`
--

DROP TABLE IF EXISTS `oauth2client_openid_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2client_openid_user` (
  `userId` int(11) NOT NULL,
  `clientId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`userId`),
  KEY `oauth2client_openid_user_oauth2client_oauth2client_id_fk` (`clientId`),
  CONSTRAINT `oauth2client_openid_user_core_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `oauth2client_openid_user_oauth2client_oauth2client_id_fk` FOREIGN KEY (`clientId`) REFERENCES `oauth2client_oauth2client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2client_openid_user`
--

LOCK TABLES `oauth2client_openid_user` WRITE;
/*!40000 ALTER TABLE `oauth2client_openid_user` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `oauth2client_openid_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `otp_secret`
--

DROP TABLE IF EXISTS `otp_secret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `otp_secret` (
  `userId` int(11) NOT NULL,
  `secret` varchar(16) NOT NULL,
  `createdAt` datetime NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`userId`),
  KEY `user` (`userId`),
  CONSTRAINT `otp_secret_user` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otp_secret`
--

LOCK TABLES `otp_secret` WRITE;
/*!40000 ALTER TABLE `otp_secret` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `otp_secret` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `smi_account_settings`
--

DROP TABLE IF EXISTS `smi_account_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `smi_account_settings` (
  `account_id` int(11) NOT NULL,
  `always_sign` tinyint(1) NOT NULL,
  PRIMARY KEY (`account_id`),
  CONSTRAINT `fk_smi_settings_account_id_to_email_account` FOREIGN KEY (`account_id`) REFERENCES `em_accounts` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smi_account_settings`
--

LOCK TABLES `smi_account_settings` WRITE;
/*!40000 ALTER TABLE `smi_account_settings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `smi_account_settings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `smi_certs`
--

DROP TABLE IF EXISTS `smi_certs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `smi_certs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `cert` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smi_certs`
--

LOCK TABLES `smi_certs` WRITE;
/*!40000 ALTER TABLE `smi_certs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `smi_certs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `smi_pkcs12`
--

DROP TABLE IF EXISTS `smi_pkcs12`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `smi_pkcs12` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `cert` blob DEFAULT NULL,
  `serial` varchar(100) NOT NULL,
  `valid_until` datetime NOT NULL,
  `valid_since` datetime NOT NULL,
  `provided_by` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pks_cert_account_id_email_account_idx` (`account_id`),
  CONSTRAINT `fk_account_id_to_email_account` FOREIGN KEY (`account_id`) REFERENCES `em_accounts` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smi_pkcs12`
--

LOCK TABLES `smi_pkcs12` WRITE;
/*!40000 ALTER TABLE `smi_pkcs12` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `smi_pkcs12` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `su_announcements`
--

DROP TABLE IF EXISTS `su_announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `su_announcements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `acl_id` int(11) NOT NULL,
  `due_time` int(11) NOT NULL DEFAULT 0,
  `ctime` int(11) NOT NULL DEFAULT 0,
  `mtime` int(11) NOT NULL DEFAULT 0,
  `title` varchar(50) DEFAULT NULL,
  `content` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `due_time` (`due_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_announcements`
--

LOCK TABLES `su_announcements` WRITE;
/*!40000 ALTER TABLE `su_announcements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `su_announcements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `su_latest_read_announcement_records`
--

DROP TABLE IF EXISTS `su_latest_read_announcement_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `su_latest_read_announcement_records` (
  `user_id` int(11) NOT NULL,
  `announcement_id` int(11) DEFAULT NULL,
  `announcement_ctime` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  KEY `su_latest_read_announcement_records_su_announcements_id_fk` (`announcement_id`),
  CONSTRAINT `su_latest_read_announcement_records_core_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `su_latest_read_announcement_records_su_announcements_id_fk` FOREIGN KEY (`announcement_id`) REFERENCES `su_announcements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_latest_read_announcement_records`
--

LOCK TABLES `su_latest_read_announcement_records` WRITE;
/*!40000 ALTER TABLE `su_latest_read_announcement_records` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `su_latest_read_announcement_records` VALUES
(1,NULL,0);
/*!40000 ALTER TABLE `su_latest_read_announcement_records` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `su_notes`
--

DROP TABLE IF EXISTS `su_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `su_notes` (
  `user_id` int(11) NOT NULL,
  `text` text DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `su_notes_core_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_notes`
--

LOCK TABLES `su_notes` WRITE;
/*!40000 ALTER TABLE `su_notes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `su_notes` VALUES
(1,NULL);
/*!40000 ALTER TABLE `su_notes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `su_rss_feeds`
--

DROP TABLE IF EXISTS `su_rss_feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `su_rss_feeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(512) DEFAULT NULL,
  `summary` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `su_rss_feeds_core_user_id_fk` (`user_id`),
  CONSTRAINT `su_rss_feeds_core_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_rss_feeds`
--

LOCK TABLES `su_rss_feeds` WRITE;
/*!40000 ALTER TABLE `su_rss_feeds` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `su_rss_feeds` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `su_visible_calendars`
--

DROP TABLE IF EXISTS `su_visible_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `su_visible_calendars` (
  `user_id` int(11) NOT NULL,
  `calendar_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`calendar_id`),
  CONSTRAINT `su_visible_calendars_core_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_visible_calendars`
--

LOCK TABLES `su_visible_calendars` WRITE;
/*!40000 ALTER TABLE `su_visible_calendars` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `su_visible_calendars` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `su_visible_lists`
--

DROP TABLE IF EXISTS `su_visible_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `su_visible_lists` (
  `user_id` int(11) NOT NULL,
  `tasklist_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`tasklist_id`),
  CONSTRAINT `su_visible_lists_core_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `su_visible_lists`
--

LOCK TABLES `su_visible_lists` WRITE;
/*!40000 ALTER TABLE `su_visible_lists` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `su_visible_lists` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `sync_addressbook_user`
--

DROP TABLE IF EXISTS `sync_addressbook_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_addressbook_user` (
  `addressBookId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `isDefault` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`addressBookId`,`userId`),
  KEY `userId` (`userId`),
  CONSTRAINT `sync_addressbook_user_ibfk_1` FOREIGN KEY (`addressBookId`) REFERENCES `addressbook_addressbook` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sync_addressbook_user_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_addressbook_user`
--

LOCK TABLES `sync_addressbook_user` WRITE;
/*!40000 ALTER TABLE `sync_addressbook_user` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sync_addressbook_user` VALUES
(1,1,1);
/*!40000 ALTER TABLE `sync_addressbook_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `sync_calendar_user`
--

DROP TABLE IF EXISTS `sync_calendar_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_calendar_user` (
  `calendar_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `default_calendar` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`calendar_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_calendar_user`
--

LOCK TABLES `sync_calendar_user` WRITE;
/*!40000 ALTER TABLE `sync_calendar_user` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sync_calendar_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `sync_devices`
--

DROP TABLE IF EXISTS `sync_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_devices` (
  `id` int(11) NOT NULL DEFAULT 0,
  `manufacturer` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `software_version` varchar(50) DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `uri` varchar(128) DEFAULT NULL,
  `UTC` enum('0','1') NOT NULL,
  `vcalendar_version` varchar(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_devices`
--

LOCK TABLES `sync_devices` WRITE;
/*!40000 ALTER TABLE `sync_devices` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sync_devices` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `sync_note_categories_user`
--

DROP TABLE IF EXISTS `sync_note_categories_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_note_categories_user` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `default_category` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`category_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_note_categories_user`
--

LOCK TABLES `sync_note_categories_user` WRITE;
/*!40000 ALTER TABLE `sync_note_categories_user` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sync_note_categories_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `sync_settings`
--

DROP TABLE IF EXISTS `sync_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_settings` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `addressbook_id` int(11) NOT NULL DEFAULT 0,
  `calendar_id` int(11) NOT NULL DEFAULT 0,
  `tasklist_id` int(11) NOT NULL DEFAULT 0,
  `note_category_id` int(11) NOT NULL DEFAULT 0,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `server_is_master` tinyint(1) NOT NULL DEFAULT 1,
  `max_days_old` tinyint(4) NOT NULL DEFAULT 0,
  `delete_old_events` tinyint(1) NOT NULL DEFAULT 1,
  `allowDeletes` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_settings`
--

LOCK TABLES `sync_settings` WRITE;
/*!40000 ALTER TABLE `sync_settings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sync_settings` VALUES
(1,0,0,0,0,0,1,0,1,1);
/*!40000 ALTER TABLE `sync_settings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `sync_tasklist_user`
--

DROP TABLE IF EXISTS `sync_tasklist_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_tasklist_user` (
  `tasklistId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL DEFAULT 0,
  `isDefault` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`tasklistId`,`userId`),
  KEY `userId` (`userId`),
  CONSTRAINT `sync_tasklist_user_core_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sync_tasklist_user_tasks_tasklist_id_fk` FOREIGN KEY (`tasklistId`) REFERENCES `tasks_tasklist` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_tasklist_user`
--

LOCK TABLES `sync_tasklist_user` WRITE;
/*!40000 ALTER TABLE `sync_tasklist_user` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sync_tasklist_user` VALUES
(1,1,1);
/*!40000 ALTER TABLE `sync_tasklist_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `sync_user_note_book`
--

DROP TABLE IF EXISTS `sync_user_note_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sync_user_note_book` (
  `noteBookId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `isDefault` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`noteBookId`,`userId`),
  KEY `user` (`userId`),
  CONSTRAINT `sync_user_note_book_user` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_user_note_book`
--

LOCK TABLES `sync_user_note_book` WRITE;
/*!40000 ALTER TABLE `sync_user_note_book` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sync_user_note_book` VALUES
(65,1,1);
/*!40000 ALTER TABLE `sync_user_note_book` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_alert`
--

DROP TABLE IF EXISTS `tasks_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_alert` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `when` datetime NOT NULL,
  `acknowledged` datetime DEFAULT NULL,
  `relatedTo` text DEFAULT NULL,
  `action` smallint(2) NOT NULL DEFAULT 1,
  `offset` varchar(45) DEFAULT NULL,
  `relativeTo` varchar(5) DEFAULT 'start',
  `taskId` int(11) unsigned NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`,`taskId`,`userId`),
  KEY `fk_tasks_alert_tasks_task_user1_idx` (`taskId`,`userId`),
  CONSTRAINT `fk_tasks_alert_tasks_task_user1` FOREIGN KEY (`taskId`, `userId`) REFERENCES `tasks_task_user` (`taskId`, `userId`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_alert`
--

LOCK TABLES `tasks_alert` WRITE;
/*!40000 ALTER TABLE `tasks_alert` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tasks_alert` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_category`
--

DROP TABLE IF EXISTS `tasks_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `ownerId` int(11) DEFAULT NULL,
  `tasklistId` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`ownerId`),
  KEY `tasks_category_tasklist_ibfk_9` (`tasklistId`),
  CONSTRAINT `tasks_category_ibfk_1` FOREIGN KEY (`ownerId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_category_tasklist_ibfk_9` FOREIGN KEY (`tasklistId`) REFERENCES `tasks_tasklist` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_category`
--

LOCK TABLES `tasks_category` WRITE;
/*!40000 ALTER TABLE `tasks_category` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tasks_category` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_default_alert`
--

DROP TABLE IF EXISTS `tasks_default_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_default_alert` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `when` datetime NOT NULL,
  `relatedTo` text DEFAULT NULL,
  `action` smallint(2) NOT NULL DEFAULT 1,
  `offset` varchar(45) DEFAULT NULL,
  `relativeTo` varchar(5) DEFAULT 'start',
  `withTime` tinyint(1) NOT NULL DEFAULT 1,
  `tasklistId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`,`tasklistId`),
  KEY `fk_tasks_default_alert_tasks_tasklist1_idx` (`tasklistId`),
  CONSTRAINT `fk_tasks_default_alert_tasks_tasklist1` FOREIGN KEY (`tasklistId`) REFERENCES `tasks_tasklist` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_default_alert`
--

LOCK TABLES `tasks_default_alert` WRITE;
/*!40000 ALTER TABLE `tasks_default_alert` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tasks_default_alert` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_portlet_tasklist`
--

DROP TABLE IF EXISTS `tasks_portlet_tasklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_portlet_tasklist` (
  `userId` int(11) NOT NULL,
  `tasklistId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`userId`,`tasklistId`),
  KEY `tasklistId` (`tasklistId`),
  CONSTRAINT `tasks_portlet_tasklist_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_portlet_tasklist_ibfk_2` FOREIGN KEY (`tasklistId`) REFERENCES `tasks_tasklist` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_portlet_tasklist`
--

LOCK TABLES `tasks_portlet_tasklist` WRITE;
/*!40000 ALTER TABLE `tasks_portlet_tasklist` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tasks_portlet_tasklist` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_task`
--

DROP TABLE IF EXISTS `tasks_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_task` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` varchar(190) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  `tasklistId` int(11) unsigned NOT NULL,
  `groupId` int(10) unsigned DEFAULT NULL,
  `responsibleUserId` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `modifiedAt` datetime NOT NULL,
  `modifiedBy` int(11) DEFAULT NULL,
  `filesFolderId` int(11) DEFAULT NULL,
  `due` date DEFAULT NULL,
  `start` date DEFAULT NULL,
  `estimatedDuration` int(11) DEFAULT NULL COMMENT 'Duration in seconds',
  `progress` tinyint(2) NOT NULL DEFAULT 1,
  `progressUpdated` datetime DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `color` char(6) DEFAULT NULL,
  `recurrenceRule` varchar(400) DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT 1,
  `freeBusyStatus` char(4) DEFAULT 'busy',
  `privacy` varchar(7) DEFAULT 'public',
  `percentComplete` tinyint(4) NOT NULL DEFAULT 0,
  `uri` varchar(190) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `vcalendarBlobId` binary(40) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `location` text DEFAULT NULL,
  `projectId` int(10) unsigned DEFAULT NULL,
  `mileStoneId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `list_id` (`tasklistId`),
  KEY `groupId` (`groupId`),
  KEY `rrule` (`recurrenceRule`(191)),
  KEY `uuid` (`uid`),
  KEY `fkModifiedBy` (`modifiedBy`),
  KEY `createdBy` (`createdBy`),
  KEY `filesFolderId` (`filesFolderId`),
  KEY `tasks_task_groupId_idx` (`groupId`),
  KEY `tasks_vcalendar_blob_idx` (`vcalendarBlobId`),
  KEY `tasks_task_core_user_id_fk` (`responsibleUserId`),
  KEY `tasks_task_progress_index` (`progress`),
  CONSTRAINT `tasks_task_core_user_id_fk` FOREIGN KEY (`responsibleUserId`) REFERENCES `core_user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tasks_task_fkModifiedBy` FOREIGN KEY (`modifiedBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tasks_task_groupId` FOREIGN KEY (`groupId`) REFERENCES `tasks_tasklist_group` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tasks_task_ibfk_1` FOREIGN KEY (`tasklistId`) REFERENCES `tasks_tasklist` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_task_ibfk_2` FOREIGN KEY (`createdBy`) REFERENCES `core_user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tasks_vcalendar_blob` FOREIGN KEY (`vcalendarBlobId`) REFERENCES `core_blob` (`id`) ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_task`
--

LOCK TABLES `tasks_task` WRITE;
/*!40000 ALTER TABLE `tasks_task` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tasks_task` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_task_category`
--

DROP TABLE IF EXISTS `tasks_task_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_task_category` (
  `taskId` int(11) unsigned NOT NULL,
  `categoryId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`taskId`,`categoryId`),
  KEY `tasks_task_category_ibfk_2` (`categoryId`),
  CONSTRAINT `tasks_task_category_ibfk_1` FOREIGN KEY (`taskId`) REFERENCES `tasks_task` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_task_category_ibfk_2` FOREIGN KEY (`categoryId`) REFERENCES `tasks_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_task_category`
--

LOCK TABLES `tasks_task_category` WRITE;
/*!40000 ALTER TABLE `tasks_task_category` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tasks_task_category` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_task_custom_fields`
--

DROP TABLE IF EXISTS `tasks_task_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_task_custom_fields` (
  `id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tasks_task_custom_field1` FOREIGN KEY (`id`) REFERENCES `tasks_task` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_task_custom_fields`
--

LOCK TABLES `tasks_task_custom_fields` WRITE;
/*!40000 ALTER TABLE `tasks_task_custom_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tasks_task_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_task_user`
--

DROP TABLE IF EXISTS `tasks_task_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_task_user` (
  `taskId` int(11) unsigned NOT NULL,
  `userId` int(11) NOT NULL,
  `modSeq` int(11) NOT NULL DEFAULT 0,
  `freeBusyStatus` char(4) NOT NULL DEFAULT 'busy',
  PRIMARY KEY (`taskId`,`userId`),
  KEY `fk_tasks_task_user_tasks_task1_idx` (`taskId`),
  CONSTRAINT `fk_tasks_task_user_tasks_task1` FOREIGN KEY (`taskId`) REFERENCES `tasks_task` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_task_user`
--

LOCK TABLES `tasks_task_user` WRITE;
/*!40000 ALTER TABLE `tasks_task_user` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tasks_task_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_tasklist`
--

DROP TABLE IF EXISTS `tasks_tasklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_tasklist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `role` tinyint(2) unsigned DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `defaultColor` varchar(21) NOT NULL,
  `highestItemModSeq` varchar(32) DEFAULT '0',
  `aclId` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL DEFAULT 1,
  `filesFolderId` int(11) DEFAULT NULL,
  `projectId` int(11) DEFAULT NULL,
  `groupingId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fkCreatedBy` (`createdBy`),
  KEY `fkAcl` (`aclId`),
  KEY `tasks_tasklist_tasks_tasklist_grouping_null_fk` (`groupingId`),
  CONSTRAINT `tasks_tasklist_ibfk1` FOREIGN KEY (`aclId`) REFERENCES `core_acl` (`id`),
  CONSTRAINT `tasks_tasklist_ibfk2` FOREIGN KEY (`createdBy`) REFERENCES `core_user` (`id`),
  CONSTRAINT `tasks_tasklist_tasks_tasklist_grouping_null_fk` FOREIGN KEY (`groupingId`) REFERENCES `tasks_tasklist_grouping` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_tasklist`
--

LOCK TABLES `tasks_tasklist` WRITE;
/*!40000 ALTER TABLE `tasks_tasklist` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `tasks_tasklist` VALUES
(1,1,'System Administrator',NULL,1,'002200','0',25,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tasks_tasklist` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_tasklist_group`
--

DROP TABLE IF EXISTS `tasks_tasklist_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_tasklist_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `color` char(6) DEFAULT NULL,
  `sortOrder` smallint(2) unsigned NOT NULL DEFAULT 0,
  `tasklistId` int(11) unsigned NOT NULL,
  `progressChange` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`,`tasklistId`),
  UNIQUE KEY `fk_tasks_column_tasks_id_idx` (`id`),
  UNIQUE KEY `tasks_tasklist_group_pk` (`id`),
  KEY `fk_tasks_column_tasks_tasklist1_idx` (`tasklistId`),
  CONSTRAINT `fk_tasks_column_tasks_tasklist1` FOREIGN KEY (`tasklistId`) REFERENCES `tasks_tasklist` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_tasklist_group`
--

LOCK TABLES `tasks_tasklist_group` WRITE;
/*!40000 ALTER TABLE `tasks_tasklist_group` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tasks_tasklist_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_tasklist_grouping`
--

DROP TABLE IF EXISTS `tasks_tasklist_grouping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_tasklist_grouping` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(190) NOT NULL,
  `order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tasks_tasklist_grouping_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_tasklist_grouping`
--

LOCK TABLES `tasks_tasklist_grouping` WRITE;
/*!40000 ALTER TABLE `tasks_tasklist_grouping` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tasks_tasklist_grouping` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_tasklist_user`
--

DROP TABLE IF EXISTS `tasks_tasklist_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_tasklist_user` (
  `tasklistId` int(11) unsigned NOT NULL,
  `userId` int(11) NOT NULL,
  `modSeq` int(11) NOT NULL DEFAULT 0,
  `color` varchar(21) DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `isVisible` tinyint(1) NOT NULL DEFAULT 0,
  `isSubscribed` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`tasklistId`,`userId`),
  KEY `fk_tasks_tasklist_user_tasks_tasklist1_idx` (`tasklistId`),
  CONSTRAINT `fk_tasks_tasklist_user_tasks_tasklist1` FOREIGN KEY (`tasklistId`) REFERENCES `tasks_tasklist` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_tasklist_user`
--

LOCK TABLES `tasks_tasklist_user` WRITE;
/*!40000 ALTER TABLE `tasks_tasklist_user` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tasks_tasklist_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `tasks_user_settings`
--

DROP TABLE IF EXISTS `tasks_user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_user_settings` (
  `userId` int(11) NOT NULL,
  `defaultTasklistId` int(11) unsigned DEFAULT NULL,
  `rememberLastItems` tinyint(1) NOT NULL DEFAULT 0,
  `lastTasklistIds` varchar(255) DEFAULT NULL,
  `defaultDate` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`userId`),
  KEY `tasks_user_settings_tasks_tasklist_id_fk` (`defaultTasklistId`),
  CONSTRAINT `tasks_user_settings_core_user_id_fk` FOREIGN KEY (`userId`) REFERENCES `core_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_user_settings_tasks_tasklist_id_fk` FOREIGN KEY (`defaultTasklistId`) REFERENCES `tasks_tasklist` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks_user_settings`
--

LOCK TABLES `tasks_user_settings` WRITE;
/*!40000 ALTER TABLE `tasks_user_settings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `tasks_user_settings` VALUES
(1,1,1,NULL,0);
/*!40000 ALTER TABLE `tasks_user_settings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `zpa_devices`
--

DROP TABLE IF EXISTS `zpa_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `zpa_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` varchar(50) NOT NULL,
  `device_type` varchar(50) NOT NULL,
  `remote_addr` varchar(45) NOT NULL,
  `can_connect` tinyint(1) NOT NULL DEFAULT 0,
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `new` tinyint(1) NOT NULL DEFAULT 1,
  `username` varchar(190) NOT NULL DEFAULT '',
  `comment` text DEFAULT NULL,
  `as_version` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zpa_devices`
--

LOCK TABLES `zpa_devices` WRITE;
/*!40000 ALTER TABLE `zpa_devices` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `zpa_devices` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-08-19 13:17:16
