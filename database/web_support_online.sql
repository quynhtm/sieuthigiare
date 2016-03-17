/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : sieuthigiare

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2016-03-17 11:18:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for web_support_online
-- ----------------------------
DROP TABLE IF EXISTS `web_support_online`;
CREATE TABLE `web_support_online` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `catid` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `title_alias` varchar(255) DEFAULT NULL,
  `yahoo` varchar(255) DEFAULT NULL,
  `skyper` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created` varchar(15) DEFAULT NULL,
  `order_no` int(11) DEFAULT '0',
  `img` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0' COMMENT 'Item enabled status (1 = enabled, 0 = disabled)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Stores support online content.';

-- ----------------------------
-- Records of web_support_online
-- ----------------------------
INSERT INTO `web_support_online` VALUES ('1', '1', null, 'Nguyễn Duy', 'nguyen-duy', 'pt.soleil', 'nguyenduypt86', null, '0913.922.986', 'nguyenduypt86@gmail.com', '1458147793', '1', null, '1');
INSERT INTO `web_support_online` VALUES ('4', '2', null, 'quynh_arsenal133', 'quynharsenal133', 'quynh_arsenal133', 'quynh_arsenal133', null, '0938413368', 'manhquynh1984@gmail.com', '1458184712', '1', null, '1');
