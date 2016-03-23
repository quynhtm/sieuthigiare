/*
Navicat MySQL Data Transfer

Source Server         : plazamuachungdev
Source Server Version : 50624
Source Host           : 10.3.9.10:3306
Source Database       : mcplaza

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-03-23 09:33:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for province
-- ----------------------------
DROP TABLE IF EXISTS `province`;
CREATE TABLE `province` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `position` tinyint(4) NOT NULL,
  `status` varchar(20) NOT NULL,
  `area` tinyint(4) NOT NULL,
  `support` varchar(500) DEFAULT NULL,
  `fullHotline` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name_facebook` varchar(255) DEFAULT '',
  `lang` char(2) DEFAULT 'vi',
  `area_ship` tinyint(4) DEFAULT '0',
  `province_pickup` tinyint(2) DEFAULT '0' COMMENT '1: Lay hang HN, 2: Lay hang HCM',
  PRIMARY KEY (`id`),
  KEY `position` (`position`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of province
-- ----------------------------
INSERT INTO `province` VALUES ('3', 'Bạc Liêu', '6', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('4', 'Bắc Cạn', '7', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('5', 'Bắc Giang', '6', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('6', 'Bắc Ninh', '7', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('7', 'Bến Tre', '8', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('8', 'Bình Dương', '9', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('9', 'Bình Định', '10', '0', '2', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('10', 'Bình Phước', '11', '0', '2', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('11', 'Bình Thuận', '12', '0', '2', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('12', 'Cà Mau', '13', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('13', 'Cao Bằng', '14', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('14', 'Cần Thơ', '8', '0', '3', 'a:7:{s:7:\"hotline\";s:12:\"0710.3783192\";s:5:\"yahoo\";s:18:\"Đang cập nhật\";s:7:\"address\";s:67:\"Số 230, đường 30/4, Phường Hưng Lợi, Quận Ninh Kiều\";s:5:\"email\";s:18:\"cantho@muachung.vn\";s:11:\"fullHotline\";s:32:\"0710.3783192 - Fax: 0710.3783194\";s:4:\"time\";s:10:\"8h30 - 12h\";s:5:\"time2\";s:11:\"13h30 - 18h\";}', '', '', 'MuaChung', 'vi', '1', '0');
INSERT INTO `province` VALUES ('15', 'Đà Nẵng', '3', '1', '2', 'a:7:{s:7:\"hotline\";s:14:\"(0511) 2603603\";s:5:\"yahoo\";s:10:\"muachungdn\";s:7:\"address\";s:56:\"21 Hàm Nghi - Phường Vĩnh Trung - Quận Thanh Khê\";s:5:\"email\";s:18:\"danang@muachung.vn\";s:11:\"fullHotline\";s:36:\"(0511) 2603603 - Fax: (0511) 3812168\";s:4:\"time\";s:10:\"8h30 - 12h\";s:5:\"time2\";s:11:\"13h30 - 18h\";}', '', '', 'Muachung.DaNang', 'vi', '2', '1');
INSERT INTO `province` VALUES ('17', 'Đồng Nai', '18', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('18', 'Đồng Tháp', '19', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('19', 'Gia Lai', '20', '0', '2', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('20', 'Hà Giang', '21', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('21', 'Hà Nam', '22', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('22', 'Hà Nội', '1', '1', '1', 'a:7:{s:7:\"hotline\";s:13:\"(04) 73068386\";s:5:\"yahoo\";s:10:\"muachungvn\";s:7:\"address\";s:44:\"152 Phó Đức Chính, Ba Đình, Hà Nội\";s:5:\"email\";s:19:\"contact@muachung.vn\";s:11:\"fullHotline\";s:34:\"(04) 73068386 - Fax: (04) 37154310\";s:4:\"time\";s:8:\"8h - 12h\";s:5:\"time2\";s:11:\"13h30 - 18h\";}', '', '', 'MuaChung', 'en', '3', '0');
INSERT INTO `province` VALUES ('23', 'Hà Tây', '24', '0', '1', null, '', '', '', 'vi', '0', '0');
INSERT INTO `province` VALUES ('24', 'Hà Tĩnh', '25', '0', '2', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('25', 'Hải Dương', '26', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('26', 'Hải Phòng', '5', '1', '1', 'a:7:{s:7:\"hotline\";s:29:\"(031) 3786816 / (031) 3786814\";s:5:\"yahoo\";s:10:\"muachunghp\";s:7:\"address\";s:57:\"310 Hai Bà Trưng (Cát Dài), Q.Lê Chân, Hải Phòng\";s:5:\"email\";s:20:\"haiphong@muachung.vn\";s:11:\"fullHotline\";s:34:\"(031) 3786816 - Fax: (031) 3786815\";s:4:\"time\";s:10:\"8h30 - 12h\";s:5:\"time2\";s:11:\"13h - 17h30\";}', '', '', 'MuaChung.HaiPhong', 'vi', '3', '0');
INSERT INTO `province` VALUES ('27', 'Hòa Bình', '28', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('28', 'Hưng Yên', '29', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('29', 'TP Hồ Chí Minh', '2', '1', '3', 'a:7:{s:7:\"hotline\";s:13:\"(08) 73068386\";s:5:\"yahoo\";s:11:\"muachunghcm\";s:7:\"address\";s:55:\"Cao ốc 123, 123 Võ Văn Tần, Phường 6, Quận 3\";s:5:\"email\";s:15:\"hcm@muachung.vn\";s:11:\"fullHotline\";s:34:\"(08) 73068386 - Fax: (08) 39309936\";s:4:\"time\";s:10:\"7h30 - 12h\";s:5:\"time2\";s:11:\"12h - 18h30\";}', '', '', 'MuaChung', 'en', '1', '0');
INSERT INTO `province` VALUES ('30', 'Khánh Hòa', '31', '0', '2', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('31', 'Kiên Giang', '32', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('32', 'Kon Tum', '33', '0', '2', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('33', 'Lai Châu', '34', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('34', 'Lạng Sơn', '35', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('35', 'Lào Cai', '36', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('36', 'Lâm Đồng', '37', '0', '2', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('37', 'Long An', '38', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('38', 'Nam Định', '39', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('39', 'Nghệ An', '40', '0', '2', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('40', 'Ninh Bình', '41', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('41', 'Ninh Thuận', '42', '0', '2', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('42', 'Phú Thọ', '43', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('43', 'Phú Yên', '44', '0', '2', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('44', 'Quảng Bình', '45', '0', '2', null, '', '', '', 'vi', '2', '1');
INSERT INTO `province` VALUES ('45', 'Quảng Nam', '46', '0', '2', null, '', '', '', 'vi', '2', '2');
INSERT INTO `province` VALUES ('46', 'Quảng Ngãi', '47', '0', '2', null, '', '', '', 'vi', '2', '2');
INSERT INTO `province` VALUES ('47', 'Quảng Ninh', '7', '0', '1', 'a:7:{s:7:\"hotline\";s:13:\"(031) 3786812\";s:5:\"yahoo\";s:10:\"muachungqn\";s:7:\"address\";s:18:\"Đang cập nhật\";s:5:\"email\";s:21:\"quangninh@muachung.vn\";s:11:\"fullHotline\";s:34:\"(031) 3786812 - Fax: (031) 3786815\";s:4:\"time\";s:10:\"8h30 - 12h\";s:5:\"time2\";s:11:\"13h - 17h30\";}', '', '', 'MuaChung', 'vi', '3', '0');
INSERT INTO `province` VALUES ('48', 'Quảng Trị', '49', '0', '2', null, '', '', '', 'vi', '2', '1');
INSERT INTO `province` VALUES ('49', 'Sóc Trăng', '50', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('50', 'Sơn La', '51', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('51', 'Tây Ninh', '52', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('52', 'Thái Bình', '53', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('53', 'Thái Nguyên', '54', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('54', 'Thanh Hóa', '55', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('55', 'Thừa Thiên Huế', '56', '0', '2', null, '', '', '', 'vi', '2', '1');
INSERT INTO `province` VALUES ('56', 'Tiền Giang', '57', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('57', 'Trà Vinh', '58', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('58', 'Tuyên Quang', '59', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('59', 'Vĩnh Long', '60', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('60', 'Vĩnh Phúc', '61', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('61', 'Yên Bái', '62', '0', '1', null, '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('66', 'An giang', '62', '0', '3', null, '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('67', 'Vũng Tàu', '6', '1', '3', 'a:7:{s:7:\"hotline\";s:14:\"(064)3.584.818\";s:5:\"yahoo\";s:9:\"mcvungtau\";s:7:\"address\";s:48:\"63 Lý Tự Trọng, Phường 1, TP. Vũng Tàu\";s:5:\"email\";s:19:\"vungtau@muachung.vn\";s:11:\"fullHotline\";s:14:\"(064)3.584.818\";s:4:\"time\";s:10:\"8h30 - 12h\";s:5:\"time2\";s:11:\"13h30 - 18h\";}', '', '', 'MuaChung.VungTau', 'vi', '1', '0');
INSERT INTO `province` VALUES ('68', 'Nha Trang', '4', '1', '0', 'a:7:{s:7:\"hotline\";s:27:\"(058)3813136 / (058)3813137\";s:5:\"yahoo\";s:10:\"muachungnt\";s:7:\"address\";s:67:\"Số 6B Đào Duy Từ , Phường Vạn Thạnh,  TP Nha Trang\";s:5:\"email\";s:22:\"mcnhatrang@muachung.vn\";s:11:\"fullHotline\";s:27:\"(058)3813136 / (058)3813137\";s:4:\"time\";s:10:\"7h30 - 12h\";s:5:\"time2\";s:9:\"14h - 18h\";}', '', '', 'Muachung.NhaTrang', 'en', '0', '0');
INSERT INTO `province` VALUES ('69', 'Điện Biên', '0', '0', '0', 'a:5:{s:7:\"hotline\";s:0:\"\";s:5:\"yahoo\";s:0:\"\";s:7:\"address\";s:0:\"\";s:11:\"fullHotline\";s:0:\"\";s:5:\"email\";s:0:\"\";}', '', '', '', 'vi', '3', '0');
INSERT INTO `province` VALUES ('70', 'Hậu Giang', '0', '0', '0', 'a:5:{s:7:\"hotline\";s:0:\"\";s:5:\"yahoo\";s:0:\"\";s:7:\"address\";s:0:\"\";s:11:\"fullHotline\";s:0:\"\";s:5:\"email\";s:0:\"\";}', '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('71', 'Đắk Nông', '0', '0', '0', 'a:5:{s:7:\"hotline\";s:0:\"\";s:5:\"yahoo\";s:0:\"\";s:7:\"address\";s:0:\"\";s:11:\"fullHotline\";s:0:\"\";s:5:\"email\";s:0:\"\";}', '', '', '', 'vi', '1', '0');
INSERT INTO `province` VALUES ('72', 'Đắk Lắc', '0', '0', '0', 'a:5:{s:7:\"hotline\";s:0:\"\";s:5:\"yahoo\";s:0:\"\";s:7:\"address\";s:0:\"\";s:5:\"email\";s:0:\"\";s:11:\"fullHotline\";s:0:\"\";}', '', '', '', 'vi', '1', '0');
