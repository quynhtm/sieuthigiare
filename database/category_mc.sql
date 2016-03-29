/*
Navicat MySQL Data Transfer

Source Server         : plazamuachungdev
Source Server Version : 50624
Source Host           : 10.3.9.10:3306
Source Database       : mcplaza

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-03-29 17:25:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `category_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category_merchant_id` smallint(5) DEFAULT NULL,
  `category_parent_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `category_depart` smallint(5) unsigned NOT NULL DEFAULT '0',
  `category_icon` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'icon',
  `category_icon_hover` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'icon hover',
  `category_status` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`category_id`),
  KEY `status` (`category_status`) USING BTREE,
  KEY `id_parrent` (`category_parent_id`,`category_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', 'Thời trang áo tắm', null, '24', '1', null, null, '0', '2014-07-03 11:19:02', '0000-00-00 00:00:00');
INSERT INTO `category` VALUES ('2', 'Váy dài', null, '24', '1', null, null, '0', '2014-07-03 11:21:57', '2014-06-16 09:56:55');
INSERT INTO `category` VALUES ('3', 'Áo', null, '24', '1', null, null, '0', '2014-07-03 11:19:59', '2014-06-16 09:57:35');
INSERT INTO `category` VALUES ('4', 'Du lịch', null, '0', '4', 'dev/category/-0-64931.png', 'category/category/-0-27998.png', '1', '2014-08-13 16:28:23', '2014-06-17 04:33:26');
INSERT INTO `category` VALUES ('5', 'Phụ kiện công nghệ', null, '43', '4', '', 'category/category/-0-phukien-30616.png', '1', '2015-12-08 17:38:06', '2014-06-17 04:35:48');
INSERT INTO `category` VALUES ('6', 'Phòng khách sạn', null, '4', '2', null, null, '1', '2014-07-03 11:32:07', '2014-06-17 08:21:10');
INSERT INTO `category` VALUES ('7', 'Ẩm thực, Spa, Giải trí', null, '0', '7', 'category/category/-0-amthuc-spa-26673.png', 'category/category/-0-14289.png', '1', '2015-12-10 15:21:32', '2014-06-18 02:51:24');
INSERT INTO `category` VALUES ('8', 'Ô tô', null, '7', '7', null, null, '0', '2015-10-08 11:22:30', '2014-06-18 03:12:12');
INSERT INTO `category` VALUES ('9', 'Nhà hàng', null, '7', '7', null, null, '1', '2014-07-03 11:30:15', '2014-06-19 02:30:21');
INSERT INTO `category` VALUES ('10', 'Váy ngắn', null, '24', '1', null, null, '0', '2014-07-03 11:19:29', '2014-06-19 03:05:30');
INSERT INTO `category` VALUES ('11', 'Chân váy', null, '24', '1', null, null, '0', '2014-07-15 15:07:16', '2014-06-19 03:11:53');
INSERT INTO `category` VALUES ('13', 'Resort&amp;Nghỉ dưỡng', null, '4', '1', null, null, '1', '2014-07-03 11:31:51', '2014-06-19 10:00:09');
INSERT INTO `category` VALUES ('14', 'Khám phá', null, '4', '3', null, null, '1', '2014-07-03 11:31:19', '2014-06-19 10:00:45');
INSERT INTO `category` VALUES ('15', 'Ăn vặt&amp;Cafe', null, '7', '2', null, null, '0', '2014-09-15 11:01:10', '2014-06-19 10:23:33');
INSERT INTO `category` VALUES ('16', 'Ẩm thực', null, '7', '2', 'category/category/-0-amthuc-spa-74319.png', 'category/category/-0-amthuc-97970.png', '1', '2015-12-10 15:21:01', '2014-06-19 10:24:34');
INSERT INTO `category` VALUES ('17', 'Quần áo&amp;Phụ kiện trẻ em', null, '24', '1', null, null, '0', '2014-09-15 11:03:07', '2014-06-19 10:45:17');
INSERT INTO `category` VALUES ('19', 'Quần áo&amp;Phụ kiện nam', null, '24', '1', null, null, '0', '2014-09-15 11:04:30', '2014-06-19 11:44:27');
INSERT INTO `category` VALUES ('23', 'Mỹ phẩm&amp;Làm đẹp', null, '24', '1', null, null, '0', '2014-09-15 11:04:18', '2014-06-20 04:13:11');
INSERT INTO `category` VALUES ('24', 'Thời trang &amp; Phụ kiện', null, '0', '0', 'dev/category/-0-28245.png', 'category/category/-0-17340.png', '0', '2015-05-08 19:22:18', '2014-06-20 04:17:54');
INSERT INTO `category` VALUES ('25', 'Tham quan', null, '4', '2', null, null, '1', '2014-07-03 11:31:28', '2014-06-24 05:16:45');
INSERT INTO `category` VALUES ('26', 'test danhmuc', null, '21', '0', null, null, '0', '2014-06-30 10:12:28', '2014-06-25 04:32:11');
INSERT INTO `category` VALUES ('27', 'Đồ điện gia dụng', null, '86', '0', 'dev/category/-0-32684.png', 'category/category/-0-diengiadung-16722.png', '1', '2015-12-10 11:40:25', '2014-06-26 04:09:25');
INSERT INTO `category` VALUES ('28', 'Channel', null, '27', '0', null, null, '0', '2014-07-03 11:26:32', '2014-06-26 04:19:02');
INSERT INTO `category` VALUES ('29', 'Phụ kiện', null, '24', '0', null, null, '0', '2015-05-08 19:21:15', '2014-06-30 08:56:49');
INSERT INTO `category` VALUES ('30', 'Maybeline', null, '27', '0', null, null, '0', '2014-07-03 11:26:18', '2014-07-02 09:47:03');
INSERT INTO `category` VALUES ('31', 'Thời trang nam', null, '24', '0', null, null, '0', '2015-05-08 19:21:53', '2014-07-03 01:53:29');
INSERT INTO `category` VALUES ('32', 'Thời trang nữ', null, '24', '0', null, null, '0', '2015-05-08 19:22:05', '2014-07-03 04:00:03');
INSERT INTO `category` VALUES ('33', 'Đồ dùng tiện ích', null, '27', '0', null, null, '0', '2014-09-15 11:22:40', '2014-07-17 11:10:57');
INSERT INTO `category` VALUES ('41', 'Mẹ và bé', null, '0', '0', 'dev/category/-0-mevabe-27723.png', '', '1', '2016-03-01 14:26:28', '2014-08-11 16:54:57');
INSERT INTO `category` VALUES ('42', 'Điện máy', null, '0', '0', 'category/category/-0-55335.png', '', '0', '2015-08-18 17:04:40', '2014-08-21 11:38:50');
INSERT INTO `category` VALUES ('43', 'Điện tử công nghệ', null, '0', '0', 'category/category/-0-dientu-congnghe-67983.png', '', '1', '2015-12-16 10:16:04', '2014-08-21 16:37:56');
INSERT INTO `category` VALUES ('44', 'Điện thoại', '3', '43', '0', '', 'category/category/-0-dienthoai-47430.png', '1', '2015-12-08 17:37:42', '2014-08-21 17:01:16');
INSERT INTO `category` VALUES ('45', 'Xe cộ', null, '0', '0', 'category/category/-0-xeco-59919.png', '', '1', '2015-12-10 11:35:10', '2014-09-13 17:12:23');
INSERT INTO `category` VALUES ('50', 'Điện lạnh', null, '86', '0', '', '', '1', '2015-11-07 12:45:44', '2014-09-15 10:25:52');
INSERT INTO `category` VALUES ('53', 'Thời trang trẻ em', null, '41', '0', '', 'category/category/-0-Embe-81980.png', '1', '2015-12-10 09:33:49', '2014-09-15 16:06:46');
INSERT INTO `category` VALUES ('56', 'Đồ chơi - Đồ dùng', null, '41', '0', '', 'category/category/-0-dochoi-41846.png', '1', '2015-12-24 09:28:23', '2014-09-15 16:07:04');
INSERT INTO `category` VALUES ('59', 'Xe đạp', null, '45', '0', '', 'category/category/-0-xedap-65137.png', '1', '2015-12-10 09:34:26', '2014-09-15 17:51:28');
INSERT INTO `category` VALUES ('65', 'Trang điểm - Làm tóc', null, '0', '0', '', '', '1', '2015-12-25 16:56:20', '2014-10-03 14:36:19');
INSERT INTO `category` VALUES ('66', 'Mỹ phẩm', null, '7', '0', '', 'category/category/-0-mypham-23544.png', '0', '2015-12-09 16:31:32', '2014-10-03 14:46:48');
INSERT INTO `category` VALUES ('69', 'Spa &amp; Làm đẹp', null, '7', '0', '', '', '0', '2015-11-20 18:20:29', '2014-10-03 14:48:33');
INSERT INTO `category` VALUES ('72', 'Spa - Masage', null, '0', '0', '', 'category/category/-0-spa-66685.png', '0', '2015-12-09 16:34:26', '2014-10-03 14:55:22');
INSERT INTO `category` VALUES ('75', 'Trang điểm - Chăm sóc tóc', null, '69', '0', '', '', '0', '2015-09-01 10:46:16', '2014-10-03 14:55:45');
INSERT INTO `category` VALUES ('78', 'Chăm sóc sức khỏe', null, '69', '0', '', '', '0', '2015-09-01 10:46:34', '2014-10-03 14:56:03');
INSERT INTO `category` VALUES ('81', 'Tivi, Video &amp; Âm thanh', null, '43', '0', '', 'category/category/-0-tivi-amthanh-50194.png', '0', '2015-12-08 17:37:30', '2014-10-08 00:14:12');
INSERT INTO `category` VALUES ('83', 'Phòng ngủ - Phòng tắm', null, '0', '0', '', '', '1', '2015-12-25 16:56:23', '2014-10-10 10:23:14');
INSERT INTO `category` VALUES ('86', 'Gia dụng &amp; Nội thất', null, '0', '0', 'category/category/-0-giadung-78352.png', '', '1', '2015-12-10 11:31:25', '2014-10-10 10:39:01');
INSERT INTO `category` VALUES ('89', 'Nội thất phòng tắm', null, '86', '0', '', 'category/category/-0-phongtam-25426.png', '1', '2015-12-09 16:35:24', '2014-10-10 10:51:41');
INSERT INTO `category` VALUES ('90', 'Thực phẩm', null, '0', '0', 'category/category/-0-thucpham-12540.png', '', '1', '2015-12-10 11:31:18', '2014-11-20 11:20:56');
INSERT INTO `category` VALUES ('91', 'Thực phẩm bổ dưỡng', null, '90', '0', '', 'category/category/-0-thucphamboduong-36750.png', '1', '2015-12-10 09:52:46', '2014-11-20 11:21:54');
INSERT INTO `category` VALUES ('92', 'Vật dụng nhà bếp', null, '86', '0', '', 'category/category/-0-vatdung-nhabep-26616.png', '1', '2015-12-09 16:35:48', '2014-11-21 10:23:45');
INSERT INTO `category` VALUES ('93', 'Sữa - Đồ ngọt', null, '90', '0', '', 'category/category/-0-sua-dongot-99037.png', '1', '2015-12-10 09:52:06', '2015-01-16 14:38:08');
INSERT INTO `category` VALUES ('94', 'Thực phẩm gia đình', null, '90', '0', '', 'category/category/-0-thucphamgiadinh-26637.png', '1', '2015-12-10 09:52:31', '2015-01-16 14:38:56');
INSERT INTO `category` VALUES ('95', 'Thực phẩm chức năng', null, '90', '0', '', 'category/category/-0-thucphamchucnang-56455.png', '1', '2015-12-10 09:52:18', '2015-01-16 14:40:09');
INSERT INTO `category` VALUES ('96', 'Thời trang nam', null, '0', '0', 'category/category/-0-thoitrangnam-97196.png', '', '1', '2015-12-10 11:34:16', '2015-05-08 17:57:37');
INSERT INTO `category` VALUES ('97', 'Thời trang nữ', null, '0', '0', 'category/category/-0-thoitrangnu2-46212.png', '', '1', '2015-12-16 10:16:30', '2015-05-08 17:57:37');
INSERT INTO `category` VALUES ('98', 'Áo sơmi', null, '96', '0', '', '', '0', '2015-08-18 17:14:24', '2015-05-08 17:57:37');
INSERT INTO `category` VALUES ('99', 'Áo khoác, Vest', null, '96', '0', '', 'category/category/-0-vest-26155.png', '1', '2015-12-09 17:01:44', '2015-05-08 17:57:37');
INSERT INTO `category` VALUES ('100', 'Áo len, Cardigan', null, '96', '0', '', '', '1', '2015-05-08 17:57:37', '2015-05-08 17:57:37');
INSERT INTO `category` VALUES ('101', 'Quần', null, '96', '0', '', 'category/category/-0-quan-13922.png', '1', '2015-12-09 17:01:51', '2015-05-08 17:57:38');
INSERT INTO `category` VALUES ('102', 'Pull và Áo phông', null, '96', '0', '', 'category/category/-0-pull-aophong-34571.png', '1', '2015-12-09 17:01:08', '2015-05-08 17:57:38');
INSERT INTO `category` VALUES ('103', 'Đồ lót, Đồ bơi nam', null, '96', '0', '', '', '1', '2015-05-08 17:57:38', '2015-05-08 17:57:38');
INSERT INTO `category` VALUES ('104', 'Đồ thể thao', null, '96', '0', '', 'category/category/-0-dothethao-28059.png', '1', '2015-12-10 09:55:37', '2015-05-08 17:57:38');
INSERT INTO `category` VALUES ('105', 'Thời trang bầu', null, '41', '0', '', '', '1', '2015-08-18 17:01:45', '2015-05-08 17:57:38');
INSERT INTO `category` VALUES ('106', 'Đầm, chân váy', null, '97', '0', '', 'category/category/-0-vay-54406.png', '1', '2015-12-09 17:31:33', '2015-05-08 17:57:39');
INSERT INTO `category` VALUES ('107', 'Áo sơ mi', null, '97', '0', '', 'category/category/-0-aosomi-82723.png', '1', '2015-12-09 17:27:13', '2015-05-08 17:57:39');
INSERT INTO `category` VALUES ('108', 'Áo Khoác và Vest', null, '97', '0', '', 'category/category/-0-24897poster-63119.png', '1', '2015-12-08 15:40:04', '2015-05-08 17:57:39');
INSERT INTO `category` VALUES ('109', 'Quần', null, '97', '0', '', 'category/category/-0-quan-85766.png', '1', '2015-12-11 10:06:33', '2015-05-08 17:57:39');
INSERT INTO `category` VALUES ('110', 'Đồ lót, Đồ bơi', null, '97', '0', '', 'category/category/-0-dolot-doboi-96167.png', '1', '2015-12-09 17:27:29', '2015-05-08 17:57:39');
INSERT INTO `category` VALUES ('111', 'Đồ thể thao, mặc nhà', null, '97', '0', '', 'category/category/-0-domacnha-98753.png', '1', '2015-12-09 17:30:42', '2015-05-08 17:57:40');
INSERT INTO `category` VALUES ('112', 'Thời trang nữ khác', null, '97', '0', '', '', '1', '2015-05-08 17:57:40', '2015-05-08 17:57:40');
INSERT INTO `category` VALUES ('113', 'Chân váy', null, '97', '0', '', '', '0', '2015-08-18 17:28:59', '2015-05-08 17:57:40');
INSERT INTO `category` VALUES ('114', 'Đồ thể thao', null, '97', '0', '', 'category/category/-0-dothethao-macnha-49466.png', '0', '2015-12-09 17:28:28', '2015-05-08 17:57:41');
INSERT INTO `category` VALUES ('115', 'Phụ kiện Nữ', null, '97', '0', '', 'category/category/-0-phukien-10246.png', '1', '2015-12-09 17:31:09', '2015-05-08 17:57:41');
INSERT INTO `category` VALUES ('116', 'Túi, Ví', null, '115', '0', '', '', '0', '2015-08-18 17:30:38', '2015-05-08 17:57:41');
INSERT INTO `category` VALUES ('117', 'Trang sức', null, '115', '0', '', '', '0', '2015-08-18 17:31:00', '2015-05-08 17:57:41');
INSERT INTO `category` VALUES ('118', 'Khác', null, '115', '0', '', '', '0', '2015-08-18 17:31:30', '2015-05-08 17:57:42');
INSERT INTO `category` VALUES ('119', 'Phụ kiện Nam', null, '96', '0', '', 'category/category/-0-phukien-18996.png', '1', '2015-12-09 17:00:55', '2015-05-08 17:57:42');
INSERT INTO `category` VALUES ('120', 'Túi, Ví nam', null, '119', '0', '', '', '0', '2015-08-18 17:17:14', '2015-05-08 17:57:42');
INSERT INTO `category` VALUES ('121', 'Thắt lưng', null, '119', '0', '', '', '0', '2015-08-18 17:17:47', '2015-05-08 17:57:42');
INSERT INTO `category` VALUES ('122', 'Giày dép Nữ', null, '97', '0', '', 'category/category/-0-giaydep-32011.png', '1', '2015-12-09 17:30:58', '2015-05-08 17:57:42');
INSERT INTO `category` VALUES ('123', 'Giày cao gót', null, '122', '0', '', '', '0', '2015-08-18 17:33:58', '2015-05-08 17:57:43');
INSERT INTO `category` VALUES ('124', 'Giày đế bằng', null, '122', '0', '', '', '0', '2015-08-18 17:33:39', '2015-05-08 17:57:43');
INSERT INTO `category` VALUES ('125', 'Boots nam', null, '122', '0', '', '', '0', '2015-08-18 17:33:19', '2015-05-08 17:57:43');
INSERT INTO `category` VALUES ('126', 'Sandals', null, '122', '0', '', '', '0', '2015-08-18 17:32:47', '2015-05-08 17:57:43');
INSERT INTO `category` VALUES ('127', 'Giày dép Nam', null, '96', '0', '', 'category/category/-0-giaydep-27182.png', '1', '2015-12-09 17:00:41', '2015-05-08 17:57:43');
INSERT INTO `category` VALUES ('128', 'Giày Âu', null, '127', '0', '', '', '0', '2015-08-18 17:23:58', '2015-05-08 17:57:43');
INSERT INTO `category` VALUES ('129', 'Giày lười', null, '127', '0', '', '', '0', '2015-08-18 17:24:35', '2015-05-08 17:57:44');
INSERT INTO `category` VALUES ('130', 'Boots', null, '127', '0', '', '', '0', '2015-08-18 17:24:54', '2015-05-08 17:57:44');
INSERT INTO `category` VALUES ('131', 'Giày thể thao', null, '127', '0', '', '', '0', '2015-08-18 17:25:16', '2015-05-08 17:57:44');
INSERT INTO `category` VALUES ('132', 'Giày buộc dây, Sneaker', null, '127', '0', '', '', '0', '2015-08-18 17:25:34', '2015-05-08 17:57:44');
INSERT INTO `category` VALUES ('133', 'Thời trang trẻ em', null, '0', '0', '', '', '0', '2015-08-21 11:40:22', '2015-05-20 16:05:29');
INSERT INTO `category` VALUES ('134', 'Thời trang bé trai', null, '133', '0', '', '', '0', '2015-08-21 11:40:09', '2015-05-20 16:05:57');
INSERT INTO `category` VALUES ('135', 'Thời trang bé gái', null, '133', '0', '', '', '0', '2015-08-21 11:38:50', '2015-05-20 16:06:12');
INSERT INTO `category` VALUES ('136', 'Phụ kiện bé trai', null, '133', '0', '', '', '0', '2015-08-21 11:38:24', '2015-05-20 16:06:29');
INSERT INTO `category` VALUES ('137', 'Phụ kiện bé gái', null, '133', '0', '', '', '0', '2015-08-21 11:38:01', '2015-05-20 16:06:46');
INSERT INTO `category` VALUES ('138', 'Giày dép bé trai', null, '133', '0', '', '', '0', '2015-08-21 11:37:38', '2015-05-20 16:07:07');
INSERT INTO `category` VALUES ('139', 'Giày dép bé gái', null, '0', '0', '', '', '0', '2015-10-06 09:44:40', '2015-05-20 16:07:26');
INSERT INTO `category` VALUES ('140', 'Máy tính, laptop', '4', '43', '0', '', 'category/category/-0-laptop-10811.png', '1', '2015-12-08 17:37:07', '2015-08-16 11:44:02');
INSERT INTO `category` VALUES ('141', 'Máy tính bảng', null, '43', '0', '', 'category/category/-0-maytinhbang-76582.png', '1', '2015-12-08 17:36:58', '2015-08-20 17:08:51');
INSERT INTO `category` VALUES ('142', 'All', '1', '43', '0', null, null, '0', '2015-08-26 11:19:11', '2015-08-26 11:19:11');
INSERT INTO `category` VALUES ('143', 'Máy in', null, '43', '0', '', 'category/category/-0-mayin-16257.png', '1', '2015-12-08 17:36:48', '2015-08-31 16:58:40');
INSERT INTO `category` VALUES ('144', 'Màn hình', null, '43', '0', '', 'category/category/-0-manhinh-53602.png', '1', '2015-12-08 17:38:17', '2015-08-31 17:02:28');
INSERT INTO `category` VALUES ('145', 'Máy ảnh - Máy quay', null, '43', '0', '', 'category/category/-0-mayanh-84423.png', '1', '2015-12-08 17:36:30', '2015-09-22 14:20:30');
INSERT INTO `category` VALUES ('146', 'Mỹ phẩm nam', null, '96', '0', '', '', '0', '2015-09-22 17:32:10', '2015-09-22 17:32:10');
INSERT INTO `category` VALUES ('147', 'Thiết bị an ninh', null, '43', '0', '', '', '1', '2015-09-23 15:40:16', '2015-09-23 15:40:16');
INSERT INTO `category` VALUES ('148', 'Tivi - Âm thanh - Thiết bị Số', null, '43', '0', '', 'category/category/-0-tivi-amthanh-28529.png', '1', '2015-12-08 17:36:17', '2015-10-06 14:51:16');
INSERT INTO `category` VALUES ('149', 'Mỹ phẩm', null, '97', '0', '', '', '0', '2015-12-01 11:43:15', '2015-10-07 11:03:19');
INSERT INTO `category` VALUES ('150', 'Ô tô', null, '45', '0', '', '', '1', '2015-10-08 10:34:48', '2015-10-08 10:34:48');
INSERT INTO `category` VALUES ('151', 'Xe máy', null, '45', '0', '', 'category/category/-0-xemay-35786.png', '1', '2015-12-10 09:34:10', '2015-10-08 11:22:11');
INSERT INTO `category` VALUES ('152', 'Dụng cụ nhà bếp', null, '86', '0', '', '', '0', '2015-11-07 12:46:57', '2015-11-07 10:07:51');
INSERT INTO `category` VALUES ('153', 'Dụng cụ nhà bếp', null, '86', '0', '', '', '0', '2015-11-07 10:09:09', '2015-11-07 10:07:56');
INSERT INTO `category` VALUES ('154', 'Đồ điện gia dụng', null, '86', '0', '', 'category/category/-0-diengiadung-98029.png', '0', '2015-12-10 11:42:51', '2015-11-07 10:08:16');
INSERT INTO `category` VALUES ('155', 'Sản phẩm tiện ích', null, '86', '0', '', 'category/category/-0-tienich-28613.png', '1', '2015-12-09 16:35:36', '2015-11-07 10:08:33');
INSERT INTO `category` VALUES ('156', 'Nội thất phòng ngủ', null, '86', '0', '', 'category/category/-0-noithatphongngu-28493.png', '0', '2015-12-14 13:20:51', '2015-11-10 11:40:54');
INSERT INTO `category` VALUES ('157', 'Nội thất và trang trí nhà ở', null, '86', '0', '', 'category/category/-0-noithat&amp;trangtri-74489.png', '1', '2015-12-09 16:34:52', '2015-11-17 12:38:07');
INSERT INTO `category` VALUES ('158', 'Thể Thao - Dã ngoại', null, '0', '0', 'category/category/-0-thethao-94175.png', '', '1', '2015-12-10 11:31:01', '2015-11-28 12:20:19');
INSERT INTO `category` VALUES ('159', 'Máy tập thể thao các loại', null, '158', '0', '', 'category/category/-0-maytapthethao-51328.png', '1', '2015-12-09 16:36:26', '2015-11-30 10:07:59');
INSERT INTO `category` VALUES ('160', 'Dụng cụ thể thao', null, '158', '0', '', 'category/category/-0-dungcuthethao-40953.png', '1', '2015-12-09 16:36:17', '2015-11-30 10:08:13');
INSERT INTO `category` VALUES ('161', 'Đồ dùng dã ngoại', null, '158', '0', '', '', '1', '2015-11-30 10:08:36', '2015-11-30 10:08:36');
INSERT INTO `category` VALUES ('162', 'Xe đạp thể thao', null, '158', '0', '', '', '1', '2015-11-30 10:09:52', '2015-11-30 10:09:52');
INSERT INTO `category` VALUES ('163', 'Các loại khác', null, '158', '0', '', 'category/category/-0-cacloaikhac-39073.png', '1', '2015-12-09 16:36:36', '2015-11-30 10:10:07');
INSERT INTO `category` VALUES ('164', 'Làm đẹp &amp; Sức khỏe', null, '0', '0', 'category/category/-0-mypham-58173.png', '', '1', '2016-01-05 14:44:02', '2015-11-30 13:59:51');
INSERT INTO `category` VALUES ('165', 'Trang điểm', null, '164', '0', '', 'category/category/-0-trangdiem-72775.png', '1', '2015-12-09 17:38:39', '2015-12-01 11:25:06');
INSERT INTO `category` VALUES ('166', 'Chăm sóc cơ thể', null, '164', '0', '', 'category/category/-0-chamsoccothe-31242.png', '1', '2015-12-09 17:38:30', '2015-12-01 11:25:27');
INSERT INTO `category` VALUES ('167', 'Chăm sóc tóc', null, '164', '0', '', 'category/category/-0-chamsoctoc-29363.png', '1', '2015-12-09 17:38:22', '2015-12-01 11:25:44');
INSERT INTO `category` VALUES ('168', 'Chăm sóc da mặt', null, '164', '0', '', 'category/category/-0-chamsocdamat-94346.png', '1', '2015-12-09 17:38:12', '2015-12-01 11:26:04');
INSERT INTO `category` VALUES ('169', 'Quần áo - Phụ kiện thể thao', null, '158', '0', '', '', '1', '2015-12-09 12:19:56', '2015-12-09 12:19:56');
INSERT INTO `category` VALUES ('170', 'Đồ dùng cho mẹ', null, '41', '0', '', '', '1', '2015-12-23 12:20:18', '2015-12-19 12:10:35');
INSERT INTO `category` VALUES ('171', 'Thực phẩm và dụng cụ ăn uống', null, '41', '0', '', '', '1', '2015-12-23 12:16:41', '2015-12-19 12:10:58');
INSERT INTO `category` VALUES ('172', 'Đồ dùng cho bé', null, '41', '0', '', '', '1', '2015-12-23 12:48:58', '2015-12-19 12:11:08');
INSERT INTO `category` VALUES ('173', 'Xe và các thiết bị an toàn', null, '41', '0', '', '', '1', '2015-12-23 10:24:11', '2015-12-19 12:11:22');
INSERT INTO `category` VALUES ('174', 'Bé học và chơi', null, '41', '0', '', '', '1', '2015-12-23 10:25:07', '2015-12-19 12:11:38');
INSERT INTO `category` VALUES ('175', 'Đồ gia dụng tiện ích', null, '41', '0', '', '', '1', '2015-12-23 11:51:26', '2015-12-19 12:11:58');
INSERT INTO `category` VALUES ('176', 'Thiết bị y tế &amp; Làm đẹp', null, '164', '0', '', '', '1', '2016-01-05 15:18:34', '2016-01-05 15:18:34');
