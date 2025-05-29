DROP DATABASE IF EXISTS `ad1`;
CREATE DATABASE `ad1`;
USE `ad1`;
-- ----------------------------
-- Table structure for `randad`
-- ----------------------------
CREATE TABLE `randad` (
  `ADID` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_path` varchar(20) NOT NULL,
  `ad_file` varchar(20) NOT NULL,
  `link` varchar(30) NOT NULL,
  `Alternate` text NOT NULL,
  `ADContent` text NOT NULL,
  PRIMARY KEY (`ADID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of randad
-- ----------------------------
INSERT INTO randad VALUES ('1', 'image', 'ad1.png', 'shopping.pchome.com.tw', 'pchome網路購物', 'pchome網路購物');
INSERT INTO randad VALUES ('2', 'image', 'ad2.png', 'tw.yahoo.com', 'yahoo', 'yahoo');
INSERT INTO randad VALUES ('3', 'image', 'ad3.png', 'udn.com', '聯合新聞網', '聯合新聞網');
