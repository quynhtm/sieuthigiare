/*
Navicat MySQL Data Transfer

Source Server         : LOCALHOST
Source Server Version : 50625
Source Host           : 127.0.0.1:3306
Source Database       : sieuthigiare

Target Server Type    : MYSQL
Target Server Version : 50625
File Encoding         : 65001

Date: 2016-04-01 09:20:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for actions
-- ----------------------------
DROP TABLE IF EXISTS `actions`;
CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';

-- ----------------------------
-- Records of actions
-- ----------------------------
INSERT INTO `actions` VALUES ('comment_publish_action', 'comment', 'comment_publish_action', '', 'Publish comment');
INSERT INTO `actions` VALUES ('comment_save_action', 'comment', 'comment_save_action', '', 'Save comment');
INSERT INTO `actions` VALUES ('comment_unpublish_action', 'comment', 'comment_unpublish_action', '', 'Unpublish comment');
INSERT INTO `actions` VALUES ('node_make_sticky_action', 'node', 'node_make_sticky_action', '', 'Make content sticky');
INSERT INTO `actions` VALUES ('node_make_unsticky_action', 'node', 'node_make_unsticky_action', '', 'Make content unsticky');
INSERT INTO `actions` VALUES ('node_promote_action', 'node', 'node_promote_action', '', 'Promote content to front page');
INSERT INTO `actions` VALUES ('node_publish_action', 'node', 'node_publish_action', '', 'Publish content');
INSERT INTO `actions` VALUES ('node_save_action', 'node', 'node_save_action', '', 'Save content');
INSERT INTO `actions` VALUES ('node_unpromote_action', 'node', 'node_unpromote_action', '', 'Remove content from front page');
INSERT INTO `actions` VALUES ('node_unpublish_action', 'node', 'node_unpublish_action', '', 'Unpublish content');
INSERT INTO `actions` VALUES ('system_block_ip_action', 'user', 'system_block_ip_action', '', 'Ban IP address of current user');
INSERT INTO `actions` VALUES ('user_block_user_action', 'user', 'user_block_user_action', '', 'Block current user');

-- ----------------------------
-- Table structure for authmap
-- ----------------------------
DROP TABLE IF EXISTS `authmap`;
CREATE TABLE `authmap` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `authname` (`authname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';

-- ----------------------------
-- Records of authmap
-- ----------------------------

-- ----------------------------
-- Table structure for batch
-- ----------------------------
DROP TABLE IF EXISTS `batch`;
CREATE TABLE `batch` (
  `bid` int(10) unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
  PRIMARY KEY (`bid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';

-- ----------------------------
-- Records of batch
-- ----------------------------

-- ----------------------------
-- Table structure for block
-- ----------------------------
DROP TABLE IF EXISTS `block`;
CREATE TABLE `block` (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';

-- ----------------------------
-- Records of block
-- ----------------------------
INSERT INTO `block` VALUES ('1', 'system', 'main', 'bartik', '1', '0', 'content', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('2', 'search', 'form', 'bartik', '1', '-1', 'sidebar_first', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('3', 'node', 'recent', 'seven', '1', '10', 'dashboard_main', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('4', 'user', 'login', 'bartik', '1', '0', 'sidebar_first', '0', '1', 'user', '<none>', '-1');
INSERT INTO `block` VALUES ('5', 'system', 'navigation', 'bartik', '1', '0', 'sidebar_first', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('6', 'system', 'powered-by', 'bartik', '1', '10', 'footer', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('7', 'system', 'help', 'bartik', '1', '0', 'help', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('8', 'system', 'main', 'seven', '1', '0', 'content', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('9', 'system', 'help', 'seven', '1', '0', 'help', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('10', 'user', 'login', 'seven', '1', '10', 'content', '0', '1', 'user', '<none>', '-1');
INSERT INTO `block` VALUES ('11', 'user', 'new', 'seven', '1', '0', 'dashboard_sidebar', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('12', 'search', 'form', 'seven', '1', '-10', 'dashboard_sidebar', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('13', 'comment', 'recent', 'bartik', '0', '0', '-1', '0', '0', '', '', '1');
INSERT INTO `block` VALUES ('14', 'node', 'syndicate', 'bartik', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('15', 'node', 'recent', 'bartik', '0', '0', '-1', '0', '0', '', '', '1');
INSERT INTO `block` VALUES ('16', 'shortcut', 'shortcuts', 'bartik', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('17', 'system', 'management', 'bartik', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('18', 'system', 'user-menu', 'bartik', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('19', 'system', 'main-menu', 'bartik', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('20', 'user', 'new', 'bartik', '0', '0', '-1', '0', '0', '', '', '1');
INSERT INTO `block` VALUES ('21', 'user', 'online', 'bartik', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('22', 'comment', 'recent', 'seven', '1', '0', 'dashboard_inactive', '0', '0', '', '', '1');
INSERT INTO `block` VALUES ('23', 'node', 'syndicate', 'seven', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('24', 'shortcut', 'shortcuts', 'seven', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('25', 'system', 'powered-by', 'seven', '0', '10', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('26', 'system', 'navigation', 'seven', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('27', 'system', 'management', 'seven', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('28', 'system', 'user-menu', 'seven', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('29', 'system', 'main-menu', 'seven', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('30', 'user', 'online', 'seven', '1', '0', 'dashboard_inactive', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('31', 'HSSCore', 'admin-header', 'bartik', '1', '0', 'header', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('32', 'HSSCore', 'admin-left', 'bartik', '0', '0', '-1', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('33', 'HSSCore', 'admin-content', 'bartik', '1', '0', 'content', '0', '1', 'admincp', '<none>', '1');
INSERT INTO `block` VALUES ('34', 'HSSCore', 'admin-footer', 'bartik', '1', '0', 'footer', '0', '1', '', '', '1');
INSERT INTO `block` VALUES ('35', 'HSSCore', 'admin-header', 'seven', '0', '0', '-1', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('36', 'HSSCore', 'admin-left', 'seven', '0', '0', '-1', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('37', 'HSSCore', 'admin-content', 'seven', '1', '0', 'content', '0', '1', 'admincp', '<none>', '1');
INSERT INTO `block` VALUES ('38', 'HSSCore', 'admin-footer', 'seven', '0', '0', '-1', '0', '1', '', '', '1');
INSERT INTO `block` VALUES ('39', 'comment', 'recent', 'theme_default', '0', '0', '-1', '0', '0', '', '', '1');
INSERT INTO `block` VALUES ('40', 'HSSCore', 'admin-content', 'theme_default', '1', '0', 'content', '0', '1', 'admincp', '<none>', '1');
INSERT INTO `block` VALUES ('41', 'HSSCore', 'admin-footer', 'theme_default', '0', '0', '-1', '0', '1', '', '', '1');
INSERT INTO `block` VALUES ('42', 'HSSCore', 'admin-header', 'theme_default', '1', '0', 'header', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('43', 'HSSCore', 'admin-left', 'theme_default', '1', '0', 'left', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('44', 'node', 'recent', 'theme_default', '0', '0', '-1', '0', '0', '', '', '1');
INSERT INTO `block` VALUES ('45', 'node', 'syndicate', 'theme_default', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('46', 'search', 'form', 'theme_default', '0', '-1', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('47', 'shortcut', 'shortcuts', 'theme_default', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('48', 'system', 'help', 'theme_default', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('49', 'system', 'main', 'theme_default', '1', '0', 'content', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('50', 'system', 'main-menu', 'theme_default', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('51', 'system', 'management', 'theme_default', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('52', 'system', 'navigation', 'theme_default', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('53', 'system', 'powered-by', 'theme_default', '0', '10', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('54', 'system', 'user-menu', 'theme_default', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('55', 'user', 'login', 'theme_default', '1', '0', 'content', '0', '1', 'user', '<none>', '-1');
INSERT INTO `block` VALUES ('56', 'user', 'new', 'theme_default', '0', '0', '-1', '0', '0', '', '', '1');
INSERT INTO `block` VALUES ('57', 'user', 'online', 'theme_default', '0', '0', '-1', '0', '0', '', '', '-1');
INSERT INTO `block` VALUES ('58', 'Core', 'admin-header', 'bartik', '1', '0', 'header', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('59', 'Core', 'admin-left', 'bartik', '0', '0', '-1', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('60', 'Core', 'admin-content', 'bartik', '1', '0', 'content', '0', '1', 'admincp', '<none>', '1');
INSERT INTO `block` VALUES ('61', 'Core', 'admin-footer', 'bartik', '1', '0', 'footer', '0', '1', '', '', '1');
INSERT INTO `block` VALUES ('62', 'Core', 'admin-header', 'seven', '0', '0', '-1', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('63', 'Core', 'admin-left', 'seven', '0', '0', '-1', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('64', 'Core', 'admin-content', 'seven', '1', '0', 'content', '0', '1', 'admincp', '<none>', '1');
INSERT INTO `block` VALUES ('65', 'Core', 'admin-footer', 'seven', '0', '0', '-1', '0', '1', '', '', '1');
INSERT INTO `block` VALUES ('66', 'Core', 'admin-header', 'theme_default', '1', '0', 'header', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('67', 'Core', 'admin-left', 'theme_default', '1', '0', 'left', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('68', 'Core', 'admin-content', 'theme_default', '1', '0', 'content', '0', '1', 'admincp', '<none>', '1');
INSERT INTO `block` VALUES ('69', 'Core', 'admin-footer', 'theme_default', '0', '0', '-1', '0', '1', '', '', '1');
INSERT INTO `block` VALUES ('70', 'Site', 'block-header', 'bartik', '1', '0', 'header', '0', '0', 'admin\r\nadmin/*\r\nadmincp\r\nadmincp/*\r\ndang-san-pham.html\r\nquan-ly-gian-hang.html\r\nsua-thong-tin-gian-hang.html', '<none>', '1');
INSERT INTO `block` VALUES ('71', 'Site', 'block-slide', 'bartik', '1', '0', 'content', '0', '1', '<front>', '<none>', '1');
INSERT INTO `block` VALUES ('72', 'Site', 'block-content', 'bartik', '1', '0', 'content', '0', '1', '<front>', '<none>', '1');
INSERT INTO `block` VALUES ('73', 'Site', 'block-footer', 'bartik', '1', '0', 'footer', '0', '0', 'admin\r\nadmin/*\r\nadmincp\r\nadmincp/*\r\ndang-san-pham.html\r\nquan-ly-gian-hang.html', '<none>', '1');
INSERT INTO `block` VALUES ('74', 'Site', 'block-header', 'seven', '0', '0', '-1', '0', '0', 'admin\r\nadmin/*\r\nadmincp\r\nadmincp/*\r\ndang-san-pham.html\r\nquan-ly-gian-hang.html\r\nsua-thong-tin-gian-hang.html', '<none>', '1');
INSERT INTO `block` VALUES ('75', 'Site', 'block-slide', 'seven', '1', '0', 'content', '0', '1', '<front>', '<none>', '1');
INSERT INTO `block` VALUES ('76', 'Site', 'block-content', 'seven', '1', '0', 'content', '0', '1', '<front>', '<none>', '1');
INSERT INTO `block` VALUES ('77', 'Site', 'block-footer', 'seven', '0', '0', '-1', '0', '0', 'admin\r\nadmin/*\r\nadmincp\r\nadmincp/*\r\ndang-san-pham.html\r\nquan-ly-gian-hang.html', '<none>', '1');
INSERT INTO `block` VALUES ('78', 'Site', 'block-header', 'theme_default', '1', '0', 'header', '0', '0', 'admin\r\nadmin/*\r\nadmincp\r\nadmincp/*\r\ndang-san-pham.html\r\nquan-ly-gian-hang.html\r\nsua-thong-tin-gian-hang.html', '<none>', '1');
INSERT INTO `block` VALUES ('79', 'Site', 'block-slide', 'theme_default', '1', '0', 'content', '0', '1', '<front>', '<none>', '1');
INSERT INTO `block` VALUES ('80', 'Site', 'block-content', 'theme_default', '1', '0', 'content', '0', '1', '<front>', '<none>', '1');
INSERT INTO `block` VALUES ('81', 'Site', 'block-footer', 'theme_default', '1', '0', 'footer', '0', '0', 'admin\r\nadmin/*\r\nadmincp\r\nadmincp/*\r\ndang-san-pham.html\r\nquan-ly-gian-hang.html', '<none>', '1');
INSERT INTO `block` VALUES ('82', 'Admin', 'admin-header', 'bartik', '1', '0', 'header', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('83', 'Admin', 'admin-left', 'bartik', '0', '0', '-1', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('84', 'Admin', 'admin-content', 'bartik', '1', '0', 'content', '0', '1', 'admincp', '<none>', '1');
INSERT INTO `block` VALUES ('85', 'Admin', 'admin-footer', 'bartik', '1', '0', 'footer', '0', '1', '', '', '1');
INSERT INTO `block` VALUES ('86', 'Admin', 'admin-header', 'seven', '0', '0', '-1', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('87', 'Admin', 'admin-left', 'seven', '0', '0', '-1', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('88', 'Admin', 'admin-content', 'seven', '1', '0', 'content', '0', '1', 'admincp', '<none>', '1');
INSERT INTO `block` VALUES ('89', 'Admin', 'admin-footer', 'seven', '0', '0', '-1', '0', '1', '', '', '1');
INSERT INTO `block` VALUES ('90', 'Admin', 'admin-header', 'theme_default', '1', '0', 'header', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('91', 'Admin', 'admin-left', 'theme_default', '1', '0', 'left', '0', '1', 'admincp\r\nadmincp/*', '<none>', '1');
INSERT INTO `block` VALUES ('92', 'Admin', 'admin-content', 'theme_default', '1', '0', 'content', '0', '1', 'admincp', '<none>', '1');
INSERT INTO `block` VALUES ('93', 'Admin', 'admin-footer', 'theme_default', '1', '0', 'footer', '0', '1', '', '', '1');

-- ----------------------------
-- Table structure for block_custom
-- ----------------------------
DROP TABLE IF EXISTS `block_custom`;
CREATE TABLE `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';

-- ----------------------------
-- Records of block_custom
-- ----------------------------

-- ----------------------------
-- Table structure for block_node_type
-- ----------------------------
DROP TABLE IF EXISTS `block_node_type`;
CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';

-- ----------------------------
-- Records of block_node_type
-- ----------------------------

-- ----------------------------
-- Table structure for block_role
-- ----------------------------
DROP TABLE IF EXISTS `block_role`;
CREATE TABLE `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) unsigned NOT NULL COMMENT 'The user’s role ID from users_roles.rid.',
  PRIMARY KEY (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';

-- ----------------------------
-- Records of block_role
-- ----------------------------

-- ----------------------------
-- Table structure for blocked_ips
-- ----------------------------
DROP TABLE IF EXISTS `blocked_ips`;
CREATE TABLE `blocked_ips` (
  `iid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address',
  PRIMARY KEY (`iid`),
  KEY `blocked_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';

-- ----------------------------
-- Records of blocked_ips
-- ----------------------------

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';

-- ----------------------------
-- Records of cache
-- ----------------------------

-- ----------------------------
-- Table structure for cache_block
-- ----------------------------
DROP TABLE IF EXISTS `cache_block`;
CREATE TABLE `cache_block` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';

-- ----------------------------
-- Records of cache_block
-- ----------------------------

-- ----------------------------
-- Table structure for cache_bootstrap
-- ----------------------------
DROP TABLE IF EXISTS `cache_bootstrap`;
CREATE TABLE `cache_bootstrap` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';

-- ----------------------------
-- Records of cache_bootstrap
-- ----------------------------

-- ----------------------------
-- Table structure for cache_field
-- ----------------------------
DROP TABLE IF EXISTS `cache_field`;
CREATE TABLE `cache_field` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Field module to store already built...';

-- ----------------------------
-- Records of cache_field
-- ----------------------------

-- ----------------------------
-- Table structure for cache_filter
-- ----------------------------
DROP TABLE IF EXISTS `cache_filter`;
CREATE TABLE `cache_filter` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';

-- ----------------------------
-- Records of cache_filter
-- ----------------------------

-- ----------------------------
-- Table structure for cache_form
-- ----------------------------
DROP TABLE IF EXISTS `cache_form`;
CREATE TABLE `cache_form` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';

-- ----------------------------
-- Records of cache_form
-- ----------------------------

-- ----------------------------
-- Table structure for cache_image
-- ----------------------------
DROP TABLE IF EXISTS `cache_image`;
CREATE TABLE `cache_image` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';

-- ----------------------------
-- Records of cache_image
-- ----------------------------

-- ----------------------------
-- Table structure for cache_menu
-- ----------------------------
DROP TABLE IF EXISTS `cache_menu`;
CREATE TABLE `cache_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';

-- ----------------------------
-- Records of cache_menu
-- ----------------------------

-- ----------------------------
-- Table structure for cache_page
-- ----------------------------
DROP TABLE IF EXISTS `cache_page`;
CREATE TABLE `cache_page` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';

-- ----------------------------
-- Records of cache_page
-- ----------------------------

-- ----------------------------
-- Table structure for cache_path
-- ----------------------------
DROP TABLE IF EXISTS `cache_path`;
CREATE TABLE `cache_path` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';

-- ----------------------------
-- Records of cache_path
-- ----------------------------

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique comment ID.',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid to which this comment is a reply.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.',
  `subject` varchar(64) NOT NULL DEFAULT '' COMMENT 'The comment title.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The author’s host name.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was last edited, as a Unix timestamp.',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The published status of a comment. (0 = Not Published, 1 = Published)',
  `thread` varchar(255) NOT NULL COMMENT 'The vancode representation of the comment’s place in a thread.',
  `name` varchar(60) DEFAULT NULL COMMENT 'The comment author’s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.',
  `mail` varchar(64) DEFAULT NULL COMMENT 'The comment author’s e-mail address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `homepage` varchar(255) DEFAULT NULL COMMENT 'The comment author’s home page address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this comment.',
  PRIMARY KEY (`cid`),
  KEY `comment_status_pid` (`pid`,`status`),
  KEY `comment_num_new` (`nid`,`status`,`created`,`cid`,`thread`),
  KEY `comment_uid` (`uid`),
  KEY `comment_nid_language` (`nid`,`language`),
  KEY `comment_created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores comments and associated data.';

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for date_format_locale
-- ----------------------------
DROP TABLE IF EXISTS `date_format_locale`;
CREATE TABLE `date_format_locale` (
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A languages.language for this format to be used with.',
  PRIMARY KEY (`type`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';

-- ----------------------------
-- Records of date_format_locale
-- ----------------------------

-- ----------------------------
-- Table structure for date_format_type
-- ----------------------------
DROP TABLE IF EXISTS `date_format_type`;
CREATE TABLE `date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this is a system provided format.',
  PRIMARY KEY (`type`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';

-- ----------------------------
-- Records of date_format_type
-- ----------------------------
INSERT INTO `date_format_type` VALUES ('long', 'Long', '1');
INSERT INTO `date_format_type` VALUES ('medium', 'Medium', '1');
INSERT INTO `date_format_type` VALUES ('short', 'Short', '1');

-- ----------------------------
-- Table structure for date_formats
-- ----------------------------
DROP TABLE IF EXISTS `date_formats`;
CREATE TABLE `date_formats` (
  `dfid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.',
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this format can be modified.',
  PRIMARY KEY (`dfid`),
  UNIQUE KEY `formats` (`format`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.';

-- ----------------------------
-- Records of date_formats
-- ----------------------------
INSERT INTO `date_formats` VALUES ('1', 'Y-m-d H:i', 'short', '1');
INSERT INTO `date_formats` VALUES ('2', 'm/d/Y - H:i', 'short', '1');
INSERT INTO `date_formats` VALUES ('3', 'd/m/Y - H:i', 'short', '1');
INSERT INTO `date_formats` VALUES ('4', 'Y/m/d - H:i', 'short', '1');
INSERT INTO `date_formats` VALUES ('5', 'd.m.Y - H:i', 'short', '1');
INSERT INTO `date_formats` VALUES ('6', 'm/d/Y - g:ia', 'short', '1');
INSERT INTO `date_formats` VALUES ('7', 'd/m/Y - g:ia', 'short', '1');
INSERT INTO `date_formats` VALUES ('8', 'Y/m/d - g:ia', 'short', '1');
INSERT INTO `date_formats` VALUES ('9', 'M j Y - H:i', 'short', '1');
INSERT INTO `date_formats` VALUES ('10', 'j M Y - H:i', 'short', '1');
INSERT INTO `date_formats` VALUES ('11', 'Y M j - H:i', 'short', '1');
INSERT INTO `date_formats` VALUES ('12', 'M j Y - g:ia', 'short', '1');
INSERT INTO `date_formats` VALUES ('13', 'j M Y - g:ia', 'short', '1');
INSERT INTO `date_formats` VALUES ('14', 'Y M j - g:ia', 'short', '1');
INSERT INTO `date_formats` VALUES ('15', 'D, Y-m-d H:i', 'medium', '1');
INSERT INTO `date_formats` VALUES ('16', 'D, m/d/Y - H:i', 'medium', '1');
INSERT INTO `date_formats` VALUES ('17', 'D, d/m/Y - H:i', 'medium', '1');
INSERT INTO `date_formats` VALUES ('18', 'D, Y/m/d - H:i', 'medium', '1');
INSERT INTO `date_formats` VALUES ('19', 'F j, Y - H:i', 'medium', '1');
INSERT INTO `date_formats` VALUES ('20', 'j F, Y - H:i', 'medium', '1');
INSERT INTO `date_formats` VALUES ('21', 'Y, F j - H:i', 'medium', '1');
INSERT INTO `date_formats` VALUES ('22', 'D, m/d/Y - g:ia', 'medium', '1');
INSERT INTO `date_formats` VALUES ('23', 'D, d/m/Y - g:ia', 'medium', '1');
INSERT INTO `date_formats` VALUES ('24', 'D, Y/m/d - g:ia', 'medium', '1');
INSERT INTO `date_formats` VALUES ('25', 'F j, Y - g:ia', 'medium', '1');
INSERT INTO `date_formats` VALUES ('26', 'j F Y - g:ia', 'medium', '1');
INSERT INTO `date_formats` VALUES ('27', 'Y, F j - g:ia', 'medium', '1');
INSERT INTO `date_formats` VALUES ('28', 'j. F Y - G:i', 'medium', '1');
INSERT INTO `date_formats` VALUES ('29', 'l, F j, Y - H:i', 'long', '1');
INSERT INTO `date_formats` VALUES ('30', 'l, j F, Y - H:i', 'long', '1');
INSERT INTO `date_formats` VALUES ('31', 'l, Y,  F j - H:i', 'long', '1');
INSERT INTO `date_formats` VALUES ('32', 'l, F j, Y - g:ia', 'long', '1');
INSERT INTO `date_formats` VALUES ('33', 'l, j F Y - g:ia', 'long', '1');
INSERT INTO `date_formats` VALUES ('34', 'l, Y,  F j - g:ia', 'long', '1');
INSERT INTO `date_formats` VALUES ('35', 'l, j. F Y - G:i', 'long', '1');

-- ----------------------------
-- Table structure for field_config
-- ----------------------------
DROP TABLE IF EXISTS `field_config`;
CREATE TABLE `field_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name` (`field_name`),
  KEY `active` (`active`),
  KEY `storage_active` (`storage_active`),
  KEY `deleted` (`deleted`),
  KEY `module` (`module`),
  KEY `storage_module` (`storage_module`),
  KEY `type` (`type`),
  KEY `storage_type` (`storage_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of field_config
-- ----------------------------
INSERT INTO `field_config` VALUES ('1', 'comment_body', 'text_long', 'text', '1', 'field_sql_storage', 'field_sql_storage', '1', '0', 0x613A363A7B733A31323A22656E746974795F7479706573223B613A313A7B693A303B733A373A22636F6D6D656E74223B7D733A31323A227472616E736C617461626C65223B623A303B733A383A2273657474696E6773223B613A303A7B7D733A373A2273746F72616765223B613A343A7B733A343A2274797065223B733A31373A226669656C645F73716C5F73746F72616765223B733A383A2273657474696E6773223B613A303A7B7D733A363A226D6F64756C65223B733A31373A226669656C645F73716C5F73746F72616765223B733A363A22616374697665223B693A313B7D733A31323A22666F726569676E206B657973223B613A313A7B733A363A22666F726D6174223B613A323A7B733A353A227461626C65223B733A31333A2266696C7465725F666F726D6174223B733A373A22636F6C756D6E73223B613A313A7B733A363A22666F726D6174223B733A363A22666F726D6174223B7D7D7D733A373A22696E6465786573223B613A313A7B733A363A22666F726D6174223B613A313A7B693A303B733A363A22666F726D6174223B7D7D7D, '1', '0', '0');
INSERT INTO `field_config` VALUES ('2', 'body', 'text_with_summary', 'text', '1', 'field_sql_storage', 'field_sql_storage', '1', '0', 0x613A363A7B733A31323A22656E746974795F7479706573223B613A313A7B693A303B733A343A226E6F6465223B7D733A31323A227472616E736C617461626C65223B623A303B733A383A2273657474696E6773223B613A303A7B7D733A373A2273746F72616765223B613A343A7B733A343A2274797065223B733A31373A226669656C645F73716C5F73746F72616765223B733A383A2273657474696E6773223B613A303A7B7D733A363A226D6F64756C65223B733A31373A226669656C645F73716C5F73746F72616765223B733A363A22616374697665223B693A313B7D733A31323A22666F726569676E206B657973223B613A313A7B733A363A22666F726D6174223B613A323A7B733A353A227461626C65223B733A31333A2266696C7465725F666F726D6174223B733A373A22636F6C756D6E73223B613A313A7B733A363A22666F726D6174223B733A363A22666F726D6174223B7D7D7D733A373A22696E6465786573223B613A313A7B733A363A22666F726D6174223B613A313A7B693A303B733A363A22666F726D6174223B7D7D7D, '1', '0', '0');
INSERT INTO `field_config` VALUES ('3', 'field_tags', 'taxonomy_term_reference', 'taxonomy', '1', 'field_sql_storage', 'field_sql_storage', '1', '0', 0x613A363A7B733A383A2273657474696E6773223B613A313A7B733A31343A22616C6C6F7765645F76616C756573223B613A313A7B693A303B613A323A7B733A31303A22766F636162756C617279223B733A343A2274616773223B733A363A22706172656E74223B693A303B7D7D7D733A31323A22656E746974795F7479706573223B613A303A7B7D733A31323A227472616E736C617461626C65223B623A303B733A373A2273746F72616765223B613A343A7B733A343A2274797065223B733A31373A226669656C645F73716C5F73746F72616765223B733A383A2273657474696E6773223B613A303A7B7D733A363A226D6F64756C65223B733A31373A226669656C645F73716C5F73746F72616765223B733A363A22616374697665223B693A313B7D733A31323A22666F726569676E206B657973223B613A313A7B733A333A22746964223B613A323A7B733A353A227461626C65223B733A31383A227461786F6E6F6D795F7465726D5F64617461223B733A373A22636F6C756D6E73223B613A313A7B733A333A22746964223B733A333A22746964223B7D7D7D733A373A22696E6465786573223B613A313A7B733A333A22746964223B613A313A7B693A303B733A333A22746964223B7D7D7D, '-1', '0', '0');
INSERT INTO `field_config` VALUES ('4', 'field_image', 'image', 'image', '1', 'field_sql_storage', 'field_sql_storage', '1', '0', 0x613A363A7B733A373A22696E6465786573223B613A313A7B733A333A22666964223B613A313A7B693A303B733A333A22666964223B7D7D733A383A2273657474696E6773223B613A323A7B733A31303A227572695F736368656D65223B733A363A227075626C6963223B733A31333A2264656661756C745F696D616765223B623A303B7D733A373A2273746F72616765223B613A343A7B733A343A2274797065223B733A31373A226669656C645F73716C5F73746F72616765223B733A383A2273657474696E6773223B613A303A7B7D733A363A226D6F64756C65223B733A31373A226669656C645F73716C5F73746F72616765223B733A363A22616374697665223B693A313B7D733A31323A22656E746974795F7479706573223B613A303A7B7D733A31323A227472616E736C617461626C65223B623A303B733A31323A22666F726569676E206B657973223B613A313A7B733A333A22666964223B613A323A7B733A353A227461626C65223B733A31323A2266696C655F6D616E61676564223B733A373A22636F6C756D6E73223B613A313A7B733A333A22666964223B733A333A22666964223B7D7D7D7D, '1', '0', '0');

-- ----------------------------
-- Table structure for field_config_instance
-- ----------------------------
DROP TABLE IF EXISTS `field_config_instance`;
CREATE TABLE `field_config_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of field_config_instance
-- ----------------------------
INSERT INTO `field_config_instance` VALUES ('1', '1', 'comment_body', 'comment', 'comment_node_page', 0x613A363A7B733A353A226C6162656C223B733A373A22436F6D6D656E74223B733A383A2273657474696E6773223B613A323A7B733A31353A22746578745F70726F63657373696E67223B693A313B733A31383A22757365725F72656769737465725F666F726D223B623A303B7D733A383A227265717569726564223B623A313B733A373A22646973706C6179223B613A313A7B733A373A2264656661756C74223B613A353A7B733A353A226C6162656C223B733A363A2268696464656E223B733A343A2274797065223B733A31323A22746578745F64656661756C74223B733A363A22776569676874223B693A303B733A383A2273657474696E6773223B613A303A7B7D733A363A226D6F64756C65223B733A343A2274657874223B7D7D733A363A22776964676574223B613A343A7B733A343A2274797065223B733A31333A22746578745F7465787461726561223B733A383A2273657474696E6773223B613A313A7B733A343A22726F7773223B693A353B7D733A363A22776569676874223B693A303B733A363A226D6F64756C65223B733A343A2274657874223B7D733A31313A226465736372697074696F6E223B733A303A22223B7D, '0');
INSERT INTO `field_config_instance` VALUES ('2', '2', 'body', 'node', 'page', 0x613A363A7B733A353A226C6162656C223B733A343A22426F6479223B733A363A22776964676574223B613A343A7B733A343A2274797065223B733A32363A22746578745F74657874617265615F776974685F73756D6D617279223B733A383A2273657474696E6773223B613A323A7B733A343A22726F7773223B693A32303B733A31323A2273756D6D6172795F726F7773223B693A353B7D733A363A22776569676874223B693A2D343B733A363A226D6F64756C65223B733A343A2274657874223B7D733A383A2273657474696E6773223B613A333A7B733A31353A22646973706C61795F73756D6D617279223B623A313B733A31353A22746578745F70726F63657373696E67223B693A313B733A31383A22757365725F72656769737465725F666F726D223B623A303B7D733A373A22646973706C6179223B613A323A7B733A373A2264656661756C74223B613A353A7B733A353A226C6162656C223B733A363A2268696464656E223B733A343A2274797065223B733A31323A22746578745F64656661756C74223B733A383A2273657474696E6773223B613A303A7B7D733A363A226D6F64756C65223B733A343A2274657874223B733A363A22776569676874223B693A303B7D733A363A22746561736572223B613A353A7B733A353A226C6162656C223B733A363A2268696464656E223B733A343A2274797065223B733A32333A22746578745F73756D6D6172795F6F725F7472696D6D6564223B733A383A2273657474696E6773223B613A313A7B733A31313A227472696D5F6C656E677468223B693A3630303B7D733A363A226D6F64756C65223B733A343A2274657874223B733A363A22776569676874223B693A303B7D7D733A383A227265717569726564223B623A303B733A31313A226465736372697074696F6E223B733A303A22223B7D, '0');
INSERT INTO `field_config_instance` VALUES ('3', '1', 'comment_body', 'comment', 'comment_node_article', 0x613A363A7B733A353A226C6162656C223B733A373A22436F6D6D656E74223B733A383A2273657474696E6773223B613A323A7B733A31353A22746578745F70726F63657373696E67223B693A313B733A31383A22757365725F72656769737465725F666F726D223B623A303B7D733A383A227265717569726564223B623A313B733A373A22646973706C6179223B613A313A7B733A373A2264656661756C74223B613A353A7B733A353A226C6162656C223B733A363A2268696464656E223B733A343A2274797065223B733A31323A22746578745F64656661756C74223B733A363A22776569676874223B693A303B733A383A2273657474696E6773223B613A303A7B7D733A363A226D6F64756C65223B733A343A2274657874223B7D7D733A363A22776964676574223B613A343A7B733A343A2274797065223B733A31333A22746578745F7465787461726561223B733A383A2273657474696E6773223B613A313A7B733A343A22726F7773223B693A353B7D733A363A22776569676874223B693A303B733A363A226D6F64756C65223B733A343A2274657874223B7D733A31313A226465736372697074696F6E223B733A303A22223B7D, '0');
INSERT INTO `field_config_instance` VALUES ('4', '2', 'body', 'node', 'article', 0x613A363A7B733A353A226C6162656C223B733A343A22426F6479223B733A363A22776964676574223B613A343A7B733A343A2274797065223B733A32363A22746578745F74657874617265615F776974685F73756D6D617279223B733A383A2273657474696E6773223B613A323A7B733A343A22726F7773223B693A32303B733A31323A2273756D6D6172795F726F7773223B693A353B7D733A363A22776569676874223B693A2D343B733A363A226D6F64756C65223B733A343A2274657874223B7D733A383A2273657474696E6773223B613A333A7B733A31353A22646973706C61795F73756D6D617279223B623A313B733A31353A22746578745F70726F63657373696E67223B693A313B733A31383A22757365725F72656769737465725F666F726D223B623A303B7D733A373A22646973706C6179223B613A323A7B733A373A2264656661756C74223B613A353A7B733A353A226C6162656C223B733A363A2268696464656E223B733A343A2274797065223B733A31323A22746578745F64656661756C74223B733A383A2273657474696E6773223B613A303A7B7D733A363A226D6F64756C65223B733A343A2274657874223B733A363A22776569676874223B693A303B7D733A363A22746561736572223B613A353A7B733A353A226C6162656C223B733A363A2268696464656E223B733A343A2274797065223B733A32333A22746578745F73756D6D6172795F6F725F7472696D6D6564223B733A383A2273657474696E6773223B613A313A7B733A31313A227472696D5F6C656E677468223B693A3630303B7D733A363A226D6F64756C65223B733A343A2274657874223B733A363A22776569676874223B693A303B7D7D733A383A227265717569726564223B623A303B733A31313A226465736372697074696F6E223B733A303A22223B7D, '0');
INSERT INTO `field_config_instance` VALUES ('5', '3', 'field_tags', 'node', 'article', 0x613A363A7B733A353A226C6162656C223B733A343A2254616773223B733A31313A226465736372697074696F6E223B733A36333A22456E746572206120636F6D6D612D736570617261746564206C697374206F6620776F72647320746F20646573637269626520796F757220636F6E74656E742E223B733A363A22776964676574223B613A343A7B733A343A2274797065223B733A32313A227461786F6E6F6D795F6175746F636F6D706C657465223B733A363A22776569676874223B693A2D343B733A383A2273657474696E6773223B613A323A7B733A343A2273697A65223B693A36303B733A31373A226175746F636F6D706C6574655F70617468223B733A32313A227461786F6E6F6D792F6175746F636F6D706C657465223B7D733A363A226D6F64756C65223B733A383A227461786F6E6F6D79223B7D733A373A22646973706C6179223B613A323A7B733A373A2264656661756C74223B613A353A7B733A343A2274797065223B733A32383A227461786F6E6F6D795F7465726D5F7265666572656E63655F6C696E6B223B733A363A22776569676874223B693A31303B733A353A226C6162656C223B733A353A2261626F7665223B733A383A2273657474696E6773223B613A303A7B7D733A363A226D6F64756C65223B733A383A227461786F6E6F6D79223B7D733A363A22746561736572223B613A353A7B733A343A2274797065223B733A32383A227461786F6E6F6D795F7465726D5F7265666572656E63655F6C696E6B223B733A363A22776569676874223B693A31303B733A353A226C6162656C223B733A353A2261626F7665223B733A383A2273657474696E6773223B613A303A7B7D733A363A226D6F64756C65223B733A383A227461786F6E6F6D79223B7D7D733A383A2273657474696E6773223B613A313A7B733A31383A22757365725F72656769737465725F666F726D223B623A303B7D733A383A227265717569726564223B623A303B7D, '0');
INSERT INTO `field_config_instance` VALUES ('6', '4', 'field_image', 'node', 'article', 0x613A363A7B733A353A226C6162656C223B733A353A22496D616765223B733A31313A226465736372697074696F6E223B733A34303A2255706C6F616420616E20696D61676520746F20676F207769746820746869732061727469636C652E223B733A383A227265717569726564223B623A303B733A383A2273657474696E6773223B613A393A7B733A31343A2266696C655F6469726563746F7279223B733A31313A226669656C642F696D616765223B733A31353A2266696C655F657874656E73696F6E73223B733A31363A22706E6720676966206A7067206A706567223B733A31323A226D61785F66696C6573697A65223B733A303A22223B733A31343A226D61785F7265736F6C7574696F6E223B733A303A22223B733A31343A226D696E5F7265736F6C7574696F6E223B733A303A22223B733A393A22616C745F6669656C64223B623A313B733A31313A227469746C655F6669656C64223B733A303A22223B733A31333A2264656661756C745F696D616765223B693A303B733A31383A22757365725F72656769737465725F666F726D223B623A303B7D733A363A22776964676574223B613A343A7B733A343A2274797065223B733A31313A22696D6167655F696D616765223B733A383A2273657474696E6773223B613A323A7B733A31383A2270726F67726573735F696E64696361746F72223B733A383A227468726F62626572223B733A31393A22707265766965775F696D6167655F7374796C65223B733A393A227468756D626E61696C223B7D733A363A22776569676874223B693A2D313B733A363A226D6F64756C65223B733A353A22696D616765223B7D733A373A22646973706C6179223B613A323A7B733A373A2264656661756C74223B613A353A7B733A353A226C6162656C223B733A363A2268696464656E223B733A343A2274797065223B733A353A22696D616765223B733A383A2273657474696E6773223B613A323A7B733A31313A22696D6167655F7374796C65223B733A353A226C61726765223B733A31303A22696D6167655F6C696E6B223B733A303A22223B7D733A363A22776569676874223B693A2D313B733A363A226D6F64756C65223B733A353A22696D616765223B7D733A363A22746561736572223B613A353A7B733A353A226C6162656C223B733A363A2268696464656E223B733A343A2274797065223B733A353A22696D616765223B733A383A2273657474696E6773223B613A323A7B733A31313A22696D6167655F7374796C65223B733A363A226D656469756D223B733A31303A22696D6167655F6C696E6B223B733A373A22636F6E74656E74223B7D733A363A22776569676874223B693A2D313B733A363A226D6F64756C65223B733A353A22696D616765223B7D7D7D, '0');

-- ----------------------------
-- Table structure for field_data_body
-- ----------------------------
DROP TABLE IF EXISTS `field_data_body`;
CREATE TABLE `field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (body)';

-- ----------------------------
-- Records of field_data_body
-- ----------------------------

-- ----------------------------
-- Table structure for field_data_comment_body
-- ----------------------------
DROP TABLE IF EXISTS `field_data_comment_body`;
CREATE TABLE `field_data_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (comment_body)';

-- ----------------------------
-- Records of field_data_comment_body
-- ----------------------------

-- ----------------------------
-- Table structure for field_data_field_image
-- ----------------------------
DROP TABLE IF EXISTS `field_data_field_image`;
CREATE TABLE `field_data_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_image)';

-- ----------------------------
-- Records of field_data_field_image
-- ----------------------------

-- ----------------------------
-- Table structure for field_data_field_tags
-- ----------------------------
DROP TABLE IF EXISTS `field_data_field_tags`;
CREATE TABLE `field_data_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 3 (field_tags)';

-- ----------------------------
-- Records of field_data_field_tags
-- ----------------------------

-- ----------------------------
-- Table structure for field_revision_body
-- ----------------------------
DROP TABLE IF EXISTS `field_revision_body`;
CREATE TABLE `field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (body)';

-- ----------------------------
-- Records of field_revision_body
-- ----------------------------

-- ----------------------------
-- Table structure for field_revision_comment_body
-- ----------------------------
DROP TABLE IF EXISTS `field_revision_comment_body`;
CREATE TABLE `field_revision_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (comment_body)';

-- ----------------------------
-- Records of field_revision_comment_body
-- ----------------------------

-- ----------------------------
-- Table structure for field_revision_field_image
-- ----------------------------
DROP TABLE IF EXISTS `field_revision_field_image`;
CREATE TABLE `field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_image)';

-- ----------------------------
-- Records of field_revision_field_image
-- ----------------------------

-- ----------------------------
-- Table structure for field_revision_field_tags
-- ----------------------------
DROP TABLE IF EXISTS `field_revision_field_tags`;
CREATE TABLE `field_revision_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 3 (field_tags)';

-- ----------------------------
-- Records of field_revision_field_tags
-- ----------------------------

-- ----------------------------
-- Table structure for file_managed
-- ----------------------------
DROP TABLE IF EXISTS `file_managed`;
CREATE TABLE `file_managed` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.',
  PRIMARY KEY (`fid`),
  UNIQUE KEY `uri` (`uri`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';

-- ----------------------------
-- Records of file_managed
-- ----------------------------

-- ----------------------------
-- Table structure for file_usage
-- ----------------------------
DROP TABLE IF EXISTS `file_usage`;
CREATE TABLE `file_usage` (
  `fid` int(10) unsigned NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.',
  PRIMARY KEY (`fid`,`type`,`id`,`module`),
  KEY `type_id` (`type`,`id`),
  KEY `fid_count` (`fid`,`count`),
  KEY `fid_module` (`fid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';

-- ----------------------------
-- Records of file_usage
-- ----------------------------

-- ----------------------------
-- Table structure for filter
-- ----------------------------
DROP TABLE IF EXISTS `filter`;
CREATE TABLE `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';

-- ----------------------------
-- Records of filter
-- ----------------------------
INSERT INTO `filter` VALUES ('filtered_html', 'filter', 'filter_autop', '2', '1', 0x613A303A7B7D);
INSERT INTO `filter` VALUES ('filtered_html', 'filter', 'filter_html', '1', '1', 0x613A333A7B733A31323A22616C6C6F7765645F68746D6C223B733A37343A223C613E203C656D3E203C7374726F6E673E203C636974653E203C626C6F636B71756F74653E203C636F64653E203C756C3E203C6F6C3E203C6C693E203C646C3E203C64743E203C64643E223B733A31363A2266696C7465725F68746D6C5F68656C70223B693A313B733A32303A2266696C7465725F68746D6C5F6E6F666F6C6C6F77223B693A303B7D);
INSERT INTO `filter` VALUES ('filtered_html', 'filter', 'filter_htmlcorrector', '10', '1', 0x613A303A7B7D);
INSERT INTO `filter` VALUES ('filtered_html', 'filter', 'filter_html_escape', '-10', '0', 0x613A303A7B7D);
INSERT INTO `filter` VALUES ('filtered_html', 'filter', 'filter_url', '0', '1', 0x613A313A7B733A31373A2266696C7465725F75726C5F6C656E677468223B693A37323B7D);
INSERT INTO `filter` VALUES ('full_html', 'filter', 'filter_autop', '1', '1', 0x613A303A7B7D);
INSERT INTO `filter` VALUES ('full_html', 'filter', 'filter_html', '-10', '0', 0x613A333A7B733A31323A22616C6C6F7765645F68746D6C223B733A37343A223C613E203C656D3E203C7374726F6E673E203C636974653E203C626C6F636B71756F74653E203C636F64653E203C756C3E203C6F6C3E203C6C693E203C646C3E203C64743E203C64643E223B733A31363A2266696C7465725F68746D6C5F68656C70223B693A313B733A32303A2266696C7465725F68746D6C5F6E6F666F6C6C6F77223B693A303B7D);
INSERT INTO `filter` VALUES ('full_html', 'filter', 'filter_htmlcorrector', '10', '1', 0x613A303A7B7D);
INSERT INTO `filter` VALUES ('full_html', 'filter', 'filter_html_escape', '-10', '0', 0x613A303A7B7D);
INSERT INTO `filter` VALUES ('full_html', 'filter', 'filter_url', '0', '1', 0x613A313A7B733A31373A2266696C7465725F75726C5F6C656E677468223B693A37323B7D);
INSERT INTO `filter` VALUES ('plain_text', 'filter', 'filter_autop', '2', '1', 0x613A303A7B7D);
INSERT INTO `filter` VALUES ('plain_text', 'filter', 'filter_html', '-10', '0', 0x613A333A7B733A31323A22616C6C6F7765645F68746D6C223B733A37343A223C613E203C656D3E203C7374726F6E673E203C636974653E203C626C6F636B71756F74653E203C636F64653E203C756C3E203C6F6C3E203C6C693E203C646C3E203C64743E203C64643E223B733A31363A2266696C7465725F68746D6C5F68656C70223B693A313B733A32303A2266696C7465725F68746D6C5F6E6F666F6C6C6F77223B693A303B7D);
INSERT INTO `filter` VALUES ('plain_text', 'filter', 'filter_htmlcorrector', '10', '0', 0x613A303A7B7D);
INSERT INTO `filter` VALUES ('plain_text', 'filter', 'filter_html_escape', '0', '1', 0x613A303A7B7D);
INSERT INTO `filter` VALUES ('plain_text', 'filter', 'filter_url', '1', '1', 0x613A313A7B733A31373A2266696C7465725F75726C5F6C656E677468223B693A37323B7D);

-- ----------------------------
-- Table structure for filter_format
-- ----------------------------
DROP TABLE IF EXISTS `filter_format`;
CREATE TABLE `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';

-- ----------------------------
-- Records of filter_format
-- ----------------------------
INSERT INTO `filter_format` VALUES ('filtered_html', 'Filtered HTML', '1', '1', '0');
INSERT INTO `filter_format` VALUES ('full_html', 'Full HTML', '1', '1', '1');
INSERT INTO `filter_format` VALUES ('plain_text', 'Plain text', '1', '1', '10');

-- ----------------------------
-- Table structure for flood
-- ----------------------------
DROP TABLE IF EXISTS `flood`;
CREATE TABLE `flood` (
  `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.',
  PRIMARY KEY (`fid`),
  KEY `allow` (`event`,`identifier`,`timestamp`),
  KEY `purge` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...';

-- ----------------------------
-- Records of flood
-- ----------------------------

-- ----------------------------
-- Table structure for history
-- ----------------------------
DROP TABLE IF EXISTS `history`;
CREATE TABLE `history` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that read the node nid.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.',
  PRIMARY KEY (`uid`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which users have read which nodes.';

-- ----------------------------
-- Records of history
-- ----------------------------

-- ----------------------------
-- Table structure for image_effects
-- ----------------------------
DROP TABLE IF EXISTS `image_effects`;
CREATE TABLE `image_effects` (
  `ieid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';

-- ----------------------------
-- Records of image_effects
-- ----------------------------

-- ----------------------------
-- Table structure for image_styles
-- ----------------------------
DROP TABLE IF EXISTS `image_styles`;
CREATE TABLE `image_styles` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style machine name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';

-- ----------------------------
-- Records of image_styles
-- ----------------------------

-- ----------------------------
-- Table structure for menu_custom
-- ----------------------------
DROP TABLE IF EXISTS `menu_custom`;
CREATE TABLE `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';

-- ----------------------------
-- Records of menu_custom
-- ----------------------------
INSERT INTO `menu_custom` VALUES ('main-menu', 'Main menu', 'The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.');
INSERT INTO `menu_custom` VALUES ('management', 'Management', 'The <em>Management</em> menu contains links for administrative tasks.');
INSERT INTO `menu_custom` VALUES ('navigation', 'Navigation', 'The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.');
INSERT INTO `menu_custom` VALUES ('user-menu', 'User menu', 'The <em>User</em> menu contains links related to the user\'s account, as well as the \'Log out\' link.');

-- ----------------------------
-- Table structure for menu_links
-- ----------------------------
DROP TABLE IF EXISTS `menu_links`;
CREATE TABLE `menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.',
  PRIMARY KEY (`mlid`),
  KEY `path_menu` (`link_path`(128),`menu_name`),
  KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  KEY `router_path` (`router_path`(128))
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';

-- ----------------------------
-- Records of menu_links
-- ----------------------------
INSERT INTO `menu_links` VALUES ('management', '1', '0', 'admin', 'admin', 'Administration', 0x613A303A7B7D, 'system', '0', '0', '1', '0', '9', '1', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('user-menu', '2', '0', 'user', 'user', 'User account', 0x613A313A7B733A353A22616C746572223B623A313B7D, 'system', '0', '0', '0', '0', '-10', '1', '0', '2', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '3', '0', 'comment/%', 'comment/%', 'Comment permalink', 0x613A303A7B7D, 'system', '0', '0', '1', '0', '0', '1', '0', '3', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '4', '0', 'filter/tips', 'filter/tips', 'Compose tips', 0x613A303A7B7D, 'system', '1', '0', '1', '0', '0', '1', '0', '4', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '5', '0', 'node/%', 'node/%', '', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '1', '0', '5', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '6', '0', 'node/add', 'node/add', 'Add content', 0x613A303A7B7D, 'system', '0', '0', '1', '0', '0', '1', '0', '6', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '7', '1', 'admin/appearance', 'admin/appearance', 'Appearance', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33333A2253656C65637420616E6420636F6E66696775726520796F7572207468656D65732E223B7D7D, 'system', '0', '0', '0', '0', '-6', '2', '0', '1', '7', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '8', '1', 'admin/config', 'admin/config', 'Configuration', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A32303A2241646D696E69737465722073657474696E67732E223B7D7D, 'system', '0', '0', '1', '0', '0', '2', '0', '1', '8', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '9', '1', 'admin/content', 'admin/content', 'Content', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33323A2241646D696E697374657220636F6E74656E7420616E6420636F6D6D656E74732E223B7D7D, 'system', '0', '0', '1', '0', '-10', '2', '0', '1', '9', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('user-menu', '10', '2', 'user/register', 'user/register', 'Create new account', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '2', '0', '2', '10', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '11', '1', 'admin/dashboard', 'admin/dashboard', 'Dashboard', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33343A225669657720616E6420637573746F6D697A6520796F75722064617368626F6172642E223B7D7D, 'system', '0', '0', '0', '0', '-15', '2', '0', '1', '11', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '12', '1', 'admin/help', 'admin/help', 'Help', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34383A225265666572656E636520666F722075736167652C20636F6E66696775726174696F6E2C20616E64206D6F64756C65732E223B7D7D, 'system', '0', '0', '0', '0', '9', '2', '0', '1', '12', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '13', '1', 'admin/index', 'admin/index', 'Index', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-18', '2', '0', '1', '13', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('user-menu', '14', '2', 'user/login', 'user/login', 'Log in', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '2', '0', '2', '14', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('user-menu', '15', '0', 'user/logout', 'user/logout', 'Log out', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '10', '1', '0', '15', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '16', '1', 'admin/modules', 'admin/modules', 'Modules', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A32363A22457874656E6420736974652066756E6374696F6E616C6974792E223B7D7D, 'system', '0', '0', '0', '0', '-2', '2', '0', '1', '16', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '17', '0', 'user/%', 'user/%', 'My account', 0x613A303A7B7D, 'system', '0', '0', '1', '0', '0', '1', '0', '17', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '18', '1', 'admin/people', 'admin/people', 'People', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34353A224D616E6167652075736572206163636F756E74732C20726F6C65732C20616E64207065726D697373696F6E732E223B7D7D, 'system', '0', '0', '0', '0', '-4', '2', '0', '1', '18', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '19', '1', 'admin/reports', 'admin/reports', 'Reports', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33343A2256696577207265706F7274732C20757064617465732C20616E64206572726F72732E223B7D7D, 'system', '0', '0', '1', '0', '5', '2', '0', '1', '19', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('user-menu', '20', '2', 'user/password', 'user/password', 'Request new password', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '2', '0', '2', '20', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '21', '1', 'admin/structure', 'admin/structure', 'Structure', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34353A2241646D696E697374657220626C6F636B732C20636F6E74656E742074797065732C206D656E75732C206574632E223B7D7D, 'system', '0', '0', '1', '0', '-8', '2', '0', '1', '21', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '22', '1', 'admin/tasks', 'admin/tasks', 'Tasks', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-20', '2', '0', '1', '22', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '23', '0', 'comment/reply/%', 'comment/reply/%', 'Add new comment', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '1', '0', '23', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '24', '3', 'comment/%/approve', 'comment/%/approve', 'Approve', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '1', '2', '0', '3', '24', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '25', '4', 'filter/tips/%', 'filter/tips/%', 'Compose tips', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '2', '0', '4', '25', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '26', '3', 'comment/%/delete', 'comment/%/delete', 'Delete', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '2', '2', '0', '3', '26', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '27', '3', 'comment/%/edit', 'comment/%/edit', 'Edit', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '2', '0', '3', '27', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '28', '0', 'taxonomy/term/%', 'taxonomy/term/%', 'Taxonomy term', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '1', '0', '28', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '29', '3', 'comment/%/view', 'comment/%/view', 'View comment', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '2', '0', '3', '29', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '30', '18', 'admin/people/create', 'admin/people/create', 'Add user', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '18', '30', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '31', '21', 'admin/structure/block', 'admin/structure/block', 'Blocks', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A37393A22436F6E666967757265207768617420626C6F636B20636F6E74656E74206170706561727320696E20796F75722073697465277320736964656261727320616E64206F7468657220726567696F6E732E223B7D7D, 'system', '0', '0', '1', '0', '0', '3', '0', '1', '21', '31', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '32', '17', 'user/%/cancel', 'user/%/cancel', 'Cancel account', 0x613A303A7B7D, 'system', '0', '0', '1', '0', '0', '2', '0', '17', '32', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '33', '9', 'admin/content/comment', 'admin/content/comment', 'Comments', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A35393A224C69737420616E642065646974207369746520636F6D6D656E747320616E642074686520636F6D6D656E7420617070726F76616C2071756575652E223B7D7D, 'system', '0', '0', '0', '0', '0', '3', '0', '1', '9', '33', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '34', '11', 'admin/dashboard/configure', 'admin/dashboard/configure', 'Configure available dashboard blocks', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A35333A22436F6E66696775726520776869636820626C6F636B732063616E2062652073686F776E206F6E207468652064617368626F6172642E223B7D7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '11', '34', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '35', '9', 'admin/content/node', 'admin/content/node', 'Content', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '3', '0', '1', '9', '35', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '36', '8', 'admin/config/content', 'admin/config/content', 'Content authoring', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A35333A2253657474696E67732072656C6174656420746F20666F726D617474696E6720616E6420617574686F72696E6720636F6E74656E742E223B7D7D, 'system', '0', '0', '1', '0', '-15', '3', '0', '1', '8', '36', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '37', '21', 'admin/structure/types', 'admin/structure/types', 'Content types', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A39323A224D616E61676520636F6E74656E742074797065732C20696E636C7564696E672064656661756C74207374617475732C2066726F6E7420706167652070726F6D6F74696F6E2C20636F6D6D656E742073657474696E67732C206574632E223B7D7D, 'system', '0', '0', '1', '0', '0', '3', '0', '1', '21', '37', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '38', '11', 'admin/dashboard/customize', 'admin/dashboard/customize', 'Customize dashboard', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A32353A22437573746F6D697A6520796F75722064617368626F6172642E223B7D7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '11', '38', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '39', '5', 'node/%/delete', 'node/%/delete', 'Delete', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '1', '2', '0', '5', '39', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '40', '8', 'admin/config/development', 'admin/config/development', 'Development', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A31383A22446576656C6F706D656E7420746F6F6C732E223B7D7D, 'system', '0', '0', '1', '0', '-10', '3', '0', '1', '8', '40', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '41', '17', 'user/%/edit', 'user/%/edit', 'Edit', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '2', '0', '17', '41', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '42', '5', 'node/%/edit', 'node/%/edit', 'Edit', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '2', '0', '5', '42', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '43', '19', 'admin/reports/fields', 'admin/reports/fields', 'Field list', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33393A224F76657276696577206F66206669656C6473206F6E20616C6C20656E746974792074797065732E223B7D7D, 'system', '0', '0', '0', '0', '0', '3', '0', '1', '19', '43', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '44', '16', 'admin/modules/list', 'admin/modules/list', 'List', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '16', '44', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '45', '18', 'admin/people/people', 'admin/people/people', 'List', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A35303A2246696E6420616E64206D616E6167652070656F706C6520696E746572616374696E67207769746820796F757220736974652E223B7D7D, 'system', '-1', '0', '0', '0', '-10', '3', '0', '1', '18', '45', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '46', '7', 'admin/appearance/list', 'admin/appearance/list', 'List', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33313A2253656C65637420616E6420636F6E66696775726520796F7572207468656D65223B7D7D, 'system', '-1', '0', '0', '0', '-1', '3', '0', '1', '7', '46', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '47', '8', 'admin/config/media', 'admin/config/media', 'Media', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A31323A224D6564696120746F6F6C732E223B7D7D, 'system', '0', '0', '1', '0', '-10', '3', '0', '1', '8', '47', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '48', '21', 'admin/structure/menu', 'admin/structure/menu', 'Menus', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A38363A22416464206E6577206D656E757320746F20796F757220736974652C2065646974206578697374696E67206D656E75732C20616E642072656E616D6520616E642072656F7267616E697A65206D656E75206C696E6B732E223B7D7D, 'system', '0', '0', '1', '0', '0', '3', '0', '1', '21', '48', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '49', '8', 'admin/config/people', 'admin/config/people', 'People', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A32343A22436F6E6669677572652075736572206163636F756E74732E223B7D7D, 'system', '0', '0', '1', '0', '-20', '3', '0', '1', '8', '49', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '50', '18', 'admin/people/permissions', 'admin/people/permissions', 'Permissions', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A36343A2244657465726D696E652061636365737320746F2066656174757265732062792073656C656374696E67207065726D697373696F6E7320666F7220726F6C65732E223B7D7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '18', '50', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '51', '19', 'admin/reports/dblog', 'admin/reports/dblog', 'Recent log messages', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34333A2256696577206576656E74732074686174206861766520726563656E746C79206265656E206C6F676765642E223B7D7D, 'system', '0', '0', '0', '0', '-1', '3', '0', '1', '19', '51', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '52', '8', 'admin/config/regional', 'admin/config/regional', 'Regional and language', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34383A22526567696F6E616C2073657474696E67732C206C6F63616C697A6174696F6E20616E64207472616E736C6174696F6E2E223B7D7D, 'system', '0', '0', '1', '0', '-5', '3', '0', '1', '8', '52', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '53', '5', 'node/%/revisions', 'node/%/revisions', 'Revisions', 0x613A303A7B7D, 'system', '-1', '0', '1', '0', '2', '2', '0', '5', '53', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '54', '8', 'admin/config/search', 'admin/config/search', 'Search and metadata', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33363A224C6F63616C2073697465207365617263682C206D6574616461746120616E642053454F2E223B7D7D, 'system', '0', '0', '1', '0', '-10', '3', '0', '1', '8', '54', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '55', '7', 'admin/appearance/settings', 'admin/appearance/settings', 'Settings', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34363A22436F6E6669677572652064656661756C7420616E64207468656D652073706563696669632073657474696E67732E223B7D7D, 'system', '-1', '0', '0', '0', '20', '3', '0', '1', '7', '55', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '56', '19', 'admin/reports/status', 'admin/reports/status', 'Status report', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A37343A22476574206120737461747573207265706F72742061626F757420796F757220736974652773206F7065726174696F6E20616E6420616E792064657465637465642070726F626C656D732E223B7D7D, 'system', '0', '0', '0', '0', '-60', '3', '0', '1', '19', '56', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '57', '8', 'admin/config/system', 'admin/config/system', 'System', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33373A2247656E6572616C2073797374656D2072656C6174656420636F6E66696775726174696F6E2E223B7D7D, 'system', '0', '0', '1', '0', '-20', '3', '0', '1', '8', '57', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '58', '21', 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'Taxonomy', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A36373A224D616E6167652074616767696E672C2063617465676F72697A6174696F6E2C20616E6420636C617373696669636174696F6E206F6620796F757220636F6E74656E742E223B7D7D, 'system', '0', '0', '1', '0', '0', '3', '0', '1', '21', '58', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '59', '19', 'admin/reports/access-denied', 'admin/reports/access-denied', 'Top \'access denied\' errors', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33353A225669657720276163636573732064656E69656427206572726F7273202834303373292E223B7D7D, 'system', '0', '0', '0', '0', '0', '3', '0', '1', '19', '59', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '60', '19', 'admin/reports/page-not-found', 'admin/reports/page-not-found', 'Top \'page not found\' errors', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33363A2256696577202770616765206E6F7420666F756E6427206572726F7273202834303473292E223B7D7D, 'system', '0', '0', '0', '0', '0', '3', '0', '1', '19', '60', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '61', '16', 'admin/modules/uninstall', 'admin/modules/uninstall', 'Uninstall', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '20', '3', '0', '1', '16', '61', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '62', '8', 'admin/config/user-interface', 'admin/config/user-interface', 'User interface', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33383A22546F6F6C73207468617420656E68616E636520746865207573657220696E746572666163652E223B7D7D, 'system', '0', '0', '1', '0', '-15', '3', '0', '1', '8', '62', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '63', '5', 'node/%/view', 'node/%/view', 'View', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '2', '0', '5', '63', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '64', '17', 'user/%/view', 'user/%/view', 'View', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '2', '0', '17', '64', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '65', '8', 'admin/config/services', 'admin/config/services', 'Web services', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33303A22546F6F6C732072656C6174656420746F207765622073657276696365732E223B7D7D, 'system', '0', '0', '1', '0', '0', '3', '0', '1', '8', '65', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '66', '8', 'admin/config/workflow', 'admin/config/workflow', 'Workflow', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34333A22436F6E74656E7420776F726B666C6F772C20656469746F7269616C20776F726B666C6F7720746F6F6C732E223B7D7D, 'system', '0', '0', '0', '0', '5', '3', '0', '1', '8', '66', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '67', '12', 'admin/help/block', 'admin/help/block', 'block', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '67', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '68', '12', 'admin/help/color', 'admin/help/color', 'color', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '68', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '69', '12', 'admin/help/comment', 'admin/help/comment', 'comment', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '69', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '70', '12', 'admin/help/contextual', 'admin/help/contextual', 'contextual', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '70', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '71', '12', 'admin/help/dashboard', 'admin/help/dashboard', 'dashboard', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '71', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '72', '12', 'admin/help/dblog', 'admin/help/dblog', 'dblog', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '72', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '73', '12', 'admin/help/field', 'admin/help/field', 'field', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '73', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '74', '12', 'admin/help/field_sql_storage', 'admin/help/field_sql_storage', 'field_sql_storage', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '74', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '75', '12', 'admin/help/field_ui', 'admin/help/field_ui', 'field_ui', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '75', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '76', '12', 'admin/help/file', 'admin/help/file', 'file', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '76', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '77', '12', 'admin/help/filter', 'admin/help/filter', 'filter', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '77', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '78', '12', 'admin/help/help', 'admin/help/help', 'help', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '78', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '79', '12', 'admin/help/image', 'admin/help/image', 'image', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '79', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '80', '12', 'admin/help/list', 'admin/help/list', 'list', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '80', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '81', '12', 'admin/help/menu', 'admin/help/menu', 'menu', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '81', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '82', '12', 'admin/help/node', 'admin/help/node', 'node', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '82', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '83', '12', 'admin/help/options', 'admin/help/options', 'options', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '83', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '84', '12', 'admin/help/system', 'admin/help/system', 'system', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '84', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '85', '12', 'admin/help/taxonomy', 'admin/help/taxonomy', 'taxonomy', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '85', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '86', '12', 'admin/help/text', 'admin/help/text', 'text', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '86', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '87', '12', 'admin/help/user', 'admin/help/user', 'user', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '87', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '88', '28', 'taxonomy/term/%/edit', 'taxonomy/term/%/edit', 'Edit', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '10', '2', '0', '28', '88', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '89', '28', 'taxonomy/term/%/view', 'taxonomy/term/%/view', 'View', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '2', '0', '28', '89', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '90', '58', 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', '', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '4', '0', '1', '21', '58', '90', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '91', '49', 'admin/config/people/accounts', 'admin/config/people/accounts', 'Account settings', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A3130393A22436F6E6669677572652064656661756C74206265686176696F72206F662075736572732C20696E636C7564696E6720726567697374726174696F6E20726571756972656D656E74732C20652D6D61696C732C206669656C64732C20616E6420757365722070696374757265732E223B7D7D, 'system', '0', '0', '0', '0', '-10', '4', '0', '1', '8', '49', '91', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '92', '57', 'admin/config/system/actions', 'admin/config/system/actions', 'Actions', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34313A224D616E6167652074686520616374696F6E7320646566696E656420666F7220796F757220736974652E223B7D7D, 'system', '0', '0', '1', '0', '0', '4', '0', '1', '8', '57', '92', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '93', '31', 'admin/structure/block/add', 'admin/structure/block/add', 'Add block', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '21', '31', '93', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '94', '37', 'admin/structure/types/add', 'admin/structure/types/add', 'Add content type', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '21', '37', '94', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '95', '48', 'admin/structure/menu/add', 'admin/structure/menu/add', 'Add menu', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '21', '48', '95', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '96', '58', 'admin/structure/taxonomy/add', 'admin/structure/taxonomy/add', 'Add vocabulary', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '21', '58', '96', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '97', '55', 'admin/appearance/settings/bartik', 'admin/appearance/settings/bartik', 'Bartik', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '7', '55', '97', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '98', '54', 'admin/config/search/clean-urls', 'admin/config/search/clean-urls', 'Clean URLs', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34333A22456E61626C65206F722064697361626C6520636C65616E2055524C7320666F7220796F757220736974652E223B7D7D, 'system', '0', '0', '0', '0', '5', '4', '0', '1', '8', '54', '98', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '99', '57', 'admin/config/system/cron', 'admin/config/system/cron', 'Cron', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34303A224D616E616765206175746F6D617469632073697465206D61696E74656E616E6365207461736B732E223B7D7D, 'system', '0', '0', '0', '0', '20', '4', '0', '1', '8', '57', '99', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '100', '52', 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Date and time', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34343A22436F6E66696775726520646973706C617920666F726D61747320666F72206461746520616E642074696D652E223B7D7D, 'system', '0', '0', '0', '0', '-15', '4', '0', '1', '8', '52', '100', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '101', '19', 'admin/reports/event/%', 'admin/reports/event/%', 'Details', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '3', '0', '1', '19', '101', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '102', '47', 'admin/config/media/file-system', 'admin/config/media/file-system', 'File system', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A36383A2254656C6C2044727570616C20776865726520746F2073746F72652075706C6F616465642066696C657320616E6420686F772074686579206172652061636365737365642E223B7D7D, 'system', '0', '0', '0', '0', '-10', '4', '0', '1', '8', '47', '102', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '103', '55', 'admin/appearance/settings/garland', 'admin/appearance/settings/garland', 'Garland', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '7', '55', '103', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '104', '55', 'admin/appearance/settings/global', 'admin/appearance/settings/global', 'Global settings', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-1', '4', '0', '1', '7', '55', '104', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '105', '49', 'admin/config/people/ip-blocking', 'admin/config/people/ip-blocking', 'IP address blocking', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A32383A224D616E61676520626C6F636B6564204950206164647265737365732E223B7D7D, 'system', '0', '0', '1', '0', '10', '4', '0', '1', '8', '49', '105', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '106', '47', 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'Image styles', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A37383A22436F6E666967757265207374796C657320746861742063616E206265207573656420666F7220726573697A696E67206F722061646A757374696E6720696D61676573206F6E20646973706C61792E223B7D7D, 'system', '0', '0', '1', '0', '0', '4', '0', '1', '8', '47', '106', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '107', '47', 'admin/config/media/image-toolkit', 'admin/config/media/image-toolkit', 'Image toolkit', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A37343A2243686F6F736520776869636820696D61676520746F6F6C6B697420746F2075736520696620796F75206861766520696E7374616C6C6564206F7074696F6E616C20746F6F6C6B6974732E223B7D7D, 'system', '0', '0', '0', '0', '20', '4', '0', '1', '8', '47', '107', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '108', '44', 'admin/modules/list/confirm', 'admin/modules/list/confirm', 'List', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '16', '44', '108', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '109', '37', 'admin/structure/types/list', 'admin/structure/types/list', 'List', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '4', '0', '1', '21', '37', '109', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '110', '58', 'admin/structure/taxonomy/list', 'admin/structure/taxonomy/list', 'List', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '4', '0', '1', '21', '58', '110', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '111', '48', 'admin/structure/menu/list', 'admin/structure/menu/list', 'List menus', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '4', '0', '1', '21', '48', '111', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '112', '40', 'admin/config/development/logging', 'admin/config/development/logging', 'Logging and errors', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A3135343A2253657474696E677320666F72206C6F6767696E6720616E6420616C65727473206D6F64756C65732E20566172696F7573206D6F64756C65732063616E20726F7574652044727570616C27732073797374656D206576656E747320746F20646966666572656E742064657374696E6174696F6E732C2073756368206173207379736C6F672C2064617461626173652C20656D61696C2C206574632E223B7D7D, 'system', '0', '0', '0', '0', '-15', '4', '0', '1', '8', '40', '112', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '113', '40', 'admin/config/development/maintenance', 'admin/config/development/maintenance', 'Maintenance mode', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A36323A2254616B65207468652073697465206F66666C696E6520666F72206D61696E74656E616E6365206F72206272696E67206974206261636B206F6E6C696E652E223B7D7D, 'system', '0', '0', '0', '0', '-10', '4', '0', '1', '8', '40', '113', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '114', '40', 'admin/config/development/performance', 'admin/config/development/performance', 'Performance', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A3130313A22456E61626C65206F722064697361626C6520706167652063616368696E6720666F7220616E6F6E796D6F757320757365727320616E64207365742043535320616E64204A532062616E647769647468206F7074696D697A6174696F6E206F7074696F6E732E223B7D7D, 'system', '0', '0', '0', '0', '-20', '4', '0', '1', '8', '40', '114', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '115', '50', 'admin/people/permissions/list', 'admin/people/permissions/list', 'Permissions', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A36343A2244657465726D696E652061636365737320746F2066656174757265732062792073656C656374696E67207065726D697373696F6E7320666F7220726F6C65732E223B7D7D, 'system', '-1', '0', '0', '0', '-8', '4', '0', '1', '18', '50', '115', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '116', '33', 'admin/content/comment/new', 'admin/content/comment/new', 'Published comments', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '4', '0', '1', '9', '33', '116', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '117', '65', 'admin/config/services/rss-publishing', 'admin/config/services/rss-publishing', 'RSS publishing', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A3131343A22436F6E666967757265207468652073697465206465736372697074696F6E2C20746865206E756D626572206F66206974656D7320706572206665656420616E6420776865746865722066656564732073686F756C64206265207469746C65732F746561736572732F66756C6C2D746578742E223B7D7D, 'system', '0', '0', '0', '0', '0', '4', '0', '1', '8', '65', '117', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '118', '52', 'admin/config/regional/settings', 'admin/config/regional/settings', 'Regional settings', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A35343A2253657474696E677320666F7220746865207369746527732064656661756C742074696D65207A6F6E6520616E6420636F756E7472792E223B7D7D, 'system', '0', '0', '0', '0', '-20', '4', '0', '1', '8', '52', '118', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '119', '50', 'admin/people/permissions/roles', 'admin/people/permissions/roles', 'Roles', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33303A224C6973742C20656469742C206F7220616464207573657220726F6C65732E223B7D7D, 'system', '-1', '0', '1', '0', '-5', '4', '0', '1', '18', '50', '119', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '120', '48', 'admin/structure/menu/settings', 'admin/structure/menu/settings', 'Settings', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '5', '4', '0', '1', '21', '48', '120', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '121', '55', 'admin/appearance/settings/seven', 'admin/appearance/settings/seven', 'Seven', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '7', '55', '121', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '122', '57', 'admin/config/system/site-information', 'admin/config/system/site-information', 'Site information', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A3130343A224368616E67652073697465206E616D652C20652D6D61696C20616464726573732C20736C6F67616E2C2064656661756C742066726F6E7420706167652C20616E64206E756D626572206F6620706F7374732070657220706167652C206572726F722070616765732E223B7D7D, 'system', '0', '0', '0', '0', '-20', '4', '0', '1', '8', '57', '122', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '123', '55', 'admin/appearance/settings/stark', 'admin/appearance/settings/stark', 'Stark', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '7', '55', '123', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '124', '36', 'admin/config/content/formats', 'admin/config/content/formats', 'Text formats', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A3132373A22436F6E66696775726520686F7720636F6E74656E7420696E7075742062792075736572732069732066696C74657265642C20696E636C7564696E6720616C6C6F7765642048544D4C20746167732E20416C736F20616C6C6F777320656E61626C696E67206F66206D6F64756C652D70726F76696465642066696C746572732E223B7D7D, 'system', '0', '0', '1', '0', '0', '4', '0', '1', '8', '36', '124', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '125', '33', 'admin/content/comment/approval', 'admin/content/comment/approval', 'Unapproved comments', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '9', '33', '125', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '126', '61', 'admin/modules/uninstall/confirm', 'admin/modules/uninstall/confirm', 'Uninstall', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '16', '61', '126', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '127', '41', 'user/%/edit/account', 'user/%/edit/account', 'Account', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '17', '41', '127', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '128', '124', 'admin/config/content/formats/%', 'admin/config/content/formats/%', '', 0x613A303A7B7D, 'system', '0', '0', '1', '0', '0', '5', '0', '1', '8', '36', '124', '128', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '129', '106', 'admin/config/media/image-styles/add', 'admin/config/media/image-styles/add', 'Add style', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A32323A224164642061206E657720696D616765207374796C652E223B7D7D, 'system', '-1', '0', '0', '0', '2', '5', '0', '1', '8', '47', '106', '129', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '130', '90', 'admin/structure/taxonomy/%/add', 'admin/structure/taxonomy/%/add', 'Add term', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '21', '58', '90', '130', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '131', '124', 'admin/config/content/formats/add', 'admin/config/content/formats/add', 'Add text format', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '1', '5', '0', '1', '8', '36', '124', '131', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '132', '31', 'admin/structure/block/list/bartik', 'admin/structure/block/list/bartik', 'Bartik', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '21', '31', '132', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '133', '92', 'admin/config/system/actions/configure', 'admin/config/system/actions/configure', 'Configure an advanced action', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '8', '57', '92', '133', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '134', '48', 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Customize menu', 0x613A303A7B7D, 'system', '0', '0', '1', '0', '0', '4', '0', '1', '21', '48', '134', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '135', '90', 'admin/structure/taxonomy/%/edit', 'admin/structure/taxonomy/%/edit', 'Edit', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '5', '0', '1', '21', '58', '90', '135', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '136', '37', 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Edit content type', 0x613A303A7B7D, 'system', '0', '0', '1', '0', '0', '4', '0', '1', '21', '37', '136', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '137', '100', 'admin/config/regional/date-time/formats', 'admin/config/regional/date-time/formats', 'Formats', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A35313A22436F6E66696775726520646973706C617920666F726D617420737472696E677320666F72206461746520616E642074696D652E223B7D7D, 'system', '-1', '0', '1', '0', '-9', '5', '0', '1', '8', '52', '100', '137', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '138', '31', 'admin/structure/block/list/garland', 'admin/structure/block/list/garland', 'Garland', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '21', '31', '138', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '139', '90', 'admin/structure/taxonomy/%/list', 'admin/structure/taxonomy/%/list', 'List', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-20', '5', '0', '1', '21', '58', '90', '139', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '140', '124', 'admin/config/content/formats/list', 'admin/config/content/formats/list', 'List', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '8', '36', '124', '140', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '141', '106', 'admin/config/media/image-styles/list', 'admin/config/media/image-styles/list', 'List', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34323A224C697374207468652063757272656E7420696D616765207374796C6573206F6E2074686520736974652E223B7D7D, 'system', '-1', '0', '0', '0', '1', '5', '0', '1', '8', '47', '106', '141', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '142', '92', 'admin/config/system/actions/manage', 'admin/config/system/actions/manage', 'Manage actions', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34313A224D616E6167652074686520616374696F6E7320646566696E656420666F7220796F757220736974652E223B7D7D, 'system', '-1', '0', '0', '0', '-2', '5', '0', '1', '8', '57', '92', '142', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '143', '91', 'admin/config/people/accounts/settings', 'admin/config/people/accounts/settings', 'Settings', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '5', '0', '1', '8', '49', '91', '143', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '144', '31', 'admin/structure/block/list/seven', 'admin/structure/block/list/seven', 'Seven', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '21', '31', '144', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '145', '31', 'admin/structure/block/list/stark', 'admin/structure/block/list/stark', 'Stark', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '21', '31', '145', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '146', '100', 'admin/config/regional/date-time/types', 'admin/config/regional/date-time/types', 'Types', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34343A22436F6E66696775726520646973706C617920666F726D61747320666F72206461746520616E642074696D652E223B7D7D, 'system', '-1', '0', '1', '0', '-10', '5', '0', '1', '8', '52', '100', '146', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '147', '53', 'node/%/revisions/%/delete', 'node/%/revisions/%/delete', 'Delete earlier revision', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '3', '0', '5', '53', '147', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '148', '53', 'node/%/revisions/%/revert', 'node/%/revisions/%/revert', 'Revert to earlier revision', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '3', '0', '5', '53', '148', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '149', '53', 'node/%/revisions/%/view', 'node/%/revisions/%/view', 'Revisions', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '3', '0', '5', '53', '149', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '150', '138', 'admin/structure/block/list/garland/add', 'admin/structure/block/list/garland/add', 'Add block', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '21', '31', '138', '150', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '151', '144', 'admin/structure/block/list/seven/add', 'admin/structure/block/list/seven/add', 'Add block', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '21', '31', '144', '151', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '152', '145', 'admin/structure/block/list/stark/add', 'admin/structure/block/list/stark/add', 'Add block', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '21', '31', '145', '152', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '153', '146', 'admin/config/regional/date-time/types/add', 'admin/config/regional/date-time/types/add', 'Add date type', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A31383A22416464206E6577206461746520747970652E223B7D7D, 'system', '-1', '0', '0', '0', '-10', '6', '0', '1', '8', '52', '100', '146', '153', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '154', '137', 'admin/config/regional/date-time/formats/add', 'admin/config/regional/date-time/formats/add', 'Add format', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34333A22416C6C6F7720757365727320746F20616464206164646974696F6E616C206461746520666F726D6174732E223B7D7D, 'system', '-1', '0', '0', '0', '-10', '6', '0', '1', '8', '52', '100', '137', '154', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '155', '134', 'admin/structure/menu/manage/%/add', 'admin/structure/menu/manage/%/add', 'Add link', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '21', '48', '134', '155', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '156', '31', 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Configure block', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '4', '0', '1', '21', '31', '156', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '157', '32', 'user/%/cancel/confirm/%/%', 'user/%/cancel/confirm/%/%', 'Confirm account cancellation', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '3', '0', '17', '32', '157', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '158', '136', 'admin/structure/types/manage/%/delete', 'admin/structure/types/manage/%/delete', 'Delete', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '5', '0', '1', '21', '37', '136', '158', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '159', '105', 'admin/config/people/ip-blocking/delete/%', 'admin/config/people/ip-blocking/delete/%', 'Delete IP address', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '5', '0', '1', '8', '49', '105', '159', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '160', '92', 'admin/config/system/actions/delete/%', 'admin/config/system/actions/delete/%', 'Delete action', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A31373A2244656C65746520616E20616374696F6E2E223B7D7D, 'system', '0', '0', '0', '0', '0', '5', '0', '1', '8', '57', '92', '160', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '161', '134', 'admin/structure/menu/manage/%/delete', 'admin/structure/menu/manage/%/delete', 'Delete menu', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '5', '0', '1', '21', '48', '134', '161', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '162', '48', 'admin/structure/menu/item/%/delete', 'admin/structure/menu/item/%/delete', 'Delete menu link', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '4', '0', '1', '21', '48', '162', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '163', '119', 'admin/people/permissions/roles/delete/%', 'admin/people/permissions/roles/delete/%', 'Delete role', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '5', '0', '1', '18', '50', '119', '163', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '164', '128', 'admin/config/content/formats/%/disable', 'admin/config/content/formats/%/disable', 'Disable text format', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '6', '0', '1', '8', '36', '124', '128', '164', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '165', '136', 'admin/structure/types/manage/%/edit', 'admin/structure/types/manage/%/edit', 'Edit', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '21', '37', '136', '165', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '166', '134', 'admin/structure/menu/manage/%/edit', 'admin/structure/menu/manage/%/edit', 'Edit menu', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '21', '48', '134', '166', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '167', '48', 'admin/structure/menu/item/%/edit', 'admin/structure/menu/item/%/edit', 'Edit menu link', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '4', '0', '1', '21', '48', '167', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '168', '119', 'admin/people/permissions/roles/edit/%', 'admin/people/permissions/roles/edit/%', 'Edit role', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '5', '0', '1', '18', '50', '119', '168', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '169', '106', 'admin/config/media/image-styles/edit/%', 'admin/config/media/image-styles/edit/%', 'Edit style', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A32353A22436F6E66696775726520616E20696D616765207374796C652E223B7D7D, 'system', '0', '0', '1', '0', '0', '5', '0', '1', '8', '47', '106', '169', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '170', '134', 'admin/structure/menu/manage/%/list', 'admin/structure/menu/manage/%/list', 'List links', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '5', '0', '1', '21', '48', '134', '170', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '171', '48', 'admin/structure/menu/item/%/reset', 'admin/structure/menu/item/%/reset', 'Reset menu link', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '4', '0', '1', '21', '48', '171', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '172', '106', 'admin/config/media/image-styles/delete/%', 'admin/config/media/image-styles/delete/%', 'Delete style', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A32323A2244656C65746520616E20696D616765207374796C652E223B7D7D, 'system', '0', '0', '0', '0', '0', '5', '0', '1', '8', '47', '106', '172', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '173', '106', 'admin/config/media/image-styles/revert/%', 'admin/config/media/image-styles/revert/%', 'Revert style', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A32323A2252657665727420616E20696D616765207374796C652E223B7D7D, 'system', '0', '0', '0', '0', '0', '5', '0', '1', '8', '47', '106', '173', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '174', '136', 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%/comment/display', 'Comment display', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '4', '5', '0', '1', '21', '37', '136', '174', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '175', '136', 'admin/structure/types/manage/%/comment/fields', 'admin/structure/types/manage/%/comment/fields', 'Comment fields', 0x613A303A7B7D, 'system', '-1', '0', '1', '0', '3', '5', '0', '1', '21', '37', '136', '175', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '176', '156', 'admin/structure/block/manage/%/%/configure', 'admin/structure/block/manage/%/%/configure', 'Configure block', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '21', '31', '156', '176', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '177', '156', 'admin/structure/block/manage/%/%/delete', 'admin/structure/block/manage/%/%/delete', 'Delete block', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '21', '31', '156', '177', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '178', '137', 'admin/config/regional/date-time/formats/%/delete', 'admin/config/regional/date-time/formats/%/delete', 'Delete date format', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34373A22416C6C6F7720757365727320746F2064656C657465206120636F6E66696775726564206461746520666F726D61742E223B7D7D, 'system', '0', '0', '0', '0', '0', '6', '0', '1', '8', '52', '100', '137', '178', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '179', '146', 'admin/config/regional/date-time/types/%/delete', 'admin/config/regional/date-time/types/%/delete', 'Delete date type', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34353A22416C6C6F7720757365727320746F2064656C657465206120636F6E66696775726564206461746520747970652E223B7D7D, 'system', '0', '0', '0', '0', '0', '6', '0', '1', '8', '52', '100', '146', '179', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '180', '137', 'admin/config/regional/date-time/formats/%/edit', 'admin/config/regional/date-time/formats/%/edit', 'Edit date format', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34353A22416C6C6F7720757365727320746F2065646974206120636F6E66696775726564206461746520666F726D61742E223B7D7D, 'system', '0', '0', '0', '0', '0', '6', '0', '1', '8', '52', '100', '137', '180', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '181', '169', 'admin/config/media/image-styles/edit/%/add/%', 'admin/config/media/image-styles/edit/%/add/%', 'Add image effect', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A32383A224164642061206E65772065666665637420746F2061207374796C652E223B7D7D, 'system', '0', '0', '0', '0', '0', '6', '0', '1', '8', '47', '106', '169', '181', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '182', '169', 'admin/config/media/image-styles/edit/%/effects/%', 'admin/config/media/image-styles/edit/%/effects/%', 'Edit image effect', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33393A224564697420616E206578697374696E67206566666563742077697468696E2061207374796C652E223B7D7D, 'system', '0', '0', '1', '0', '0', '6', '0', '1', '8', '47', '106', '169', '182', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '183', '182', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'Delete image effect', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33393A2244656C65746520616E206578697374696E67206566666563742066726F6D2061207374796C652E223B7D7D, 'system', '0', '0', '0', '0', '0', '7', '0', '1', '8', '47', '106', '169', '182', '183', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '184', '48', 'admin/structure/menu/manage/main-menu', 'admin/structure/menu/manage/%', 'Main menu', 0x613A303A7B7D, 'menu', '0', '0', '0', '0', '0', '4', '0', '1', '21', '48', '184', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '185', '48', 'admin/structure/menu/manage/management', 'admin/structure/menu/manage/%', 'Management', 0x613A303A7B7D, 'menu', '0', '0', '0', '0', '0', '4', '0', '1', '21', '48', '185', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '186', '48', 'admin/structure/menu/manage/navigation', 'admin/structure/menu/manage/%', 'Navigation', 0x613A303A7B7D, 'menu', '0', '0', '0', '0', '0', '4', '0', '1', '21', '48', '186', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '187', '48', 'admin/structure/menu/manage/user-menu', 'admin/structure/menu/manage/%', 'User menu', 0x613A303A7B7D, 'menu', '0', '0', '0', '0', '0', '4', '0', '1', '21', '48', '187', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '188', '0', 'search', 'search', 'Search', 0x613A303A7B7D, 'system', '1', '0', '0', '0', '0', '1', '0', '188', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '189', '188', 'search/node', 'search/node', 'Content', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '2', '0', '188', '189', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '190', '188', 'search/user', 'search/user', 'Users', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '2', '0', '188', '190', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '191', '189', 'search/node/%', 'search/node/%', 'Content', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '188', '189', '191', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '192', '17', 'user/%/shortcuts', 'user/%/shortcuts', 'Shortcuts', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '2', '0', '17', '192', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '193', '19', 'admin/reports/search', 'admin/reports/search', 'Top search phrases', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A33333A2256696577206D6F737420706F70756C61722073656172636820706872617365732E223B7D7D, 'system', '0', '0', '0', '0', '0', '3', '0', '1', '19', '193', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '194', '190', 'search/user/%', 'search/user/%', 'Users', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '188', '190', '194', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '195', '12', 'admin/help/number', 'admin/help/number', 'number', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '195', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '197', '12', 'admin/help/path', 'admin/help/path', 'path', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '197', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '198', '12', 'admin/help/rdf', 'admin/help/rdf', 'rdf', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '198', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '199', '12', 'admin/help/search', 'admin/help/search', 'search', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '199', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '200', '12', 'admin/help/shortcut', 'admin/help/shortcut', 'shortcut', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '200', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '201', '54', 'admin/config/search/settings', 'admin/config/search/settings', 'Search settings', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A36373A22436F6E6669677572652072656C6576616E63652073657474696E677320666F722073656172636820616E64206F7468657220696E646578696E67206F7074696F6E732E223B7D7D, 'system', '0', '0', '0', '0', '-10', '4', '0', '1', '8', '54', '201', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '202', '62', 'admin/config/user-interface/shortcut', 'admin/config/user-interface/shortcut', 'Shortcuts', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A32393A2241646420616E64206D6F646966792073686F727463757420736574732E223B7D7D, 'system', '0', '0', '1', '0', '0', '4', '0', '1', '8', '62', '202', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '203', '54', 'admin/config/search/path', 'admin/config/search/path', 'URL aliases', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A34363A224368616E676520796F7572207369746527732055524C20706174687320627920616C696173696E67207468656D2E223B7D7D, 'system', '0', '0', '1', '0', '-5', '4', '0', '1', '8', '54', '203', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '204', '203', 'admin/config/search/path/add', 'admin/config/search/path/add', 'Add alias', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '8', '54', '203', '204', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '205', '202', 'admin/config/user-interface/shortcut/add-set', 'admin/config/user-interface/shortcut/add-set', 'Add shortcut set', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '8', '62', '202', '205', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '206', '201', 'admin/config/search/settings/reindex', 'admin/config/search/settings/reindex', 'Clear index', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '8', '54', '201', '206', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '207', '202', 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Edit shortcuts', 0x613A303A7B7D, 'system', '0', '0', '1', '0', '0', '5', '0', '1', '8', '62', '202', '207', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '208', '203', 'admin/config/search/path/list', 'admin/config/search/path/list', 'List', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '5', '0', '1', '8', '54', '203', '208', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '209', '207', 'admin/config/user-interface/shortcut/%/add-link', 'admin/config/user-interface/shortcut/%/add-link', 'Add shortcut', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '6', '0', '1', '8', '62', '202', '207', '209', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '210', '203', 'admin/config/search/path/delete/%', 'admin/config/search/path/delete/%', 'Delete alias', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '5', '0', '1', '8', '54', '203', '210', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '211', '207', 'admin/config/user-interface/shortcut/%/delete', 'admin/config/user-interface/shortcut/%/delete', 'Delete shortcut set', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '6', '0', '1', '8', '62', '202', '207', '211', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '212', '203', 'admin/config/search/path/edit/%', 'admin/config/search/path/edit/%', 'Edit alias', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '5', '0', '1', '8', '54', '203', '212', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '213', '207', 'admin/config/user-interface/shortcut/%/edit', 'admin/config/user-interface/shortcut/%/edit', 'Edit set name', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '10', '6', '0', '1', '8', '62', '202', '207', '213', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '214', '202', 'admin/config/user-interface/shortcut/link/%', 'admin/config/user-interface/shortcut/link/%', 'Edit shortcut', 0x613A303A7B7D, 'system', '0', '0', '1', '0', '0', '5', '0', '1', '8', '62', '202', '214', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '215', '207', 'admin/config/user-interface/shortcut/%/links', 'admin/config/user-interface/shortcut/%/links', 'List links', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '6', '0', '1', '8', '62', '202', '207', '215', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '216', '214', 'admin/config/user-interface/shortcut/link/%/delete', 'admin/config/user-interface/shortcut/link/%/delete', 'Delete shortcut', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '6', '0', '1', '8', '62', '202', '214', '216', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('shortcut-set-1', '217', '0', 'node/add', 'node/add', 'Add content', 0x613A303A7B7D, 'menu', '0', '0', '0', '0', '-50', '1', '0', '217', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('shortcut-set-1', '218', '0', 'admin/content', 'admin/content', 'Find content', 0x613A303A7B7D, 'menu', '0', '0', '0', '0', '-49', '1', '0', '218', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('main-menu', '219', '0', '<front>', '', 'Home', 0x613A303A7B7D, 'menu', '0', '1', '0', '0', '0', '1', '0', '219', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '220', '6', 'node/add/article', 'node/add/article', 'Article', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A38393A22557365203C656D3E61727469636C65733C2F656D3E20666F722074696D652D73656E73697469766520636F6E74656E74206C696B65206E6577732C2070726573732072656C6561736573206F7220626C6F6720706F7374732E223B7D7D, 'system', '0', '0', '0', '0', '0', '2', '0', '6', '220', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('navigation', '221', '6', 'node/add/page', 'node/add/page', 'Basic page', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A37373A22557365203C656D3E62617369632070616765733C2F656D3E20666F7220796F75722073746174696320636F6E74656E742C207375636820617320616E202741626F75742075732720706167652E223B7D7D, 'system', '0', '0', '0', '0', '0', '2', '0', '6', '221', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '222', '12', 'admin/help/toolbar', 'admin/help/toolbar', 'toolbar', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '3', '0', '1', '12', '222', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '261', '90', 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%/display', 'Manage display', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '2', '5', '0', '1', '21', '58', '90', '261', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '262', '91', 'admin/config/people/accounts/display', 'admin/config/people/accounts/display', 'Manage display', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '2', '5', '0', '1', '8', '49', '91', '262', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '263', '90', 'admin/structure/taxonomy/%/fields', 'admin/structure/taxonomy/%/fields', 'Manage fields', 0x613A303A7B7D, 'system', '-1', '0', '1', '0', '1', '5', '0', '1', '21', '58', '90', '263', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '264', '91', 'admin/config/people/accounts/fields', 'admin/config/people/accounts/fields', 'Manage fields', 0x613A303A7B7D, 'system', '-1', '0', '1', '0', '1', '5', '0', '1', '8', '49', '91', '264', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '265', '261', 'admin/structure/taxonomy/%/display/default', 'admin/structure/taxonomy/%/display/default', 'Default', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '6', '0', '1', '21', '58', '90', '261', '265', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '266', '262', 'admin/config/people/accounts/display/default', 'admin/config/people/accounts/display/default', 'Default', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '6', '0', '1', '8', '49', '91', '262', '266', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '267', '136', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%/display', 'Manage display', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '2', '5', '0', '1', '21', '37', '136', '267', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '268', '136', 'admin/structure/types/manage/%/fields', 'admin/structure/types/manage/%/fields', 'Manage fields', 0x613A303A7B7D, 'system', '-1', '0', '1', '0', '1', '5', '0', '1', '21', '37', '136', '268', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '269', '261', 'admin/structure/taxonomy/%/display/full', 'admin/structure/taxonomy/%/display/full', 'Taxonomy term page', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '6', '0', '1', '21', '58', '90', '261', '269', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '270', '262', 'admin/config/people/accounts/display/full', 'admin/config/people/accounts/display/full', 'User account', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '6', '0', '1', '8', '49', '91', '262', '270', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '271', '263', 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', '', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '6', '0', '1', '21', '58', '90', '263', '271', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '272', '264', 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', '', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '6', '0', '1', '8', '49', '91', '264', '272', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '273', '267', 'admin/structure/types/manage/%/display/default', 'admin/structure/types/manage/%/display/default', 'Default', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '6', '0', '1', '21', '37', '136', '267', '273', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '274', '267', 'admin/structure/types/manage/%/display/full', 'admin/structure/types/manage/%/display/full', 'Full content', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '6', '0', '1', '21', '37', '136', '267', '274', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '275', '267', 'admin/structure/types/manage/%/display/rss', 'admin/structure/types/manage/%/display/rss', 'RSS', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '2', '6', '0', '1', '21', '37', '136', '267', '275', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '276', '267', 'admin/structure/types/manage/%/display/search_index', 'admin/structure/types/manage/%/display/search_index', 'Search index', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '3', '6', '0', '1', '21', '37', '136', '267', '276', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '277', '267', 'admin/structure/types/manage/%/display/search_result', 'admin/structure/types/manage/%/display/search_result', 'Search result highlighting input', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '4', '6', '0', '1', '21', '37', '136', '267', '277', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '278', '267', 'admin/structure/types/manage/%/display/teaser', 'admin/structure/types/manage/%/display/teaser', 'Teaser', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '1', '6', '0', '1', '21', '37', '136', '267', '278', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '279', '268', 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', '', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '6', '0', '1', '21', '37', '136', '268', '279', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '280', '271', 'admin/structure/taxonomy/%/fields/%/delete', 'admin/structure/taxonomy/%/fields/%/delete', 'Delete', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '10', '7', '0', '1', '21', '58', '90', '263', '271', '280', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '281', '271', 'admin/structure/taxonomy/%/fields/%/edit', 'admin/structure/taxonomy/%/fields/%/edit', 'Edit', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '7', '0', '1', '21', '58', '90', '263', '271', '281', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '282', '271', 'admin/structure/taxonomy/%/fields/%/field-settings', 'admin/structure/taxonomy/%/fields/%/field-settings', 'Field settings', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '7', '0', '1', '21', '58', '90', '263', '271', '282', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '283', '271', 'admin/structure/taxonomy/%/fields/%/widget-type', 'admin/structure/taxonomy/%/fields/%/widget-type', 'Widget type', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '7', '0', '1', '21', '58', '90', '263', '271', '283', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '284', '272', 'admin/config/people/accounts/fields/%/delete', 'admin/config/people/accounts/fields/%/delete', 'Delete', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '10', '7', '0', '1', '8', '49', '91', '264', '272', '284', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '285', '272', 'admin/config/people/accounts/fields/%/edit', 'admin/config/people/accounts/fields/%/edit', 'Edit', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '7', '0', '1', '8', '49', '91', '264', '272', '285', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '286', '272', 'admin/config/people/accounts/fields/%/field-settings', 'admin/config/people/accounts/fields/%/field-settings', 'Field settings', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '7', '0', '1', '8', '49', '91', '264', '272', '286', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '287', '272', 'admin/config/people/accounts/fields/%/widget-type', 'admin/config/people/accounts/fields/%/widget-type', 'Widget type', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '7', '0', '1', '8', '49', '91', '264', '272', '287', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '288', '174', 'admin/structure/types/manage/%/comment/display/default', 'admin/structure/types/manage/%/comment/display/default', 'Default', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '6', '0', '1', '21', '37', '136', '174', '288', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '289', '174', 'admin/structure/types/manage/%/comment/display/full', 'admin/structure/types/manage/%/comment/display/full', 'Full comment', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '6', '0', '1', '21', '37', '136', '174', '289', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '290', '279', 'admin/structure/types/manage/%/fields/%/delete', 'admin/structure/types/manage/%/fields/%/delete', 'Delete', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '10', '7', '0', '1', '21', '37', '136', '268', '279', '290', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '291', '279', 'admin/structure/types/manage/%/fields/%/edit', 'admin/structure/types/manage/%/fields/%/edit', 'Edit', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '7', '0', '1', '21', '37', '136', '268', '279', '291', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '292', '175', 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', '', 0x613A303A7B7D, 'system', '0', '0', '0', '0', '0', '6', '0', '1', '21', '37', '136', '175', '292', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '293', '279', 'admin/structure/types/manage/%/fields/%/field-settings', 'admin/structure/types/manage/%/fields/%/field-settings', 'Field settings', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '7', '0', '1', '21', '37', '136', '268', '279', '293', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '294', '279', 'admin/structure/types/manage/%/fields/%/widget-type', 'admin/structure/types/manage/%/fields/%/widget-type', 'Widget type', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '7', '0', '1', '21', '37', '136', '268', '279', '294', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '295', '292', 'admin/structure/types/manage/%/comment/fields/%/delete', 'admin/structure/types/manage/%/comment/fields/%/delete', 'Delete', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '10', '7', '0', '1', '21', '37', '136', '175', '292', '295', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '296', '292', 'admin/structure/types/manage/%/comment/fields/%/edit', 'admin/structure/types/manage/%/comment/fields/%/edit', 'Edit', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '7', '0', '1', '21', '37', '136', '175', '292', '296', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '297', '292', 'admin/structure/types/manage/%/comment/fields/%/field-settings', 'admin/structure/types/manage/%/comment/fields/%/field-settings', 'Field settings', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '7', '0', '1', '21', '37', '136', '175', '292', '297', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '298', '292', 'admin/structure/types/manage/%/comment/fields/%/widget-type', 'admin/structure/types/manage/%/comment/fields/%/widget-type', 'Widget type', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '7', '0', '1', '21', '37', '136', '175', '292', '298', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '299', '55', 'admin/appearance/settings/theme_default', 'admin/appearance/settings/theme_default', 'default theme', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '4', '0', '1', '7', '55', '299', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '300', '31', 'admin/structure/block/list/theme_default', 'admin/structure/block/list/theme_default', 'default theme', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '-10', '4', '0', '1', '21', '31', '300', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('shortcut-set-1', '303', '0', 'admin/structure/block', 'admin/structure/block', 'Blocks', 0x613A303A7B7D, 'menu', '0', '0', '0', '0', '-48', '1', '0', '303', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '304', '132', 'admin/structure/block/list/bartik/add', 'admin/structure/block/list/bartik/add', 'Add block', 0x613A303A7B7D, 'system', '-1', '0', '0', '0', '0', '5', '0', '1', '21', '31', '132', '304', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('shortcut-set-1', '305', '0', 'admin/config/development/performance', 'admin/config/development/performance', 'Performance', 0x613A303A7B7D, 'menu', '0', '0', '0', '0', '-47', '1', '0', '305', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `menu_links` VALUES ('management', '306', '1', 'admin/admincp', 'admin/admincp', 'Trang quản trị', 0x613A313A7B733A31303A2261747472696275746573223B613A313A7B733A353A227469746C65223B733A31343A2241646D696E697374726174696F6E223B7D7D, 'system', '0', '0', '0', '0', '0', '2', '0', '1', '306', '0', '0', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for menu_router
-- ----------------------------
DROP TABLE IF EXISTS `menu_router`;
CREATE TABLE `menu_router` (
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL DEFAULT '0' COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL DEFAULT '0' COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL DEFAULT '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext COMMENT 'The file to include for this element, usually the page callback function lives in this file.',
  PRIMARY KEY (`path`),
  KEY `fit` (`fit`),
  KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps paths to various callbacks (access, page and title)';

-- ----------------------------
-- Records of menu_router
-- ----------------------------
INSERT INTO `menu_router` VALUES ('admin', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '1', '1', '0', '', 'admin', 'Administration', 't', '', '', 'a:0:{}', '6', '', '', '9', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/admincp', '', '', '1', 0x613A303A7B7D, 'admin_redirect', 0x613A303A7B7D, '', '3', '2', '0', '', 'admin/admincp', 'Trang quản trị', 't', '', '', 'a:0:{}', '6', 'Administration', '', '0', '');
INSERT INTO `menu_router` VALUES ('admin/appearance', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E6973746572207468656D6573223B7D, 'system_themes_page', 0x613A303A7B7D, '', '3', '2', '0', '', 'admin/appearance', 'Appearance', 't', '', '', 'a:0:{}', '6', 'Select and configure your themes.', 'left', '-6', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/default', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E6973746572207468656D6573223B7D, 'system_theme_default', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/appearance/default', 'Set default theme', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/disable', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E6973746572207468656D6573223B7D, 'system_theme_disable', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/appearance/disable', 'Disable theme', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/enable', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E6973746572207468656D6573223B7D, 'system_theme_enable', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/appearance/enable', 'Enable theme', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/list', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E6973746572207468656D6573223B7D, 'system_themes_page', 0x613A303A7B7D, '', '7', '3', '1', 'admin/appearance', 'admin/appearance', 'List', 't', '', '', 'a:0:{}', '140', 'Select and configure your theme', '', '-1', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E6973746572207468656D6573223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32313A2273797374656D5F7468656D655F73657474696E6773223B7D, '', '7', '3', '1', 'admin/appearance', 'admin/appearance', 'Settings', 't', '', '', 'a:0:{}', '132', 'Configure default and theme specific settings.', '', '20', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/bartik', '', '', '_system_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A32353A227468656D65732F62617274696B2F62617274696B2E696E666F223B733A343A226E616D65223B733A363A2262617274696B223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2231223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31393A7B733A343A226E616D65223B733A363A2242617274696B223B733A31313A226465736372697074696F6E223B733A34383A224120666C657869626C652C207265636F6C6F7261626C65207468656D652077697468206D616E7920726567696F6E732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A333A7B733A31343A226373732F6C61796F75742E637373223B733A32383A227468656D65732F62617274696B2F6373732F6C61796F75742E637373223B733A31333A226373732F7374796C652E637373223B733A32373A227468656D65732F62617274696B2F6373732F7374796C652E637373223B733A31343A226373732F636F6C6F72732E637373223B733A32383A227468656D65732F62617274696B2F6373732F636F6C6F72732E637373223B7D733A353A227072696E74223B613A313A7B733A31333A226373732F7072696E742E637373223B733A32373A227468656D65732F62617274696B2F6373732F7072696E742E637373223B7D7D733A373A22726567696F6E73223B613A32303A7B733A363A22686561646572223B733A363A22486561646572223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31313A22686967686C696768746564223B733A31313A22486967686C696768746564223B733A383A226665617475726564223B733A383A224665617475726564223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A31333A22736964656261725F6669727374223B733A31333A2253696465626172206669727374223B733A31343A22736964656261725F7365636F6E64223B733A31343A2253696465626172207365636F6E64223B733A31343A2274726970747963685F6669727374223B733A31343A225472697074796368206669727374223B733A31353A2274726970747963685F6D6964646C65223B733A31353A225472697074796368206D6964646C65223B733A31333A2274726970747963685F6C617374223B733A31333A225472697074796368206C617374223B733A31383A22666F6F7465725F6669727374636F6C756D6E223B733A31393A22466F6F74657220666972737420636F6C756D6E223B733A31393A22666F6F7465725F7365636F6E64636F6C756D6E223B733A32303A22466F6F746572207365636F6E6420636F6C756D6E223B733A31383A22666F6F7465725F7468697264636F6C756D6E223B733A31393A22466F6F74657220746869726420636F6C756D6E223B733A31393A22666F6F7465725F666F75727468636F6C756D6E223B733A32303A22466F6F74657220666F7572746820636F6C756D6E223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A383A2273657474696E6773223B613A313A7B733A32303A2273686F72746375745F6D6F64756C655F6C696E6B223B733A313A2230223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32383A227468656D65732F62617274696B2F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A333A7B733A31343A226373732F6C61796F75742E637373223B733A32383A227468656D65732F62617274696B2F6373732F6C61796F75742E637373223B733A31333A226373732F7374796C652E637373223B733A32373A227468656D65732F62617274696B2F6373732F7374796C652E637373223B733A31343A226373732F636F6C6F72732E637373223B733A32383A227468656D65732F62617274696B2F6373732F636F6C6F72732E637373223B7D733A353A227072696E74223B613A313A7B733A31333A226373732F7072696E742E637373223B733A32373A227468656D65732F62617274696B2F6373732F7072696E742E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'drupal_get_form', 0x613A323A7B693A303B733A32313A2273797374656D5F7468656D655F73657474696E6773223B693A313B733A363A2262617274696B223B7D, '', '15', '4', '1', 'admin/appearance/settings', 'admin/appearance', 'Bartik', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/garland', '', '', '_system_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A32373A227468656D65732F6761726C616E642F6761726C616E642E696E666F223B733A343A226E616D65223B733A373A226761726C616E64223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2230223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31393A7B733A343A226E616D65223B733A373A224761726C616E64223B733A31313A226465736372697074696F6E223B733A3131313A2241206D756C74692D636F6C756D6E207468656D652077686963682063616E20626520636F6E6669677572656420746F206D6F6469667920636F6C6F727320616E6420737769746368206265747765656E20666978656420616E6420666C756964207769647468206C61796F7574732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A313A7B733A393A227374796C652E637373223B733A32343A227468656D65732F6761726C616E642F7374796C652E637373223B7D733A353A227072696E74223B613A313A7B733A393A227072696E742E637373223B733A32343A227468656D65732F6761726C616E642F7072696E742E637373223B7D7D733A383A2273657474696E6773223B613A313A7B733A31333A226761726C616E645F7769647468223B733A353A22666C756964223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A373A22726567696F6E73223B613A31323A7B733A31333A22736964656261725F6669727374223B733A31323A224C6566742073696465626172223B733A31343A22736964656261725F7365636F6E64223B733A31333A2252696768742073696465626172223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A363A22686561646572223B733A363A22486561646572223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31313A22686967686C696768746564223B733A31313A22486967686C696768746564223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32393A227468656D65732F6761726C616E642F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A313A7B733A393A227374796C652E637373223B733A32343A227468656D65732F6761726C616E642F7374796C652E637373223B7D733A353A227072696E74223B613A313A7B733A393A227072696E742E637373223B733A32343A227468656D65732F6761726C616E642F7072696E742E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'drupal_get_form', 0x613A323A7B693A303B733A32313A2273797374656D5F7468656D655F73657474696E6773223B693A313B733A373A226761726C616E64223B7D, '', '15', '4', '1', 'admin/appearance/settings', 'admin/appearance', 'Garland', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/global', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E6973746572207468656D6573223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32313A2273797374656D5F7468656D655F73657474696E6773223B7D, '', '15', '4', '1', 'admin/appearance/settings', 'admin/appearance', 'Global settings', 't', '', '', 'a:0:{}', '140', '', '', '-1', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/seven', '', '', '_system_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A32333A227468656D65732F736576656E2F736576656E2E696E666F223B733A343A226E616D65223B733A353A22736576656E223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2231223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31393A7B733A343A226E616D65223B733A353A22536576656E223B733A31313A226465736372697074696F6E223B733A36353A22412073696D706C65206F6E652D636F6C756D6E2C207461626C656C6573732C20666C7569642077696474682061646D696E697374726174696F6E207468656D652E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A313A7B733A363A2273637265656E223B613A323A7B733A393A2272657365742E637373223B733A32323A227468656D65732F736576656E2F72657365742E637373223B733A393A227374796C652E637373223B733A32323A227468656D65732F736576656E2F7374796C652E637373223B7D7D733A383A2273657474696E6773223B613A313A7B733A32303A2273686F72746375745F6D6F64756C655F6C696E6B223B733A313A2231223B7D733A373A22726567696F6E73223B613A383A7B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31333A22736964656261725F6669727374223B733A31333A2246697273742073696465626172223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A31343A22726567696F6E735F68696464656E223B613A333A7B693A303B733A31333A22736964656261725F6669727374223B693A313B733A383A22706167655F746F70223B693A323B733A31313A22706167655F626F74746F6D223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32373A227468656D65732F736576656E2F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A313A7B733A363A2273637265656E223B613A323A7B733A393A2272657365742E637373223B733A32323A227468656D65732F736576656E2F72657365742E637373223B733A393A227374796C652E637373223B733A32323A227468656D65732F736576656E2F7374796C652E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'drupal_get_form', 0x613A323A7B693A303B733A32313A2273797374656D5F7468656D655F73657474696E6773223B693A313B733A353A22736576656E223B7D, '', '15', '4', '1', 'admin/appearance/settings', 'admin/appearance', 'Seven', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/stark', '', '', '_system_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A32333A227468656D65732F737461726B2F737461726B2E696E666F223B733A343A226E616D65223B733A353A22737461726B223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2230223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31383A7B733A343A226E616D65223B733A353A22537461726B223B733A31313A226465736372697074696F6E223B733A3230383A2254686973207468656D652064656D6F6E737472617465732044727570616C27732064656661756C742048544D4C206D61726B757020616E6420435353207374796C65732E20546F206C6561726E20686F7720746F206275696C6420796F7572206F776E207468656D6520616E64206F766572726964652044727570616C27732064656661756C7420636F64652C2073656520746865203C6120687265663D22687474703A2F2F64727570616C2E6F72672F7468656D652D6775696465223E5468656D696E672047756964653C2F613E2E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31303A226C61796F75742E637373223B733A32333A227468656D65732F737461726B2F6C61796F75742E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A373A22726567696F6E73223B613A31323A7B733A31333A22736964656261725F6669727374223B733A31323A224C6566742073696465626172223B733A31343A22736964656261725F7365636F6E64223B733A31333A2252696768742073696465626172223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A363A22686561646572223B733A363A22486561646572223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31313A22686967686C696768746564223B733A31313A22486967686C696768746564223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32373A227468656D65732F737461726B2F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31303A226C61796F75742E637373223B733A32333A227468656D65732F737461726B2F6C61796F75742E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'drupal_get_form', 0x613A323A7B693A303B733A32313A2273797374656D5F7468656D655F73657474696E6773223B693A313B733A353A22737461726B223B7D, '', '15', '4', '1', 'admin/appearance/settings', 'admin/appearance', 'Stark', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/theme_default', '', '', '_system_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A34393A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F7468656D655F64656661756C742E696E666F223B733A343A226E616D65223B733A31333A227468656D655F64656661756C74223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2231223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31373A7B733A343A226E616D65223B733A31333A2264656661756C74207468656D65223B733A31313A226465736372697074696F6E223B733A31333A2264656661756C74207468656D65223B733A343A22636F7265223B733A333A22372E78223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A373A2276657273696F6E223B733A333A22372E78223B733A373A2270726F6A656374223B733A31333A2264656661756C74207468656D65223B733A393A22646174657374616D70223B733A31303A2231333332353137383436223B733A373A22726567696F6E73223B613A383A7B733A363A22686561646572223B733A363A22486561646572223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A343A226C656674223B733A343A224C656674223B733A353A227269676874223B733A353A225269676874223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31333A226373732F7374796C652E637373223B733A34343A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F6373732F7374796C652E637373223B7D7D733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A34353A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383331353630373B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31333A226373732F7374796C652E637373223B733A34343A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F6373732F7374796C652E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'drupal_get_form', 0x613A323A7B693A303B733A32313A2273797374656D5F7468656D655F73657474696E6773223B693A313B733A31333A227468656D655F64656661756C74223B7D, '', '15', '4', '1', 'admin/appearance/settings', 'admin/appearance', 'default theme', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/compact', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_compact_page', 0x613A303A7B7D, '', '3', '2', '0', '', 'admin/compact', 'Compact mode', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_config_page', 0x613A303A7B7D, '', '3', '2', '0', '', 'admin/config', 'Configuration', 't', '', '', 'a:0:{}', '6', 'Administer settings.', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/config/content', 'Content authoring', 't', '', '', 'a:0:{}', '6', 'Settings related to formatting and authoring content.', 'left', '-15', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats', '', '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E69737465722066696C74657273223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32313A2266696C7465725F61646D696E5F6F76657276696577223B7D, '', '15', '4', '0', '', 'admin/config/content/formats', 'Text formats', 't', '', '', 'a:0:{}', '6', 'Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.', '', '0', 'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats/%', 0x613A313A7B693A343B733A31383A2266696C7465725F666F726D61745F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E69737465722066696C74657273223B7D, 'filter_admin_format_page', 0x613A313A7B693A303B693A343B7D, '', '30', '5', '0', '', 'admin/config/content/formats/%', '', 'filter_admin_format_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', '6', '', '', '0', 'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats/%/disable', 0x613A313A7B693A343B733A31383A2266696C7465725F666F726D61745F6C6F6164223B7D, '', '_filter_disable_format_access', 0x613A313A7B693A303B693A343B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32303A2266696C7465725F61646D696E5F64697361626C65223B693A313B693A343B7D, '', '61', '6', '0', '', 'admin/config/content/formats/%/disable', 'Disable text format', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats/add', '', '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E69737465722066696C74657273223B7D, 'filter_admin_format_page', 0x613A303A7B7D, '', '31', '5', '1', 'admin/config/content/formats', 'admin/config/content/formats', 'Add text format', 't', '', '', 'a:0:{}', '388', '', '', '1', 'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats/list', '', '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E69737465722066696C74657273223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32313A2266696C7465725F61646D696E5F6F76657276696577223B7D, '', '31', '5', '1', 'admin/config/content/formats', 'admin/config/content/formats', 'List', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/development', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/config/development', 'Development', 't', '', '', 'a:0:{}', '6', 'Development tools.', 'right', '-10', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/development/logging', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32333A2273797374656D5F6C6F6767696E675F73657474696E6773223B7D, '', '15', '4', '0', '', 'admin/config/development/logging', 'Logging and errors', 't', '', '', 'a:0:{}', '6', 'Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.', '', '-15', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/development/maintenance', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32383A2273797374656D5F736974655F6D61696E74656E616E63655F6D6F6465223B7D, '', '15', '4', '0', '', 'admin/config/development/maintenance', 'Maintenance mode', 't', '', '', 'a:0:{}', '6', 'Take the site offline for maintenance or bring it back online.', '', '-10', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/development/performance', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32373A2273797374656D5F706572666F726D616E63655F73657474696E6773223B7D, '', '15', '4', '0', '', 'admin/config/development/performance', 'Performance', 't', '', '', 'a:0:{}', '6', 'Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.', '', '-20', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/config/media', 'Media', 't', '', '', 'a:0:{}', '6', 'Media tools.', 'left', '-10', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/file-system', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32373A2273797374656D5F66696C655F73797374656D5F73657474696E6773223B7D, '', '15', '4', '0', '', 'admin/config/media/file-system', 'File system', 't', '', '', 'a:0:{}', '6', 'Tell Drupal where to store uploaded files and how they are accessed.', '', '-10', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles', '', '', 'user_access', 0x613A313A7B693A303B733A32333A2261646D696E697374657220696D616765207374796C6573223B7D, 'image_style_list', 0x613A303A7B7D, '', '15', '4', '0', '', 'admin/config/media/image-styles', 'Image styles', 't', '', '', 'a:0:{}', '6', 'Configure styles that can be used for resizing or adjusting images on display.', '', '0', 'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/add', '', '', 'user_access', 0x613A313A7B693A303B733A32333A2261646D696E697374657220696D616765207374796C6573223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32303A22696D6167655F7374796C655F6164645F666F726D223B7D, '', '31', '5', '1', 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'Add style', 't', '', '', 'a:0:{}', '388', 'Add a new image style.', '', '2', 'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/delete/%', 0x613A313A7B693A353B613A313A7B733A31363A22696D6167655F7374796C655F6C6F6164223B613A323A7B693A303B4E3B693A313B733A313A2231223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32333A2261646D696E697374657220696D616765207374796C6573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32333A22696D6167655F7374796C655F64656C6574655F666F726D223B693A313B693A353B7D, '', '62', '6', '0', '', 'admin/config/media/image-styles/delete/%', 'Delete style', 't', '', '', 'a:0:{}', '6', 'Delete an image style.', '', '0', 'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/edit/%', 0x613A313A7B693A353B733A31363A22696D6167655F7374796C655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A32333A2261646D696E697374657220696D616765207374796C6573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31363A22696D6167655F7374796C655F666F726D223B693A313B693A353B7D, '', '62', '6', '0', '', 'admin/config/media/image-styles/edit/%', 'Edit style', 't', '', '', 'a:0:{}', '6', 'Configure an image style.', '', '0', 'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/edit/%/add/%', 0x613A323A7B693A353B613A313A7B733A31363A22696D6167655F7374796C655F6C6F6164223B613A313A7B693A303B693A353B7D7D693A373B613A313A7B733A32383A22696D6167655F6566666563745F646566696E6974696F6E5F6C6F6164223B613A313A7B693A303B693A353B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32333A2261646D696E697374657220696D616765207374796C6573223B7D, 'drupal_get_form', 0x613A333A7B693A303B733A31373A22696D6167655F6566666563745F666F726D223B693A313B693A353B693A323B693A373B7D, '', '250', '8', '0', '', 'admin/config/media/image-styles/edit/%/add/%', 'Add image effect', 't', '', '', 'a:0:{}', '6', 'Add a new effect to a style.', '', '0', 'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/edit/%/effects/%', 0x613A323A7B693A353B613A313A7B733A31363A22696D6167655F7374796C655F6C6F6164223B613A323A7B693A303B693A353B693A313B733A313A2233223B7D7D693A373B613A313A7B733A31373A22696D6167655F6566666563745F6C6F6164223B613A323A7B693A303B693A353B693A313B733A313A2233223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32333A2261646D696E697374657220696D616765207374796C6573223B7D, 'drupal_get_form', 0x613A333A7B693A303B733A31373A22696D6167655F6566666563745F666F726D223B693A313B693A353B693A323B693A373B7D, '', '250', '8', '0', '', 'admin/config/media/image-styles/edit/%/effects/%', 'Edit image effect', 't', '', '', 'a:0:{}', '6', 'Edit an existing effect within a style.', '', '0', 'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/edit/%/effects/%/delete', 0x613A323A7B693A353B613A313A7B733A31363A22696D6167655F7374796C655F6C6F6164223B613A323A7B693A303B693A353B693A313B733A313A2233223B7D7D693A373B613A313A7B733A31373A22696D6167655F6566666563745F6C6F6164223B613A323A7B693A303B693A353B693A313B733A313A2233223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32333A2261646D696E697374657220696D616765207374796C6573223B7D, 'drupal_get_form', 0x613A333A7B693A303B733A32343A22696D6167655F6566666563745F64656C6574655F666F726D223B693A313B693A353B693A323B693A373B7D, '', '501', '9', '0', '', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'Delete image effect', 't', '', '', 'a:0:{}', '6', 'Delete an existing effect from a style.', '', '0', 'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/list', '', '', 'user_access', 0x613A313A7B693A303B733A32333A2261646D696E697374657220696D616765207374796C6573223B7D, 'image_style_list', 0x613A303A7B7D, '', '31', '5', '1', 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'List', 't', '', '', 'a:0:{}', '140', 'List the current image styles on the site.', '', '1', 'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/revert/%', 0x613A313A7B693A353B613A313A7B733A31363A22696D6167655F7374796C655F6C6F6164223B613A323A7B693A303B4E3B693A313B733A313A2232223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32333A2261646D696E697374657220696D616765207374796C6573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32333A22696D6167655F7374796C655F7265766572745F666F726D223B693A313B693A353B7D, '', '62', '6', '0', '', 'admin/config/media/image-styles/revert/%', 'Revert style', 't', '', '', 'a:0:{}', '6', 'Revert an image style.', '', '0', 'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-toolkit', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32393A2273797374656D5F696D6167655F746F6F6C6B69745F73657474696E6773223B7D, '', '15', '4', '0', '', 'admin/config/media/image-toolkit', 'Image toolkit', 't', '', '', 'a:0:{}', '6', 'Choose which image toolkit to use if you have installed optional toolkits.', '', '20', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/config/people', 'People', 't', '', '', 'a:0:{}', '6', 'Configure user accounts.', 'left', '-20', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts', '', '', 'user_access', 0x613A313A7B693A303B733A31363A2261646D696E6973746572207573657273223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A31393A22757365725F61646D696E5F73657474696E6773223B7D, '', '15', '4', '0', '', 'admin/config/people/accounts', 'Account settings', 't', '', '', 'a:0:{}', '6', 'Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.', '', '-10', 'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/display', '', '', 'user_access', 0x613A313A7B693A303B733A31363A2261646D696E6973746572207573657273223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A343A2275736572223B693A323B733A343A2275736572223B693A333B733A373A2264656661756C74223B7D, '', '31', '5', '1', 'admin/config/people/accounts', 'admin/config/people/accounts', 'Manage display', 't', '', '', 'a:0:{}', '132', '', '', '2', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/display/default', '', '', '_field_ui_view_mode_menu_access', 0x613A353A7B693A303B733A343A2275736572223B693A313B733A343A2275736572223B693A323B733A373A2264656661756C74223B693A333B733A31313A22757365725F616363657373223B693A343B733A31363A2261646D696E6973746572207573657273223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A343A2275736572223B693A323B733A343A2275736572223B693A333B733A373A2264656661756C74223B7D, '', '63', '6', '1', 'admin/config/people/accounts/display', 'admin/config/people/accounts', 'Default', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/display/full', '', '', '_field_ui_view_mode_menu_access', 0x613A353A7B693A303B733A343A2275736572223B693A313B733A343A2275736572223B693A323B733A343A2266756C6C223B693A333B733A31313A22757365725F616363657373223B693A343B733A31363A2261646D696E6973746572207573657273223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A343A2275736572223B693A323B733A343A2275736572223B693A333B733A343A2266756C6C223B7D, '', '63', '6', '1', 'admin/config/people/accounts/display', 'admin/config/people/accounts', 'User account', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields', '', '', 'user_access', 0x613A313A7B693A303B733A31363A2261646D696E6973746572207573657273223B7D, 'drupal_get_form', 0x613A333A7B693A303B733A32383A226669656C645F75695F6669656C645F6F766572766965775F666F726D223B693A313B733A343A2275736572223B693A323B733A343A2275736572223B7D, '', '31', '5', '1', 'admin/config/people/accounts', 'admin/config/people/accounts', 'Manage fields', 't', '', '', 'a:0:{}', '132', '', '', '1', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%', 0x613A313A7B693A353B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A343A2275736572223B693A313B733A343A2275736572223B693A323B733A313A2230223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A31363A2261646D696E6973746572207573657273223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32343A226669656C645F75695F6669656C645F656469745F666F726D223B693A313B693A353B7D, '', '62', '6', '0', '', 'admin/config/people/accounts/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:5;}', '', 'a:0:{}', '6', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%/delete', 0x613A313A7B693A353B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A343A2275736572223B693A313B733A343A2275736572223B693A323B733A313A2230223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A31363A2261646D696E6973746572207573657273223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32363A226669656C645F75695F6669656C645F64656C6574655F666F726D223B693A313B693A353B7D, '', '125', '7', '1', 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Delete', 't', '', '', 'a:0:{}', '132', '', '', '10', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%/edit', 0x613A313A7B693A353B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A343A2275736572223B693A313B733A343A2275736572223B693A323B733A313A2230223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A31363A2261646D696E6973746572207573657273223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32343A226669656C645F75695F6669656C645F656469745F666F726D223B693A313B693A353B7D, '', '125', '7', '1', 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Edit', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%/field-settings', 0x613A313A7B693A353B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A343A2275736572223B693A313B733A343A2275736572223B693A323B733A313A2230223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A31363A2261646D696E6973746572207573657273223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32383A226669656C645F75695F6669656C645F73657474696E67735F666F726D223B693A313B693A353B7D, '', '125', '7', '1', 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Field settings', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%/widget-type', 0x613A313A7B693A353B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A343A2275736572223B693A313B733A343A2275736572223B693A323B733A313A2230223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A31363A2261646D696E6973746572207573657273223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32353A226669656C645F75695F7769646765745F747970655F666F726D223B693A313B693A353B7D, '', '125', '7', '1', 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Widget type', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/settings', '', '', 'user_access', 0x613A313A7B693A303B733A31363A2261646D696E6973746572207573657273223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A31393A22757365725F61646D696E5F73657474696E6773223B7D, '', '31', '5', '1', 'admin/config/people/accounts', 'admin/config/people/accounts', 'Settings', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/ip-blocking', '', '', 'user_access', 0x613A313A7B693A303B733A31383A22626C6F636B20495020616464726573736573223B7D, 'system_ip_blocking', 0x613A303A7B7D, '', '15', '4', '0', '', 'admin/config/people/ip-blocking', 'IP address blocking', 't', '', '', 'a:0:{}', '6', 'Manage blocked IP addresses.', '', '10', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/ip-blocking/delete/%', 0x613A313A7B693A353B733A31353A22626C6F636B65645F69705F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31383A22626C6F636B20495020616464726573736573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32353A2273797374656D5F69705F626C6F636B696E675F64656C657465223B693A313B693A353B7D, '', '62', '6', '0', '', 'admin/config/people/ip-blocking/delete/%', 'Delete IP address', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/config/regional', 'Regional and language', 't', '', '', 'a:0:{}', '6', 'Regional settings, localization and translation.', 'left', '-5', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32353A2273797374656D5F646174655F74696D655F73657474696E6773223B7D, '', '15', '4', '0', '', 'admin/config/regional/date-time', 'Date and time', 't', '', '', 'a:0:{}', '6', 'Configure display formats for date and time.', '', '-15', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'system_date_time_formats', 0x613A303A7B7D, '', '31', '5', '1', 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Formats', 't', '', '', 'a:0:{}', '132', 'Configure display format strings for date and time.', '', '-9', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats/%/delete', 0x613A313A7B693A353B4E3B7D, '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A33303A2273797374656D5F646174655F64656C6574655F666F726D61745F666F726D223B693A313B693A353B7D, '', '125', '7', '0', '', 'admin/config/regional/date-time/formats/%/delete', 'Delete date format', 't', '', '', 'a:0:{}', '6', 'Allow users to delete a configured date format.', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats/%/edit', 0x613A313A7B693A353B4E3B7D, '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A33343A2273797374656D5F636F6E6669677572655F646174655F666F726D6174735F666F726D223B693A313B693A353B7D, '', '125', '7', '0', '', 'admin/config/regional/date-time/formats/%/edit', 'Edit date format', 't', '', '', 'a:0:{}', '6', 'Allow users to edit a configured date format.', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats/add', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A33343A2273797374656D5F636F6E6669677572655F646174655F666F726D6174735F666F726D223B7D, '', '63', '6', '1', 'admin/config/regional/date-time/formats', 'admin/config/regional/date-time', 'Add format', 't', '', '', 'a:0:{}', '388', 'Allow users to add additional date formats.', '', '-10', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats/lookup', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'system_date_time_lookup', 0x613A303A7B7D, '', '63', '6', '0', '', 'admin/config/regional/date-time/formats/lookup', 'Date and time lookup', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/types', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32353A2273797374656D5F646174655F74696D655F73657474696E6773223B7D, '', '31', '5', '1', 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Types', 't', '', '', 'a:0:{}', '140', 'Configure display formats for date and time.', '', '-10', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/types/%/delete', 0x613A313A7B693A353B4E3B7D, '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A33353A2273797374656D5F64656C6574655F646174655F666F726D61745F747970655F666F726D223B693A313B693A353B7D, '', '125', '7', '0', '', 'admin/config/regional/date-time/types/%/delete', 'Delete date type', 't', '', '', 'a:0:{}', '6', 'Allow users to delete a configured date type.', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/types/add', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A33323A2273797374656D5F6164645F646174655F666F726D61745F747970655F666F726D223B7D, '', '63', '6', '1', 'admin/config/regional/date-time/types', 'admin/config/regional/date-time', 'Add date type', 't', '', '', 'a:0:{}', '388', 'Add new date type.', '', '-10', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/settings', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32343A2273797374656D5F726567696F6E616C5F73657474696E6773223B7D, '', '15', '4', '0', '', 'admin/config/regional/settings', 'Regional settings', 't', '', '', 'a:0:{}', '6', 'Settings for the site\'s default time zone and country.', '', '-20', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/config/search', 'Search and metadata', 't', '', '', 'a:0:{}', '6', 'Local site search, metadata and SEO.', 'left', '-10', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/clean-urls', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32353A2273797374656D5F636C65616E5F75726C5F73657474696E6773223B7D, '', '15', '4', '0', '', 'admin/config/search/clean-urls', 'Clean URLs', 't', '', '', 'a:0:{}', '6', 'Enable or disable clean URLs for your site.', '', '5', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/clean-urls/check', '', '', '1', 0x613A303A7B7D, 'drupal_json_output', 0x613A313A7B693A303B613A313A7B733A363A22737461747573223B623A313B7D7D, '', '31', '5', '0', '', 'admin/config/search/clean-urls/check', 'Clean URL check', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path', '', '', 'user_access', 0x613A313A7B693A303B733A32323A2261646D696E69737465722075726C20616C6961736573223B7D, 'path_admin_overview', 0x613A303A7B7D, '', '15', '4', '0', '', 'admin/config/search/path', 'URL aliases', 't', '', '', 'a:0:{}', '6', 'Change your site\'s URL paths by aliasing them.', '', '-5', 'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path/add', '', '', 'user_access', 0x613A313A7B693A303B733A32323A2261646D696E69737465722075726C20616C6961736573223B7D, 'path_admin_edit', 0x613A303A7B7D, '', '31', '5', '1', 'admin/config/search/path', 'admin/config/search/path', 'Add alias', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path/delete/%', 0x613A313A7B693A353B733A393A22706174685F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A32323A2261646D696E69737465722075726C20616C6961736573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32353A22706174685F61646D696E5F64656C6574655F636F6E6669726D223B693A313B693A353B7D, '', '62', '6', '0', '', 'admin/config/search/path/delete/%', 'Delete alias', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path/edit/%', 0x613A313A7B693A353B733A393A22706174685F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A32323A2261646D696E69737465722075726C20616C6961736573223B7D, 'path_admin_edit', 0x613A313A7B693A303B693A353B7D, '', '62', '6', '0', '', 'admin/config/search/path/edit/%', 'Edit alias', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path/list', '', '', 'user_access', 0x613A313A7B693A303B733A32323A2261646D696E69737465722075726C20616C6961736573223B7D, 'path_admin_overview', 0x613A303A7B7D, '', '31', '5', '1', 'admin/config/search/path', 'admin/config/search/path', 'List', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/settings', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220736561726368223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32313A227365617263685F61646D696E5F73657474696E6773223B7D, '', '15', '4', '0', '', 'admin/config/search/settings', 'Search settings', 't', '', '', 'a:0:{}', '6', 'Configure relevance settings for search and other indexing options.', '', '-10', 'modules/search/search.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/settings/reindex', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220736561726368223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32323A227365617263685F7265696E6465785F636F6E6669726D223B7D, '', '31', '5', '0', '', 'admin/config/search/settings/reindex', 'Clear index', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/search/search.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/services', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/config/services', 'Web services', 't', '', '', 'a:0:{}', '6', 'Tools related to web services.', 'right', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/services/rss-publishing', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32353A2273797374656D5F7273735F66656564735F73657474696E6773223B7D, '', '15', '4', '0', '', 'admin/config/services/rss-publishing', 'RSS publishing', 't', '', '', 'a:0:{}', '6', 'Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/config/system', 'System', 't', '', '', 'a:0:{}', '6', 'General system related configuration.', 'right', '-20', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions', '', '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E697374657220616374696F6E73223B7D, 'system_actions_manage', 0x613A303A7B7D, '', '15', '4', '0', '', 'admin/config/system/actions', 'Actions', 't', '', '', 'a:0:{}', '6', 'Manage the actions defined for your site.', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions/configure', '', '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E697374657220616374696F6E73223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32343A2273797374656D5F616374696F6E735F636F6E666967757265223B7D, '', '31', '5', '0', '', 'admin/config/system/actions/configure', 'Configure an advanced action', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions/delete/%', 0x613A313A7B693A353B733A31323A22616374696F6E735F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E697374657220616374696F6E73223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32363A2273797374656D5F616374696F6E735F64656C6574655F666F726D223B693A313B693A353B7D, '', '62', '6', '0', '', 'admin/config/system/actions/delete/%', 'Delete action', 't', '', '', 'a:0:{}', '6', 'Delete an action.', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions/manage', '', '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E697374657220616374696F6E73223B7D, 'system_actions_manage', 0x613A303A7B7D, '', '31', '5', '1', 'admin/config/system/actions', 'admin/config/system/actions', 'Manage actions', 't', '', '', 'a:0:{}', '140', 'Manage the actions defined for your site.', '', '-2', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions/orphan', '', '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E697374657220616374696F6E73223B7D, 'system_actions_remove_orphans', 0x613A303A7B7D, '', '31', '5', '0', '', 'admin/config/system/actions/orphan', 'Remove orphans', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/cron', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32303A2273797374656D5F63726F6E5F73657474696E6773223B7D, '', '15', '4', '0', '', 'admin/config/system/cron', 'Cron', 't', '', '', 'a:0:{}', '6', 'Manage automatic site maintenance tasks.', '', '20', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/site-information', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A33323A2273797374656D5F736974655F696E666F726D6174696F6E5F73657474696E6773223B7D, '', '15', '4', '0', '', 'admin/config/system/site-information', 'Site information', 't', '', '', 'a:0:{}', '6', 'Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.', '', '-20', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/config/user-interface', 'User interface', 't', '', '', 'a:0:{}', '6', 'Tools that enhance the user interface.', 'right', '-15', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut', '', '', 'user_access', 0x613A313A7B693A303B733A32303A2261646D696E69737465722073686F727463757473223B7D, 'shortcut_set_admin', 0x613A303A7B7D, '', '15', '4', '0', '', 'admin/config/user-interface/shortcut', 'Shortcuts', 't', '', '', 'a:0:{}', '6', 'Add and modify shortcut sets.', '', '0', 'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%', 0x613A313A7B693A343B733A31373A2273686F72746375745F7365745F6C6F6164223B7D, '', 'shortcut_set_edit_access', 0x613A313A7B693A303B693A343B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32323A2273686F72746375745F7365745F637573746F6D697A65223B693A313B693A343B7D, '', '30', '5', '0', '', 'admin/config/user-interface/shortcut/%', 'Edit shortcuts', 'shortcut_set_title_callback', 'a:1:{i:0;i:4;}', '', 'a:0:{}', '6', '', '', '0', 'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/add-link', 0x613A313A7B693A343B733A31373A2273686F72746375745F7365745F6C6F6164223B7D, '', 'shortcut_set_edit_access', 0x613A313A7B693A303B693A343B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31373A2273686F72746375745F6C696E6B5F616464223B693A313B693A343B7D, '', '61', '6', '1', 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Add shortcut', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/add-link-inline', 0x613A313A7B693A343B733A31373A2273686F72746375745F7365745F6C6F6164223B7D, '', 'shortcut_set_edit_access', 0x613A313A7B693A303B693A343B7D, 'shortcut_link_add_inline', 0x613A313A7B693A303B693A343B7D, '', '61', '6', '0', '', 'admin/config/user-interface/shortcut/%/add-link-inline', 'Add shortcut', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/delete', 0x613A313A7B693A343B733A31373A2273686F72746375745F7365745F6C6F6164223B7D, '', 'shortcut_set_delete_access', 0x613A313A7B693A303B693A343B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32343A2273686F72746375745F7365745F64656C6574655F666F726D223B693A313B693A343B7D, '', '61', '6', '0', '', 'admin/config/user-interface/shortcut/%/delete', 'Delete shortcut set', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/edit', 0x613A313A7B693A343B733A31373A2273686F72746375745F7365745F6C6F6164223B7D, '', 'shortcut_set_edit_access', 0x613A313A7B693A303B693A343B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32323A2273686F72746375745F7365745F656469745F666F726D223B693A313B693A343B7D, '', '61', '6', '1', 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Edit set name', 't', '', '', 'a:0:{}', '132', '', '', '10', 'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/links', 0x613A313A7B693A343B733A31373A2273686F72746375745F7365745F6C6F6164223B7D, '', 'shortcut_set_edit_access', 0x613A313A7B693A303B693A343B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32323A2273686F72746375745F7365745F637573746F6D697A65223B693A313B693A343B7D, '', '61', '6', '1', 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'List links', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/add-set', '', '', 'user_access', 0x613A313A7B693A303B733A32303A2261646D696E69737465722073686F727463757473223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32313A2273686F72746375745F7365745F6164645F666F726D223B7D, '', '31', '5', '1', 'admin/config/user-interface/shortcut', 'admin/config/user-interface/shortcut', 'Add shortcut set', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/link/%', 0x613A313A7B693A353B733A31343A226D656E755F6C696E6B5F6C6F6164223B7D, '', 'shortcut_link_access', 0x613A313A7B693A303B693A353B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31383A2273686F72746375745F6C696E6B5F65646974223B693A313B693A353B7D, '', '62', '6', '0', '', 'admin/config/user-interface/shortcut/link/%', 'Edit shortcut', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/link/%/delete', 0x613A313A7B693A353B733A31343A226D656E755F6C696E6B5F6C6F6164223B7D, '', 'shortcut_link_access', 0x613A313A7B693A303B693A353B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32303A2273686F72746375745F6C696E6B5F64656C657465223B693A313B693A353B7D, '', '125', '7', '0', '', 'admin/config/user-interface/shortcut/link/%/delete', 'Delete shortcut', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/workflow', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/config/workflow', 'Workflow', 't', '', '', 'a:0:{}', '6', 'Content workflow, editorial workflow tools.', 'right', '5', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content', '', '', 'user_access', 0x613A313A7B693A303B733A32333A2261636365737320636F6E74656E74206F76657276696577223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A31383A226E6F64655F61646D696E5F636F6E74656E74223B7D, '', '3', '2', '0', '', 'admin/content', 'Content', 't', '', '', 'a:0:{}', '6', 'Administer content and comments.', '', '-10', 'modules/node/node.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content/comment', '', '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E697374657220636F6D6D656E7473223B7D, 'comment_admin', 0x613A303A7B7D, '', '7', '3', '1', 'admin/content', 'admin/content', 'Comments', 't', '', '', 'a:0:{}', '134', 'List and edit site comments and the comment approval queue.', '', '0', 'modules/comment/comment.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content/comment/approval', '', '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E697374657220636F6D6D656E7473223B7D, 'comment_admin', 0x613A313A7B693A303B733A383A22617070726F76616C223B7D, '', '15', '4', '1', 'admin/content/comment', 'admin/content', 'Unapproved comments', 'comment_count_unpublished', '', '', 'a:0:{}', '132', '', '', '0', 'modules/comment/comment.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content/comment/new', '', '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E697374657220636F6D6D656E7473223B7D, 'comment_admin', 0x613A303A7B7D, '', '15', '4', '1', 'admin/content/comment', 'admin/content', 'Published comments', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/comment/comment.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content/node', '', '', 'user_access', 0x613A313A7B693A303B733A32333A2261636365737320636F6E74656E74206F76657276696577223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A31383A226E6F64655F61646D696E5F636F6E74656E74223B7D, '', '7', '3', '1', 'admin/content', 'admin/content', 'Content', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/node/node.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/dashboard', '', '', 'user_access', 0x613A313A7B693A303B733A31363A226163636573732064617368626F617264223B7D, 'dashboard_admin', 0x613A303A7B7D, '', '3', '2', '0', '', 'admin/dashboard', 'Dashboard', 't', '', '', 'a:0:{}', '6', 'View and customize your dashboard.', '', '-15', '');
INSERT INTO `menu_router` VALUES ('admin/dashboard/block-content/%/%', 0x613A323A7B693A333B4E3B693A343B4E3B7D, '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'dashboard_show_block_content', 0x613A323A7B693A303B693A333B693A313B693A343B7D, '', '28', '5', '0', '', 'admin/dashboard/block-content/%/%', '', 't', '', '', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('admin/dashboard/configure', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'dashboard_admin_blocks', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/dashboard/configure', 'Configure available dashboard blocks', 't', '', '', 'a:0:{}', '4', 'Configure which blocks can be shown on the dashboard.', '', '0', '');
INSERT INTO `menu_router` VALUES ('admin/dashboard/customize', '', '', 'user_access', 0x613A313A7B693A303B733A31363A226163636573732064617368626F617264223B7D, 'dashboard_admin', 0x613A313A7B693A303B623A313B7D, '', '7', '3', '0', '', 'admin/dashboard/customize', 'Customize dashboard', 't', '', '', 'a:0:{}', '4', 'Customize your dashboard.', '', '0', '');
INSERT INTO `menu_router` VALUES ('admin/dashboard/drawer', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'dashboard_show_disabled', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/dashboard/drawer', '', 't', '', '', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('admin/dashboard/update', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'dashboard_update', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/dashboard/update', '', 't', '', '', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('admin/help', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_main', 0x613A303A7B7D, '', '3', '2', '0', '', 'admin/help', 'Help', 't', '', '', 'a:0:{}', '6', 'Reference for usage, configuration, and modules.', '', '9', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/block', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/block', 'block', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/color', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/color', 'color', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/comment', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/comment', 'comment', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/contextual', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/contextual', 'contextual', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/dashboard', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/dashboard', 'dashboard', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/dblog', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/dblog', 'dblog', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/field', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/field', 'field', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/field_sql_storage', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/field_sql_storage', 'field_sql_storage', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/field_ui', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/field_ui', 'field_ui', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/file', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/file', 'file', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/filter', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/filter', 'filter', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/help', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/help', 'help', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/image', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/image', 'image', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/list', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/list', 'list', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/menu', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/menu', 'menu', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/node', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/node', 'node', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/number', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/number', 'number', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/options', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/options', 'options', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/path', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/path', 'path', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/rdf', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/rdf', 'rdf', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/search', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/search', 'search', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/shortcut', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/shortcut', 'shortcut', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/system', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/system', 'system', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/taxonomy', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/taxonomy', 'taxonomy', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/text', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/text', 'text', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/toolbar', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/toolbar', 'toolbar', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/user', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'help_page', 0x613A313A7B693A303B693A323B7D, '', '7', '3', '0', '', 'admin/help/user', 'user', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/index', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_index', 0x613A303A7B7D, '', '3', '2', '1', 'admin', 'admin', 'Index', 't', '', '', 'a:0:{}', '132', '', '', '-18', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules', '', '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E6973746572206D6F64756C6573223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A31343A2273797374656D5F6D6F64756C6573223B7D, '', '3', '2', '0', '', 'admin/modules', 'Modules', 't', '', '', 'a:0:{}', '6', 'Extend site functionality.', '', '-2', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/list', '', '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E6973746572206D6F64756C6573223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A31343A2273797374656D5F6D6F64756C6573223B7D, '', '7', '3', '1', 'admin/modules', 'admin/modules', 'List', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/list/confirm', '', '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E6973746572206D6F64756C6573223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A31343A2273797374656D5F6D6F64756C6573223B7D, '', '15', '4', '0', '', 'admin/modules/list/confirm', 'List', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/uninstall', '', '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E6973746572206D6F64756C6573223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32343A2273797374656D5F6D6F64756C65735F756E696E7374616C6C223B7D, '', '7', '3', '1', 'admin/modules', 'admin/modules', 'Uninstall', 't', '', '', 'a:0:{}', '132', '', '', '20', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/uninstall/confirm', '', '', 'user_access', 0x613A313A7B693A303B733A31383A2261646D696E6973746572206D6F64756C6573223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32343A2273797374656D5F6D6F64756C65735F756E696E7374616C6C223B7D, '', '15', '4', '0', '', 'admin/modules/uninstall/confirm', 'Uninstall', 't', '', '', 'a:0:{}', '4', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people', '', '', 'user_access', 0x613A313A7B693A303B733A31363A2261646D696E6973746572207573657273223B7D, 'user_admin', 0x613A313A7B693A303B733A343A226C697374223B7D, '', '3', '2', '0', '', 'admin/people', 'People', 't', '', '', 'a:0:{}', '6', 'Manage user accounts, roles, and permissions.', 'left', '-4', 'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/create', '', '', 'user_access', 0x613A313A7B693A303B733A31363A2261646D696E6973746572207573657273223B7D, 'user_admin', 0x613A313A7B693A303B733A363A22637265617465223B7D, '', '7', '3', '1', 'admin/people', 'admin/people', 'Add user', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/people', '', '', 'user_access', 0x613A313A7B693A303B733A31363A2261646D696E6973746572207573657273223B7D, 'user_admin', 0x613A313A7B693A303B733A343A226C697374223B7D, '', '7', '3', '1', 'admin/people', 'admin/people', 'List', 't', '', '', 'a:0:{}', '140', 'Find and manage people interacting with your site.', '', '-10', 'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions', '', '', 'user_access', 0x613A313A7B693A303B733A32323A2261646D696E6973746572207065726D697373696F6E73223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32323A22757365725F61646D696E5F7065726D697373696F6E73223B7D, '', '7', '3', '1', 'admin/people', 'admin/people', 'Permissions', 't', '', '', 'a:0:{}', '132', 'Determine access to features by selecting permissions for roles.', '', '0', 'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions/list', '', '', 'user_access', 0x613A313A7B693A303B733A32323A2261646D696E6973746572207065726D697373696F6E73223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32323A22757365725F61646D696E5F7065726D697373696F6E73223B7D, '', '15', '4', '1', 'admin/people/permissions', 'admin/people', 'Permissions', 't', '', '', 'a:0:{}', '140', 'Determine access to features by selecting permissions for roles.', '', '-8', 'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions/roles', '', '', 'user_access', 0x613A313A7B693A303B733A32323A2261646D696E6973746572207065726D697373696F6E73223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A31363A22757365725F61646D696E5F726F6C6573223B7D, '', '15', '4', '1', 'admin/people/permissions', 'admin/people', 'Roles', 't', '', '', 'a:0:{}', '132', 'List, edit, or add user roles.', '', '-5', 'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions/roles/delete/%', 0x613A313A7B693A353B733A31343A22757365725F726F6C655F6C6F6164223B7D, '', 'user_role_edit_access', 0x613A313A7B693A303B693A353B7D, 'drupal_get_form', 0x613A323A7B693A303B733A33303A22757365725F61646D696E5F726F6C655F64656C6574655F636F6E6669726D223B693A313B693A353B7D, '', '62', '6', '0', '', 'admin/people/permissions/roles/delete/%', 'Delete role', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions/roles/edit/%', 0x613A313A7B693A353B733A31343A22757365725F726F6C655F6C6F6164223B7D, '', 'user_role_edit_access', 0x613A313A7B693A303B693A353B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31353A22757365725F61646D696E5F726F6C65223B693A313B693A353B7D, '', '62', '6', '0', '', 'admin/people/permissions/roles/edit/%', 'Edit role', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports', '', '', 'user_access', 0x613A313A7B693A303B733A31393A226163636573732073697465207265706F727473223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '3', '2', '0', '', 'admin/reports', 'Reports', 't', '', '', 'a:0:{}', '6', 'View reports, updates, and errors.', 'left', '5', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/access-denied', '', '', 'user_access', 0x613A313A7B693A303B733A31393A226163636573732073697465207265706F727473223B7D, 'dblog_top', 0x613A313A7B693A303B733A31333A226163636573732064656E696564223B7D, '', '7', '3', '0', '', 'admin/reports/access-denied', 'Top \'access denied\' errors', 't', '', '', 'a:0:{}', '6', 'View \'access denied\' errors (403s).', '', '0', 'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/dblog', '', '', 'user_access', 0x613A313A7B693A303B733A31393A226163636573732073697465207265706F727473223B7D, 'dblog_overview', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/reports/dblog', 'Recent log messages', 't', '', '', 'a:0:{}', '6', 'View events that have recently been logged.', '', '-1', 'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/event/%', 0x613A313A7B693A333B4E3B7D, '', 'user_access', 0x613A313A7B693A303B733A31393A226163636573732073697465207265706F727473223B7D, 'dblog_event', 0x613A313A7B693A303B693A333B7D, '', '14', '4', '0', '', 'admin/reports/event/%', 'Details', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/fields', '', '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'field_ui_fields_list', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/reports/fields', 'Field list', 't', '', '', 'a:0:{}', '6', 'Overview of fields on all entity types.', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/page-not-found', '', '', 'user_access', 0x613A313A7B693A303B733A31393A226163636573732073697465207265706F727473223B7D, 'dblog_top', 0x613A313A7B693A303B733A31343A2270616765206E6F7420666F756E64223B7D, '', '7', '3', '0', '', 'admin/reports/page-not-found', 'Top \'page not found\' errors', 't', '', '', 'a:0:{}', '6', 'View \'page not found\' errors (404s).', '', '0', 'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/search', '', '', 'user_access', 0x613A313A7B693A303B733A31393A226163636573732073697465207265706F727473223B7D, 'dblog_top', 0x613A313A7B693A303B733A363A22736561726368223B7D, '', '7', '3', '0', '', 'admin/reports/search', 'Top search phrases', 't', '', '', 'a:0:{}', '6', 'View most popular search phrases.', '', '0', 'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/status', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'system_status', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/reports/status', 'Status report', 't', '', '', 'a:0:{}', '6', 'Get a status report about your site\'s operation and any detected problems.', '', '-60', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/status/php', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'system_php', 0x613A303A7B7D, '', '15', '4', '0', '', 'admin/reports/status/php', 'PHP', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/status/rebuild', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A33303A226E6F64655F636F6E6669677572655F72656275696C645F636F6E6669726D223B7D, '', '15', '4', '0', '', 'admin/reports/status/rebuild', 'Rebuild permissions', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/node/node.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/status/run-cron', '', '', 'user_access', 0x613A313A7B693A303B733A32393A2261646D696E6973746572207369746520636F6E66696775726174696F6E223B7D, 'system_run_cron', 0x613A303A7B7D, '', '15', '4', '0', '', 'admin/reports/status/run-cron', 'Run cron', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '3', '2', '0', '', 'admin/structure', 'Structure', 't', '', '', 'a:0:{}', '6', 'Administer blocks, content types, menus, etc.', 'right', '-8', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'block_admin_display', 0x613A313A7B693A303B733A31333A227468656D655F64656661756C74223B7D, '', '7', '3', '0', '', 'admin/structure/block', 'Blocks', 't', '', '', 'a:0:{}', '6', 'Configure what block content appears in your site\'s sidebars and other regions.', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/add', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32303A22626C6F636B5F6164645F626C6F636B5F666F726D223B7D, '', '15', '4', '1', 'admin/structure/block', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/bartik', '', '', '_block_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A32353A227468656D65732F62617274696B2F62617274696B2E696E666F223B733A343A226E616D65223B733A363A2262617274696B223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2231223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31393A7B733A343A226E616D65223B733A363A2242617274696B223B733A31313A226465736372697074696F6E223B733A34383A224120666C657869626C652C207265636F6C6F7261626C65207468656D652077697468206D616E7920726567696F6E732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A333A7B733A31343A226373732F6C61796F75742E637373223B733A32383A227468656D65732F62617274696B2F6373732F6C61796F75742E637373223B733A31333A226373732F7374796C652E637373223B733A32373A227468656D65732F62617274696B2F6373732F7374796C652E637373223B733A31343A226373732F636F6C6F72732E637373223B733A32383A227468656D65732F62617274696B2F6373732F636F6C6F72732E637373223B7D733A353A227072696E74223B613A313A7B733A31333A226373732F7072696E742E637373223B733A32373A227468656D65732F62617274696B2F6373732F7072696E742E637373223B7D7D733A373A22726567696F6E73223B613A32303A7B733A363A22686561646572223B733A363A22486561646572223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31313A22686967686C696768746564223B733A31313A22486967686C696768746564223B733A383A226665617475726564223B733A383A224665617475726564223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A31333A22736964656261725F6669727374223B733A31333A2253696465626172206669727374223B733A31343A22736964656261725F7365636F6E64223B733A31343A2253696465626172207365636F6E64223B733A31343A2274726970747963685F6669727374223B733A31343A225472697074796368206669727374223B733A31353A2274726970747963685F6D6964646C65223B733A31353A225472697074796368206D6964646C65223B733A31333A2274726970747963685F6C617374223B733A31333A225472697074796368206C617374223B733A31383A22666F6F7465725F6669727374636F6C756D6E223B733A31393A22466F6F74657220666972737420636F6C756D6E223B733A31393A22666F6F7465725F7365636F6E64636F6C756D6E223B733A32303A22466F6F746572207365636F6E6420636F6C756D6E223B733A31383A22666F6F7465725F7468697264636F6C756D6E223B733A31393A22466F6F74657220746869726420636F6C756D6E223B733A31393A22666F6F7465725F666F75727468636F6C756D6E223B733A32303A22466F6F74657220666F7572746820636F6C756D6E223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A383A2273657474696E6773223B613A313A7B733A32303A2273686F72746375745F6D6F64756C655F6C696E6B223B733A313A2230223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32383A227468656D65732F62617274696B2F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A333A7B733A31343A226373732F6C61796F75742E637373223B733A32383A227468656D65732F62617274696B2F6373732F6C61796F75742E637373223B733A31333A226373732F7374796C652E637373223B733A32373A227468656D65732F62617274696B2F6373732F7374796C652E637373223B733A31343A226373732F636F6C6F72732E637373223B733A32383A227468656D65732F62617274696B2F6373732F636F6C6F72732E637373223B7D733A353A227072696E74223B613A313A7B733A31333A226373732F7072696E742E637373223B733A32373A227468656D65732F62617274696B2F6373732F7072696E742E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'block_admin_demo', 0x613A313A7B693A303B733A363A2262617274696B223B7D, '', '31', '5', '0', '', 'admin/structure/block/demo/bartik', 'Bartik', 't', '', '_block_custom_theme', 'a:1:{i:0;s:6:\"bartik\";}', '0', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/garland', '', '', '_block_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A32373A227468656D65732F6761726C616E642F6761726C616E642E696E666F223B733A343A226E616D65223B733A373A226761726C616E64223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2230223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31393A7B733A343A226E616D65223B733A373A224761726C616E64223B733A31313A226465736372697074696F6E223B733A3131313A2241206D756C74692D636F6C756D6E207468656D652077686963682063616E20626520636F6E6669677572656420746F206D6F6469667920636F6C6F727320616E6420737769746368206265747765656E20666978656420616E6420666C756964207769647468206C61796F7574732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A313A7B733A393A227374796C652E637373223B733A32343A227468656D65732F6761726C616E642F7374796C652E637373223B7D733A353A227072696E74223B613A313A7B733A393A227072696E742E637373223B733A32343A227468656D65732F6761726C616E642F7072696E742E637373223B7D7D733A383A2273657474696E6773223B613A313A7B733A31333A226761726C616E645F7769647468223B733A353A22666C756964223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A373A22726567696F6E73223B613A31323A7B733A31333A22736964656261725F6669727374223B733A31323A224C6566742073696465626172223B733A31343A22736964656261725F7365636F6E64223B733A31333A2252696768742073696465626172223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A363A22686561646572223B733A363A22486561646572223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31313A22686967686C696768746564223B733A31313A22486967686C696768746564223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32393A227468656D65732F6761726C616E642F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A313A7B733A393A227374796C652E637373223B733A32343A227468656D65732F6761726C616E642F7374796C652E637373223B7D733A353A227072696E74223B613A313A7B733A393A227072696E742E637373223B733A32343A227468656D65732F6761726C616E642F7072696E742E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'block_admin_demo', 0x613A313A7B693A303B733A373A226761726C616E64223B7D, '', '31', '5', '0', '', 'admin/structure/block/demo/garland', 'Garland', 't', '', '_block_custom_theme', 'a:1:{i:0;s:7:\"garland\";}', '0', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/seven', '', '', '_block_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A32333A227468656D65732F736576656E2F736576656E2E696E666F223B733A343A226E616D65223B733A353A22736576656E223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2231223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31393A7B733A343A226E616D65223B733A353A22536576656E223B733A31313A226465736372697074696F6E223B733A36353A22412073696D706C65206F6E652D636F6C756D6E2C207461626C656C6573732C20666C7569642077696474682061646D696E697374726174696F6E207468656D652E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A313A7B733A363A2273637265656E223B613A323A7B733A393A2272657365742E637373223B733A32323A227468656D65732F736576656E2F72657365742E637373223B733A393A227374796C652E637373223B733A32323A227468656D65732F736576656E2F7374796C652E637373223B7D7D733A383A2273657474696E6773223B613A313A7B733A32303A2273686F72746375745F6D6F64756C655F6C696E6B223B733A313A2231223B7D733A373A22726567696F6E73223B613A383A7B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31333A22736964656261725F6669727374223B733A31333A2246697273742073696465626172223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A31343A22726567696F6E735F68696464656E223B613A333A7B693A303B733A31333A22736964656261725F6669727374223B693A313B733A383A22706167655F746F70223B693A323B733A31313A22706167655F626F74746F6D223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32373A227468656D65732F736576656E2F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A313A7B733A363A2273637265656E223B613A323A7B733A393A2272657365742E637373223B733A32323A227468656D65732F736576656E2F72657365742E637373223B733A393A227374796C652E637373223B733A32323A227468656D65732F736576656E2F7374796C652E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'block_admin_demo', 0x613A313A7B693A303B733A353A22736576656E223B7D, '', '31', '5', '0', '', 'admin/structure/block/demo/seven', 'Seven', 't', '', '_block_custom_theme', 'a:1:{i:0;s:5:\"seven\";}', '0', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/stark', '', '', '_block_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A32333A227468656D65732F737461726B2F737461726B2E696E666F223B733A343A226E616D65223B733A353A22737461726B223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2230223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31383A7B733A343A226E616D65223B733A353A22537461726B223B733A31313A226465736372697074696F6E223B733A3230383A2254686973207468656D652064656D6F6E737472617465732044727570616C27732064656661756C742048544D4C206D61726B757020616E6420435353207374796C65732E20546F206C6561726E20686F7720746F206275696C6420796F7572206F776E207468656D6520616E64206F766572726964652044727570616C27732064656661756C7420636F64652C2073656520746865203C6120687265663D22687474703A2F2F64727570616C2E6F72672F7468656D652D6775696465223E5468656D696E672047756964653C2F613E2E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31303A226C61796F75742E637373223B733A32333A227468656D65732F737461726B2F6C61796F75742E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A373A22726567696F6E73223B613A31323A7B733A31333A22736964656261725F6669727374223B733A31323A224C6566742073696465626172223B733A31343A22736964656261725F7365636F6E64223B733A31333A2252696768742073696465626172223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A363A22686561646572223B733A363A22486561646572223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31313A22686967686C696768746564223B733A31313A22486967686C696768746564223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32373A227468656D65732F737461726B2F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31303A226C61796F75742E637373223B733A32333A227468656D65732F737461726B2F6C61796F75742E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'block_admin_demo', 0x613A313A7B693A303B733A353A22737461726B223B7D, '', '31', '5', '0', '', 'admin/structure/block/demo/stark', 'Stark', 't', '', '_block_custom_theme', 'a:1:{i:0;s:5:\"stark\";}', '0', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/theme_default', '', '', '_block_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A34393A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F7468656D655F64656661756C742E696E666F223B733A343A226E616D65223B733A31333A227468656D655F64656661756C74223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2231223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31373A7B733A343A226E616D65223B733A31333A2264656661756C74207468656D65223B733A31313A226465736372697074696F6E223B733A31333A2264656661756C74207468656D65223B733A343A22636F7265223B733A333A22372E78223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A373A2276657273696F6E223B733A333A22372E78223B733A373A2270726F6A656374223B733A31333A2264656661756C74207468656D65223B733A393A22646174657374616D70223B733A31303A2231333332353137383436223B733A373A22726567696F6E73223B613A383A7B733A363A22686561646572223B733A363A22486561646572223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A343A226C656674223B733A343A224C656674223B733A353A227269676874223B733A353A225269676874223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31333A226373732F7374796C652E637373223B733A34343A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F6373732F7374796C652E637373223B7D7D733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A34353A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383331353630373B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31333A226373732F7374796C652E637373223B733A34343A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F6373732F7374796C652E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'block_admin_demo', 0x613A313A7B693A303B733A31333A227468656D655F64656661756C74223B7D, '', '31', '5', '0', '', 'admin/structure/block/demo/theme_default', 'default theme', 't', '', '_block_custom_theme', 'a:1:{i:0;s:13:\"theme_default\";}', '0', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/bartik', '', '', '_block_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A32353A227468656D65732F62617274696B2F62617274696B2E696E666F223B733A343A226E616D65223B733A363A2262617274696B223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2231223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31393A7B733A343A226E616D65223B733A363A2242617274696B223B733A31313A226465736372697074696F6E223B733A34383A224120666C657869626C652C207265636F6C6F7261626C65207468656D652077697468206D616E7920726567696F6E732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A333A7B733A31343A226373732F6C61796F75742E637373223B733A32383A227468656D65732F62617274696B2F6373732F6C61796F75742E637373223B733A31333A226373732F7374796C652E637373223B733A32373A227468656D65732F62617274696B2F6373732F7374796C652E637373223B733A31343A226373732F636F6C6F72732E637373223B733A32383A227468656D65732F62617274696B2F6373732F636F6C6F72732E637373223B7D733A353A227072696E74223B613A313A7B733A31333A226373732F7072696E742E637373223B733A32373A227468656D65732F62617274696B2F6373732F7072696E742E637373223B7D7D733A373A22726567696F6E73223B613A32303A7B733A363A22686561646572223B733A363A22486561646572223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31313A22686967686C696768746564223B733A31313A22486967686C696768746564223B733A383A226665617475726564223B733A383A224665617475726564223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A31333A22736964656261725F6669727374223B733A31333A2253696465626172206669727374223B733A31343A22736964656261725F7365636F6E64223B733A31343A2253696465626172207365636F6E64223B733A31343A2274726970747963685F6669727374223B733A31343A225472697074796368206669727374223B733A31353A2274726970747963685F6D6964646C65223B733A31353A225472697074796368206D6964646C65223B733A31333A2274726970747963685F6C617374223B733A31333A225472697074796368206C617374223B733A31383A22666F6F7465725F6669727374636F6C756D6E223B733A31393A22466F6F74657220666972737420636F6C756D6E223B733A31393A22666F6F7465725F7365636F6E64636F6C756D6E223B733A32303A22466F6F746572207365636F6E6420636F6C756D6E223B733A31383A22666F6F7465725F7468697264636F6C756D6E223B733A31393A22466F6F74657220746869726420636F6C756D6E223B733A31393A22666F6F7465725F666F75727468636F6C756D6E223B733A32303A22466F6F74657220666F7572746820636F6C756D6E223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A383A2273657474696E6773223B613A313A7B733A32303A2273686F72746375745F6D6F64756C655F6C696E6B223B733A313A2230223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32383A227468656D65732F62617274696B2F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A333A7B733A31343A226373732F6C61796F75742E637373223B733A32383A227468656D65732F62617274696B2F6373732F6C61796F75742E637373223B733A31333A226373732F7374796C652E637373223B733A32373A227468656D65732F62617274696B2F6373732F7374796C652E637373223B733A31343A226373732F636F6C6F72732E637373223B733A32383A227468656D65732F62617274696B2F6373732F636F6C6F72732E637373223B7D733A353A227072696E74223B613A313A7B733A31333A226373732F7072696E742E637373223B733A32373A227468656D65732F62617274696B2F6373732F7072696E742E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'block_admin_display', 0x613A313A7B693A303B733A363A2262617274696B223B7D, '', '31', '5', '1', 'admin/structure/block', 'admin/structure/block', 'Bartik', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/bartik/add', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32303A22626C6F636B5F6164645F626C6F636B5F666F726D223B7D, '', '63', '6', '1', 'admin/structure/block/list/bartik', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/garland', '', '', '_block_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A32373A227468656D65732F6761726C616E642F6761726C616E642E696E666F223B733A343A226E616D65223B733A373A226761726C616E64223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2230223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31393A7B733A343A226E616D65223B733A373A224761726C616E64223B733A31313A226465736372697074696F6E223B733A3131313A2241206D756C74692D636F6C756D6E207468656D652077686963682063616E20626520636F6E6669677572656420746F206D6F6469667920636F6C6F727320616E6420737769746368206265747765656E20666978656420616E6420666C756964207769647468206C61796F7574732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A313A7B733A393A227374796C652E637373223B733A32343A227468656D65732F6761726C616E642F7374796C652E637373223B7D733A353A227072696E74223B613A313A7B733A393A227072696E742E637373223B733A32343A227468656D65732F6761726C616E642F7072696E742E637373223B7D7D733A383A2273657474696E6773223B613A313A7B733A31333A226761726C616E645F7769647468223B733A353A22666C756964223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A373A22726567696F6E73223B613A31323A7B733A31333A22736964656261725F6669727374223B733A31323A224C6566742073696465626172223B733A31343A22736964656261725F7365636F6E64223B733A31333A2252696768742073696465626172223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A363A22686561646572223B733A363A22486561646572223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31313A22686967686C696768746564223B733A31313A22486967686C696768746564223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32393A227468656D65732F6761726C616E642F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A313A7B733A393A227374796C652E637373223B733A32343A227468656D65732F6761726C616E642F7374796C652E637373223B7D733A353A227072696E74223B613A313A7B733A393A227072696E742E637373223B733A32343A227468656D65732F6761726C616E642F7072696E742E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'block_admin_display', 0x613A313A7B693A303B733A373A226761726C616E64223B7D, '', '31', '5', '1', 'admin/structure/block', 'admin/structure/block', 'Garland', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/garland/add', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32303A22626C6F636B5F6164645F626C6F636B5F666F726D223B7D, '', '63', '6', '1', 'admin/structure/block/list/garland', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/seven', '', '', '_block_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A32333A227468656D65732F736576656E2F736576656E2E696E666F223B733A343A226E616D65223B733A353A22736576656E223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2231223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31393A7B733A343A226E616D65223B733A353A22536576656E223B733A31313A226465736372697074696F6E223B733A36353A22412073696D706C65206F6E652D636F6C756D6E2C207461626C656C6573732C20666C7569642077696474682061646D696E697374726174696F6E207468656D652E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A313A7B733A363A2273637265656E223B613A323A7B733A393A2272657365742E637373223B733A32323A227468656D65732F736576656E2F72657365742E637373223B733A393A227374796C652E637373223B733A32323A227468656D65732F736576656E2F7374796C652E637373223B7D7D733A383A2273657474696E6773223B613A313A7B733A32303A2273686F72746375745F6D6F64756C655F6C696E6B223B733A313A2231223B7D733A373A22726567696F6E73223B613A383A7B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31333A22736964656261725F6669727374223B733A31333A2246697273742073696465626172223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A31343A22726567696F6E735F68696464656E223B613A333A7B693A303B733A31333A22736964656261725F6669727374223B693A313B733A383A22706167655F746F70223B693A323B733A31313A22706167655F626F74746F6D223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32373A227468656D65732F736576656E2F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A313A7B733A363A2273637265656E223B613A323A7B733A393A2272657365742E637373223B733A32323A227468656D65732F736576656E2F72657365742E637373223B733A393A227374796C652E637373223B733A32323A227468656D65732F736576656E2F7374796C652E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'block_admin_display', 0x613A313A7B693A303B733A353A22736576656E223B7D, '', '31', '5', '1', 'admin/structure/block', 'admin/structure/block', 'Seven', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/seven/add', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32303A22626C6F636B5F6164645F626C6F636B5F666F726D223B7D, '', '63', '6', '1', 'admin/structure/block/list/seven', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/stark', '', '', '_block_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A32333A227468656D65732F737461726B2F737461726B2E696E666F223B733A343A226E616D65223B733A353A22737461726B223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2230223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31383A7B733A343A226E616D65223B733A353A22537461726B223B733A31313A226465736372697074696F6E223B733A3230383A2254686973207468656D652064656D6F6E737472617465732044727570616C27732064656661756C742048544D4C206D61726B757020616E6420435353207374796C65732E20546F206C6561726E20686F7720746F206275696C6420796F7572206F776E207468656D6520616E64206F766572726964652044727570616C27732064656661756C7420636F64652C2073656520746865203C6120687265663D22687474703A2F2F64727570616C2E6F72672F7468656D652D6775696465223E5468656D696E672047756964653C2F613E2E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31303A226C61796F75742E637373223B733A32333A227468656D65732F737461726B2F6C61796F75742E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A373A22726567696F6E73223B613A31323A7B733A31333A22736964656261725F6669727374223B733A31323A224C6566742073696465626172223B733A31343A22736964656261725F7365636F6E64223B733A31333A2252696768742073696465626172223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A363A22686561646572223B733A363A22486561646572223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31313A22686967686C696768746564223B733A31313A22486967686C696768746564223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32373A227468656D65732F737461726B2F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31303A226C61796F75742E637373223B733A32333A227468656D65732F737461726B2F6C61796F75742E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'block_admin_display', 0x613A313A7B693A303B733A353A22737461726B223B7D, '', '31', '5', '1', 'admin/structure/block', 'admin/structure/block', 'Stark', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/stark/add', '', '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32303A22626C6F636B5F6164645F626C6F636B5F666F726D223B7D, '', '63', '6', '1', 'admin/structure/block/list/stark', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/theme_default', '', '', '_block_themes_access', 0x613A313A7B693A303B4F3A383A22737464436C617373223A31323A7B733A383A2266696C656E616D65223B733A34393A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F7468656D655F64656661756C742E696E666F223B733A343A226E616D65223B733A31333A227468656D655F64656661756C74223B733A343A2274797065223B733A353A227468656D65223B733A353A226F776E6572223B733A34353A227468656D65732F656E67696E65732F70687074656D706C6174652F70687074656D706C6174652E656E67696E65223B733A363A22737461747573223B733A313A2231223B733A393A22626F6F747374726170223B733A313A2230223B733A31343A22736368656D615F76657273696F6E223B733A323A222D31223B733A363A22776569676874223B733A313A2230223B733A343A22696E666F223B613A31373A7B733A343A226E616D65223B733A31333A2264656661756C74207468656D65223B733A31313A226465736372697074696F6E223B733A31333A2264656661756C74207468656D65223B733A343A22636F7265223B733A333A22372E78223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A373A2276657273696F6E223B733A333A22372E78223B733A373A2270726F6A656374223B733A31333A2264656661756C74207468656D65223B733A393A22646174657374616D70223B733A31303A2231333332353137383436223B733A373A22726567696F6E73223B613A383A7B733A363A22686561646572223B733A363A22486561646572223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A343A226C656674223B733A343A224C656674223B733A353A227269676874223B733A353A225269676874223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31333A226373732F7374796C652E637373223B733A34343A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F6373732F7374796C652E637373223B7D7D733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A34353A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383331353630373B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D733A363A22707265666978223B733A31313A2270687074656D706C617465223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31333A226373732F7374796C652E637373223B733A34343A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F6373732F7374796C652E637373223B7D7D733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B7D7D, 'block_admin_display', 0x613A313A7B693A303B733A31333A227468656D655F64656661756C74223B7D, '', '31', '5', '1', 'admin/structure/block', 'admin/structure/block', 'default theme', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/manage/%/%', 0x613A323A7B693A343B4E3B693A353B4E3B7D, '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'drupal_get_form', 0x613A333A7B693A303B733A32313A22626C6F636B5F61646D696E5F636F6E666967757265223B693A313B693A343B693A323B693A353B7D, '', '60', '6', '0', '', 'admin/structure/block/manage/%/%', 'Configure block', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/manage/%/%/configure', 0x613A323A7B693A343B4E3B693A353B4E3B7D, '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'drupal_get_form', 0x613A333A7B693A303B733A32313A22626C6F636B5F61646D696E5F636F6E666967757265223B693A313B693A343B693A323B693A353B7D, '', '121', '7', '2', 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Configure block', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/manage/%/%/delete', 0x613A323A7B693A343B4E3B693A353B4E3B7D, '', 'user_access', 0x613A313A7B693A303B733A31373A2261646D696E697374657220626C6F636B73223B7D, 'drupal_get_form', 0x613A333A7B693A303B733A32353A22626C6F636B5F637573746F6D5F626C6F636B5F64656C657465223B693A313B693A343B693A323B693A353B7D, '', '121', '7', '0', 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Delete block', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu', '', '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'menu_overview_page', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/structure/menu', 'Menus', 't', '', '', 'a:0:{}', '6', 'Add new menus to your site, edit existing menus, and rename and reorganize menu links.', '', '0', 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/add', '', '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31343A226D656E755F656469745F6D656E75223B693A313B733A333A22616464223B7D, '', '15', '4', '1', 'admin/structure/menu', 'admin/structure/menu', 'Add menu', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/item/%/delete', 0x613A313A7B693A343B733A31343A226D656E755F6C696E6B5F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'menu_item_delete_page', 0x613A313A7B693A303B693A343B7D, '', '61', '6', '0', '', 'admin/structure/menu/item/%/delete', 'Delete menu link', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/item/%/edit', 0x613A313A7B693A343B733A31343A226D656E755F6C696E6B5F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A31343A226D656E755F656469745F6974656D223B693A313B733A343A2265646974223B693A323B693A343B693A333B4E3B7D, '', '61', '6', '0', '', 'admin/structure/menu/item/%/edit', 'Edit menu link', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/item/%/reset', 0x613A313A7B693A343B733A31343A226D656E755F6C696E6B5F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32333A226D656E755F72657365745F6974656D5F636F6E6669726D223B693A313B693A343B7D, '', '61', '6', '0', '', 'admin/structure/menu/item/%/reset', 'Reset menu link', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/list', '', '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'menu_overview_page', 0x613A303A7B7D, '', '15', '4', '1', 'admin/structure/menu', 'admin/structure/menu', 'List menus', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%', 0x613A313A7B693A343B733A393A226D656E755F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31383A226D656E755F6F766572766965775F666F726D223B693A313B693A343B7D, '', '30', '5', '0', '', 'admin/structure/menu/manage/%', 'Customize menu', 'menu_overview_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', '6', '', '', '0', 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%/add', 0x613A313A7B693A343B733A393A226D656E755F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A31343A226D656E755F656469745F6974656D223B693A313B733A333A22616464223B693A323B4E3B693A333B693A343B7D, '', '61', '6', '1', 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Add link', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%/delete', 0x613A313A7B693A343B733A393A226D656E755F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'menu_delete_menu_page', 0x613A313A7B693A303B693A343B7D, '', '61', '6', '0', '', 'admin/structure/menu/manage/%/delete', 'Delete menu', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%/edit', 0x613A313A7B693A343B733A393A226D656E755F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'drupal_get_form', 0x613A333A7B693A303B733A31343A226D656E755F656469745F6D656E75223B693A313B733A343A2265646974223B693A323B693A343B7D, '', '61', '6', '3', 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Edit menu', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%/list', 0x613A313A7B693A343B733A393A226D656E755F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31383A226D656E755F6F766572766965775F666F726D223B693A313B693A343B7D, '', '61', '6', '3', 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'List links', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/parents', '', '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'menu_parent_options_js', 0x613A303A7B7D, '', '15', '4', '0', '', 'admin/structure/menu/parents', 'Parent menu items', 't', '', '', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/settings', '', '', 'user_access', 0x613A313A7B693A303B733A31353A2261646D696E6973746572206D656E75223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A31343A226D656E755F636F6E666967757265223B7D, '', '15', '4', '1', 'admin/structure/menu', 'admin/structure/menu', 'Settings', 't', '', '', 'a:0:{}', '132', '', '', '5', 'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy', '', '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A33303A227461786F6E6F6D795F6F766572766965775F766F636162756C6172696573223B7D, '', '7', '3', '0', '', 'admin/structure/taxonomy', 'Taxonomy', 't', '', '', 'a:0:{}', '6', 'Manage tagging, categorization, and classification of your content.', '', '0', 'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%', 0x613A313A7B693A333B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32333A227461786F6E6F6D795F6F766572766965775F7465726D73223B693A313B693A333B7D, '', '14', '4', '0', '', 'admin/structure/taxonomy/%', '', 'entity_label', 'a:2:{i:0;s:19:\"taxonomy_vocabulary\";i:1;i:3;}', '', 'a:0:{}', '6', '', '', '0', 'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/add', 0x613A313A7B693A333B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A333A7B693A303B733A31383A227461786F6E6F6D795F666F726D5F7465726D223B693A313B613A303A7B7D693A323B693A333B7D, '', '29', '5', '1', 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Add term', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/display', 0x613A313A7B693A333B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A31333A227461786F6E6F6D795F7465726D223B693A323B693A333B693A333B733A373A2264656661756C74223B7D, '', '29', '5', '1', 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Manage display', 't', '', '', 'a:0:{}', '132', '', '', '2', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/display/default', 0x613A313A7B693A333B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B7D, '', '_field_ui_view_mode_menu_access', 0x613A353A7B693A303B733A31333A227461786F6E6F6D795F7465726D223B693A313B693A333B693A323B733A373A2264656661756C74223B693A333B733A31313A22757365725F616363657373223B693A343B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A31333A227461786F6E6F6D795F7465726D223B693A323B693A333B693A333B733A373A2264656661756C74223B7D, '', '59', '6', '1', 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%', 'Default', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/display/full', 0x613A313A7B693A333B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B7D, '', '_field_ui_view_mode_menu_access', 0x613A353A7B693A303B733A31333A227461786F6E6F6D795F7465726D223B693A313B693A333B693A323B733A343A2266756C6C223B693A333B733A31313A22757365725F616363657373223B693A343B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A31333A227461786F6E6F6D795F7465726D223B693A323B693A333B693A333B733A343A2266756C6C223B7D, '', '59', '6', '1', 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%', 'Taxonomy term page', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/edit', 0x613A313A7B693A333B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32343A227461786F6E6F6D795F666F726D5F766F636162756C617279223B693A313B693A333B7D, '', '29', '5', '1', 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Edit', 't', '', '', 'a:0:{}', '132', '', '', '-10', 'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields', 0x613A313A7B693A333B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A333A7B693A303B733A32383A226669656C645F75695F6669656C645F6F766572766965775F666F726D223B693A313B733A31333A227461786F6E6F6D795F7465726D223B693A323B693A333B7D, '', '29', '5', '1', 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Manage fields', 't', '', '', 'a:0:{}', '132', '', '', '1', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%', 0x613A323A7B693A333B613A313A7B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B613A343A7B693A303B733A31333A227461786F6E6F6D795F7465726D223B693A313B693A333B693A323B733A313A2233223B693A333B733A343A22256D6170223B7D7D693A353B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A31333A227461786F6E6F6D795F7465726D223B693A313B693A333B693A323B733A313A2233223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32343A226669656C645F75695F6669656C645F656469745F666F726D223B693A313B693A353B7D, '', '58', '6', '0', '', 'admin/structure/taxonomy/%/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:5;}', '', 'a:0:{}', '6', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%/delete', 0x613A323A7B693A333B613A313A7B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B613A343A7B693A303B733A31333A227461786F6E6F6D795F7465726D223B693A313B693A333B693A323B733A313A2233223B693A333B733A343A22256D6170223B7D7D693A353B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A31333A227461786F6E6F6D795F7465726D223B693A313B693A333B693A323B733A313A2233223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32363A226669656C645F75695F6669656C645F64656C6574655F666F726D223B693A313B693A353B7D, '', '117', '7', '1', 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Delete', 't', '', '', 'a:0:{}', '132', '', '', '10', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%/edit', 0x613A323A7B693A333B613A313A7B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B613A343A7B693A303B733A31333A227461786F6E6F6D795F7465726D223B693A313B693A333B693A323B733A313A2233223B693A333B733A343A22256D6170223B7D7D693A353B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A31333A227461786F6E6F6D795F7465726D223B693A313B693A333B693A323B733A313A2233223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32343A226669656C645F75695F6669656C645F656469745F666F726D223B693A313B693A353B7D, '', '117', '7', '1', 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Edit', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%/field-settings', 0x613A323A7B693A333B613A313A7B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B613A343A7B693A303B733A31333A227461786F6E6F6D795F7465726D223B693A313B693A333B693A323B733A313A2233223B693A333B733A343A22256D6170223B7D7D693A353B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A31333A227461786F6E6F6D795F7465726D223B693A313B693A333B693A323B733A313A2233223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32383A226669656C645F75695F6669656C645F73657474696E67735F666F726D223B693A313B693A353B7D, '', '117', '7', '1', 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Field settings', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%/widget-type', 0x613A323A7B693A333B613A313A7B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B613A343A7B693A303B733A31333A227461786F6E6F6D795F7465726D223B693A313B693A333B693A323B733A313A2233223B693A333B733A343A22256D6170223B7D7D693A353B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A31333A227461786F6E6F6D795F7465726D223B693A313B693A333B693A323B733A313A2233223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32353A226669656C645F75695F7769646765745F747970655F666F726D223B693A313B693A353B7D, '', '117', '7', '1', 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Widget type', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/list', 0x613A313A7B693A333B733A33373A227461786F6E6F6D795F766F636162756C6172795F6D616368696E655F6E616D655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32333A227461786F6E6F6D795F6F766572766965775F7465726D73223B693A313B693A333B7D, '', '29', '5', '1', 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'List', 't', '', '', 'a:0:{}', '140', '', '', '-20', 'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/add', '', '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A32343A227461786F6E6F6D795F666F726D5F766F636162756C617279223B7D, '', '15', '4', '1', 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'Add vocabulary', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/list', '', '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E6973746572207461786F6E6F6D79223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A33303A227461786F6E6F6D795F6F766572766965775F766F636162756C6172696573223B7D, '', '15', '4', '1', 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'List', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types', '', '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'node_overview_types', 0x613A303A7B7D, '', '7', '3', '0', '', 'admin/structure/types', 'Content types', 't', '', '', 'a:0:{}', '6', 'Manage content types, including default status, front page promotion, comment settings, etc.', '', '0', 'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/add', '', '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A313A7B693A303B733A31343A226E6F64655F747970655F666F726D223B7D, '', '15', '4', '1', 'admin/structure/types', 'admin/structure/types', 'Add content type', 't', '', '', 'a:0:{}', '388', '', '', '0', 'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/list', '', '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'node_overview_types', 0x613A303A7B7D, '', '15', '4', '1', 'admin/structure/types', 'admin/structure/types', 'List', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%', 0x613A313A7B693A343B733A31343A226E6F64655F747970655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31343A226E6F64655F747970655F666F726D223B693A313B693A343B7D, '', '30', '5', '0', '', 'admin/structure/types/manage/%', 'Edit content type', 'node_type_page_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', '6', '', '', '0', 'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/display', 0x613A313A7B693A343B733A32323A22636F6D6D656E745F6E6F64655F747970655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A373A22636F6D6D656E74223B693A323B693A343B693A333B733A373A2264656661756C74223B7D, '', '123', '7', '1', 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Comment display', 't', '', '', 'a:0:{}', '132', '', '', '4', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/display/default', 0x613A313A7B693A343B733A32323A22636F6D6D656E745F6E6F64655F747970655F6C6F6164223B7D, '', '_field_ui_view_mode_menu_access', 0x613A353A7B693A303B733A373A22636F6D6D656E74223B693A313B693A343B693A323B733A373A2264656661756C74223B693A333B733A31313A22757365725F616363657373223B693A343B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A373A22636F6D6D656E74223B693A323B693A343B693A333B733A373A2264656661756C74223B7D, '', '247', '8', '1', 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%', 'Default', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/display/full', 0x613A313A7B693A343B733A32323A22636F6D6D656E745F6E6F64655F747970655F6C6F6164223B7D, '', '_field_ui_view_mode_menu_access', 0x613A353A7B693A303B733A373A22636F6D6D656E74223B693A313B693A343B693A323B733A343A2266756C6C223B693A333B733A31313A22757365725F616363657373223B693A343B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A373A22636F6D6D656E74223B693A323B693A343B693A333B733A343A2266756C6C223B7D, '', '247', '8', '1', 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%', 'Full comment', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields', 0x613A313A7B693A343B733A32323A22636F6D6D656E745F6E6F64655F747970655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A333A7B693A303B733A32383A226669656C645F75695F6669656C645F6F766572766965775F666F726D223B693A313B733A373A22636F6D6D656E74223B693A323B693A343B7D, '', '123', '7', '1', 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Comment fields', 't', '', '', 'a:0:{}', '132', '', '', '3', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%', 0x613A323A7B693A343B613A313A7B733A32323A22636F6D6D656E745F6E6F64655F747970655F6C6F6164223B613A343A7B693A303B733A373A22636F6D6D656E74223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D693A373B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A373A22636F6D6D656E74223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32343A226669656C645F75695F6669656C645F656469745F666F726D223B693A313B693A373B7D, '', '246', '8', '0', '', 'admin/structure/types/manage/%/comment/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:7;}', '', 'a:0:{}', '6', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%/delete', 0x613A323A7B693A343B613A313A7B733A32323A22636F6D6D656E745F6E6F64655F747970655F6C6F6164223B613A343A7B693A303B733A373A22636F6D6D656E74223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D693A373B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A373A22636F6D6D656E74223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32363A226669656C645F75695F6669656C645F64656C6574655F666F726D223B693A313B693A373B7D, '', '493', '9', '1', 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Delete', 't', '', '', 'a:0:{}', '132', '', '', '10', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%/edit', 0x613A323A7B693A343B613A313A7B733A32323A22636F6D6D656E745F6E6F64655F747970655F6C6F6164223B613A343A7B693A303B733A373A22636F6D6D656E74223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D693A373B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A373A22636F6D6D656E74223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32343A226669656C645F75695F6669656C645F656469745F666F726D223B693A313B693A373B7D, '', '493', '9', '1', 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Edit', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%/field-settings', 0x613A323A7B693A343B613A313A7B733A32323A22636F6D6D656E745F6E6F64655F747970655F6C6F6164223B613A343A7B693A303B733A373A22636F6D6D656E74223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D693A373B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A373A22636F6D6D656E74223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32383A226669656C645F75695F6669656C645F73657474696E67735F666F726D223B693A313B693A373B7D, '', '493', '9', '1', 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Field settings', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%/widget-type', 0x613A323A7B693A343B613A313A7B733A32323A22636F6D6D656E745F6E6F64655F747970655F6C6F6164223B613A343A7B693A303B733A373A22636F6D6D656E74223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D693A373B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A373A22636F6D6D656E74223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32353A226669656C645F75695F7769646765745F747970655F666F726D223B693A313B693A373B7D, '', '493', '9', '1', 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Widget type', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/delete', 0x613A313A7B693A343B733A31343A226E6F64655F747970655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32343A226E6F64655F747970655F64656C6574655F636F6E6669726D223B693A313B693A343B7D, '', '61', '6', '0', '', 'admin/structure/types/manage/%/delete', 'Delete', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display', 0x613A313A7B693A343B733A31343A226E6F64655F747970655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A343A226E6F6465223B693A323B693A343B693A333B733A373A2264656661756C74223B7D, '', '61', '6', '1', 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Manage display', 't', '', '', 'a:0:{}', '132', '', '', '2', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/default', 0x613A313A7B693A343B733A31343A226E6F64655F747970655F6C6F6164223B7D, '', '_field_ui_view_mode_menu_access', 0x613A353A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A373A2264656661756C74223B693A333B733A31313A22757365725F616363657373223B693A343B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A343A226E6F6465223B693A323B693A343B693A333B733A373A2264656661756C74223B7D, '', '123', '7', '1', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Default', 't', '', '', 'a:0:{}', '140', '', '', '-10', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/full', 0x613A313A7B693A343B733A31343A226E6F64655F747970655F6C6F6164223B7D, '', '_field_ui_view_mode_menu_access', 0x613A353A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A343A2266756C6C223B693A333B733A31313A22757365725F616363657373223B693A343B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A343A226E6F6465223B693A323B693A343B693A333B733A343A2266756C6C223B7D, '', '123', '7', '1', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Full content', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/rss', 0x613A313A7B693A343B733A31343A226E6F64655F747970655F6C6F6164223B7D, '', '_field_ui_view_mode_menu_access', 0x613A353A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A333A22727373223B693A333B733A31313A22757365725F616363657373223B693A343B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A343A226E6F6465223B693A323B693A343B693A333B733A333A22727373223B7D, '', '123', '7', '1', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'RSS', 't', '', '', 'a:0:{}', '132', '', '', '2', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/search_index', 0x613A313A7B693A343B733A31343A226E6F64655F747970655F6C6F6164223B7D, '', '_field_ui_view_mode_menu_access', 0x613A353A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A31323A227365617263685F696E646578223B693A333B733A31313A22757365725F616363657373223B693A343B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A343A226E6F6465223B693A323B693A343B693A333B733A31323A227365617263685F696E646578223B7D, '', '123', '7', '1', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Search index', 't', '', '', 'a:0:{}', '132', '', '', '3', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/search_result', 0x613A313A7B693A343B733A31343A226E6F64655F747970655F6C6F6164223B7D, '', '_field_ui_view_mode_menu_access', 0x613A353A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A31333A227365617263685F726573756C74223B693A333B733A31313A22757365725F616363657373223B693A343B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A343A226E6F6465223B693A323B693A343B693A333B733A31333A227365617263685F726573756C74223B7D, '', '123', '7', '1', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Search result highlighting input', 't', '', '', 'a:0:{}', '132', '', '', '4', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/teaser', 0x613A313A7B693A343B733A31343A226E6F64655F747970655F6C6F6164223B7D, '', '_field_ui_view_mode_menu_access', 0x613A353A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A363A22746561736572223B693A333B733A31313A22757365725F616363657373223B693A343B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A343A7B693A303B733A33303A226669656C645F75695F646973706C61795F6F766572766965775F666F726D223B693A313B733A343A226E6F6465223B693A323B693A343B693A333B733A363A22746561736572223B7D, '', '123', '7', '1', 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Teaser', 't', '', '', 'a:0:{}', '132', '', '', '1', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/edit', 0x613A313A7B693A343B733A31343A226E6F64655F747970655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31343A226E6F64655F747970655F666F726D223B693A313B693A343B7D, '', '61', '6', '1', 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Edit', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields', 0x613A313A7B693A343B733A31343A226E6F64655F747970655F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A333A7B693A303B733A32383A226669656C645F75695F6669656C645F6F766572766965775F666F726D223B693A313B733A343A226E6F6465223B693A323B693A343B7D, '', '61', '6', '1', 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Manage fields', 't', '', '', 'a:0:{}', '132', '', '', '1', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%', 0x613A323A7B693A343B613A313A7B733A31343A226E6F64655F747970655F6C6F6164223B613A343A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D693A363B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32343A226669656C645F75695F6669656C645F656469745F666F726D223B693A313B693A363B7D, '', '122', '7', '0', '', 'admin/structure/types/manage/%/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:6;}', '', 'a:0:{}', '6', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%/delete', 0x613A323A7B693A343B613A313A7B733A31343A226E6F64655F747970655F6C6F6164223B613A343A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D693A363B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32363A226669656C645F75695F6669656C645F64656C6574655F666F726D223B693A313B693A363B7D, '', '245', '8', '1', 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Delete', 't', '', '', 'a:0:{}', '132', '', '', '10', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%/edit', 0x613A323A7B693A343B613A313A7B733A31343A226E6F64655F747970655F6C6F6164223B613A343A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D693A363B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32343A226669656C645F75695F6669656C645F656469745F666F726D223B693A313B693A363B7D, '', '245', '8', '1', 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Edit', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%/field-settings', 0x613A323A7B693A343B613A313A7B733A31343A226E6F64655F747970655F6C6F6164223B613A343A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D693A363B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32383A226669656C645F75695F6669656C645F73657474696E67735F666F726D223B693A313B693A363B7D, '', '245', '8', '1', 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Field settings', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%/widget-type', 0x613A323A7B693A343B613A313A7B733A31343A226E6F64655F747970655F6C6F6164223B613A343A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D693A363B613A313A7B733A31383A226669656C645F75695F6D656E755F6C6F6164223B613A343A7B693A303B733A343A226E6F6465223B693A313B693A343B693A323B733A313A2234223B693A333B733A343A22256D6170223B7D7D7D, '', 'user_access', 0x613A313A7B693A303B733A32343A2261646D696E697374657220636F6E74656E74207479706573223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32353A226669656C645F75695F7769646765745F747970655F666F726D223B693A313B693A363B7D, '', '245', '8', '1', 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Widget type', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/tasks', '', '', 'user_access', 0x613A313A7B693A303B733A32373A226163636573732061646D696E697374726174696F6E207061676573223B7D, 'system_admin_menu_block_page', 0x613A303A7B7D, '', '3', '2', '1', 'admin', 'admin', 'Tasks', 't', '', '', 'a:0:{}', '140', '', '', '-20', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admincp', '', '', '1', 0x613A303A7B7D, 'router_page', 0x613A303A7B7D, '', '1', '1', '0', '', 'admincp', 'Trang quản trị', 't', '', '', 'a:0:{}', '0', 'Administration', '', '0', '');
INSERT INTO `menu_router` VALUES ('admincp/configinfo', '', '', '1', 0x613A303A7B7D, 'router_page', 0x613A303A7B7D, '', '3', '2', '0', '', 'admincp/configinfo', 'Config info', 't', '', '', 'a:0:{}', '0', 'Config info', '', '0', '');
INSERT INTO `menu_router` VALUES ('admincp/province', '', '', '1', 0x613A303A7B7D, 'router_page', 0x613A303A7B7D, '', '3', '2', '0', '', 'admincp/province', 'province', 't', '', '', 'a:0:{}', '0', 'province', '', '0', '');
INSERT INTO `menu_router` VALUES ('admincp/supplier', '', '', '1', 0x613A303A7B7D, 'router_page', 0x613A303A7B7D, '', '3', '2', '0', '', 'admincp/supplier', 'Quản lý NCC', 't', '', '', 'a:0:{}', '0', 'Qu?n lý NCC', '', '0', '');
INSERT INTO `menu_router` VALUES ('admincp/supportonline', '', '', '1', 0x613A303A7B7D, 'router_page', 0x613A303A7B7D, '', '3', '2', '0', '', 'admincp/supportonline', 'Support online', 't', '', '', 'a:0:{}', '0', 'Support online', '', '0', '');
INSERT INTO `menu_router` VALUES ('admincp/usershop', '', '', '1', 0x613A303A7B7D, 'router_page', 0x613A303A7B7D, '', '3', '2', '0', '', 'admincp/usershop', 'Quản lý User Shop', 't', '', '', 'a:0:{}', '0', 'Qu?n lý User Shop', '', '0', '');
INSERT INTO `menu_router` VALUES ('batch', '', '', '1', 0x613A303A7B7D, 'system_batch_page', 0x613A303A7B7D, '', '1', '1', '0', '', 'batch', '', 't', '', '_system_batch_theme', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('comment/%', 0x613A313A7B693A313B4E3B7D, '', 'user_access', 0x613A313A7B693A303B733A31353A2261636365737320636F6D6D656E7473223B7D, 'comment_permalink', 0x613A313A7B693A303B693A313B7D, '', '2', '2', '0', '', 'comment/%', 'Comment permalink', 't', '', '', 'a:0:{}', '6', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('comment/%/approve', 0x613A313A7B693A313B4E3B7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E697374657220636F6D6D656E7473223B7D, 'comment_approve', 0x613A313A7B693A303B693A313B7D, '', '5', '3', '0', '', 'comment/%/approve', 'Approve', 't', '', '', 'a:0:{}', '6', '', '', '1', 'modules/comment/comment.pages.inc');
INSERT INTO `menu_router` VALUES ('comment/%/delete', 0x613A313A7B693A313B4E3B7D, '', 'user_access', 0x613A313A7B693A303B733A31393A2261646D696E697374657220636F6D6D656E7473223B7D, 'comment_confirm_delete_page', 0x613A313A7B693A303B693A313B7D, '', '5', '3', '1', 'comment/%', 'comment/%', 'Delete', 't', '', '', 'a:0:{}', '132', '', '', '2', 'modules/comment/comment.admin.inc');
INSERT INTO `menu_router` VALUES ('comment/%/edit', 0x613A313A7B693A313B733A31323A22636F6D6D656E745F6C6F6164223B7D, '', 'comment_access', 0x613A323A7B693A303B733A343A2265646974223B693A313B693A313B7D, 'comment_edit_page', 0x613A313A7B693A303B693A313B7D, '', '5', '3', '1', 'comment/%', 'comment/%', 'Edit', 't', '', '', 'a:0:{}', '132', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('comment/%/view', 0x613A313A7B693A313B4E3B7D, '', 'user_access', 0x613A313A7B693A303B733A31353A2261636365737320636F6D6D656E7473223B7D, 'comment_permalink', 0x613A313A7B693A303B693A313B7D, '', '5', '3', '1', 'comment/%', 'comment/%', 'View comment', 't', '', '', 'a:0:{}', '140', '', '', '-10', '');
INSERT INTO `menu_router` VALUES ('comment/reply/%', 0x613A313A7B693A323B733A393A226E6F64655F6C6F6164223B7D, '', 'node_access', 0x613A323A7B693A303B733A343A2276696577223B693A313B693A323B7D, 'comment_reply', 0x613A313A7B693A303B693A323B7D, '', '6', '3', '0', '', 'comment/reply/%', 'Add new comment', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/comment/comment.pages.inc');
INSERT INTO `menu_router` VALUES ('dang-ky.html', '', '', '1', 0x613A303A7B7D, 'shopRegister', 0x613A303A7B7D, '', '1', '1', '0', '', 'dang-ky.html', 'Đăng ký shop', 't', '', '', 'a:0:{}', '0', 'Đăng ký shop', '', '0', '');
INSERT INTO `menu_router` VALUES ('dang-nhap.html', '', '', '1', 0x613A303A7B7D, 'shopLogin', 0x613A303A7B7D, '', '1', '1', '0', '', 'dang-nhap.html', 'Đăng nhập shop', 't', '', '', 'a:0:{}', '0', 'Đăng nhâp shop', '', '0', '');
INSERT INTO `menu_router` VALUES ('dang-san-pham.html', '', '', '1', 0x613A303A7B7D, 'shopPostProduct', 0x613A303A7B7D, '', '1', '1', '0', '', 'dang-san-pham.html', 'Đăng sản phẩm', 't', '', '', 'a:0:{}', '0', 'Đăng sản phẩm', '', '0', '');
INSERT INTO `menu_router` VALUES ('doi-mat-khau.html', '', '', '1', 0x613A303A7B7D, 'shopEditPassword', 0x613A303A7B7D, '', '1', '1', '0', '', 'doi-mat-khau.html', 'Đổi mật khẩu', 't', '', '', 'a:0:{}', '0', 'Đổi mật khẩu', '', '0', '');
INSERT INTO `menu_router` VALUES ('file/ajax', '', '', 'user_access', 0x613A313A7B693A303B733A31343A2261636365737320636F6E74656E74223B7D, 'file_ajax_upload', 0x613A303A7B7D, 'ajax_deliver', '3', '2', '0', '', 'file/ajax', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('file/progress', '', '', 'user_access', 0x613A313A7B693A303B733A31343A2261636365737320636F6E74656E74223B7D, 'file_ajax_progress', 0x613A303A7B7D, '', '3', '2', '0', '', 'file/progress', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('filter/tips', '', '', '1', 0x613A303A7B7D, 'filter_tips_long', 0x613A303A7B7D, '', '3', '2', '0', '', 'filter/tips', 'Compose tips', 't', '', '', 'a:0:{}', '20', '', '', '0', 'modules/filter/filter.pages.inc');
INSERT INTO `menu_router` VALUES ('filter/tips/%', 0x613A313A7B693A323B733A31383A2266696C7465725F666F726D61745F6C6F6164223B7D, '', 'filter_access', 0x613A313A7B693A303B693A323B7D, 'filter_tips_long', 0x613A313A7B693A303B693A323B7D, '', '6', '3', '0', '', 'filter/tips/%', 'Compose tips', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/filter/filter.pages.inc');
INSERT INTO `menu_router` VALUES ('node', '', '', 'user_access', 0x613A313A7B693A303B733A31343A2261636365737320636F6E74656E74223B7D, 'node_page_default', 0x613A303A7B7D, '', '1', '1', '0', '', 'node', '', 't', '', '', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('node/%', 0x613A313A7B693A313B733A393A226E6F64655F6C6F6164223B7D, '', 'node_access', 0x613A323A7B693A303B733A343A2276696577223B693A313B693A313B7D, 'node_page_view', 0x613A313A7B693A303B693A313B7D, '', '2', '2', '0', '', 'node/%', '', 'node_page_title', 'a:1:{i:0;i:1;}', '', 'a:0:{}', '6', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('node/%/delete', 0x613A313A7B693A313B733A393A226E6F64655F6C6F6164223B7D, '', 'node_access', 0x613A323A7B693A303B733A363A2264656C657465223B693A313B693A313B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31393A226E6F64655F64656C6574655F636F6E6669726D223B693A313B693A313B7D, '', '5', '3', '2', 'node/%', 'node/%', 'Delete', 't', '', '', 'a:0:{}', '132', '', '', '1', 'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/edit', 0x613A313A7B693A313B733A393A226E6F64655F6C6F6164223B7D, '', 'node_access', 0x613A323A7B693A303B733A363A22757064617465223B693A313B693A313B7D, 'node_page_edit', 0x613A313A7B693A303B693A313B7D, '', '5', '3', '3', 'node/%', 'node/%', 'Edit', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/revisions', 0x613A313A7B693A313B733A393A226E6F64655F6C6F6164223B7D, '', '_node_revision_access', 0x613A313A7B693A303B693A313B7D, 'node_revision_overview', 0x613A313A7B693A303B693A313B7D, '', '5', '3', '1', 'node/%', 'node/%', 'Revisions', 't', '', '', 'a:0:{}', '132', '', '', '2', 'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/revisions/%/delete', 0x613A323A7B693A313B613A313A7B733A393A226E6F64655F6C6F6164223B613A313A7B693A303B693A333B7D7D693A333B4E3B7D, '', '_node_revision_access', 0x613A323A7B693A303B693A313B693A313B733A363A2264656C657465223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32383A226E6F64655F7265766973696F6E5F64656C6574655F636F6E6669726D223B693A313B693A313B7D, '', '21', '5', '0', '', 'node/%/revisions/%/delete', 'Delete earlier revision', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/revisions/%/revert', 0x613A323A7B693A313B613A313A7B733A393A226E6F64655F6C6F6164223B613A313A7B693A303B693A333B7D7D693A333B4E3B7D, '', '_node_revision_access', 0x613A323A7B693A303B693A313B693A313B733A363A22757064617465223B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32383A226E6F64655F7265766973696F6E5F7265766572745F636F6E6669726D223B693A313B693A313B7D, '', '21', '5', '0', '', 'node/%/revisions/%/revert', 'Revert to earlier revision', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/revisions/%/view', 0x613A323A7B693A313B613A313A7B733A393A226E6F64655F6C6F6164223B613A313A7B693A303B693A333B7D7D693A333B4E3B7D, '', '_node_revision_access', 0x613A313A7B693A303B693A313B7D, 'node_show', 0x613A323A7B693A303B693A313B693A313B623A313B7D, '', '21', '5', '0', '', 'node/%/revisions/%/view', 'Revisions', 't', '', '', 'a:0:{}', '6', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('node/%/view', 0x613A313A7B693A313B733A393A226E6F64655F6C6F6164223B7D, '', 'node_access', 0x613A323A7B693A303B733A343A2276696577223B693A313B693A313B7D, 'node_page_view', 0x613A313A7B693A303B693A313B7D, '', '5', '3', '1', 'node/%', 'node/%', 'View', 't', '', '', 'a:0:{}', '140', '', '', '-10', '');
INSERT INTO `menu_router` VALUES ('node/add', '', '', '_node_add_access', 0x613A303A7B7D, 'node_add_page', 0x613A303A7B7D, '', '3', '2', '0', '', 'node/add', 'Add content', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/add/article', '', '', 'node_access', 0x613A323A7B693A303B733A363A22637265617465223B693A313B733A373A2261727469636C65223B7D, 'node_add', 0x613A313A7B693A303B733A373A2261727469636C65223B7D, '', '7', '3', '0', '', 'node/add/article', 'Article', 'check_plain', '', '', 'a:0:{}', '6', 'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.', '', '0', 'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/add/page', '', '', 'node_access', 0x613A323A7B693A303B733A363A22637265617465223B693A313B733A343A2270616765223B7D, 'node_add', 0x613A313A7B693A303B733A343A2270616765223B7D, '', '7', '3', '0', '', 'node/add/page', 'Basic page', 'check_plain', '', '', 'a:0:{}', '6', 'Use <em>basic pages</em> for your static content, such as an \'About us\' page.', '', '0', 'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('page-403', '', '', '1', 0x613A303A7B7D, 'page_403', 0x613A303A7B7D, '', '1', '1', '0', '', 'page-403', 'page access denied', 't', '', '', 'a:0:{}', '0', 'page access denied', '', '0', '');
INSERT INTO `menu_router` VALUES ('page-404', '', '', '1', 0x613A303A7B7D, 'page_404', 0x613A303A7B7D, '', '1', '1', '0', '', 'page-404', 'page not found', 't', '', '', 'a:0:{}', '0', 'page not found', '', '0', '');
INSERT INTO `menu_router` VALUES ('quan-ly-gian-hang.html', '', '', '1', 0x613A303A7B7D, 'shopManagerProduct', 0x613A303A7B7D, '', '1', '1', '0', '', 'quan-ly-gian-hang.html', 'Quản lý sản phẩm', 't', '', '', 'a:0:{}', '0', 'Quản lý sản phẩm', '', '0', '');
INSERT INTO `menu_router` VALUES ('rss.xml', '', '', 'user_access', 0x613A313A7B693A303B733A31343A2261636365737320636F6E74656E74223B7D, 'node_feed', 0x613A323A7B693A303B623A303B693A313B613A303A7B7D7D, '', '1', '1', '0', '', 'rss.xml', 'RSS feed', 't', '', '', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('search', '', '', 'search_is_active', 0x613A303A7B7D, 'search_view', 0x613A303A7B7D, '', '1', '1', '0', '', 'search', 'Search', 't', '', '', 'a:0:{}', '20', '', '', '0', 'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('search/node', '', '', '_search_menu_access', 0x613A313A7B693A303B733A343A226E6F6465223B7D, 'search_view', 0x613A323A7B693A303B733A343A226E6F6465223B693A313B733A303A22223B7D, '', '3', '2', '1', 'search', 'search', 'Content', 't', '', '', 'a:0:{}', '132', '', '', '-10', 'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('search/node/%', 0x613A313A7B693A323B613A313A7B733A31343A226D656E755F7461696C5F6C6F6164223B613A323A7B693A303B733A343A22256D6170223B693A313B733A363A2225696E646578223B7D7D7D, 0x613A313A7B693A323B733A31363A226D656E755F7461696C5F746F5F617267223B7D, '_search_menu_access', 0x613A313A7B693A303B733A343A226E6F6465223B7D, 'search_view', 0x613A323A7B693A303B733A343A226E6F6465223B693A313B693A323B7D, '', '6', '3', '1', 'search/node', 'search/node/%', 'Content', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('search/user', '', '', '_search_menu_access', 0x613A313A7B693A303B733A343A2275736572223B7D, 'search_view', 0x613A323A7B693A303B733A343A2275736572223B693A313B733A303A22223B7D, '', '3', '2', '1', 'search', 'search', 'Users', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('search/user/%', 0x613A313A7B693A323B613A313A7B733A31343A226D656E755F7461696C5F6C6F6164223B613A323A7B693A303B733A343A22256D6170223B693A313B733A363A2225696E646578223B7D7D7D, 0x613A313A7B693A323B733A31363A226D656E755F7461696C5F746F5F617267223B7D, '_search_menu_access', 0x613A313A7B693A303B733A343A2275736572223B7D, 'search_view', 0x613A323A7B693A303B733A343A2275736572223B693A313B693A323B7D, '', '6', '3', '1', 'search/node', 'search/node/%', 'Users', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('sites/default/files/styles/%', 0x613A313A7B693A343B733A31363A22696D6167655F7374796C655F6C6F6164223B7D, '', '1', 0x613A303A7B7D, 'image_style_deliver', 0x613A313A7B693A303B693A343B7D, '', '30', '5', '0', '', 'sites/default/files/styles/%', 'Generate image style', 't', '', '', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('sua-thong-tin-gian-hang.html', '', '', '1', 0x613A303A7B7D, 'shopEditInfo', 0x613A303A7B7D, '', '1', '1', '0', '', 'sua-thong-tin-gian-hang.html', 'Sửa thông tin gian hàng', 't', '', '', 'a:0:{}', '0', 'Sửa thông tin gian hàng', '', '0', '');
INSERT INTO `menu_router` VALUES ('system/ajax', '', '', '1', 0x613A303A7B7D, 'ajax_form_callback', 0x613A303A7B7D, 'ajax_deliver', '3', '2', '0', '', 'system/ajax', 'AHAH callback', 't', '', 'ajax_base_page_theme', 'a:0:{}', '0', '', '', '0', 'includes/form.inc');
INSERT INTO `menu_router` VALUES ('system/files', '', '', '1', 0x613A303A7B7D, 'file_download', 0x613A313A7B693A303B733A373A2270726976617465223B7D, '', '3', '2', '0', '', 'system/files', 'File download', 't', '', '', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('system/files/styles/%', 0x613A313A7B693A333B733A31363A22696D6167655F7374796C655F6C6F6164223B7D, '', '1', 0x613A303A7B7D, 'image_style_deliver', 0x613A313A7B693A303B693A333B7D, '', '14', '4', '0', '', 'system/files/styles/%', 'Generate image style', 't', '', '', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('system/temporary', '', '', '1', 0x613A303A7B7D, 'file_download', 0x613A313A7B693A303B733A393A2274656D706F72617279223B7D, '', '3', '2', '0', '', 'system/temporary', 'Temporary files', 't', '', '', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('system/timezone', '', '', '1', 0x613A303A7B7D, 'system_timezone', 0x613A303A7B7D, '', '3', '2', '0', '', 'system/timezone', 'Time zone', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/autocomplete', '', '', 'user_access', 0x613A313A7B693A303B733A31343A2261636365737320636F6E74656E74223B7D, 'taxonomy_autocomplete', 0x613A303A7B7D, '', '3', '2', '0', '', 'taxonomy/autocomplete', 'Autocomplete taxonomy', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/taxonomy/taxonomy.pages.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/term/%', 0x613A313A7B693A323B733A31383A227461786F6E6F6D795F7465726D5F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31343A2261636365737320636F6E74656E74223B7D, 'taxonomy_term_page', 0x613A313A7B693A303B693A323B7D, '', '6', '3', '0', '', 'taxonomy/term/%', 'Taxonomy term', 'taxonomy_term_title', 'a:1:{i:0;i:2;}', '', 'a:0:{}', '6', '', '', '0', 'modules/taxonomy/taxonomy.pages.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/term/%/edit', 0x613A313A7B693A323B733A31383A227461786F6E6F6D795F7465726D5F6C6F6164223B7D, '', 'taxonomy_term_edit_access', 0x613A313A7B693A303B693A323B7D, 'drupal_get_form', 0x613A333A7B693A303B733A31383A227461786F6E6F6D795F666F726D5F7465726D223B693A313B693A323B693A323B4E3B7D, '', '13', '4', '1', 'taxonomy/term/%', 'taxonomy/term/%', 'Edit', 't', '', '', 'a:0:{}', '132', '', '', '10', 'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/term/%/feed', 0x613A313A7B693A323B733A31383A227461786F6E6F6D795F7465726D5F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31343A2261636365737320636F6E74656E74223B7D, 'taxonomy_term_feed', 0x613A313A7B693A303B693A323B7D, '', '13', '4', '0', '', 'taxonomy/term/%/feed', 'Taxonomy term', 'taxonomy_term_title', 'a:1:{i:0;i:2;}', '', 'a:0:{}', '0', '', '', '0', 'modules/taxonomy/taxonomy.pages.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/term/%/view', 0x613A313A7B693A323B733A31383A227461786F6E6F6D795F7465726D5F6C6F6164223B7D, '', 'user_access', 0x613A313A7B693A303B733A31343A2261636365737320636F6E74656E74223B7D, 'taxonomy_term_page', 0x613A313A7B693A303B693A323B7D, '', '13', '4', '1', 'taxonomy/term/%', 'taxonomy/term/%', 'View', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/taxonomy/taxonomy.pages.inc');
INSERT INTO `menu_router` VALUES ('thoat.html', '', '', '1', 0x613A303A7B7D, 'shopLogout', 0x613A303A7B7D, '', '1', '1', '0', '', 'thoat.html', 'Thoát shop', 't', '', '', 'a:0:{}', '0', 'Thoat shop', '', '0', '');
INSERT INTO `menu_router` VALUES ('toolbar/toggle', '', '', 'user_access', 0x613A313A7B693A303B733A31343A2261636365737320746F6F6C626172223B7D, 'toolbar_toggle_page', 0x613A303A7B7D, '', '3', '2', '0', '', 'toolbar/toggle', 'Toggle drawer visibility', 't', '', '', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('trang-chu', '', '', '1', 0x613A303A7B7D, 'page_default', 0x613A303A7B7D, '', '1', '1', '0', '', 'trang-chu', 'Trang chủ', 't', '', '', 'a:0:{}', '0', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('user', '', '', '1', 0x613A303A7B7D, 'user_page', 0x613A303A7B7D, '', '1', '1', '0', '', 'user', 'User account', 'user_menu_title', '', '', 'a:0:{}', '6', '', '', '-10', 'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%', 0x613A313A7B693A313B733A393A22757365725F6C6F6164223B7D, '', 'user_view_access', 0x613A313A7B693A303B693A313B7D, 'user_view_page', 0x613A313A7B693A303B693A313B7D, '', '2', '2', '0', '', 'user/%', 'My account', 'user_page_title', 'a:1:{i:0;i:1;}', '', 'a:0:{}', '6', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('user/%/cancel', 0x613A313A7B693A313B733A393A22757365725F6C6F6164223B7D, '', 'user_cancel_access', 0x613A313A7B693A303B693A313B7D, 'drupal_get_form', 0x613A323A7B693A303B733A32343A22757365725F63616E63656C5F636F6E6669726D5F666F726D223B693A313B693A313B7D, '', '5', '3', '0', '', 'user/%/cancel', 'Cancel account', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%/cancel/confirm/%/%', 0x613A333A7B693A313B733A393A22757365725F6C6F6164223B693A343B4E3B693A353B4E3B7D, '', 'user_cancel_access', 0x613A313A7B693A303B693A313B7D, 'user_cancel_confirm', 0x613A333A7B693A303B693A313B693A313B693A343B693A323B693A353B7D, '', '44', '6', '0', '', 'user/%/cancel/confirm/%/%', 'Confirm account cancellation', 't', '', '', 'a:0:{}', '6', '', '', '0', 'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%/edit', 0x613A313A7B693A313B733A393A22757365725F6C6F6164223B7D, '', 'user_edit_access', 0x613A313A7B693A303B693A313B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31373A22757365725F70726F66696C655F666F726D223B693A313B693A313B7D, '', '5', '3', '1', 'user/%', 'user/%', 'Edit', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%/edit/account', 0x613A313A7B693A313B613A313A7B733A31383A22757365725F63617465676F72795F6C6F6164223B613A323A7B693A303B733A343A22256D6170223B693A313B733A363A2225696E646578223B7D7D7D, '', 'user_edit_access', 0x613A313A7B693A303B693A313B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31373A22757365725F70726F66696C655F666F726D223B693A313B693A313B7D, '', '11', '4', '1', 'user/%/edit', 'user/%', 'Account', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%/shortcuts', 0x613A313A7B693A313B733A393A22757365725F6C6F6164223B7D, '', 'shortcut_set_switch_access', 0x613A313A7B693A303B693A313B7D, 'drupal_get_form', 0x613A323A7B693A303B733A31393A2273686F72746375745F7365745F737769746368223B693A313B693A313B7D, '', '5', '3', '1', 'user/%', 'user/%', 'Shortcuts', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('user/%/view', 0x613A313A7B693A313B733A393A22757365725F6C6F6164223B7D, '', 'user_view_access', 0x613A313A7B693A303B693A313B7D, 'user_view_page', 0x613A313A7B693A303B693A313B7D, '', '5', '3', '1', 'user/%', 'user/%', 'View', 't', '', '', 'a:0:{}', '140', '', '', '-10', '');
INSERT INTO `menu_router` VALUES ('user/autocomplete', '', '', 'user_access', 0x613A313A7B693A303B733A32303A2261636365737320757365722070726F66696C6573223B7D, 'user_autocomplete', 0x613A303A7B7D, '', '3', '2', '0', '', 'user/autocomplete', 'User autocomplete', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/login', '', '', 'user_is_anonymous', 0x613A303A7B7D, 'user_page', 0x613A303A7B7D, '', '3', '2', '1', 'user', 'user', 'Log in', 't', '', '', 'a:0:{}', '140', '', '', '0', 'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/logout', '', '', 'user_is_logged_in', 0x613A303A7B7D, 'user_logout', 0x613A303A7B7D, '', '3', '2', '0', '', 'user/logout', 'Log out', 't', '', '', 'a:0:{}', '6', '', '', '10', 'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/password', '', '', '1', 0x613A303A7B7D, 'drupal_get_form', 0x613A313A7B693A303B733A393A22757365725F70617373223B7D, '', '3', '2', '1', 'user', 'user', 'Request new password', 't', '', '', 'a:0:{}', '132', '', '', '0', 'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/register', '', '', 'user_register_access', 0x613A303A7B7D, 'drupal_get_form', 0x613A313A7B693A303B733A31383A22757365725F72656769737465725F666F726D223B7D, '', '3', '2', '1', 'user', 'user', 'Create new account', 't', '', '', 'a:0:{}', '132', '', '', '0', '');
INSERT INTO `menu_router` VALUES ('user/reset/%/%/%', 0x613A333A7B693A323B4E3B693A333B4E3B693A343B4E3B7D, '', '1', 0x613A303A7B7D, 'drupal_get_form', 0x613A343A7B693A303B733A31353A22757365725F706173735F7265736574223B693A313B693A323B693A323B693A333B693A333B693A343B7D, '', '24', '5', '0', '', 'user/reset/%/%/%', 'Reset password', 't', '', '', 'a:0:{}', '0', '', '', '0', 'modules/user/user.pages.inc');

-- ----------------------------
-- Table structure for node
-- ----------------------------
DROP TABLE IF EXISTS `node`;
CREATE TABLE `node` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.',
  `vid` int(10) unsigned DEFAULT NULL COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.',
  PRIMARY KEY (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';

-- ----------------------------
-- Records of node
-- ----------------------------

-- ----------------------------
-- Table structure for node_access
-- ----------------------------
DROP TABLE IF EXISTS `node_access`;
CREATE TABLE `node_access` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';

-- ----------------------------
-- Records of node_access
-- ----------------------------
INSERT INTO `node_access` VALUES ('0', '0', 'all', '1', '0', '0');

-- ----------------------------
-- Table structure for node_comment_statistics
-- ----------------------------
DROP TABLE IF EXISTS `node_comment_statistics`;
CREATE TABLE `node_comment_statistics` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid for which the statistics are compiled.',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid of the last comment.',
  `last_comment_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from comment.changed.',
  `last_comment_name` varchar(60) DEFAULT NULL COMMENT 'The name of the latest author to post a comment on this node, from comment.name.',
  `last_comment_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The user ID of the latest author to post a comment on this node, from comment.uid.',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of comments on this node.',
  PRIMARY KEY (`nid`),
  KEY `node_comment_timestamp` (`last_comment_timestamp`),
  KEY `comment_count` (`comment_count`),
  KEY `last_comment_uid` (`last_comment_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains statistics of node and comments posts to show ...';

-- ----------------------------
-- Records of node_comment_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for node_revision
-- ----------------------------
DROP TABLE IF EXISTS `node_revision`;
CREATE TABLE `node_revision` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.',
  PRIMARY KEY (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.';

-- ----------------------------
-- Records of node_revision
-- ----------------------------

-- ----------------------------
-- Table structure for node_type
-- ----------------------------
DROP TABLE IF EXISTS `node_type`;
CREATE TABLE `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) unsigned NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined node types.';

-- ----------------------------
-- Records of node_type
-- ----------------------------
INSERT INTO `node_type` VALUES ('article', 'Article', 'node_content', 'node', 'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.', '', '1', 'Title', '1', '1', '0', '0', 'article');
INSERT INTO `node_type` VALUES ('page', 'Basic page', 'node_content', 'node', 'Use <em>basic pages</em> for your static content, such as an \'About us\' page.', '', '1', 'Title', '1', '1', '0', '0', 'page');

-- ----------------------------
-- Table structure for queue
-- ----------------------------
DROP TABLE IF EXISTS `queue`;
CREATE TABLE `queue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';

-- ----------------------------
-- Records of queue
-- ----------------------------

-- ----------------------------
-- Table structure for rdf_mapping
-- ----------------------------
DROP TABLE IF EXISTS `rdf_mapping`;
CREATE TABLE `rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.',
  PRIMARY KEY (`type`,`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores custom RDF mappings for user defined content types...';

-- ----------------------------
-- Records of rdf_mapping
-- ----------------------------
INSERT INTO `rdf_mapping` VALUES ('node', 'article', 0x613A31313A7B733A31313A226669656C645F696D616765223B613A323A7B733A31303A2270726564696361746573223B613A323A7B693A303B733A383A226F673A696D616765223B693A313B733A31323A22726466733A736565416C736F223B7D733A343A2274797065223B733A333A2272656C223B7D733A31303A226669656C645F74616773223B613A323A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A31303A2264633A7375626A656374223B7D733A343A2274797065223B733A333A2272656C223B7D733A373A2272646674797065223B613A323A7B693A303B733A393A2273696F633A4974656D223B693A313B733A31333A22666F61663A446F63756D656E74223B7D733A353A227469746C65223B613A313A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A383A2264633A7469746C65223B7D7D733A373A2263726561746564223B613A333A7B733A31303A2270726564696361746573223B613A323A7B693A303B733A373A2264633A64617465223B693A313B733A31303A2264633A63726561746564223B7D733A383A226461746174797065223B733A31323A227873643A6461746554696D65223B733A383A2263616C6C6261636B223B733A31323A22646174655F69736F38363031223B7D733A373A226368616E676564223B613A333A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A31313A2264633A6D6F646966696564223B7D733A383A226461746174797065223B733A31323A227873643A6461746554696D65223B733A383A2263616C6C6261636B223B733A31323A22646174655F69736F38363031223B7D733A343A22626F6479223B613A313A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A31353A22636F6E74656E743A656E636F646564223B7D7D733A333A22756964223B613A323A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A31363A2273696F633A6861735F63726561746F72223B7D733A343A2274797065223B733A333A2272656C223B7D733A343A226E616D65223B613A313A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A393A22666F61663A6E616D65223B7D7D733A31333A22636F6D6D656E745F636F756E74223B613A323A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A31363A2273696F633A6E756D5F7265706C696573223B7D733A383A226461746174797065223B733A31313A227873643A696E7465676572223B7D733A31333A226C6173745F6163746976697479223B613A333A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A32333A2273696F633A6C6173745F61637469766974795F64617465223B7D733A383A226461746174797065223B733A31323A227873643A6461746554696D65223B733A383A2263616C6C6261636B223B733A31323A22646174655F69736F38363031223B7D7D);
INSERT INTO `rdf_mapping` VALUES ('node', 'page', 0x613A393A7B733A373A2272646674797065223B613A313A7B693A303B733A31333A22666F61663A446F63756D656E74223B7D733A353A227469746C65223B613A313A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A383A2264633A7469746C65223B7D7D733A373A2263726561746564223B613A333A7B733A31303A2270726564696361746573223B613A323A7B693A303B733A373A2264633A64617465223B693A313B733A31303A2264633A63726561746564223B7D733A383A226461746174797065223B733A31323A227873643A6461746554696D65223B733A383A2263616C6C6261636B223B733A31323A22646174655F69736F38363031223B7D733A373A226368616E676564223B613A333A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A31313A2264633A6D6F646966696564223B7D733A383A226461746174797065223B733A31323A227873643A6461746554696D65223B733A383A2263616C6C6261636B223B733A31323A22646174655F69736F38363031223B7D733A343A22626F6479223B613A313A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A31353A22636F6E74656E743A656E636F646564223B7D7D733A333A22756964223B613A323A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A31363A2273696F633A6861735F63726561746F72223B7D733A343A2274797065223B733A333A2272656C223B7D733A343A226E616D65223B613A313A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A393A22666F61663A6E616D65223B7D7D733A31333A22636F6D6D656E745F636F756E74223B613A323A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A31363A2273696F633A6E756D5F7265706C696573223B7D733A383A226461746174797065223B733A31313A227873643A696E7465676572223B7D733A31333A226C6173745F6163746976697479223B613A333A7B733A31303A2270726564696361746573223B613A313A7B693A303B733A32333A2273696F633A6C6173745F61637469766974795F64617465223B7D733A383A226461746174797065223B733A31323A227873643A6461746554696D65223B733A383A2263616C6C6261636B223B733A31323A22646174655F69736F38363031223B7D7D);

-- ----------------------------
-- Table structure for registry
-- ----------------------------
DROP TABLE IF EXISTS `registry`;
CREATE TABLE `registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  PRIMARY KEY (`name`,`type`),
  KEY `hook` (`type`,`weight`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';

-- ----------------------------
-- Records of registry
-- ----------------------------
INSERT INTO `registry` VALUES ('AccessDeniedTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('AdminMetaTagTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('ArchiverInterface', 'interface', 'includes/archiver.inc', '', '0');
INSERT INTO `registry` VALUES ('ArchiverTar', 'class', 'modules/system/system.archiver.inc', 'system', '0');
INSERT INTO `registry` VALUES ('ArchiverZip', 'class', 'modules/system/system.archiver.inc', 'system', '0');
INSERT INTO `registry` VALUES ('Archive_Tar', 'class', 'modules/system/system.tar.inc', 'system', '0');
INSERT INTO `registry` VALUES ('BatchMemoryQueue', 'class', 'includes/batch.queue.inc', '', '0');
INSERT INTO `registry` VALUES ('BatchQueue', 'class', 'includes/batch.queue.inc', '', '0');
INSERT INTO `registry` VALUES ('BlockAdminThemeTestCase', 'class', 'modules/block/block.test', 'block', '-5');
INSERT INTO `registry` VALUES ('BlockCacheTestCase', 'class', 'modules/block/block.test', 'block', '-5');
INSERT INTO `registry` VALUES ('BlockHashTestCase', 'class', 'modules/block/block.test', 'block', '-5');
INSERT INTO `registry` VALUES ('BlockHiddenRegionTestCase', 'class', 'modules/block/block.test', 'block', '-5');
INSERT INTO `registry` VALUES ('BlockHTMLIdTestCase', 'class', 'modules/block/block.test', 'block', '-5');
INSERT INTO `registry` VALUES ('BlockInvalidRegionTestCase', 'class', 'modules/block/block.test', 'block', '-5');
INSERT INTO `registry` VALUES ('BlockTemplateSuggestionsUnitTest', 'class', 'modules/block/block.test', 'block', '-5');
INSERT INTO `registry` VALUES ('BlockTestCase', 'class', 'modules/block/block.test', 'block', '-5');
INSERT INTO `registry` VALUES ('BlockViewModuleDeltaAlterWebTest', 'class', 'modules/block/block.test', 'block', '-5');
INSERT INTO `registry` VALUES ('ColorTestCase', 'class', 'modules/color/color.test', 'color', '0');
INSERT INTO `registry` VALUES ('CommentActionsTestCase', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentAnonymous', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentApprovalTest', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentBlockFunctionalTest', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentContentRebuild', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentController', 'class', 'modules/comment/comment.module', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentFieldsTest', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentHelperCase', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentInterfaceTest', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentNodeAccessTest', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentNodeChangesTestCase', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentPagerTest', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentPreviewTest', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentRSSUnitTest', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentThreadingTestCase', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('CommentTokenReplaceTestCase', 'class', 'modules/comment/comment.test', 'comment', '0');
INSERT INTO `registry` VALUES ('ConfirmFormTest', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('ContextualDynamicContextTestCase', 'class', 'modules/contextual/contextual.test', 'contextual', '0');
INSERT INTO `registry` VALUES ('CronQueueTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('CronRunTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('DashboardBlocksTestCase', 'class', 'modules/dashboard/dashboard.test', 'dashboard', '0');
INSERT INTO `registry` VALUES ('Database', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseCondition', 'class', 'includes/database/query.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseConnection', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseConnectionNotDefinedException', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseConnection_mysql', 'class', 'includes/database/mysql/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseConnection_pgsql', 'class', 'includes/database/pgsql/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseConnection_sqlite', 'class', 'includes/database/sqlite/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseDriverNotSpecifiedException', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseLog', 'class', 'includes/database/log.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseSchema', 'class', 'includes/database/schema.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseSchemaObjectDoesNotExistException', 'class', 'includes/database/schema.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseSchemaObjectExistsException', 'class', 'includes/database/schema.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseSchema_mysql', 'class', 'includes/database/mysql/schema.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseSchema_pgsql', 'class', 'includes/database/pgsql/schema.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseSchema_sqlite', 'class', 'includes/database/sqlite/schema.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseStatementBase', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseStatementEmpty', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseStatementInterface', 'interface', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseStatementPrefetch', 'class', 'includes/database/prefetch.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseStatement_sqlite', 'class', 'includes/database/sqlite/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseTaskException', 'class', 'includes/install.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseTasks', 'class', 'includes/install.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseTasks_mysql', 'class', 'includes/database/mysql/install.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseTasks_pgsql', 'class', 'includes/database/pgsql/install.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseTasks_sqlite', 'class', 'includes/database/sqlite/install.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseTransaction', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseTransactionCommitFailedException', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseTransactionExplicitCommitNotAllowedException', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseTransactionNameNonUniqueException', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseTransactionNoActiveException', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DatabaseTransactionOutOfOrderException', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('DateTimeFunctionalTest', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('DBLogTestCase', 'class', 'modules/dblog/dblog.test', 'dblog', '0');
INSERT INTO `registry` VALUES ('DefaultMailSystem', 'class', 'modules/system/system.mail.inc', 'system', '0');
INSERT INTO `registry` VALUES ('DeleteQuery', 'class', 'includes/database/query.inc', '', '0');
INSERT INTO `registry` VALUES ('DeleteQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalCacheArray', 'class', 'includes/bootstrap.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalCacheInterface', 'interface', 'includes/cache.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalDatabaseCache', 'class', 'includes/cache.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalDefaultEntityController', 'class', 'includes/entity.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalEntityControllerInterface', 'interface', 'includes/entity.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalFakeCache', 'class', 'includes/cache-install.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalLocalStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalPrivateStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalPublicStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalQueue', 'class', 'modules/system/system.queue.inc', 'system', '0');
INSERT INTO `registry` VALUES ('DrupalQueueInterface', 'interface', 'modules/system/system.queue.inc', 'system', '0');
INSERT INTO `registry` VALUES ('DrupalReliableQueueInterface', 'interface', 'modules/system/system.queue.inc', 'system', '0');
INSERT INTO `registry` VALUES ('DrupalSetMessageTest', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('DrupalStreamWrapperInterface', 'interface', 'includes/stream_wrappers.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalTemporaryStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalUpdateException', 'class', 'includes/update.inc', '', '0');
INSERT INTO `registry` VALUES ('DrupalUpdaterInterface', 'interface', 'includes/updater.inc', '', '0');
INSERT INTO `registry` VALUES ('EnableDisableTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('EntityFieldQuery', 'class', 'includes/entity.inc', '', '0');
INSERT INTO `registry` VALUES ('EntityFieldQueryException', 'class', 'includes/entity.inc', '', '0');
INSERT INTO `registry` VALUES ('EntityMalformedException', 'class', 'includes/entity.inc', '', '0');
INSERT INTO `registry` VALUES ('EntityPropertiesTestCase', 'class', 'modules/field/tests/field.test', 'field', '0');
INSERT INTO `registry` VALUES ('FieldAttachOtherTestCase', 'class', 'modules/field/tests/field.test', 'field', '0');
INSERT INTO `registry` VALUES ('FieldAttachStorageTestCase', 'class', 'modules/field/tests/field.test', 'field', '0');
INSERT INTO `registry` VALUES ('FieldAttachTestCase', 'class', 'modules/field/tests/field.test', 'field', '0');
INSERT INTO `registry` VALUES ('FieldBulkDeleteTestCase', 'class', 'modules/field/tests/field.test', 'field', '0');
INSERT INTO `registry` VALUES ('FieldCrudTestCase', 'class', 'modules/field/tests/field.test', 'field', '0');
INSERT INTO `registry` VALUES ('FieldDisplayAPITestCase', 'class', 'modules/field/tests/field.test', 'field', '0');
INSERT INTO `registry` VALUES ('FieldException', 'class', 'modules/field/field.module', 'field', '0');
INSERT INTO `registry` VALUES ('FieldFormTestCase', 'class', 'modules/field/tests/field.test', 'field', '0');
INSERT INTO `registry` VALUES ('FieldInfo', 'class', 'modules/field/field.info.class.inc', 'field', '0');
INSERT INTO `registry` VALUES ('FieldInfoTestCase', 'class', 'modules/field/tests/field.test', 'field', '0');
INSERT INTO `registry` VALUES ('FieldInstanceCrudTestCase', 'class', 'modules/field/tests/field.test', 'field', '0');
INSERT INTO `registry` VALUES ('FieldsOverlapException', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('FieldSqlStorageTestCase', 'class', 'modules/field/modules/field_sql_storage/field_sql_storage.test', 'field_sql_storage', '0');
INSERT INTO `registry` VALUES ('FieldTestCase', 'class', 'modules/field/tests/field.test', 'field', '0');
INSERT INTO `registry` VALUES ('FieldTranslationsTestCase', 'class', 'modules/field/tests/field.test', 'field', '0');
INSERT INTO `registry` VALUES ('FieldUIAlterTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', '0');
INSERT INTO `registry` VALUES ('FieldUIManageDisplayTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', '0');
INSERT INTO `registry` VALUES ('FieldUIManageFieldsTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', '0');
INSERT INTO `registry` VALUES ('FieldUITestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', '0');
INSERT INTO `registry` VALUES ('FieldUpdateForbiddenException', 'class', 'modules/field/field.module', 'field', '0');
INSERT INTO `registry` VALUES ('FieldValidationException', 'class', 'modules/field/field.attach.inc', 'field', '0');
INSERT INTO `registry` VALUES ('FileFieldDisplayTestCase', 'class', 'modules/file/tests/file.test', 'file', '0');
INSERT INTO `registry` VALUES ('FileFieldPathTestCase', 'class', 'modules/file/tests/file.test', 'file', '0');
INSERT INTO `registry` VALUES ('FileFieldRevisionTestCase', 'class', 'modules/file/tests/file.test', 'file', '0');
INSERT INTO `registry` VALUES ('FileFieldTestCase', 'class', 'modules/file/tests/file.test', 'file', '0');
INSERT INTO `registry` VALUES ('FileFieldValidateTestCase', 'class', 'modules/file/tests/file.test', 'file', '0');
INSERT INTO `registry` VALUES ('FileFieldWidgetTestCase', 'class', 'modules/file/tests/file.test', 'file', '0');
INSERT INTO `registry` VALUES ('FileManagedFileElementTestCase', 'class', 'modules/file/tests/file.test', 'file', '0');
INSERT INTO `registry` VALUES ('FilePrivateTestCase', 'class', 'modules/file/tests/file.test', 'file', '0');
INSERT INTO `registry` VALUES ('FileTaxonomyTermTestCase', 'class', 'modules/file/tests/file.test', 'file', '0');
INSERT INTO `registry` VALUES ('FileTokenReplaceTestCase', 'class', 'modules/file/tests/file.test', 'file', '0');
INSERT INTO `registry` VALUES ('FileTransfer', 'class', 'includes/filetransfer/filetransfer.inc', '', '0');
INSERT INTO `registry` VALUES ('FileTransferChmodInterface', 'interface', 'includes/filetransfer/filetransfer.inc', '', '0');
INSERT INTO `registry` VALUES ('FileTransferException', 'class', 'includes/filetransfer/filetransfer.inc', '', '0');
INSERT INTO `registry` VALUES ('FileTransferFTP', 'class', 'includes/filetransfer/ftp.inc', '', '0');
INSERT INTO `registry` VALUES ('FileTransferFTPExtension', 'class', 'includes/filetransfer/ftp.inc', '', '0');
INSERT INTO `registry` VALUES ('FileTransferLocal', 'class', 'includes/filetransfer/local.inc', '', '0');
INSERT INTO `registry` VALUES ('FileTransferSSH', 'class', 'includes/filetransfer/ssh.inc', '', '0');
INSERT INTO `registry` VALUES ('FilterAdminTestCase', 'class', 'modules/filter/filter.test', 'filter', '0');
INSERT INTO `registry` VALUES ('FilterCRUDTestCase', 'class', 'modules/filter/filter.test', 'filter', '0');
INSERT INTO `registry` VALUES ('FilterDefaultFormatTestCase', 'class', 'modules/filter/filter.test', 'filter', '0');
INSERT INTO `registry` VALUES ('FilterDOMSerializeTestCase', 'class', 'modules/filter/filter.test', 'filter', '0');
INSERT INTO `registry` VALUES ('FilterFormatAccessTestCase', 'class', 'modules/filter/filter.test', 'filter', '0');
INSERT INTO `registry` VALUES ('FilterHooksTestCase', 'class', 'modules/filter/filter.test', 'filter', '0');
INSERT INTO `registry` VALUES ('FilterNoFormatTestCase', 'class', 'modules/filter/filter.test', 'filter', '0');
INSERT INTO `registry` VALUES ('FilterSecurityTestCase', 'class', 'modules/filter/filter.test', 'filter', '0');
INSERT INTO `registry` VALUES ('FilterSettingsTestCase', 'class', 'modules/filter/filter.test', 'filter', '0');
INSERT INTO `registry` VALUES ('FilterUnitTestCase', 'class', 'modules/filter/filter.test', 'filter', '0');
INSERT INTO `registry` VALUES ('FloodFunctionalTest', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('FrontPageTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('HelpTestCase', 'class', 'modules/help/help.test', 'help', '0');
INSERT INTO `registry` VALUES ('HookRequirementsTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('ImageAdminStylesUnitTest', 'class', 'modules/image/image.test', 'image', '0');
INSERT INTO `registry` VALUES ('ImageAdminUiTestCase', 'class', 'modules/image/image.test', 'image', '0');
INSERT INTO `registry` VALUES ('ImageDimensionsScaleTestCase', 'class', 'modules/image/image.test', 'image', '0');
INSERT INTO `registry` VALUES ('ImageDimensionsTestCase', 'class', 'modules/image/image.test', 'image', '0');
INSERT INTO `registry` VALUES ('ImageEffectsUnitTest', 'class', 'modules/image/image.test', 'image', '0');
INSERT INTO `registry` VALUES ('ImageFieldDefaultImagesTestCase', 'class', 'modules/image/image.test', 'image', '0');
INSERT INTO `registry` VALUES ('ImageFieldDisplayTestCase', 'class', 'modules/image/image.test', 'image', '0');
INSERT INTO `registry` VALUES ('ImageFieldTestCase', 'class', 'modules/image/image.test', 'image', '0');
INSERT INTO `registry` VALUES ('ImageFieldValidateTestCase', 'class', 'modules/image/image.test', 'image', '0');
INSERT INTO `registry` VALUES ('ImageStyleFlushTest', 'class', 'modules/image/image.test', 'image', '0');
INSERT INTO `registry` VALUES ('ImageStylesPathAndUrlTestCase', 'class', 'modules/image/image.test', 'image', '0');
INSERT INTO `registry` VALUES ('ImageThemeFunctionWebTestCase', 'class', 'modules/image/image.test', 'image', '0');
INSERT INTO `registry` VALUES ('InfoFileParserTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('InsertQuery', 'class', 'includes/database/query.inc', '', '0');
INSERT INTO `registry` VALUES ('InsertQuery_mysql', 'class', 'includes/database/mysql/query.inc', '', '0');
INSERT INTO `registry` VALUES ('InsertQuery_pgsql', 'class', 'includes/database/pgsql/query.inc', '', '0');
INSERT INTO `registry` VALUES ('InsertQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', '0');
INSERT INTO `registry` VALUES ('InvalidMergeQueryException', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('IPAddressBlockingTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('ListDynamicValuesTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', '0');
INSERT INTO `registry` VALUES ('ListDynamicValuesValidationTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', '0');
INSERT INTO `registry` VALUES ('ListFieldTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', '0');
INSERT INTO `registry` VALUES ('ListFieldUITestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', '0');
INSERT INTO `registry` VALUES ('MailSystemInterface', 'interface', 'includes/mail.inc', '', '0');
INSERT INTO `registry` VALUES ('MemoryQueue', 'class', 'modules/system/system.queue.inc', 'system', '0');
INSERT INTO `registry` VALUES ('MenuNodeTestCase', 'class', 'modules/menu/menu.test', 'menu', '0');
INSERT INTO `registry` VALUES ('MenuTestCase', 'class', 'modules/menu/menu.test', 'menu', '0');
INSERT INTO `registry` VALUES ('MergeQuery', 'class', 'includes/database/query.inc', '', '0');
INSERT INTO `registry` VALUES ('ModuleDependencyTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('ModuleRequiredTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('ModuleTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('ModuleUpdater', 'class', 'modules/system/system.updater.inc', 'system', '0');
INSERT INTO `registry` VALUES ('ModuleVersionTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('MultiStepNodeFormBasicOptionsTest', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NewDefaultThemeBlocks', 'class', 'modules/block/block.test', 'block', '-5');
INSERT INTO `registry` VALUES ('NodeAccessBaseTableTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeAccessFieldTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeAccessPagerTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeAccessRebuildTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeAccessRecordsTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeAccessTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeAdminTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeBlockFunctionalTest', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeBlockTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeBuildContent', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeController', 'class', 'modules/node/node.module', 'node', '0');
INSERT INTO `registry` VALUES ('NodeCreationTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeEntityFieldQueryAlter', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeEntityViewModeAlterTest', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeFeedTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeLoadHooksTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeLoadMultipleTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodePageCacheTest', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodePostSettingsTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeQueryAlter', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeRevisionPermissionsTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeRevisionsTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeRSSContentTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeSaveTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeTitleTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeTitleXSSTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeTokenReplaceTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeTypePersistenceTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeTypeTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NodeWebTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('NoFieldsException', 'class', 'includes/database/database.inc', '', '0');
INSERT INTO `registry` VALUES ('NoHelpTestCase', 'class', 'modules/help/help.test', 'help', '0');
INSERT INTO `registry` VALUES ('NonDefaultBlockAdmin', 'class', 'modules/block/block.test', 'block', '-5');
INSERT INTO `registry` VALUES ('NumberFieldTestCase', 'class', 'modules/field/modules/number/number.test', 'number', '0');
INSERT INTO `registry` VALUES ('OptionsSelectDynamicValuesTestCase', 'class', 'modules/field/modules/options/options.test', 'options', '0');
INSERT INTO `registry` VALUES ('OptionsWidgetsTestCase', 'class', 'modules/field/modules/options/options.test', 'options', '0');
INSERT INTO `registry` VALUES ('PageEditTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('PageNotFoundTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('PagePreviewTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('PagerDefault', 'class', 'includes/pager.inc', '', '0');
INSERT INTO `registry` VALUES ('PageTitleFiltering', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('PageViewTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('PathLanguageTestCase', 'class', 'modules/path/path.test', 'path', '0');
INSERT INTO `registry` VALUES ('PathLanguageUITestCase', 'class', 'modules/path/path.test', 'path', '0');
INSERT INTO `registry` VALUES ('PathMonolingualTestCase', 'class', 'modules/path/path.test', 'path', '0');
INSERT INTO `registry` VALUES ('PathTaxonomyTermTestCase', 'class', 'modules/path/path.test', 'path', '0');
INSERT INTO `registry` VALUES ('PathTestCase', 'class', 'modules/path/path.test', 'path', '0');
INSERT INTO `registry` VALUES ('Query', 'class', 'includes/database/query.inc', '', '0');
INSERT INTO `registry` VALUES ('QueryAlterableInterface', 'interface', 'includes/database/query.inc', '', '0');
INSERT INTO `registry` VALUES ('QueryConditionInterface', 'interface', 'includes/database/query.inc', '', '0');
INSERT INTO `registry` VALUES ('QueryExtendableInterface', 'interface', 'includes/database/select.inc', '', '0');
INSERT INTO `registry` VALUES ('QueryPlaceholderInterface', 'interface', 'includes/database/query.inc', '', '0');
INSERT INTO `registry` VALUES ('QueueTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('RdfCommentAttributesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0');
INSERT INTO `registry` VALUES ('RdfCrudTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0');
INSERT INTO `registry` VALUES ('RdfGetRdfNamespacesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0');
INSERT INTO `registry` VALUES ('RdfMappingDefinitionTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0');
INSERT INTO `registry` VALUES ('RdfMappingHookTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0');
INSERT INTO `registry` VALUES ('RdfRdfaMarkupTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0');
INSERT INTO `registry` VALUES ('RdfTrackerAttributesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', '0');
INSERT INTO `registry` VALUES ('RetrieveFileTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('SchemaCache', 'class', 'includes/bootstrap.inc', '', '0');
INSERT INTO `registry` VALUES ('SearchAdvancedSearchForm', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchBlockTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchCommentCountToggleTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchCommentTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchConfigSettingsForm', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchEmbedForm', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchExactTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchExcerptTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchExpressionInsertExtractTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchKeywordsConditions', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchLanguageTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchMatchTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchNodeAccessTest', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchNodeTagTest', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchNumberMatchingTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchNumbersTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchPageOverride', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchPageText', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchQuery', 'class', 'modules/search/search.extender.inc', 'search', '0');
INSERT INTO `registry` VALUES ('SearchRankingTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchSetLocaleTest', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchSimplifyTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SearchTokenizerTestCase', 'class', 'modules/search/search.test', 'search', '0');
INSERT INTO `registry` VALUES ('SelectQuery', 'class', 'includes/database/select.inc', '', '0');
INSERT INTO `registry` VALUES ('SelectQueryExtender', 'class', 'includes/database/select.inc', '', '0');
INSERT INTO `registry` VALUES ('SelectQueryInterface', 'interface', 'includes/database/select.inc', '', '0');
INSERT INTO `registry` VALUES ('SelectQuery_pgsql', 'class', 'includes/database/pgsql/select.inc', '', '0');
INSERT INTO `registry` VALUES ('SelectQuery_sqlite', 'class', 'includes/database/sqlite/select.inc', '', '0');
INSERT INTO `registry` VALUES ('ShortcutLinksTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', '0');
INSERT INTO `registry` VALUES ('ShortcutSetsTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', '0');
INSERT INTO `registry` VALUES ('ShortcutTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', '0');
INSERT INTO `registry` VALUES ('ShutdownFunctionsTest', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('SiteMaintenanceTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('SkipDotsRecursiveDirectoryIterator', 'class', 'includes/filetransfer/filetransfer.inc', '', '0');
INSERT INTO `registry` VALUES ('StreamWrapperInterface', 'interface', 'includes/stream_wrappers.inc', '', '0');
INSERT INTO `registry` VALUES ('SummaryLengthTestCase', 'class', 'modules/node/node.test', 'node', '0');
INSERT INTO `registry` VALUES ('SystemAdminTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('SystemAuthorizeCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('SystemBlockTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('SystemIndexPhpTest', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('SystemInfoAlterTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('SystemMainContentFallback', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('SystemQueue', 'class', 'modules/system/system.queue.inc', 'system', '0');
INSERT INTO `registry` VALUES ('SystemThemeFunctionalTest', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('SystemValidTokenTest', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('TableSort', 'class', 'includes/tablesort.inc', '', '0');
INSERT INTO `registry` VALUES ('TaxonomyEFQTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyHooksTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyLegacyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyLoadMultipleTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyRSSTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyTermController', 'class', 'modules/taxonomy/taxonomy.module', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyTermFieldMultipleVocabularyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyTermFieldTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyTermFunctionTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyTermIndexTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyTermTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyThemeTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyTokenReplaceTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyVocabularyController', 'class', 'modules/taxonomy/taxonomy.module', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyVocabularyFunctionalTest', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyVocabularyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TaxonomyWebTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', '0');
INSERT INTO `registry` VALUES ('TestingMailSystem', 'class', 'modules/system/system.mail.inc', 'system', '0');
INSERT INTO `registry` VALUES ('TextFieldTestCase', 'class', 'modules/field/modules/text/text.test', 'text', '0');
INSERT INTO `registry` VALUES ('TextSummaryTestCase', 'class', 'modules/field/modules/text/text.test', 'text', '0');
INSERT INTO `registry` VALUES ('TextTranslationTestCase', 'class', 'modules/field/modules/text/text.test', 'text', '0');
INSERT INTO `registry` VALUES ('ThemeRegistry', 'class', 'includes/theme.inc', '', '0');
INSERT INTO `registry` VALUES ('ThemeUpdater', 'class', 'modules/system/system.updater.inc', 'system', '0');
INSERT INTO `registry` VALUES ('TokenReplaceTestCase', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('TokenScanTest', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('TruncateQuery', 'class', 'includes/database/query.inc', '', '0');
INSERT INTO `registry` VALUES ('TruncateQuery_mysql', 'class', 'includes/database/mysql/query.inc', '', '0');
INSERT INTO `registry` VALUES ('TruncateQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', '0');
INSERT INTO `registry` VALUES ('UpdateQuery', 'class', 'includes/database/query.inc', '', '0');
INSERT INTO `registry` VALUES ('UpdateQuery_pgsql', 'class', 'includes/database/pgsql/query.inc', '', '0');
INSERT INTO `registry` VALUES ('UpdateQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', '0');
INSERT INTO `registry` VALUES ('Updater', 'class', 'includes/updater.inc', '', '0');
INSERT INTO `registry` VALUES ('UpdaterException', 'class', 'includes/updater.inc', '', '0');
INSERT INTO `registry` VALUES ('UpdaterFileTransferException', 'class', 'includes/updater.inc', '', '0');
INSERT INTO `registry` VALUES ('UpdateScriptFunctionalTest', 'class', 'modules/system/system.test', 'system', '0');
INSERT INTO `registry` VALUES ('UserAccountLinksUnitTests', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserAdminTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserAuthmapAssignmentTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserAutocompleteTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserBlocksUnitTests', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserCancelTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserController', 'class', 'modules/user/user.module', 'user', '0');
INSERT INTO `registry` VALUES ('UserCreateTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserEditedOwnAccountTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserEditTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserLoginTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserPasswordResetTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserPermissionsTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserPictureTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserRegistrationTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserRoleAdminTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserRolesAssignmentTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserSaveTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserSignatureTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserTimeZoneFunctionalTest', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserTokenReplaceTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserUserSearchTestCase', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserValidateCurrentPassCustomForm', 'class', 'modules/user/user.test', 'user', '0');
INSERT INTO `registry` VALUES ('UserValidationTestCase', 'class', 'modules/user/user.test', 'user', '0');

-- ----------------------------
-- Table structure for registry_file
-- ----------------------------
DROP TABLE IF EXISTS `registry_file`;
CREATE TABLE `registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';

-- ----------------------------
-- Records of registry_file
-- ----------------------------
INSERT INTO `registry_file` VALUES ('includes/actions.inc', '859c360d93c9e1b480b2aea97bace00fec80b78ec241d689d50c11c1b9d3724f');
INSERT INTO `registry_file` VALUES ('includes/ajax.inc', 'bcf9ebd2d63beccea24f2d12cc402a59ba4f0720983e2e1cb82cd6919f21aa94');
INSERT INTO `registry_file` VALUES ('includes/archiver.inc', '42862bf8819db773fed5c36a8f989a3ff9539a5180164f0cf1f17df26968de0e');
INSERT INTO `registry_file` VALUES ('includes/authorize.inc', 'f5fe0b9f9c23f9493a42b7b87a1d815f6cf2607042a710c9263d5df78ff35cbb');
INSERT INTO `registry_file` VALUES ('includes/batch.inc', '2f70e5c137d16e15a6e671ae147332bc31909df233c34128208cd2f018847390');
INSERT INTO `registry_file` VALUES ('includes/batch.queue.inc', '9bceecc4155daefbe11c87856d034f75634fa8b42ff21c4ee3366794b92bc0ec');
INSERT INTO `registry_file` VALUES ('includes/bootstrap.inc', 'ff58caa42aa641ff5bcfc6cc2312416dae059f753cbbaf8427736f59965028d9');
INSERT INTO `registry_file` VALUES ('includes/cache-install.inc', '7405c3a6b7d9a93f88ab299d467d0eff0b17ad36ee4126265f4c6c159204fd90');
INSERT INTO `registry_file` VALUES ('includes/cache.inc', 'a654efdd1043aec026dd6272a7f5ca57bee82d570ce6c97240eb76bfaad20c83');
INSERT INTO `registry_file` VALUES ('includes/common.inc', '15263f4439cccd70c0ab8f4204900748522a9408be9f7d65514bc53d2e8fa68e');
INSERT INTO `registry_file` VALUES ('includes/database/database.inc', '8379205fc94712c9866071c199f4e674cbc4ce2f52530e3afb7be0e9d12c4f02');
INSERT INTO `registry_file` VALUES ('includes/database/log.inc', '8f413b2a9797b5882642ea8db86439a195c628da691e9c5cab829df25d82dd20');
INSERT INTO `registry_file` VALUES ('includes/database/mysql/database.inc', 'd46b3188dd3722c49abc6588fa3a5f56004bbd69a81b04b4e96d7fe9a6d22c88');
INSERT INTO `registry_file` VALUES ('includes/database/mysql/install.inc', '8895c89a3a308c944f141245afd9382faa06dd5c28a4eb2a0076fb95a765e8fb');
INSERT INTO `registry_file` VALUES ('includes/database/mysql/query.inc', '1bfaa2c759e431d699c353cd86f59a02b6dcb2b7afd775576e082155e23d5474');
INSERT INTO `registry_file` VALUES ('includes/database/mysql/schema.inc', '0512fb10448f83560e0e93175cb98926d359ba1c19dfaf89091ff954c5396d02');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/database.inc', 'c5d5a67d74a47161c1f4b724b1836a0e90ab7787aa7cd19943f41b6b25ba900d');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/install.inc', '8c12e3a5d1318c095975db1e1db6addc285e48c2fded0e8cdedbb3c69f4365ba');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/query.inc', '4def4aef89e3e971bee2538c485a254cc680a7369e098946088cda0caeaddb18');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/schema.inc', '2b970d1a846dfe761e3c3a651b1e123316e29057edcfe8fdf6d72ed5a21bdad8');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/select.inc', '5f6abd312afeffced8ad049abb9890589df17b05de6ef514a8df60b641a5da5c');
INSERT INTO `registry_file` VALUES ('includes/database/prefetch.inc', 'd001592b2c8967a1848d685dc830dfdc6b88c28b802a09a5abfc5e0f1d5af5f6');
INSERT INTO `registry_file` VALUES ('includes/database/query.inc', '5e29340a7c28bd995a7e001885a5eaedbd58be51cc84eb2abb55a3cae161663f');
INSERT INTO `registry_file` VALUES ('includes/database/schema.inc', '37044fb7d65582a0022074e0b26d47c36655760152cea5fb5825d90ef35dd1ce');
INSERT INTO `registry_file` VALUES ('includes/database/select.inc', '057e8fdfcec7f321d5c84f90335a893d126ac4deb43b5095c4d0b2a37a9ca21e');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/database.inc', 'bc44135e8f74fd17756812115ed64fc1fb48bab55c6e86ebf22364a3115fd5be');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/install.inc', '4f2c42c5fdbaef9f2b28f61f244754755a7ebd356ccc9947c03de80d1ed48019');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/query.inc', '64b39522fbb82408c93aca47501583d9fff84e9ddf32bfa105c45da300019c94');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/schema.inc', '2de4711ea7b16e3dfdca76fc5dce97b7166e432fcd17ce9d64e95b8483a06bfa');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/select.inc', '17d91e8b050487801fbca0023faa7d370490f56e3c069cd707dfb320716fa750');
INSERT INTO `registry_file` VALUES ('includes/date.inc', '78db5787e7ff1ee4b3ef89cb7d5766c40bab6432cc708080d8198dc8a08ed948');
INSERT INTO `registry_file` VALUES ('includes/entity.inc', 'aa886cb959da973fff08ad85a0dc0eed05202f2647a508469aef0f650443cc00');
INSERT INTO `registry_file` VALUES ('includes/errors.inc', '4d8bb04e2efeb179913c3895411ab35b4b45e5aa03eb48d36e2e58adc44428f0');
INSERT INTO `registry_file` VALUES ('includes/file.inc', '8467f8eb648c7e6f66f85930c6224fce67562a1fc00d98a71847174c83441d88');
INSERT INTO `registry_file` VALUES ('includes/file.mimetypes.inc', '3f7558f1d6cc5ce54cd8afc34c9946e6291fc7894e78e1eec9fd2829303eb60e');
INSERT INTO `registry_file` VALUES ('includes/filetransfer/filetransfer.inc', '19c1838b3465797bc3a8c4880efae05f7a76658ac858a6e4a645a63662e57dc7');
INSERT INTO `registry_file` VALUES ('includes/filetransfer/ftp.inc', 'ef1472c4f7ed05c93e0116148a81181cf81b8293b81b5b87bc4808e11b4f9968');
INSERT INTO `registry_file` VALUES ('includes/filetransfer/local.inc', '37cd2835cf0f0df5b637542ea8deffe4d5b50bf325a9f69b689386fe9d7c934c');
INSERT INTO `registry_file` VALUES ('includes/filetransfer/ssh.inc', '7da26ffc1451b63b373b54ed8c134b6f51f64565edab770049a3031c3e70bcd9');
INSERT INTO `registry_file` VALUES ('includes/form.inc', '99d011db8b0a6b61c04b73ea1d0bb2def641579be3f8e89244a58b96c8b09857');
INSERT INTO `registry_file` VALUES ('includes/graph.inc', '2f847387a1fc05bc7dbd555d63bb4108cdfb6dea52d0f5a2ccfa3cf52dfab868');
INSERT INTO `registry_file` VALUES ('includes/image.inc', '5c058a24f3664c03556617773c398189d73b681d962dfb6b7aa17244cc1aa355');
INSERT INTO `registry_file` VALUES ('includes/install.core.inc', '3a97d3c7c5f550e0f383d797c61aa148bf8b9d7f0101caa3ab3627097ee46008');
INSERT INTO `registry_file` VALUES ('includes/install.inc', '68b4a25fa55a4cbff138536c55000d4149a7864a1f34290bdfa609e0d46147bb');
INSERT INTO `registry_file` VALUES ('includes/iso.inc', '0b5499b1578ff12f1361dd68433c5254be458c4b7100d42bbcc7450aac1f6f3e');
INSERT INTO `registry_file` VALUES ('includes/json-encode.inc', '026d78220c634efe7baf0c1d4835c2ba1a4d4e9b284954e6d70c3a9dbed2a825');
INSERT INTO `registry_file` VALUES ('includes/language.inc', '3349118f652cff5da4b43dd5bcbad9df3968e165939404bdd96715ff4b2cafb5');
INSERT INTO `registry_file` VALUES ('includes/locale.inc', 'f25e194f7dab3669d1fa354a7000ec6b1c8053f46fe88852a70bdc639caef0d7');
INSERT INTO `registry_file` VALUES ('includes/lock.inc', '84481b291a7b7d28ac6c7f54f3fe2ecd15d74423aa9e28baec2e85d50092d615');
INSERT INTO `registry_file` VALUES ('includes/mail.inc', '07edabc0f904c814010298eb7dadb86633fcf9ddef30ba47e359c7f9d4f8fbe4');
INSERT INTO `registry_file` VALUES ('includes/menu.inc', 'b1718109de2fdac0e99183c785b101a9d4c1830da21bbbeb3de22c062aa82613');
INSERT INTO `registry_file` VALUES ('includes/module.inc', '964a6fd1db4efe16b54bc9437e27f3846e14453fb1d490184ef77da1ab13f9e0');
INSERT INTO `registry_file` VALUES ('includes/pager.inc', '0e88b406e896c45f0d7c78b9f105d067df8bdc1dac9aa4df7cb17a8fd85a0b80');
INSERT INTO `registry_file` VALUES ('includes/password.inc', 'e630c55e393e85c44150d295c1aa9a9d0f40a428e43b61f38a75082da371354e');
INSERT INTO `registry_file` VALUES ('includes/path.inc', '43e24e30a182fcbdb4a778f70db725d5d8e6bbbc6fc4d4b5cf827983b5390539');
INSERT INTO `registry_file` VALUES ('includes/registry.inc', '5c514e8a7c3af6750ef824e7268b255b2a0d22ef87527be377ab69db6c8fe21a');
INSERT INTO `registry_file` VALUES ('includes/session.inc', 'b394b9ff290563943d498c78c396e0e89ad9a593cc17e9b8efb960f778531187');
INSERT INTO `registry_file` VALUES ('includes/stream_wrappers.inc', 'bd534ecba834ecbd5438b8ca58ce027cb5984f8e61535de2ef6fb2a8ec68a16d');
INSERT INTO `registry_file` VALUES ('includes/tablesort.inc', '3e4f789838ffb4aea03c2a98119507a88ebc74f0e71a4d23b8468969aa0fcc64');
INSERT INTO `registry_file` VALUES ('includes/theme.inc', '3f6a7aa60b6ab2f59f97528cf967a7cba3f354533f0c6d8a1dd63af017403ca1');
INSERT INTO `registry_file` VALUES ('includes/theme.maintenance.inc', '56f862149825bc1b669ec5f735ce1e89e10e56b781cd2acd81c428c821df39cd');
INSERT INTO `registry_file` VALUES ('includes/token.inc', '7e268ac14fd364d9b04bbdf60701772233557da649747932ee0d7998878d3b96');
INSERT INTO `registry_file` VALUES ('includes/unicode.entities.inc', 'e1a42c70df8e5e2f546e79bd9a69eb39085559ff24e45d53d84d51d7e00547e3');
INSERT INTO `registry_file` VALUES ('includes/unicode.inc', '6dfea063b1241f511f8f16b0632f9437034670074fe808cd43ac2ef366d732aa');
INSERT INTO `registry_file` VALUES ('includes/update.inc', '50bf04a0f2ba7431d1d7eb96c33ed5cf7396b345fc0c69b740a7b1e6b6225533');
INSERT INTO `registry_file` VALUES ('includes/updater.inc', 'a9dea2f035e323874929e69beb800b5ff5e73e3b6a904e728788a37ccf008415');
INSERT INTO `registry_file` VALUES ('includes/utility.inc', '94c2b587b95740533a83354b12d6f68f8f810e19dbb5652c388da470f88ea4be');
INSERT INTO `registry_file` VALUES ('includes/xmlrpc.inc', '8c586c3afa10c009a468a1d2da32d9749aa413343da4ed584740a0383a3ff9a6');
INSERT INTO `registry_file` VALUES ('includes/xmlrpcs.inc', 'd2ac209c397201a6b4c55d304b95106f5f2642ec41f22bd252b601e3abfdd801');
INSERT INTO `registry_file` VALUES ('modules/block/block.test', 'b0968136c024cca3ec9384f4b339095c186068e111d38208562b10268103f704');
INSERT INTO `registry_file` VALUES ('modules/color/color.test', '8384abb75de38e38e9f9fc6f4d6700b033f8b4fbf81c32d1425a6cc4ac2bbf41');
INSERT INTO `registry_file` VALUES ('modules/comment/comment.module', '3ab24322a90a253f70716c1c3871f5136e849de6d139b5f7da6c0d9643234bf0');
INSERT INTO `registry_file` VALUES ('modules/comment/comment.test', 'a4a0ac46c8c8faf5f4fa02e853ff37cc52e87e53952d1dc20e61226a63536348');
INSERT INTO `registry_file` VALUES ('modules/contextual/contextual.test', 'ea3d4b5752d1a2e159c51d933ed54695ba41976e635dbb3c224ce426d093a888');
INSERT INTO `registry_file` VALUES ('modules/dashboard/dashboard.test', '73109fa8ee522914cf417adfcf860d5e52eb7e17fdc155fb0d6cf3a8ef587dd3');
INSERT INTO `registry_file` VALUES ('modules/dblog/dblog.test', 'a19e85e59b922dd31d407c082691223e8aa63e0d5458c0020d28ac0e461628fa');
INSERT INTO `registry_file` VALUES ('modules/field/field.attach.inc', '13f74d34fab9b8b29c9385d47b341438b186756e4cd48ba703d9a3e27530dbef');
INSERT INTO `registry_file` VALUES ('modules/field/field.info.class.inc', '9f78fe500e537a0530c665d1a4e24e5d477c21750b18ba7ad32cdb79adf563c7');
INSERT INTO `registry_file` VALUES ('modules/field/field.module', 'cfe39892a44887d5bcdc86f439a51c8c440b31d77838b4307e22d8369a04bdaa');
INSERT INTO `registry_file` VALUES ('modules/field/modules/field_sql_storage/field_sql_storage.test', '90b05508fa925e91cd86e30a346b89840505e0b91e17c6b2f0c79a974b818e8d');
INSERT INTO `registry_file` VALUES ('modules/field/modules/list/tests/list.test', 'f9707dde3e6ec2a0551651105d6e60576e4fa42f51f097136d3663876066f6d3');
INSERT INTO `registry_file` VALUES ('modules/field/modules/number/number.test', '3d495c619e1a4cfdefdd1af902662ae2c7e2fca2dc50ce8d480689cea15a9e26');
INSERT INTO `registry_file` VALUES ('modules/field/modules/options/options.test', '2f3b35e2160672b398fbf25a2eb1444072fa4ded15d50400f8bbd2976cf57eae');
INSERT INTO `registry_file` VALUES ('modules/field/modules/text/text.test', '9cdd20be63154a7320394863b059f7fbbc2321f0a1ab428aa212026416562fad');
INSERT INTO `registry_file` VALUES ('modules/field/tests/field.test', '7398771cfbf4099d02b1d808a1aa36f6689e7aeef6e94cca0c7ff57b788afe27');
INSERT INTO `registry_file` VALUES ('modules/field_ui/field_ui.test', 'd0e498445f02efb64fde4c2ec820af23abed312ecbdf32798b24e34ac6a98ca1');
INSERT INTO `registry_file` VALUES ('modules/file/tests/file.test', '5aaa144e9ea90182da3d3d0bb9fa7b54f56aa10af3680d2b729883e9db3c95d7');
INSERT INTO `registry_file` VALUES ('modules/filter/filter.test', '683245f1fdca6385be6cb2f15d3f00be98fcfcc3217bbe2f3e29520847d58e8a');
INSERT INTO `registry_file` VALUES ('modules/help/help.test', 'b8bfed778911b9678882f51d7e10621f22310bf445e269d174b098fb881cea50');
INSERT INTO `registry_file` VALUES ('modules/image/image.test', '00adeedc873aef14d73c99ef5842a42d1fc2342dcb9fbcfb265563d6a848c746');
INSERT INTO `registry_file` VALUES ('modules/menu/menu.test', 'c794992fe5949ad5998edf71efccb3400e7245818b4eef61ae4951078a59e4e1');
INSERT INTO `registry_file` VALUES ('modules/node/node.module', 'b6e3d4f578c9f1a3de37e33a133622de8e3df05a0b2634efaf76dd15a44c2b21');
INSERT INTO `registry_file` VALUES ('modules/node/node.test', '42ea592189fcf07751be4a846559537250aee597942681d2090eb37251aeb1e4');
INSERT INTO `registry_file` VALUES ('modules/path/path.test', '164c888c4c51a28ffb83892b938323cf8b9cd6690cd8b32ba1a536cacd66916d');
INSERT INTO `registry_file` VALUES ('modules/rdf/rdf.test', '7de4968052028f2cb10cd863a1366be7f3f44cdb436e977c971dd0d9fa5946c4');
INSERT INTO `registry_file` VALUES ('modules/search/search.extender.inc', 'ab6cbc747e79bb8422873f985ef9246e4b25ca0b41401df41b6d06a2669340fa');
INSERT INTO `registry_file` VALUES ('modules/search/search.test', '565c8969c40a4d9fc8ec8998384f0031f1beaddfca3905f23fd941337c07a271');
INSERT INTO `registry_file` VALUES ('modules/shortcut/shortcut.test', '0500f73ceca0b5420c13c9a7f80840f730318c7f0272fdf935c270c6ab6d1610');
INSERT INTO `registry_file` VALUES ('modules/system/system.archiver.inc', 'fe7ad8067602e3e706fad1f6caf3d318a16512e06f4a19f892b696d781506b64');
INSERT INTO `registry_file` VALUES ('modules/system/system.mail.inc', 'b07bc848006f7c5955607de44442e04dac092b5800e5015a86a7c110f19640c3');
INSERT INTO `registry_file` VALUES ('modules/system/system.queue.inc', 'b5284a68d70d5ce4840a1e7f18f5450fbed71e0516f588ec8adeac7010dbb857');
INSERT INTO `registry_file` VALUES ('modules/system/system.tar.inc', '95034047452d379fbe587a822562a25adcc7cf0e72250f14d4f896c0a4e6ce17');
INSERT INTO `registry_file` VALUES ('modules/system/system.test', 'a5724f5cdda557a453ac8111d024aee6266f21876698354515f7211acdb77f8c');
INSERT INTO `registry_file` VALUES ('modules/system/system.updater.inc', '4b4d23058f2af162bbbc886e981ce1b60373aa49a4126ae9d8018748758f57ab');
INSERT INTO `registry_file` VALUES ('modules/taxonomy/taxonomy.module', '906b18ce5dc68c9cd7ad4401203b6d2b616076b62c44949f975f321c0d42c03a');
INSERT INTO `registry_file` VALUES ('modules/taxonomy/taxonomy.test', 'af5703c63b1f7270aa07767b2fb271849e0899cbd1ac7da725df7038ac8735f4');
INSERT INTO `registry_file` VALUES ('modules/user/user.module', '85a360dca642f0a1b802c81996fc2b27a1916f124e98401c4abb69b0568c5070');
INSERT INTO `registry_file` VALUES ('modules/user/user.test', '54d11e323f4b66e532c3124307e04bd61bb581c8edf76e53094104bff4cefdb6');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('3', 'Administrator', '2');
INSERT INTO `role` VALUES ('1', 'anonymous user', '0');
INSERT INTO `role` VALUES ('2', 'authenticated user', '1');
INSERT INTO `role` VALUES ('4', 'Manager', '3');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('1', 'access comments', 'comment');
INSERT INTO `role_permission` VALUES ('1', 'access content', 'node');
INSERT INTO `role_permission` VALUES ('1', 'use text format filtered_html', 'filter');
INSERT INTO `role_permission` VALUES ('2', 'access comments', 'comment');
INSERT INTO `role_permission` VALUES ('2', 'access content', 'node');
INSERT INTO `role_permission` VALUES ('2', 'post comments', 'comment');
INSERT INTO `role_permission` VALUES ('2', 'skip comment approval', 'comment');
INSERT INTO `role_permission` VALUES ('2', 'use text format filtered_html', 'filter');
INSERT INTO `role_permission` VALUES ('3', 'access administration pages', 'system');
INSERT INTO `role_permission` VALUES ('3', 'access comments', 'comment');
INSERT INTO `role_permission` VALUES ('3', 'access content', 'node');
INSERT INTO `role_permission` VALUES ('3', 'access content overview', 'node');
INSERT INTO `role_permission` VALUES ('3', 'access contextual links', 'contextual');
INSERT INTO `role_permission` VALUES ('3', 'access dashboard', 'dashboard');
INSERT INTO `role_permission` VALUES ('3', 'access overlay', 'overlay');
INSERT INTO `role_permission` VALUES ('3', 'access protected Admin', 'Admin');
INSERT INTO `role_permission` VALUES ('3', 'access protected HSS Admin', 'HSSAdmin');
INSERT INTO `role_permission` VALUES ('3', 'access protected HSS Core', 'Core');
INSERT INTO `role_permission` VALUES ('3', 'access site in maintenance mode', 'system');
INSERT INTO `role_permission` VALUES ('3', 'access site reports', 'system');
INSERT INTO `role_permission` VALUES ('3', 'access toolbar', 'toolbar');
INSERT INTO `role_permission` VALUES ('3', 'access user profiles', 'user');
INSERT INTO `role_permission` VALUES ('3', 'administer actions', 'system');
INSERT INTO `role_permission` VALUES ('3', 'administer blocks', 'block');
INSERT INTO `role_permission` VALUES ('3', 'administer comments', 'comment');
INSERT INTO `role_permission` VALUES ('3', 'administer content types', 'node');
INSERT INTO `role_permission` VALUES ('3', 'administer filters', 'filter');
INSERT INTO `role_permission` VALUES ('3', 'administer image styles', 'image');
INSERT INTO `role_permission` VALUES ('3', 'administer menu', 'menu');
INSERT INTO `role_permission` VALUES ('3', 'administer modules', 'system');
INSERT INTO `role_permission` VALUES ('3', 'administer nodes', 'node');
INSERT INTO `role_permission` VALUES ('3', 'administer permissions', 'user');
INSERT INTO `role_permission` VALUES ('3', 'administer search', 'search');
INSERT INTO `role_permission` VALUES ('3', 'administer shortcuts', 'shortcut');
INSERT INTO `role_permission` VALUES ('3', 'administer site configuration', 'system');
INSERT INTO `role_permission` VALUES ('3', 'administer software updates', 'system');
INSERT INTO `role_permission` VALUES ('3', 'administer taxonomy', 'taxonomy');
INSERT INTO `role_permission` VALUES ('3', 'administer themes', 'system');
INSERT INTO `role_permission` VALUES ('3', 'administer url aliases', 'path');
INSERT INTO `role_permission` VALUES ('3', 'administer users', 'user');
INSERT INTO `role_permission` VALUES ('3', 'block IP addresses', 'system');
INSERT INTO `role_permission` VALUES ('3', 'bypass node access', 'node');
INSERT INTO `role_permission` VALUES ('3', 'cancel account', 'user');
INSERT INTO `role_permission` VALUES ('3', 'change own username', 'user');
INSERT INTO `role_permission` VALUES ('3', 'create article content', 'node');
INSERT INTO `role_permission` VALUES ('3', 'create page content', 'node');
INSERT INTO `role_permission` VALUES ('3', 'create url aliases', 'path');
INSERT INTO `role_permission` VALUES ('3', 'customize shortcut links', 'shortcut');
INSERT INTO `role_permission` VALUES ('3', 'delete any article content', 'node');
INSERT INTO `role_permission` VALUES ('3', 'delete any page content', 'node');
INSERT INTO `role_permission` VALUES ('3', 'delete own article content', 'node');
INSERT INTO `role_permission` VALUES ('3', 'delete own page content', 'node');
INSERT INTO `role_permission` VALUES ('3', 'delete revisions', 'node');
INSERT INTO `role_permission` VALUES ('3', 'delete terms in 1', 'taxonomy');
INSERT INTO `role_permission` VALUES ('3', 'edit any article content', 'node');
INSERT INTO `role_permission` VALUES ('3', 'edit any page content', 'node');
INSERT INTO `role_permission` VALUES ('3', 'edit own article content', 'node');
INSERT INTO `role_permission` VALUES ('3', 'edit own comments', 'comment');
INSERT INTO `role_permission` VALUES ('3', 'edit own page content', 'node');
INSERT INTO `role_permission` VALUES ('3', 'edit terms in 1', 'taxonomy');
INSERT INTO `role_permission` VALUES ('3', 'post comments', 'comment');
INSERT INTO `role_permission` VALUES ('3', 'revert revisions', 'node');
INSERT INTO `role_permission` VALUES ('3', 'search content', 'search');
INSERT INTO `role_permission` VALUES ('3', 'select account cancellation method', 'user');
INSERT INTO `role_permission` VALUES ('3', 'skip comment approval', 'comment');
INSERT INTO `role_permission` VALUES ('3', 'switch shortcut sets', 'shortcut');
INSERT INTO `role_permission` VALUES ('3', 'use advanced search', 'search');
INSERT INTO `role_permission` VALUES ('3', 'use text format filtered_html', 'filter');
INSERT INTO `role_permission` VALUES ('3', 'use text format full_html', 'filter');
INSERT INTO `role_permission` VALUES ('3', 'view own unpublished content', 'node');
INSERT INTO `role_permission` VALUES ('3', 'view revisions', 'node');
INSERT INTO `role_permission` VALUES ('3', 'view the administration theme', 'system');

-- ----------------------------
-- Table structure for search_dataset
-- ----------------------------
DROP TABLE IF EXISTS `search_dataset`;
CREATE TABLE `search_dataset` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Search item ID, e.g. node ID for nodes.',
  `type` varchar(16) NOT NULL COMMENT 'Type of item, e.g. node.',
  `data` longtext NOT NULL COMMENT 'List of space-separated words from the item.',
  `reindex` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Set to force node reindexing.',
  PRIMARY KEY (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items that will be searched.';

-- ----------------------------
-- Records of search_dataset
-- ----------------------------

-- ----------------------------
-- Table structure for search_index
-- ----------------------------
DROP TABLE IF EXISTS `search_index`;
CREATE TABLE `search_index` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'The search_total.word that is associated with the search item.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item to which the word belongs.',
  `type` varchar(16) NOT NULL COMMENT 'The search_dataset.type of the searchable item to which the word belongs.',
  `score` float DEFAULT NULL COMMENT 'The numeric score of the word, higher being more important.',
  PRIMARY KEY (`word`,`sid`,`type`),
  KEY `sid_type` (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the search index, associating words, items and...';

-- ----------------------------
-- Records of search_index
-- ----------------------------

-- ----------------------------
-- Table structure for search_node_links
-- ----------------------------
DROP TABLE IF EXISTS `search_node_links`;
CREATE TABLE `search_node_links` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item containing the link to the node.',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT 'The search_dataset.type of the searchable item containing the link to the node.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid that this item links to.',
  `caption` longtext COMMENT 'The text used to link to the node.nid.',
  PRIMARY KEY (`sid`,`type`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items (like nodes) that link to other nodes, used...';

-- ----------------------------
-- Records of search_node_links
-- ----------------------------

-- ----------------------------
-- Table structure for search_total
-- ----------------------------
DROP TABLE IF EXISTS `search_total`;
CREATE TABLE `search_total` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique word in the search index.',
  `count` float DEFAULT NULL COMMENT 'The count of the word in the index using Zipf’s law to equalize the probability distribution.',
  PRIMARY KEY (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search totals for words.';

-- ----------------------------
-- Records of search_total
-- ----------------------------

-- ----------------------------
-- Table structure for semaphore
-- ----------------------------
DROP TABLE IF EXISTS `semaphore`;
CREATE TABLE `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';

-- ----------------------------
-- Records of semaphore
-- ----------------------------

-- ----------------------------
-- Table structure for sequences
-- ----------------------------
DROP TABLE IF EXISTS `sequences`;
CREATE TABLE `sequences` (
  `value` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
  PRIMARY KEY (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';

-- ----------------------------
-- Records of sequences
-- ----------------------------
INSERT INTO `sequences` VALUES ('2');

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `uid` int(10) unsigned NOT NULL COMMENT 'The users.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL DEFAULT '0' COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.',
  PRIMARY KEY (`sid`,`ssid`),
  KEY `timestamp` (`timestamp`),
  KEY `uid` (`uid`),
  KEY `ssid` (`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drupal’s session handlers read and write into the...';

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('0', 'jXEJ3bPTKcfK7tn2SDZYwGQsd-WSIwPD0Kr5_9GGeOQ', '', '127.0.0.1', '1459174757', '0', 0x757365725F73686F707C4F3A383A22737464436C617373223A31383A7B733A373A2273686F705F6964223B733A313A2234223B733A393A2273686F705F6E616D65223B733A393A2253686F70205465656E223B733A393A22757365725F73686F70223B733A393A226E677579656E647579223B733A31333A22757365725F70617373776F7264223B733A35353A222453244461426A597058583569563932362F64654B63746243504F55644A744970346F482E73534D59325A3557576E6A784149466F556B223B733A31303A2273686F705F70686F6E65223B733A31303A2230393133393232393836223B733A31323A2273686F705F61646472657373223B4E3B733A31303A2273686F705F656D61696C223B733A32333A226E677579656E6475797074383640676D61696C2E636F6D223B733A31333A2273686F705F70726F76696E6365223B733A313A2231223B733A31303A2273686F705F61626F7574223B4E3B733A32303A226E756D6265725F6C696D69745F70726F64756374223B733A323A223132223B733A373A2269735F73686F70223B733A313A2230223B733A383A2269735F6C6F67696E223B733A313A2230223B733A31313A2274696D655F616363657373223B733A31303A2231343539313733323134223B733A31313A2273686F705F737461747573223B733A313A2230223B733A31323A2273686F705F63726561746564223B733A31303A2231343538353634303937223B733A31343A2274696D655F73746172745F766970223B4E3B733A31323A2274696D655F656E645F766970223B4E3B733A373A2265787069726573223B693A313435393137383335393B7D);
INSERT INTO `sessions` VALUES ('1', 'Wow2Togf8-C05IYALmAj7uYhrfQNlZlispYKs2HNEDw', '', '::1', '1459438616', '0', '');

-- ----------------------------
-- Table structure for shortcut_set
-- ----------------------------
DROP TABLE IF EXISTS `shortcut_set`;
CREATE TABLE `shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.',
  PRIMARY KEY (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';

-- ----------------------------
-- Records of shortcut_set
-- ----------------------------
INSERT INTO `shortcut_set` VALUES ('shortcut-set-1', 'Default');

-- ----------------------------
-- Table structure for shortcut_set_users
-- ----------------------------
DROP TABLE IF EXISTS `shortcut_set_users`;
CREATE TABLE `shortcut_set_users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid for this set.',
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The shortcut_set.set_name that will be displayed for this user.',
  PRIMARY KEY (`uid`),
  KEY `set_name` (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to shortcut sets.';

-- ----------------------------
-- Records of shortcut_set_users
-- ----------------------------

-- ----------------------------
-- Table structure for system
-- ----------------------------
DROP TABLE IF EXISTS `system`;
CREATE TABLE `system` (
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL DEFAULT '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL DEFAULT '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL DEFAULT '-1' COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.',
  PRIMARY KEY (`filename`),
  KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  KEY `type_name` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of all modules, themes, and theme engines that are...';

-- ----------------------------
-- Records of system
-- ----------------------------
INSERT INTO `system` VALUES ('modules/aggregator/aggregator.module', 'aggregator', 'module', '', '0', '0', '-1', '0', 0x613A31343A7B733A343A226E616D65223B733A31303A2241676772656761746F72223B733A31313A226465736372697074696F6E223B733A35373A22416767726567617465732073796E6469636174656420636F6E74656E7420285253532C205244462C20616E642041746F6D206665656473292E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31353A2261676772656761746F722E74657374223B7D733A393A22636F6E666967757265223B733A34313A2261646D696E2F636F6E6669672F73657276696365732F61676772656761746F722F73657474696E6773223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31343A2261676772656761746F722E637373223B733A33333A226D6F64756C65732F61676772656761746F722F61676772656761746F722E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/aggregator/tests/aggregator_test.module', 'aggregator_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32333A2241676772656761746F72206D6F64756C65207465737473223B733A31313A226465736372697074696F6E223B733A34363A22537570706F7274206D6F64756C6520666F722061676772656761746F722072656C617465642074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/block/block.module', 'block', 'module', '', '1', '0', '7009', '-5', 0x613A31333A7B733A343A226E616D65223B733A353A22426C6F636B223B733A31313A226465736372697074696F6E223B733A3134303A22436F6E74726F6C73207468652076697375616C206275696C64696E6720626C6F636B732061207061676520697320636F6E737472756374656420776974682E20426C6F636B732061726520626F786573206F6620636F6E74656E742072656E646572656420696E746F20616E20617265612C206F7220726567696F6E2C206F6620612077656220706167652E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31303A22626C6F636B2E74657374223B7D733A393A22636F6E666967757265223B733A32313A2261646D696E2F7374727563747572652F626C6F636B223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/block/tests/block_test.module', 'block_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31303A22426C6F636B2074657374223B733A31313A226465736372697074696F6E223B733A32313A2250726F7669646573207465737420626C6F636B732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/blog/blog.module', 'blog', 'module', '', '0', '0', '-1', '0', 0x613A31323A7B733A343A226E616D65223B733A343A22426C6F67223B733A31313A226465736372697074696F6E223B733A32353A22456E61626C6573206D756C74692D7573657220626C6F67732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A393A22626C6F672E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/book/book.module', 'book', 'module', '', '0', '0', '-1', '0', 0x613A31343A7B733A343A226E616D65223B733A343A22426F6F6B223B733A31313A226465736372697074696F6E223B733A36363A22416C6C6F777320757365727320746F2063726561746520616E64206F7267616E697A652072656C6174656420636F6E74656E7420696E20616E206F75746C696E652E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A393A22626F6F6B2E74657374223B7D733A393A22636F6E666967757265223B733A32373A2261646D696E2F636F6E74656E742F626F6F6B2F73657474696E6773223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A383A22626F6F6B2E637373223B733A32313A226D6F64756C65732F626F6F6B2F626F6F6B2E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/color/color.module', 'color', 'module', '', '1', '0', '7001', '0', 0x613A31323A7B733A343A226E616D65223B733A353A22436F6C6F72223B733A31313A226465736372697074696F6E223B733A37303A22416C6C6F77732061646D696E6973747261746F727320746F206368616E67652074686520636F6C6F7220736368656D65206F6620636F6D70617469626C65207468656D65732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31303A22636F6C6F722E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/comment/comment.module', 'comment', 'module', '', '1', '0', '7009', '0', 0x613A31343A7B733A343A226E616D65223B733A373A22436F6D6D656E74223B733A31313A226465736372697074696F6E223B733A35373A22416C6C6F777320757365727320746F20636F6D6D656E74206F6E20616E642064697363757373207075626C697368656420636F6E74656E742E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A343A2274657874223B7D733A353A2266696C6573223B613A323A7B693A303B733A31343A22636F6D6D656E742E6D6F64756C65223B693A313B733A31323A22636F6D6D656E742E74657374223B7D733A393A22636F6E666967757265223B733A32313A2261646D696E2F636F6E74656E742F636F6D6D656E74223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31313A22636F6D6D656E742E637373223B733A32373A226D6F64756C65732F636F6D6D656E742F636F6D6D656E742E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/contact/contact.module', 'contact', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A373A22436F6E74616374223B733A31313A226465736372697074696F6E223B733A36313A22456E61626C65732074686520757365206F6620626F746820706572736F6E616C20616E6420736974652D7769646520636F6E7461637420666F726D732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31323A22636F6E746163742E74657374223B7D733A393A22636F6E666967757265223B733A32333A2261646D696E2F7374727563747572652F636F6E74616374223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/contextual/contextual.module', 'contextual', 'module', '', '1', '0', '0', '0', 0x613A31323A7B733A343A226E616D65223B733A31363A22436F6E7465787475616C206C696E6B73223B733A31313A226465736372697074696F6E223B733A37353A2250726F766964657320636F6E7465787475616C206C696E6B7320746F20706572666F726D20616374696F6E732072656C6174656420746F20656C656D656E7473206F6E206120706167652E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31353A22636F6E7465787475616C2E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/dashboard/dashboard.module', 'dashboard', 'module', '', '1', '0', '0', '0', 0x613A31333A7B733A343A226E616D65223B733A393A2244617368626F617264223B733A31313A226465736372697074696F6E223B733A3133363A2250726F766964657320612064617368626F617264207061676520696E207468652061646D696E69737472617469766520696E7465726661636520666F72206F7267616E697A696E672061646D696E697374726174697665207461736B7320616E6420747261636B696E6720696E666F726D6174696F6E2077697468696E20796F757220736974652E223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A353A2266696C6573223B613A313A7B693A303B733A31343A2264617368626F6172642E74657374223B7D733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A353A22626C6F636B223B7D733A393A22636F6E666967757265223B733A32353A2261646D696E2F64617368626F6172642F637573746F6D697A65223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/dblog/dblog.module', 'dblog', 'module', '', '1', '1', '7002', '0', 0x613A31323A7B733A343A226E616D65223B733A31363A224461746162617365206C6F6767696E67223B733A31313A226465736372697074696F6E223B733A34373A224C6F677320616E64207265636F7264732073797374656D206576656E747320746F207468652064617461626173652E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31303A2264626C6F672E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/field/field.module', 'field', 'module', '', '1', '0', '7003', '0', 0x613A31343A7B733A343A226E616D65223B733A353A224669656C64223B733A31313A226465736372697074696F6E223B733A35373A224669656C642041504920746F20616464206669656C647320746F20656E746974696573206C696B65206E6F64657320616E642075736572732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A343A7B693A303B733A31323A226669656C642E6D6F64756C65223B693A313B733A31363A226669656C642E6174746163682E696E63223B693A323B733A32303A226669656C642E696E666F2E636C6173732E696E63223B693A333B733A31363A2274657374732F6669656C642E74657374223B7D733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A31373A226669656C645F73716C5F73746F72616765223B7D733A383A227265717569726564223B623A313B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31353A227468656D652F6669656C642E637373223B733A32393A226D6F64756C65732F6669656C642F7468656D652F6669656C642E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/field/modules/field_sql_storage/field_sql_storage.module', 'field_sql_storage', 'module', '', '1', '0', '7002', '0', 0x613A31333A7B733A343A226E616D65223B733A31373A224669656C642053514C2073746F72616765223B733A31313A226465736372697074696F6E223B733A33373A2253746F726573206669656C64206461746120696E20616E2053514C2064617461626173652E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A353A226669656C64223B7D733A353A2266696C6573223B613A313A7B693A303B733A32323A226669656C645F73716C5F73746F726167652E74657374223B7D733A383A227265717569726564223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/field/modules/list/list.module', 'list', 'module', '', '1', '0', '7002', '0', 0x613A31323A7B733A343A226E616D65223B733A343A224C697374223B733A31313A226465736372697074696F6E223B733A36393A22446566696E6573206C697374206669656C642074797065732E205573652077697468204F7074696F6E7320746F206372656174652073656C656374696F6E206C697374732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A323A7B693A303B733A353A226669656C64223B693A313B733A373A226F7074696F6E73223B7D733A353A2266696C6573223B613A313A7B693A303B733A31353A2274657374732F6C6973742E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/field/modules/list/tests/list_test.module', 'list_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A393A224C6973742074657374223B733A31313A226465736372697074696F6E223B733A34313A22537570706F7274206D6F64756C6520666F7220746865204C697374206D6F64756C652074657374732E223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/field/modules/number/number.module', 'number', 'module', '', '1', '0', '0', '0', 0x613A31323A7B733A343A226E616D65223B733A363A224E756D626572223B733A31313A226465736372697074696F6E223B733A32383A22446566696E6573206E756D65726963206669656C642074797065732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A353A226669656C64223B7D733A353A2266696C6573223B613A313A7B693A303B733A31313A226E756D6265722E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/field/modules/options/options.module', 'options', 'module', '', '1', '0', '0', '0', 0x613A31323A7B733A343A226E616D65223B733A373A224F7074696F6E73223B733A31313A226465736372697074696F6E223B733A38323A22446566696E65732073656C656374696F6E2C20636865636B20626F7820616E6420726164696F20627574746F6E207769646765747320666F72207465787420616E64206E756D65726963206669656C64732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A353A226669656C64223B7D733A353A2266696C6573223B613A313A7B693A303B733A31323A226F7074696F6E732E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/field/modules/text/text.module', 'text', 'module', '', '1', '0', '7000', '0', 0x613A31343A7B733A343A226E616D65223B733A343A2254657874223B733A31313A226465736372697074696F6E223B733A33323A22446566696E65732073696D706C652074657874206669656C642074797065732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A353A226669656C64223B7D733A353A2266696C6573223B613A313A7B693A303B733A393A22746578742E74657374223B7D733A383A227265717569726564223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B733A31313A226578706C616E6174696F6E223B733A38363A224669656C64207479706528732920696E20757365202D20736565203C6120687265663D222F7369657574686967696172652F61646D696E2F7265706F7274732F6669656C6473223E4669656C64206C6973743C2F613E223B7D);
INSERT INTO `system` VALUES ('modules/field/tests/field_test.module', 'field_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31343A224669656C64204150492054657374223B733A31313A226465736372697074696F6E223B733A33393A22537570706F7274206D6F64756C6520666F7220746865204669656C64204150492074657374732E223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A373A2254657374696E67223B733A353A2266696C6573223B613A313A7B693A303B733A32313A226669656C645F746573742E656E746974792E696E63223B7D733A373A2276657273696F6E223B733A343A22372E3433223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/field_ui/field_ui.module', 'field_ui', 'module', '', '1', '0', '0', '0', 0x613A31323A7B733A343A226E616D65223B733A383A224669656C64205549223B733A31313A226465736372697074696F6E223B733A33333A225573657220696E7465726661636520666F7220746865204669656C64204150492E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A353A226669656C64223B7D733A353A2266696C6573223B613A313A7B693A303B733A31333A226669656C645F75692E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331343B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/file/file.module', 'file', 'module', '', '1', '0', '0', '0', 0x613A31323A7B733A343A226E616D65223B733A343A2246696C65223B733A31313A226465736372697074696F6E223B733A32363A22446566696E657320612066696C65206669656C6420747970652E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A353A226669656C64223B7D733A353A2266696C6573223B613A313A7B693A303B733A31353A2274657374732F66696C652E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/file/tests/file_module_test.module', 'file_module_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A393A2246696C652074657374223B733A31313A226465736372697074696F6E223B733A35333A2250726F766964657320686F6F6B7320666F722074657374696E672046696C65206D6F64756C652066756E6374696F6E616C6974792E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/filter/filter.module', 'filter', 'module', '', '1', '0', '7010', '0', 0x613A31343A7B733A343A226E616D65223B733A363A2246696C746572223B733A31313A226465736372697074696F6E223B733A34333A2246696C7465727320636F6E74656E7420696E207072657061726174696F6E20666F7220646973706C61792E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31313A2266696C7465722E74657374223B7D733A383A227265717569726564223B623A313B733A393A22636F6E666967757265223B733A32383A2261646D696E2F636F6E6669672F636F6E74656E742F666F726D617473223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/forum/forum.module', 'forum', 'module', '', '0', '0', '-1', '0', 0x613A31343A7B733A343A226E616D65223B733A353A22466F72756D223B733A31313A226465736372697074696F6E223B733A32373A2250726F76696465732064697363757373696F6E20666F72756D732E223B733A31323A22646570656E64656E63696573223B613A323A7B693A303B733A383A227461786F6E6F6D79223B693A313B733A373A22636F6D6D656E74223B7D733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31303A22666F72756D2E74657374223B7D733A393A22636F6E666967757265223B733A32313A2261646D696E2F7374727563747572652F666F72756D223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A393A22666F72756D2E637373223B733A32333A226D6F64756C65732F666F72756D2F666F72756D2E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/help/help.module', 'help', 'module', '', '1', '0', '0', '0', 0x613A31323A7B733A343A226E616D65223B733A343A2248656C70223B733A31313A226465736372697074696F6E223B733A33353A224D616E616765732074686520646973706C6179206F66206F6E6C696E652068656C702E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A393A2268656C702E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/image/image.module', 'image', 'module', '', '1', '0', '7005', '0', 0x613A31353A7B733A343A226E616D65223B733A353A22496D616765223B733A31313A226465736372697074696F6E223B733A33343A2250726F766964657320696D616765206D616E6970756C6174696F6E20746F6F6C732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A343A2266696C65223B7D733A353A2266696C6573223B613A313A7B693A303B733A31303A22696D6167652E74657374223B7D733A393A22636F6E666967757265223B733A33313A2261646D696E2F636F6E6669672F6D656469612F696D6167652D7374796C6573223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B733A383A227265717569726564223B623A313B733A31313A226578706C616E6174696F6E223B733A38363A224669656C64207479706528732920696E20757365202D20736565203C6120687265663D222F7369657574686967696172652F61646D696E2F7265706F7274732F6669656C6473223E4669656C64206C6973743C2F613E223B7D);
INSERT INTO `system` VALUES ('modules/image/tests/image_module_test.module', 'image_module_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31303A22496D6167652074657374223B733A31313A226465736372697074696F6E223B733A36393A2250726F766964657320686F6F6B20696D706C656D656E746174696F6E7320666F722074657374696E6720496D616765206D6F64756C652066756E6374696F6E616C6974792E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A32343A22696D6167655F6D6F64756C655F746573742E6D6F64756C65223B7D733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/locale/locale.module', 'locale', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A363A224C6F63616C65223B733A31313A226465736372697074696F6E223B733A3131393A2241646473206C616E67756167652068616E646C696E672066756E6374696F6E616C69747920616E6420656E61626C657320746865207472616E736C6174696F6E206F6620746865207573657220696E7465726661636520746F206C616E677561676573206F74686572207468616E20456E676C6973682E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31313A226C6F63616C652E74657374223B7D733A393A22636F6E666967757265223B733A33303A2261646D696E2F636F6E6669672F726567696F6E616C2F6C616E6775616765223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/locale/tests/locale_test.module', 'locale_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31313A224C6F63616C652054657374223B733A31313A226465736372697074696F6E223B733A34323A22537570706F7274206D6F64756C6520666F7220746865206C6F63616C65206C617965722074657374732E223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/menu/menu.module', 'menu', 'module', '', '1', '0', '7003', '0', 0x613A31333A7B733A343A226E616D65223B733A343A224D656E75223B733A31313A226465736372697074696F6E223B733A36303A22416C6C6F77732061646D696E6973747261746F727320746F20637573746F6D697A65207468652073697465206E617669676174696F6E206D656E752E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A393A226D656E752E74657374223B7D733A393A22636F6E666967757265223B733A32303A2261646D696E2F7374727563747572652F6D656E75223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/node/node.module', 'node', 'module', '', '1', '0', '7015', '0', 0x613A31353A7B733A343A226E616D65223B733A343A224E6F6465223B733A31313A226465736372697074696F6E223B733A36363A22416C6C6F777320636F6E74656E7420746F206265207375626D697474656420746F20746865207369746520616E6420646973706C61796564206F6E2070616765732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A323A7B693A303B733A31313A226E6F64652E6D6F64756C65223B693A313B733A393A226E6F64652E74657374223B7D733A383A227265717569726564223B623A313B733A393A22636F6E666967757265223B733A32313A2261646D696E2F7374727563747572652F7479706573223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A383A226E6F64652E637373223B733A32313A226D6F64756C65732F6E6F64652F6E6F64652E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/node/tests/node_access_test.module', 'node_access_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32343A224E6F6465206D6F64756C6520616363657373207465737473223B733A31313A226465736372697074696F6E223B733A34333A22537570706F7274206D6F64756C6520666F72206E6F6465207065726D697373696F6E2074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/node/tests/node_test.module', 'node_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31373A224E6F6465206D6F64756C65207465737473223B733A31313A226465736372697074696F6E223B733A34303A22537570706F7274206D6F64756C6520666F72206E6F64652072656C617465642074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/node/tests/node_test_exception.module', 'node_test_exception', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32373A224E6F6465206D6F64756C6520657863657074696F6E207465737473223B733A31313A226465736372697074696F6E223B733A35303A22537570706F7274206D6F64756C6520666F72206E6F64652072656C6174656420657863657074696F6E2074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/openid/openid.module', 'openid', 'module', '', '0', '0', '-1', '0', 0x613A31323A7B733A343A226E616D65223B733A363A224F70656E4944223B733A31313A226465736372697074696F6E223B733A34383A22416C6C6F777320757365727320746F206C6F6720696E746F20796F75722073697465207573696E67204F70656E49442E223B733A373A2276657273696F6E223B733A343A22372E3433223B733A373A227061636B616765223B733A343A22436F7265223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31313A226F70656E69642E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/openid/tests/openid_test.module', 'openid_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32313A224F70656E49442064756D6D792070726F7669646572223B733A31313A226465736372697074696F6E223B733A33333A224F70656E49442070726F7669646572207573656420666F722074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A363A226F70656E6964223B7D733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/overlay/overlay.module', 'overlay', 'module', '', '0', '0', '0', '0', 0x613A31323A7B733A343A226E616D65223B733A373A224F7665726C6179223B733A31313A226465736372697074696F6E223B733A35393A22446973706C617973207468652044727570616C2061646D696E697374726174696F6E20696E7465726661636520696E20616E206F7665726C61792E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/path/path.module', 'path', 'module', '', '1', '0', '0', '0', 0x613A31333A7B733A343A226E616D65223B733A343A2250617468223B733A31313A226465736372697074696F6E223B733A32383A22416C6C6F777320757365727320746F2072656E616D652055524C732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A393A22706174682E74657374223B7D733A393A22636F6E666967757265223B733A32343A2261646D696E2F636F6E6669672F7365617263682F70617468223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/php/php.module', 'php', 'module', '', '0', '0', '-1', '0', 0x613A31323A7B733A343A226E616D65223B733A31303A225048502066696C746572223B733A31313A226465736372697074696F6E223B733A35303A22416C6C6F777320656D6265646465642050485020636F64652F736E69707065747320746F206265206576616C75617465642E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A383A227068702E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/poll/poll.module', 'poll', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A343A22506F6C6C223B733A31313A226465736372697074696F6E223B733A39353A22416C6C6F777320796F7572207369746520746F206361707475726520766F746573206F6E20646966666572656E7420746F7069637320696E2074686520666F726D206F66206D756C7469706C652063686F696365207175657374696F6E732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A393A22706F6C6C2E74657374223B7D733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A383A22706F6C6C2E637373223B733A32313A226D6F64756C65732F706F6C6C2F706F6C6C2E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/profile/profile.module', 'profile', 'module', '', '0', '0', '-1', '0', 0x613A31343A7B733A343A226E616D65223B733A373A2250726F66696C65223B733A31313A226465736372697074696F6E223B733A33363A22537570706F72747320636F6E666967757261626C6520757365722070726F66696C65732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31323A2270726F66696C652E74657374223B7D733A393A22636F6E666967757265223B733A32373A2261646D696E2F636F6E6669672F70656F706C652F70726F66696C65223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/rdf/rdf.module', 'rdf', 'module', '', '1', '0', '0', '0', 0x613A31323A7B733A343A226E616D65223B733A333A22524446223B733A31313A226465736372697074696F6E223B733A3134383A22456E72696368657320796F757220636F6E74656E742077697468206D6574616461746120746F206C6574206F74686572206170706C69636174696F6E732028652E672E2073656172636820656E67696E65732C2061676772656761746F7273292062657474657220756E6465727374616E64206974732072656C6174696F6E736869707320616E6420617474726962757465732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A383A227264662E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/rdf/tests/rdf_test.module', 'rdf_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31363A22524446206D6F64756C65207465737473223B733A31313A226465736372697074696F6E223B733A33383A22537570706F7274206D6F64756C6520666F7220524446206D6F64756C652074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/search/search.module', 'search', 'module', '', '1', '0', '7000', '0', 0x613A31343A7B733A343A226E616D65223B733A363A22536561726368223B733A31313A226465736372697074696F6E223B733A33363A22456E61626C657320736974652D77696465206B6579776F726420736561726368696E672E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A323A7B693A303B733A31393A227365617263682E657874656E6465722E696E63223B693A313B733A31313A227365617263682E74657374223B7D733A393A22636F6E666967757265223B733A32383A2261646D696E2F636F6E6669672F7365617263682F73657474696E6773223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31303A227365617263682E637373223B733A32353A226D6F64756C65732F7365617263682F7365617263682E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/search/tests/search_embedded_form.module', 'search_embedded_form', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32303A2253656172636820656D62656464656420666F726D223B733A31313A226465736372697074696F6E223B733A35393A22537570706F7274206D6F64756C6520666F7220736561726368206D6F64756C652074657374696E67206F6620656D62656464656420666F726D732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/search/tests/search_extra_type.module', 'search_extra_type', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31363A2254657374207365617263682074797065223B733A31313A226465736372697074696F6E223B733A34313A22537570706F7274206D6F64756C6520666F7220736561726368206D6F64756C652074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/search/tests/search_node_tags.module', 'search_node_tags', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32313A225465737420736561726368206E6F64652074616773223B733A31313A226465736372697074696F6E223B733A34343A22537570706F7274206D6F64756C6520666F72204E6F64652073656172636820746167732074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/shortcut/shortcut.module', 'shortcut', 'module', '', '1', '0', '0', '0', 0x613A31333A7B733A343A226E616D65223B733A383A2253686F7274637574223B733A31313A226465736372697074696F6E223B733A36303A22416C6C6F777320757365727320746F206D616E61676520637573746F6D697A61626C65206C69737473206F662073686F7274637574206C696E6B732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31333A2273686F72746375742E74657374223B7D733A393A22636F6E666967757265223B733A33363A2261646D696E2F636F6E6669672F757365722D696E746572666163652F73686F7274637574223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/simpletest.module', 'simpletest', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A373A2254657374696E67223B733A31313A226465736372697074696F6E223B733A35333A2250726F76696465732061206672616D65776F726B20666F7220756E697420616E642066756E6374696F6E616C2074657374696E672E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A35303A7B693A303B733A31353A2273696D706C65746573742E74657374223B693A313B733A32343A2264727570616C5F7765625F746573745F636173652E706870223B693A323B733A31383A2274657374732F616374696F6E732E74657374223B693A333B733A31353A2274657374732F616A61782E74657374223B693A343B733A31363A2274657374732F62617463682E74657374223B693A353B733A31353A2274657374732F626F6F742E74657374223B693A363B733A32303A2274657374732F626F6F7473747261702E74657374223B693A373B733A31363A2274657374732F63616368652E74657374223B693A383B733A31373A2274657374732F636F6D6D6F6E2E74657374223B693A393B733A32343A2274657374732F64617461626173655F746573742E74657374223B693A31303B733A32323A2274657374732F656E746974795F637275642E74657374223B693A31313B733A33323A2274657374732F656E746974795F637275645F686F6F6B5F746573742E74657374223B693A31323B733A32333A2274657374732F656E746974795F71756572792E74657374223B693A31333B733A31363A2274657374732F6572726F722E74657374223B693A31343B733A31353A2274657374732F66696C652E74657374223B693A31353B733A32333A2274657374732F66696C657472616E736665722E74657374223B693A31363B733A31353A2274657374732F666F726D2E74657374223B693A31373B733A31363A2274657374732F67726170682E74657374223B693A31383B733A31363A2274657374732F696D6167652E74657374223B693A31393B733A31353A2274657374732F6C6F636B2E74657374223B693A32303B733A31353A2274657374732F6D61696C2E74657374223B693A32313B733A31353A2274657374732F6D656E752E74657374223B693A32323B733A31373A2274657374732F6D6F64756C652E74657374223B693A32333B733A31363A2274657374732F70616765722E74657374223B693A32343B733A31393A2274657374732F70617373776F72642E74657374223B693A32353B733A31353A2274657374732F706174682E74657374223B693A32363B733A31393A2274657374732F72656769737472792E74657374223B693A32373B733A31373A2274657374732F736368656D612E74657374223B693A32383B733A31383A2274657374732F73657373696F6E2E74657374223B693A32393B733A32303A2274657374732F7461626C65736F72742E74657374223B693A33303B733A31363A2274657374732F7468656D652E74657374223B693A33313B733A31383A2274657374732F756E69636F64652E74657374223B693A33323B733A31373A2274657374732F7570646174652E74657374223B693A33333B733A31373A2274657374732F786D6C7270632E74657374223B693A33343B733A32363A2274657374732F757067726164652F757067726164652E74657374223B693A33353B733A33343A2274657374732F757067726164652F757067726164652E636F6D6D656E742E74657374223B693A33363B733A33333A2274657374732F757067726164652F757067726164652E66696C7465722E74657374223B693A33373B733A33323A2274657374732F757067726164652F757067726164652E666F72756D2E74657374223B693A33383B733A33333A2274657374732F757067726164652F757067726164652E6C6F63616C652E74657374223B693A33393B733A33313A2274657374732F757067726164652F757067726164652E6D656E752E74657374223B693A34303B733A33313A2274657374732F757067726164652F757067726164652E6E6F64652E74657374223B693A34313B733A33353A2274657374732F757067726164652F757067726164652E7461786F6E6F6D792E74657374223B693A34323B733A33343A2274657374732F757067726164652F757067726164652E747269676765722E74657374223B693A34333B733A33393A2274657374732F757067726164652F757067726164652E7472616E736C617461626C652E74657374223B693A34343B733A33333A2274657374732F757067726164652F757067726164652E75706C6F61642E74657374223B693A34353B733A33313A2274657374732F757067726164652F757067726164652E757365722E74657374223B693A34363B733A33363A2274657374732F757067726164652F7570646174652E61676772656761746F722E74657374223B693A34373B733A33333A2274657374732F757067726164652F7570646174652E747269676765722E74657374223B693A34383B733A33313A2274657374732F757067726164652F7570646174652E6669656C642E74657374223B693A34393B733A33303A2274657374732F757067726164652F7570646174652E757365722E74657374223B7D733A393A22636F6E666967757265223B733A34313A2261646D696E2F636F6E6669672F646576656C6F706D656E742F74657374696E672F73657474696E6773223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/actions_loop_test.module', 'actions_loop_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31373A22416374696F6E73206C6F6F702074657374223B733A31313A226465736372697074696F6E223B733A33393A22537570706F7274206D6F64756C6520666F7220616374696F6E206C6F6F702074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/ajax_forms_test.module', 'ajax_forms_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32363A22414A415820666F726D2074657374206D6F636B206D6F64756C65223B733A31313A226465736372697074696F6E223B733A32353A225465737420666F7220414A415820666F726D2063616C6C732E223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/ajax_test.module', 'ajax_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A393A22414A41582054657374223B733A31313A226465736372697074696F6E223B733A34303A22537570706F7274206D6F64756C6520666F7220414A4158206672616D65776F726B2074657374732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/batch_test.module', 'batch_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31343A224261746368204150492074657374223B733A31313A226465736372697074696F6E223B733A33353A22537570706F7274206D6F64756C6520666F72204261746368204150492074657374732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/boot_test_1.module', 'boot_test_1', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32313A224561726C7920626F6F747374726170207465737473223B733A31313A226465736372697074696F6E223B733A33393A224120737570706F7274206D6F64756C6520666F7220686F6F6B5F626F6F742074657374696E672E223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/boot_test_2.module', 'boot_test_2', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32313A224561726C7920626F6F747374726170207465737473223B733A31313A226465736372697074696F6E223B733A34343A224120737570706F7274206D6F64756C6520666F7220686F6F6B5F626F6F7420686F6F6B2074657374696E672E223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/common_test.module', 'common_test', 'module', '', '0', '0', '-1', '0', 0x613A31343A7B733A343A226E616D65223B733A31313A22436F6D6D6F6E2054657374223B733A31313A226465736372697074696F6E223B733A33323A22537570706F7274206D6F64756C6520666F7220436F6D6D6F6E2074657374732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A313A7B733A31353A22636F6D6D6F6E5F746573742E637373223B733A34303A226D6F64756C65732F73696D706C65746573742F74657374732F636F6D6D6F6E5F746573742E637373223B7D733A353A227072696E74223B613A313A7B733A32313A22636F6D6D6F6E5F746573742E7072696E742E637373223B733A34363A226D6F64756C65732F73696D706C65746573742F74657374732F636F6D6D6F6E5F746573742E7072696E742E637373223B7D7D733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/common_test_cron_helper.module', 'common_test_cron_helper', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32333A22436F6D6D6F6E20546573742043726F6E2048656C706572223B733A31313A226465736372697074696F6E223B733A35363A2248656C706572206D6F64756C6520666F722043726F6E52756E54657374436173653A3A7465737443726F6E457863657074696F6E7328292E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/database_test.module', 'database_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31333A2244617461626173652054657374223B733A31313A226465736372697074696F6E223B733A34303A22537570706F7274206D6F64756C6520666F72204461746162617365206C617965722074657374732E223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/drupal_autoload_test/drupal_autoload_test.module', 'drupal_autoload_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32353A2244727570616C20636F64652072656769737472792074657374223B733A31313A226465736372697074696F6E223B733A34353A22537570706F7274206D6F64756C6520666F722074657374696E672074686520636F64652072656769737472792E223B733A353A2266696C6573223B613A323A7B693A303B733A33343A2264727570616C5F6175746F6C6F61645F746573745F696E746572666163652E696E63223B693A313B733A33303A2264727570616C5F6175746F6C6F61645F746573745F636C6173732E696E63223B7D733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/drupal_system_listing_compatible_test/drupal_system_listing_compatible_test.module', 'drupal_system_listing_compatible_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A33373A2244727570616C2073797374656D206C697374696E6720636F6D70617469626C652074657374223B733A31313A226465736372697074696F6E223B733A36323A22537570706F7274206D6F64756C6520666F722074657374696E67207468652064727570616C5F73797374656D5F6C697374696E672066756E6374696F6E2E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/drupal_system_listing_incompatible_test/drupal_system_listing_incompatible_test.module', 'drupal_system_listing_incompatible_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A33393A2244727570616C2073797374656D206C697374696E6720696E636F6D70617469626C652074657374223B733A31313A226465736372697074696F6E223B733A36323A22537570706F7274206D6F64756C6520666F722074657374696E67207468652064727570616C5F73797374656D5F6C697374696E672066756E6374696F6E2E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/entity_cache_test.module', 'entity_cache_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31373A22456E746974792063616368652074657374223B733A31313A226465736372697074696F6E223B733A34303A22537570706F7274206D6F64756C6520666F722074657374696E6720656E746974792063616368652E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A32383A22656E746974795F63616368655F746573745F646570656E64656E6379223B7D733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/entity_cache_test_dependency.module', 'entity_cache_test_dependency', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32383A22456E74697479206361636865207465737420646570656E64656E6379223B733A31313A226465736372697074696F6E223B733A35313A22537570706F727420646570656E64656E6379206D6F64756C6520666F722074657374696E6720656E746974792063616368652E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/entity_crud_hook_test.module', 'entity_crud_hook_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32323A22456E74697479204352554420486F6F6B732054657374223B733A31313A226465736372697074696F6E223B733A33353A22537570706F7274206D6F64756C6520666F72204352554420686F6F6B2074657374732E223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/entity_query_access_test.module', 'entity_query_access_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32343A22456E74697479207175657279206163636573732074657374223B733A31313A226465736372697074696F6E223B733A34393A22537570706F7274206D6F64756C6520666F7220636865636B696E6720656E7469747920717565727920726573756C74732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/error_test.module', 'error_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31303A224572726F722074657374223B733A31313A226465736372697074696F6E223B733A34373A22537570706F7274206D6F64756C6520666F72206572726F7220616E6420657863657074696F6E2074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/file_test.module', 'file_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A393A2246696C652074657374223B733A31313A226465736372697074696F6E223B733A33393A22537570706F7274206D6F64756C6520666F722066696C652068616E646C696E672074657374732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31363A2266696C655F746573742E6D6F64756C65223B7D733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/filter_test.module', 'filter_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31383A2246696C7465722074657374206D6F64756C65223B733A31313A226465736372697074696F6E223B733A33333A2254657374732066696C74657220686F6F6B7320616E642066756E6374696F6E732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/form_test.module', 'form_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31323A22466F726D4150492054657374223B733A31313A226465736372697074696F6E223B733A33343A22537570706F7274206D6F64756C6520666F7220466F726D204150492074657374732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/image_test.module', 'image_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31303A22496D6167652074657374223B733A31313A226465736372697074696F6E223B733A33393A22537570706F7274206D6F64756C6520666F7220696D61676520746F6F6C6B69742074657374732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/menu_test.module', 'menu_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31353A22486F6F6B206D656E75207465737473223B733A31313A226465736372697074696F6E223B733A33373A22537570706F7274206D6F64756C6520666F72206D656E7520686F6F6B2074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/module_test.module', 'module_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31313A224D6F64756C652074657374223B733A31313A226465736372697074696F6E223B733A34313A22537570706F7274206D6F64756C6520666F72206D6F64756C652073797374656D2074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/path_test.module', 'path_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31353A22486F6F6B2070617468207465737473223B733A31313A226465736372697074696F6E223B733A33373A22537570706F7274206D6F64756C6520666F72207061746820686F6F6B2074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/psr_0_test/psr_0_test.module', 'psr_0_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31363A225053522D302054657374206361736573223B733A31313A226465736372697074696F6E223B733A34343A225465737420636C617373657320746F20626520646973636F76657265642062792073696D706C65746573742E223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/psr_4_test/psr_4_test.module', 'psr_4_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31363A225053522D342054657374206361736573223B733A31313A226465736372697074696F6E223B733A34343A225465737420636C617373657320746F20626520646973636F76657265642062792073696D706C65746573742E223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/requirements1_test.module', 'requirements1_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31393A22526571756972656D656E747320312054657374223B733A31313A226465736372697074696F6E223B733A38303A22546573747320746861742061206D6F64756C65206973206E6F7420696E7374616C6C6564207768656E206974206661696C7320686F6F6B5F726571756972656D656E74732827696E7374616C6C27292E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/requirements2_test.module', 'requirements2_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31393A22526571756972656D656E747320322054657374223B733A31313A226465736372697074696F6E223B733A39383A22546573747320746861742061206D6F64756C65206973206E6F7420696E7374616C6C6564207768656E20746865206F6E6520697420646570656E6473206F6E206661696C7320686F6F6B5F726571756972656D656E74732827696E7374616C6C292E223B733A31323A22646570656E64656E63696573223B613A323A7B693A303B733A31383A22726571756972656D656E7473315F74657374223B693A313B733A373A22636F6D6D656E74223B7D733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/session_test.module', 'session_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31323A2253657373696F6E2074657374223B733A31313A226465736372697074696F6E223B733A34303A22537570706F7274206D6F64756C6520666F722073657373696F6E20646174612074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_dependencies_test.module', 'system_dependencies_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32323A2253797374656D20646570656E64656E63792074657374223B733A31313A226465736372697074696F6E223B733A34373A22537570706F7274206D6F64756C6520666F722074657374696E672073797374656D20646570656E64656E636965732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A31393A225F6D697373696E675F646570656E64656E6379223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_incompatible_core_version_dependencies_test.module', 'system_incompatible_core_version_dependencies_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A35303A2253797374656D20696E636F6D70617469626C6520636F72652076657273696F6E20646570656E64656E636965732074657374223B733A31313A226465736372697074696F6E223B733A34373A22537570706F7274206D6F64756C6520666F722074657374696E672073797374656D20646570656E64656E636965732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A33373A2273797374656D5F696E636F6D70617469626C655F636F72655F76657273696F6E5F74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_incompatible_core_version_test.module', 'system_incompatible_core_version_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A33373A2253797374656D20696E636F6D70617469626C6520636F72652076657273696F6E2074657374223B733A31313A226465736372697074696F6E223B733A34373A22537570706F7274206D6F64756C6520666F722074657374696E672073797374656D20646570656E64656E636965732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22352E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_incompatible_module_version_dependencies_test.module', 'system_incompatible_module_version_dependencies_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A35323A2253797374656D20696E636F6D70617469626C65206D6F64756C652076657273696F6E20646570656E64656E636965732074657374223B733A31313A226465736372697074696F6E223B733A34373A22537570706F7274206D6F64756C6520666F722074657374696E672073797374656D20646570656E64656E636965732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A34363A2273797374656D5F696E636F6D70617469626C655F6D6F64756C655F76657273696F6E5F7465737420283E322E3029223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_incompatible_module_version_test.module', 'system_incompatible_module_version_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A33393A2253797374656D20696E636F6D70617469626C65206D6F64756C652076657273696F6E2074657374223B733A31313A226465736372697074696F6E223B733A34373A22537570706F7274206D6F64756C6520666F722074657374696E672073797374656D20646570656E64656E636965732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_project_namespace_test.module', 'system_project_namespace_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32393A2253797374656D2070726F6A656374206E616D6573706163652074657374223B733A31313A226465736372697074696F6E223B733A35383A22537570706F7274206D6F64756C6520666F722074657374696E672070726F6A656374206E616D65737061636520646570656E64656E636965732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A31333A2264727570616C3A66696C746572223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_test.module', 'system_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31313A2253797374656D2074657374223B733A31313A226465736372697074696F6E223B733A33343A22537570706F7274206D6F64756C6520666F722073797374656D2074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31383A2273797374656D5F746573742E6D6F64756C65223B7D733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/taxonomy_test.module', 'taxonomy_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32303A225461786F6E6F6D792074657374206D6F64756C65223B733A31313A226465736372697074696F6E223B733A34353A222254657374732066756E6374696F6E7320616E6420686F6F6B73206E6F74207573656420696E20636F7265222E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A383A227461786F6E6F6D79223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/theme_test.module', 'theme_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31303A225468656D652074657374223B733A31313A226465736372697074696F6E223B733A34303A22537570706F7274206D6F64756C6520666F72207468656D652073797374656D2074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/update_script_test.module', 'update_script_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31383A22557064617465207363726970742074657374223B733A31313A226465736372697074696F6E223B733A34313A22537570706F7274206D6F64756C6520666F7220757064617465207363726970742074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/update_test_1.module', 'update_test_1', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31313A225570646174652074657374223B733A31313A226465736372697074696F6E223B733A33343A22537570706F7274206D6F64756C6520666F72207570646174652074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/update_test_2.module', 'update_test_2', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31313A225570646174652074657374223B733A31313A226465736372697074696F6E223B733A33343A22537570706F7274206D6F64756C6520666F72207570646174652074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/update_test_3.module', 'update_test_3', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31313A225570646174652074657374223B733A31313A226465736372697074696F6E223B733A33343A22537570706F7274206D6F64756C6520666F72207570646174652074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/url_alter_test.module', 'url_alter_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31353A2255726C5F616C746572207465737473223B733A31313A226465736372697074696F6E223B733A34353A224120737570706F7274206D6F64756C657320666F722075726C5F616C74657220686F6F6B2074657374696E672E223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/simpletest/tests/xmlrpc_test.module', 'xmlrpc_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31323A22584D4C2D5250432054657374223B733A31313A226465736372697074696F6E223B733A37353A22537570706F7274206D6F64756C6520666F7220584D4C2D525043207465737473206163636F7264696E6720746F207468652076616C696461746F72312073706563696669636174696F6E2E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/statistics/statistics.module', 'statistics', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31303A2253746174697374696373223B733A31313A226465736372697074696F6E223B733A33373A224C6F677320616363657373207374617469737469637320666F7220796F757220736974652E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31353A22737461746973746963732E74657374223B7D733A393A22636F6E666967757265223B733A33303A2261646D696E2F636F6E6669672F73797374656D2F73746174697374696373223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/syslog/syslog.module', 'syslog', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A363A225379736C6F67223B733A31313A226465736372697074696F6E223B733A34313A224C6F677320616E64207265636F7264732073797374656D206576656E747320746F207379736C6F672E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31313A227379736C6F672E74657374223B7D733A393A22636F6E666967757265223B733A33323A2261646D696E2F636F6E6669672F646576656C6F706D656E742F6C6F6767696E67223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/system/system.module', 'system', 'module', '', '1', '0', '7080', '0', 0x613A31343A7B733A343A226E616D65223B733A363A2253797374656D223B733A31313A226465736372697074696F6E223B733A35343A2248616E646C65732067656E6572616C207369746520636F6E66696775726174696F6E20666F722061646D696E6973747261746F72732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A363A7B693A303B733A31393A2273797374656D2E61726368697665722E696E63223B693A313B733A31353A2273797374656D2E6D61696C2E696E63223B693A323B733A31363A2273797374656D2E71756575652E696E63223B693A333B733A31343A2273797374656D2E7461722E696E63223B693A343B733A31383A2273797374656D2E757064617465722E696E63223B693A353B733A31313A2273797374656D2E74657374223B7D733A383A227265717569726564223B623A313B733A393A22636F6E666967757265223B733A31393A2261646D696E2F636F6E6669672F73797374656D223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/system/tests/cron_queue_test.module', 'cron_queue_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31353A2243726F6E2051756575652074657374223B733A31313A226465736372697074696F6E223B733A34313A22537570706F7274206D6F64756C6520666F72207468652063726F6E2071756575652072756E6E65722E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/system/tests/system_cron_test.module', 'system_cron_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31363A2253797374656D2043726F6E2054657374223B733A31313A226465736372697074696F6E223B733A34353A22537570706F7274206D6F64756C6520666F722074657374696E67207468652073797374656D5F63726F6E28292E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/taxonomy/taxonomy.module', 'taxonomy', 'module', '', '1', '0', '7011', '0', 0x613A31353A7B733A343A226E616D65223B733A383A225461786F6E6F6D79223B733A31313A226465736372697074696F6E223B733A33383A22456E61626C6573207468652063617465676F72697A6174696F6E206F6620636F6E74656E742E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A373A226F7074696F6E73223B7D733A353A2266696C6573223B613A323A7B693A303B733A31353A227461786F6E6F6D792E6D6F64756C65223B693A313B733A31333A227461786F6E6F6D792E74657374223B7D733A393A22636F6E666967757265223B733A32343A2261646D696E2F7374727563747572652F7461786F6E6F6D79223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B733A383A227265717569726564223B623A313B733A31313A226578706C616E6174696F6E223B733A38363A224669656C64207479706528732920696E20757365202D20736565203C6120687265663D222F7369657574686967696172652F61646D696E2F7265706F7274732F6669656C6473223E4669656C64206C6973743C2F613E223B7D);
INSERT INTO `system` VALUES ('modules/toolbar/toolbar.module', 'toolbar', 'module', '', '1', '0', '0', '0', 0x613A31323A7B733A343A226E616D65223B733A373A22546F6F6C626172223B733A31313A226465736372697074696F6E223B733A39393A2250726F7669646573206120746F6F6C62617220746861742073686F77732074686520746F702D6C6576656C2061646D696E697374726174696F6E206D656E75206974656D7320616E64206C696E6B732066726F6D206F74686572206D6F64756C65732E223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/tracker/tracker.module', 'tracker', 'module', '', '0', '0', '-1', '0', 0x613A31323A7B733A343A226E616D65223B733A373A22547261636B6572223B733A31313A226465736372697074696F6E223B733A34353A22456E61626C657320747261636B696E67206F6620726563656E7420636F6E74656E7420666F722075736572732E223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A373A22636F6D6D656E74223B7D733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31323A22747261636B65722E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/translation/tests/translation_test.module', 'translation_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32343A22436F6E74656E74205472616E736C6174696F6E2054657374223B733A31313A226465736372697074696F6E223B733A34393A22537570706F7274206D6F64756C6520666F722074686520636F6E74656E74207472616E736C6174696F6E2074657374732E223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/translation/translation.module', 'translation', 'module', '', '0', '0', '-1', '0', 0x613A31323A7B733A343A226E616D65223B733A31393A22436F6E74656E74207472616E736C6174696F6E223B733A31313A226465736372697074696F6E223B733A35373A22416C6C6F777320636F6E74656E7420746F206265207472616E736C6174656420696E746F20646966666572656E74206C616E6775616765732E223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A363A226C6F63616C65223B7D733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31363A227472616E736C6174696F6E2E74657374223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/trigger/tests/trigger_test.module', 'trigger_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31323A22547269676765722054657374223B733A31313A226465736372697074696F6E223B733A33333A22537570706F7274206D6F64756C6520666F7220547269676765722074657374732E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2276657273696F6E223B733A343A22372E3433223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/trigger/trigger.module', 'trigger', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A373A2254726967676572223B733A31313A226465736372697074696F6E223B733A39303A22456E61626C657320616374696F6E7320746F206265206669726564206F6E206365727461696E2073797374656D206576656E74732C2073756368206173207768656E206E657720636F6E74656E7420697320637265617465642E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31323A22747269676765722E74657374223B7D733A393A22636F6E666967757265223B733A32333A2261646D696E2F7374727563747572652F74726967676572223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/update/tests/aaa_update_test.module', 'aaa_update_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31353A22414141205570646174652074657374223B733A31313A226465736372697074696F6E223B733A34313A22537570706F7274206D6F64756C6520666F7220757064617465206D6F64756C652074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2276657273696F6E223B733A343A22372E3433223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/update/tests/bbb_update_test.module', 'bbb_update_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31353A22424242205570646174652074657374223B733A31313A226465736372697074696F6E223B733A34313A22537570706F7274206D6F64756C6520666F7220757064617465206D6F64756C652074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2276657273696F6E223B733A343A22372E3433223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/update/tests/ccc_update_test.module', 'ccc_update_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31353A22434343205570646174652074657374223B733A31313A226465736372697074696F6E223B733A34313A22537570706F7274206D6F64756C6520666F7220757064617465206D6F64756C652074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2276657273696F6E223B733A343A22372E3433223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/update/tests/update_test.module', 'update_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31313A225570646174652074657374223B733A31313A226465736372697074696F6E223B733A34313A22537570706F7274206D6F64756C6520666F7220757064617465206D6F64756C652074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/update/update.module', 'update', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A31343A22557064617465206D616E61676572223B733A31313A226465736372697074696F6E223B733A3130343A22436865636B7320666F7220617661696C61626C6520757064617465732C20616E642063616E207365637572656C7920696E7374616C6C206F7220757064617465206D6F64756C657320616E64207468656D65732076696120612077656220696E746572666163652E223B733A373A2276657273696F6E223B733A343A22372E3433223B733A373A227061636B616765223B733A343A22436F7265223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A313A7B693A303B733A31313A227570646174652E74657374223B7D733A393A22636F6E666967757265223B733A33303A2261646D696E2F7265706F7274732F757064617465732F73657474696E6773223B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/user/tests/user_form_test.module', 'user_form_test', 'module', '', '0', '0', '-1', '0', 0x613A31333A7B733A343A226E616D65223B733A32323A2255736572206D6F64756C6520666F726D207465737473223B733A31313A226465736372697074696F6E223B733A33373A22537570706F7274206D6F64756C6520666F72207573657220666F726D2074657374696E672E223B733A373A227061636B616765223B733A373A2254657374696E67223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A363A2268696464656E223B623A313B733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('modules/user/user.module', 'user', 'module', '', '1', '0', '7018', '0', 0x613A31353A7B733A343A226E616D65223B733A343A2255736572223B733A31313A226465736372697074696F6E223B733A34373A224D616E6167657320746865207573657220726567697374726174696F6E20616E64206C6F67696E2073797374656D2E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A353A2266696C6573223B613A323A7B693A303B733A31313A22757365722E6D6F64756C65223B693A313B733A393A22757365722E74657374223B7D733A383A227265717569726564223B623A313B733A393A22636F6E666967757265223B733A31393A2261646D696E2F636F6E6669672F70656F706C65223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A383A22757365722E637373223B733A32313A226D6F64756C65732F757365722F757365722E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('profiles/standard/standard.profile', 'standard', 'module', '', '1', '0', '0', '1000', 0x613A31353A7B733A343A226E616D65223B733A383A225374616E64617264223B733A31313A226465736372697074696F6E223B733A35313A22496E7374616C6C207769746820636F6D6D6F6E6C792075736564206665617475726573207072652D636F6E666967757265642E223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A32313A7B693A303B733A353A22626C6F636B223B693A313B733A353A22636F6C6F72223B693A323B733A373A22636F6D6D656E74223B693A333B733A31303A22636F6E7465787475616C223B693A343B733A393A2264617368626F617264223B693A353B733A343A2268656C70223B693A363B733A353A22696D616765223B693A373B733A343A226C697374223B693A383B733A343A226D656E75223B693A393B733A363A226E756D626572223B693A31303B733A373A226F7074696F6E73223B693A31313B733A343A2270617468223B693A31323B733A383A227461786F6E6F6D79223B693A31333B733A353A2264626C6F67223B693A31343B733A363A22736561726368223B693A31353B733A383A2273686F7274637574223B693A31363B733A373A22746F6F6C626172223B693A31373B733A373A226F7665726C6179223B693A31383B733A383A226669656C645F7569223B693A31393B733A343A2266696C65223B693A32303B733A333A22726466223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A353A226D74696D65223B693A313435383232343331353B733A373A227061636B616765223B733A353A224F74686572223B733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B733A363A2268696464656E223B623A313B733A383A227265717569726564223B623A313B733A31373A22646973747269627574696F6E5F6E616D65223B733A363A2244727570616C223B7D);
INSERT INTO `system` VALUES ('sites/all/modules/autoLoad/Core.module', 'Core', 'module', '', '1', '0', '0', '0', 0x613A31313A7B733A343A226E616D65223B733A343A22436F7265223B733A31313A226465736372697074696F6E223B733A31373A22446576656C6F706572206279207465616D223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A333A22444556223B733A373A2276657273696F6E223B733A373A22372E782D312E31223B733A393A22646174657374616D70223B733A31303A2231323236333437383237223B733A353A226D74696D65223B693A313435383232343331353B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('sites/all/modules/autoLoad/HSSCore/HSSCore.module', 'HSSCore', 'module', '', '1', '0', '0', '0', 0x613A31313A7B733A343A226E616D65223B733A31353A2248535320436F7265206D6F64756C65223B733A31313A226465736372697074696F6E223B733A31363A22446576656C6F70657220627920485353223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A31313A22485353206D6F64756C6573223B733A373A2276657273696F6E223B733A373A22372E782D312E31223B733A393A22646174657374616D70223B733A31303A2231323236333437383237223B733A353A226D74696D65223B693A313435383138373933383B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('sites/all/modules/backend/Admin.module', 'Admin', 'module', '', '1', '0', '0', '0', 0x613A31313A7B733A343A226E616D65223B733A353A2241646D696E223B733A31313A226465736372697074696F6E223B733A31373A22446576656C6F706572206279207465616D223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A343A22436F7265223B7D733A373A227061636B616765223B733A333A22444556223B733A373A2276657273696F6E223B733A373A22372E782D312E31223B733A393A22646174657374616D70223B733A31303A2231323236333437383237223B733A353A226D74696D65223B693A313435383232343331353B733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('sites/all/modules/backend/HSSAdmin/HSSAdmin.module', 'HSSAdmin', 'module', '', '1', '0', '0', '0', 0x613A31313A7B733A343A226E616D65223B733A353A2241646D696E223B733A31313A226465736372697074696F6E223B733A31373A22446576656C6F706572206279207465616D223B733A343A22636F7265223B733A333A22372E78223B733A31323A22646570656E64656E63696573223B613A313A7B693A303B733A343A22436F7265223B7D733A373A227061636B616765223B733A333A22444556223B733A373A2276657273696F6E223B733A373A22372E782D312E31223B733A393A22646174657374616D70223B733A31303A2231323236333437383237223B733A353A226D74696D65223B693A313435383138393434363B733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('sites/all/modules/frontend/Site.module', 'Site', 'module', '', '1', '0', '0', '0', 0x613A31313A7B733A343A226E616D65223B733A343A2253697465223B733A31313A226465736372697074696F6E223B733A31373A22446576656C6F706572206279207465616D223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A333A22444556223B733A373A2276657273696F6E223B733A373A22372E782D312E31223B733A393A22646174657374616D70223B733A31303A2231323236333437383237223B733A353A226D74696D65223B693A313435383438323532393B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('sites/all/modules/shop/Shop.module', 'Shop', 'module', '', '1', '0', '0', '0', 0x613A31313A7B733A343A226E616D65223B733A343A2253686F70223B733A31313A226465736372697074696F6E223B733A31373A22446576656C6F706572206279207465616D223B733A343A22636F7265223B733A333A22372E78223B733A373A227061636B616765223B733A333A22444556223B733A373A2276657273696F6E223B733A373A22372E782D312E31223B733A393A22646174657374616D70223B733A31303A2231323236333437383237223B733A353A226D74696D65223B693A313435383536373236343B733A31323A22646570656E64656E63696573223B613A303A7B7D733A333A22706870223B733A353A22352E322E34223B733A353A2266696C6573223B613A303A7B7D733A393A22626F6F747374726170223B693A303B7D);
INSERT INTO `system` VALUES ('sites/all/themes/theme_default/theme_default.info', 'theme_default', 'theme', 'themes/engines/phptemplate/phptemplate.engine', '1', '0', '-1', '0', 0x613A31373A7B733A343A226E616D65223B733A31333A2264656661756C74207468656D65223B733A31313A226465736372697074696F6E223B733A31333A2264656661756C74207468656D65223B733A343A22636F7265223B733A333A22372E78223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A373A2276657273696F6E223B733A333A22372E78223B733A373A2270726F6A656374223B733A31333A2264656661756C74207468656D65223B733A393A22646174657374616D70223B733A31303A2231333332353137383436223B733A373A22726567696F6E73223B613A383A7B733A363A22686561646572223B733A363A22486561646572223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A343A226C656674223B733A343A224C656674223B733A353A227269676874223B733A353A225269676874223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31333A226373732F7374796C652E637373223B733A34343A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F6373732F7374796C652E637373223B7D7D733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A34353A2273697465732F616C6C2F7468656D65732F7468656D655F64656661756C742F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383331353630373B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D);
INSERT INTO `system` VALUES ('themes/bartik/bartik.info', 'bartik', 'theme', 'themes/engines/phptemplate/phptemplate.engine', '1', '0', '-1', '0', 0x613A31393A7B733A343A226E616D65223B733A363A2242617274696B223B733A31313A226465736372697074696F6E223B733A34383A224120666C657869626C652C207265636F6C6F7261626C65207468656D652077697468206D616E7920726567696F6E732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A333A7B733A31343A226373732F6C61796F75742E637373223B733A32383A227468656D65732F62617274696B2F6373732F6C61796F75742E637373223B733A31333A226373732F7374796C652E637373223B733A32373A227468656D65732F62617274696B2F6373732F7374796C652E637373223B733A31343A226373732F636F6C6F72732E637373223B733A32383A227468656D65732F62617274696B2F6373732F636F6C6F72732E637373223B7D733A353A227072696E74223B613A313A7B733A31333A226373732F7072696E742E637373223B733A32373A227468656D65732F62617274696B2F6373732F7072696E742E637373223B7D7D733A373A22726567696F6E73223B613A32303A7B733A363A22686561646572223B733A363A22486561646572223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31313A22686967686C696768746564223B733A31313A22486967686C696768746564223B733A383A226665617475726564223B733A383A224665617475726564223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A31333A22736964656261725F6669727374223B733A31333A2253696465626172206669727374223B733A31343A22736964656261725F7365636F6E64223B733A31343A2253696465626172207365636F6E64223B733A31343A2274726970747963685F6669727374223B733A31343A225472697074796368206669727374223B733A31353A2274726970747963685F6D6964646C65223B733A31353A225472697074796368206D6964646C65223B733A31333A2274726970747963685F6C617374223B733A31333A225472697074796368206C617374223B733A31383A22666F6F7465725F6669727374636F6C756D6E223B733A31393A22466F6F74657220666972737420636F6C756D6E223B733A31393A22666F6F7465725F7365636F6E64636F6C756D6E223B733A32303A22466F6F746572207365636F6E6420636F6C756D6E223B733A31383A22666F6F7465725F7468697264636F6C756D6E223B733A31393A22466F6F74657220746869726420636F6C756D6E223B733A31393A22666F6F7465725F666F75727468636F6C756D6E223B733A32303A22466F6F74657220666F7572746820636F6C756D6E223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A383A2273657474696E6773223B613A313A7B733A32303A2273686F72746375745F6D6F64756C655F6C696E6B223B733A313A2230223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32383A227468656D65732F62617274696B2F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D);
INSERT INTO `system` VALUES ('themes/garland/garland.info', 'garland', 'theme', 'themes/engines/phptemplate/phptemplate.engine', '0', '0', '-1', '0', 0x613A31393A7B733A343A226E616D65223B733A373A224761726C616E64223B733A31313A226465736372697074696F6E223B733A3131313A2241206D756C74692D636F6C756D6E207468656D652077686963682063616E20626520636F6E6669677572656420746F206D6F6469667920636F6C6F727320616E6420737769746368206265747765656E20666978656420616E6420666C756964207769647468206C61796F7574732E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A323A7B733A333A22616C6C223B613A313A7B733A393A227374796C652E637373223B733A32343A227468656D65732F6761726C616E642F7374796C652E637373223B7D733A353A227072696E74223B613A313A7B733A393A227072696E742E637373223B733A32343A227468656D65732F6761726C616E642F7072696E742E637373223B7D7D733A383A2273657474696E6773223B613A313A7B733A31333A226761726C616E645F7769647468223B733A353A22666C756964223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A373A22726567696F6E73223B613A31323A7B733A31333A22736964656261725F6669727374223B733A31323A224C6566742073696465626172223B733A31343A22736964656261725F7365636F6E64223B733A31333A2252696768742073696465626172223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A363A22686561646572223B733A363A22486561646572223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31313A22686967686C696768746564223B733A31313A22486967686C696768746564223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32393A227468656D65732F6761726C616E642F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D);
INSERT INTO `system` VALUES ('themes/seven/seven.info', 'seven', 'theme', 'themes/engines/phptemplate/phptemplate.engine', '1', '0', '-1', '0', 0x613A31393A7B733A343A226E616D65223B733A353A22536576656E223B733A31313A226465736372697074696F6E223B733A36353A22412073696D706C65206F6E652D636F6C756D6E2C207461626C656C6573732C20666C7569642077696474682061646D696E697374726174696F6E207468656D652E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A313A7B733A363A2273637265656E223B613A323A7B733A393A2272657365742E637373223B733A32323A227468656D65732F736576656E2F72657365742E637373223B733A393A227374796C652E637373223B733A32323A227468656D65732F736576656E2F7374796C652E637373223B7D7D733A383A2273657474696E6773223B613A313A7B733A32303A2273686F72746375745F6D6F64756C655F6C696E6B223B733A313A2231223B7D733A373A22726567696F6E73223B613A383A7B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31333A22736964656261725F6669727374223B733A31333A2246697273742073696465626172223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A31343A22726567696F6E735F68696464656E223B613A333A7B693A303B733A31333A22736964656261725F6669727374223B693A313B733A383A22706167655F746F70223B693A323B733A31313A22706167655F626F74746F6D223B7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32373A227468656D65732F736576656E2F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D);
INSERT INTO `system` VALUES ('themes/stark/stark.info', 'stark', 'theme', 'themes/engines/phptemplate/phptemplate.engine', '0', '0', '-1', '0', 0x613A31383A7B733A343A226E616D65223B733A353A22537461726B223B733A31313A226465736372697074696F6E223B733A3230383A2254686973207468656D652064656D6F6E737472617465732044727570616C27732064656661756C742048544D4C206D61726B757020616E6420435353207374796C65732E20546F206C6561726E20686F7720746F206275696C6420796F7572206F776E207468656D6520616E64206F766572726964652044727570616C27732064656661756C7420636F64652C2073656520746865203C6120687265663D22687474703A2F2F64727570616C2E6F72672F7468656D652D6775696465223E5468656D696E672047756964653C2F613E2E223B733A373A227061636B616765223B733A343A22436F7265223B733A373A2276657273696F6E223B733A343A22372E3433223B733A343A22636F7265223B733A333A22372E78223B733A31313A227374796C65736865657473223B613A313A7B733A333A22616C6C223B613A313A7B733A31303A226C61796F75742E637373223B733A32333A227468656D65732F737461726B2F6C61796F75742E637373223B7D7D733A373A2270726F6A656374223B733A363A2264727570616C223B733A393A22646174657374616D70223B733A31303A2231343536333433353036223B733A363A22656E67696E65223B733A31313A2270687074656D706C617465223B733A373A22726567696F6E73223B613A31323A7B733A31333A22736964656261725F6669727374223B733A31323A224C6566742073696465626172223B733A31343A22736964656261725F7365636F6E64223B733A31333A2252696768742073696465626172223B733A373A22636F6E74656E74223B733A373A22436F6E74656E74223B733A363A22686561646572223B733A363A22486561646572223B733A363A22666F6F746572223B733A363A22466F6F746572223B733A31313A22686967686C696768746564223B733A31313A22486967686C696768746564223B733A343A2268656C70223B733A343A2248656C70223B733A383A22706167655F746F70223B733A383A225061676520746F70223B733A31313A22706167655F626F74746F6D223B733A31313A225061676520626F74746F6D223B733A31343A2264617368626F6172645F6D61696E223B733A31363A2244617368626F61726420286D61696E29223B733A31373A2264617368626F6172645F73696465626172223B733A31393A2244617368626F61726420287369646562617229223B733A31383A2264617368626F6172645F696E616374697665223B733A32303A2244617368626F6172642028696E61637469766529223B7D733A383A226665617475726573223B613A393A7B693A303B733A343A226C6F676F223B693A313B733A373A2266617669636F6E223B693A323B733A343A226E616D65223B693A333B733A363A22736C6F67616E223B693A343B733A31373A226E6F64655F757365725F70696374757265223B693A353B733A32303A22636F6D6D656E745F757365725F70696374757265223B693A363B733A32353A22636F6D6D656E745F757365725F766572696669636174696F6E223B693A373B733A393A226D61696E5F6D656E75223B693A383B733A31343A227365636F6E646172795F6D656E75223B7D733A31303A2273637265656E73686F74223B733A32373A227468656D65732F737461726B2F73637265656E73686F742E706E67223B733A333A22706870223B733A353A22352E322E34223B733A373A2273637269707473223B613A303A7B7D733A353A226D74696D65223B693A313435383232343331353B733A31353A226F7665726C61795F726567696F6E73223B613A333A7B693A303B733A31343A2264617368626F6172645F6D61696E223B693A313B733A31373A2264617368626F6172645F73696465626172223B693A323B733A31383A2264617368626F6172645F696E616374697665223B7D733A31343A22726567696F6E735F68696464656E223B613A323A7B693A303B733A383A22706167655F746F70223B693A313B733A31313A22706167655F626F74746F6D223B7D733A32383A226F7665726C61795F737570706C656D656E74616C5F726567696F6E73223B613A313A7B693A303B733A383A22706167655F746F70223B7D7D);

-- ----------------------------
-- Table structure for taxonomy_index
-- ----------------------------
DROP TABLE IF EXISTS `taxonomy_index`;
CREATE TABLE `taxonomy_index` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  KEY `term_node` (`tid`,`sticky`,`created`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';

-- ----------------------------
-- Records of taxonomy_index
-- ----------------------------

-- ----------------------------
-- Table structure for taxonomy_term_data
-- ----------------------------
DROP TABLE IF EXISTS `taxonomy_term_data`;
CREATE TABLE `taxonomy_term_data` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the description.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this term in relation to other terms.',
  PRIMARY KEY (`tid`),
  KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  KEY `vid_name` (`vid`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores term information.';

-- ----------------------------
-- Records of taxonomy_term_data
-- ----------------------------

-- ----------------------------
-- Table structure for taxonomy_term_hierarchy
-- ----------------------------
DROP TABLE IF EXISTS `taxonomy_term_hierarchy`;
CREATE TABLE `taxonomy_term_hierarchy` (
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.',
  PRIMARY KEY (`tid`,`parent`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';

-- ----------------------------
-- Records of taxonomy_term_hierarchy
-- ----------------------------

-- ----------------------------
-- Table structure for taxonomy_vocabulary
-- ----------------------------
DROP TABLE IF EXISTS `taxonomy_vocabulary`;
CREATE TABLE `taxonomy_vocabulary` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `machine_name` (`machine_name`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.';

-- ----------------------------
-- Records of taxonomy_vocabulary
-- ----------------------------
INSERT INTO `taxonomy_vocabulary` VALUES ('1', 'Tags', 'tags', 'Use tags to group articles on similar topics into categories.', '0', 'taxonomy', '0');

-- ----------------------------
-- Table structure for url_alias
-- ----------------------------
DROP TABLE IF EXISTS `url_alias`;
CREATE TABLE `url_alias` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';

-- ----------------------------
-- Records of url_alias
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL DEFAULT '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) DEFAULT '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the signature.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) DEFAULT NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign key: file_managed.fid of user’s picture.',
  `init` varchar(254) DEFAULT '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`),
  KEY `access` (`access`),
  KEY `created` (`created`),
  KEY `mail` (`mail`),
  KEY `picture` (`picture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user data.';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('0', '', '', '', '', '', null, '0', '0', '0', '0', null, '', '0', '', null);
INSERT INTO `users` VALUES ('1', 'admin', '$S$DyGshzjSmdVx3nIlSlyudY6W6B15hpj8okVwv83yLTZC7Uw3RUrl', 'nguyenduypt86@gmail.com', '', '', null, '1458142935', '1459438616', '1459436586', '1', 'Asia/Ho_Chi_Minh', '', '0', 'nguyenduypt86@gmail.com', 0x623A303B);
INSERT INTO `users` VALUES ('2', 'manager', '$S$D4ErzK/ym14voD61gd4BljbVaJxA9eg1qj54cIzeaeSdd4Bij.6S', 'pt.soleil@gmail.com', '', '', 'filtered_html', '1458146407', '1458365541', '1458319455', '1', 'Asia/Ho_Chi_Minh', '', '0', 'pt.soleil@gmail.com', null);

-- ----------------------------
-- Table structure for users_roles
-- ----------------------------
DROP TABLE IF EXISTS `users_roles`;
CREATE TABLE `users_roles` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: role.rid for role.',
  PRIMARY KEY (`uid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';

-- ----------------------------
-- Records of users_roles
-- ----------------------------
INSERT INTO `users_roles` VALUES ('1', '3');
INSERT INTO `users_roles` VALUES ('2', '4');

-- ----------------------------
-- Table structure for variable
-- ----------------------------
DROP TABLE IF EXISTS `variable`;
CREATE TABLE `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';

-- ----------------------------
-- Records of variable
-- ----------------------------
INSERT INTO `variable` VALUES ('admin_theme', 0x733A353A22736576656E223B);
INSERT INTO `variable` VALUES ('clean_url', 0x733A313A2231223B);
INSERT INTO `variable` VALUES ('comment_page', 0x693A303B);
INSERT INTO `variable` VALUES ('cron_key', 0x733A34333A226C4C66375F5A3962513061305A7171356E4E7351354E5558594F366C34533477515279507A7062734A356F223B);
INSERT INTO `variable` VALUES ('cron_last', 0x693A313435393437373133393B);
INSERT INTO `variable` VALUES ('css_js_query_string', 0x733A363A226F3477746868223B);
INSERT INTO `variable` VALUES ('date_default_timezone', 0x733A31363A22417369612F486F5F4368695F4D696E68223B);
INSERT INTO `variable` VALUES ('default_nodes_main', 0x733A323A223130223B);
INSERT INTO `variable` VALUES ('drupal_http_request_fails', 0x623A303B);
INSERT INTO `variable` VALUES ('drupal_private_key', 0x733A34333A22715877333152676446674C564F7662786E4F634877326A5A50446C6449682D4E724E6E5F566D70366D3351223B);
INSERT INTO `variable` VALUES ('file_temporary_path', 0x733A31323A22443A5C78616D70705C746D70223B);
INSERT INTO `variable` VALUES ('filter_fallback_format', 0x733A31303A22706C61696E5F74657874223B);
INSERT INTO `variable` VALUES ('install_profile', 0x733A383A227374616E64617264223B);
INSERT INTO `variable` VALUES ('install_task', 0x733A343A22646F6E65223B);
INSERT INTO `variable` VALUES ('install_time', 0x693A313435383134333332313B);
INSERT INTO `variable` VALUES ('menu_expanded', 0x613A303A7B7D);
INSERT INTO `variable` VALUES ('menu_masks', 0x613A33343A7B693A303B693A3530313B693A313B693A3439333B693A323B693A3235303B693A333B693A3234373B693A343B693A3234363B693A353B693A3234353B693A363B693A3132353B693A373B693A3132333B693A383B693A3132323B693A393B693A3132313B693A31303B693A3131373B693A31313B693A36333B693A31323B693A36323B693A31333B693A36313B693A31343B693A36303B693A31353B693A35393B693A31363B693A35383B693A31373B693A34343B693A31383B693A33313B693A31393B693A33303B693A32303B693A32393B693A32313B693A32383B693A32323B693A32343B693A32333B693A32313B693A32343B693A31353B693A32353B693A31343B693A32363B693A31333B693A32373B693A31313B693A32383B693A373B693A32393B693A363B693A33303B693A353B693A33313B693A333B693A33323B693A323B693A33333B693A313B7D);
INSERT INTO `variable` VALUES ('node_admin_theme', 0x733A313A2231223B);
INSERT INTO `variable` VALUES ('node_options_page', 0x613A313A7B693A303B733A363A22737461747573223B7D);
INSERT INTO `variable` VALUES ('node_submitted_page', 0x623A303B);
INSERT INTO `variable` VALUES ('path_alias_whitelist', 0x613A303A7B7D);
INSERT INTO `variable` VALUES ('site_403', 0x733A383A22706167652D343033223B);
INSERT INTO `variable` VALUES ('site_404', 0x733A383A22706167652D343034223B);
INSERT INTO `variable` VALUES ('site_default_country', 0x733A323A22564E223B);
INSERT INTO `variable` VALUES ('site_frontpage', 0x733A393A227472616E672D636875223B);
INSERT INTO `variable` VALUES ('site_mail', 0x733A32333A226E677579656E6475797074383640676D61696C2E636F6D223B);
INSERT INTO `variable` VALUES ('site_name', 0x733A31303A224769616E2048C3A06E67223B);
INSERT INTO `variable` VALUES ('site_slogan', 0x733A303A22223B);
INSERT INTO `variable` VALUES ('theme_default', 0x733A31333A227468656D655F64656661756C74223B);
INSERT INTO `variable` VALUES ('user_admin_role', 0x733A313A2233223B);
INSERT INTO `variable` VALUES ('user_pictures', 0x733A313A2231223B);
INSERT INTO `variable` VALUES ('user_picture_dimensions', 0x733A393A22313032347831303234223B);
INSERT INTO `variable` VALUES ('user_picture_file_size', 0x733A333A22383030223B);
INSERT INTO `variable` VALUES ('user_picture_style', 0x733A393A227468756D626E61696C223B);
INSERT INTO `variable` VALUES ('user_register', 0x693A323B);

-- ----------------------------
-- Table structure for watchdog
-- ----------------------------
DROP TABLE IF EXISTS `watchdog`;
CREATE TABLE `watchdog` (
  `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example "user" or "page not found."',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Unix timestamp of when event occurred.',
  PRIMARY KEY (`wid`),
  KEY `type` (`type`),
  KEY `uid` (`uid`),
  KEY `severity` (`severity`)
) ENGINE=InnoDB AUTO_INCREMENT=2436 DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.';

-- ----------------------------
-- Records of watchdog
-- ----------------------------

-- ----------------------------
-- Table structure for web_category
-- ----------------------------
DROP TABLE IF EXISTS `web_category`;
CREATE TABLE `web_category` (
  `category_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category_parent_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `category_status` tinyint(1) NOT NULL DEFAULT '0',
  `category_order` tinyint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`),
  KEY `status` (`category_status`) USING BTREE,
  KEY `id_parrent` (`category_parent_id`,`category_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of web_category
-- ----------------------------
INSERT INTO `web_category` VALUES ('1', 'Thời trang áo tắm', '24', '0', '0');
INSERT INTO `web_category` VALUES ('2', 'Váy dài', '24', '0', '0');
INSERT INTO `web_category` VALUES ('3', 'Áo', '24', '0', '0');
INSERT INTO `web_category` VALUES ('4', 'Du lịch', '0', '1', '0');
INSERT INTO `web_category` VALUES ('5', 'Phụ kiện công nghệ', '43', '1', '0');
INSERT INTO `web_category` VALUES ('6', 'Phòng khách sạn', '4', '1', '0');
INSERT INTO `web_category` VALUES ('7', 'Ẩm thực, Spa, Giải trí', '0', '1', '0');
INSERT INTO `web_category` VALUES ('8', 'Ô tô', '7', '0', '0');
INSERT INTO `web_category` VALUES ('9', 'Nhà hàng', '7', '1', '0');
INSERT INTO `web_category` VALUES ('10', 'Váy ngắn', '24', '0', '0');
INSERT INTO `web_category` VALUES ('11', 'Chân váy', '24', '0', '0');
INSERT INTO `web_category` VALUES ('13', 'Resort&amp;Nghỉ dưỡng', '4', '1', '0');
INSERT INTO `web_category` VALUES ('14', 'Khám phá', '4', '1', '0');
INSERT INTO `web_category` VALUES ('15', 'Ăn vặt&amp;Cafe', '7', '0', '0');
INSERT INTO `web_category` VALUES ('16', 'Ẩm thực', '7', '1', '0');
INSERT INTO `web_category` VALUES ('17', 'Quần áo&amp;Phụ kiện trẻ em', '24', '0', '0');
INSERT INTO `web_category` VALUES ('19', 'Quần áo&amp;Phụ kiện nam', '24', '0', '0');
INSERT INTO `web_category` VALUES ('23', 'Mỹ phẩm&amp;Làm đẹp', '24', '0', '0');
INSERT INTO `web_category` VALUES ('24', 'Thời trang &amp; Phụ kiện', '0', '0', '0');
INSERT INTO `web_category` VALUES ('25', 'Tham quan', '4', '1', '0');
INSERT INTO `web_category` VALUES ('26', 'test danhmuc', '21', '0', '0');
INSERT INTO `web_category` VALUES ('27', 'Đồ điện gia dụng', '86', '1', '0');
INSERT INTO `web_category` VALUES ('28', 'Channel', '27', '0', '0');
INSERT INTO `web_category` VALUES ('29', 'Phụ kiện', '24', '0', '0');
INSERT INTO `web_category` VALUES ('30', 'Maybeline', '27', '0', '0');
INSERT INTO `web_category` VALUES ('31', 'Thời trang nam', '24', '0', '0');
INSERT INTO `web_category` VALUES ('32', 'Thời trang nữ', '24', '0', '0');
INSERT INTO `web_category` VALUES ('33', 'Đồ dùng tiện ích', '27', '0', '0');
INSERT INTO `web_category` VALUES ('41', 'Mẹ và bé', '0', '1', '0');
INSERT INTO `web_category` VALUES ('42', 'Điện máy', '0', '0', '0');
INSERT INTO `web_category` VALUES ('43', 'Điện tử công nghệ', '0', '1', '0');
INSERT INTO `web_category` VALUES ('44', 'Điện thoại', '43', '1', '0');
INSERT INTO `web_category` VALUES ('45', 'Xe cộ', '0', '1', '0');
INSERT INTO `web_category` VALUES ('50', 'Điện lạnh', '86', '1', '0');
INSERT INTO `web_category` VALUES ('53', 'Thời trang trẻ em', '41', '1', '0');
INSERT INTO `web_category` VALUES ('56', 'Đồ chơi - Đồ dùng', '41', '1', '0');
INSERT INTO `web_category` VALUES ('59', 'Xe đạp', '45', '1', '0');
INSERT INTO `web_category` VALUES ('65', 'Trang điểm - Làm tóc', '0', '1', '0');
INSERT INTO `web_category` VALUES ('66', 'Mỹ phẩm', '7', '0', '0');
INSERT INTO `web_category` VALUES ('69', 'Spa &amp; Làm đẹp', '7', '0', '0');
INSERT INTO `web_category` VALUES ('72', 'Spa - Masage', '0', '0', '0');
INSERT INTO `web_category` VALUES ('75', 'Trang điểm - Chăm sóc tóc', '69', '0', '0');
INSERT INTO `web_category` VALUES ('78', 'Chăm sóc sức khỏe', '69', '0', '0');
INSERT INTO `web_category` VALUES ('81', 'Tivi, Video &amp; Âm thanh', '43', '0', '0');
INSERT INTO `web_category` VALUES ('83', 'Phòng ngủ - Phòng tắm', '0', '1', '0');
INSERT INTO `web_category` VALUES ('86', 'Gia dụng &amp; Nội thất', '0', '1', '0');
INSERT INTO `web_category` VALUES ('89', 'Nội thất phòng tắm', '86', '1', '0');
INSERT INTO `web_category` VALUES ('90', 'Thực phẩm', '0', '1', '0');
INSERT INTO `web_category` VALUES ('91', 'Thực phẩm bổ dưỡng', '90', '1', '0');
INSERT INTO `web_category` VALUES ('92', 'Vật dụng nhà bếp', '86', '1', '0');
INSERT INTO `web_category` VALUES ('93', 'Sữa - Đồ ngọt', '90', '1', '0');
INSERT INTO `web_category` VALUES ('94', 'Thực phẩm gia đình', '90', '1', '0');
INSERT INTO `web_category` VALUES ('95', 'Thực phẩm chức năng', '90', '1', '0');
INSERT INTO `web_category` VALUES ('96', 'Thời trang nam', '0', '1', '0');
INSERT INTO `web_category` VALUES ('97', 'Thời trang nữ', '0', '1', '0');
INSERT INTO `web_category` VALUES ('98', 'Áo sơmi', '96', '0', '0');
INSERT INTO `web_category` VALUES ('99', 'Áo khoác, Vest', '96', '1', '0');
INSERT INTO `web_category` VALUES ('100', 'Áo len, Cardigan', '96', '1', '0');
INSERT INTO `web_category` VALUES ('101', 'Quần', '96', '1', '0');
INSERT INTO `web_category` VALUES ('102', 'Pull và Áo phông', '96', '1', '0');
INSERT INTO `web_category` VALUES ('103', 'Đồ lót, Đồ bơi nam', '96', '1', '0');
INSERT INTO `web_category` VALUES ('104', 'Đồ thể thao', '96', '1', '0');
INSERT INTO `web_category` VALUES ('105', 'Thời trang bầu', '41', '1', '0');
INSERT INTO `web_category` VALUES ('106', 'Đầm, chân váy', '97', '1', '0');
INSERT INTO `web_category` VALUES ('107', 'Áo sơ mi', '97', '1', '0');
INSERT INTO `web_category` VALUES ('108', 'Áo Khoác và Vest', '97', '1', '0');
INSERT INTO `web_category` VALUES ('109', 'Quần', '97', '1', '0');
INSERT INTO `web_category` VALUES ('110', 'Đồ lót, Đồ bơi', '97', '1', '0');
INSERT INTO `web_category` VALUES ('111', 'Đồ thể thao, mặc nhà', '97', '1', '0');
INSERT INTO `web_category` VALUES ('112', 'Thời trang nữ khác', '97', '1', '0');
INSERT INTO `web_category` VALUES ('113', 'Chân váy', '97', '0', '0');
INSERT INTO `web_category` VALUES ('114', 'Đồ thể thao', '97', '0', '0');
INSERT INTO `web_category` VALUES ('115', 'Phụ kiện Nữ', '97', '1', '0');
INSERT INTO `web_category` VALUES ('116', 'Túi, Ví', '115', '0', '0');
INSERT INTO `web_category` VALUES ('117', 'Trang sức', '115', '0', '0');
INSERT INTO `web_category` VALUES ('118', 'Khác', '115', '0', '0');
INSERT INTO `web_category` VALUES ('119', 'Phụ kiện Nam', '96', '1', '0');
INSERT INTO `web_category` VALUES ('120', 'Túi, Ví nam', '119', '0', '0');
INSERT INTO `web_category` VALUES ('121', 'Thắt lưng', '119', '0', '0');
INSERT INTO `web_category` VALUES ('122', 'Giày dép Nữ', '97', '1', '0');
INSERT INTO `web_category` VALUES ('123', 'Giày cao gót', '122', '0', '0');
INSERT INTO `web_category` VALUES ('124', 'Giày đế bằng', '122', '0', '0');
INSERT INTO `web_category` VALUES ('125', 'Boots nam', '122', '0', '0');
INSERT INTO `web_category` VALUES ('126', 'Sandals', '122', '0', '0');
INSERT INTO `web_category` VALUES ('127', 'Giày dép Nam', '96', '1', '0');
INSERT INTO `web_category` VALUES ('128', 'Giày Âu', '127', '0', '0');
INSERT INTO `web_category` VALUES ('129', 'Giày lười', '127', '0', '0');
INSERT INTO `web_category` VALUES ('130', 'Boots', '127', '0', '0');
INSERT INTO `web_category` VALUES ('131', 'Giày thể thao', '127', '0', '0');
INSERT INTO `web_category` VALUES ('132', 'Giày buộc dây, Sneaker', '127', '0', '0');
INSERT INTO `web_category` VALUES ('133', 'Thời trang trẻ em', '0', '0', '0');
INSERT INTO `web_category` VALUES ('134', 'Thời trang bé trai', '133', '0', '0');
INSERT INTO `web_category` VALUES ('135', 'Thời trang bé gái', '133', '0', '0');
INSERT INTO `web_category` VALUES ('136', 'Phụ kiện bé trai', '133', '0', '0');
INSERT INTO `web_category` VALUES ('137', 'Phụ kiện bé gái', '133', '0', '0');
INSERT INTO `web_category` VALUES ('138', 'Giày dép bé trai', '133', '0', '0');
INSERT INTO `web_category` VALUES ('139', 'Giày dép bé gái', '0', '0', '0');
INSERT INTO `web_category` VALUES ('140', 'Máy tính, laptop', '43', '1', '0');
INSERT INTO `web_category` VALUES ('141', 'Máy tính bảng', '43', '1', '0');
INSERT INTO `web_category` VALUES ('142', 'All', '43', '0', '0');
INSERT INTO `web_category` VALUES ('143', 'Máy in', '43', '1', '0');
INSERT INTO `web_category` VALUES ('144', 'Màn hình', '43', '1', '0');
INSERT INTO `web_category` VALUES ('145', 'Máy ảnh - Máy quay', '43', '1', '0');
INSERT INTO `web_category` VALUES ('146', 'Mỹ phẩm nam', '96', '0', '0');
INSERT INTO `web_category` VALUES ('147', 'Thiết bị an ninh', '43', '1', '0');
INSERT INTO `web_category` VALUES ('148', 'Tivi - Âm thanh - Thiết bị Số', '43', '1', '0');
INSERT INTO `web_category` VALUES ('149', 'Mỹ phẩm', '97', '0', '0');
INSERT INTO `web_category` VALUES ('150', 'Ô tô', '45', '1', '0');
INSERT INTO `web_category` VALUES ('151', 'Xe máy', '45', '1', '0');
INSERT INTO `web_category` VALUES ('152', 'Dụng cụ nhà bếp', '86', '0', '0');
INSERT INTO `web_category` VALUES ('153', 'Dụng cụ nhà bếp', '86', '0', '0');
INSERT INTO `web_category` VALUES ('154', 'Đồ điện gia dụng', '86', '0', '0');
INSERT INTO `web_category` VALUES ('155', 'Sản phẩm tiện ích', '86', '1', '0');
INSERT INTO `web_category` VALUES ('156', 'Nội thất phòng ngủ', '86', '0', '0');
INSERT INTO `web_category` VALUES ('157', 'Nội thất và trang trí nhà ở', '86', '1', '0');
INSERT INTO `web_category` VALUES ('158', 'Thể Thao - Dã ngoại', '0', '1', '0');
INSERT INTO `web_category` VALUES ('159', 'Máy tập thể thao các loại', '158', '1', '0');
INSERT INTO `web_category` VALUES ('160', 'Dụng cụ thể thao', '158', '1', '0');
INSERT INTO `web_category` VALUES ('161', 'Đồ dùng dã ngoại', '158', '1', '0');
INSERT INTO `web_category` VALUES ('162', 'Xe đạp thể thao', '158', '1', '0');
INSERT INTO `web_category` VALUES ('163', 'Các loại khác', '158', '1', '0');
INSERT INTO `web_category` VALUES ('164', 'Làm đẹp &amp; Sức khỏe', '0', '1', '0');
INSERT INTO `web_category` VALUES ('165', 'Trang điểm', '164', '1', '0');
INSERT INTO `web_category` VALUES ('166', 'Chăm sóc cơ thể', '164', '1', '0');
INSERT INTO `web_category` VALUES ('167', 'Chăm sóc tóc', '164', '1', '0');
INSERT INTO `web_category` VALUES ('168', 'Chăm sóc da mặt', '164', '1', '0');
INSERT INTO `web_category` VALUES ('169', 'Quần áo - Phụ kiện thể thao', '158', '1', '0');
INSERT INTO `web_category` VALUES ('170', 'Đồ dùng cho mẹ', '41', '1', '0');
INSERT INTO `web_category` VALUES ('171', 'Thực phẩm và dụng cụ ăn uống', '41', '1', '0');
INSERT INTO `web_category` VALUES ('172', 'Đồ dùng cho bé', '41', '1', '0');
INSERT INTO `web_category` VALUES ('173', 'Xe và các thiết bị an toàn', '41', '1', '0');
INSERT INTO `web_category` VALUES ('174', 'Bé học và chơi', '41', '1', '0');
INSERT INTO `web_category` VALUES ('175', 'Đồ gia dụng tiện ích', '41', '0', '0');
INSERT INTO `web_category` VALUES ('176', 'Thiết bị y tế &amp; Làm đẹp', '164', '1', '0');

-- ----------------------------
-- Table structure for web_comment
-- ----------------------------
DROP TABLE IF EXISTS `web_comment`;
CREATE TABLE `web_comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_parent_id` int(11) DEFAULT '0' COMMENT 'Comment cha, câu hỏi trước',
  `comment_product_id` int(11) DEFAULT NULL,
  `comment_shop_id` int(11) DEFAULT NULL COMMENT 'Id shop được bình luận',
  `comment_customer_name` varchar(255) DEFAULT NULL COMMENT 'tên khách comment',
  `comment_content` tinytext COMMENT 'Nội dung conmetn',
  `comment_is_reply` tinyint(5) DEFAULT '0' COMMENT '0: chưa trả lời, 1: đã trả lời',
  `comment_create` int(11) DEFAULT NULL COMMENT 'tg hỏi',
  `comment_reply` int(11) DEFAULT '0' COMMENT 'Thời gian trả lời',
  `comment_status` tinyint(5) DEFAULT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_comment
-- ----------------------------

-- ----------------------------
-- Table structure for web_config_info
-- ----------------------------
DROP TABLE IF EXISTS `web_config_info`;
CREATE TABLE `web_config_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keyword` varchar(255) DEFAULT NULL COMMENT 'keyword',
  `intro` longtext,
  `content` longtext,
  `img` varchar(255) DEFAULT NULL,
  `created` varchar(15) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0' COMMENT 'Item enabled status (1 = enabled, 0 = disabled)',
  `meta_title` text COMMENT 'Meta title',
  `meta_keywords` text COMMENT 'Meta keywords',
  `meta_description` text COMMENT 'Meta description',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Stores news content.';

-- ----------------------------
-- Records of web_config_info
-- ----------------------------
INSERT INTO `web_config_info` VALUES ('1', '1', 'Thông tin chân trang bên trái', 'SITE_FOOTER_LEFT', 'Hà Nội:\r\nSố 10 ngách 224/6 đường Hoàng Mai -Hoàng Văn Thụ - Hoàng Mai - Hà Nội\r\nĐT: 0946.721.638 - 0913.922.986\r\nEmail: hotro@sanphamredep.com', '<p>\r\n	<strong>H&agrave; Nội:</strong><br />\r\n	Số 10 ng&aacute;ch 224/6 đường Ho&agrave;ng Mai -Ho&agrave;ng Văn Thụ - Ho&agrave;ng Mai - H&agrave; Nội<br />\r\n	ĐT: 0946.721.638 - 0913.922.986<br />\r\n	Email: hotro@sanphamredep.com</p>', null, '1447794727', '1', '', '', '');
INSERT INTO `web_config_info` VALUES ('2', '1', 'Thông tin giới thiệu', 'SITE_INTRO', '', '<p>\r\n	X&atilde; hội ng&agrave;y c&agrave;ng ph&aacute;t triển, cuộc sống ng&agrave;y c&agrave;ng được n&acirc;ng cao, v&agrave; những nhu cầu tiện nghi cho cuộc sống con người cũng v&igrave; thế m&agrave; n&acirc;ng l&ecirc;n, k&egrave;m theo đ&oacute; l&agrave; những th&uacute; vui sưu tầm v&agrave; sở hữu những gi&aacute; trị nghệ thuật ng&agrave;y c&agrave;ng lớn. Phụ kiện thời trang từ xưa đến nay lu&ocirc;n l&agrave; biểu tượng của thời gian. SanPhamReDep.COM l&agrave; nơi cung cấp v&agrave; phục vụ tốt nhất về c&aacute;c loại sản phẩm gi&uacute;p kh&aacute;ch h&agrave;ng trang bị cho m&igrave;nh phụ kiện thời trang ho&agrave;n mỹ nhất.</p>\r\n<p>\r\n	<strong>Mọi th&ocirc;ng tin chi tiết vui l&ograve;ng li&ecirc;n hệ về:</strong></p>\r\n<p>\r\n	Email hợp t&aacute;c: pt.soleil@gmail.com<br />\r\n	Địa chỉ: Số 64/68, Ho&agrave;ng Văn Thụ, Ho&agrave;ng Mai, H&agrave; Nội<br />\r\n	Li&ecirc;n hệ: 0913.922.986(Mr.Anh)</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>', null, '1441430611', '1', '', '', '');
INSERT INTO `web_config_info` VALUES ('4', '1', 'Thông tin bài liên hệ', 'SITE_CONTACT', '', '<p>\r\n	X&atilde; hội ng&agrave;y c&agrave;ng ph&aacute;t triển, cuộc sống ng&agrave;y c&agrave;ng được n&acirc;ng cao, v&agrave; những nhu cầu tiện nghi cho cuộc sống con người cũng v&igrave; thế m&agrave; n&acirc;ng l&ecirc;n, k&egrave;m theo đ&oacute; l&agrave; những th&uacute; vui sưu tầm v&agrave; sở hữu những sản phẩm phục vụ cho cuộc sống ng&agrave;y c&agrave;ng lớn. SanPhamReDep.COM l&agrave; nơi cung cấp v&agrave; phục vụ tốt nhất về c&aacute;c loại sản phẩm n&agrave;y.</p>', null, '1441430633', '1', '', '', '');
INSERT INTO `web_config_info` VALUES ('8', '1', 'Hướng dẫn mua hàng - nhận hàng - thanh toán', 'SITE_GUIDE_BUY_PAY', '', '<p>\r\n	<strong>Mua đơn giản nhất</strong>: gọi điện trực tiếp đến 0913 922 986 v&agrave; l&agrave;m theo hướng dẫn.</p>\r\n<p>\r\n	<strong>Mua nhanh nhất</strong>: Nhắn 1 tin nhắn gồm: Họ t&ecirc;n + Địa chỉ + M&atilde; sản phẩm đến 0913 922 986. Shop sẽ gọi lại x&aacute;c nhận v&agrave; chuyển h&agrave;ng cho bạn.</p>\r\n<p>\r\n	<strong>Mua ch&iacute;nh x&aacute;c nhất</strong>: Đặt h&agrave;ng tr&ecirc;n website</p>\r\n<p>\r\n	- <em><strong>Bước 1</strong></em>: Lựa chọn mẫu sản phẩm ưng &yacute; tr&ecirc;n website: SanPhamReDep.COM</p>\r\n<p>\r\n	-<em><strong> Bước 2</strong></em>: Điền đầy đủ th&ocirc;ng tin v&agrave;o &ocirc; nhập v&agrave; số lượng bạn muốn mua:</p>\r\n<p>\r\n	- <em><strong>Bước 3</strong></em> - Gửi đơn h&agrave;ng: Sau khi điền xong bạn bấm v&agrave;o n&uacute;t GỬI ĐƠN H&Agrave;NG</p>\r\n<p>\r\n	<strong>NHẬN H&Agrave;NG</strong></p>\r\n<p>\r\n	Sau 2-4 ng&agrave;y bạn đặt h&agrave;ng, sản phẩm bạn mua sẽ được giao tận tay bạn ở nh&agrave; hoặc bất cứ địa điểm n&agrave;o bạn muốn trong giờ h&agrave;nh ch&iacute;nh nh&eacute; (Từ 8h s&aacute;ng đến 17h chiều).</p>\r\n<p>\r\n	<strong>THANH TO&Aacute;N</strong></p>\r\n<p>\r\n	Thanh to&aacute;n rất đơn giản, khi n&agrave;o nhận được h&agrave;ng bạn chỉ cần gửi tiền cho người giao l&agrave; xong, kh&ocirc;ng cần chuyển khoản, vừa tiết kiệm thời gian vừa an to&agrave;n.</p>', null, '1441430673', '1', '', '', '');
INSERT INTO `web_config_info` VALUES ('9', '1', 'Nội dung meta SEO trang chủ', 'SITE_SEO_HOME', 'Không cần để nội dung...', 'Không cần để nội dung...', '07-2015/10-41-20-21-07-2015-sanphamtructuyen.jpg', '1437450080', '1', 'Thời trang nam, thời trang nữ, thời trang trẻ em, phụ kiện thời trang, đồ gia dụng', 'Thời trang nam, thời trang nữ, thời trang trẻ em, phụ kiện thời trang, đồ gia dụng', 'Thời trang nam, thời trang nữ, thời trang trẻ em, phụ kiện thời trang, đồ gia dụng');
INSERT INTO `web_config_info` VALUES ('10', '1', 'Hotline đầu trang', 'SITE_HOTLINE', 'Hotline đầu trang', '0946.721.638 - 0913.922.986', null, '1446789341', '1', '', '', '');

-- ----------------------------
-- Table structure for web_news
-- ----------------------------
DROP TABLE IF EXISTS `web_news`;
CREATE TABLE `web_news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `news_title` varchar(255) DEFAULT NULL,
  `news_desc_sort` varchar(255) DEFAULT NULL,
  `news_content` text,
  `news_image` varchar(255) DEFAULT NULL COMMENT 'ảnh đại diện của bài viết',
  `news_image_other` varchar(255) DEFAULT NULL COMMENT 'Lưu ảnh của bài viết',
  `news_type` tinyint(5) DEFAULT '1' COMMENT 'Kiểu tin',
  `news_category` int(11) DEFAULT NULL,
  `news_status` tinyint(5) DEFAULT NULL,
  `news_create` int(11) DEFAULT NULL,
  PRIMARY KEY (`news_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_news
-- ----------------------------
INSERT INTO `web_news` VALUES ('1', 'Hướng dẫn up sản phẩm', 'Hướng dẫn up sản phẩm', '', '', '', '0', '0', '1', '0');

-- ----------------------------
-- Table structure for web_product
-- ----------------------------
DROP TABLE IF EXISTS `web_product`;
CREATE TABLE `web_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price_sell` int(11) DEFAULT '0' COMMENT 'Giá bán',
  `product_price_market` int(11) DEFAULT '0' COMMENT 'Giá thị trường',
  `product_price_input` int(11) DEFAULT '0' COMMENT 'giá nhập',
  `product_type_price` tinyint(5) DEFAULT '1' COMMENT 'Kiểu hiển thị giá bán: 1:hiển thị giá số, 2: hiển thị giá liên hệ',
  `product_selloff` varchar(255) DEFAULT NULL COMMENT 'text thông báo thông tin giảm giá, sp dinh kèm, khuyến mại...',
  `product_is_hot` tinyint(5) DEFAULT '0' COMMENT '0: SP bthuong,1:sản phẩm nổi bật,2:sản phẩm giảm giá....',
  `product_sort_desc` tinytext COMMENT 'mô tả ngắn',
  `product_content` text COMMENT 'nội dung sản phẩm',
  `product_image` varchar(255) DEFAULT NULL COMMENT 'ảnh SP chính ',
  `product_image_hover` varchar(255) DEFAULT NULL COMMENT 'ảnh khi hover chuột vào SP',
  `product_image_other` tinytext COMMENT 'danh sach ảnh khác',
  `category_id` int(11) DEFAULT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `quality_input` int(11) DEFAULT '0' COMMENT 'Số lượng nhập hàng',
  `quality_out` int(11) DEFAULT '0' COMMENT 'Số lượng đã xuất',
  `status` tinyint(5) DEFAULT '1' COMMENT '0:ẩn, 1:hiện,',
  `is_block` tinyint(5) DEFAULT '1' COMMENT '0: bị khóa, 1: không bị khóa',
  `user_shop_id` int(11) DEFAULT '0' COMMENT 'Id user shop',
  `user_shop_name` varchar(255) DEFAULT NULL COMMENT 'Tên shop tạo sản phẩm',
  `is_shop` tinyint(5) DEFAULT '0' COMMENT '0: sp của shop thường, 1: sản phẩm của shop vip',
  `time_created` int(11) DEFAULT NULL,
  `time_update` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_product
-- ----------------------------

-- ----------------------------
-- Table structure for web_province
-- ----------------------------
DROP TABLE IF EXISTS `web_province`;
CREATE TABLE `web_province` (
  `province_id` int(11) NOT NULL AUTO_INCREMENT,
  `province_name` varchar(255) NOT NULL,
  `province_position` tinyint(4) NOT NULL,
  `province_status` varchar(20) NOT NULL,
  `province_area` tinyint(4) NOT NULL COMMENT 'Vùng miền của tỉnh thành',
  PRIMARY KEY (`province_id`),
  KEY `position` (`province_position`),
  KEY `status` (`province_status`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_province
-- ----------------------------
INSERT INTO `web_province` VALUES ('3', 'Bạc Liêu', '6', '0', '3');
INSERT INTO `web_province` VALUES ('4', 'Bắc Cạn', '7', '0', '1');
INSERT INTO `web_province` VALUES ('5', 'Bắc Giang', '6', '0', '1');
INSERT INTO `web_province` VALUES ('6', 'Bắc Ninh', '7', '0', '1');
INSERT INTO `web_province` VALUES ('7', 'Bến Tre', '8', '0', '3');
INSERT INTO `web_province` VALUES ('8', 'Bình Dương', '9', '0', '3');
INSERT INTO `web_province` VALUES ('9', 'Bình Định', '10', '0', '2');
INSERT INTO `web_province` VALUES ('10', 'Bình Phước', '11', '0', '2');
INSERT INTO `web_province` VALUES ('11', 'Bình Thuận', '12', '0', '2');
INSERT INTO `web_province` VALUES ('12', 'Cà Mau', '13', '0', '3');
INSERT INTO `web_province` VALUES ('13', 'Cao Bằng', '14', '0', '1');
INSERT INTO `web_province` VALUES ('14', 'Cần Thơ', '8', '0', '3');
INSERT INTO `web_province` VALUES ('15', 'Đà Nẵng', '3', '1', '2');
INSERT INTO `web_province` VALUES ('17', 'Đồng Nai', '18', '0', '3');
INSERT INTO `web_province` VALUES ('18', 'Đồng Tháp', '19', '0', '3');
INSERT INTO `web_province` VALUES ('19', 'Gia Lai', '20', '0', '2');
INSERT INTO `web_province` VALUES ('20', 'Hà Giang', '21', '0', '1');
INSERT INTO `web_province` VALUES ('21', 'Hà Nam', '22', '0', '1');
INSERT INTO `web_province` VALUES ('22', 'Hà Nội', '1', '1', '1');
INSERT INTO `web_province` VALUES ('23', 'Hà Tây', '24', '0', '1');
INSERT INTO `web_province` VALUES ('24', 'Hà Tĩnh', '25', '0', '2');
INSERT INTO `web_province` VALUES ('25', 'Hải Dương', '26', '0', '1');
INSERT INTO `web_province` VALUES ('26', 'Hải Phòng', '5', '1', '1');
INSERT INTO `web_province` VALUES ('27', 'Hòa Bình', '28', '0', '1');
INSERT INTO `web_province` VALUES ('28', 'Hưng Yên', '29', '0', '1');
INSERT INTO `web_province` VALUES ('29', 'TP Hồ Chí Minh', '2', '1', '3');
INSERT INTO `web_province` VALUES ('30', 'Khánh Hòa', '31', '0', '2');
INSERT INTO `web_province` VALUES ('31', 'Kiên Giang', '32', '0', '3');
INSERT INTO `web_province` VALUES ('32', 'Kon Tum', '33', '0', '2');
INSERT INTO `web_province` VALUES ('33', 'Lai Châu', '34', '0', '1');
INSERT INTO `web_province` VALUES ('34', 'Lạng Sơn', '35', '0', '1');
INSERT INTO `web_province` VALUES ('35', 'Lào Cai', '36', '0', '1');
INSERT INTO `web_province` VALUES ('36', 'Lâm Đồng', '37', '0', '2');
INSERT INTO `web_province` VALUES ('37', 'Long An', '38', '0', '3');
INSERT INTO `web_province` VALUES ('38', 'Nam Định', '39', '0', '1');
INSERT INTO `web_province` VALUES ('39', 'Nghệ An', '40', '0', '2');
INSERT INTO `web_province` VALUES ('40', 'Ninh Bình', '41', '0', '1');
INSERT INTO `web_province` VALUES ('41', 'Ninh Thuận', '42', '0', '2');
INSERT INTO `web_province` VALUES ('42', 'Phú Thọ', '43', '0', '1');
INSERT INTO `web_province` VALUES ('43', 'Phú Yên', '44', '0', '2');
INSERT INTO `web_province` VALUES ('44', 'Quảng Bình', '45', '0', '2');
INSERT INTO `web_province` VALUES ('45', 'Quảng Nam', '46', '0', '2');
INSERT INTO `web_province` VALUES ('46', 'Quảng Ngãi', '47', '0', '2');
INSERT INTO `web_province` VALUES ('47', 'Quảng Ninh', '7', '0', '1');
INSERT INTO `web_province` VALUES ('48', 'Quảng Trị', '49', '0', '2');
INSERT INTO `web_province` VALUES ('49', 'Sóc Trăng', '50', '0', '3');
INSERT INTO `web_province` VALUES ('50', 'Sơn La', '51', '0', '1');
INSERT INTO `web_province` VALUES ('51', 'Tây Ninh', '52', '0', '3');
INSERT INTO `web_province` VALUES ('52', 'Thái Bình', '53', '0', '1');
INSERT INTO `web_province` VALUES ('53', 'Thái Nguyên', '54', '0', '1');
INSERT INTO `web_province` VALUES ('54', 'Thanh Hóa', '55', '0', '1');
INSERT INTO `web_province` VALUES ('55', 'Thừa Thiên Huế', '56', '0', '2');
INSERT INTO `web_province` VALUES ('56', 'Tiền Giang', '57', '0', '3');
INSERT INTO `web_province` VALUES ('57', 'Trà Vinh', '58', '0', '3');
INSERT INTO `web_province` VALUES ('58', 'Tuyên Quang', '59', '0', '1');
INSERT INTO `web_province` VALUES ('59', 'Vĩnh Long', '60', '0', '3');
INSERT INTO `web_province` VALUES ('60', 'Vĩnh Phúc', '61', '0', '1');
INSERT INTO `web_province` VALUES ('61', 'Yên Bái', '62', '0', '1');
INSERT INTO `web_province` VALUES ('66', 'An giang', '62', '0', '3');
INSERT INTO `web_province` VALUES ('67', 'Vũng Tàu', '6', '1', '3');
INSERT INTO `web_province` VALUES ('68', 'Nha Trang', '4', '1', '0');
INSERT INTO `web_province` VALUES ('69', 'Điện Biên', '0', '0', '0');
INSERT INTO `web_province` VALUES ('70', 'Hậu Giang', '0', '0', '0');
INSERT INTO `web_province` VALUES ('71', 'Đắk Nông', '0', '0', '0');
INSERT INTO `web_province` VALUES ('72', 'Đắk Lắc', '0', '0', '0');

-- ----------------------------
-- Table structure for web_supplier
-- ----------------------------
DROP TABLE IF EXISTS `web_supplier`;
CREATE TABLE `web_supplier` (
  `supplier_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(50) DEFAULT NULL COMMENT 'Tên Brand hiển thị',
  `supplier_phone` varchar(20) DEFAULT NULL,
  `supplier_hot_line` varchar(20) DEFAULT NULL,
  `supplier_email` varchar(255) DEFAULT NULL,
  `supplier_website` varchar(255) DEFAULT NULL,
  `supplier_status` tinyint(1) DEFAULT '1',
  `supplier_created` int(11) DEFAULT '0',
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=895 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_supplier
-- ----------------------------
INSERT INTO `web_supplier` VALUES ('107', 'Demo2', '0904488737', '', 'demo@gmail.com', 'demo.vn', '1', '1410606257');
INSERT INTO `web_supplier` VALUES ('117', 'SIÊU THỊ ĐIỆN MÁY HC', '18001788', '', 'online@hc.com.vn', 'http://hc.com.vn', '1', '1410630351');
INSERT INTO `web_supplier` VALUES ('119', 'Robot Tosy', '04 3248 4666', '04 3248 4666', 'kinhdoanh@tosy.com', 'http://vn.tosy.com', '1', '1410773906');
INSERT INTO `web_supplier` VALUES ('122', 'VietBike', '[04]668.00.9', '01999-88-000', 'info@xedapgap.com', 'http://xedapgap.com/', '1', '1410776269');
INSERT INTO `web_supplier` VALUES ('125', 'BooShop', '(04) 3978106', '0936.30.36.3', 'order@bosua.vn', 'http://bosua.vn', '1', '1410834872');
INSERT INTO `web_supplier` VALUES ('128', 'Canifa Fashion', '(04) 3564209', '04.3577.2870', 'chamsockhachhang@canifa.vn', 'http://canifa.com/', '1', '1410839663');
INSERT INTO `web_supplier` VALUES ('131', 'Khách sạn Daewoo Hà Nội', '043 8315000', '', 'sales@daewoohotel.com', 'http://www.daewoohotel.com/', '1', '1410847197');
INSERT INTO `web_supplier` VALUES ('134', 'Chudu24.vn', '1900545440', '1900545440', 'chudu24@gmail.com', 'http://chudu24.vn', '1', '1410847463');
INSERT INTO `web_supplier` VALUES ('136', 'Saigontourist', '0838225874', '083822 5874', 'saigontourist@gmail.com.vn', 'http://www.saigon-tourist.com/', '1', '1410850104');
INSERT INTO `web_supplier` VALUES ('137', 'Kangaroo', '0473 095 588', '092.335.5588', 'kstore@kangaroo.vn', 'http://store.kangaroo.vn', '1', '1411200117');
INSERT INTO `web_supplier` VALUES ('139', 'Masscom Việt Nam', '0437679171', '0437679171', 'hotro@masscom.vn', 'http://masstel.vn/site/index', '1', '1411371261');
INSERT INTO `web_supplier` VALUES ('141', 'Toàn Anh', '01673886886', '', 'thoaluuthi@muachung.vn', '', '1', '1411440013');
INSERT INTO `web_supplier` VALUES ('143', 'Nhà hàng L\'annam', '0984901157', '0912032100', 'annambuffet@gmail.com', 'http://annambuffet.vn/', '1', '1411531987');
INSERT INTO `web_supplier` VALUES ('146', 'Sunhouse', '043736 66 76', '18006680', 'info@sunhouse.com.vn', 'http://www.sunhouse.com.vn', '0', '1411731247');
INSERT INTO `web_supplier` VALUES ('149', 'test', '0973446306', '', 'test@gmail.com', 'test.vn', '1', '1411784613');
INSERT INTO `web_supplier` VALUES ('152', 'Điện máy DigiCity', '(04)730 888 86', '1900.6662', 'info@digicity.vn', 'http://digicity.vn/', '1', '1411789925');
INSERT INTO `web_supplier` VALUES ('155', 'Mykingdom', '0854318717', '0966032003', 'info@viettinhanh.com.vn', 'viettinhanh.com.vn', '1', '1411962977');
INSERT INTO `web_supplier` VALUES ('158', 'Aspen Clinic &amp; Spa', '0963770682', '0435562580', 'p.phuonglinh@gmail.com', 'http://aspenclinic.com.vn/', '1', '1411985979');
INSERT INTO `web_supplier` VALUES ('160', 'Myota Vietnam', '0422428238', '', 'kho@myota.com.vn', '', '1', '1412048493');
INSERT INTO `web_supplier` VALUES ('161', 'Công ty Ngọc Vũ', '01674 911 800', '043976 56', 'myphamngocvu@gmail.com', 'kma.vn', '1', '1412050455');
INSERT INTO `web_supplier` VALUES ('164', 'Royal Lotus Hạ Long', '03 3626 9999', '04 7306 8689', 'info@royallotushotelhalong.com', 'http://royallotushotelhalong.com/', '1', '1412138143');
INSERT INTO `web_supplier` VALUES ('167', 'Vietourist', '0915 943 383', '0873 00 10 2', 'info@vietourist.com.vn', 'http://vietourist.com.vn/', '1', '1412139502');
INSERT INTO `web_supplier` VALUES ('169', 'MerPerle Hòn Tằm Resort', '08 3785 0927 - 103', '0906683059', 'sales@merperle.vn', 'http://www.merperle.vn', '1', '1412156552');
INSERT INTO `web_supplier` VALUES ('170', 'Little Paris Resort', '0623743716', '', 'info@littleparisresort.com.vn', 'http://www.littleparisresort.com.vn/​​​', '1', '1412236521');
INSERT INTO `web_supplier` VALUES ('173', 'Villa Delsol Beach Resort', '062.384.555', '062.384.555', 'sm@villadelsol.com.vn', 'http://www.villadelsol.com.vn/', '1', '1412324343');
INSERT INTO `web_supplier` VALUES ('176', 'La Sapinette', '063 3550 979', '', 'rsvn@lasapinette.com', 'http://www.lasapinette.com/?m=home', '1', '1412324928');
INSERT INTO `web_supplier` VALUES ('179', 'Xe đạp điện Nghĩa Hải', '096 728 7777', '04.351 60766', 'sales@nghiahai.vn', 'http://www.xedapdien.com/', '1', '1412332966');
INSERT INTO `web_supplier` VALUES ('182', 'xemlamua.vn', '0979 68 66 88', '0979 68 66', 'info@xemlamua.vn', 'http://www.xemlamua.vn', '1', '1412584073');
INSERT INTO `web_supplier` VALUES ('185', 'Khách sạn Vian', '0511.3931319', '', 'sales@vianhoteldanang.vn', 'www.vianhoteldanang.vn', '1', '1412657243');
INSERT INTO `web_supplier` VALUES ('188', 'Khách sạn Trendy', '0511 3945657', '', 'saletrendy@yahoo.com', 'http://trendyhotel.com.vn', '1', '1412657890');
INSERT INTO `web_supplier` VALUES ('190', 'Emeraude Classic Cruise', '(84-4) 3935 1888', '', 'customer1@emeraude-cruises.com', 'http://www.emeraude-cruises.com/', '1', '1412667300');
INSERT INTO `web_supplier` VALUES ('191', 'Khách sạn Mường Thanh', '05113 929 929', '', 'sales2@danang.muongthanh.vn', 'danang.muongthanh.vn', '1', '1412671999');
INSERT INTO `web_supplier` VALUES ('194', 'Ancient House River', '0510 3 930 777', '0510 3 930 7', 'sales@ancinenthouseriver.com', 'http://www.ancienthouseriver.com/', '1', '1412673162');
INSERT INTO `web_supplier` VALUES ('196', 'Khách sạn Eldora Huế', '054 386 6666', '', 'esa@eldorahotel.com', 'eldorahotel.com', '1', '1412673949');
INSERT INTO `web_supplier` VALUES ('198', 'Dalat Palace Luxury', '063 3825 444', '', 'palace.reservations@dalatresorts.com', 'http://www.dalatresorts.com/index.php/vi/dalatpalace', '1', '1412678817');
INSERT INTO `web_supplier` VALUES ('200', 'Shambala Spa', '04 3933 9898', '', 'shambala.hn@gmail.com', 'http://shambala.vn', '1', '1412763653');
INSERT INTO `web_supplier` VALUES ('202', 'Cửa hàng Ngọc Lan', '0914 817 028', '0914 817 028', 'ngocquynh08101988@gmail.com', '', '1', '1412766241');
INSERT INTO `web_supplier` VALUES ('212', 'Siêu thị Ga Gối', '0919716533', '0919716533', 'mrs.ngocbao@gmail.com', '', '1', '1412844250');
INSERT INTO `web_supplier` VALUES ('214', 'Modern Life', '0945458811', '18001715', 'trang.nguyenthanh@goldsun.vn', 'http://www.modernlife.vn/', '1', '1412929033');
INSERT INTO `web_supplier` VALUES ('215', 'Goldsun Việt Nam', '0437658111', '0945 458 811', 'ngtrang68@gmail.com', 'http://www.goldsun.vn/', '1', '1412933087');
INSERT INTO `web_supplier` VALUES ('218', 'Victory Hotel', '0839303182', '', 'nhahangvictory@victoryhotel.com.vn', 'http://www.victoryhotel.com.vn/facilities_service.php', '1', '1412998930');
INSERT INTO `web_supplier` VALUES ('221', 'Oriflame HCM Shop', '0908085436', '', 'huutiennhansu9999@gmail.com', 'https://www.facebook.com/pages/Oriflame-HCM/535060059885680', '1', '1412999992');
INSERT INTO `web_supplier` VALUES ('223', 'Công ty Phát Việt', '04 3 5141429', '', 'pvdistribution69@yahoo.com', 'http://pvdistribution.com/', '1', '1413448737');
INSERT INTO `web_supplier` VALUES ('224', 'Sứ Buffet', '043 9413338', '096 438 8844', 'letansubuffet@gmail.com', 'www.subuffet.com', '1', '1416198202');
INSERT INTO `web_supplier` VALUES ('225', 'Dalat Hotel Du Parc', '063 3825 777', '063 3825 7', 'duparc.reservations@dalatresorts.com', '', '1', '1416223169');
INSERT INTO `web_supplier` VALUES ('226', 'Siêu thị mẹ &amp; bé Babysol', '04 35668669', '1900 6496', 'dang.tuanh@echovietnam.com', 'http://www.babysol.vn/', '1', '1416283254');
INSERT INTO `web_supplier` VALUES ('228', 'hồ chí minh', '0973445255', '', 'hcm@gmail.com', '', '1', '1416301085');
INSERT INTO `web_supplier` VALUES ('230', 'Nhà Hàng Alfresco\'s', '0908131568', '0908131568', 'ld@alfrescosgroup.com', '', '1', '1416371592');
INSERT INTO `web_supplier` VALUES ('231', 'Eden Saigon Hotel', '0988896545', '0988896545', 'fb@edensaigonhotel.com', 'https://www.edensaigonhotel.com/', '1', '1416373143');
INSERT INTO `web_supplier` VALUES ('232', 'Lakeside Hotel', '043 8350111', '0928004213', 'hoanganh.marketing@lakesidehotel.com.vn', 'lakesidehotel.com.vn', '1', '1416374001');
INSERT INTO `web_supplier` VALUES ('233', 'Yến A Hoàng', '01296507173', '01296507173', 'dangchitam2006vn@yahoo.com', '', '1', '1416379742');
INSERT INTO `web_supplier` VALUES ('234', 'Yến sào Chấn Phi', '0903766683', '0903766683', 'yensaochanphi@yahoo.com', 'http://www.yensaochanphi.com/', '1', '1416379989');
INSERT INTO `web_supplier` VALUES ('235', 'Ví Nam Nữ The Real Partner', '0908142737', '0908142737', 'cosothanhtrieu@gmail.com', '', '1', '1416380218');
INSERT INTO `web_supplier` VALUES ('236', 'Moriitalia', '090.222.3773', '043.564.3611', 'hanh09071982@gmail.com', 'moriitalia.com', '1', '1416395869');
INSERT INTO `web_supplier` VALUES ('237', 'Wa Japanese Cuisine', '04.37153663', '04.37153663', 'wahanoi@gmail.com', 'http://wa-cuisine.com/', '1', '1416545064');
INSERT INTO `web_supplier` VALUES ('238', 'Kidsplaza', '08.3830.6358', '08.3830.6358', 'contact@kidsplaza.vn', 'http://www.kidsplaza.vn/', '1', '1416545868');
INSERT INTO `web_supplier` VALUES ('239', 'Thời trang Remmy', '04.6670.0808', '094 242 1111', 'sales@remmy.vn', 'http://remmy.vn/', '1', '1416556745');
INSERT INTO `web_supplier` VALUES ('240', 'Trung Tâm Điều Trị Da Công Nghệ Cao  Nữ Hoàng Thẩm', '0934427282', '0934427282', 'ngocmytran78@gmail.com', '', '1', '1416562115');
INSERT INTO `web_supplier` VALUES ('241', 'NaSaTouRist - Sài Gòn Năm Sao', '0917.000.978', '0917.000.978', 'info@nasatourist.com', 'nasatourist.com', '1', '1416625423');
INSERT INTO `web_supplier` VALUES ('242', 'Quán Ăn Ngon', '(04)39461485', '090 212 6963', 'sales@phuchungthinh.vn', 'http://www.ngonhanoi.com.vn/', '1', '1416627060');
INSERT INTO `web_supplier` VALUES ('243', 'KM VIỆT NAM', '0976 800 825', '', 'km@kmcosmetic.com.vn', 'http://myphamnhatban.vn/default.aspx', '1', '1416630420');
INSERT INTO `web_supplier` VALUES ('244', 'Nhà Hàng Ngân Đình', '0967990688', '0967990688', 'donghai.nguyen@windsorplazahotel.com', '', '1', '1416800314');
INSERT INTO `web_supplier` VALUES ('245', 'BANDOLINI', '04.3543 4430', '', 'bandolini.shoes@gmail.com', 'http://bandolini.com.vn/', '1', '1416902832');
INSERT INTO `web_supplier` VALUES ('246', 'Windsor Plaza', '0967990689', '0967990688', 'donghai.nguyen@gmail.com', '', '1', '1417062133');
INSERT INTO `web_supplier` VALUES ('247', 'Aroma Beach Resort &amp; Spa Mũi Né', '0623.828288', '', 'reservation@aromabeachresort.com', 'http://www.aromabeachresort.com/', '1', '1417084147');
INSERT INTO `web_supplier` VALUES ('248', 'Hue Riverside Boutique Resort', '054.3978484', '054.3938301', 'info@hueriversideresort.com', 'http://www.hueriversideresort.com/', '1', '1417084753');
INSERT INTO `web_supplier` VALUES ('249', 'Thời trang Phan Nguyễn', '0122.6366.066', '', 'thoitrangphannguyen2014@gmail.com', 'http://www.pnf.vn/', '1', '1417142805');
INSERT INTO `web_supplier` VALUES ('250', 'Thời trang Venice', '0985 79 8686', '0915308286', 'tiensm@gmail.com', 'http://www.venice.esitevn.com/', '1', '1417144783');
INSERT INTO `web_supplier` VALUES ('251', 'Khách sạn Cẩm Đô Đà Lạt', '0633 822 732', '', 'camdosale@gmail.com', 'www.camdohotel.com', '1', '1417410463');
INSERT INTO `web_supplier` VALUES ('252', 'Khách sạn Valentine - TPHCM', '08 38 30 38 33', '', 'valentinehotelvn@gmail.com', 'www.valentinehotelvn.com', '1', '1417421899');
INSERT INTO `web_supplier` VALUES ('253', 'Osaka Village Dalat', '0633.533.160', '', 'osakadalat@yahoo.com.vn', '', '1', '1417423441');
INSERT INTO `web_supplier` VALUES ('254', 'Khách sạn Nhật Thành - Nha Trang', '058.222.0.555', '', 'sales@nhatthanhhotel.com.vn', 'http://nhatthanhhotel.com.vn/VN/', '1', '1417425529');
INSERT INTO `web_supplier` VALUES ('255', 'Thời trang Pacolano', '096.456.7676', '', 'PACOLANO.CO@gmail.com', 'http://pacolano.com.vn/', '1', '1417428099');
INSERT INTO `web_supplier` VALUES ('256', 'Khoảnh Khắc Việt', '099 352 6888', '099 352 6888', 'tuanhm76@gmail.com', 'http://khoanhkhacviet.com/', '1', '1417511786');
INSERT INTO `web_supplier` VALUES ('257', 'BIBOMART', '0437871168', '1900 5555 80', 'info@bibomart.com.vn', 'http://bibomart.com.vn/', '1', '1417516722');
INSERT INTO `web_supplier` VALUES ('258', 'Nhà hàng 1915INDOCHINE', '043 976 1915', '0986 79 1915', 'ngocnguyenthinhu@muachung.vn', 'http://1915indochine.com.vn/', '1', '1417574646');
INSERT INTO `web_supplier` VALUES ('259', 'KIDS PLAZA', '0473000088', '1900.609', 'hoailethithu@muachung.vn', 'http://www.kidsplaza.vn/', '1', '1417662685');
INSERT INTO `web_supplier` VALUES ('260', 'PANASONIC', '0900000000', '', 'PANASONIC@gmail.com', '', '1', '1417675431');
INSERT INTO `web_supplier` VALUES ('261', 'TOSHIBA', '0900000001', '', 'TOSHIBA@gmail.com', '', '1', '1417675486');
INSERT INTO `web_supplier` VALUES ('262', 'CTY TNHH PHÚC NGỌC ANH', '083.9434988', '0933.77.3903', 'phucngocanh@gmail.com', '', '1', '1417675981');
INSERT INTO `web_supplier` VALUES ('263', 'Nhà hàng Java Crawfish', '0437150150', '01239159999', 'info@javacrawfish.com', 'https://www.facebook.com/JavaCrawfish', '1', '1418007678');
INSERT INTO `web_supplier` VALUES ('264', 'Phú Thịnh Boutique Resort &amp; Spa - Hội An', '0510 392 3923', '', 'sm@phuthinhhotels.com', 'www.phuthinhhotels.com', '1', '1418029398');
INSERT INTO `web_supplier` VALUES ('265', 'Thời trang NEM', '04.39393664', '04.39393664', 'lienhe@newnem.com', 'http://www.newnem.com/', '1', '1418099798');
INSERT INTO `web_supplier` VALUES ('266', 'Mazano Fashion', '0933.128.986', '0933.128.986', 'thaocao.marzano@gmail.com', 'http://www.marzano.com.vn/', '1', '1418180344');
INSERT INTO `web_supplier` VALUES ('267', 'Icook', '(84 4) 3722 6354', '0435.186.186', 'icook@ggg.com.vn', 'http://www.ggg.com.vn/', '1', '1418785762');
INSERT INTO `web_supplier` VALUES ('269', 'TopHit', '(04) 6.281.9555', '(04)62819555', 'quyen.newnem@gmail.com', 'https://www.facebook.com/tophitfashion/info?tab=page_info', '1', '1418974230');
INSERT INTO `web_supplier` VALUES ('270', 'Champs Việt nam', '0903868896', '0903868896', 'nguyenkhachung862@gmail.com', 'http://champs-vn.com/', '1', '1419327602');
INSERT INTO `web_supplier` VALUES ('271', 'Khách sạn Thanh Lịch', '054.3877877', '054.3877877', 'sales@eleganthotel.com.vn', 'http://thanhlichhotel.com.vn/', '1', '1419330079');
INSERT INTO `web_supplier` VALUES ('272', 'KHÁCH SẠN CENDELUXE', '057.3818.818', '057.3818.818', 'sm5@hkh.vn', 'http://www.cendeluxehotel.com', '1', '1419333031');
INSERT INTO `web_supplier` VALUES ('273', 'Church Boutique Hàng Cá', '04 3923 4499', '04 3923 4499', 'ecom1@hkh.vn', 'http://hangca.churchhotel.com.vn/', '1', '1419333391');
INSERT INTO `web_supplier` VALUES ('274', 'Playboy', '043.736.8282', '', 'linhnt712@gmail.com', 'https://www.facebook.com/liveplaylove?ref=ts&amp;fref=ts', '1', '1419395695');
INSERT INTO `web_supplier` VALUES ('275', 'Funai', '0909.007.054', '0909.007.054', 'trung.funai@gmail.com', 'http://funai.com.vn/', '1', '1419490855');
INSERT INTO `web_supplier` VALUES ('276', 'Khách sạn Đèn Lồng Đỏ', '0977 689 137', '0977 689 137', 'thuyphan@denlongdo.vn', '', '1', '1419508895');
INSERT INTO `web_supplier` VALUES ('277', 'Miu xinh', '0973222222', '', 'miu@gmail.com', '', '1', '1420015213');
INSERT INTO `web_supplier` VALUES ('278', 'CÔNG TY TRÀ HÀN', '(08)38208572', '094.5454.388', 'miiulee@yahoo.com.vn', 'http://nokchawon2013.koreasme.com/cerfificates.html', '1', '1420019695');
INSERT INTO `web_supplier` VALUES ('279', 'VVindsor Spa', '38323288_2330', '38323288_233', 'kelly.law@windsorplazahotel.com', 'www.windsorplazahotel.com', '1', '1420021567');
INSERT INTO `web_supplier` VALUES ('287', 'Mắt kính Việt', '08.62913379', '0918888515', 'matkinhviet.vn@gmail.com', 'matkinhviet.vn', '1', '1420517599');
INSERT INTO `web_supplier` VALUES ('288', 'Đồng Hồ Hải Triều', '01253246810', '01253246810', 'lienhe@DongHoHaiTrieu.Com', 'DongHoHaiTrieu.Com', '1', '1421133347');
INSERT INTO `web_supplier` VALUES ('289', 'Nhà hàng Yakiniku Gensan', '091 233 50 00', '0942782228', 'yakinikugensan149@gmail.com', 'http://yakinikugensan.vn/', '1', '1421309642');
INSERT INTO `web_supplier` VALUES ('290', 'Điện máy Bình Minh', '086292 5323', '0902438777', 'info@dienmaybinhminh.com', 'http://dienmaybinhminh.com/', '1', '1421312780');
INSERT INTO `web_supplier` VALUES ('291', 'Skinlover', '0947639522', '0933584286', 'anhnguyen1512@gmail.com', 'http://skinlovers.vn/', '1', '1421735897');
INSERT INTO `web_supplier` VALUES ('292', 'Shoptretho', '0982120066', '0982120066', 'cskh.shoptretho@gmail.com', 'https://shoptretho.vn/', '1', '1421739865');
INSERT INTO `web_supplier` VALUES ('293', 'Eveline', '0982988298', '0933584286', 'trieuvi.bui@gmail.com', 'http://eveline.vn/', '1', '1421913479');
INSERT INTO `web_supplier` VALUES ('294', 'Nhà hàng Ý Mondo', '0989 130 876', '0989 130 876', 'linh.nt@mondogroup.vn', 'www.mondo.vn', '1', '1421918149');
INSERT INTO `web_supplier` VALUES ('295', 'HONG SHUAN Co..Ltd', '08 66 836 813', '098 636 9133', 'hongshuan@hongshuan.com', 'www.hongshuan.com', '1', '1422266904');
INSERT INTO `web_supplier` VALUES ('296', 'Công ty TNHH Thế Giới Huy Hoàng', '091.654.0404', '0938 515 404', 'thegioihuyhoang@gmail.com', 'http://www.casauhuyhoang.com', '1', '1422349576');
INSERT INTO `web_supplier` VALUES ('297', 'ZPizza', '043 719 5959', '', 'trangtth@zpizza.vn', 'http://www.zpizza.vn/products-lang-vn-place--active_food-156-food_id-145.htm', '1', '1422497975');
INSERT INTO `web_supplier` VALUES ('298', 'Bệnh viện đa khoa quốc tế Thu Cúc', '04 383 55555', '0964080999', 'tuvan@thucuchospital.vn', 'http://thammythucuc.vn/', '1', '1423124984');
INSERT INTO `web_supplier` VALUES ('299', 'Royal Baby Việt Nam', '0987.557.575', '0987.557.575', 'skh.royalbike@gmail.com', 'http://xedaphoanggia.com', '1', '1423191538');
INSERT INTO `web_supplier` VALUES ('300', 'Công ty Cổ phần vàng bạc đá quý Phú Nhuận', '08 3995 9336', '08 3995 9336', 'pnj@pnj.com.vn', 'www.shopping.pnj.com.vn', '1', '1423290085');
INSERT INTO `web_supplier` VALUES ('301', 'Trộm vía', '0978 197 124', '098.212.0066', 'hoangthaont35@gmail.com', 'http://tromvia.com/', '1', '1423452010');
INSERT INTO `web_supplier` VALUES ('302', 'Thế giới hải sản', '0987728085', '090 448 2626', 'nhahangsieuthithegioihaisan@gmail.com', 'thegioihaisan.vn', '1', '1425543650');
INSERT INTO `web_supplier` VALUES ('303', 'Du thuyền Bhaya', '0919744141', '0933 446 542', 'sales@bhayacruises.com', 'www.bhayacruises.com/', '1', '1425613851');
INSERT INTO `web_supplier` VALUES ('304', 'CÔNG TY CỔ PHẦN MAY NANIO', '3845 6785', '0913 978 665', 'congtynanio@gmail.com', 'www.nanio.vn', '1', '1425629023');
INSERT INTO `web_supplier` VALUES ('305', 'Nhà Hàng Moo Beef Steak', '0932342979', '0932342979', 'hiepmbs72nt@gmail.com', 'http://moobeefsteak.com.vn', '1', '1425958888');
INSERT INTO `web_supplier` VALUES ('306', 'techdemo', '0904488733', '', 'tlkit158@gmail.com', '', '1', '1425959440');
INSERT INTO `web_supplier` VALUES ('313', 'Thương hiệu Mommy', '0989343340', '0946868080', 'nguyenminhhai.fm@gmail.com', 'http://mommy.vn', '1', '1425975479');
INSERT INTO `web_supplier` VALUES ('314', 'Saigon Smile Spa', '0919.34.1881', '', 'caring@saigonsmilespa.com.vn', 'saigonsmilespa.com.vn', '1', '1426562561');
INSERT INTO `web_supplier` VALUES ('315', 'Nhà hàng Shinbashi', '0936686562', '', 'shinbashikt214@gmail.com', 'http://www.shinbashi.com.vn', '1', '1426652548');
INSERT INTO `web_supplier` VALUES ('316', 'Nhà hàng Ao Ta', '0976989739', '', 'trangtq@aota.com.vn', 'http://aota.com.vn', '1', '1427959907');
INSERT INTO `web_supplier` VALUES ('317', 'Nhà hàng Á Gia', '09032.33339', '0968.223583', 'duyvietkfbs@gmail.com', 'agia.com.vn', '1', '1429672758');
INSERT INTO `web_supplier` VALUES ('318', 'Bếp từ nhập khẩu Rovigo - Italia', '0915981199', '0942086699', 'info@rovigo-italy.vn', 'www.rovigo-italy.vn', '1', '1430734230');
INSERT INTO `web_supplier` VALUES ('348', 'Công ty TNHH Thương mại và Đầu tư Gia Phú', '0962285304', '0962285304', 'vantoan89bn@gmail.com', null, '1', '1431317425');
INSERT INTO `web_supplier` VALUES ('349', 'CÔNG TY CỔ PHẦN QUỐC TẾ THIÊN ANH', '043 563 8733', '043 563 8733', 'lethuanbluecom@gmail.com', null, '1', '1431334069');
INSERT INTO `web_supplier` VALUES ('350', 'Lovely Korea Beauty Premium', '0984650538', '0984650538', 'nguyentrongcuong.mba@gmail.com', 'http://lovelykorea.com.vn/', '1', '1431334111');
INSERT INTO `web_supplier` VALUES ('351', 'Lê Công Tài - Nguyễn Thị Trà', '0968223223', '0968223223', 'lecongtai_1987@yahoo.com', null, '1', '1431404222');
INSERT INTO `web_supplier` VALUES ('352', 'Đồ gia dụng Magic One', '04.85855952', '04.85855952', 'magicone.vn@gmail.com', 'http://magicone.vn/page/gioithieu/5', '1', '1431430341');
INSERT INTO `web_supplier` VALUES ('353', 'Sanosan - Chan chứa tình mẹ', '04. 37281440', '04. 37281440', 'contact@zinniadistribution.vn', 'http://sanosan.vn/ve-sanosan/', '1', '1431430755');
INSERT INTO `web_supplier` VALUES ('354', 'Vương quốc trẻ thơ - Kid\'s Kingdom', '0976925208', '0976925208', 'Kidskingdom2010@gmail.com', 'http://kidskingdom.vn/index.php/vi/gioi-thieu/thu-ngo', '1', '1431431563');
INSERT INTO `web_supplier` VALUES ('355', 'Đồ chơi Toptoys', '0947.144.921', '0947.144.921', 'congluan@tanthuanduc.com', '', '1', '1431431740');
INSERT INTO `web_supplier` VALUES ('356', 'Nội thất cao cấp Koenic', '0968922296', '0968922296', 'thuydt@huratech.com', '', '1', '1431435036');
INSERT INTO `web_supplier` VALUES ('357', 'CÔNG TY TNHH MỘT THÀNH VIÊN CORA FOOD & BEVERAGE', '0438215555', '0438215555', 'coracafe.vn@gmail.com', null, '1', '1431483555');
INSERT INTO `web_supplier` VALUES ('358', 'Công ty TNHH Thực Phẩm Khánh Long', '(04) 3 627 8866- 096', '(04) 3 627 8866- 096', 'khanhlongfood@gmail.com', null, '1', '1431488125');
INSERT INTO `web_supplier` VALUES ('359', 'Shop Hàn Quốc', '0983386887', '0983386887', '', null, '1', '1431494128');
INSERT INTO `web_supplier` VALUES ('360', 'CÔNG TY CỔ PHẦN ĐẦU TƯ VÀ KINH DOANH THƯƠNG MẠI HA', '0439746403', '0439746403', 'thinhbd@haneltrading.com.vn', null, '1', '1431505419');
INSERT INTO `web_supplier` VALUES ('361', 'CÔNG TY CỔ PHẦN TẬP ĐOÀN SUNHOUSE', '0439746403', '0439746403', 'anhpd@sunhouse.com.vn', '', '0', '1431506246');
INSERT INTO `web_supplier` VALUES ('362', 'Công ty cổ phần thương mại quốc tế Phú Sỹ', '0983663319', '0983663319', '', null, '1', '1431506459');
INSERT INTO `web_supplier` VALUES ('363', 'Plan Do See Việt Nam', '0942 907 077', '0942 907 077', 'quannh@plandosee.com.vn', 'http://plandosee.com.vn/vi.html', '1', '1431591659');
INSERT INTO `web_supplier` VALUES ('364', 'CÔNG TY TNHH SX &TM Minh Thảo', '0984444433', '0984444433', 'minhthao3d@gmail.com', null, '1', '1431593857');
INSERT INTO `web_supplier` VALUES ('365', 'THẾ GIỚI ĐẤT NẶN DOH-WORLD', '01236113689', '01236113689', 'nguyenquanganh@thegioidatnan.com', '', '1', '1431595668');
INSERT INTO `web_supplier` VALUES ('366', 'Phú Gia Trading', '0988818843', '0988818843', 'phamduy@phugiatrading.com.vn', '', '1', '1431663658');
INSERT INTO `web_supplier` VALUES ('367', 'CÔNG TY TNHH VẬT TƯ THIẾT BỊ KỸ THUẬT VIỆT LONG', '0984 849 236', '0984 849 236', 'Dinhxuanhao.vietlong@gmail.com', null, '1', '1431922545');
INSERT INTO `web_supplier` VALUES ('368', 'Đồ gia dụng thông minh Facare', '0946 693 281', '0946 693 281', 'tieulan80@yahoo.com', 'http://www.coluami.vn/', '1', '1431933464');
INSERT INTO `web_supplier` VALUES ('370', 'CÔNG TY TNHH Công nghệ Giải pháp phần mềm GP', '0943881700', '0943881700', 'halampard@gmail.com', null, '1', '1432009725');
INSERT INTO `web_supplier` VALUES ('371', 'Công ty TNHH TBCS Y tế Đại gia đình Phương Đông', '0435738311', '0435738311', '', null, '1', '1432020181');
INSERT INTO `web_supplier` VALUES ('372', 'Khoa học và kỹ thuật Bách khoa', '0983640844', '0983640844', 'hn@gmail.com', '', '1', '1432024288');
INSERT INTO `web_supplier` VALUES ('373', 'KM Việt Nam', '0976800825', '0976800825', 'km@kmcosmetic.com', 'http://kmcosmetic.com/gioi-thieu.html', '1', '1432092958');
INSERT INTO `web_supplier` VALUES ('374', 'Shop Bảo Hân.net', '0975 656 558', '0975 656 558', '', null, '1', '1432112296');
INSERT INTO `web_supplier` VALUES ('375', 'Công ty CP Sản xuất và TMDV Picker', '0904 791 065', '0904 791 065', '', null, '1', '1432121466');
INSERT INTO `web_supplier` VALUES ('376', 'Vegionbiotech', '01649614250', '01649614250', '', null, '1', '1432179985');
INSERT INTO `web_supplier` VALUES ('377', 'CÔNG TY CỔ PHẦN ELMICH', '0916 57 3883', '0916 57 3883', 'minhngoc.nguyen@elmich.vn', null, '1', '1432291455');
INSERT INTO `web_supplier` VALUES ('378', 'AIME Việt Nam', '0943300677', '0943300677', 'f', '', '1', '1432299529');
INSERT INTO `web_supplier` VALUES ('386', 'CÔNGTY CỔ PHẦN KỸ THUẬT CÔNG TRÌNH THANH PHÚC', 'Tel : 04.3646.2166', 'Tel : 04.3646.2166', 'dinh.thanhphucjsc@gmail.com', null, '1', '1432351997');
INSERT INTO `web_supplier` VALUES ('387', 'Dr Brown\'s', '0987757886', '0987757886', 'huy.focushn@gmail.com', 'http://www.drbrowns.com.vn/', '1', '1432356421');
INSERT INTO `web_supplier` VALUES ('388', 'Orico', '0972 833 807', '0972 833 807', 'xuandatpt@gmail.com', 'http://linaco.vn', '1', '1432521162');
INSERT INTO `web_supplier` VALUES ('389', 'Sữa Celia', '04629608888', '04629608888', 'info@ceia.vn', '', '1', '1432523443');
INSERT INTO `web_supplier` VALUES ('390', 'Remax', '0988068881', '0988068881', 'jno.kool@gmail.com', 'iremax.vn', '1', '1432524697');
INSERT INTO `web_supplier` VALUES ('391', 'Công ty TNHH Humana Việt Nam', '0979 400 888', '0979 400 888', 'chuc.dominh@huamana.com.vn', null, '1', '1432613517');
INSERT INTO `web_supplier` VALUES ('392', 'CTY TNHH THƯƠNG MẠI VÀ TƯ VẤN MINH ANH', '043 5377935', '043 5377935', 'info@minhanhltd.com', null, '1', '1432715438');
INSERT INTO `web_supplier` VALUES ('393', 'CÔNG TY CỔ PHẦN XUẤT NHẬP KHẨU THƯƠNG MẠI ĐÀI LINH', '04.3538 1818', '04.3538 1818', '', null, '1', '1432720988');
INSERT INTO `web_supplier` VALUES ('394', 'CTY TNHH Aimica Việt Nam', '0866818862', '0838639033', 'rs503.micavn@gmail.com', 'www.i-mica.com.vn', '1', '1432783333');
INSERT INTO `web_supplier` VALUES ('395', 'CTY TNHH TM DV Tin Học BNI', '0839225733', '0839225733', '', null, '1', '1432790757');
INSERT INTO `web_supplier` VALUES ('396', 'CÔNG TY TNHH THƯƠNG MẠI DỊCH VỤ KHƯƠNG VIỆT', '0838685800', '0838685800', '', null, '1', '1432791024');
INSERT INTO `web_supplier` VALUES ('397', 'APOLLO', '0987234568', '0987234568', '', null, '1', '1432791836');
INSERT INTO `web_supplier` VALUES ('398', 'Công ty TNHH Thương Mại Dịch Vụ Phúc Hải', '0', '0', '', null, '1', '1432798683');
INSERT INTO `web_supplier` VALUES ('399', 'Công Ty Cổ Phần Điện Thoại Di Động Thành Công ( Th', '0839901199', '0839901199', 'sale@thanhcongmobile.com', null, '1', '1432800204');
INSERT INTO `web_supplier` VALUES ('400', 'CÔNG TY TNHH KỸ THUẬT ICOOL', '0862515671', '0862515671', 'ndang.khoa90@gmail.com', null, '1', '1432830044');
INSERT INTO `web_supplier` VALUES ('401', 'Công Ty TNHH Một Thành Viên Kỹ Thuật Và Khoa Học O', '1800577776', '1800577776', '', null, '1', '1432870353');
INSERT INTO `web_supplier` VALUES ('402', 'Công ty TNHH TMDV XNK Tân Ngôi Sao May Mắn', '0839778983, 08384684', '0839778983, 08384684', '', null, '1', '1432870840');
INSERT INTO `web_supplier` VALUES ('403', 'CÔNG TY TNHH MỘT THÀNH VIÊN THƯƠNG MẠI DỊCH VỤ XUẤ', '0', '0', '', null, '1', '1432871266');
INSERT INTO `web_supplier` VALUES ('404', 'Công ty Cổ phần Hội tụ Thông minh', '0839105566', '0839105566', 'info@smartcom.com.vn', null, '1', '1432871785');
INSERT INTO `web_supplier` VALUES ('405', 'DIGIWORLD', '08.39290059', '08.39290059', '', '', '1', '1432872212');
INSERT INTO `web_supplier` VALUES ('406', 'CÔNG TY TNHH MỘT THÀNH VIÊN THƯƠNG MẠI ÔNG VUA SỐ', 'o', 'o', '', null, '1', '1432873107');
INSERT INTO `web_supplier` VALUES ('407', 'Goodhealth', '0437264222', '0437264222', 'info@goodhealth.com.vn', '', '1', '1432884077');
INSERT INTO `web_supplier` VALUES ('408', 'Công ty Cổ phần Masscom Việt Nam', '0835171250', '0835171250', '', null, '1', '1432961463');
INSERT INTO `web_supplier` VALUES ('409', 'CÔNG TY CỔ PHẦN ĐẦU TƯ LÊ BẢO MINH', '(08) 3838 6666', '(08) 3838 6666', 'info@lebaominh.vn', null, '1', '1433130892');
INSERT INTO `web_supplier` VALUES ('411', 'AHANKEN ASIA CO., LTD', '0908770438', '0908770438', '', null, '1', '1433301403');
INSERT INTO `web_supplier` VALUES ('412', 'Made in USA', '0908669797', '0908669797', '', null, '1', '1433302600');
INSERT INTO `web_supplier` VALUES ('413', 'CÔNG TY CỔ PHẦN PHÂN PHỐI SẢN PHẨM CÔNG NGHỆ CAO D', '083910 7979', '083910 7979', '', null, '1', '1433305192');
INSERT INTO `web_supplier` VALUES ('414', 'NHÀ HÀNG SỨ BUFFET', '04 39413338', '04 39413338', '', null, '1', '1433321161');
INSERT INTO `web_supplier` VALUES ('415', 'Cty CP Aqua Sportswear', '0903857358', '0903857358', '', null, '1', '1433403057');
INSERT INTO `web_supplier` VALUES ('416', 'Tân Phạm Gia', '0903927607', '0903927607', '', null, '1', '1433403130');
INSERT INTO `web_supplier` VALUES ('417', 'Bình Tiên Đồng Nai', '0908303027', '0908303027', '', null, '1', '1433403182');
INSERT INTO `web_supplier` VALUES ('418', 'M.M', '0903332556', '0903332556', '', null, '1', '1433403290');
INSERT INTO `web_supplier` VALUES ('419', 'Cty TNHH MTV SXTM Trường Thắng', '01672488929', '01672488929', '', null, '1', '1433403354');
INSERT INTO `web_supplier` VALUES ('420', 'Cửa hàng Depkool', '01672488929', '01672488929', '', null, '1', '1433403412');
INSERT INTO `web_supplier` VALUES ('421', 'CP Thời Trang Kowil VN S', '0909 533 777', '0909 533 777', '', null, '1', '1433403452');
INSERT INTO `web_supplier` VALUES ('422', 'Công ty TNHH thiết bị y tế Minh Khoa', '0862925655', '0862925655', '', null, '1', '1433407946');
INSERT INTO `web_supplier` VALUES ('423', 'Công ty Cổ phần Thương hiệu Quốc tế', '0982201174', '0982201174', 'tamnm@ibcgroup.com.vn', null, '1', '1433409956');
INSERT INTO `web_supplier` VALUES ('424', 'Cty CP Công Nghệ Viễn Thông Phúc Thịnh', '0938905838 - 0934311', '0938905838 - 0934311', 'thangnguyen@phucthinhgroup.vn', null, '1', '1433410818');
INSERT INTO `web_supplier` VALUES ('425', 'Chi nhánh Cty TNHH Syn Style', '0904717973 Chị Hạnh ', '0904717973 Chị Hạnh ', '', null, '1', '1433411111');
INSERT INTO `web_supplier` VALUES ('426', 'Cty TNHH Mậu Đạt', '0902775175', '0902775175', '', null, '1', '1433411243');
INSERT INTO `web_supplier` VALUES ('427', 'Cty Thương Mại Dịch Vụ XNK Nam Tiên', '0913401543', '0913401543', '', null, '1', '1433411303');
INSERT INTO `web_supplier` VALUES ('428', 'Cty TNHH MTV Thiên Sao Kim', '0938644913 Mr Quân -', '0938644913 Mr Quân -', '', null, '1', '1433411387');
INSERT INTO `web_supplier` VALUES ('429', 'Cty TNHH Sản Xuất TMDV XNK Song Tấn', '0918436655', '0918436655', 'quocbao@sotapc.com', null, '1', '1433411458');
INSERT INTO `web_supplier` VALUES ('430', 'Cty TNHH TMDV Kỹ Thuật Viễn Thoại', '0918177474 Ms Mai - ', '0918177474 Ms Mai - ', 'vienthoaico.ltd@gmail.com', null, '1', '1433411553');
INSERT INTO `web_supplier` VALUES ('431', 'Công ty CP Xuất Nhập Khẩu và Thương Mại MANIGO', '0466879393', '0466879393', '', null, '1', '1433434893');
INSERT INTO `web_supplier` VALUES ('432', 'Cty TNHH P.N.I', '090 2455 597', '090 2455 597', '', null, '1', '1433469357');
INSERT INTO `web_supplier` VALUES ('433', 'Cty CP May BÌNH MINH', '0909977179', '0909977179', '', null, '1', '1433469418');
INSERT INTO `web_supplier` VALUES ('434', 'CÔNG TY TNHH KHÔNG GIAN CÔNG NGHỆ', '0838424517', '0838424517', 'sales.executive@techmate.vn', null, '1', '1433473068');
INSERT INTO `web_supplier` VALUES ('435', 'Thời trang Allura', '0438525188', '0438525188', 'vynm@yahoo.com', '', '1', '1433474112');
INSERT INTO `web_supplier` VALUES ('436', 'Công ty TNHH Phát triển thương mại và dịch vụ Nam ', '0961005518', '0961005518', 'nguyenson.nt93@gmail.com', null, '1', '1433479732');
INSERT INTO `web_supplier` VALUES ('437', 'Cty TNHH TM DV Phân Phối Phú An Gia', '0916611072', '0916611072', '', null, '1', '1433491677');
INSERT INTO `web_supplier` VALUES ('438', 'Yêu Sống', '0906 025 016', '0906 025 016', 'duc.ntm@spsvietnam.com', '', '1', '1433506567');
INSERT INTO `web_supplier` VALUES ('439', 'Công ty cổ phần đầu tư phát triển Vĩnh Phát', '0919 268 269', '0919 268 269', 'nguyenchithanh.hypt@gmail.com', null, '1', '1433682846');
INSERT INTO `web_supplier` VALUES ('440', 'Công ty TNHH Một Thành Viên Yến Sào Tâm Yến', '0916664118', '0916664118', 'duccanh1810@gmail.com', null, '1', '1433738234');
INSERT INTO `web_supplier` VALUES ('441', 'Công ty TNHH Gia Huy', '0907044018', '0907044018', '', null, '1', '1433827479');
INSERT INTO `web_supplier` VALUES ('442', 'Công ty TNHH Phạm', '04.373.22.189', '04.373.22.189', 'phamltdco@gmail.com', null, '1', '1433843367');
INSERT INTO `web_supplier` VALUES ('443', 'Comet Việt Nam', '0436341688', '0436341688', '0436341688@gmail.com', '', '1', '1433845041');
INSERT INTO `web_supplier` VALUES ('444', 'Chị Nhàn', '0914608688', '0914608688', 'monngonmientay@gmail.com', null, '1', '1433932192');
INSERT INTO `web_supplier` VALUES ('445', 'Công ty TNHH Thương mại Xuất nhập khẩu Đức Sơn', '6416448', '6416448', '', null, '1', '1433989012');
INSERT INTO `web_supplier` VALUES ('446', 'Test Công ty CP VALUE', '0912326698', '0912326698', '', null, '1', '1433989516');
INSERT INTO `web_supplier` VALUES ('447', 'Công ty TNHH Một Thành Viên Yến Sào Tâm Yến', '0916664118', '0916664118', 'ducanh1810@gmail.com', null, '1', '1434007585');
INSERT INTO `web_supplier` VALUES ('448', 'Thời trang ALIZA', '0912906926', '0912906926', 'anhphuong1973@gmail.com', '', '1', '1434010399');
INSERT INTO `web_supplier` VALUES ('449', 'CÔNG TY TNHH PHÂN PHỐI SNB', '04.39335399', '04.39335399', '', null, '1', '1434011539');
INSERT INTO `web_supplier` VALUES ('450', 'Vivitoys', '0908293866', '0908293866', 'anhtm.vivitoys@gmail.com', 'http://vivitoy.com/', '1', '1434027044');
INSERT INTO `web_supplier` VALUES ('451', 'X.L VIET NAM', '0918.65.85.92 - 0919', '0918.65.85.92 - 0919', 'xlvietnam68@gmail.com', '', '1', '1434168224');
INSERT INTO `web_supplier` VALUES ('452', 'CÔNG TY CỔ PHẦN PHÁT TRIỂN NHÀ BẮC TRUNG NAM', '0122 580 2223', '0122 580 2223', '', null, '1', '1434185310');
INSERT INTO `web_supplier` VALUES ('453', 'OSAKA', '08.9707.257/258', '08.9707.257/258', '', '', '1', '1434360653');
INSERT INTO `web_supplier` VALUES ('454', 'Công Ty TNHH CB JAPAN VIỆT NAM', '0975 70 1518​', '0975 70 1518​', 'linh.cbjapan@gmail.com', null, '1', '1434429098');
INSERT INTO `web_supplier` VALUES ('455', 'MamanBébé', '0915918893', '0915918893', 'Hoai.lt@mamanbebe.vn', null, '1', '1434443179');
INSERT INTO `web_supplier` VALUES ('456', 'Công ty TNHH Glocal Kim', '04.378.36.150', '04.378.36.150', 'khanhly.gk@gmail.com', null, '1', '1434447736');
INSERT INTO `web_supplier` VALUES ('457', 'CÔNG TY TNHH TRÀ XANH FUJI', '08 7309 0949 - 09142', '08 7309 0949 - 09142', 'bottraxanh@gmail.com', null, '1', '1434513390');
INSERT INTO `web_supplier` VALUES ('458', 'CÔNG TY CỔ PHẦN ĐẦU TƯ LIÊN KẾT TƯƠNG LAI', '0939333191', '0939333191', 'thamcao@futurelink.com.vn', null, '1', '1434513736');
INSERT INTO `web_supplier` VALUES ('459', 'GOLDDAY Việt Nam', '0963 750 296', '0963 750 296', 'bachphuong@goldday.vn', '', '1', '1434679768');
INSERT INTO `web_supplier` VALUES ('460', 'Thời trang Busaba', '01675.078.060', '01675.078.060', 'Busaba.thailan@gmail.com', 'http://busabashop.com/', '1', '1435037532');
INSERT INTO `web_supplier` VALUES ('461', 'Beautee collagen', '093 221 6466', '093 221 6466', 'vananh@nhatanhcorp.vn', '', '1', '1435070511');
INSERT INTO `web_supplier` VALUES ('462', 'Công ty TNHH TM &amp; DV Phân Phối Ánh Dương', '043.9413145', '043.9413145', 'info@phanphoianhduong.com.vn', '', '1', '1435560512');
INSERT INTO `web_supplier` VALUES ('463', 'CÔNG TY TNHH AN GIA TIẾN', '08. 3930 7278', '08. 3930 7278', 'angiatien@angiatien.com', null, '1', '1435579419');
INSERT INTO `web_supplier` VALUES ('464', 'Donlim', '0838230611', '0838230611', 'lvdha@fimexco.com.vn', '', '1', '1435583083');
INSERT INTO `web_supplier` VALUES ('465', 'CÔNG TY TNHH THƯƠNG MẠI VẠN AN', '(04) 3 8626345', '(04) 3 8626345', '', null, '1', '1435891777');
INSERT INTO `web_supplier` VALUES ('466', 'Butnon', '0984 882 352', '04 372 62 072', 'phi41290@gmail.com', 'http://butnon.com.vn/', '1', '1436155811');
INSERT INTO `web_supplier` VALUES ('467', 'Tường phi', '08.38100912', '08.38100912', 'bodetour@yahoo.com', '', '1', '1436254253');
INSERT INTO `web_supplier` VALUES ('468', 'CÔNG TY TNHH THƯƠNG MẠI VÀ DỊCH VỤ M.U.C VIỆT NAM', '0462.973.973', '0462.973.973', '', null, '1', '1436322727');
INSERT INTO `web_supplier` VALUES ('469', 'Tupperware Việt Nam', '0974 071 294', '0974 071 294', 'languidevn@gmail.com', '', '1', '1436323320');
INSERT INTO `web_supplier` VALUES ('470', 'Dunamex', '04 35120393', '04 35120393', 'info@dunamex.vn', 'http://dunamex.vn/?go=PageSingleContent&amp;igid=889', '1', '1436325047');
INSERT INTO `web_supplier` VALUES ('471', 'Máy lọc nước Karofi', '0911109000', '0911109000', 'maylocnuocduynam@gmail.com', 'http://maylocnuocduynam.vn/', '1', '1436332788');
INSERT INTO `web_supplier` VALUES ('501', 'Blacker', '0839231923', '0839231923', 'sales@blacker.com.vn', 'http://www.blacker.com.vn', '1', '1436414674');
INSERT INTO `web_supplier` VALUES ('502', 'Midea', '0838165839', '0838165839', 'nguyenthuc1608@gmail.com', '', '1', '1436414874');
INSERT INTO `web_supplier` VALUES ('503', 'Quạt điện cao cấp Nhật Bản', '0838272783', '0838272783', 'sales@knkvietnam.com.vn', 'http://kdk.com.vn/vi/gioi-thieu-cong-ty_a1', '1', '1436544756');
INSERT INTO `web_supplier` VALUES ('504', 'BBcooker', '046 297 2345', '046 297 2345', 'vanthanh@bbcooker.vn', 'http://bbcooker.vn', '1', '1436850373');
INSERT INTO `web_supplier` VALUES ('505', 'Hệ Thống POPO.VN', '0989555126', '0989555126', 'hethongpopo@gmail.com', null, '1', '1436947149');
INSERT INTO `web_supplier` VALUES ('506', 'Công ty TNHH  Đông Dương Sài Gòn', '090.222.3773', '090.222.3773', 'tm10@saigonindochina.com', null, '1', '1437014758');
INSERT INTO `web_supplier` VALUES ('507', 'Mỹ phẩm MAIKA', '0907290189', '0907290189', 'maibui@myphammaika.vn', '', '1', '1437361079');
INSERT INTO `web_supplier` VALUES ('508', 'Công ty TNHH STD Quốc Tế', '0973.862.491', '0973.862.491', '', null, '1', '1437466868');
INSERT INTO `web_supplier` VALUES ('509', 'CÔNG TY CỔ PHẦN GOLDSUN VIỆT NAM', '0437658111', '0437658111', '', null, '1', '1437475920');
INSERT INTO `web_supplier` VALUES ('510', 'Microlife', '(08) 353 99 709 – 35', '(08) 353 99 709 – 35', 'info@biomeq.com.vn', 'http://www.microlifevn.com', '1', '1437535262');
INSERT INTO `web_supplier` VALUES ('511', 'True Blue', '04.35406572', '04.35406572', 'a', '', '1', '1437559671');
INSERT INTO `web_supplier` VALUES ('512', 'Eurohome', '(04).6275.2488', '(04).6275.2488', 'luongvt@eurovision.com.vn', '', '1', '1437560083');
INSERT INTO `web_supplier` VALUES ('513', 'Ucomen', '(08) 6264 7573', '(08) 6264 7573', 'info@openmize.com', '', '1', '1437619319');
INSERT INTO `web_supplier` VALUES ('514', 'Công ty TNHH Thương mại và đầu tư Xuân Anh', '0978341289', '0978341289', '', null, '1', '1438053686');
INSERT INTO `web_supplier` VALUES ('515', 'Carnaval Restaurants', '0901.795.658', '0901.795.658', 'nhahangcarnaval@gmail.com', '', '1', '1438143929');
INSERT INTO `web_supplier` VALUES ('516', 'CÔNG TY CỔ PHẦN ĐẦU TƯ  & PHÁT TRIỂN THƯƠNG MẠI VI', '0982.936.344', '0982.936.344', 'media@faster.vn', null, '1', '1438222251');
INSERT INTO `web_supplier` VALUES ('517', 'Justin House', '0838590189', '0838590189', 'kieu.banh@kimsoncorp.com', '', '1', '1438225313');
INSERT INTO `web_supplier` VALUES ('518', 'BEESMART', '0862819177', '0862819177', 'Infor@beesmart.vn', '', '1', '1438229607');
INSERT INTO `web_supplier` VALUES ('519', 'CHI NHÁNH CÔNG TY CỔ PHẦN BÓNG ĐÈN PHÍCH NƯỚC RẠNG', '0837545233', '0837545233', 'duan.rangdong@gmail.com', null, '1', '1438229836');
INSERT INTO `web_supplier` VALUES ('520', 'Gali', '083517008', '083517008', 'thuky_pkd@gali.com.vn', '', '1', '1438230727');
INSERT INTO `web_supplier` VALUES ('521', 'La Cell', '0905198333', '0905198333', 'nguyenhangdoantrinh@gmail.com', '', '1', '1438232923');
INSERT INTO `web_supplier` VALUES ('522', 'CÔNG TY CỔ PHẦN THƯƠNG MẠI CARPA VIỆTvNAM', '0462552288', '0462552288', '', null, '1', '1438599697');
INSERT INTO `web_supplier` VALUES ('523', 'RoyalCooks', '0466753579', '0466753579', 'giapnt@royalcooks.vn', '', '1', '1438656225');
INSERT INTO `web_supplier` VALUES ('524', 'Vivantjoie', '090 222 1358', '090 222 1358', '', '', '1', '1438668933');
INSERT INTO `web_supplier` VALUES ('525', 'CỔ PHẦN VÀ SẢN XUẤT VÀ THƯƠNG MẠI A2T', '0973858933', '0973858933', '', null, '1', '1438669651');
INSERT INTO `web_supplier` VALUES ('526', 'Beer &amp; Barrel', '08 39 333 345', '08 39 333 345', 'infor@beerandbarrel.com.vn', '', '1', '1438689968');
INSERT INTO `web_supplier` VALUES ('527', 'Pisen', '0862651266', '0862651266', 'tranthihienna@gamek.vn', '', '1', '1438751469');
INSERT INTO `web_supplier` VALUES ('528', 'Triumph Việt Nam', '0904.431.222', '0904.431.222', 'promotion-info.vietnam@triumph.com', '', '1', '1438758391');
INSERT INTO `web_supplier` VALUES ('529', 'Chuchu Baby', '0987.207.642', '0987.207.642', 'ngthuynga.nd@gmail.com', '', '1', '1438848285');
INSERT INTO `web_supplier` VALUES ('530', 'NH Ấn Độ Spice India', '0908471776', '0908471776', 'spiceindia.dist1@gmail.com', null, '1', '1439002394');
INSERT INTO `web_supplier` VALUES ('531', 'Teka', '0466.812.901', '0466.812.901', 'elegantluxury484@gmail.com', '', '1', '1439007564');
INSERT INTO `web_supplier` VALUES ('547', 'Gunners &amp; Western', '838162854', '838162854', 'nguyenthuc1608@gmail.com -1', '', '1', '1439282201');
INSERT INTO `web_supplier` VALUES ('548', 'Chanli Spa', '0965911818', '0965911818', 'chanlispa@yahoo.com', '', '1', '1439287059');
INSERT INTO `web_supplier` VALUES ('549', 'Spa Tropic', '0908138546', '0908138546', 'minhtam1.spa@gmail.com', '', '1', '1439355817');
INSERT INTO `web_supplier` VALUES ('550', 'NGUYỄN THỊ CHÂU', '0908138545', '0908138545', 'minhtam.spa@gmail.com', null, '1', '1439356187');
INSERT INTO `web_supplier` VALUES ('551', 'Moen', '04.3987.6740', '04.3987.6740', 'info@thietbivesinh123.com', '', '1', '1439370289');
INSERT INTO `web_supplier` VALUES ('552', 'CÔNG TY TNHH MTV NHÀ HÀNG TRƯỜNG THỊNH', '38242411', '38242411', 'tbminh12@gmail.com', null, '1', '1439435018');
INSERT INTO `web_supplier` VALUES ('553', 'CÔNG TY TNHH ĐẦU TƯ PETRO ELECTRIC VIỆT NAM', '0919118255', '0919118255', 'sactotvn@gmail.com', null, '1', '1439438557');
INSERT INTO `web_supplier` VALUES ('554', 'Công Ty TNHH Mỹ Phẩm Hankyung Việt Nam', '04.3974.9724', '04.3974.9724', 'info@itsskin.com.vn', null, '1', '1439439440');
INSERT INTO `web_supplier` VALUES ('555', 'Chính Hãng FPT', '04 7300 6666', '04 7300 6666', 'fpt_trading@fpt.com.vn', '', '1', '1439536492');
INSERT INTO `web_supplier` VALUES ('556', 'Beurer', '04 35773151', '04 35773151', 'info@thietbiyte-eu.vn', '', '1', '1439784352');
INSERT INTO `web_supplier` VALUES ('557', 'Ohi@ma', '0838031661 - 0862941', '0838031661 - 0862941', 'hoamai54@yahoo.com', '', '1', '1439874410');
INSERT INTO `web_supplier` VALUES ('558', 'TCL', '04.32484627', '04.32484627', 'thienhoanglong868@gmail.com', '', '1', '1439891012');
INSERT INTO `web_supplier` VALUES ('559', 'Mattana', '04.3533 4853', '04.3533 4853', '', '', '1', '1439952672');
INSERT INTO `web_supplier` VALUES ('560', 'Phụ kiện Samsung', '01233698888', '01233698888', 'phongdd@itvn.vn', '', '1', '1439953016');
INSERT INTO `web_supplier` VALUES ('561', 'Nhà Hàng Chay 3 Lá', '(08) 6683 0303', '(08) 6683 0303', 'nguyentonhoangdung77@gmail.com', '', '1', '1439956821');
INSERT INTO `web_supplier` VALUES ('562', 'Yến Sào Sài Gòn Anpha', '0838300980', '0838300980', 'trolygddh.anpha@gmail.com', '', '1', '1440045467');
INSERT INTO `web_supplier` VALUES ('563', 'Tiross', '(08) 3995 3597', '(08) 3995 3597', 'phanle0928@gmail.com', '', '1', '1440065304');
INSERT INTO `web_supplier` VALUES ('564', 'NHA KHOA BẠCH KIM', '( 84.8) 3920.99.69', '( 84.8) 3920.99.69', 'drnhan@nhakhoaplatinum.com', '', '1', '1440217846');
INSERT INTO `web_supplier` VALUES ('565', 'NHA KHOA BẠCH KIM', '( 84.8) 3920.99.69', '( 84.8) 3920.99.69', 'drnhan@nhakhoaplatinum.com', null, '1', '1440217999');
INSERT INTO `web_supplier` VALUES ('566', 'Salon Hiếu Trang', '01203888666', '01203888666', 'hieutranghp363@gmail.com', '', '1', '1440400714');
INSERT INTO `web_supplier` VALUES ('567', 'CB Japan', '04.32.00.99.70', '04.32.00.99.70', 'tthuong90@gmail.com', '', '1', '1440467530');
INSERT INTO `web_supplier` VALUES ('568', 'CÔNG TY TNHH NHÀ HÀNG KHÁCH SẠN VÀ DU LỊCH VĨNH AN', '( 84) 85404 2220', '( 84) 85404 2220', '', null, '1', '1440473130');
INSERT INTO `web_supplier` VALUES ('569', 'Nhà Hàng Chay Om Mani Padme Hum', '(08) 3837 5613 - 090', '(08) 3837 5613 - 090', 'chungnguyenom@gmail.com', '', '1', '1440480026');
INSERT INTO `web_supplier` VALUES ('570', 'Frezzii', '2345', '0437264222', '123', '', '1', '1440659280');
INSERT INTO `web_supplier` VALUES ('571', 'CÔNG TY TNHH MR DEE', '0913714352', '0913714352', '', null, '1', '1440661009');
INSERT INTO `web_supplier` VALUES ('572', 'Blooms', '0904537877', '', 'thucphamchucnang102@gmail.com', '', '1', '1440820358');
INSERT INTO `web_supplier` VALUES ('573', 'Vplus', '0904537878', '', 'thucphamchucnang103@gmail.com', '', '1', '1440820421');
INSERT INTO `web_supplier` VALUES ('574', 'CÔNG TY TNHH GOLDENDOLPHIN', '0902206600', '0902206600', 'phamphihung83@gmail.com', null, '1', '1440822125');
INSERT INTO `web_supplier` VALUES ('575', 'Cty TNHH TMDV và ĐT Nhất Long', '043.6420958', '043.6420958', 'Nhatlongcompany@yahoo.com', '', '1', '1440988305');
INSERT INTO `web_supplier` VALUES ('576', 'Born Free', '0000000', '', '0000000', '', '1', '1440991111');
INSERT INTO `web_supplier` VALUES ('577', 'CÔNG TY TNHH TM DV EDEN', '0973533339', '0973533339', '', null, '1', '1440993675');
INSERT INTO `web_supplier` VALUES ('578', 'Công ty CPTM tổng hợp XNK TVH', '0435881127', '0435881127', '', null, '1', '1441017846');
INSERT INTO `web_supplier` VALUES ('579', 'CÔNG TY CỔ PHẦN GOLDSUN VIỆT NAM', '01679308727', '01679308727', 'anh.phamnhat@goldsun.vn', null, '1', '1441074054');
INSERT INTO `web_supplier` VALUES ('580', 'Teka', '0903262940', '', 'viet.teka@gmail.com', '', '1', '1441076818');
INSERT INTO `web_supplier` VALUES ('581', 'Hatha Fitness &amp; Yoga', '0838265388', '0838265388', 'hieutruong2205@gmail.com', '', '1', '1441082849');
INSERT INTO `web_supplier` VALUES ('582', 'Modern Life', '12345678', '', '12345678', 'http://www.modernlife.vn/', '1', '1441083065');
INSERT INTO `web_supplier` VALUES ('583', 'CÔNG TY CỔ PHẦN KỸ NGHỆ VÀ THƯƠNG MẠI NHẬT MINH', '0914.838.968', '0914.838.968', '', null, '1', '1441102129');
INSERT INTO `web_supplier` VALUES ('584', 'Phụ Kiện Samsung', '0967838021', '01233698888', 'phongdd@phukiensamsung.com', 'http://www.phukiensamsung.com/', '0', '1441246949');
INSERT INTO `web_supplier` VALUES ('585', 'Hanoi Tech Buy', '04 3873 7855', '0902206600', 'phamphihung803@gmail.com', 'http://hanoitechbuy.com/', '1', '1441247426');
INSERT INTO `web_supplier` VALUES ('586', 'Beaumore', null, '1900636466', 'cskh@nemo.vn', null, '1', '1444126738');
INSERT INTO `web_supplier` VALUES ('587', 'Mills Ray', null, '1900636466', 'cskh@nemo.vn', null, '1', '1444126738');
INSERT INTO `web_supplier` VALUES ('588', 'Công ty TNHH Hàng nhập khẩu Châu Âu', '0988088886', '0988088886', 'admin-eui@eu-imports.com.vn', null, '1', '1441257819');
INSERT INTO `web_supplier` VALUES ('589', 'Công Ty Cổ Phần Chìa Khóa Lê', '0918192220', '0918192220', 'vinguyen@comtamcali.com', null, '1', '1441277054');
INSERT INTO `web_supplier` VALUES ('590', 'Công ty TNHH Faso Việt Nam', '0436408627', '0436408627', '', null, '1', '1441340126');
INSERT INTO `web_supplier` VALUES ('591', 'Chi nhánh công ty TNHH Happycook', '3600583091-001', '3600583091-001', 'hoa.dao@happycook.com.vn', null, '1', '1441343594');
INSERT INTO `web_supplier` VALUES ('592', 'Konigin', '0965999699', '0965999699', 'konigin.vn@gmail.com', '', '1', '1441343859');
INSERT INTO `web_supplier` VALUES ('593', 'Ohui', '0376.662.888', '0376.662.888', '', '', '1', '1441591472');
INSERT INTO `web_supplier` VALUES ('594', 'Forci', '0439921286', '0439921286', '', '', '1', '1441591776');
INSERT INTO `web_supplier` VALUES ('595', 'Suzuran Baby', '( 84) 462537335', '( 84) 462537335', '', '', '1', '1441594809');
INSERT INTO `web_supplier` VALUES ('596', 'Chi nhánh Công ty Cổ phần công nghệ Silicom Hà Nội', '04.37323232', '04.37323232', 'kd4.hn@silicom.com.vn', '', '1', '1441605281');
INSERT INTO `web_supplier` VALUES ('597', 'Fornix', '08 62636162', '08 62636162', 'mr.tungha@gmail.com', '', '1', '1441682733');
INSERT INTO `web_supplier` VALUES ('598', 'CÔNG TY TNHH SẢN XUẤT VÀ XÂY DỰNG HOÀNG GIA', '0986296904', '0986296904', 'mart@lottebeverage.vn', null, '1', '1441686328');
INSERT INTO `web_supplier` VALUES ('599', 'GOLD CARE', '84822242168', '84822242168', 'trieubui@gilos.com.vn', '', '1', '1441688921');
INSERT INTO `web_supplier` VALUES ('600', 'Smart Salt', '0839913728', '0839913728', 'lily.nguyen@smart-health.com.vn', '', '1', '1441691444');
INSERT INTO `web_supplier` VALUES ('601', 'Mai Hoàng', '01663818639', '01663818639', '', '', '1', '1441701594');
INSERT INTO `web_supplier` VALUES ('602', 'Digiworld', '04 3936 4333', '04 3936 4333', '', '', '1', '1441707252');
INSERT INTO `web_supplier` VALUES ('603', 'Digiworld Hà Nội', '043 - 9388568', '043 - 93885', 'support@digiworldhanoi.vn', 'http://digiworldhanoi.vn/', '1', '1441707690');
INSERT INTO `web_supplier` VALUES ('604', 'VIFAMI', '04. 6252 6252', '04. 6252 6252', '', '', '1', '1441777553');
INSERT INTO `web_supplier` VALUES ('605', 'Kyoritsu VietNam', '0914 363 555', '0914 363 555', 'nguyendt.ste@gmail.com', '', '1', '1441797698');
INSERT INTO `web_supplier` VALUES ('606', 'Công ty TNHH Beuer N&C Việt Nam', '0462603264', '0462603264', 'dungmkt998@gmail.com', null, '1', '1441854925');
INSERT INTO `web_supplier` VALUES ('607', 'TVS - Italy', '(84 4) 632 1502', '(84 4) 632 1502', 'Bổ sung sau', '', '1', '1441861134');
INSERT INTO `web_supplier` VALUES ('608', 'CÔNG TY CỔ PHẦN TỐT GỖ', '043 5668509/ : 0902 ', '043 5668509/ : 0902 ', 'thuyngoc7903@gmail.com', null, '1', '1441880765');
INSERT INTO `web_supplier` VALUES ('609', 'QUARTET', '(08)  3920 5920', '(08)  3920 5920', 'sale@bnp.vn', '', '1', '1441881213');
INSERT INTO `web_supplier` VALUES ('610', ': CÔNG TY TNHH CÔNG NGHỆ THÔNG TIN NÓNG ĐỎ', '(08) 38630664', '(08) 38630664', '', null, '1', '1441892861');
INSERT INTO `web_supplier` VALUES ('611', 'POOMKO', '043 5668509', '0983888822', 'phuhg@poomko.com', 'http://poomko.vn/', '1', '1441940952');
INSERT INTO `web_supplier` VALUES ('612', 'SUNHOUSE', '0974 782 143', '0974 782 143', 'dungtk@sunhouse.com.vn', '', '1', '1441946432');
INSERT INTO `web_supplier` VALUES ('613', 'VitaDairy', '(04) 3 641 6557', '(04) 3 641 6557', 'info@vitadairy.com.vn', 'http://vitadairy.com.vn/', '1', '1442031501');
INSERT INTO `web_supplier` VALUES ('614', 'Sowun', '08 377 38 234', '08 377 38 234', 'nhung@hoangbachconex.com.vn', '', '1', '1442067213');
INSERT INTO `web_supplier` VALUES ('615', 'Yến sào Nam Việt', '04.6296.2828', '04.6296.2828', '', '', '1', '1442459285');
INSERT INTO `web_supplier` VALUES ('616', 'Mũ bảo hiểm Chita', '0977.927.385', '0977.927.385', '', '', '1', '1442477119');
INSERT INTO `web_supplier` VALUES ('617', 'Mũ bảo hiểm Chita', '04.36210238', '', 'chitab@chithanhvn.com', 'http://www.chithanhvn.com/', '1', '1442479056');
INSERT INTO `web_supplier` VALUES ('618', 'Hệ thống cửa hàng Enmax', '0904781386', '0904781386', 'nguyenanh.tmh@gmail.com', null, '1', '1442562022');
INSERT INTO `web_supplier` VALUES ('619', 'CÔNG TY TNHH VĨNH TÍN', '0603866668', '0603866668', '', null, '1', '1442636267');
INSERT INTO `web_supplier` VALUES ('620', 'Công Ty Cổ Phần Phát Triển Thương Mại Và Dịch Vụ Q', '0973596890', '0973596890', 'tinnguyen.quanganhjsc@gmail.com', null, '1', '1442747442');
INSERT INTO `web_supplier` VALUES ('621', 'CÔNG TY CỔ PH ̀N XU ́T NH ̣P KH ̉U VÀ DỊCH VỤ ', '043.996.9997', '043.996.9997', 'dieptran@tmtshop.vn', null, '1', '1442747863');
INSERT INTO `web_supplier` VALUES ('622', 'IT\'S SKIN', '04.3974.9724', '04.3974.9724', 'info@itsskin.com.vn', '', '1', '1442825493');
INSERT INTO `web_supplier` VALUES ('623', 'Công Ty TNHH Phẫu Thuật Thẫm Mỹ Măt Ngọc', '0938073488', '0938073488', 'huynhhuuthach@gmail.com', null, '1', '1442854330');
INSERT INTO `web_supplier` VALUES ('629', 'Công Ty TNHH Sản Phẩm Tiêu Dùng TOSHIBA - Việt Nam', '8975433', '8975433', 'cuong-nguyenhuy@toshiba.com.vn', null, '1', '1442939332');
INSERT INTO `web_supplier` VALUES ('630', 'ADELL Việt Nam', '(04) 37346996', '', 'kimanh@adell.com', '', '1', '1442992322');
INSERT INTO `web_supplier` VALUES ('631', 'Spigen', '043-540-6389', '043-540-6389', 'spigen.vtt@gmail.com', '', '1', '1443069341');
INSERT INTO `web_supplier` VALUES ('632', 'Phụ kiện KIANEX', '(08) 62 935 427', '(08) 62 935 427', 'huy@kianex.vn', 'http://kianex.vn', '1', '1443155996');
INSERT INTO `web_supplier` VALUES ('633', 'Công ty cổ phần dịch vụ Vietlife', '0963 392 531', '0963 392 531', '', null, '1', '1443433169');
INSERT INTO `web_supplier` VALUES ('634', 'Nanakids', '(08) 39142606 -  391', '(08) 39142606 -  391', 'Info@nanakids.vn', '', '1', '1443459034');
INSERT INTO `web_supplier` VALUES ('635', 'CÔNG TY TNHH TM DV PHÚC THÀNH AN', '0854102218', '0854102218', 'cs2@pta.vn', null, '1', '1443506601');
INSERT INTO `web_supplier` VALUES ('636', 'SPIGEN', '(04). 6278 0046', '(04). 6278 0046', 'hao.tran@phongthai.vn', '', '1', '1443511033');
INSERT INTO `web_supplier` VALUES ('637', 'Phong Thái', '04) 6278 3718', '', 'huyenqt@phongthai.vn', '', '1', '1443511783');
INSERT INTO `web_supplier` VALUES ('638', 'GGMM', '', '', 'hoa@gmail.com', '', '1', '1443516452');
INSERT INTO `web_supplier` VALUES ('639', 'Công Ty Cổ Phần Ngôi Nhà Ánh Dương Miền Nam', '08 38691014', '08 38691014', 'trinhph@sunhouse.com.vn', null, '1', '1443586061');
INSERT INTO `web_supplier` VALUES ('640', 'Hưng Long', '844 36285888', '844 36285888', '', '', '1', '1443599112');
INSERT INTO `web_supplier` VALUES ('641', 'Bluedio', '097395 3333', '097395 3333', 'info@tainghe.com.vn', '', '1', '1443602138');
INSERT INTO `web_supplier` VALUES ('642', 'CÔNG TY TNHH THƯƠNG MẠI DỊCH VỤ CÔNG NGHỆ START', '0918 455 855', '0918 455 855', 'info@sotate.com', null, '1', '1443603906');
INSERT INTO `web_supplier` VALUES ('643', 'Whoo', '0900000000', '', 'sdsadsads@dssdsjdhsajdsajk', '', '1', '1443684632');
INSERT INTO `web_supplier` VALUES ('644', 'Sinbo', '(04)36340532', '(04)36340532', 'update...', '', '1', '1443769204');
INSERT INTO `web_supplier` VALUES ('645', 'Audio Technica', '(08) 6 292 4428 -  (', '(08) 6 292 4428 -  (', 'sang.nguyen@synstyle.com.vn', '', '1', '1443770342');
INSERT INTO `web_supplier` VALUES ('646', 'iOne', '0437331830', '0437331830', '', '', '1', '1443838626');
INSERT INTO `web_supplier` VALUES ('647', 'Philiger', '212324233443', '', '12312321234324', '', '1', '1443848482');
INSERT INTO `web_supplier` VALUES ('648', 'Steven Spa &amp; Salon', '(08) 6672 4888', '(08) 6672 4888', 'phuchoang117@gmail.com', '', '1', '1443850845');
INSERT INTO `web_supplier` VALUES ('649', 'Chicco', '000123', '', 'emailkhongphainhap', '', '1', '1444009846');
INSERT INTO `web_supplier` VALUES ('650', 'CÔNG TY TNHH MTV KOVIN', '08-3601-9564', '08-3601-9564', 'duan.lh@kovin.vn', null, '1', '1444028164');
INSERT INTO `web_supplier` VALUES ('651', 'Công Ty TNHH Việt Chí Thành', '043 85 25 373', '043 85 25 373', '', null, '1', '1444037175');
INSERT INTO `web_supplier` VALUES ('652', 'CÔNG TY TNHH ĐẦU TƯ THƯƠNG MẠI KỸ THUẬT PHƯƠNG ANH', '0915696933', '0915696933', 'mydieu12@gmail.com', null, '1', '1444063637');
INSERT INTO `web_supplier` VALUES ('653', 'TEASANA', '04.363 21079', '04.363 21079', 'teasana', '', '1', '1444116172');
INSERT INTO `web_supplier` VALUES ('654', 'Công ty TNHH MTV Ra Beaute Vina', '0839308398', '0839308398', 'annaphan20@gmail.com', null, '1', '1444122387');
INSERT INTO `web_supplier` VALUES ('655', 'Công Ty TNHH Điện Tử - Điện Lạnh Bình Minh', '0848 3945 3483', '0848 3945 3483', 'support@binhminhcompany.com', null, '1', '1444138269');
INSERT INTO `web_supplier` VALUES ('656', 'Anker', '123123123', '', 'emailkhongco', '', '1', '1444185293');
INSERT INTO `web_supplier` VALUES ('657', 'Công ty cổ phần xuất nhập khẩu Tency', '0462538162', '0462538162', 'minh.nguyet@tenbike.com.vn', null, '1', '1444274725');
INSERT INTO `web_supplier` VALUES ('658', 'CÔNG TY TNHH MTV NHIỆM MÀU', '84 8 39939919', '84 8 39939919', 'qui.chau@miraclediamond.vn', null, '1', '1444287528');
INSERT INTO `web_supplier` VALUES ('659', 'R&amp;B', '111111111', '', 'emailkhongcodau', '', '1', '1444364765');
INSERT INTO `web_supplier` VALUES ('660', 'Công ty cổ phần HTB Việt Nam', '0912.146.147', '0912.146.147', 'trongduyg2@gmail.com', null, '1', '1444372244');
INSERT INTO `web_supplier` VALUES ('661', 'HP', '(84 4) 3537 8637', '(84 4) 3537 8637', '', '', '1', '1444372937');
INSERT INTO `web_supplier` VALUES ('662', 'CosMedical', '08 3846 4480', '08 3846 4480', '', '', '1', '1444374517');
INSERT INTO `web_supplier` VALUES ('663', 'EDUGAME', '0822165171', '0822165171', 'songchau912@gmail.com', 'http://www.edugames.edu.vn/hmp/', '1', '1444374707');
INSERT INTO `web_supplier` VALUES ('664', 'CÔNG TY CỔ PHẦN XUẤT NHẬP KHẨU THƯƠNG MẠI ĐÀI LINH', '043 538 1818', '043 538 1818', 'huongpt@dailinhgroup.vn', null, '1', '1444397979');
INSERT INTO `web_supplier` VALUES ('665', 'Mỹ phẩm thiên nhiên', '123765', '', 'khongcodau', '', '1', '1444400801');
INSERT INTO `web_supplier` VALUES ('666', 'Hotor', '5431', '', 'lamgicoha', '', '1', '1444619075');
INSERT INTO `web_supplier` VALUES ('667', 'Song Long', '0866741149', '0866741149', 'happyplastic1202@gmail.com', '', '1', '1444624911');
INSERT INTO `web_supplier` VALUES ('668', 'Sản phẩm Hàn Quốc', '0983 386 887', '0983 386 887', 'linhct0508g@gmail.com', '', '1', '1444705430');
INSERT INTO `web_supplier` VALUES ('669', 'CÔNG TY TNHH ĐIỆN TỬ ĐIỆN LẠNH VIỆT NHẬT', '083.8112084', '083.8112084', '', null, '1', '1444709180');
INSERT INTO `web_supplier` VALUES ('670', 'ARGO', '08-35180099', '08-35180099', '', '', '1', '1444712110');
INSERT INTO `web_supplier` VALUES ('671', 'Công ty TNHH CÔNG TY CỔ PHẦN MỸ PHẨM KANG NAM', '04.62.923.873', '04.62.923.873', '', null, '1', '1444728492');
INSERT INTO `web_supplier` VALUES ('680', 'CÔNG TY TNHH THẾ GIỚI TÚI XÁCH', '(08) 3845 4966', '(08) 3845 4966', 'info@thegioituixach.com.vn', null, '1', '1444918103');
INSERT INTO `web_supplier` VALUES ('681', 'CN TẠI TPHCM –CÔNG TY TNHH PHÂN PHỐI SNB', '08.38208554', '08.38208554', 'saleshcm00.01@snb.com.vn', null, '1', '1444918559');
INSERT INTO `web_supplier` VALUES ('682', 'CHI NHÁNH CÔNG TY TNHH ĐỒ DÙNG GIA ĐÌNH SA PA TẠI ', '043.7833770/71', '043.7833770/71', 'dafang2vn@gmail.com', null, '1', '1444962909');
INSERT INTO `web_supplier` VALUES ('683', 'Bormioli Rocco', '11211', '', 'khongcogica', '', '1', '1444963003');
INSERT INTO `web_supplier` VALUES ('684', 'Công ty TNHH Thương Mại thế giới đẹp Sam Lan', '0946081010', '0946081010', 'nhulan@samlan.vn', null, '1', '1444963898');
INSERT INTO `web_supplier` VALUES ('685', 'Bormioli Rocco', '121212121212', '', 'AAA', '', '1', '1444975775');
INSERT INTO `web_supplier` VALUES ('686', 'Động Lực Group', '(84,4)5588418', '(84,4)5588418', 'dongluc', '', '1', '1444982966');
INSERT INTO `web_supplier` VALUES ('687', 'Topmost Bike', '0964079882', '0964079882', 'topmostbikevn@gmail.com', '', '1', '1445220526');
INSERT INTO `web_supplier` VALUES ('688', 'CÔNG TY CP THIẾT BỊ CÔNG NGHỆ CAO TM', '(04) 3576 3435', '(04) 3576 3435', '', null, '1', '1445221617');
INSERT INTO `web_supplier` VALUES ('689', 'Braun Electronic Việt Nam', '0982098490', '0982098490', 'tranhoa070984@gmail.com', '', '1', '1445223916');
INSERT INTO `web_supplier` VALUES ('690', 'Sport Mart', '04.3747.3747', '04.3747.3747', 'tanlienminhjsc@gmail.com', '', '1', '1445225731');
INSERT INTO `web_supplier` VALUES ('691', 'Xuân Phát', '0936 366 166', '0936 366 166', '', '', '1', '1445334275');
INSERT INTO `web_supplier` VALUES ('692', 'CÔNG TY CỔ PHẦN VINANOI', '0862 789 409', '0862 789 409', 'mevabe@mbcare.vn', null, '1', '1445355859');
INSERT INTO `web_supplier` VALUES ('693', 'Iwaki', '109', '', 'abcdef', '', '1', '1445394893');
INSERT INTO `web_supplier` VALUES ('694', 'CÔNG TY CỔ PHẦN LỘC ĐẠI QUÝ', '0906508403', '0906508403', 'samnguyen@chefman.vn', null, '1', '1445445342');
INSERT INTO `web_supplier` VALUES ('695', 'CÔNG TY TNHH THƯƠNG MẠI VÀ DỊCH VỤ XUẤT NHẬP KHẨU ', 'nhap sau', 'nhap sau', '', null, '1', '1445480716');
INSERT INTO `web_supplier` VALUES ('696', 'Mai Kế Sport', 'Nhập sau', 'Nhập sau', '', '', '1', '1445565708');
INSERT INTO `web_supplier` VALUES ('697', 'LAICA', '(04) 3640 4157', '(04) 3640 4157', 'laica', '', '1', '1445567625');
INSERT INTO `web_supplier` VALUES ('698', 'CHI NHÁNH CÔNG TY CỔ PHẦN KIM LONG', '0837514422', '0837514422', '', null, '1', '1445600070');
INSERT INTO `web_supplier` VALUES ('699', 'Hamilton Beach', '3241', '', 'hahaaaa', '', '1', '1445825740');
INSERT INTO `web_supplier` VALUES ('700', 'Bialetti', '67545', '', 'aaaaaaaaa', '', '1', '1445838104');
INSERT INTO `web_supplier` VALUES ('701', 'Dualit', '567890', '', 'adc', '', '1', '1445840184');
INSERT INTO `web_supplier` VALUES ('702', 'Gorenje', '04 35121878 - 0911 4', '0989 288443', 'phong0710@thanhlong.vn', '', '1', '1445918773');
INSERT INTO `web_supplier` VALUES ('703', 'CÔNG TY TNHH SX.TM.DV.XNK SONG TẤN', '(08) 35178540 / (08)', '(08) 35178540 / (08)', 'info@songtan.vn', null, '1', '1446135684');
INSERT INTO `web_supplier` VALUES ('704', 'CTCP Đầu Tư TMDV Tam Tân Quý', '08 3716 4209', '08 3716 4209', 'info@ysdn.vn', null, '1', '1446174034');
INSERT INTO `web_supplier` VALUES ('705', 'Lacor', '11111111111111111111', '', 'hahahav', '', '1', '1446174403');
INSERT INTO `web_supplier` VALUES ('706', 'CS', '5131', '', '333', '', '1', '1446174522');
INSERT INTO `web_supplier` VALUES ('707', 'Kitchen Aid', '233333333', '', 'bababa', '', '1', '1446174834');
INSERT INTO `web_supplier` VALUES ('708', 'STANLEY', '122121212121', '', 'VVVVVVV', '', '1', '1446174877');
INSERT INTO `web_supplier` VALUES ('709', 'CARLMANN', '23111231312312312312', '', 'VVVVVVVVVVVVVVVVVVVVVVVVVVV', '', '1', '1446174897');
INSERT INTO `web_supplier` VALUES ('710', 'Đông Trùng Hạ Thảo Kim Lai', '04.3514 7871', '04.3514 7871', '', '', '1', '1446435144');
INSERT INTO `web_supplier` VALUES ('711', 'NIKE', '0942362111', '', 'DONGXU@GMAIL.COM', '', '1', '1446612452');
INSERT INTO `web_supplier` VALUES ('712', 'K-GIN', '0904.981.981', '0904.981.981', 'ntthu262@gmail.com', '', '1', '1446629045');
INSERT INTO `web_supplier` VALUES ('713', 'Công Ty TNHH TM Khánh Tân', '043 636 9456', '043 636 9456', 'khanhtan88@yahoo.com', null, '1', '1446694198');
INSERT INTO `web_supplier` VALUES ('714', 'CT TNHH THƯƠNG MẠI VÀ SẢN XUẤT NGUYÊN SINH', '04.6685.1818', '04.6685.1818', 'nguyensinhvietnam@gmail.com', null, '1', '1446710348');
INSERT INTO `web_supplier` VALUES ('715', 'Yến sào Thiên Hoàng', '0903.402.486', '0903.402.486', 'vietthufood@gmail.com', '', '1', '1446711949');
INSERT INTO `web_supplier` VALUES ('716', 'Công ty TNHH SX TM Ngôi Sao Xanh', '08 3916 5678', '08 3916 5678', 'info@bluestar-vn.com', null, '1', '1446736697');
INSERT INTO `web_supplier` VALUES ('717', 'CHARTERHOUSE', '11111111111111111111', '', 'aaaa', '', '1', '1446778240');
INSERT INTO `web_supplier` VALUES ('718', 'Moriitalia', '12121214', '', 'fg', '', '1', '1446778370');
INSERT INTO `web_supplier` VALUES ('719', 'Tinh dầu Lam Hà', '04.36250718', '04.36250718', '', '', '1', '1446786566');
INSERT INTO `web_supplier` VALUES ('720', 'BẢO QUANG', '(04) 37723626', '(04) 37723626', '', '', '1', '1446787206');
INSERT INTO `web_supplier` VALUES ('721', 'RoyalBaby', '0987557575', '0987557575', 'cskh.royalbike@gmail.com', '', '1', '1447124732');
INSERT INTO `web_supplier` VALUES ('722', 'Mizuno', '04 3944 9999 / 04 38', '04 3944 9999 / 04 38', 'hongminh1901@gmail.com', '', '1', '1447147316');
INSERT INTO `web_supplier` VALUES ('723', 'Hoàng Gia Yến', '0917021177', '0917021177', 'hoanggiayen', '', '1', '1447150969');
INSERT INTO `web_supplier` VALUES ('724', 'NUTRIBEN', '0854361528', '0854361528', '', '', '1', '1447216350');
INSERT INTO `web_supplier` VALUES ('725', 'Hộ kinh doanh Hoàng Thị Mai Yến', '04.6673.9157', '04.6673.9157', 'samnamnamtrieu@gmail.com', null, '1', '1447407886');
INSERT INTO `web_supplier` VALUES ('726', 'Simba', '08.376.26.266', '08.376.26.266', '', '', '1', '1447730435');
INSERT INTO `web_supplier` VALUES ('727', 'Công ty cổ phần Elmich', '0916 57 3883', '0916 57 3883', 'vuthinhutrang.vcu@gmail.com', null, '1', '1447737343');
INSERT INTO `web_supplier` VALUES ('728', 'FASO', '4444444', '4444444', 'faso', '', '1', '1447737737');
INSERT INTO `web_supplier` VALUES ('729', 'MYKINGDOM', '08.54319051', '08.54319051', '', '', '1', '1447833904');
INSERT INTO `web_supplier` VALUES ('730', 'CÔNG TY TNHH THƯƠNG MẠI VÀ DỊCH VỤ XUẤT NHẬP KHẨU ', '04-38511616', '04-38511616', '', null, '1', '1447908410');
INSERT INTO `web_supplier` VALUES ('731', 'CÔNG TY CP ĐẦU TƯ PHÁT TRIỂN CÔNG NGHỆ THỜI ĐẠI MỚ', '04-353 77777', '04-353 77777', '', null, '1', '1447919145');
INSERT INTO `web_supplier` VALUES ('732', 'Lật đật Nga', '0838342881', '0838342881', '', '', '1', '1447927150');
INSERT INTO `web_supplier` VALUES ('733', 'Thảm thổ nhĩ kỳ Antalya', '0904.892.293', '0904.892.293', '', '', '1', '1447991147');
INSERT INTO `web_supplier` VALUES ('734', 'Rossi', '043.687.5555', '043.687.5555', '', '', '1', '1448267219');
INSERT INTO `web_supplier` VALUES ('735', 'Bosch', '0436276396', '0436276396', 'sdsvietnam', '', '1', '1448350663');
INSERT INTO `web_supplier` VALUES ('736', 'HỘ KINH DOANH TRẦN PHÚC THỌ', '0943422268', '0943422268', 'phucthokc@gmail.com', null, '1', '1448359522');
INSERT INTO `web_supplier` VALUES ('737', 'Alodienthoai VN', '1122', '1122', '1122', 'http://alodienthoai.net/', '1', '1448359839');
INSERT INTO `web_supplier` VALUES ('738', 'Bell Shark', '08.3977.8927', '08.3977.8927', 'phuongpham7785@gmail.com', '', '1', '1448381317');
INSERT INTO `web_supplier` VALUES ('739', 'Công Ty Cổ Phần Tương Lai Việt', '08. 3502 3930', '08. 3502 3930', 'sales@baby-autoru.com', '', '1', '1448438620');
INSERT INTO `web_supplier` VALUES ('740', 'Autoru', '0906975456', '', 'order.autoru@gmail.com', 'http://www.baby-autoru.com/', '1', '1448512913');
INSERT INTO `web_supplier` VALUES ('741', 'CÔNG TY TNHH SẢN XUẤT, THƯƠNG MẠI VÀ DỊCH VỤ ĐỨC M', '(090) 469-7677', '(090) 469-7677', 'tranducmanh@gmail.com', null, '1', '1448526830');
INSERT INTO `web_supplier` VALUES ('742', 'Duc Minh Mobile', '0904697677', '', 'ducmanh0309@gmail.com', 'http://www.ducminhmobile.net/', '1', '1448527098');
INSERT INTO `web_supplier` VALUES ('743', 'Apelson', '046 6633779', '046 6633779', 'nguyendung.nsv@gmail.com', '', '1', '1448590970');
INSERT INTO `web_supplier` VALUES ('744', 'NGUỒN SỐNG VIỆT', '08. 37480859', '08. 37480859', '', '', '1', '1448601257');
INSERT INTO `web_supplier` VALUES ('745', 'Công ty TNHH Việt Năng', '043.9332476', '043.9332476', 'vietnangltd@vietnang.vn', null, '1', '1448602830');
INSERT INTO `web_supplier` VALUES ('746', 'Supor', '0466729696', '0466729696', 'namphuong3868@gmail.com', '', '1', '1448604205');
INSERT INTO `web_supplier` VALUES ('747', 'Công ty cổ phần kỹ thuật công nghệ Nam Thành', '094 345 3210', '094 345 3210', 'sale03@namthanh.com.vn', null, '1', '1448604509');
INSERT INTO `web_supplier` VALUES ('748', 'Công ty TNHH FIRST Việt Nam', '04.37830794', '04.37830794', 'tiross.thanglong@gmail.com', null, '1', '1448604683');
INSERT INTO `web_supplier` VALUES ('749', 'CÔNG TY TNHH TIN HỌC Á ĐÔNG VI NA', '04.35130610', '04.35130610', 'vuthanhlamvn@gmail.com', null, '1', '1448606423');
INSERT INTO `web_supplier` VALUES ('750', 'OGAWA', '( 84 8) 5.413.3222/', '( 84 8) 5.413.3222/', 'minh.tran@ogawaworld.net', 'www.ogawa.net.vn', '1', '1448609747');
INSERT INTO `web_supplier` VALUES ('751', 'Công ty TNHH Winline Việt Nam', '0915258233', '0915258233', 'winlinevietnam@gmail.com', '', '1', '1448612747');
INSERT INTO `web_supplier` VALUES ('752', 'Công ty Cổ phần Tâm Mỹ', '03513616789', '0912478289', 'trungmiranda@gmail.com', 'http://miranda.vn', '1', '1448615840');
INSERT INTO `web_supplier` VALUES ('753', 'Mật ong Hoa Bốn Mùa', '043. 7846965', '043. 7846965', '', '', '1', '1448616345');
INSERT INTO `web_supplier` VALUES ('754', 'SMARTPARKING', 'acb', '', 'acv', '', '0', '1448675846');
INSERT INTO `web_supplier` VALUES ('755', 'BNL (Hàn Quốc)', '08. 3773 0779', '08. 3773 0779', 'bnl.acehappy@gmail.com', '', '1', '1448676729');
INSERT INTO `web_supplier` VALUES ('756', 'SMARTPARKING', 'AAA', '', 'GHS', '', '1', '1448678215');
INSERT INTO `web_supplier` VALUES ('757', 'TRUNG TÂM CHĂM SÓC KHÁCH HÀNG S U N T E K', '01237197997', '01237197997', 'suntek.kd@gmail.com', null, '1', '1448678590');
INSERT INTO `web_supplier` VALUES ('758', 'SUNTEK', '04 66528661', '04 66528661', 'hieucv1797@gmail.com', 'http://suntekvietnam.vn/vn/', '1', '1448679087');
INSERT INTO `web_supplier` VALUES ('759', 'Clever Dog', '0984.227.505', '0984.227.505', 'tuyentran@foscam.vn', 'http://foscam.vn/', '1', '1448702613');
INSERT INTO `web_supplier` VALUES ('760', 'Foscam', '(08) 22101327', '', 'support@huyenvu.vn', 'http://foscam.vn/', '1', '1448702777');
INSERT INTO `web_supplier` VALUES ('761', 'CÔNG TY CỔ PHẦN THỜI TRANG PHAN NGUYỄN', 'ag', 'ag', '', '', '1', '1448854973');
INSERT INTO `web_supplier` VALUES ('762', 'CÔNG TY TNHH ĐẠI ĐOÀN GIA', '0983330380', '0983330380', 'dung.transy@gmail.com', null, '1', '1448857278');
INSERT INTO `web_supplier` VALUES ('763', 'Đại Đoàn Gia', '046326686', '046326686', 'sydung@daidoangia.com', 'http://daidoangia.vn/', '1', '1448857489');
INSERT INTO `web_supplier` VALUES ('764', 'Hauck', '08. 3899 6300', '08. 3899 6300', 'sale1@royalkid.net', 'http://www.royalkid.net/', '1', '1448943897');
INSERT INTO `web_supplier` VALUES ('765', 'BABYTOP', '08. 3961 8992', '08. 3961 8992', 'nghilucco@hcm.fpt.vn', '', '1', '1448945408');
INSERT INTO `web_supplier` VALUES ('766', 'B-BAGS', 'AGAGAG', '', 'GSHASH', '', '1', '1448956241');
INSERT INTO `web_supplier` VALUES ('767', 'Miracle', '0838215855', '0838215855', 'qui.chau@miraclediamond.vn', 'http://www.miraclediamond.vn/', '1', '1449073710');
INSERT INTO `web_supplier` VALUES ('768', 'PHAN NGUYEN', 'AFAF', '', 'AGSH', '', '1', '1449110573');
INSERT INTO `web_supplier` VALUES ('769', 'HUYNDAI WACORTEC', '04 66756742 - 046675', '04 66756742 - 046675', '', '', '1', '1449113574');
INSERT INTO `web_supplier` VALUES ('770', 'Kho Di Động', '0983605699', '0983605699', 'khodidong', '', '1', '1449136700');
INSERT INTO `web_supplier` VALUES ('771', 'Kho Di Động', '(098) 360-5699', '(098) 360-56', 'thanhtd@diemsangviet.vn', '', '1', '1449136823');
INSERT INTO `web_supplier` VALUES ('772', 'OMRON', '04.85886151', '04.85886151', 'ưewewewew', '', '1', '1449174922');
INSERT INTO `web_supplier` VALUES ('773', 'CÔNG TY TNHH KINH DOANH VÀ DỊCH VỤ THANH LOAN', '0935665995', '0935665995', 'hiennn1302@gmail.com', null, '1', '1449217329');
INSERT INTO `web_supplier` VALUES ('774', 'Phụ kiện Phương Loan', '(093) 566-5995', '', 'hiennn1302@yahoo.com', '', '1', '1449217550');
INSERT INTO `web_supplier` VALUES ('775', 'ÔNG TY TNHH THỜI TRANG MẶT TRỜI HỒNG', '08.22124030 - 08.383', '08.22124030 - 08.383', '', null, '1', '1449232675');
INSERT INTO `web_supplier` VALUES ('776', 'The Herbal Cup', '( 84) 90 979 1200 -', '( 84) 90 979 1200 -', 'customer.service@theherbalcup.vn', 'www.theherbalcup.vn', '1', '1449244082');
INSERT INTO `web_supplier` VALUES ('777', 'RIONET', '21343254', '', '43423423423', '', '1', '1449255363');
INSERT INTO `web_supplier` VALUES ('778', 'Ching Ching', '04 35668556', '04 35668556', 'info@dochoihanoi', '', '1', '1449290247');
INSERT INTO `web_supplier` VALUES ('779', 'CT CP TM DV TRUYỀN THÔNG TNG VIỆT NAM', '0438647120', '0438647120', '', null, '1', '1449297473');
INSERT INTO `web_supplier` VALUES ('780', 'PSF', 'AGGE', '', 'ẦGAG', '', '1', '1449392014');
INSERT INTO `web_supplier` VALUES ('781', 'Dynamic Vina', '08.62622670', '08.62622670', '', '', '1', '1449456885');
INSERT INTO `web_supplier` VALUES ('782', 'CÔNG TY TNHH NHẬT LINH', '0903458888', '0903458888', '', null, '1', '1449457754');
INSERT INTO `web_supplier` VALUES ('783', 'LIOA', 'AHAHAE', '', 'AGG', '', '1', '1449457930');
INSERT INTO `web_supplier` VALUES ('784', 'Vinalon', '08.3731.2414', '08.3731.2414', 'maihanh1216@gmail.com', '', '1', '1449459984');
INSERT INTO `web_supplier` VALUES ('785', 'Kho đồ chơi Sóng Mới', '046402372', '046402372', '', '', '1', '1449463823');
INSERT INTO `web_supplier` VALUES ('786', 'BÙI NGỌC CƯỜNG', '0986552211', '0986552211', '', null, '1', '1449470787');
INSERT INTO `web_supplier` VALUES ('787', 'SEEBABY', 'AGAG', '', 'AGAGFFF', '', '1', '1449470861');
INSERT INTO `web_supplier` VALUES ('788', 'IQTOY', 'AGA', '', 'AGEAGAGA', '', '1', '1449470879');
INSERT INTO `web_supplier` VALUES ('789', 'LIVAX', '0462573215', '0462573215', '', '', '1', '1449477918');
INSERT INTO `web_supplier` VALUES ('790', 'JANGIN', '6544654353', '', 'ádassadada', '', '1', '1449482277');
INSERT INTO `web_supplier` VALUES ('791', 'FarmaCell', '08. 3984 3646', '08. 3984 3646', 'hunghyco@gmail.com', '', '1', '1449558436');
INSERT INTO `web_supplier` VALUES ('792', 'CÔNG TY CỔ PHẦN THIẾT BỊ BÁCH KHOA', '0916979903', '0916979903', 'huynq@bkc.vn', null, '1', '1449563628');
INSERT INTO `web_supplier` VALUES ('793', 'Bach Khoa Computer', '0916 979 903', '', 'homeshopping@gmail.com', '', '1', '1449563768');
INSERT INTO `web_supplier` VALUES ('794', 'Tupperware Việt Nam', 'điền sau', 'điền sau', 'điền sau', '', '1', '1449669443');
INSERT INTO `web_supplier` VALUES ('795', 'Beurer Việt Nam', '04.35773151', '04.35773151', 'info@thietbiyte-eu.vn', '', '1', '1449713038');
INSERT INTO `web_supplier` VALUES ('796', 'Grow\'n Up', '0917172188', '', 'hoanglinh@dochoihanoi.vn', '', '1', '1449723559');
INSERT INTO `web_supplier` VALUES ('797', 'Công ty TNHH IDO Việt Nam', '0988070908', '0988070908', 'phuong@ido.com.vn', null, '1', '1449727529');
INSERT INTO `web_supplier` VALUES ('798', 'T.LONG', '08. 6264 4646', '08. 6264 4646', 'ly.thanhlongcoltd@gmail.com', '', '1', '1449737336');
INSERT INTO `web_supplier` VALUES ('799', 'AN SINH', '04-35377123', '04-35377123', '', '', '1', '1449739058');
INSERT INTO `web_supplier` VALUES ('800', 'FOREVER', '08 6673 1460', '08 6673 1460', 'chuong@mucimax.com', 'http://forever-k.com.vn/', '1', '1449765067');
INSERT INTO `web_supplier` VALUES ('801', 'Công ty CP Tư vấn thiết kế và xây dựng V-Home', '04.62541919', '04.62541919', '', null, '1', '1449806464');
INSERT INTO `web_supplier` VALUES ('802', 'V-Home', '0965197222', '', 'noithatvhome@gmail.com', '', '1', '1449806643');
INSERT INTO `web_supplier` VALUES ('803', 'Công Ty TNHH Sản Phẩm Trẻ Em Chí Việt', '08. 6653 4524', '08. 6653 4524', '', null, '1', '1449816515');
INSERT INTO `web_supplier` VALUES ('804', 'CÔNG TY TNHH IQTOYS VIỆT NAM', '0938150880', '0938150880', '', null, '1', '1449825721');
INSERT INTO `web_supplier` VALUES ('805', 'IQTOYS', 'ẦGAGGGG', '', 'AGAGGGGG', '', '1', '1449825778');
INSERT INTO `web_supplier` VALUES ('806', 'OSHITSU', '65411231323', '', 'rgtregergfrfg', '', '1', '1449889053');
INSERT INTO `web_supplier` VALUES ('807', 'CÔNG TY CỔ PHẦN PHÁT TRIỂN THƯƠNG HIỆU HẠT GẠO QUỐ', '04625517777', '04625517777', '', null, '1', '1449890200');
INSERT INTO `web_supplier` VALUES ('808', 'PISEN', 'AHGAG', '', 'AGEL', '', '1', '1449890248');
INSERT INTO `web_supplier` VALUES ('809', 'HANSTAND', '(84.8) 3 7445409', '(84.8) 3 7445409', 'phuong.pham_sophia@ce.com.vn', 'http://www.ce.com.vn/', '1', '1449895704');
INSERT INTO `web_supplier` VALUES ('810', 'CÔNG TY TNHH THƯƠNG MẠI ĐIỆN TỬ HÀ VY', '0944944139', '0944944139', 'havymobile@gmail.com', null, '1', '1450019451');
INSERT INTO `web_supplier` VALUES ('811', 'Hà Vy Mobile', '094813333', '', 'thuanhn89@gmail.com', '', '1', '1450019717');
INSERT INTO `web_supplier` VALUES ('812', 'CÔNG TY TNHH B-UNI HÀ NỘI', '043 8134 322', '043 8134 322', '', null, '1', '1450061610');
INSERT INTO `web_supplier` VALUES ('813', 'Công ty Cổ phần Thiết bị Vật tư La Bàn', '08 38490953', '08 38490953', 'info@nkxlock.com', '', '1', '1450061674');
INSERT INTO `web_supplier` VALUES ('814', 'OnGuard', '+84.(0)903919995', '', 'giangnguyen@nkxlock.com', '', '1', '1450062022');
INSERT INTO `web_supplier` VALUES ('815', 'AUM', 'AGEHK', '', 'SGSG', '', '1', '1450062365');
INSERT INTO `web_supplier` VALUES ('816', 'SCITECH', '04-37616222', '04-37616222', 'contact@scitech.com.vn', '', '1', '1450063246');
INSERT INTO `web_supplier` VALUES ('817', 'CÔNG TY TNHH GIA DỤNG CAO CẤP VIỆT NHẬT', '04. 6273.0579', '04. 6273.0579', '', null, '1', '1450065068');
INSERT INTO `web_supplier` VALUES ('818', 'TANAKA', 'YIUT', '', 'KFUKUK', '', '1', '1450065133');
INSERT INTO `web_supplier` VALUES ('819', 'BRAVO', 'NGN', '', 'HSJ', '', '1', '1450065161');
INSERT INTO `web_supplier` VALUES ('820', 'Tiross Việt Nam', '11111111111111111111', '', '111111111111111111111111111', '', '1', '1450066313');
INSERT INTO `web_supplier` VALUES ('821', 'CÔNG TY CỔ PHẦN BẢO KHÁNH VIỆT NAM', '043.5161816', '043.5161816', '', null, '1', '1450075779');
INSERT INTO `web_supplier` VALUES ('822', 'A.O.Smith', 'kfku', '', 'kkfk', '', '1', '1450075863');
INSERT INTO `web_supplier` VALUES ('823', 'JAPAKO KOMAX', '0466830288', '0466830288', '', '', '1', '1450080955');
INSERT INTO `web_supplier` VALUES ('824', 'GOWI', '08. 3964 1401', '08. 3964 1401', 'huong.l.tran@mbcare.com.vn', '', '1', '1450162310');
INSERT INTO `web_supplier` VALUES ('825', 'ABLOY', '0903.821.839', '', 'giangnh@nkxlock.com', '', '1', '1450173233');
INSERT INTO `web_supplier` VALUES ('826', 'Beurer', 'vvvvv', '', 'vvvv', '', '1', '1450231478');
INSERT INTO `web_supplier` VALUES ('827', 'Nuk', '08. 3970 8925', '08. 3970 8925', '', '', '1', '1450235533');
INSERT INTO `web_supplier` VALUES ('828', 'Công Ty TNHH Vạn Thiên Sa', '08 7515049', '08 7515049', '', '', '1', '1450327669');
INSERT INTO `web_supplier` VALUES ('829', 'Edena', '0935191626', '', 'thanhnhon@edena.com.vn', '', '1', '1450327798');
INSERT INTO `web_supplier` VALUES ('830', 'Eufood', '741', '', 'ewe', '', '1', '1450339812');
INSERT INTO `web_supplier` VALUES ('831', 'CROWN SPACE', '043.9289259', '043.9289259', '', '', '1', '1450347340');
INSERT INTO `web_supplier` VALUES ('832', 'Vita Fruits', 'trt', '', 'gftghfgh', '', '1', '1450413300');
INSERT INTO `web_supplier` VALUES ('833', 'Rapoo', '11111111111111111111', '', '1111111111111111111111111111111111111', '', '1', '1450422413');
INSERT INTO `web_supplier` VALUES ('834', 'IEA', '0945637799', '0945637799', 'quanghai.iea@gmail.com', 'www.iea.com.vn', '1', '1450515728');
INSERT INTO `web_supplier` VALUES ('835', 'MODULO HOME', '(84) 8. 66 83 97 50', '(84) 8. 66 83 97 50', 'nam.bui@bnfurniture.net', 'http://www.modulohome.com/', '1', '1450521624');
INSERT INTO `web_supplier` VALUES ('836', 'Microlab', 'vsvsa', '', 'aaasa', '', '1', '1450678651');
INSERT INTO `web_supplier` VALUES ('837', 'Phụ kiện Samsung', '01233896666', '01233896666', 'sale@itvn.vn', '', '1', '1450683386');
INSERT INTO `web_supplier` VALUES ('838', 'Syn Style', '0945385050 - 0943935', '0945385050 - 0943935', '', '', '1', '1450687965');
INSERT INTO `web_supplier` VALUES ('839', 'Bébé Cadum', '0907036254', '', 'huongtt@hnfgroup.com.vn', '', '1', '1450693397');
INSERT INTO `web_supplier` VALUES ('840', 'CÔNG TY TNHH DỊCH VỤ PHÁT TRIỂN Á CHÂU', '08 3601 6018', '08 3601 6018', '', null, '1', '1450751518');
INSERT INTO `web_supplier` VALUES ('841', 'IQTOYS', 'LIUGM', '', 'KKED', '', '1', '1450751554');
INSERT INTO `web_supplier` VALUES ('842', 'Diamond', '123456789', '', 'hoa9@gmail.com', '', '1', '1450760181');
INSERT INTO `web_supplier` VALUES ('843', 'Công ty TNHH Lan Anh', '0987456295', '0987456295', 'phuongquyen92@gmail.com', '', '1', '1450771400');
INSERT INTO `web_supplier` VALUES ('844', 'Công ty Cổ phần Saiko Việt Nam', '04.37321795', '04.37321795', 'dohongquyen79@gmail.com', null, '1', '1450838728');
INSERT INTO `web_supplier` VALUES ('845', 'Yison', '0985575850', '', 'miptt@thanhmy.com.vn', '', '1', '1450855272');
INSERT INTO `web_supplier` VALUES ('846', 'Yoshikawa', '6565656565', '', '56565656565', '', '1', '1450858239');
INSERT INTO `web_supplier` VALUES ('847', 'GoodLife', '08. 3895 3356', '08. 3895 3356', 'dangxuanhinh@gmail.com', '', '1', '1450933227');
INSERT INTO `web_supplier` VALUES ('848', 'ZEBRA', '08. 3834 6118', '08. 3834 6118', 'hang-inoxnt.com.vn', '', '1', '1450933940');
INSERT INTO `web_supplier` VALUES ('849', 'CÔNG TY CỔ PHẦN DEBORAH', '043.783.1461', '043.783.1461', 'info@deborah.vn', null, '1', '1450944051');
INSERT INTO `web_supplier` VALUES ('850', 'Bosi', 'acc', '', 'avc', '', '1', '1451008907');
INSERT INTO `web_supplier` VALUES ('851', 'GLASSLOCK', '04 3785 1555', '04 3785 1555', '', '', '1', '1451026785');
INSERT INTO `web_supplier` VALUES ('852', 'Công ty TNHH Thương mại và Hữu Nghị Lê Gia', '0936 433 503', '0936 433 503', 'quanghanh259@gmail.com', null, '1', '1451045644');
INSERT INTO `web_supplier` VALUES ('853', 'Soylove', 'vb', '', 'vb', '', '1', '1451046489');
INSERT INTO `web_supplier` VALUES ('854', 'Tefal', 'qưqưqưq', '', 'qưqq', '', '1', '1451047775');
INSERT INTO `web_supplier` VALUES ('855', 'Braun Việt Nam', 'ccccc', '', 'cccc', '', '1', '1451051133');
INSERT INTO `web_supplier` VALUES ('856', 'PEACE WORLD', '(08)39846010', '(08)39846010', 'beptietkiem@gmail.com', 'www.peaceworld.com.vn', '1', '1451109647');
INSERT INTO `web_supplier` VALUES ('857', 'LAVAR', '08 3601 9799', '08 3601 9799', 'pei.finance@gmail.com', 'http://pei.vn', '1', '1451110677');
INSERT INTO `web_supplier` VALUES ('858', 'Braun', '11111111', '', 'abcxyz', '', '1', '1451442183');
INSERT INTO `web_supplier` VALUES ('859', 'Severin', '22222222', '', 'zxcvbnm', '', '1', '1451442254');
INSERT INTO `web_supplier` VALUES ('860', 'CÔNG TY TNHH MTV NHIỆM MẦU', '(08) 399 399 19', '(08) 399 399 19', 'info@miraclediamond.vn', null, '1', '1451449726');
INSERT INTO `web_supplier` VALUES ('861', 'CÔNG TY CỔ PHẦN THIẾT BỊ KỸ THUẬT VÀ ĐỒ CHƠI AN TO', '84 0996959079', '84 0996959079', '', null, '1', '1451530132');
INSERT INTO `web_supplier` VALUES ('862', 'ANTONA', 'MUR6', '', 'JYDEJ', '', '1', '1451530539');
INSERT INTO `web_supplier` VALUES ('863', 'Woody', '08 3727 3730', '08 3727 3730', 'info@happytimevn.com', '', '1', '1451536979');
INSERT INTO `web_supplier` VALUES ('864', 'CÔNG TY TNHH MẬT ONG MANUKA ANZ', '08 3559 4415', '08 3559 4415', '', null, '1', '1451806971');
INSERT INTO `web_supplier` VALUES ('865', 'Công ty cổ phần phát triển Ong miền núi', '043.5651749', '043.5651749', '', null, '1', '1451807462');
INSERT INTO `web_supplier` VALUES ('866', 'CÔNG TY CỔ PHẦN SAGASO', '0839401368', '0839401368', '', null, '1', '1451808165');
INSERT INTO `web_supplier` VALUES ('867', 'Khang Nhung Mobile', '0975700899', '0975700899', '', '', '1', '1451835954');
INSERT INTO `web_supplier` VALUES ('868', 'CÔNG TY CP THIẾT BỊ CHĂM SÓC SỨC KHỎE SỐ 1', '7341210', '7341210', '', null, '1', '1451880103');
INSERT INTO `web_supplier` VALUES ('869', 'THỦY TINH NGỌC', 'UIO', '', 'TÊNR', '', '1', '1451883842');
INSERT INTO `web_supplier` VALUES ('870', 'La Fonte', 'ácv', '', 'acvbn', '', '1', '1451975590');
INSERT INTO `web_supplier` VALUES ('871', 'Rachael Ray', 'zxcccccccc', '', 'vvvvvvvvvvvxxxxx', '', '1', '1451979827');
INSERT INTO `web_supplier` VALUES ('872', 'Indochina Sài Gòn', 'hjhjhjhjhj', '', 'hjhjhjhj', '', '1', '1451982866');
INSERT INTO `web_supplier` VALUES ('873', 'ĐỒ CHƠI TRẺ EM AND', '0942003286', '0942003286', '', null, '1', '1452072948');
INSERT INTO `web_supplier` VALUES ('874', 'Công ty CP KD TM &amp; DV Thuận Hưng', 'sdfsfsd', '', 'fsdfsdf', '', '1', '1452102310');
INSERT INTO `web_supplier` VALUES ('875', 'Công ty TNHH SAKI', '04-38684459', '04-38684459', 'info@saki.net.vn', null, '1', '1452135938');
INSERT INTO `web_supplier` VALUES ('876', 'PTA', 'KIK', '', 'JYRJ', '', '1', '1452137335');
INSERT INTO `web_supplier` VALUES ('877', 'Saki', 'hk', '', 'hk', '', '1', '1452137782');
INSERT INTO `web_supplier` VALUES ('878', 'TOMMEE TIPPEE', '123456', '', '456789', '', '1', '1452153211');
INSERT INTO `web_supplier` VALUES ('879', 'Công Ty TNHH Dệt May Phương Đông', '08. 3762 2249 - 08. ', '08. 3762 2249 - 08. ', '', null, '1', '1452222771');
INSERT INTO `web_supplier` VALUES ('880', 'willendrof', '(08) 3758 0239', '(08) 3758 0239', '', '', '1', '1452237977');
INSERT INTO `web_supplier` VALUES ('881', 'Kangaroo', '0436281699', '0436281699', 'nguyenngoctu@kangaroo.vn', '', '1', '1452272056');
INSERT INTO `web_supplier` VALUES ('882', 'Hộ kinh doanh Nguyễn Tuấn Anh', '0932252286 - 0968585', '0932252286 - 0968585', '', null, '1', '1452439960');
INSERT INTO `web_supplier` VALUES ('883', 'New Life', '08. 6298 9577', '08. 6298 9577', 'newlifetphcm@gmail.com', '', '1', '1452479571');
INSERT INTO `web_supplier` VALUES ('884', 'RELAXSAN', '1456768', '', '55477798', '', '1', '1452481730');
INSERT INTO `web_supplier` VALUES ('885', 'BeneCheck', '987564', '', '12358', '', '1', '1452481955');
INSERT INTO `web_supplier` VALUES ('886', 'VUPIESSE', '14566', '', 'vhj', '', '1', '1452482240');
INSERT INTO `web_supplier` VALUES ('887', 'Công ty TNHH lông vũ Anh và Em', '04 62816115', '04 62816115', '', null, '1', '1452484545');
INSERT INTO `web_supplier` VALUES ('888', 'Peace’s BY HVTB', '08. 3839 05904', '08. 3839 05904', 'thaibinhhoangvu@gmail.com', '', '1', '1452485479');
INSERT INTO `web_supplier` VALUES ('889', 'Auldey', '789523', '', '15879', '', '1', '1452501150');
INSERT INTO `web_supplier` VALUES ('890', 'Công ty TNHH PBH Việt Nam', '04.6259.8614', '04.6259.8614', 'pbhoutdoor@gmail.com', null, '1', '1452734310');
INSERT INTO `web_supplier` VALUES ('891', 'Công ty TNHH Thể thao Đức Trung', '043.935.0506', '043.935.0506', 'trungnd@dtgroup.vn', null, '1', '1452737490');
INSERT INTO `web_supplier` VALUES ('892', 'Tiko', '08. 3923 9229', '08. 3923 9229', '', '', '1', '1452738770');
INSERT INTO `web_supplier` VALUES ('893', 'Sport1', 'yu', '', 'yu', '', '1', '1452749733');
INSERT INTO `web_supplier` VALUES ('894', 'HASA Fashion', '0437164399', '0437164399', '', '', '1', '1452759359');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores support online content.';

-- ----------------------------
-- Records of web_support_online
-- ----------------------------
INSERT INTO `web_support_online` VALUES ('1', '1', null, 'Nguyen Duy', null, 'pt.soleil', 'nguyenduypt86', null, '0913922986', 'nguyenduypt86@gmail.com', '1459144973', '1', null, '1');

-- ----------------------------
-- Table structure for web_user_shop
-- ----------------------------
DROP TABLE IF EXISTS `web_user_shop`;
CREATE TABLE `web_user_shop` (
  `shop_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(250) DEFAULT NULL COMMENT 'Tên shop, cửa hàng hiển thị',
  `user_shop` varchar(100) DEFAULT NULL COMMENT 'Tên dăng nhập của shop',
  `user_password` varchar(100) DEFAULT NULL,
  `shop_phone` varchar(20) DEFAULT NULL,
  `shop_address` varchar(255) DEFAULT NULL,
  `shop_email` varchar(100) DEFAULT NULL,
  `shop_province` int(10) DEFAULT NULL COMMENT 'tinh thanh',
  `shop_category` int(11) DEFAULT '0' COMMENT 'Danh mục của shop đang sửa dụng',
  `shop_about` text COMMENT 'gioi thieu shop',
  `shop_transfer` text,
  `number_limit_product` int(11) DEFAULT '12' COMMENT 'Giới hạn số lượng sản phẩm trong shop: 0: shop vip, 12: shop free',
  `is_shop` tinyint(1) DEFAULT '0' COMMENT '0-thuong, 1-vip',
  `is_login` tinyint(1) DEFAULT '0' COMMENT '0:not login, 1:login',
  `time_access` int(12) DEFAULT '0' COMMENT 'time access login ok',
  `shop_status` tinyint(1) DEFAULT '0' COMMENT '0-an, 1-hoat dong, 2-khoa',
  `shop_created` int(12) DEFAULT NULL COMMENT 'Ngày tạo',
  `time_start_vip` int(12) DEFAULT NULL COMMENT 'Ngày bắt đầu vip',
  `time_end_vip` int(12) DEFAULT NULL COMMENT 'Ngày hết hạn vip',
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_user_shop
-- ----------------------------
INSERT INTO `web_user_shop` VALUES ('4', 'Shop Teen', 'nguyenduy', '$S$DaBjYpXX5iV926/deKctbCPOUdJtIp4oH.sSMY2Z5WWnjxAIFoUk', '0913922986', null, 'nguyenduypt86@gmail.com', '1', '0', null, null, '12', '0', '1', '1459173229', '0', '1458564097', null, null);
INSERT INTO `web_user_shop` VALUES ('5', null, 'shop_manhquynh', '$S$Dh3CQmErCXbk6oSlZsdNth5QdwuhdmBaPCwyPIOcVmCW2g3DnXJp', '0938413368', null, 'manhquynh1984@gmail.com', '22', '0', null, null, '12', '0', '0', '0', '0', '1459258585', null, null);