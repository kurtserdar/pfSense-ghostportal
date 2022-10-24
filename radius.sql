-- --------------------------------------------------------
-- Sunucu:                       192.168.1.4
-- Sunucu versiyonu:             5.5.21 - Source distribution
-- Sunucu İşletim Sistemi:       FreeBSD8.1
-- HeidiSQL Sürüm:               8.0.0.4396
-- --------------------------------------------------------

-- --------------------------------------------------------

-- Twitter : serdarkurt

-- ---------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- radius için veritabanı yapısı dökülüyor
CREATE DATABASE IF NOT EXISTS `radius` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `radius`;


-- tablo yapısı dökülüyor radius.cui
CREATE TABLE IF NOT EXISTS `cui` (
  `clientipaddress` varchar(15) NOT NULL DEFAULT '',
  `callingstationid` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(64) NOT NULL DEFAULT '',
  `cui` varchar(32) NOT NULL DEFAULT '',
  `creationdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastaccounting` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`username`,`clientipaddress`,`callingstationid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table radius.cui: 0 rows
/*!40000 ALTER TABLE `cui` DISABLE KEYS */;
/*!40000 ALTER TABLE `cui` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.ghost_settings
CREATE TABLE IF NOT EXISTS `ghost_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dayssms` text NOT NULL,
  `passwordexptime` text NOT NULL,
  `smsuser` text NOT NULL,
  `smspass` text NOT NULL,
  `smsno` text NOT NULL,
  `apiurl` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table radius.ghost_settings: ~1 rows (yaklaşık)
/*!40000 ALTER TABLE `ghost_settings` DISABLE KEYS */;
INSERT INTO `ghost_settings` (`id`, `dayssms`, `passwordexptime`, `smsuser`, `smspass`, `smsno`, `apiurl`) VALUES
	(1, 'gerek yok', '50', 'kullanici adi', 'sifre', 'sms basligi', 'http://api.iletimerkezi.com/v1/send-sms');
/*!40000 ALTER TABLE `ghost_settings` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.ghost_users
CREATE TABLE IF NOT EXISTS `ghost_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) CHARACTER SET latin1 NOT NULL,
  `password` varchar(200) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin5;

-- Dumping data for table radius.ghost_users: ~1 rows (yaklaşık)
/*!40000 ALTER TABLE `ghost_users` DISABLE KEYS */;
INSERT INTO `ghost_users` (`id`, `username`, `password`) VALUES
	(1, 'admin', 'ghost');
/*!40000 ALTER TABLE `ghost_users` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.log
CREATE TABLE IF NOT EXISTS `log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ad` text NOT NULL,
  `soyad` text NOT NULL,
  `telefon` text NOT NULL,
  `hata` text NOT NULL,
  `hatakodu` text NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

-- Dumping data for table radius.log: ~16 rows (yaklaşık)
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
/*!40000 ALTER TABLE `log` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.nas
CREATE TABLE IF NOT EXISTS `nas` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nasname` varchar(128) NOT NULL,
  `shortname` varchar(32) DEFAULT NULL,
  `type` varchar(30) DEFAULT 'other',
  `ports` int(5) DEFAULT NULL,
  `secret` varchar(60) NOT NULL DEFAULT 'secret',
  `server` varchar(64) DEFAULT NULL,
  `community` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT 'RADIUS Client',
  PRIMARY KEY (`id`),
  KEY `nasname` (`nasname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table radius.nas: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `nas` DISABLE KEYS */;
