/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : sieuthigiare

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2016-05-25 09:23:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for web_advertise_click
-- ----------------------------
DROP TABLE IF EXISTS `web_advertise_click`;
CREATE TABLE `web_advertise_click` (
  `click_id` int(11) NOT NULL AUTO_INCREMENT,
  `click_banner_id` int(11) NOT NULL DEFAULT '0' COMMENT 'banner id được click',
  `click_video_id` int(11) DEFAULT '0' COMMENT 'id video dc xem',
  `click_new_id` int(11) DEFAULT '0' COMMENT 'Tin bài quảng cáo đc click',
  `click_type_object` tinyint(5) DEFAULT '1' COMMENT '1: banner quảng cáo, 2: tin bài quảng cáo:3 video',
  `click_host_ip` varchar(255) DEFAULT NULL COMMENT 'Địa chỉ IP click banner',
  `click_total` int(11) DEFAULT '0' COMMENT 'tổng sô click gần nhất',
  `click_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`click_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_advertise_click
-- ----------------------------
INSERT INTO `web_advertise_click` VALUES ('1', '13', null, '0', '1', '192.168.35.123', '1', '1462520365');
INSERT INTO `web_advertise_click` VALUES ('2', '13', null, '0', '1', '192.168.35.124', '1', '1462520450');
INSERT INTO `web_advertise_click` VALUES ('3', '13', null, '0', '1', '192.168.35.125', '1', '1462521066');
INSERT INTO `web_advertise_click` VALUES ('4', '13', null, '0', '1', '192.168.35.126', '1', '1462521094');
INSERT INTO `web_advertise_click` VALUES ('5', '13', null, '0', '1', '192.168.35.127', '1', '1462521698');
INSERT INTO `web_advertise_click` VALUES ('6', '13', null, '0', '1', '192.168.35.128', '1', '1462521752');
INSERT INTO `web_advertise_click` VALUES ('7', '13', null, '0', '1', '192.168.35.129', '1', '1462522517');
INSERT INTO `web_advertise_click` VALUES ('8', '14', null, '0', '1', '192.168.35.129', '1', '1462522557');
INSERT INTO `web_advertise_click` VALUES ('9', '14', null, '0', '1', '192.168.35.128', '1', '1462522588');
