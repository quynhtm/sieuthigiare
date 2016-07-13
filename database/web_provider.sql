/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : sieuthigiare

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2016-07-13 15:40:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for web_provider
-- ----------------------------
DROP TABLE IF EXISTS `web_provider`;
CREATE TABLE `web_provider` (
  `provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Tên nhà cung cấp',
  `provider_phone` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `provider_address` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `provider_email` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `provider_shop_id` int(11) DEFAULT NULL COMMENT 'ID shop của nhà cung cấp',
  `provider_shop_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of web_provider
-- ----------------------------