/*!40000 ALTER TABLE `nas` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.radacct
CREATE TABLE IF NOT EXISTS `radacct` (
  `radacctid` bigint(21) NOT NULL AUTO_INCREMENT,
  `acctsessionid` varchar(64) CHARACTER SET latin1 DEFAULT '',
  `acctuniqueid` varchar(32) CHARACTER SET latin1 DEFAULT '',
  `username` varchar(64) CHARACTER SET latin1 DEFAULT '',
  `groupname` varchar(64) CHARACTER SET latin1 DEFAULT '',
  `realm` varchar(64) CHARACTER SET latin1 DEFAULT '',
  `nasipaddress` varchar(15) CHARACTER SET latin1 DEFAULT '',
  `nasportid` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `nasporttype` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `acctstarttime` datetime DEFAULT NULL,
  `acctupdatetime` datetime DEFAULT NULL,
  `acctstoptime` datetime DEFAULT NULL,
  `acctsessiontime` int(12) DEFAULT NULL,
  `acctinterval` varchar(40) DEFAULT NULL,
  `acctauthentic` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `connectinfo_start` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `connectinfo_stop` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `acctinputoctets` bigint(20) DEFAULT NULL,
  `acctoutputoctets` bigint(20) DEFAULT NULL,
  `calledstationid` varchar(50) CHARACTER SET latin1 DEFAULT '',
  `callingstationid` varchar(50) CHARACTER SET latin1 DEFAULT '',
  `acctterminatecause` varchar(32) CHARACTER SET latin1 DEFAULT '',
  `servicetype` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `framedprotocol` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `framedipaddress` varchar(15) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `framedipv6address` varchar(15) CHARACTER SET latin1 DEFAULT '',
  `framedipv6prefix` varchar(15) CHARACTER SET latin1 DEFAULT '',
  `framedinterfaceid` varchar(15) CHARACTER SET latin1 DEFAULT '',
  `delegatedipv6prefix` varchar(15) CHARACTER SET latin1 DEFAULT '',
  `acctstartdelay` int(12) DEFAULT NULL,
  `acctstopdelay` int(12) DEFAULT NULL,
  `xascendsessionsvrkey` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`radacctid`),
  KEY `username` (`username`),
  KEY `framedipaddress` (`framedipaddress`),
  KEY `acctsessionid` (`acctsessionid`),
  KEY `acctsessiontime` (`acctsessiontime`),
  KEY `acctuniqueid` (`acctuniqueid`),
  KEY `acctstarttime` (`acctstarttime`),
  KEY `acctstoptime` (`acctstoptime`),
  KEY `nasipaddress` (`nasipaddress`)
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8;

-- Dumping data for table radius.radacct: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radacct` DISABLE KEYS */;
/*!40000 ALTER TABLE `radacct` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.radcheck
CREATE TABLE IF NOT EXISTS `radcheck` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64),
  `attribute` varchar(64),
  `op` char(2) NOT NULL DEFAULT ':=',
  `value` varchar(253),
  `tip` longtext,
  `telefon` longtext,
  `tcno` longtext,
  `adsoyad` longtext,
  `tarih` longtext,
  `sifre` longtext,
  `dtarih` longtext,
  PRIMARY KEY (`id`),
  KEY `username` (`username`(32))
) ENGINE=InnoDB AUTO_INCREMENT=1122 DEFAULT CHARSET=latin5;

-- Dumping data for table radius.radcheck: ~20 rows (yaklaşık)
/*!40000 ALTER TABLE `radcheck` DISABLE KEYS */;
/*!40000 ALTER TABLE `radcheck` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.radgroupcheck
CREATE TABLE IF NOT EXISTS `radgroupcheck` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '==',
  `value` varchar(253) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `groupname` (`groupname`(32))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table radius.radgroupcheck: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radgroupcheck` DISABLE KEYS */;
/*!40000 ALTER TABLE `radgroupcheck` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.radgroupreply
CREATE TABLE IF NOT EXISTS `radgroupreply` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '=',
  `value` varchar(253) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `groupname` (`groupname`(32))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table radius.radgroupreply: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radgroupreply` DISABLE KEYS */;
/*!40000 ALTER TABLE `radgroupreply` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.radippool
CREATE TABLE IF NOT EXISTS `radippool` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pool_name` varchar(30) NOT NULL,
  `framedipaddress` varchar(15) NOT NULL DEFAULT '',
  `nasipaddress` varchar(15) NOT NULL DEFAULT '',
  `calledstationid` varchar(30) NOT NULL,
  `callingstationid` varchar(30) NOT NULL,
  `expiry_time` datetime DEFAULT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `pool_key` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `radippool_poolname_expire` (`pool_name`,`expiry_time`),
  KEY `framedipaddress` (`framedipaddress`),
  KEY `radippool_nasip_poolkey_ipaddress` (`nasipaddress`,`pool_key`,`framedipaddress`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table radius.radippool: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radippool` DISABLE KEYS */;
/*!40000 ALTER TABLE `radippool` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.radpostauth
CREATE TABLE IF NOT EXISTS `radpostauth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `pass` varchar(64) NOT NULL DEFAULT '',
  `reply` varchar(32) NOT NULL DEFAULT '',
  `authdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=610 DEFAULT CHARSET=latin1;

-- Dumping data for table radius.radpostauth: ~2 rows (yaklaşık)
/*!40000 ALTER TABLE `radpostauth` DISABLE KEYS */;
/*!40000 ALTER TABLE `radpostauth` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.radreply
CREATE TABLE IF NOT EXISTS `radreply` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '=',
  `value` varchar(253) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `username` (`username`(32))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table radius.radreply: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radreply` DISABLE KEYS */;
/*!40000 ALTER TABLE `radreply` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.radusergroup
CREATE TABLE IF NOT EXISTS `radusergroup` (
  `username` varchar(64) NOT NULL DEFAULT '',
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `priority` int(11) NOT NULL DEFAULT '1',
  KEY `username` (`username`(32))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table radius.radusergroup: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radusergroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `radusergroup` ENABLE KEYS */;


-- tablo yapısı dökülüyor radius.wimax
CREATE TABLE IF NOT EXISTS `wimax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `authdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `spi` varchar(16) NOT NULL DEFAULT '',
  `mipkey` varchar(400) NOT NULL DEFAULT '',
  `lifetime` int(12) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `spi` (`spi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table radius.wimax: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `wimax` DISABLE KEYS */;
/*!40000 ALTER TABLE `wimax` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
