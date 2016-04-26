-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Apr 26, 2016 at 02:39 PM
-- Server version: 5.5.48-cll
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `shopcuat_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `actions`
--

CREATE TABLE IF NOT EXISTS `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';

--
-- Dumping data for table `actions`
--

INSERT INTO `actions` (`aid`, `type`, `callback`, `parameters`, `label`) VALUES
('comment_publish_action', 'comment', 'comment_publish_action', '', 'Publish comment'),
('comment_save_action', 'comment', 'comment_save_action', '', 'Save comment'),
('comment_unpublish_action', 'comment', 'comment_unpublish_action', '', 'Unpublish comment'),
('node_make_sticky_action', 'node', 'node_make_sticky_action', '', 'Make content sticky'),
('node_make_unsticky_action', 'node', 'node_make_unsticky_action', '', 'Make content unsticky'),
('node_promote_action', 'node', 'node_promote_action', '', 'Promote content to front page'),
('node_publish_action', 'node', 'node_publish_action', '', 'Publish content'),
('node_save_action', 'node', 'node_save_action', '', 'Save content'),
('node_unpromote_action', 'node', 'node_unpromote_action', '', 'Remove content from front page'),
('node_unpublish_action', 'node', 'node_unpublish_action', '', 'Unpublish content'),
('system_block_ip_action', 'user', 'system_block_ip_action', '', 'Ban IP address of current user'),
('user_block_user_action', 'user', 'user_block_user_action', '', 'Block current user');

-- --------------------------------------------------------

--
-- Table structure for table `authmap`
--

CREATE TABLE IF NOT EXISTS `authmap` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `authname` (`authname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `batch`
--

CREATE TABLE IF NOT EXISTS `batch` (
  `bid` int(10) unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
  PRIMARY KEY (`bid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';

-- --------------------------------------------------------

--
-- Table structure for table `block`
--

CREATE TABLE IF NOT EXISTS `block` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...' AUTO_INCREMENT=94 ;

--
-- Dumping data for table `block`
--

INSERT INTO `block` (`bid`, `module`, `delta`, `theme`, `status`, `weight`, `region`, `custom`, `visibility`, `pages`, `title`, `cache`) VALUES
(1, 'system', 'main', 'bartik', 1, 0, 'content', 0, 0, '', '', -1),
(2, 'search', 'form', 'bartik', 1, -1, 'sidebar_first', 0, 0, '', '', -1),
(3, 'node', 'recent', 'seven', 1, 10, 'dashboard_main', 0, 0, '', '', -1),
(4, 'user', 'login', 'bartik', 1, 0, 'sidebar_first', 0, 1, 'user', '<none>', -1),
(5, 'system', 'navigation', 'bartik', 1, 0, 'sidebar_first', 0, 0, '', '', -1),
(6, 'system', 'powered-by', 'bartik', 1, 10, 'footer', 0, 0, '', '', -1),
(7, 'system', 'help', 'bartik', 1, 0, 'help', 0, 0, '', '', -1),
(8, 'system', 'main', 'seven', 1, 0, 'content', 0, 0, '', '', -1),
(9, 'system', 'help', 'seven', 1, 0, 'help', 0, 0, '', '', -1),
(10, 'user', 'login', 'seven', 1, 10, 'content', 0, 1, 'user', '<none>', -1),
(11, 'user', 'new', 'seven', 1, 0, 'dashboard_sidebar', 0, 0, '', '', -1),
(12, 'search', 'form', 'seven', 1, -10, 'dashboard_sidebar', 0, 0, '', '', -1),
(13, 'comment', 'recent', 'bartik', 0, 0, '-1', 0, 0, '', '', 1),
(14, 'node', 'syndicate', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(15, 'node', 'recent', 'bartik', 0, 0, '-1', 0, 0, '', '', 1),
(16, 'shortcut', 'shortcuts', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(17, 'system', 'management', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(18, 'system', 'user-menu', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(19, 'system', 'main-menu', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(20, 'user', 'new', 'bartik', 0, 0, '-1', 0, 0, '', '', 1),
(21, 'user', 'online', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(22, 'comment', 'recent', 'seven', 1, 0, 'dashboard_inactive', 0, 0, '', '', 1),
(23, 'node', 'syndicate', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(24, 'shortcut', 'shortcuts', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(25, 'system', 'powered-by', 'seven', 0, 10, '-1', 0, 0, '', '', -1),
(26, 'system', 'navigation', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(27, 'system', 'management', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(28, 'system', 'user-menu', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(29, 'system', 'main-menu', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(30, 'user', 'online', 'seven', 1, 0, 'dashboard_inactive', 0, 0, '', '', -1),
(31, 'HSSCore', 'admin-header', 'bartik', 1, 0, 'header', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(32, 'HSSCore', 'admin-left', 'bartik', 0, 0, '-1', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(33, 'HSSCore', 'admin-content', 'bartik', 1, 0, 'content', 0, 1, 'admincp', '<none>', 1),
(34, 'HSSCore', 'admin-footer', 'bartik', 1, 0, 'footer', 0, 1, '', '', 1),
(35, 'HSSCore', 'admin-header', 'seven', 0, 0, '-1', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(36, 'HSSCore', 'admin-left', 'seven', 0, 0, '-1', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(37, 'HSSCore', 'admin-content', 'seven', 1, 0, 'content', 0, 1, 'admincp', '<none>', 1),
(38, 'HSSCore', 'admin-footer', 'seven', 0, 0, '-1', 0, 1, '', '', 1),
(39, 'comment', 'recent', 'theme_default', 0, 0, '-1', 0, 0, '', '', 1),
(40, 'HSSCore', 'admin-content', 'theme_default', 1, 0, 'content', 0, 1, 'admincp', '<none>', 1),
(41, 'HSSCore', 'admin-footer', 'theme_default', 0, 0, '-1', 0, 1, '', '', 1),
(42, 'HSSCore', 'admin-header', 'theme_default', 1, 0, 'header', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(43, 'HSSCore', 'admin-left', 'theme_default', 1, 0, 'left', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(44, 'node', 'recent', 'theme_default', 0, 0, '-1', 0, 0, '', '', 1),
(45, 'node', 'syndicate', 'theme_default', 0, 0, '-1', 0, 0, '', '', -1),
(46, 'search', 'form', 'theme_default', 0, -1, '-1', 0, 0, '', '', -1),
(47, 'shortcut', 'shortcuts', 'theme_default', 0, 0, '-1', 0, 0, '', '', -1),
(48, 'system', 'help', 'theme_default', 0, 0, '-1', 0, 0, '', '', -1),
(49, 'system', 'main', 'theme_default', 1, 0, 'content', 0, 0, '', '', -1),
(50, 'system', 'main-menu', 'theme_default', 0, 0, '-1', 0, 0, '', '', -1),
(51, 'system', 'management', 'theme_default', 0, 0, '-1', 0, 0, '', '', -1),
(52, 'system', 'navigation', 'theme_default', 0, 0, '-1', 0, 0, '', '', -1),
(53, 'system', 'powered-by', 'theme_default', 0, 10, '-1', 0, 0, '', '', -1),
(54, 'system', 'user-menu', 'theme_default', 0, 0, '-1', 0, 0, '', '', -1),
(55, 'user', 'login', 'theme_default', 1, 0, 'content', 0, 1, 'user', '<none>', -1),
(56, 'user', 'new', 'theme_default', 0, 0, '-1', 0, 0, '', '', 1),
(57, 'user', 'online', 'theme_default', 0, 0, '-1', 0, 0, '', '', -1),
(58, 'Core', 'admin-header', 'bartik', 1, 0, 'header', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(59, 'Core', 'admin-left', 'bartik', 0, 0, '-1', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(60, 'Core', 'admin-content', 'bartik', 1, 0, 'content', 0, 1, 'admincp', '<none>', 1),
(61, 'Core', 'admin-footer', 'bartik', 1, 0, 'footer', 0, 1, '', '', 1),
(62, 'Core', 'admin-header', 'seven', 0, 0, '-1', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(63, 'Core', 'admin-left', 'seven', 0, 0, '-1', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(64, 'Core', 'admin-content', 'seven', 1, 0, 'content', 0, 1, 'admincp', '<none>', 1),
(65, 'Core', 'admin-footer', 'seven', 0, 0, '-1', 0, 1, '', '', 1),
(66, 'Core', 'admin-header', 'theme_default', 1, 0, 'header', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(67, 'Core', 'admin-left', 'theme_default', 1, 0, 'left', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(68, 'Core', 'admin-content', 'theme_default', 1, 0, 'content', 0, 1, 'admincp', '<none>', 1),
(69, 'Core', 'admin-footer', 'theme_default', 0, 0, '-1', 0, 1, '', '', 1),
(70, 'Site', 'block-header', 'bartik', 1, 0, 'header', 0, 0, 'admin\r\nadmin/*\r\nadmincp\r\nadmincp/*\r\ndang-san-pham.html\r\nquan-ly-gian-hang.html\r\nsua-thong-tin-gian-hang.html\r\nsua-san-pham/*', '<none>', 1),
(71, 'Site', 'block-slide', 'bartik', 1, 0, 'content', 0, 1, '<front>', '<none>', 1),
(72, 'Site', 'block-content', 'bartik', 1, 0, 'content', 0, 1, '<front>', '<none>', 1),
(73, 'Site', 'block-footer', 'bartik', 1, 0, 'footer', 0, 0, 'admin\r\nadmin/*\r\nadmincp\r\nadmincp/*\r\ndang-san-pham.html\r\nquan-ly-gian-hang.html\r\nsua-san-pham/*', '<none>', 1),
(74, 'Site', 'block-header', 'seven', 0, 0, '-1', 0, 0, 'admin\r\nadmin/*\r\nadmincp\r\nadmincp/*\r\ndang-san-pham.html\r\nquan-ly-gian-hang.html\r\nsua-thong-tin-gian-hang.html\r\nsua-san-pham/*', '<none>', 1),
(75, 'Site', 'block-slide', 'seven', 1, 0, 'content', 0, 1, '<front>', '<none>', 1),
(76, 'Site', 'block-content', 'seven', 1, 0, 'content', 0, 1, '<front>', '<none>', 1),
(77, 'Site', 'block-footer', 'seven', 0, 0, '-1', 0, 0, 'admin\r\nadmin/*\r\nadmincp\r\nadmincp/*\r\ndang-san-pham.html\r\nquan-ly-gian-hang.html\r\nsua-san-pham/*', '<none>', 1),
(78, 'Site', 'block-header', 'theme_default', 1, 0, 'header', 0, 0, 'admin\r\nadmin/*\r\nadmincp\r\nadmincp/*\r\ndang-san-pham.html\r\nquan-ly-gian-hang.html\r\nsua-thong-tin-gian-hang.html\r\nsua-san-pham/*', '<none>', 1),
(79, 'Site', 'block-slide', 'theme_default', 1, 0, 'content', 0, 1, '<front>', '<none>', 1),
(80, 'Site', 'block-content', 'theme_default', 1, 0, 'content', 0, 1, '<front>', '<none>', 1),
(81, 'Site', 'block-footer', 'theme_default', 1, 0, 'footer', 0, 0, 'admin\r\nadmin/*\r\nadmincp\r\nadmincp/*\r\ndang-san-pham.html\r\nquan-ly-gian-hang.html\r\nsua-san-pham/*', '<none>', 1),
(82, 'Admin', 'admin-header', 'bartik', 1, 0, 'header', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(83, 'Admin', 'admin-left', 'bartik', 0, 0, '-1', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(84, 'Admin', 'admin-content', 'bartik', 1, 0, 'content', 0, 1, 'admincp', '<none>', 1),
(85, 'Admin', 'admin-footer', 'bartik', 1, 0, 'footer', 0, 1, '', '', 1),
(86, 'Admin', 'admin-header', 'seven', 0, 0, '-1', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(87, 'Admin', 'admin-left', 'seven', 0, 0, '-1', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(88, 'Admin', 'admin-content', 'seven', 1, 0, 'content', 0, 1, 'admincp', '<none>', 1),
(89, 'Admin', 'admin-footer', 'seven', 0, 0, '-1', 0, 1, '', '', 1),
(90, 'Admin', 'admin-header', 'theme_default', 1, 0, 'header', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(91, 'Admin', 'admin-left', 'theme_default', 1, 0, 'left', 0, 1, 'admincp\r\nadmincp/*', '<none>', 1),
(92, 'Admin', 'admin-content', 'theme_default', 1, 0, 'content', 0, 1, 'admincp', '<none>', 1),
(93, 'Admin', 'admin-footer', 'theme_default', 1, 0, 'footer', 0, 1, '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `blocked_ips`
--

CREATE TABLE IF NOT EXISTS `blocked_ips` (
  `iid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address',
  PRIMARY KEY (`iid`),
  KEY `blocked_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `block_custom`
--

CREATE TABLE IF NOT EXISTS `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `block_node_type`
--

CREATE TABLE IF NOT EXISTS `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';

-- --------------------------------------------------------

--
-- Table structure for table `block_role`
--

CREATE TABLE IF NOT EXISTS `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) unsigned NOT NULL COMMENT 'The user’s role ID from users_roles.rid.',
  PRIMARY KEY (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE IF NOT EXISTS `cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_block`
--

CREATE TABLE IF NOT EXISTS `cache_block` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_bootstrap`
--

CREATE TABLE IF NOT EXISTS `cache_bootstrap` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_field`
--

CREATE TABLE IF NOT EXISTS `cache_field` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Field module to store already built...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_filter`
--

CREATE TABLE IF NOT EXISTS `cache_filter` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_form`
--

CREATE TABLE IF NOT EXISTS `cache_form` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_image`
--

CREATE TABLE IF NOT EXISTS `cache_image` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_menu`
--

CREATE TABLE IF NOT EXISTS `cache_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_page`
--

CREATE TABLE IF NOT EXISTS `cache_page` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';

-- --------------------------------------------------------

--
-- Table structure for table `cache_path`
--

CREATE TABLE IF NOT EXISTS `cache_path` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores comments and associated data.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `date_formats`
--

CREATE TABLE IF NOT EXISTS `date_formats` (
  `dfid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.',
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this format can be modified.',
  PRIMARY KEY (`dfid`),
  UNIQUE KEY `formats` (`format`,`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.' AUTO_INCREMENT=36 ;

--
-- Dumping data for table `date_formats`
--

INSERT INTO `date_formats` (`dfid`, `format`, `type`, `locked`) VALUES
(1, 'Y-m-d H:i', 'short', 1),
(2, 'm/d/Y - H:i', 'short', 1),
(3, 'd/m/Y - H:i', 'short', 1),
(4, 'Y/m/d - H:i', 'short', 1),
(5, 'd.m.Y - H:i', 'short', 1),
(6, 'm/d/Y - g:ia', 'short', 1),
(7, 'd/m/Y - g:ia', 'short', 1),
(8, 'Y/m/d - g:ia', 'short', 1),
(9, 'M j Y - H:i', 'short', 1),
(10, 'j M Y - H:i', 'short', 1),
(11, 'Y M j - H:i', 'short', 1),
(12, 'M j Y - g:ia', 'short', 1),
(13, 'j M Y - g:ia', 'short', 1),
(14, 'Y M j - g:ia', 'short', 1),
(15, 'D, Y-m-d H:i', 'medium', 1),
(16, 'D, m/d/Y - H:i', 'medium', 1),
(17, 'D, d/m/Y - H:i', 'medium', 1),
(18, 'D, Y/m/d - H:i', 'medium', 1),
(19, 'F j, Y - H:i', 'medium', 1),
(20, 'j F, Y - H:i', 'medium', 1),
(21, 'Y, F j - H:i', 'medium', 1),
(22, 'D, m/d/Y - g:ia', 'medium', 1),
(23, 'D, d/m/Y - g:ia', 'medium', 1),
(24, 'D, Y/m/d - g:ia', 'medium', 1),
(25, 'F j, Y - g:ia', 'medium', 1),
(26, 'j F Y - g:ia', 'medium', 1),
(27, 'Y, F j - g:ia', 'medium', 1),
(28, 'j. F Y - G:i', 'medium', 1),
(29, 'l, F j, Y - H:i', 'long', 1),
(30, 'l, j F, Y - H:i', 'long', 1),
(31, 'l, Y,  F j - H:i', 'long', 1),
(32, 'l, F j, Y - g:ia', 'long', 1),
(33, 'l, j F Y - g:ia', 'long', 1),
(34, 'l, Y,  F j - g:ia', 'long', 1),
(35, 'l, j. F Y - G:i', 'long', 1);

-- --------------------------------------------------------

--
-- Table structure for table `date_format_locale`
--

CREATE TABLE IF NOT EXISTS `date_format_locale` (
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A languages.language for this format to be used with.',
  PRIMARY KEY (`type`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';

-- --------------------------------------------------------

--
-- Table structure for table `date_format_type`
--

CREATE TABLE IF NOT EXISTS `date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this is a system provided format.',
  PRIMARY KEY (`type`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';

--
-- Dumping data for table `date_format_type`
--

INSERT INTO `date_format_type` (`type`, `title`, `locked`) VALUES
('long', 'Long', 1),
('medium', 'Medium', 1),
('short', 'Short', 1);

-- --------------------------------------------------------

--
-- Table structure for table `field_config`
--

CREATE TABLE IF NOT EXISTS `field_config` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `field_config`
--

INSERT INTO `field_config` (`id`, `field_name`, `type`, `module`, `active`, `storage_type`, `storage_module`, `storage_active`, `locked`, `data`, `cardinality`, `translatable`, `deleted`) VALUES
(1, 'comment_body', 'text_long', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a31323a22656e746974795f7479706573223b613a313a7b693a303b733a373a22636f6d6d656e74223b7d733a31323a227472616e736c617461626c65223b623a303b733a383a2273657474696e6773223b613a303a7b7d733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d7d, 1, 0, 0),
(2, 'body', 'text_with_summary', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a31323a22656e746974795f7479706573223b613a313a7b693a303b733a343a226e6f6465223b7d733a31323a227472616e736c617461626c65223b623a303b733a383a2273657474696e6773223b613a303a7b7d733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d7d, 1, 0, 0),
(3, 'field_tags', 'taxonomy_term_reference', 'taxonomy', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a383a2273657474696e6773223b613a313a7b733a31343a22616c6c6f7765645f76616c756573223b613a313a7b693a303b613a323a7b733a31303a22766f636162756c617279223b733a343a2274616773223b733a363a22706172656e74223b693a303b7d7d7d733a31323a22656e746974795f7479706573223b613a303a7b7d733a31323a227472616e736c617461626c65223b623a303b733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22666f726569676e206b657973223b613a313a7b733a333a22746964223b613a323a7b733a353a227461626c65223b733a31383a227461786f6e6f6d795f7465726d5f64617461223b733a373a22636f6c756d6e73223b613a313a7b733a333a22746964223b733a333a22746964223b7d7d7d733a373a22696e6465786573223b613a313a7b733a333a22746964223b613a313a7b693a303b733a333a22746964223b7d7d7d, -1, 0, 0),
(4, 'field_image', 'image', 'image', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a373a22696e6465786573223b613a313a7b733a333a22666964223b613a313a7b693a303b733a333a22666964223b7d7d733a383a2273657474696e6773223b613a323a7b733a31303a227572695f736368656d65223b733a363a227075626c6963223b733a31333a2264656661756c745f696d616765223b623a303b7d733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22656e746974795f7479706573223b613a303a7b7d733a31323a227472616e736c617461626c65223b623a303b733a31323a22666f726569676e206b657973223b613a313a7b733a333a22666964223b613a323a7b733a353a227461626c65223b733a31323a2266696c655f6d616e61676564223b733a373a22636f6c756d6e73223b613a313a7b733a333a22666964223b733a333a22666964223b7d7d7d7d, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `field_config_instance`
--

CREATE TABLE IF NOT EXISTS `field_config_instance` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `field_config_instance`
--

INSERT INTO `field_config_instance` (`id`, `field_id`, `field_name`, `entity_type`, `bundle`, `data`, `deleted`) VALUES
(1, 1, 'comment_body', 'comment', 'comment_node_page', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(2, 2, 'body', 'node', 'page', 0x613a363a7b733a353a226c6162656c223b733a343a22426f6479223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b693a32303b733a31323a2273756d6d6172795f726f7773223b693a353b7d733a363a22776569676874223b693a2d343b733a363a226d6f64756c65223b733a343a2274657874223b7d733a383a2273657474696e6773223b613a333a7b733a31353a22646973706c61795f73756d6d617279223b623a313b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32333a22746578745f73756d6d6172795f6f725f7472696d6d6564223b733a383a2273657474696e6773223b613a313a7b733a31313a227472696d5f6c656e677468223b693a3630303b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d7d733a383a227265717569726564223b623a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(3, 1, 'comment_body', 'comment', 'comment_node_article', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(4, 2, 'body', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a343a22426f6479223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b693a32303b733a31323a2273756d6d6172795f726f7773223b693a353b7d733a363a22776569676874223b693a2d343b733a363a226d6f64756c65223b733a343a2274657874223b7d733a383a2273657474696e6773223b613a333a7b733a31353a22646973706c61795f73756d6d617279223b623a313b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32333a22746578745f73756d6d6172795f6f725f7472696d6d6564223b733a383a2273657474696e6773223b613a313a7b733a31313a227472696d5f6c656e677468223b693a3630303b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d7d733a383a227265717569726564223b623a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(5, 3, 'field_tags', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a343a2254616773223b733a31313a226465736372697074696f6e223b733a36333a22456e746572206120636f6d6d612d736570617261746564206c697374206f6620776f72647320746f20646573637269626520796f757220636f6e74656e742e223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32313a227461786f6e6f6d795f6175746f636f6d706c657465223b733a363a22776569676874223b693a2d343b733a383a2273657474696e6773223b613a323a7b733a343a2273697a65223b693a36303b733a31373a226175746f636f6d706c6574655f70617468223b733a32313a227461786f6e6f6d792f6175746f636f6d706c657465223b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b693a31303b733a353a226c6162656c223b733a353a2261626f7665223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a363a22746561736572223b613a353a7b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b693a31303b733a353a226c6162656c223b733a353a2261626f7665223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a303b7d, 0),
(6, 4, 'field_image', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a353a22496d616765223b733a31313a226465736372697074696f6e223b733a34303a2255706c6f616420616e20696d61676520746f20676f207769746820746869732061727469636c652e223b733a383a227265717569726564223b623a303b733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a31313a226669656c642f696d616765223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b623a313b733a31313a227469746c655f6669656c64223b733a303a22223b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d733a363a22776569676874223b693a2d313b733a363a226d6f64756c65223b733a353a22696d616765223b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a353a226c61726765223b733a31303a22696d6167655f6c696e6b223b733a303a22223b7d733a363a22776569676874223b693a2d313b733a363a226d6f64756c65223b733a353a22696d616765223b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a363a226d656469756d223b733a31303a22696d6167655f6c696e6b223b733a373a22636f6e74656e74223b7d733a363a22776569676874223b693a2d313b733a363a226d6f64756c65223b733a353a22696d616765223b7d7d7d, 0);

-- --------------------------------------------------------

--
-- Table structure for table `field_data_body`
--

CREATE TABLE IF NOT EXISTS `field_data_body` (
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

-- --------------------------------------------------------

--
-- Table structure for table `field_data_comment_body`
--

CREATE TABLE IF NOT EXISTS `field_data_comment_body` (
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

-- --------------------------------------------------------

--
-- Table structure for table `field_data_field_image`
--

CREATE TABLE IF NOT EXISTS `field_data_field_image` (
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

-- --------------------------------------------------------

--
-- Table structure for table `field_data_field_tags`
--

CREATE TABLE IF NOT EXISTS `field_data_field_tags` (
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

-- --------------------------------------------------------

--
-- Table structure for table `field_revision_body`
--

CREATE TABLE IF NOT EXISTS `field_revision_body` (
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

-- --------------------------------------------------------

--
-- Table structure for table `field_revision_comment_body`
--

CREATE TABLE IF NOT EXISTS `field_revision_comment_body` (
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

-- --------------------------------------------------------

--
-- Table structure for table `field_revision_field_image`
--

CREATE TABLE IF NOT EXISTS `field_revision_field_image` (
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

-- --------------------------------------------------------

--
-- Table structure for table `field_revision_field_tags`
--

CREATE TABLE IF NOT EXISTS `field_revision_field_tags` (
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

-- --------------------------------------------------------

--
-- Table structure for table `file_managed`
--

CREATE TABLE IF NOT EXISTS `file_managed` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `file_usage`
--

CREATE TABLE IF NOT EXISTS `file_usage` (
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

-- --------------------------------------------------------

--
-- Table structure for table `filter`
--

CREATE TABLE IF NOT EXISTS `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';

--
-- Dumping data for table `filter`
--

INSERT INTO `filter` (`format`, `module`, `name`, `weight`, `status`, `settings`) VALUES
('filtered_html', 'filter', 'filter_autop', 2, 1, 0x613a303a7b7d),
('filtered_html', 'filter', 'filter_html', 1, 1, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('filtered_html', 'filter', 'filter_htmlcorrector', 10, 1, 0x613a303a7b7d),
('filtered_html', 'filter', 'filter_html_escape', -10, 0, 0x613a303a7b7d),
('filtered_html', 'filter', 'filter_url', 0, 1, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d),
('full_html', 'filter', 'filter_autop', 1, 1, 0x613a303a7b7d),
('full_html', 'filter', 'filter_html', -10, 0, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('full_html', 'filter', 'filter_htmlcorrector', 10, 1, 0x613a303a7b7d),
('full_html', 'filter', 'filter_html_escape', -10, 0, 0x613a303a7b7d),
('full_html', 'filter', 'filter_url', 0, 1, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d),
('plain_text', 'filter', 'filter_autop', 2, 1, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_html', -10, 0, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('plain_text', 'filter', 'filter_htmlcorrector', 10, 0, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_html_escape', 0, 1, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_url', 1, 1, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d);

-- --------------------------------------------------------

--
-- Table structure for table `filter_format`
--

CREATE TABLE IF NOT EXISTS `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';

--
-- Dumping data for table `filter_format`
--

INSERT INTO `filter_format` (`format`, `name`, `cache`, `status`, `weight`) VALUES
('filtered_html', 'Filtered HTML', 1, 1, 0),
('full_html', 'Full HTML', 1, 1, 1),
('plain_text', 'Plain text', 1, 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `flood`
--

CREATE TABLE IF NOT EXISTS `flood` (
  `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.',
  PRIMARY KEY (`fid`),
  KEY `allow` (`event`,`identifier`,`timestamp`),
  KEY `purge` (`expiration`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...' AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE IF NOT EXISTS `history` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that read the node nid.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.',
  PRIMARY KEY (`uid`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which users have read which nodes.';

-- --------------------------------------------------------

--
-- Table structure for table `image_effects`
--

CREATE TABLE IF NOT EXISTS `image_effects` (
  `ieid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `image_styles`
--

CREATE TABLE IF NOT EXISTS `image_styles` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style machine name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `menu_custom`
--

CREATE TABLE IF NOT EXISTS `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';

--
-- Dumping data for table `menu_custom`
--

INSERT INTO `menu_custom` (`menu_name`, `title`, `description`) VALUES
('main-menu', 'Main menu', 'The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.'),
('management', 'Management', 'The <em>Management</em> menu contains links for administrative tasks.'),
('navigation', 'Navigation', 'The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.'),
('user-menu', 'User menu', 'The <em>User</em> menu contains links related to the user''s account, as well as the ''Log out'' link.');

-- --------------------------------------------------------

--
-- Table structure for table `menu_links`
--

CREATE TABLE IF NOT EXISTS `menu_links` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.' AUTO_INCREMENT=325 ;

--
-- Dumping data for table `menu_links`
--

INSERT INTO `menu_links` (`menu_name`, `mlid`, `plid`, `link_path`, `router_path`, `link_title`, `options`, `module`, `hidden`, `external`, `has_children`, `expanded`, `weight`, `depth`, `customized`, `p1`, `p2`, `p3`, `p4`, `p5`, `p6`, `p7`, `p8`, `p9`, `updated`) VALUES
('management', 1, 0, 'admin', 'admin', 'Administration', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 9, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 2, 0, 'user', 'user', 'User account', 0x613a313a7b733a353a22616c746572223b623a313b7d, 'system', 0, 0, 0, 0, -10, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 3, 0, 'comment/%', 'comment/%', 'Comment permalink', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 1, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 4, 0, 'filter/tips', 'filter/tips', 'Compose tips', 0x613a303a7b7d, 'system', 1, 0, 1, 0, 0, 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 5, 0, 'node/%', 'node/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 6, 0, 'node/add', 'node/add', 'Add content', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 1, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 7, 1, 'admin/appearance', 'admin/appearance', 'Appearance', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33333a2253656c65637420616e6420636f6e66696775726520796f7572207468656d65732e223b7d7d, 'system', 0, 0, 0, 0, -6, 2, 0, 1, 7, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 8, 1, 'admin/config', 'admin/config', 'Configuration', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32303a2241646d696e69737465722073657474696e67732e223b7d7d, 'system', 0, 0, 1, 0, 0, 2, 0, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 9, 1, 'admin/content', 'admin/content', 'Content', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33323a2241646d696e697374657220636f6e74656e7420616e6420636f6d6d656e74732e223b7d7d, 'system', 0, 0, 1, 0, -10, 2, 0, 1, 9, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 10, 2, 'user/register', 'user/register', 'Create new account', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 2, 10, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 11, 1, 'admin/dashboard', 'admin/dashboard', 'Dashboard', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33343a225669657720616e6420637573746f6d697a6520796f75722064617368626f6172642e223b7d7d, 'system', 0, 0, 0, 0, -15, 2, 0, 1, 11, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 12, 1, 'admin/help', 'admin/help', 'Help', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34383a225265666572656e636520666f722075736167652c20636f6e66696775726174696f6e2c20616e64206d6f64756c65732e223b7d7d, 'system', 0, 0, 0, 0, 9, 2, 0, 1, 12, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 13, 1, 'admin/index', 'admin/index', 'Index', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -18, 2, 0, 1, 13, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 14, 2, 'user/login', 'user/login', 'Log in', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 2, 14, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 15, 0, 'user/logout', 'user/logout', 'Log out', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 10, 1, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 16, 1, 'admin/modules', 'admin/modules', 'Modules', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32363a22457874656e6420736974652066756e6374696f6e616c6974792e223b7d7d, 'system', 0, 0, 0, 0, -2, 2, 0, 1, 16, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 17, 0, 'user/%', 'user/%', 'My account', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 1, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 18, 1, 'admin/people', 'admin/people', 'People', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a224d616e6167652075736572206163636f756e74732c20726f6c65732c20616e64207065726d697373696f6e732e223b7d7d, 'system', 0, 0, 0, 0, -4, 2, 0, 1, 18, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 19, 1, 'admin/reports', 'admin/reports', 'Reports', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33343a2256696577207265706f7274732c20757064617465732c20616e64206572726f72732e223b7d7d, 'system', 0, 0, 1, 0, 5, 2, 0, 1, 19, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 20, 2, 'user/password', 'user/password', 'Request new password', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 2, 20, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 21, 1, 'admin/structure', 'admin/structure', 'Structure', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a2241646d696e697374657220626c6f636b732c20636f6e74656e742074797065732c206d656e75732c206574632e223b7d7d, 'system', 0, 0, 1, 0, -8, 2, 0, 1, 21, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 22, 1, 'admin/tasks', 'admin/tasks', 'Tasks', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -20, 2, 0, 1, 22, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 23, 0, 'comment/reply/%', 'comment/reply/%', 'Add new comment', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 24, 3, 'comment/%/approve', 'comment/%/approve', 'Approve', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 1, 2, 0, 3, 24, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 25, 4, 'filter/tips/%', 'filter/tips/%', 'Compose tips', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 2, 0, 4, 25, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 26, 3, 'comment/%/delete', 'comment/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 2, 0, 3, 26, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 27, 3, 'comment/%/edit', 'comment/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 3, 27, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 28, 0, 'taxonomy/term/%', 'taxonomy/term/%', 'Taxonomy term', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 29, 3, 'comment/%/view', 'comment/%/view', 'View comment', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 3, 29, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 30, 18, 'admin/people/create', 'admin/people/create', 'Add user', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 18, 30, 0, 0, 0, 0, 0, 0, 0),
('management', 31, 21, 'admin/structure/block', 'admin/structure/block', 'Blocks', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37393a22436f6e666967757265207768617420626c6f636b20636f6e74656e74206170706561727320696e20796f75722073697465277320736964656261727320616e64206f7468657220726567696f6e732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 31, 0, 0, 0, 0, 0, 0, 0),
('navigation', 32, 17, 'user/%/cancel', 'user/%/cancel', 'Cancel account', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 2, 0, 17, 32, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 33, 9, 'admin/content/comment', 'admin/content/comment', 'Comments', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35393a224c69737420616e642065646974207369746520636f6d6d656e747320616e642074686520636f6d6d656e7420617070726f76616c2071756575652e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 9, 33, 0, 0, 0, 0, 0, 0, 0),
('management', 34, 11, 'admin/dashboard/configure', 'admin/dashboard/configure', 'Configure available dashboard blocks', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35333a22436f6e66696775726520776869636820626c6f636b732063616e2062652073686f776e206f6e207468652064617368626f6172642e223b7d7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 11, 34, 0, 0, 0, 0, 0, 0, 0),
('management', 35, 9, 'admin/content/node', 'admin/content/node', 'Content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 3, 0, 1, 9, 35, 0, 0, 0, 0, 0, 0, 0),
('management', 36, 8, 'admin/config/content', 'admin/config/content', 'Content authoring', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35333a2253657474696e67732072656c6174656420746f20666f726d617474696e6720616e6420617574686f72696e6720636f6e74656e742e223b7d7d, 'system', 0, 0, 1, 0, -15, 3, 0, 1, 8, 36, 0, 0, 0, 0, 0, 0, 0),
('management', 37, 21, 'admin/structure/types', 'admin/structure/types', 'Content types', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a39323a224d616e61676520636f6e74656e742074797065732c20696e636c7564696e672064656661756c74207374617475732c2066726f6e7420706167652070726f6d6f74696f6e2c20636f6d6d656e742073657474696e67732c206574632e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 37, 0, 0, 0, 0, 0, 0, 0),
('management', 38, 11, 'admin/dashboard/customize', 'admin/dashboard/customize', 'Customize dashboard', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32353a22437573746f6d697a6520796f75722064617368626f6172642e223b7d7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 11, 38, 0, 0, 0, 0, 0, 0, 0),
('navigation', 39, 5, 'node/%/delete', 'node/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 2, 0, 5, 39, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 40, 8, 'admin/config/development', 'admin/config/development', 'Development', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31383a22446576656c6f706d656e7420746f6f6c732e223b7d7d, 'system', 0, 0, 1, 0, -10, 3, 0, 1, 8, 40, 0, 0, 0, 0, 0, 0, 0),
('navigation', 41, 17, 'user/%/edit', 'user/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 17, 41, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 42, 5, 'node/%/edit', 'node/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 5, 42, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 43, 19, 'admin/reports/fields', 'admin/reports/fields', 'Field list', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33393a224f76657276696577206f66206669656c6473206f6e20616c6c20656e746974792074797065732e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 43, 0, 0, 0, 0, 0, 0, 0),
('management', 44, 16, 'admin/modules/list', 'admin/modules/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 16, 44, 0, 0, 0, 0, 0, 0, 0),
('management', 45, 18, 'admin/people/people', 'admin/people/people', 'List', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35303a2246696e6420616e64206d616e6167652070656f706c6520696e746572616374696e67207769746820796f757220736974652e223b7d7d, 'system', -1, 0, 0, 0, -10, 3, 0, 1, 18, 45, 0, 0, 0, 0, 0, 0, 0),
('management', 46, 7, 'admin/appearance/list', 'admin/appearance/list', 'List', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33313a2253656c65637420616e6420636f6e66696775726520796f7572207468656d65223b7d7d, 'system', -1, 0, 0, 0, -1, 3, 0, 1, 7, 46, 0, 0, 0, 0, 0, 0, 0),
('management', 47, 8, 'admin/config/media', 'admin/config/media', 'Media', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31323a224d6564696120746f6f6c732e223b7d7d, 'system', 0, 0, 1, 0, -10, 3, 0, 1, 8, 47, 0, 0, 0, 0, 0, 0, 0),
('management', 49, 8, 'admin/config/people', 'admin/config/people', 'People', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32343a22436f6e6669677572652075736572206163636f756e74732e223b7d7d, 'system', 0, 0, 1, 0, -20, 3, 0, 1, 8, 49, 0, 0, 0, 0, 0, 0, 0),
('management', 50, 18, 'admin/people/permissions', 'admin/people/permissions', 'Permissions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36343a2244657465726d696e652061636365737320746f2066656174757265732062792073656c656374696e67207065726d697373696f6e7320666f7220726f6c65732e223b7d7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 18, 50, 0, 0, 0, 0, 0, 0, 0),
('management', 51, 19, 'admin/reports/dblog', 'admin/reports/dblog', 'Recent log messages', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a2256696577206576656e74732074686174206861766520726563656e746c79206265656e206c6f676765642e223b7d7d, 'system', 0, 0, 0, 0, -1, 3, 0, 1, 19, 51, 0, 0, 0, 0, 0, 0, 0),
('management', 52, 8, 'admin/config/regional', 'admin/config/regional', 'Regional and language', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34383a22526567696f6e616c2073657474696e67732c206c6f63616c697a6174696f6e20616e64207472616e736c6174696f6e2e223b7d7d, 'system', 0, 0, 1, 0, -5, 3, 0, 1, 8, 52, 0, 0, 0, 0, 0, 0, 0),
('navigation', 53, 5, 'node/%/revisions', 'node/%/revisions', 'Revisions', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 2, 2, 0, 5, 53, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 54, 8, 'admin/config/search', 'admin/config/search', 'Search and metadata', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33363a224c6f63616c2073697465207365617263682c206d6574616461746120616e642053454f2e223b7d7d, 'system', 0, 0, 1, 0, -10, 3, 0, 1, 8, 54, 0, 0, 0, 0, 0, 0, 0),
('management', 55, 7, 'admin/appearance/settings', 'admin/appearance/settings', 'Settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34363a22436f6e6669677572652064656661756c7420616e64207468656d652073706563696669632073657474696e67732e223b7d7d, 'system', -1, 0, 0, 0, 20, 3, 0, 1, 7, 55, 0, 0, 0, 0, 0, 0, 0),
('management', 56, 19, 'admin/reports/status', 'admin/reports/status', 'Status report', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37343a22476574206120737461747573207265706f72742061626f757420796f757220736974652773206f7065726174696f6e20616e6420616e792064657465637465642070726f626c656d732e223b7d7d, 'system', 0, 0, 0, 0, -60, 3, 0, 1, 19, 56, 0, 0, 0, 0, 0, 0, 0),
('management', 57, 8, 'admin/config/system', 'admin/config/system', 'System', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33373a2247656e6572616c2073797374656d2072656c6174656420636f6e66696775726174696f6e2e223b7d7d, 'system', 0, 0, 1, 0, -20, 3, 0, 1, 8, 57, 0, 0, 0, 0, 0, 0, 0),
('management', 58, 21, 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'Taxonomy', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36373a224d616e6167652074616767696e672c2063617465676f72697a6174696f6e2c20616e6420636c617373696669636174696f6e206f6620796f757220636f6e74656e742e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 58, 0, 0, 0, 0, 0, 0, 0),
('management', 59, 19, 'admin/reports/access-denied', 'admin/reports/access-denied', 'Top ''access denied'' errors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33353a225669657720276163636573732064656e69656427206572726f7273202834303373292e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 59, 0, 0, 0, 0, 0, 0, 0),
('management', 60, 19, 'admin/reports/page-not-found', 'admin/reports/page-not-found', 'Top ''page not found'' errors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33363a2256696577202770616765206e6f7420666f756e6427206572726f7273202834303473292e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 60, 0, 0, 0, 0, 0, 0, 0),
('management', 61, 16, 'admin/modules/uninstall', 'admin/modules/uninstall', 'Uninstall', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 20, 3, 0, 1, 16, 61, 0, 0, 0, 0, 0, 0, 0),
('management', 62, 8, 'admin/config/user-interface', 'admin/config/user-interface', 'User interface', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33383a22546f6f6c73207468617420656e68616e636520746865207573657220696e746572666163652e223b7d7d, 'system', 0, 0, 1, 0, -15, 3, 0, 1, 8, 62, 0, 0, 0, 0, 0, 0, 0),
('navigation', 63, 5, 'node/%/view', 'node/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 5, 63, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 64, 17, 'user/%/view', 'user/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 17, 64, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 65, 8, 'admin/config/services', 'admin/config/services', 'Web services', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33303a22546f6f6c732072656c6174656420746f207765622073657276696365732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 8, 65, 0, 0, 0, 0, 0, 0, 0),
('management', 66, 8, 'admin/config/workflow', 'admin/config/workflow', 'Workflow', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22436f6e74656e7420776f726b666c6f772c20656469746f7269616c20776f726b666c6f7720746f6f6c732e223b7d7d, 'system', 0, 0, 0, 0, 5, 3, 0, 1, 8, 66, 0, 0, 0, 0, 0, 0, 0),
('management', 67, 12, 'admin/help/block', 'admin/help/block', 'block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 67, 0, 0, 0, 0, 0, 0, 0),
('management', 68, 12, 'admin/help/color', 'admin/help/color', 'color', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 68, 0, 0, 0, 0, 0, 0, 0),
('management', 69, 12, 'admin/help/comment', 'admin/help/comment', 'comment', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 69, 0, 0, 0, 0, 0, 0, 0),
('management', 70, 12, 'admin/help/contextual', 'admin/help/contextual', 'contextual', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 70, 0, 0, 0, 0, 0, 0, 0),
('management', 71, 12, 'admin/help/dashboard', 'admin/help/dashboard', 'dashboard', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 71, 0, 0, 0, 0, 0, 0, 0),
('management', 72, 12, 'admin/help/dblog', 'admin/help/dblog', 'dblog', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 72, 0, 0, 0, 0, 0, 0, 0),
('management', 73, 12, 'admin/help/field', 'admin/help/field', 'field', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 73, 0, 0, 0, 0, 0, 0, 0),
('management', 74, 12, 'admin/help/field_sql_storage', 'admin/help/field_sql_storage', 'field_sql_storage', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 74, 0, 0, 0, 0, 0, 0, 0),
('management', 75, 12, 'admin/help/field_ui', 'admin/help/field_ui', 'field_ui', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 75, 0, 0, 0, 0, 0, 0, 0),
('management', 76, 12, 'admin/help/file', 'admin/help/file', 'file', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 76, 0, 0, 0, 0, 0, 0, 0),
('management', 77, 12, 'admin/help/filter', 'admin/help/filter', 'filter', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 77, 0, 0, 0, 0, 0, 0, 0),
('management', 78, 12, 'admin/help/help', 'admin/help/help', 'help', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 78, 0, 0, 0, 0, 0, 0, 0),
('management', 79, 12, 'admin/help/image', 'admin/help/image', 'image', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 79, 0, 0, 0, 0, 0, 0, 0),
('management', 80, 12, 'admin/help/list', 'admin/help/list', 'list', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 80, 0, 0, 0, 0, 0, 0, 0),
('management', 82, 12, 'admin/help/node', 'admin/help/node', 'node', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 82, 0, 0, 0, 0, 0, 0, 0),
('management', 83, 12, 'admin/help/options', 'admin/help/options', 'options', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 83, 0, 0, 0, 0, 0, 0, 0),
('management', 84, 12, 'admin/help/system', 'admin/help/system', 'system', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 84, 0, 0, 0, 0, 0, 0, 0),
('management', 85, 12, 'admin/help/taxonomy', 'admin/help/taxonomy', 'taxonomy', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 85, 0, 0, 0, 0, 0, 0, 0),
('management', 86, 12, 'admin/help/text', 'admin/help/text', 'text', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 86, 0, 0, 0, 0, 0, 0, 0),
('management', 87, 12, 'admin/help/user', 'admin/help/user', 'user', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 87, 0, 0, 0, 0, 0, 0, 0),
('navigation', 88, 28, 'taxonomy/term/%/edit', 'taxonomy/term/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 2, 0, 28, 88, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 89, 28, 'taxonomy/term/%/view', 'taxonomy/term/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 28, 89, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 90, 58, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 58, 90, 0, 0, 0, 0, 0, 0),
('management', 91, 49, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Account settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130393a22436f6e6669677572652064656661756c74206265686176696f72206f662075736572732c20696e636c7564696e6720726567697374726174696f6e20726571756972656d656e74732c20652d6d61696c732c206669656c64732c20616e6420757365722070696374757265732e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 49, 91, 0, 0, 0, 0, 0, 0),
('management', 92, 57, 'admin/config/system/actions', 'admin/config/system/actions', 'Actions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34313a224d616e6167652074686520616374696f6e7320646566696e656420666f7220796f757220736974652e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 57, 92, 0, 0, 0, 0, 0, 0),
('management', 93, 31, 'admin/structure/block/add', 'admin/structure/block/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 93, 0, 0, 0, 0, 0, 0),
('management', 94, 37, 'admin/structure/types/add', 'admin/structure/types/add', 'Add content type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 37, 94, 0, 0, 0, 0, 0, 0),
('management', 96, 58, 'admin/structure/taxonomy/add', 'admin/structure/taxonomy/add', 'Add vocabulary', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 58, 96, 0, 0, 0, 0, 0, 0),
('management', 97, 55, 'admin/appearance/settings/bartik', 'admin/appearance/settings/bartik', 'Bartik', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 55, 97, 0, 0, 0, 0, 0, 0),
('management', 98, 54, 'admin/config/search/clean-urls', 'admin/config/search/clean-urls', 'Clean URLs', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22456e61626c65206f722064697361626c6520636c65616e2055524c7320666f7220796f757220736974652e223b7d7d, 'system', 0, 0, 0, 0, 5, 4, 0, 1, 8, 54, 98, 0, 0, 0, 0, 0, 0),
('management', 99, 57, 'admin/config/system/cron', 'admin/config/system/cron', 'Cron', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34303a224d616e616765206175746f6d617469632073697465206d61696e74656e616e6365207461736b732e223b7d7d, 'system', 0, 0, 0, 0, 20, 4, 0, 1, 8, 57, 99, 0, 0, 0, 0, 0, 0),
('management', 100, 52, 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Date and time', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34343a22436f6e66696775726520646973706c617920666f726d61747320666f72206461746520616e642074696d652e223b7d7d, 'system', 0, 0, 0, 0, -15, 4, 0, 1, 8, 52, 100, 0, 0, 0, 0, 0, 0),
('management', 101, 19, 'admin/reports/event/%', 'admin/reports/event/%', 'Details', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 101, 0, 0, 0, 0, 0, 0, 0),
('management', 102, 47, 'admin/config/media/file-system', 'admin/config/media/file-system', 'File system', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36383a2254656c6c2044727570616c20776865726520746f2073746f72652075706c6f616465642066696c657320616e6420686f772074686579206172652061636365737365642e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 47, 102, 0, 0, 0, 0, 0, 0),
('management', 103, 55, 'admin/appearance/settings/garland', 'admin/appearance/settings/garland', 'Garland', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 55, 103, 0, 0, 0, 0, 0, 0),
('management', 104, 55, 'admin/appearance/settings/global', 'admin/appearance/settings/global', 'Global settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -1, 4, 0, 1, 7, 55, 104, 0, 0, 0, 0, 0, 0),
('management', 105, 49, 'admin/config/people/ip-blocking', 'admin/config/people/ip-blocking', 'IP address blocking', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32383a224d616e61676520626c6f636b6564204950206164647265737365732e223b7d7d, 'system', 0, 0, 1, 0, 10, 4, 0, 1, 8, 49, 105, 0, 0, 0, 0, 0, 0),
('management', 106, 47, 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'Image styles', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37383a22436f6e666967757265207374796c657320746861742063616e206265207573656420666f7220726573697a696e67206f722061646a757374696e6720696d61676573206f6e20646973706c61792e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 47, 106, 0, 0, 0, 0, 0, 0),
('management', 107, 47, 'admin/config/media/image-toolkit', 'admin/config/media/image-toolkit', 'Image toolkit', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37343a2243686f6f736520776869636820696d61676520746f6f6c6b697420746f2075736520696620796f75206861766520696e7374616c6c6564206f7074696f6e616c20746f6f6c6b6974732e223b7d7d, 'system', 0, 0, 0, 0, 20, 4, 0, 1, 8, 47, 107, 0, 0, 0, 0, 0, 0),
('management', 108, 44, 'admin/modules/list/confirm', 'admin/modules/list/confirm', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 16, 44, 108, 0, 0, 0, 0, 0, 0),
('management', 109, 37, 'admin/structure/types/list', 'admin/structure/types/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 37, 109, 0, 0, 0, 0, 0, 0),
('management', 110, 58, 'admin/structure/taxonomy/list', 'admin/structure/taxonomy/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 58, 110, 0, 0, 0, 0, 0, 0),
('management', 112, 40, 'admin/config/development/logging', 'admin/config/development/logging', 'Logging and errors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3135343a2253657474696e677320666f72206c6f6767696e6720616e6420616c65727473206d6f64756c65732e20566172696f7573206d6f64756c65732063616e20726f7574652044727570616c27732073797374656d206576656e747320746f20646966666572656e742064657374696e6174696f6e732c2073756368206173207379736c6f672c2064617461626173652c20656d61696c2c206574632e223b7d7d, 'system', 0, 0, 0, 0, -15, 4, 0, 1, 8, 40, 112, 0, 0, 0, 0, 0, 0),
('management', 113, 40, 'admin/config/development/maintenance', 'admin/config/development/maintenance', 'Maintenance mode', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36323a2254616b65207468652073697465206f66666c696e6520666f72206d61696e74656e616e6365206f72206272696e67206974206261636b206f6e6c696e652e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 40, 113, 0, 0, 0, 0, 0, 0),
('management', 114, 40, 'admin/config/development/performance', 'admin/config/development/performance', 'Performance', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130313a22456e61626c65206f722064697361626c6520706167652063616368696e6720666f7220616e6f6e796d6f757320757365727320616e64207365742043535320616e64204a532062616e647769647468206f7074696d697a6174696f6e206f7074696f6e732e223b7d7d, 'system', 0, 0, 0, 0, -20, 4, 0, 1, 8, 40, 114, 0, 0, 0, 0, 0, 0),
('management', 115, 50, 'admin/people/permissions/list', 'admin/people/permissions/list', 'Permissions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36343a2244657465726d696e652061636365737320746f2066656174757265732062792073656c656374696e67207065726d697373696f6e7320666f7220726f6c65732e223b7d7d, 'system', -1, 0, 0, 0, -8, 4, 0, 1, 18, 50, 115, 0, 0, 0, 0, 0, 0),
('management', 116, 33, 'admin/content/comment/new', 'admin/content/comment/new', 'Published comments', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 9, 33, 116, 0, 0, 0, 0, 0, 0),
('management', 117, 65, 'admin/config/services/rss-publishing', 'admin/config/services/rss-publishing', 'RSS publishing', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3131343a22436f6e666967757265207468652073697465206465736372697074696f6e2c20746865206e756d626572206f66206974656d7320706572206665656420616e6420776865746865722066656564732073686f756c64206265207469746c65732f746561736572732f66756c6c2d746578742e223b7d7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 8, 65, 117, 0, 0, 0, 0, 0, 0),
('management', 118, 52, 'admin/config/regional/settings', 'admin/config/regional/settings', 'Regional settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35343a2253657474696e677320666f7220746865207369746527732064656661756c742074696d65207a6f6e6520616e6420636f756e7472792e223b7d7d, 'system', 0, 0, 0, 0, -20, 4, 0, 1, 8, 52, 118, 0, 0, 0, 0, 0, 0),
('management', 119, 50, 'admin/people/permissions/roles', 'admin/people/permissions/roles', 'Roles', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33303a224c6973742c20656469742c206f7220616464207573657220726f6c65732e223b7d7d, 'system', -1, 0, 1, 0, -5, 4, 0, 1, 18, 50, 119, 0, 0, 0, 0, 0, 0),
('management', 121, 55, 'admin/appearance/settings/seven', 'admin/appearance/settings/seven', 'Seven', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 55, 121, 0, 0, 0, 0, 0, 0),
('management', 122, 57, 'admin/config/system/site-information', 'admin/config/system/site-information', 'Site information', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130343a224368616e67652073697465206e616d652c20652d6d61696c20616464726573732c20736c6f67616e2c2064656661756c742066726f6e7420706167652c20616e64206e756d626572206f6620706f7374732070657220706167652c206572726f722070616765732e223b7d7d, 'system', 0, 0, 0, 0, -20, 4, 0, 1, 8, 57, 122, 0, 0, 0, 0, 0, 0),
('management', 123, 55, 'admin/appearance/settings/stark', 'admin/appearance/settings/stark', 'Stark', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 55, 123, 0, 0, 0, 0, 0, 0),
('management', 124, 36, 'admin/config/content/formats', 'admin/config/content/formats', 'Text formats', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3132373a22436f6e66696775726520686f7720636f6e74656e7420696e7075742062792075736572732069732066696c74657265642c20696e636c7564696e6720616c6c6f7765642048544d4c20746167732e20416c736f20616c6c6f777320656e61626c696e67206f66206d6f64756c652d70726f76696465642066696c746572732e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 36, 124, 0, 0, 0, 0, 0, 0),
('management', 125, 33, 'admin/content/comment/approval', 'admin/content/comment/approval', 'Unapproved comments', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 9, 33, 125, 0, 0, 0, 0, 0, 0),
('management', 126, 61, 'admin/modules/uninstall/confirm', 'admin/modules/uninstall/confirm', 'Uninstall', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 16, 61, 126, 0, 0, 0, 0, 0, 0),
('navigation', 127, 41, 'user/%/edit/account', 'user/%/edit/account', 'Account', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 17, 41, 127, 0, 0, 0, 0, 0, 0, 0),
('management', 128, 124, 'admin/config/content/formats/%', 'admin/config/content/formats/%', '', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 36, 124, 128, 0, 0, 0, 0, 0),
('management', 129, 106, 'admin/config/media/image-styles/add', 'admin/config/media/image-styles/add', 'Add style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32323a224164642061206e657720696d616765207374796c652e223b7d7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 8, 47, 106, 129, 0, 0, 0, 0, 0),
('management', 130, 90, 'admin/structure/taxonomy/%/add', 'admin/structure/taxonomy/%/add', 'Add term', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 58, 90, 130, 0, 0, 0, 0, 0),
('management', 131, 124, 'admin/config/content/formats/add', 'admin/config/content/formats/add', 'Add text format', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 5, 0, 1, 8, 36, 124, 131, 0, 0, 0, 0, 0),
('management', 132, 31, 'admin/structure/block/list/bartik', 'admin/structure/block/list/bartik', 'Bartik', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 132, 0, 0, 0, 0, 0, 0),
('management', 133, 92, 'admin/config/system/actions/configure', 'admin/config/system/actions/configure', 'Configure an advanced action', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 57, 92, 133, 0, 0, 0, 0, 0),
('management', 135, 90, 'admin/structure/taxonomy/%/edit', 'admin/structure/taxonomy/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 21, 58, 90, 135, 0, 0, 0, 0, 0),
('management', 136, 37, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Edit content type', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 21, 37, 136, 0, 0, 0, 0, 0, 0),
('management', 137, 100, 'admin/config/regional/date-time/formats', 'admin/config/regional/date-time/formats', 'Formats', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35313a22436f6e66696775726520646973706c617920666f726d617420737472696e677320666f72206461746520616e642074696d652e223b7d7d, 'system', -1, 0, 1, 0, -9, 5, 0, 1, 8, 52, 100, 137, 0, 0, 0, 0, 0),
('management', 138, 31, 'admin/structure/block/list/garland', 'admin/structure/block/list/garland', 'Garland', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 138, 0, 0, 0, 0, 0, 0),
('management', 139, 90, 'admin/structure/taxonomy/%/list', 'admin/structure/taxonomy/%/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -20, 5, 0, 1, 21, 58, 90, 139, 0, 0, 0, 0, 0),
('management', 140, 124, 'admin/config/content/formats/list', 'admin/config/content/formats/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 36, 124, 140, 0, 0, 0, 0, 0),
('management', 141, 106, 'admin/config/media/image-styles/list', 'admin/config/media/image-styles/list', 'List', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34323a224c697374207468652063757272656e7420696d616765207374796c6573206f6e2074686520736974652e223b7d7d, 'system', -1, 0, 0, 0, 1, 5, 0, 1, 8, 47, 106, 141, 0, 0, 0, 0, 0),
('management', 142, 92, 'admin/config/system/actions/manage', 'admin/config/system/actions/manage', 'Manage actions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34313a224d616e6167652074686520616374696f6e7320646566696e656420666f7220796f757220736974652e223b7d7d, 'system', -1, 0, 0, 0, -2, 5, 0, 1, 8, 57, 92, 142, 0, 0, 0, 0, 0),
('management', 143, 91, 'admin/config/people/accounts/settings', 'admin/config/people/accounts/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 8, 49, 91, 143, 0, 0, 0, 0, 0),
('management', 144, 31, 'admin/structure/block/list/seven', 'admin/structure/block/list/seven', 'Seven', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 144, 0, 0, 0, 0, 0, 0),
('management', 145, 31, 'admin/structure/block/list/stark', 'admin/structure/block/list/stark', 'Stark', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 145, 0, 0, 0, 0, 0, 0),
('management', 146, 100, 'admin/config/regional/date-time/types', 'admin/config/regional/date-time/types', 'Types', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34343a22436f6e66696775726520646973706c617920666f726d61747320666f72206461746520616e642074696d652e223b7d7d, 'system', -1, 0, 1, 0, -10, 5, 0, 1, 8, 52, 100, 146, 0, 0, 0, 0, 0),
('navigation', 147, 53, 'node/%/revisions/%/delete', 'node/%/revisions/%/delete', 'Delete earlier revision', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 5, 53, 147, 0, 0, 0, 0, 0, 0, 0),
('navigation', 148, 53, 'node/%/revisions/%/revert', 'node/%/revisions/%/revert', 'Revert to earlier revision', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 5, 53, 148, 0, 0, 0, 0, 0, 0, 0),
('navigation', 149, 53, 'node/%/revisions/%/view', 'node/%/revisions/%/view', 'Revisions', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 5, 53, 149, 0, 0, 0, 0, 0, 0, 0),
('management', 150, 138, 'admin/structure/block/list/garland/add', 'admin/structure/block/list/garland/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 138, 150, 0, 0, 0, 0, 0),
('management', 151, 144, 'admin/structure/block/list/seven/add', 'admin/structure/block/list/seven/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 144, 151, 0, 0, 0, 0, 0),
('management', 152, 145, 'admin/structure/block/list/stark/add', 'admin/structure/block/list/stark/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 145, 152, 0, 0, 0, 0, 0),
('management', 153, 146, 'admin/config/regional/date-time/types/add', 'admin/config/regional/date-time/types/add', 'Add date type', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31383a22416464206e6577206461746520747970652e223b7d7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 52, 100, 146, 153, 0, 0, 0, 0),
('management', 154, 137, 'admin/config/regional/date-time/formats/add', 'admin/config/regional/date-time/formats/add', 'Add format', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22416c6c6f7720757365727320746f20616464206164646974696f6e616c206461746520666f726d6174732e223b7d7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 52, 100, 137, 154, 0, 0, 0, 0),
('management', 156, 31, 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Configure block', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 31, 156, 0, 0, 0, 0, 0, 0),
('navigation', 157, 32, 'user/%/cancel/confirm/%/%', 'user/%/cancel/confirm/%/%', 'Confirm account cancellation', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 17, 32, 157, 0, 0, 0, 0, 0, 0, 0),
('management', 158, 136, 'admin/structure/types/manage/%/delete', 'admin/structure/types/manage/%/delete', 'Delete', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 21, 37, 136, 158, 0, 0, 0, 0, 0),
('management', 159, 105, 'admin/config/people/ip-blocking/delete/%', 'admin/config/people/ip-blocking/delete/%', 'Delete IP address', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 49, 105, 159, 0, 0, 0, 0, 0),
('management', 160, 92, 'admin/config/system/actions/delete/%', 'admin/config/system/actions/delete/%', 'Delete action', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31373a2244656c65746520616e20616374696f6e2e223b7d7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 57, 92, 160, 0, 0, 0, 0, 0),
('management', 163, 119, 'admin/people/permissions/roles/delete/%', 'admin/people/permissions/roles/delete/%', 'Delete role', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 18, 50, 119, 163, 0, 0, 0, 0, 0),
('management', 164, 128, 'admin/config/content/formats/%/disable', 'admin/config/content/formats/%/disable', 'Disable text format', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 36, 124, 128, 164, 0, 0, 0, 0),
('management', 165, 136, 'admin/structure/types/manage/%/edit', 'admin/structure/types/manage/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 37, 136, 165, 0, 0, 0, 0, 0),
('management', 168, 119, 'admin/people/permissions/roles/edit/%', 'admin/people/permissions/roles/edit/%', 'Edit role', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 18, 50, 119, 168, 0, 0, 0, 0, 0),
('management', 169, 106, 'admin/config/media/image-styles/edit/%', 'admin/config/media/image-styles/edit/%', 'Edit style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32353a22436f6e66696775726520616e20696d616765207374796c652e223b7d7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 47, 106, 169, 0, 0, 0, 0, 0),
('management', 172, 106, 'admin/config/media/image-styles/delete/%', 'admin/config/media/image-styles/delete/%', 'Delete style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32323a2244656c65746520616e20696d616765207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 47, 106, 172, 0, 0, 0, 0, 0),
('management', 173, 106, 'admin/config/media/image-styles/revert/%', 'admin/config/media/image-styles/revert/%', 'Revert style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32323a2252657665727420616e20696d616765207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 47, 106, 173, 0, 0, 0, 0, 0),
('management', 174, 136, 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%/comment/display', 'Comment display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 4, 5, 0, 1, 21, 37, 136, 174, 0, 0, 0, 0, 0),
('management', 175, 136, 'admin/structure/types/manage/%/comment/fields', 'admin/structure/types/manage/%/comment/fields', 'Comment fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 3, 5, 0, 1, 21, 37, 136, 175, 0, 0, 0, 0, 0),
('management', 176, 156, 'admin/structure/block/manage/%/%/configure', 'admin/structure/block/manage/%/%/configure', 'Configure block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 156, 176, 0, 0, 0, 0, 0),
('management', 177, 156, 'admin/structure/block/manage/%/%/delete', 'admin/structure/block/manage/%/%/delete', 'Delete block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 156, 177, 0, 0, 0, 0, 0),
('management', 178, 137, 'admin/config/regional/date-time/formats/%/delete', 'admin/config/regional/date-time/formats/%/delete', 'Delete date format', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34373a22416c6c6f7720757365727320746f2064656c657465206120636f6e66696775726564206461746520666f726d61742e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 52, 100, 137, 178, 0, 0, 0, 0),
('management', 179, 146, 'admin/config/regional/date-time/types/%/delete', 'admin/config/regional/date-time/types/%/delete', 'Delete date type', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a22416c6c6f7720757365727320746f2064656c657465206120636f6e66696775726564206461746520747970652e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 52, 100, 146, 179, 0, 0, 0, 0),
('management', 180, 137, 'admin/config/regional/date-time/formats/%/edit', 'admin/config/regional/date-time/formats/%/edit', 'Edit date format', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a22416c6c6f7720757365727320746f2065646974206120636f6e66696775726564206461746520666f726d61742e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 52, 100, 137, 180, 0, 0, 0, 0),
('management', 181, 169, 'admin/config/media/image-styles/edit/%/add/%', 'admin/config/media/image-styles/edit/%/add/%', 'Add image effect', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32383a224164642061206e65772065666665637420746f2061207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 47, 106, 169, 181, 0, 0, 0, 0),
('management', 182, 169, 'admin/config/media/image-styles/edit/%/effects/%', 'admin/config/media/image-styles/edit/%/effects/%', 'Edit image effect', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33393a224564697420616e206578697374696e67206566666563742077697468696e2061207374796c652e223b7d7d, 'system', 0, 0, 1, 0, 0, 6, 0, 1, 8, 47, 106, 169, 182, 0, 0, 0, 0),
('management', 183, 182, 'admin/config/media/image-styles/edit/%/effects/%/delete', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'Delete image effect', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33393a2244656c65746520616e206578697374696e67206566666563742066726f6d2061207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 7, 0, 1, 8, 47, 106, 169, 182, 183, 0, 0, 0),
('navigation', 188, 0, 'search', 'search', 'Search', 0x613a303a7b7d, 'system', 1, 0, 0, 0, 0, 1, 0, 188, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 189, 188, 'search/node', 'search/node', 'Content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 188, 189, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 190, 188, 'search/user', 'search/user', 'Users', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 188, 190, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 191, 189, 'search/node/%', 'search/node/%', 'Content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 188, 189, 191, 0, 0, 0, 0, 0, 0, 0),
('navigation', 192, 17, 'user/%/shortcuts', 'user/%/shortcuts', 'Shortcuts', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 17, 192, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 193, 19, 'admin/reports/search', 'admin/reports/search', 'Top search phrases', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33333a2256696577206d6f737420706f70756c61722073656172636820706872617365732e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 193, 0, 0, 0, 0, 0, 0, 0),
('navigation', 194, 190, 'search/user/%', 'search/user/%', 'Users', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 188, 190, 194, 0, 0, 0, 0, 0, 0, 0),
('management', 195, 12, 'admin/help/number', 'admin/help/number', 'number', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 195, 0, 0, 0, 0, 0, 0, 0),
('management', 197, 12, 'admin/help/path', 'admin/help/path', 'path', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 197, 0, 0, 0, 0, 0, 0, 0),
('management', 198, 12, 'admin/help/rdf', 'admin/help/rdf', 'rdf', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 198, 0, 0, 0, 0, 0, 0, 0),
('management', 199, 12, 'admin/help/search', 'admin/help/search', 'search', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 199, 0, 0, 0, 0, 0, 0, 0),
('management', 200, 12, 'admin/help/shortcut', 'admin/help/shortcut', 'shortcut', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 200, 0, 0, 0, 0, 0, 0, 0),
('management', 201, 54, 'admin/config/search/settings', 'admin/config/search/settings', 'Search settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36373a22436f6e6669677572652072656c6576616e63652073657474696e677320666f722073656172636820616e64206f7468657220696e646578696e67206f7074696f6e732e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 54, 201, 0, 0, 0, 0, 0, 0),
('management', 202, 62, 'admin/config/user-interface/shortcut', 'admin/config/user-interface/shortcut', 'Shortcuts', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32393a2241646420616e64206d6f646966792073686f727463757420736574732e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 62, 202, 0, 0, 0, 0, 0, 0),
('management', 203, 54, 'admin/config/search/path', 'admin/config/search/path', 'URL aliases', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34363a224368616e676520796f7572207369746527732055524c20706174687320627920616c696173696e67207468656d2e223b7d7d, 'system', 0, 0, 1, 0, -5, 4, 0, 1, 8, 54, 203, 0, 0, 0, 0, 0, 0),
('management', 204, 203, 'admin/config/search/path/add', 'admin/config/search/path/add', 'Add alias', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 54, 203, 204, 0, 0, 0, 0, 0),
('management', 205, 202, 'admin/config/user-interface/shortcut/add-set', 'admin/config/user-interface/shortcut/add-set', 'Add shortcut set', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 62, 202, 205, 0, 0, 0, 0, 0),
('management', 206, 201, 'admin/config/search/settings/reindex', 'admin/config/search/settings/reindex', 'Clear index', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 54, 201, 206, 0, 0, 0, 0, 0),
('management', 207, 202, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Edit shortcuts', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 62, 202, 207, 0, 0, 0, 0, 0),
('management', 208, 203, 'admin/config/search/path/list', 'admin/config/search/path/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 8, 54, 203, 208, 0, 0, 0, 0, 0),
('management', 209, 207, 'admin/config/user-interface/shortcut/%/add-link', 'admin/config/user-interface/shortcut/%/add-link', 'Add shortcut', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 8, 62, 202, 207, 209, 0, 0, 0, 0),
('management', 210, 203, 'admin/config/search/path/delete/%', 'admin/config/search/path/delete/%', 'Delete alias', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 54, 203, 210, 0, 0, 0, 0, 0),
('management', 211, 207, 'admin/config/user-interface/shortcut/%/delete', 'admin/config/user-interface/shortcut/%/delete', 'Delete shortcut set', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 62, 202, 207, 211, 0, 0, 0, 0),
('management', 212, 203, 'admin/config/search/path/edit/%', 'admin/config/search/path/edit/%', 'Edit alias', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 54, 203, 212, 0, 0, 0, 0, 0),
('management', 213, 207, 'admin/config/user-interface/shortcut/%/edit', 'admin/config/user-interface/shortcut/%/edit', 'Edit set name', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 6, 0, 1, 8, 62, 202, 207, 213, 0, 0, 0, 0),
('management', 214, 202, 'admin/config/user-interface/shortcut/link/%', 'admin/config/user-interface/shortcut/link/%', 'Edit shortcut', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 62, 202, 214, 0, 0, 0, 0, 0),
('management', 215, 207, 'admin/config/user-interface/shortcut/%/links', 'admin/config/user-interface/shortcut/%/links', 'List links', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 8, 62, 202, 207, 215, 0, 0, 0, 0),
('management', 216, 214, 'admin/config/user-interface/shortcut/link/%/delete', 'admin/config/user-interface/shortcut/link/%/delete', 'Delete shortcut', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 62, 202, 214, 216, 0, 0, 0, 0),
('shortcut-set-1', 217, 0, 'node/add', 'node/add', 'Add content', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, -50, 1, 0, 217, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('shortcut-set-1', 218, 0, 'admin/content', 'admin/content', 'Find content', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, -49, 1, 0, 218, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 219, 0, '<front>', '', 'Home', 0x613a303a7b7d, 'menu', 0, 1, 0, 0, 0, 1, 0, 219, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 220, 6, 'node/add/article', 'node/add/article', 'Article', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a38393a22557365203c656d3e61727469636c65733c2f656d3e20666f722074696d652d73656e73697469766520636f6e74656e74206c696b65206e6577732c2070726573732072656c6561736573206f7220626c6f6720706f7374732e223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 6, 220, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 221, 6, 'node/add/page', 'node/add/page', 'Basic page', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37373a22557365203c656d3e62617369632070616765733c2f656d3e20666f7220796f75722073746174696320636f6e74656e742c207375636820617320616e202741626f75742075732720706167652e223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 6, 221, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `menu_links` (`menu_name`, `mlid`, `plid`, `link_path`, `router_path`, `link_title`, `options`, `module`, `hidden`, `external`, `has_children`, `expanded`, `weight`, `depth`, `customized`, `p1`, `p2`, `p3`, `p4`, `p5`, `p6`, `p7`, `p8`, `p9`, `updated`) VALUES
('management', 261, 90, 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 21, 58, 90, 261, 0, 0, 0, 0, 0),
('management', 262, 91, 'admin/config/people/accounts/display', 'admin/config/people/accounts/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 8, 49, 91, 262, 0, 0, 0, 0, 0),
('management', 263, 90, 'admin/structure/taxonomy/%/fields', 'admin/structure/taxonomy/%/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 21, 58, 90, 263, 0, 0, 0, 0, 0),
('management', 264, 91, 'admin/config/people/accounts/fields', 'admin/config/people/accounts/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 8, 49, 91, 264, 0, 0, 0, 0, 0),
('management', 265, 261, 'admin/structure/taxonomy/%/display/default', 'admin/structure/taxonomy/%/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 21, 58, 90, 261, 265, 0, 0, 0, 0),
('management', 266, 262, 'admin/config/people/accounts/display/default', 'admin/config/people/accounts/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 49, 91, 262, 266, 0, 0, 0, 0),
('management', 267, 136, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 21, 37, 136, 267, 0, 0, 0, 0, 0),
('management', 268, 136, 'admin/structure/types/manage/%/fields', 'admin/structure/types/manage/%/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 21, 37, 136, 268, 0, 0, 0, 0, 0),
('management', 269, 261, 'admin/structure/taxonomy/%/display/full', 'admin/structure/taxonomy/%/display/full', 'Taxonomy term page', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 21, 58, 90, 261, 269, 0, 0, 0, 0),
('management', 270, 262, 'admin/config/people/accounts/display/full', 'admin/config/people/accounts/display/full', 'User account', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 8, 49, 91, 262, 270, 0, 0, 0, 0),
('management', 271, 263, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 21, 58, 90, 263, 271, 0, 0, 0, 0),
('management', 272, 264, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 49, 91, 264, 272, 0, 0, 0, 0),
('management', 273, 267, 'admin/structure/types/manage/%/display/default', 'admin/structure/types/manage/%/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 21, 37, 136, 267, 273, 0, 0, 0, 0),
('management', 274, 267, 'admin/structure/types/manage/%/display/full', 'admin/structure/types/manage/%/display/full', 'Full content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 21, 37, 136, 267, 274, 0, 0, 0, 0),
('management', 275, 267, 'admin/structure/types/manage/%/display/rss', 'admin/structure/types/manage/%/display/rss', 'RSS', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 6, 0, 1, 21, 37, 136, 267, 275, 0, 0, 0, 0),
('management', 276, 267, 'admin/structure/types/manage/%/display/search_index', 'admin/structure/types/manage/%/display/search_index', 'Search index', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 3, 6, 0, 1, 21, 37, 136, 267, 276, 0, 0, 0, 0),
('management', 277, 267, 'admin/structure/types/manage/%/display/search_result', 'admin/structure/types/manage/%/display/search_result', 'Search result highlighting input', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 4, 6, 0, 1, 21, 37, 136, 267, 277, 0, 0, 0, 0),
('management', 278, 267, 'admin/structure/types/manage/%/display/teaser', 'admin/structure/types/manage/%/display/teaser', 'Teaser', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 6, 0, 1, 21, 37, 136, 267, 278, 0, 0, 0, 0),
('management', 279, 268, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 21, 37, 136, 268, 279, 0, 0, 0, 0),
('management', 280, 271, 'admin/structure/taxonomy/%/fields/%/delete', 'admin/structure/taxonomy/%/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 21, 58, 90, 263, 271, 280, 0, 0, 0),
('management', 281, 271, 'admin/structure/taxonomy/%/fields/%/edit', 'admin/structure/taxonomy/%/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 58, 90, 263, 271, 281, 0, 0, 0),
('management', 282, 271, 'admin/structure/taxonomy/%/fields/%/field-settings', 'admin/structure/taxonomy/%/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 58, 90, 263, 271, 282, 0, 0, 0),
('management', 283, 271, 'admin/structure/taxonomy/%/fields/%/widget-type', 'admin/structure/taxonomy/%/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 58, 90, 263, 271, 283, 0, 0, 0),
('management', 284, 272, 'admin/config/people/accounts/fields/%/delete', 'admin/config/people/accounts/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 8, 49, 91, 264, 272, 284, 0, 0, 0),
('management', 285, 272, 'admin/config/people/accounts/fields/%/edit', 'admin/config/people/accounts/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 49, 91, 264, 272, 285, 0, 0, 0),
('management', 286, 272, 'admin/config/people/accounts/fields/%/field-settings', 'admin/config/people/accounts/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 49, 91, 264, 272, 286, 0, 0, 0),
('management', 287, 272, 'admin/config/people/accounts/fields/%/widget-type', 'admin/config/people/accounts/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 49, 91, 264, 272, 287, 0, 0, 0),
('management', 288, 174, 'admin/structure/types/manage/%/comment/display/default', 'admin/structure/types/manage/%/comment/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 21, 37, 136, 174, 288, 0, 0, 0, 0),
('management', 289, 174, 'admin/structure/types/manage/%/comment/display/full', 'admin/structure/types/manage/%/comment/display/full', 'Full comment', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 21, 37, 136, 174, 289, 0, 0, 0, 0),
('management', 290, 279, 'admin/structure/types/manage/%/fields/%/delete', 'admin/structure/types/manage/%/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 21, 37, 136, 268, 279, 290, 0, 0, 0),
('management', 291, 279, 'admin/structure/types/manage/%/fields/%/edit', 'admin/structure/types/manage/%/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 136, 268, 279, 291, 0, 0, 0),
('management', 292, 175, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 21, 37, 136, 175, 292, 0, 0, 0, 0),
('management', 293, 279, 'admin/structure/types/manage/%/fields/%/field-settings', 'admin/structure/types/manage/%/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 136, 268, 279, 293, 0, 0, 0),
('management', 294, 279, 'admin/structure/types/manage/%/fields/%/widget-type', 'admin/structure/types/manage/%/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 136, 268, 279, 294, 0, 0, 0),
('management', 295, 292, 'admin/structure/types/manage/%/comment/fields/%/delete', 'admin/structure/types/manage/%/comment/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 21, 37, 136, 175, 292, 295, 0, 0, 0),
('management', 296, 292, 'admin/structure/types/manage/%/comment/fields/%/edit', 'admin/structure/types/manage/%/comment/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 136, 175, 292, 296, 0, 0, 0),
('management', 297, 292, 'admin/structure/types/manage/%/comment/fields/%/field-settings', 'admin/structure/types/manage/%/comment/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 136, 175, 292, 297, 0, 0, 0),
('management', 298, 292, 'admin/structure/types/manage/%/comment/fields/%/widget-type', 'admin/structure/types/manage/%/comment/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 136, 175, 292, 298, 0, 0, 0),
('management', 299, 55, 'admin/appearance/settings/theme_default', 'admin/appearance/settings/theme_default', 'default theme', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 55, 299, 0, 0, 0, 0, 0, 0),
('management', 300, 31, 'admin/structure/block/list/theme_default', 'admin/structure/block/list/theme_default', 'default theme', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 31, 300, 0, 0, 0, 0, 0, 0),
('shortcut-set-1', 303, 0, 'admin/structure/block', 'admin/structure/block', 'Blocks', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, -48, 1, 0, 303, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 304, 132, 'admin/structure/block/list/bartik/add', 'admin/structure/block/list/bartik/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 132, 304, 0, 0, 0, 0, 0),
('shortcut-set-1', 305, 0, 'admin/config/development/performance', 'admin/config/development/performance', 'Performance', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, -47, 1, 0, 305, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 306, 1, 'admin/admincp', 'admin/admincp', 'CMS', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31343a2241646d696e697374726174696f6e223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 1, 306, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 307, 21, 'admin/structure/menu', 'admin/structure/menu', 'Menus', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a38363a22416464206e6577206d656e757320746f20796f757220736974652c2065646974206578697374696e67206d656e75732c20616e642072656e616d6520616e642072656f7267616e697a65206d656e75206c696e6b732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 307, 0, 0, 0, 0, 0, 0, 0),
('management', 308, 12, 'admin/help/menu', 'admin/help/menu', 'menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 308, 0, 0, 0, 0, 0, 0, 0),
('management', 309, 307, 'admin/structure/menu/add', 'admin/structure/menu/add', 'Add menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 307, 309, 0, 0, 0, 0, 0, 0),
('management', 310, 307, 'admin/structure/menu/list', 'admin/structure/menu/list', 'List menus', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 307, 310, 0, 0, 0, 0, 0, 0),
('management', 311, 307, 'admin/structure/menu/settings', 'admin/structure/menu/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 5, 4, 0, 1, 21, 307, 311, 0, 0, 0, 0, 0, 0),
('management', 312, 307, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Customize menu', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 21, 307, 312, 0, 0, 0, 0, 0, 0),
('management', 313, 312, 'admin/structure/menu/manage/%/add', 'admin/structure/menu/manage/%/add', 'Add link', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 307, 312, 313, 0, 0, 0, 0, 0),
('management', 314, 312, 'admin/structure/menu/manage/%/delete', 'admin/structure/menu/manage/%/delete', 'Delete menu', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 21, 307, 312, 314, 0, 0, 0, 0, 0),
('management', 315, 307, 'admin/structure/menu/item/%/delete', 'admin/structure/menu/item/%/delete', 'Delete menu link', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 307, 315, 0, 0, 0, 0, 0, 0),
('management', 316, 312, 'admin/structure/menu/manage/%/edit', 'admin/structure/menu/manage/%/edit', 'Edit menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 307, 312, 316, 0, 0, 0, 0, 0),
('management', 317, 307, 'admin/structure/menu/item/%/edit', 'admin/structure/menu/item/%/edit', 'Edit menu link', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 307, 317, 0, 0, 0, 0, 0, 0),
('management', 318, 312, 'admin/structure/menu/manage/%/list', 'admin/structure/menu/manage/%/list', 'List links', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 21, 307, 312, 318, 0, 0, 0, 0, 0),
('management', 319, 307, 'admin/structure/menu/item/%/reset', 'admin/structure/menu/item/%/reset', 'Reset menu link', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 307, 319, 0, 0, 0, 0, 0, 0),
('management', 320, 307, 'admin/structure/menu/manage/main-menu', 'admin/structure/menu/manage/%', 'Main menu', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 307, 320, 0, 0, 0, 0, 0, 0),
('management', 321, 307, 'admin/structure/menu/manage/management', 'admin/structure/menu/manage/%', 'Management', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 307, 321, 0, 0, 0, 0, 0, 0),
('management', 322, 307, 'admin/structure/menu/manage/navigation', 'admin/structure/menu/manage/%', 'Navigation', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 307, 322, 0, 0, 0, 0, 0, 0),
('management', 323, 307, 'admin/structure/menu/manage/user-menu', 'admin/structure/menu/manage/%', 'User menu', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 307, 323, 0, 0, 0, 0, 0, 0),
('management', 324, 12, 'admin/help/toolbar', 'admin/help/toolbar', 'toolbar', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 324, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `menu_router`
--

CREATE TABLE IF NOT EXISTS `menu_router` (
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

--
-- Dumping data for table `menu_router`
--

INSERT INTO `menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('admin', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 1, 1, 0, '', 'admin', 'Administration', 't', '', '', 'a:0:{}', 6, '', '', 9, 'modules/system/system.admin.inc'),
('admin/admincp', '', '', '1', 0x613a303a7b7d, 'admin_redirect', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/admincp', 'CMS', 't', '', '', 'a:0:{}', 6, 'Administration', '', 0, ''),
('admin/appearance', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_themes_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/appearance', 'Appearance', 't', '', '', 'a:0:{}', 6, 'Select and configure your themes.', 'left', -6, 'modules/system/system.admin.inc'),
('admin/appearance/default', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_theme_default', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/appearance/default', 'Set default theme', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/disable', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_theme_disable', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/appearance/disable', 'Disable theme', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/enable', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_theme_enable', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/appearance/enable', 'Enable theme', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/list', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_themes_page', 0x613a303a7b7d, '', 7, 3, 1, 'admin/appearance', 'admin/appearance', 'List', 't', '', '', 'a:0:{}', 140, 'Select and configure your theme', '', -1, 'modules/system/system.admin.inc'),
('admin/appearance/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b7d, '', 7, 3, 1, 'admin/appearance', 'admin/appearance', 'Settings', 't', '', '', 'a:0:{}', 132, 'Configure default and theme specific settings.', '', 20, 'modules/system/system.admin.inc'),
('admin/appearance/settings/bartik', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32353a227468656d65732f62617274696b2f62617274696b2e696e666f223b733a343a226e616d65223b733a363a2262617274696b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a363a2242617274696b223b733a31313a226465736372697074696f6e223b733a34383a224120666c657869626c652c207265636f6c6f7261626c65207468656d652077697468206d616e7920726567696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a373a22726567696f6e73223b613a32303a7b733a363a22686561646572223b733a363a22486561646572223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a383a226665617475726564223b733a383a224665617475726564223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a31333a22736964656261725f6669727374223b733a31333a2253696465626172206669727374223b733a31343a22736964656261725f7365636f6e64223b733a31343a2253696465626172207365636f6e64223b733a31343a2274726970747963685f6669727374223b733a31343a225472697074796368206669727374223b733a31353a2274726970747963685f6d6964646c65223b733a31353a225472697074796368206d6964646c65223b733a31333a2274726970747963685f6c617374223b733a31333a225472697074796368206c617374223b733a31383a22666f6f7465725f6669727374636f6c756d6e223b733a31393a22466f6f74657220666972737420636f6c756d6e223b733a31393a22666f6f7465725f7365636f6e64636f6c756d6e223b733a32303a22466f6f746572207365636f6e6420636f6c756d6e223b733a31383a22666f6f7465725f7468697264636f6c756d6e223b733a31393a22466f6f74657220746869726420636f6c756d6e223b733a31393a22666f6f7465725f666f75727468636f6c756d6e223b733a32303a22466f6f74657220666f7572746820636f6c756d6e223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2230223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32383a227468656d65732f62617274696b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373933383b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a363a2262617274696b223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Bartik', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/settings/garland', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32373a227468656d65732f6761726c616e642f6761726c616e642e696e666f223b733a343a226e616d65223b733a373a226761726c616e64223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a373a224761726c616e64223b733a31313a226465736372697074696f6e223b733a3131313a2241206d756c74692d636f6c756d6e207468656d652077686963682063616e20626520636f6e6669677572656420746f206d6f6469667920636f6c6f727320616e6420737769746368206265747765656e20666978656420616e6420666c756964207769647468206c61796f7574732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a31333a226761726c616e645f7769647468223b733a353a22666c756964223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32393a227468656d65732f6761726c616e642f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373933383b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a373a226761726c616e64223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Garland', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/settings/global', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Global settings', 't', '', '', 'a:0:{}', 140, '', '', -1, 'modules/system/system.admin.inc'),
('admin/appearance/settings/seven', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f736576656e2f736576656e2e696e666f223b733a343a226e616d65223b733a353a22736576656e223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a353a22536576656e223b733a31313a226465736372697074696f6e223b733a36353a22412073696d706c65206f6e652d636f6c756d6e2c207461626c656c6573732c20666c7569642077696474682061646d696e697374726174696f6e207468656d652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2231223b7d733a373a22726567696f6e73223b613a383a7b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31333a22736964656261725f6669727374223b733a31333a2246697273742073696465626172223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a31343a22726567696f6e735f68696464656e223b613a333a7b693a303b733a31333a22736964656261725f6669727374223b693a313b733a383a22706167655f746f70223b693a323b733a31313a22706167655f626f74746f6d223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f736576656e2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373934303b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a353a22736576656e223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Seven', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/settings/stark', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f737461726b2f737461726b2e696e666f223b733a343a226e616d65223b733a353a22737461726b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a353a22537461726b223b733a31313a226465736372697074696f6e223b733a3230383a2254686973207468656d652064656d6f6e737472617465732044727570616c27732064656661756c742048544d4c206d61726b757020616e6420435353207374796c65732e20546f206c6561726e20686f7720746f206275696c6420796f7572206f776e207468656d6520616e64206f766572726964652044727570616c27732064656661756c7420636f64652c2073656520746865203c6120687265663d22687474703a2f2f64727570616c2e6f72672f7468656d652d6775696465223e5468656d696e672047756964653c2f613e2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f737461726b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373934303b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a353a22737461726b223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Stark', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/settings/theme_default', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a34393a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f7468656d655f64656661756c742e696e666f223b733a343a226e616d65223b733a31333a227468656d655f64656661756c74223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31373a7b733a343a226e616d65223b733a31333a2264656661756c74207468656d65223b733a31313a226465736372697074696f6e223b733a31333a2264656661756c74207468656d65223b733a343a22636f7265223b733a333a22372e78223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a2276657273696f6e223b733a333a22372e78223b733a373a2270726f6a656374223b733a31333a2264656661756c74207468656d65223b733a393a22646174657374616d70223b733a31303a2231333332353137383436223b733a373a22726567696f6e73223b613a383a7b733a363a22686561646572223b733a363a22486561646572223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a226c656674223b733a343a224c656674223b733a353a227269676874223b733a353a225269676874223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31333a226373732f7374796c652e637373223b733a34343a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f6373732f7374796c652e637373223b7d7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a34353a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383732393333323b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31333a226373732f7374796c652e637373223b733a34343a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f6373732f7374796c652e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a31333a227468656d655f64656661756c74223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'default theme', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/compact', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_compact_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/compact', 'Compact mode', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_config_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/config', 'Configuration', 't', '', '', 'a:0:{}', 6, 'Administer settings.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/content', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/content', 'Content authoring', 't', '', '', 'a:0:{}', 6, 'Settings related to formatting and authoring content.', 'left', -15, 'modules/system/system.admin.inc'),
('admin/config/content/formats', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e69737465722066696c74657273223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2266696c7465725f61646d696e5f6f76657276696577223b7d, '', 15, 4, 0, '', 'admin/config/content/formats', 'Text formats', 't', '', '', 'a:0:{}', 6, 'Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.', '', 0, 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/%', 0x613a313a7b693a343b733a31383a2266696c7465725f666f726d61745f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e69737465722066696c74657273223b7d, 'filter_admin_format_page', 0x613a313a7b693a303b693a343b7d, '', 30, 5, 0, '', 'admin/config/content/formats/%', '', 'filter_admin_format_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/%/disable', 0x613a313a7b693a343b733a31383a2266696c7465725f666f726d61745f6c6f6164223b7d, '', '_filter_disable_format_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32303a2266696c7465725f61646d696e5f64697361626c65223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/config/content/formats/%/disable', 'Disable text format', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/add', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e69737465722066696c74657273223b7d, 'filter_admin_format_page', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/content/formats', 'admin/config/content/formats', 'Add text format', 't', '', '', 'a:0:{}', 388, '', '', 1, 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/list', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e69737465722066696c74657273223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2266696c7465725f61646d696e5f6f76657276696577223b7d, '', 31, 5, 1, 'admin/config/content/formats', 'admin/config/content/formats', 'List', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/filter/filter.admin.inc'),
('admin/config/development', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/development', 'Development', 't', '', '', 'a:0:{}', 6, 'Development tools.', 'right', -10, 'modules/system/system.admin.inc'),
('admin/config/development/logging', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32333a2273797374656d5f6c6f6767696e675f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/development/logging', 'Logging and errors', 't', '', '', 'a:0:{}', 6, 'Settings for logging and alerts modules. Various modules can route Drupal''s system events to different destinations, such as syslog, database, email, etc.', '', -15, 'modules/system/system.admin.inc'),
('admin/config/development/maintenance', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32383a2273797374656d5f736974655f6d61696e74656e616e63655f6d6f6465223b7d, '', 15, 4, 0, '', 'admin/config/development/maintenance', 'Maintenance mode', 't', '', '', 'a:0:{}', 6, 'Take the site offline for maintenance or bring it back online.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/development/performance', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32373a2273797374656d5f706572666f726d616e63655f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/development/performance', 'Performance', 't', '', '', 'a:0:{}', 6, 'Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.', '', -20, 'modules/system/system.admin.inc'),
('admin/config/media', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/media', 'Media', 't', '', '', 'a:0:{}', 6, 'Media tools.', 'left', -10, 'modules/system/system.admin.inc'),
('admin/config/media/file-system', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32373a2273797374656d5f66696c655f73797374656d5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/media/file-system', 'File system', 't', '', '', 'a:0:{}', 6, 'Tell Drupal where to store uploaded files and how they are accessed.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/media/image-styles', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'image_style_list', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/media/image-styles', 'Image styles', 't', '', '', 'a:0:{}', 6, 'Configure styles that can be used for resizing or adjusting images on display.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/add', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22696d6167655f7374796c655f6164645f666f726d223b7d, '', 31, 5, 1, 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'Add style', 't', '', '', 'a:0:{}', 388, 'Add a new image style.', '', 2, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/delete/%', 0x613a313a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a323a7b693a303b4e3b693a313b733a313a2231223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a22696d6167655f7374796c655f64656c6574655f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/media/image-styles/delete/%', 'Delete style', 't', '', '', 'a:0:{}', 6, 'Delete an image style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%', 0x613a313a7b693a353b733a31363a22696d6167655f7374796c655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31363a22696d6167655f7374796c655f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/media/image-styles/edit/%', 'Edit style', 't', '', '', 'a:0:{}', 6, 'Configure an image style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/add/%', 0x613a323a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a313a7b693a303b693a353b7d7d693a373b613a313a7b733a32383a22696d6167655f6566666563745f646566696e6974696f6e5f6c6f6164223b613a313a7b693a303b693a353b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31373a22696d6167655f6566666563745f666f726d223b693a313b693a353b693a323b693a373b7d, '', 250, 8, 0, '', 'admin/config/media/image-styles/edit/%/add/%', 'Add image effect', 't', '', '', 'a:0:{}', 6, 'Add a new effect to a style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/effects/%', 0x613a323a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a323a7b693a303b693a353b693a313b733a313a2233223b7d7d693a373b613a313a7b733a31373a22696d6167655f6566666563745f6c6f6164223b613a323a7b693a303b693a353b693a313b733a313a2233223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31373a22696d6167655f6566666563745f666f726d223b693a313b693a353b693a323b693a373b7d, '', 250, 8, 0, '', 'admin/config/media/image-styles/edit/%/effects/%', 'Edit image effect', 't', '', '', 'a:0:{}', 6, 'Edit an existing effect within a style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/effects/%/delete', 0x613a323a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a323a7b693a303b693a353b693a313b733a313a2233223b7d7d693a373b613a313a7b733a31373a22696d6167655f6566666563745f6c6f6164223b613a323a7b693a303b693a353b693a313b733a313a2233223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32343a22696d6167655f6566666563745f64656c6574655f666f726d223b693a313b693a353b693a323b693a373b7d, '', 501, 9, 0, '', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'Delete image effect', 't', '', '', 'a:0:{}', 6, 'Delete an existing effect from a style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/list', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'image_style_list', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'List', 't', '', '', 'a:0:{}', 140, 'List the current image styles on the site.', '', 1, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/revert/%', 0x613a313a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a323a7b693a303b4e3b693a313b733a313a2232223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a22696d6167655f7374796c655f7265766572745f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/media/image-styles/revert/%', 'Revert style', 't', '', '', 'a:0:{}', 6, 'Revert an image style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-toolkit', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32393a2273797374656d5f696d6167655f746f6f6c6b69745f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/media/image-toolkit', 'Image toolkit', 't', '', '', 'a:0:{}', 6, 'Choose which image toolkit to use if you have installed optional toolkits.', '', 20, 'modules/system/system.admin.inc'),
('admin/config/people', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/people', 'People', 't', '', '', 'a:0:{}', 6, 'Configure user accounts.', 'left', -20, 'modules/system/system.admin.inc'),
('admin/config/people/accounts', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31393a22757365725f61646d696e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/people/accounts', 'Account settings', 't', '', '', 'a:0:{}', 6, 'Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.', '', -10, 'modules/user/user.admin.inc'),
('admin/config/people/accounts/display', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a2275736572223b693a323b733a343a2275736572223b693a333b733a373a2264656661756c74223b7d, '', 31, 5, 1, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Manage display', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/display/default', '', '', '_field_ui_view_mode_menu_access', 0x613a353a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a373a2264656661756c74223b693a333b733a31313a22757365725f616363657373223b693a343b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a2275736572223b693a323b733a343a2275736572223b693a333b733a373a2264656661756c74223b7d, '', 63, 6, 1, 'admin/config/people/accounts/display', 'admin/config/people/accounts', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/display/full', '', '', '_field_ui_view_mode_menu_access', 0x613a353a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a343a2266756c6c223b693a333b733a31313a22757365725f616363657373223b693a343b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a2275736572223b693a323b733a343a2275736572223b693a333b733a343a2266756c6c223b7d, '', 63, 6, 1, 'admin/config/people/accounts/display', 'admin/config/people/accounts', 'User account', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a343a2275736572223b693a323b733a343a2275736572223b7d, '', 31, 5, 1, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Manage fields', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/people/accounts/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:5;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/delete', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/edit', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/field-settings', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/widget-type', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31393a22757365725f61646d696e5f73657474696e6773223b7d, '', 31, 5, 1, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Settings', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/user/user.admin.inc'),
('admin/config/people/ip-blocking', '', '', 'user_access', 0x613a313a7b693a303b733a31383a22626c6f636b20495020616464726573736573223b7d, 'system_ip_blocking', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/people/ip-blocking', 'IP address blocking', 't', '', '', 'a:0:{}', 6, 'Manage blocked IP addresses.', '', 10, 'modules/system/system.admin.inc'),
('admin/config/people/ip-blocking/delete/%', 0x613a313a7b693a353b733a31353a22626c6f636b65645f69705f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31383a22626c6f636b20495020616464726573736573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a2273797374656d5f69705f626c6f636b696e675f64656c657465223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/people/ip-blocking/delete/%', 'Delete IP address', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/regional', 'Regional and language', 't', '', '', 'a:0:{}', 6, 'Regional settings, localization and translation.', 'left', -5, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2273797374656d5f646174655f74696d655f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/regional/date-time', 'Date and time', 't', '', '', 'a:0:{}', 6, 'Configure display formats for date and time.', '', -15, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_date_time_formats', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Formats', 't', '', '', 'a:0:{}', 132, 'Configure display format strings for date and time.', '', -9, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/%/delete', 0x613a313a7b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33303a2273797374656d5f646174655f64656c6574655f666f726d61745f666f726d223b693a313b693a353b7d, '', 125, 7, 0, '', 'admin/config/regional/date-time/formats/%/delete', 'Delete date format', 't', '', '', 'a:0:{}', 6, 'Allow users to delete a configured date format.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/%/edit', 0x613a313a7b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33343a2273797374656d5f636f6e6669677572655f646174655f666f726d6174735f666f726d223b693a313b693a353b7d, '', 125, 7, 0, '', 'admin/config/regional/date-time/formats/%/edit', 'Edit date format', 't', '', '', 'a:0:{}', 6, 'Allow users to edit a configured date format.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/add', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33343a2273797374656d5f636f6e6669677572655f646174655f666f726d6174735f666f726d223b7d, '', 63, 6, 1, 'admin/config/regional/date-time/formats', 'admin/config/regional/date-time', 'Add format', 't', '', '', 'a:0:{}', 388, 'Allow users to add additional date formats.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/lookup', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_date_time_lookup', 0x613a303a7b7d, '', 63, 6, 0, '', 'admin/config/regional/date-time/formats/lookup', 'Date and time lookup', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2273797374656d5f646174655f74696d655f73657474696e6773223b7d, '', 31, 5, 1, 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Types', 't', '', '', 'a:0:{}', 140, 'Configure display formats for date and time.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types/%/delete', 0x613a313a7b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33353a2273797374656d5f64656c6574655f646174655f666f726d61745f747970655f666f726d223b693a313b693a353b7d, '', 125, 7, 0, '', 'admin/config/regional/date-time/types/%/delete', 'Delete date type', 't', '', '', 'a:0:{}', 6, 'Allow users to delete a configured date type.', '', 0, 'modules/system/system.admin.inc');
INSERT INTO `menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('admin/config/regional/date-time/types/add', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33323a2273797374656d5f6164645f646174655f666f726d61745f747970655f666f726d223b7d, '', 63, 6, 1, 'admin/config/regional/date-time/types', 'admin/config/regional/date-time', 'Add date type', 't', '', '', 'a:0:{}', 388, 'Add new date type.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/regional/settings', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a2273797374656d5f726567696f6e616c5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/regional/settings', 'Regional settings', 't', '', '', 'a:0:{}', 6, 'Settings for the site''s default time zone and country.', '', -20, 'modules/system/system.admin.inc'),
('admin/config/search', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/search', 'Search and metadata', 't', '', '', 'a:0:{}', 6, 'Local site search, metadata and SEO.', 'left', -10, 'modules/system/system.admin.inc'),
('admin/config/search/clean-urls', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2273797374656d5f636c65616e5f75726c5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/search/clean-urls', 'Clean URLs', 't', '', '', 'a:0:{}', 6, 'Enable or disable clean URLs for your site.', '', 5, 'modules/system/system.admin.inc'),
('admin/config/search/clean-urls/check', '', '', '1', 0x613a303a7b7d, 'drupal_json_output', 0x613a313a7b693a303b613a313a7b733a363a22737461747573223b623a313b7d7d, '', 31, 5, 0, '', 'admin/config/search/clean-urls/check', 'Clean URL check', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/search/path', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'path_admin_overview', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/search/path', 'URL aliases', 't', '', '', 'a:0:{}', 6, 'Change your site''s URL paths by aliasing them.', '', -5, 'modules/path/path.admin.inc'),
('admin/config/search/path/add', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'path_admin_edit', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/search/path', 'admin/config/search/path', 'Add alias', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/path/path.admin.inc'),
('admin/config/search/path/delete/%', 0x613a313a7b693a353b733a393a22706174685f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a22706174685f61646d696e5f64656c6574655f636f6e6669726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/search/path/delete/%', 'Delete alias', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/path/path.admin.inc'),
('admin/config/search/path/edit/%', 0x613a313a7b693a353b733a393a22706174685f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'path_admin_edit', 0x613a313a7b693a303b693a353b7d, '', 62, 6, 0, '', 'admin/config/search/path/edit/%', 'Edit alias', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/path/path.admin.inc'),
('admin/config/search/path/list', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'path_admin_overview', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/search/path', 'admin/config/search/path', 'List', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/path/path.admin.inc'),
('admin/config/search/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220736561726368223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a227365617263685f61646d696e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/search/settings', 'Search settings', 't', '', '', 'a:0:{}', 6, 'Configure relevance settings for search and other indexing options.', '', -10, 'modules/search/search.admin.inc'),
('admin/config/search/settings/reindex', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220736561726368223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32323a227365617263685f7265696e6465785f636f6e6669726d223b7d, '', 31, 5, 0, '', 'admin/config/search/settings/reindex', 'Clear index', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/search/search.admin.inc'),
('admin/config/services', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/services', 'Web services', 't', '', '', 'a:0:{}', 6, 'Tools related to web services.', 'right', 0, 'modules/system/system.admin.inc'),
('admin/config/services/rss-publishing', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2273797374656d5f7273735f66656564735f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/services/rss-publishing', 'RSS publishing', 't', '', '', 'a:0:{}', 6, 'Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/system', 'System', 't', '', '', 'a:0:{}', 6, 'General system related configuration.', 'right', -20, 'modules/system/system.admin.inc'),
('admin/config/system/actions', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'system_actions_manage', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/system/actions', 'Actions', 't', '', '', 'a:0:{}', 6, 'Manage the actions defined for your site.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system/actions/configure', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a2273797374656d5f616374696f6e735f636f6e666967757265223b7d, '', 31, 5, 0, '', 'admin/config/system/actions/configure', 'Configure an advanced action', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system/actions/delete/%', 0x613a313a7b693a353b733a31323a22616374696f6e735f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a2273797374656d5f616374696f6e735f64656c6574655f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/system/actions/delete/%', 'Delete action', 't', '', '', 'a:0:{}', 6, 'Delete an action.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system/actions/manage', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'system_actions_manage', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/system/actions', 'admin/config/system/actions', 'Manage actions', 't', '', '', 'a:0:{}', 140, 'Manage the actions defined for your site.', '', -2, 'modules/system/system.admin.inc'),
('admin/config/system/actions/orphan', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'system_actions_remove_orphans', 0x613a303a7b7d, '', 31, 5, 0, '', 'admin/config/system/actions/orphan', 'Remove orphans', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system/cron', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a2273797374656d5f63726f6e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/system/cron', 'Cron', 't', '', '', 'a:0:{}', 6, 'Manage automatic site maintenance tasks.', '', 20, 'modules/system/system.admin.inc'),
('admin/config/system/site-information', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33323a2273797374656d5f736974655f696e666f726d6174696f6e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/system/site-information', 'Site information', 't', '', '', 'a:0:{}', 6, 'Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.', '', -20, 'modules/system/system.admin.inc'),
('admin/config/user-interface', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/user-interface', 'User interface', 't', '', '', 'a:0:{}', 6, 'Tools that enhance the user interface.', 'right', -15, 'modules/system/system.admin.inc'),
('admin/config/user-interface/shortcut', '', '', 'user_access', 0x613a313a7b693a303b733a32303a2261646d696e69737465722073686f727463757473223b7d, 'shortcut_set_admin', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/user-interface/shortcut', 'Shortcuts', 't', '', '', 'a:0:{}', 6, 'Add and modify shortcut sets.', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32323a2273686f72746375745f7365745f637573746f6d697a65223b693a313b693a343b7d, '', 30, 5, 0, '', 'admin/config/user-interface/shortcut/%', 'Edit shortcuts', 'shortcut_set_title_callback', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/add-link', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31373a2273686f72746375745f6c696e6b5f616464223b693a313b693a343b7d, '', 61, 6, 1, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Add shortcut', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/add-link-inline', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'shortcut_link_add_inline', 0x613a313a7b693a303b693a343b7d, '', 61, 6, 0, '', 'admin/config/user-interface/shortcut/%/add-link-inline', 'Add shortcut', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/delete', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_delete_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a2273686f72746375745f7365745f64656c6574655f666f726d223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/config/user-interface/shortcut/%/delete', 'Delete shortcut set', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/edit', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32323a2273686f72746375745f7365745f656469745f666f726d223b693a313b693a343b7d, '', 61, 6, 1, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Edit set name', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/links', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32323a2273686f72746375745f7365745f637573746f6d697a65223b693a313b693a343b7d, '', 61, 6, 1, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'List links', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/add-set', '', '', 'user_access', 0x613a313a7b693a303b733a32303a2261646d696e69737465722073686f727463757473223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2273686f72746375745f7365745f6164645f666f726d223b7d, '', 31, 5, 1, 'admin/config/user-interface/shortcut', 'admin/config/user-interface/shortcut', 'Add shortcut set', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/link/%', 0x613a313a7b693a353b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'shortcut_link_access', 0x613a313a7b693a303b693a353b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31383a2273686f72746375745f6c696e6b5f65646974223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/user-interface/shortcut/link/%', 'Edit shortcut', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/link/%/delete', 0x613a313a7b693a353b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'shortcut_link_access', 0x613a313a7b693a303b693a353b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32303a2273686f72746375745f6c696e6b5f64656c657465223b693a313b693a353b7d, '', 125, 7, 0, '', 'admin/config/user-interface/shortcut/link/%/delete', 'Delete shortcut', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/workflow', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/workflow', 'Workflow', 't', '', '', 'a:0:{}', 6, 'Content workflow, editorial workflow tools.', 'right', 5, 'modules/system/system.admin.inc'),
('admin/content', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261636365737320636f6e74656e74206f76657276696577223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31383a226e6f64655f61646d696e5f636f6e74656e74223b7d, '', 3, 2, 0, '', 'admin/content', 'Content', 't', '', '', 'a:0:{}', 6, 'Administer content and comments.', '', -10, 'modules/node/node.admin.inc'),
('admin/content/comment', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_admin', 0x613a303a7b7d, '', 7, 3, 1, 'admin/content', 'admin/content', 'Comments', 't', '', '', 'a:0:{}', 134, 'List and edit site comments and the comment approval queue.', '', 0, 'modules/comment/comment.admin.inc'),
('admin/content/comment/approval', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_admin', 0x613a313a7b693a303b733a383a22617070726f76616c223b7d, '', 15, 4, 1, 'admin/content/comment', 'admin/content', 'Unapproved comments', 'comment_count_unpublished', '', '', 'a:0:{}', 132, '', '', 0, 'modules/comment/comment.admin.inc'),
('admin/content/comment/new', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_admin', 0x613a303a7b7d, '', 15, 4, 1, 'admin/content/comment', 'admin/content', 'Published comments', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/comment/comment.admin.inc'),
('admin/content/node', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261636365737320636f6e74656e74206f76657276696577223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31383a226e6f64655f61646d696e5f636f6e74656e74223b7d, '', 7, 3, 1, 'admin/content', 'admin/content', 'Content', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/node/node.admin.inc'),
('admin/dashboard', '', '', 'user_access', 0x613a313a7b693a303b733a31363a226163636573732064617368626f617264223b7d, 'dashboard_admin', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/dashboard', 'Dashboard', 't', '', '', 'a:0:{}', 6, 'View and customize your dashboard.', '', -15, ''),
('admin/dashboard/block-content/%/%', 0x613a323a7b693a333b4e3b693a343b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'dashboard_show_block_content', 0x613a323a7b693a303b693a333b693a313b693a343b7d, '', 28, 5, 0, '', 'admin/dashboard/block-content/%/%', '', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('admin/dashboard/configure', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'dashboard_admin_blocks', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/dashboard/configure', 'Configure available dashboard blocks', 't', '', '', 'a:0:{}', 4, 'Configure which blocks can be shown on the dashboard.', '', 0, ''),
('admin/dashboard/customize', '', '', 'user_access', 0x613a313a7b693a303b733a31363a226163636573732064617368626f617264223b7d, 'dashboard_admin', 0x613a313a7b693a303b623a313b7d, '', 7, 3, 0, '', 'admin/dashboard/customize', 'Customize dashboard', 't', '', '', 'a:0:{}', 4, 'Customize your dashboard.', '', 0, ''),
('admin/dashboard/drawer', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'dashboard_show_disabled', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/dashboard/drawer', '', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('admin/dashboard/update', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'dashboard_update', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/dashboard/update', '', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('admin/help', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_main', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/help', 'Help', 't', '', '', 'a:0:{}', 6, 'Reference for usage, configuration, and modules.', '', 9, 'modules/help/help.admin.inc'),
('admin/help/block', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/block', 'block', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/color', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/color', 'color', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/comment', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/comment', 'comment', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/contextual', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/contextual', 'contextual', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/dashboard', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/dashboard', 'dashboard', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/dblog', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/dblog', 'dblog', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/field', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/field', 'field', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/field_sql_storage', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/field_sql_storage', 'field_sql_storage', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/field_ui', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/field_ui', 'field_ui', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/file', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/file', 'file', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/filter', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/filter', 'filter', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/help', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/help', 'help', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/image', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/image', 'image', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/list', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/list', 'list', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/menu', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/menu', 'menu', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/node', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/node', 'node', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/number', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/number', 'number', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/options', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/options', 'options', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/path', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/path', 'path', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/rdf', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/rdf', 'rdf', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/search', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/search', 'search', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/shortcut', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/shortcut', 'shortcut', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/system', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/system', 'system', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/taxonomy', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/taxonomy', 'taxonomy', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/text', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/text', 'text', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/toolbar', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/toolbar', 'toolbar', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/user', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/user', 'user', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/index', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_index', 0x613a303a7b7d, '', 3, 2, 1, 'admin', 'admin', 'Index', 't', '', '', 'a:0:{}', 132, '', '', -18, 'modules/system/system.admin.inc'),
('admin/modules', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a2273797374656d5f6d6f64756c6573223b7d, '', 3, 2, 0, '', 'admin/modules', 'Modules', 't', '', '', 'a:0:{}', 6, 'Extend site functionality.', '', -2, 'modules/system/system.admin.inc'),
('admin/modules/list', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a2273797374656d5f6d6f64756c6573223b7d, '', 7, 3, 1, 'admin/modules', 'admin/modules', 'List', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/system/system.admin.inc'),
('admin/modules/list/confirm', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a2273797374656d5f6d6f64756c6573223b7d, '', 15, 4, 0, '', 'admin/modules/list/confirm', 'List', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/system/system.admin.inc'),
('admin/modules/uninstall', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a2273797374656d5f6d6f64756c65735f756e696e7374616c6c223b7d, '', 7, 3, 1, 'admin/modules', 'admin/modules', 'Uninstall', 't', '', '', 'a:0:{}', 132, '', '', 20, 'modules/system/system.admin.inc'),
('admin/modules/uninstall/confirm', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a2273797374656d5f6d6f64756c65735f756e696e7374616c6c223b7d, '', 15, 4, 0, '', 'admin/modules/uninstall/confirm', 'Uninstall', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/system/system.admin.inc'),
('admin/people', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'user_admin', 0x613a313a7b693a303b733a343a226c697374223b7d, '', 3, 2, 0, '', 'admin/people', 'People', 't', '', '', 'a:0:{}', 6, 'Manage user accounts, roles, and permissions.', 'left', -4, 'modules/user/user.admin.inc'),
('admin/people/create', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'user_admin', 0x613a313a7b693a303b733a363a22637265617465223b7d, '', 7, 3, 1, 'admin/people', 'admin/people', 'Add user', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/user/user.admin.inc'),
('admin/people/people', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'user_admin', 0x613a313a7b693a303b733a343a226c697374223b7d, '', 7, 3, 1, 'admin/people', 'admin/people', 'List', 't', '', '', 'a:0:{}', 140, 'Find and manage people interacting with your site.', '', -10, 'modules/user/user.admin.inc'),
('admin/people/permissions', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e6973746572207065726d697373696f6e73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32323a22757365725f61646d696e5f7065726d697373696f6e73223b7d, '', 7, 3, 1, 'admin/people', 'admin/people', 'Permissions', 't', '', '', 'a:0:{}', 132, 'Determine access to features by selecting permissions for roles.', '', 0, 'modules/user/user.admin.inc'),
('admin/people/permissions/list', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e6973746572207065726d697373696f6e73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32323a22757365725f61646d696e5f7065726d697373696f6e73223b7d, '', 15, 4, 1, 'admin/people/permissions', 'admin/people', 'Permissions', 't', '', '', 'a:0:{}', 140, 'Determine access to features by selecting permissions for roles.', '', -8, 'modules/user/user.admin.inc'),
('admin/people/permissions/roles', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e6973746572207065726d697373696f6e73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31363a22757365725f61646d696e5f726f6c6573223b7d, '', 15, 4, 1, 'admin/people/permissions', 'admin/people', 'Roles', 't', '', '', 'a:0:{}', 132, 'List, edit, or add user roles.', '', -5, 'modules/user/user.admin.inc'),
('admin/people/permissions/roles/delete/%', 0x613a313a7b693a353b733a31343a22757365725f726f6c655f6c6f6164223b7d, '', 'user_role_edit_access', 0x613a313a7b693a303b693a353b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33303a22757365725f61646d696e5f726f6c655f64656c6574655f636f6e6669726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/people/permissions/roles/delete/%', 'Delete role', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/user/user.admin.inc'),
('admin/people/permissions/roles/edit/%', 0x613a313a7b693a353b733a31343a22757365725f726f6c655f6c6f6164223b7d, '', 'user_role_edit_access', 0x613a313a7b693a303b693a353b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31353a22757365725f61646d696e5f726f6c65223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/people/permissions/roles/edit/%', 'Edit role', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/user/user.admin.inc'),
('admin/reports', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/reports', 'Reports', 't', '', '', 'a:0:{}', 6, 'View reports, updates, and errors.', 'left', 5, 'modules/system/system.admin.inc'),
('admin/reports/access-denied', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_top', 0x613a313a7b693a303b733a31333a226163636573732064656e696564223b7d, '', 7, 3, 0, '', 'admin/reports/access-denied', 'Top ''access denied'' errors', 't', '', '', 'a:0:{}', 6, 'View ''access denied'' errors (403s).', '', 0, 'modules/dblog/dblog.admin.inc'),
('admin/reports/dblog', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_overview', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/reports/dblog', 'Recent log messages', 't', '', '', 'a:0:{}', 6, 'View events that have recently been logged.', '', -1, 'modules/dblog/dblog.admin.inc'),
('admin/reports/event/%', 0x613a313a7b693a333b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_event', 0x613a313a7b693a303b693a333b7d, '', 14, 4, 0, '', 'admin/reports/event/%', 'Details', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/dblog/dblog.admin.inc'),
('admin/reports/fields', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'field_ui_fields_list', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/reports/fields', 'Field list', 't', '', '', 'a:0:{}', 6, 'Overview of fields on all entity types.', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/reports/page-not-found', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_top', 0x613a313a7b693a303b733a31343a2270616765206e6f7420666f756e64223b7d, '', 7, 3, 0, '', 'admin/reports/page-not-found', 'Top ''page not found'' errors', 't', '', '', 'a:0:{}', 6, 'View ''page not found'' errors (404s).', '', 0, 'modules/dblog/dblog.admin.inc'),
('admin/reports/search', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_top', 0x613a313a7b693a303b733a363a22736561726368223b7d, '', 7, 3, 0, '', 'admin/reports/search', 'Top search phrases', 't', '', '', 'a:0:{}', 6, 'View most popular search phrases.', '', 0, 'modules/dblog/dblog.admin.inc'),
('admin/reports/status', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_status', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/reports/status', 'Status report', 't', '', '', 'a:0:{}', 6, 'Get a status report about your site''s operation and any detected problems.', '', -60, 'modules/system/system.admin.inc'),
('admin/reports/status/php', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_php', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/reports/status/php', 'PHP', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/reports/status/rebuild', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33303a226e6f64655f636f6e6669677572655f72656275696c645f636f6e6669726d223b7d, '', 15, 4, 0, '', 'admin/reports/status/rebuild', 'Rebuild permissions', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/node/node.admin.inc'),
('admin/reports/status/run-cron', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_run_cron', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/reports/status/run-cron', 'Run cron', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/structure', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/structure', 'Structure', 't', '', '', 'a:0:{}', 6, 'Administer blocks, content types, menus, etc.', 'right', -8, 'modules/system/system.admin.inc'),
('admin/structure/block', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'block_admin_display', 0x613a313a7b693a303b733a31333a227468656d655f64656661756c74223b7d, '', 7, 3, 0, '', 'admin/structure/block', 'Blocks', 't', '', '', 'a:0:{}', 6, 'Configure what block content appears in your site''s sidebars and other regions.', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 15, 4, 1, 'admin/structure/block', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/demo/bartik', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32353a227468656d65732f62617274696b2f62617274696b2e696e666f223b733a343a226e616d65223b733a363a2262617274696b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a363a2242617274696b223b733a31313a226465736372697074696f6e223b733a34383a224120666c657869626c652c207265636f6c6f7261626c65207468656d652077697468206d616e7920726567696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a373a22726567696f6e73223b613a32303a7b733a363a22686561646572223b733a363a22486561646572223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a383a226665617475726564223b733a383a224665617475726564223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a31333a22736964656261725f6669727374223b733a31333a2253696465626172206669727374223b733a31343a22736964656261725f7365636f6e64223b733a31343a2253696465626172207365636f6e64223b733a31343a2274726970747963685f6669727374223b733a31343a225472697074796368206669727374223b733a31353a2274726970747963685f6d6964646c65223b733a31353a225472697074796368206d6964646c65223b733a31333a2274726970747963685f6c617374223b733a31333a225472697074796368206c617374223b733a31383a22666f6f7465725f6669727374636f6c756d6e223b733a31393a22466f6f74657220666972737420636f6c756d6e223b733a31393a22666f6f7465725f7365636f6e64636f6c756d6e223b733a32303a22466f6f746572207365636f6e6420636f6c756d6e223b733a31383a22666f6f7465725f7468697264636f6c756d6e223b733a31393a22466f6f74657220746869726420636f6c756d6e223b733a31393a22666f6f7465725f666f75727468636f6c756d6e223b733a32303a22466f6f74657220666f7572746820636f6c756d6e223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2230223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32383a227468656d65732f62617274696b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373933383b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a363a2262617274696b223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/bartik', 'Bartik', 't', '', '_block_custom_theme', 'a:1:{i:0;s:6:"bartik";}', 0, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/demo/garland', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32373a227468656d65732f6761726c616e642f6761726c616e642e696e666f223b733a343a226e616d65223b733a373a226761726c616e64223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a373a224761726c616e64223b733a31313a226465736372697074696f6e223b733a3131313a2241206d756c74692d636f6c756d6e207468656d652077686963682063616e20626520636f6e6669677572656420746f206d6f6469667920636f6c6f727320616e6420737769746368206265747765656e20666978656420616e6420666c756964207769647468206c61796f7574732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a31333a226761726c616e645f7769647468223b733a353a22666c756964223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32393a227468656d65732f6761726c616e642f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373933383b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a373a226761726c616e64223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/garland', 'Garland', 't', '', '_block_custom_theme', 'a:1:{i:0;s:7:"garland";}', 0, '', '', 0, 'modules/block/block.admin.inc');
INSERT INTO `menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('admin/structure/block/demo/seven', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f736576656e2f736576656e2e696e666f223b733a343a226e616d65223b733a353a22736576656e223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a353a22536576656e223b733a31313a226465736372697074696f6e223b733a36353a22412073696d706c65206f6e652d636f6c756d6e2c207461626c656c6573732c20666c7569642077696474682061646d696e697374726174696f6e207468656d652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2231223b7d733a373a22726567696f6e73223b613a383a7b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31333a22736964656261725f6669727374223b733a31333a2246697273742073696465626172223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a31343a22726567696f6e735f68696464656e223b613a333a7b693a303b733a31333a22736964656261725f6669727374223b693a313b733a383a22706167655f746f70223b693a323b733a31313a22706167655f626f74746f6d223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f736576656e2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373934303b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a353a22736576656e223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/seven', 'Seven', 't', '', '_block_custom_theme', 'a:1:{i:0;s:5:"seven";}', 0, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/demo/stark', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f737461726b2f737461726b2e696e666f223b733a343a226e616d65223b733a353a22737461726b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a353a22537461726b223b733a31313a226465736372697074696f6e223b733a3230383a2254686973207468656d652064656d6f6e737472617465732044727570616c27732064656661756c742048544d4c206d61726b757020616e6420435353207374796c65732e20546f206c6561726e20686f7720746f206275696c6420796f7572206f776e207468656d6520616e64206f766572726964652044727570616c27732064656661756c7420636f64652c2073656520746865203c6120687265663d22687474703a2f2f64727570616c2e6f72672f7468656d652d6775696465223e5468656d696e672047756964653c2f613e2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f737461726b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373934303b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a353a22737461726b223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/stark', 'Stark', 't', '', '_block_custom_theme', 'a:1:{i:0;s:5:"stark";}', 0, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/demo/theme_default', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a34393a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f7468656d655f64656661756c742e696e666f223b733a343a226e616d65223b733a31333a227468656d655f64656661756c74223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31373a7b733a343a226e616d65223b733a31333a2264656661756c74207468656d65223b733a31313a226465736372697074696f6e223b733a31333a2264656661756c74207468656d65223b733a343a22636f7265223b733a333a22372e78223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a2276657273696f6e223b733a333a22372e78223b733a373a2270726f6a656374223b733a31333a2264656661756c74207468656d65223b733a393a22646174657374616d70223b733a31303a2231333332353137383436223b733a373a22726567696f6e73223b613a383a7b733a363a22686561646572223b733a363a22486561646572223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a226c656674223b733a343a224c656674223b733a353a227269676874223b733a353a225269676874223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31333a226373732f7374796c652e637373223b733a34343a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f6373732f7374796c652e637373223b7d7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a34353a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383732393333323b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31333a226373732f7374796c652e637373223b733a34343a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f6373732f7374796c652e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a31333a227468656d655f64656661756c74223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/theme_default', 'default theme', 't', '', '_block_custom_theme', 'a:1:{i:0;s:13:"theme_default";}', 0, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/bartik', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32353a227468656d65732f62617274696b2f62617274696b2e696e666f223b733a343a226e616d65223b733a363a2262617274696b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a363a2242617274696b223b733a31313a226465736372697074696f6e223b733a34383a224120666c657869626c652c207265636f6c6f7261626c65207468656d652077697468206d616e7920726567696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a373a22726567696f6e73223b613a32303a7b733a363a22686561646572223b733a363a22486561646572223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a383a226665617475726564223b733a383a224665617475726564223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a31333a22736964656261725f6669727374223b733a31333a2253696465626172206669727374223b733a31343a22736964656261725f7365636f6e64223b733a31343a2253696465626172207365636f6e64223b733a31343a2274726970747963685f6669727374223b733a31343a225472697074796368206669727374223b733a31353a2274726970747963685f6d6964646c65223b733a31353a225472697074796368206d6964646c65223b733a31333a2274726970747963685f6c617374223b733a31333a225472697074796368206c617374223b733a31383a22666f6f7465725f6669727374636f6c756d6e223b733a31393a22466f6f74657220666972737420636f6c756d6e223b733a31393a22666f6f7465725f7365636f6e64636f6c756d6e223b733a32303a22466f6f746572207365636f6e6420636f6c756d6e223b733a31383a22666f6f7465725f7468697264636f6c756d6e223b733a31393a22466f6f74657220746869726420636f6c756d6e223b733a31393a22666f6f7465725f666f75727468636f6c756d6e223b733a32303a22466f6f74657220666f7572746820636f6c756d6e223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2230223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32383a227468656d65732f62617274696b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373933383b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a363a2262617274696b223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'Bartik', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/bartik/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 63, 6, 1, 'admin/structure/block/list/bartik', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/garland', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32373a227468656d65732f6761726c616e642f6761726c616e642e696e666f223b733a343a226e616d65223b733a373a226761726c616e64223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a373a224761726c616e64223b733a31313a226465736372697074696f6e223b733a3131313a2241206d756c74692d636f6c756d6e207468656d652077686963682063616e20626520636f6e6669677572656420746f206d6f6469667920636f6c6f727320616e6420737769746368206265747765656e20666978656420616e6420666c756964207769647468206c61796f7574732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a31333a226761726c616e645f7769647468223b733a353a22666c756964223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32393a227468656d65732f6761726c616e642f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373933383b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a373a226761726c616e64223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'Garland', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/garland/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 63, 6, 1, 'admin/structure/block/list/garland', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/seven', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f736576656e2f736576656e2e696e666f223b733a343a226e616d65223b733a353a22736576656e223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31393a7b733a343a226e616d65223b733a353a22536576656e223b733a31313a226465736372697074696f6e223b733a36353a22412073696d706c65206f6e652d636f6c756d6e2c207461626c656c6573732c20666c7569642077696474682061646d696e697374726174696f6e207468656d652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2231223b7d733a373a22726567696f6e73223b613a383a7b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31333a22736964656261725f6669727374223b733a31333a2246697273742073696465626172223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a31343a22726567696f6e735f68696464656e223b613a333a7b693a303b733a31333a22736964656261725f6669727374223b693a313b733a383a22706167655f746f70223b693a323b733a31313a22706167655f626f74746f6d223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f736576656e2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373934303b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a353a22736576656e223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'Seven', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/seven/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 63, 6, 1, 'admin/structure/block/list/seven', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/stark', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f737461726b2f737461726b2e696e666f223b733a343a226e616d65223b733a353a22737461726b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a353a22537461726b223b733a31313a226465736372697074696f6e223b733a3230383a2254686973207468656d652064656d6f6e737472617465732044727570616c27732064656661756c742048544d4c206d61726b757020616e6420435353207374796c65732e20546f206c6561726e20686f7720746f206275696c6420796f7572206f776e207468656d6520616e64206f766572726964652044727570616c27732064656661756c7420636f64652c2073656520746865203c6120687265663d22687474703a2f2f64727570616c2e6f72672f7468656d652d6775696465223e5468656d696e672047756964653c2f613e2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f737461726b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373934303b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a353a22737461726b223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'Stark', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/stark/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 63, 6, 1, 'admin/structure/block/list/stark', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/theme_default', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a34393a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f7468656d655f64656661756c742e696e666f223b733a343a226e616d65223b733a31333a227468656d655f64656661756c74223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31373a7b733a343a226e616d65223b733a31333a2264656661756c74207468656d65223b733a31313a226465736372697074696f6e223b733a31333a2264656661756c74207468656d65223b733a343a22636f7265223b733a333a22372e78223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a2276657273696f6e223b733a333a22372e78223b733a373a2270726f6a656374223b733a31333a2264656661756c74207468656d65223b733a393a22646174657374616d70223b733a31303a2231333332353137383436223b733a373a22726567696f6e73223b613a383a7b733a363a22686561646572223b733a363a22486561646572223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a226c656674223b733a343a224c656674223b733a353a227269676874223b733a353a225269676874223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31333a226373732f7374796c652e637373223b733a34343a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f6373732f7374796c652e637373223b7d7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a34353a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383732393333323b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31333a226373732f7374796c652e637373223b733a34343a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f6373732f7374796c652e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a31333a227468656d655f64656661756c74223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'default theme', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%', 0x613a323a7b693a343b4e3b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32313a22626c6f636b5f61646d696e5f636f6e666967757265223b693a313b693a343b693a323b693a353b7d, '', 60, 6, 0, '', 'admin/structure/block/manage/%/%', 'Configure block', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%/configure', 0x613a323a7b693a343b4e3b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32313a22626c6f636b5f61646d696e5f636f6e666967757265223b693a313b693a343b693a323b693a353b7d, '', 121, 7, 2, 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Configure block', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%/delete', 0x613a323a7b693a343b4e3b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32353a22626c6f636b5f637573746f6d5f626c6f636b5f64656c657465223b693a313b693a343b693a323b693a353b7d, '', 121, 7, 0, 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Delete block', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/menu', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_overview_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/structure/menu', 'Menus', 't', '', '', 'a:0:{}', 6, 'Add new menus to your site, edit existing menus, and rename and reorganize menu links.', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/add', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31343a226d656e755f656469745f6d656e75223b693a313b733a333a22616464223b7d, '', 15, 4, 1, 'admin/structure/menu', 'admin/structure/menu', 'Add menu', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/delete', 0x613a313a7b693a343b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_item_delete_page', 0x613a313a7b693a303b693a343b7d, '', 61, 6, 0, '', 'admin/structure/menu/item/%/delete', 'Delete menu link', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/edit', 0x613a313a7b693a343b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a31343a226d656e755f656469745f6974656d223b693a313b733a343a2265646974223b693a323b693a343b693a333b4e3b7d, '', 61, 6, 0, '', 'admin/structure/menu/item/%/edit', 'Edit menu link', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/reset', 0x613a313a7b693a343b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a226d656e755f72657365745f6974656d5f636f6e6669726d223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/structure/menu/item/%/reset', 'Reset menu link', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/list', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_overview_page', 0x613a303a7b7d, '', 15, 4, 1, 'admin/structure/menu', 'admin/structure/menu', 'List menus', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31383a226d656e755f6f766572766965775f666f726d223b693a313b693a343b7d, '', 30, 5, 0, '', 'admin/structure/menu/manage/%', 'Customize menu', 'menu_overview_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/add', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a31343a226d656e755f656469745f6974656d223b693a313b733a333a22616464223b693a323b4e3b693a333b693a343b7d, '', 61, 6, 1, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Add link', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/delete', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_delete_menu_page', 0x613a313a7b693a303b693a343b7d, '', 61, 6, 0, '', 'admin/structure/menu/manage/%/delete', 'Delete menu', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/edit', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31343a226d656e755f656469745f6d656e75223b693a313b733a343a2265646974223b693a323b693a343b7d, '', 61, 6, 3, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Edit menu', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/list', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31383a226d656e755f6f766572766965775f666f726d223b693a313b693a343b7d, '', 61, 6, 3, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'List links', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/parents', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_parent_options_js', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/structure/menu/parents', 'Parent menu items', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('admin/structure/menu/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a226d656e755f636f6e666967757265223b7d, '', 15, 4, 1, 'admin/structure/menu', 'admin/structure/menu', 'Settings', 't', '', '', 'a:0:{}', 132, '', '', 5, 'modules/menu/menu.admin.inc'),
('admin/structure/taxonomy', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33303a227461786f6e6f6d795f6f766572766965775f766f636162756c6172696573223b7d, '', 7, 3, 0, '', 'admin/structure/taxonomy', 'Taxonomy', 't', '', '', 'a:0:{}', 6, 'Manage tagging, categorization, and classification of your content.', '', 0, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a227461786f6e6f6d795f6f766572766965775f7465726d73223b693a313b693a333b7d, '', 14, 4, 0, '', 'admin/structure/taxonomy/%', '', 'entity_label', 'a:2:{i:0;s:19:"taxonomy_vocabulary";i:1;i:3;}', '', 'a:0:{}', 6, '', '', 0, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%/add', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31383a227461786f6e6f6d795f666f726d5f7465726d223b693a313b613a303a7b7d693a323b693a333b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Add term', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%/display', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a31333a227461786f6e6f6d795f7465726d223b693a323b693a333b693a333b733a373a2264656661756c74223b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Manage display', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/display/default', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a353a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a373a2264656661756c74223b693a333b733a31313a22757365725f616363657373223b693a343b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a31333a227461786f6e6f6d795f7465726d223b693a323b693a333b693a333b733a373a2264656661756c74223b7d, '', 59, 6, 1, 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/display/full', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a353a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a343a2266756c6c223b693a333b733a31313a22757365725f616363657373223b693a343b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a31333a227461786f6e6f6d795f7465726d223b693a323b693a333b693a333b733a343a2266756c6c223b7d, '', 59, 6, 1, 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%', 'Taxonomy term page', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/edit', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a227461786f6e6f6d795f666f726d5f766f636162756c617279223b693a313b693a333b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', -10, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%/fields', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a31333a227461786f6e6f6d795f7465726d223b693a323b693a333b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Manage fields', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a353b7d, '', 58, 6, 0, '', 'admin/structure/taxonomy/%/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:5;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('admin/structure/taxonomy/%/fields/%/delete', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a353b7d, '', 117, 7, 1, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/edit', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a353b7d, '', 117, 7, 1, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/field-settings', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a353b7d, '', 117, 7, 1, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/widget-type', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a353b7d, '', 117, 7, 1, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/list', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a227461786f6e6f6d795f6f766572766965775f7465726d73223b693a313b693a333b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'List', 't', '', '', 'a:0:{}', 140, '', '', -20, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/add', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a227461786f6e6f6d795f666f726d5f766f636162756c617279223b7d, '', 15, 4, 1, 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'Add vocabulary', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/list', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33303a227461786f6e6f6d795f6f766572766965775f766f636162756c6172696573223b7d, '', 15, 4, 1, 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'List', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/types', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'node_overview_types', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/structure/types', 'Content types', 't', '', '', 'a:0:{}', 6, 'Manage content types, including default status, front page promotion, comment settings, etc.', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/add', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a226e6f64655f747970655f666f726d223b7d, '', 15, 4, 1, 'admin/structure/types', 'admin/structure/types', 'Add content type', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/list', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'node_overview_types', 0x613a303a7b7d, '', 15, 4, 1, 'admin/structure/types', 'admin/structure/types', 'List', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/node/content_types.inc'),
('admin/structure/types/manage/%', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31343a226e6f64655f747970655f666f726d223b693a313b693a343b7d, '', 30, 5, 0, '', 'admin/structure/types/manage/%', 'Edit content type', 'node_type_page_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/manage/%/comment/display', 0x613a313a7b693a343b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a373a22636f6d6d656e74223b693a323b693a343b693a333b733a373a2264656661756c74223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Comment display', 't', '', '', 'a:0:{}', 132, '', '', 4, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/display/default', 0x613a313a7b693a343b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a353a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a373a2264656661756c74223b693a333b733a31313a22757365725f616363657373223b693a343b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a373a22636f6d6d656e74223b693a323b693a343b693a333b733a373a2264656661756c74223b7d, '', 247, 8, 1, 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/display/full', 0x613a313a7b693a343b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a353a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a343a2266756c6c223b693a333b733a31313a22757365725f616363657373223b693a343b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a373a22636f6d6d656e74223b693a323b693a343b693a333b733a343a2266756c6c223b7d, '', 247, 8, 1, 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%', 'Full comment', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields', 0x613a313a7b693a343b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a373a22636f6d6d656e74223b693a323b693a343b7d, '', 123, 7, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Comment fields', 't', '', '', 'a:0:{}', 132, '', '', 3, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a373b7d, '', 246, 8, 0, '', 'admin/structure/types/manage/%/comment/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:7;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/delete', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a373b7d, '', 493, 9, 1, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/edit', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a373b7d, '', 493, 9, 1, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/field-settings', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a373b7d, '', 493, 9, 1, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/widget-type', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a373b7d, '', 493, 9, 1, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/delete', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226e6f64655f747970655f64656c6574655f636f6e6669726d223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/structure/types/manage/%/delete', 'Delete', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/manage/%/display', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a373a2264656661756c74223b7d, '', 61, 6, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Manage display', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/default', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a353a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a373a2264656661756c74223b693a333b733a31313a22757365725f616363657373223b693a343b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a373a2264656661756c74223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/full', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a353a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a343a2266756c6c223b693a333b733a31313a22757365725f616363657373223b693a343b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a343a2266756c6c223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Full content', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/rss', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a353a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a333a22727373223b693a333b733a31313a22757365725f616363657373223b693a343b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a333a22727373223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'RSS', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/search_index', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a353a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a31323a227365617263685f696e646578223b693a333b733a31313a22757365725f616363657373223b693a343b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a31323a227365617263685f696e646578223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Search index', 't', '', '', 'a:0:{}', 132, '', '', 3, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/search_result', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a353a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a31333a227365617263685f726573756c74223b693a333b733a31313a22757365725f616363657373223b693a343b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a31333a227365617263685f726573756c74223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Search result highlighting input', 't', '', '', 'a:0:{}', 132, '', '', 4, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/teaser', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a353a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a363a22746561736572223b693a333b733a31313a22757365725f616363657373223b693a343b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a363a22746561736572223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Teaser', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/edit', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31343a226e6f64655f747970655f666f726d223b693a313b693a343b7d, '', 61, 6, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/manage/%/fields', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b7d, '', 61, 6, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Manage fields', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a363b7d, '', 122, 7, 0, '', 'admin/structure/types/manage/%/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:6;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/delete', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a363b7d, '', 245, 8, 1, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/edit', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a363b7d, '', 245, 8, 1, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/field-settings', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a363b7d, '', 245, 8, 1, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/widget-type', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a363b7d, '', 245, 8, 1, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/tasks', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 3, 2, 1, 'admin', 'admin', 'Tasks', 't', '', '', 'a:0:{}', 140, '', '', -20, 'modules/system/system.admin.inc'),
('admincp', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 1, 1, 0, '', 'admincp', 'CMS', 't', '', '', 'a:0:{}', 0, 'Administration', '', 0, ''),
('admincp/banner', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admincp/banner', 'Banner Quang cao', 't', '', '', 'a:0:{}', 0, 'banner', '', 0, ''),
('admincp/buildsql', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admincp/buildsql', 'Quan ly thuc thi SQL', 't', '', '', 'a:0:{}', 0, 'build_sql', '', 0, ''),
('admincp/category', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admincp/category', 'Category', 't', '', '', 'a:0:{}', 0, 'Category', '', 0, ''),
('admincp/comments', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admincp/comments', 'Quan ly Binh luan', 't', '', '', 'a:0:{}', 0, 'comments', '', 0, ''),
('admincp/configinfo', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admincp/configinfo', 'Config info', 't', '', '', 'a:0:{}', 0, 'Config info', '', 0, ''),
('admincp/contact', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admincp/contact', 'Quan ly lien he', 't', '', '', 'a:0:{}', 0, 'contact', '', 0, ''),
('admincp/news', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admincp/news', 'News', 't', '', '', 'a:0:{}', 0, 'News', '', 0, ''),
('admincp/product', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admincp/product', 'Quan ly San pham', 't', '', '', 'a:0:{}', 0, 'product', '', 0, ''),
('admincp/province', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admincp/province', 'province', 't', '', '', 'a:0:{}', 0, 'province', '', 0, ''),
('admincp/supplier', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admincp/supplier', 'NCC', 't', '', '', 'a:0:{}', 0, 'NCC', '', 0, ''),
('admincp/supportonline', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admincp/supportonline', 'Support online', 't', '', '', 'a:0:{}', 0, 'Support online', '', 0, ''),
('admincp/usershop', '', '', '1', 0x613a303a7b7d, 'router_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admincp/usershop', 'User Shop', 't', '', '', 'a:0:{}', 0, 'User Shop', '', 0, ''),
('ajax', '', '', '1', 0x613a303a7b7d, 'CoreAjax', 0x613a303a7b7d, '', 1, 1, 0, '', 'ajax', 'Ajax', 't', '', '', 'a:0:{}', 0, 'Ajax', '', 0, ''),
('ajax-action', '', '', '1', 0x613a303a7b7d, 'CoreAjaxAction', 0x613a303a7b7d, '', 1, 1, 0, '', 'ajax-action', 'Ajax action', 't', '', '', 'a:0:{}', 0, 'Ajax action', '', 0, ''),
('ajax-check-user-reg-exist', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33363a2252656753686f70436f6e74726f6c6c65722f616a6178436865636b53686f704578697374223b7d, '', 1, 1, 0, '', 'ajax-check-user-reg-exist', 'Đăng ký shop', 't', '', '', 'a:0:{}', 0, 'Đăng ký shop', '', 0, ''),
('batch', '', '', '1', 0x613a303a7b7d, 'system_batch_page', 0x613a303a7b7d, '', 1, 1, 0, '', 'batch', '', 't', '', '_system_batch_theme', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('comment/%', 0x613a313a7b693a313b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261636365737320636f6d6d656e7473223b7d, 'comment_permalink', 0x613a313a7b693a303b693a313b7d, '', 2, 2, 0, '', 'comment/%', 'Comment permalink', 't', '', '', 'a:0:{}', 6, '', '', 0, ''),
('comment/%/approve', 0x613a313a7b693a313b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_approve', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 0, '', 'comment/%/approve', 'Approve', 't', '', '', 'a:0:{}', 6, '', '', 1, 'modules/comment/comment.pages.inc'),
('comment/%/delete', 0x613a313a7b693a313b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_confirm_delete_page', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'comment/%', 'comment/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/comment/comment.admin.inc'),
('comment/%/edit', 0x613a313a7b693a313b733a31323a22636f6d6d656e745f6c6f6164223b7d, '', 'comment_access', 0x613a323a7b693a303b733a343a2265646974223b693a313b693a313b7d, 'comment_edit_page', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'comment/%', 'comment/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', 0, ''),
('comment/%/view', 0x613a313a7b693a313b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261636365737320636f6d6d656e7473223b7d, 'comment_permalink', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'comment/%', 'comment/%', 'View comment', 't', '', '', 'a:0:{}', 140, '', '', -10, ''),
('comment/reply/%', 0x613a313a7b693a323b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a343a2276696577223b693a313b693a323b7d, 'comment_reply', 0x613a313a7b693a303b693a323b7d, '', 6, 3, 0, '', 'comment/reply/%', 'Add new comment', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/comment/comment.pages.inc'),
('dang-ky.html', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33303a2252656753686f70436f6e74726f6c6c65722f726567697374657253686f70223b7d, '', 1, 1, 0, '', 'dang-ky.html', 'Đăng ký shop', 't', '', '', 'a:0:{}', 0, 'Đăng ký shop', '', 0, ''),
('dang-nhap.html', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a32373a2252656753686f70436f6e74726f6c6c65722f6c6f67696e53686f70223b7d, '', 1, 1, 0, '', 'dang-nhap.html', 'Đăng nhập shop', 't', '', '', 'a:0:{}', 0, 'Đăng nhâp shop', '', 0, ''),
('dang-san-pham.html', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33373a2250726f6475637453686f70436f6e74726f6c6c65722f70726f64756374466f726d53686f70223b7d, '', 1, 1, 0, '', 'dang-san-pham.html', 'Đăng sản phẩm', 't', '', '', 'a:0:{}', 0, 'Đăng sản phẩm', '', 0, ''),
('danh-muc/%/%', 0x613a323a7b693a313b4e3b693a323b4e3b7d, '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33393a2253697465436f6e74726f6c6c65722f6765744c69737450726f64756374496e43617465676f7279223b7d, '', 4, 3, 0, '', 'danh-muc/%/%', 'Danh mục sản phẩm', 't', '', '', 'a:0:{}', 0, 'Danh mục sản phẩm', '', 0, ''),
('doi-mat-khau.html', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33303a2252656753686f70436f6e74726f6c6c65722f656469745061737353686f70223b7d, '', 1, 1, 0, '', 'doi-mat-khau.html', 'Đổi mật khẩu', 't', '', '', 'a:0:{}', 0, 'Đổi mật khẩu', '', 0, ''),
('file/ajax', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'file_ajax_upload', 0x613a303a7b7d, 'ajax_deliver', 3, 2, 0, '', 'file/ajax', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, ''),
('file/progress', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'file_ajax_progress', 0x613a303a7b7d, '', 3, 2, 0, '', 'file/progress', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, ''),
('filter/tips', '', '', '1', 0x613a303a7b7d, 'filter_tips_long', 0x613a303a7b7d, '', 3, 2, 0, '', 'filter/tips', 'Compose tips', 't', '', '', 'a:0:{}', 20, '', '', 0, 'modules/filter/filter.pages.inc'),
('filter/tips/%', 0x613a313a7b693a323b733a31383a2266696c7465725f666f726d61745f6c6f6164223b7d, '', 'filter_access', 0x613a313a7b693a303b693a323b7d, 'filter_tips_long', 0x613a313a7b693a303b693a323b7d, '', 6, 3, 0, '', 'filter/tips/%', 'Compose tips', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/filter/filter.pages.inc'),
('gian-hang/%/%', 0x613a323a7b693a313b4e3b693a323b4e3b7d, '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33313a2250726f6475637453686f70436f6e74726f6c6c65722f696e64657853686f70223b7d, '', 4, 3, 0, '', 'gian-hang/%/%', 'Gian hàng', 't', '', '', 'a:0:{}', 0, 'Gian hàng', '', 0, ''),
('gio-hang.html', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a32373a224361727453686f70436f6e74726f6c6c65722f6361727453686f70223b7d, '', 1, 1, 0, '', 'gio-hang.html', 'Giỏ hàng', 't', '', '', 'a:0:{}', 0, 'Giỏ hàng', '', 0, ''),
('gui-don-hang.html', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33313a224361727453686f70436f6e74726f6c6c65722f6361727453656e6453686f70223b7d, '', 1, 1, 0, '', 'gui-don-hang.html', 'Gửi đơn hàng', 't', '', '', 'a:0:{}', 0, 'Gửi đơn hàng', '', 0, ''),
('gui-lien-he.html', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33373a22436f6e7461637453686f70436f6e74726f6c6c65722f636f6e74616374466f726d53686f70223b7d, '', 1, 1, 0, '', 'gui-lien-he.html', 'Gửi liên hệ', 't', '', '', 'a:0:{}', 0, 'Gửi liên hệ', '', 0, ''),
('lien-he-quan-tri.html', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33333a22436f6e7461637453686f70436f6e74726f6c6c65722f636f6e7461637453686f70223b7d, '', 1, 1, 0, '', 'lien-he-quan-tri.html', 'Quản lý liên hệ', 't', '', '', 'a:0:{}', 0, 'Quản lý liên hệ', '', 0, ''),
('node', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'node_page_default', 0x613a303a7b7d, '', 1, 1, 0, '', 'node', '', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('node/%', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a343a2276696577223b693a313b693a313b7d, 'node_page_view', 0x613a313a7b693a303b693a313b7d, '', 2, 2, 0, '', 'node/%', '', 'node_page_title', 'a:1:{i:0;i:1;}', '', 'a:0:{}', 6, '', '', 0, ''),
('node/%/delete', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a363a2264656c657465223b693a313b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31393a226e6f64655f64656c6574655f636f6e6669726d223b693a313b693a313b7d, '', 5, 3, 2, 'node/%', 'node/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/node/node.pages.inc'),
('node/%/edit', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a363a22757064617465223b693a313b693a313b7d, 'node_page_edit', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 3, 'node/%', 'node/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/node/node.pages.inc'),
('node/%/revisions', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', '_node_revision_access', 0x613a313a7b693a303b693a313b7d, 'node_revision_overview', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'node/%', 'node/%', 'Revisions', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/node/node.pages.inc'),
('node/%/revisions/%/delete', 0x613a323a7b693a313b613a313a7b733a393a226e6f64655f6c6f6164223b613a313a7b693a303b693a333b7d7d693a333b4e3b7d, '', '_node_revision_access', 0x613a323a7b693a303b693a313b693a313b733a363a2264656c657465223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226e6f64655f7265766973696f6e5f64656c6574655f636f6e6669726d223b693a313b693a313b7d, '', 21, 5, 0, '', 'node/%/revisions/%/delete', 'Delete earlier revision', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/node/node.pages.inc'),
('node/%/revisions/%/revert', 0x613a323a7b693a313b613a313a7b733a393a226e6f64655f6c6f6164223b613a313a7b693a303b693a333b7d7d693a333b4e3b7d, '', '_node_revision_access', 0x613a323a7b693a303b693a313b693a313b733a363a22757064617465223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226e6f64655f7265766973696f6e5f7265766572745f636f6e6669726d223b693a313b693a313b7d, '', 21, 5, 0, '', 'node/%/revisions/%/revert', 'Revert to earlier revision', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/node/node.pages.inc'),
('node/%/revisions/%/view', 0x613a323a7b693a313b613a313a7b733a393a226e6f64655f6c6f6164223b613a313a7b693a303b693a333b7d7d693a333b4e3b7d, '', '_node_revision_access', 0x613a313a7b693a303b693a313b7d, 'node_show', 0x613a323a7b693a303b693a313b693a313b623a313b7d, '', 21, 5, 0, '', 'node/%/revisions/%/view', 'Revisions', 't', '', '', 'a:0:{}', 6, '', '', 0, ''),
('node/%/view', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a343a2276696577223b693a313b693a313b7d, 'node_page_view', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'node/%', 'node/%', 'View', 't', '', '', 'a:0:{}', 140, '', '', -10, ''),
('node/add', '', '', '_node_add_access', 0x613a303a7b7d, 'node_add_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'node/add', 'Add content', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/node/node.pages.inc'),
('node/add/article', '', '', 'node_access', 0x613a323a7b693a303b733a363a22637265617465223b693a313b733a373a2261727469636c65223b7d, 'node_add', 0x613a313a7b693a303b733a373a2261727469636c65223b7d, '', 7, 3, 0, '', 'node/add/article', 'Article', 'check_plain', '', '', 'a:0:{}', 6, 'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.', '', 0, 'modules/node/node.pages.inc'),
('node/add/page', '', '', 'node_access', 0x613a323a7b693a303b733a363a22637265617465223b693a313b733a343a2270616765223b7d, 'node_add', 0x613a313a7b693a303b733a343a2270616765223b7d, '', 7, 3, 0, '', 'node/add/page', 'Basic page', 'check_plain', '', '', 'a:0:{}', 6, 'Use <em>basic pages</em> for your static content, such as an ''About us'' page.', '', 0, 'modules/node/node.pages.inc'),
('page-403', '', '', '1', 0x613a303a7b7d, 'page_403', 0x613a303a7b7d, '', 1, 1, 0, '', 'page-403', 'page access denied', 't', '', '', 'a:0:{}', 0, 'page access denied', '', 0, ''),
('page-404', '', '', '1', 0x613a303a7b7d, 'page_404', 0x613a303a7b7d, '', 1, 1, 0, '', 'page-404', 'page not found', 't', '', '', 'a:0:{}', 0, 'page not found', '', 0, ''),
('quan-ly-gian-hang.html', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33333a2250726f6475637453686f70436f6e74726f6c6c65722f70726f6475637453686f70223b7d, '', 1, 1, 0, '', 'quan-ly-gian-hang.html', 'Quản lý sản phẩm', 't', '', '', 'a:0:{}', 0, 'Quản lý sản phẩm', '', 0, ''),
('rss.xml', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'node_feed', 0x613a323a7b693a303b623a303b693a313b613a303a7b7d7d, '', 1, 1, 0, '', 'rss.xml', 'RSS feed', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('san-pham/%/%', 0x613a323a7b693a313b4e3b693a323b4e3b7d, '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33323a2250726f6475637453686f70436f6e74726f6c6c65722f64657461696c53686f70223b7d, '', 4, 3, 0, '', 'san-pham/%/%', 'Chi tiết sản phẩm', 't', '', '', 'a:0:{}', 0, 'Chi tiết sản phẩm', '', 0, ''),
('search', '', '', 'search_is_active', 0x613a303a7b7d, 'search_view', 0x613a303a7b7d, '', 1, 1, 0, '', 'search', 'Search', 't', '', '', 'a:0:{}', 20, '', '', 0, 'modules/search/search.pages.inc'),
('search/node', '', '', '_search_menu_access', 0x613a313a7b693a303b733a343a226e6f6465223b7d, 'search_view', 0x613a323a7b693a303b733a343a226e6f6465223b693a313b733a303a22223b7d, '', 3, 2, 1, 'search', 'search', 'Content', 't', '', '', 'a:0:{}', 132, '', '', -10, 'modules/search/search.pages.inc'),
('search/node/%', 0x613a313a7b693a323b613a313a7b733a31343a226d656e755f7461696c5f6c6f6164223b613a323a7b693a303b733a343a22256d6170223b693a313b733a363a2225696e646578223b7d7d7d, 0x613a313a7b693a323b733a31363a226d656e755f7461696c5f746f5f617267223b7d, '_search_menu_access', 0x613a313a7b693a303b733a343a226e6f6465223b7d, 'search_view', 0x613a323a7b693a303b733a343a226e6f6465223b693a313b693a323b7d, '', 6, 3, 1, 'search/node', 'search/node/%', 'Content', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/search/search.pages.inc'),
('search/user', '', '', '_search_menu_access', 0x613a313a7b693a303b733a343a2275736572223b7d, 'search_view', 0x613a323a7b693a303b733a343a2275736572223b693a313b733a303a22223b7d, '', 3, 2, 1, 'search', 'search', 'Users', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/search/search.pages.inc'),
('search/user/%', 0x613a313a7b693a323b613a313a7b733a31343a226d656e755f7461696c5f6c6f6164223b613a323a7b693a303b733a343a22256d6170223b693a313b733a363a2225696e646578223b7d7d7d, 0x613a313a7b693a323b733a31363a226d656e755f7461696c5f746f5f617267223b7d, '_search_menu_access', 0x613a313a7b693a303b733a343a2275736572223b7d, 'search_view', 0x613a323a7b693a303b733a343a2275736572223b693a313b693a323b7d, '', 6, 3, 1, 'search/node', 'search/node/%', 'Users', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/search/search.pages.inc'),
('sites/default/files/styles/%', 0x613a313a7b693a343b733a31363a22696d6167655f7374796c655f6c6f6164223b7d, '', '1', 0x613a303a7b7d, 'image_style_deliver', 0x613a313a7b693a303b693a343b7d, '', 30, 5, 0, '', 'sites/default/files/styles/%', 'Generate image style', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('sua-san-pham/%/%', 0x613a323a7b693a313b4e3b693a323b4e3b7d, '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33373a2250726f6475637453686f70436f6e74726f6c6c65722f70726f64756374466f726d53686f70223b7d, '', 4, 3, 0, '', 'sua-san-pham/%/%', 'Sửa sản phẩm', 't', '', '', 'a:0:{}', 0, 'Sửa sản phẩm', '', 0, ''),
('sua-thong-tin-gian-hang.html', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33303a2252656753686f70436f6e74726f6c6c65722f65646974496e666f53686f70223b7d, '', 1, 1, 0, '', 'sua-thong-tin-gian-hang.html', 'Sửa thông tin gian hàng', 't', '', '', 'a:0:{}', 0, 'Sửa thông tin gian hàng', '', 0, ''),
('system/ajax', '', '', '1', 0x613a303a7b7d, 'ajax_form_callback', 0x613a303a7b7d, 'ajax_deliver', 3, 2, 0, '', 'system/ajax', 'AHAH callback', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'includes/form.inc'),
('system/files', '', '', '1', 0x613a303a7b7d, 'file_download', 0x613a313a7b693a303b733a373a2270726976617465223b7d, '', 3, 2, 0, '', 'system/files', 'File download', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('system/files/styles/%', 0x613a313a7b693a333b733a31363a22696d6167655f7374796c655f6c6f6164223b7d, '', '1', 0x613a303a7b7d, 'image_style_deliver', 0x613a313a7b693a303b693a333b7d, '', 14, 4, 0, '', 'system/files/styles/%', 'Generate image style', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('system/temporary', '', '', '1', 0x613a303a7b7d, 'file_download', 0x613a313a7b693a303b733a393a2274656d706f72617279223b7d, '', 3, 2, 0, '', 'system/temporary', 'Temporary files', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('system/timezone', '', '', '1', 0x613a303a7b7d, 'system_timezone', 0x613a303a7b7d, '', 3, 2, 0, '', 'system/timezone', 'Time zone', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('taxonomy/autocomplete', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'taxonomy_autocomplete', 0x613a303a7b7d, '', 3, 2, 0, '', 'taxonomy/autocomplete', 'Autocomplete taxonomy', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/taxonomy/taxonomy.pages.inc'),
('taxonomy/term/%', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'taxonomy_term_page', 0x613a313a7b693a303b693a323b7d, '', 6, 3, 0, '', 'taxonomy/term/%', 'Taxonomy term', 'taxonomy_term_title', 'a:1:{i:0;i:2;}', '', 'a:0:{}', 6, '', '', 0, 'modules/taxonomy/taxonomy.pages.inc'),
('taxonomy/term/%/edit', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'taxonomy_term_edit_access', 0x613a313a7b693a303b693a323b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31383a227461786f6e6f6d795f666f726d5f7465726d223b693a313b693a323b693a323b4e3b7d, '', 13, 4, 1, 'taxonomy/term/%', 'taxonomy/term/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/taxonomy/taxonomy.admin.inc'),
('taxonomy/term/%/feed', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'taxonomy_term_feed', 0x613a313a7b693a303b693a323b7d, '', 13, 4, 0, '', 'taxonomy/term/%/feed', 'Taxonomy term', 'taxonomy_term_title', 'a:1:{i:0;i:2;}', '', 'a:0:{}', 0, '', '', 0, 'modules/taxonomy/taxonomy.pages.inc'),
('taxonomy/term/%/view', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'taxonomy_term_page', 0x613a313a7b693a303b693a323b7d, '', 13, 4, 1, 'taxonomy/term/%', 'taxonomy/term/%', 'View', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/taxonomy/taxonomy.pages.inc'),
('thoat.html', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a32383a2252656753686f70436f6e74726f6c6c65722f6c6f676f757453686f70223b7d, '', 1, 1, 0, '', 'thoat.html', 'Thoát shop', 't', '', '', 'a:0:{}', 0, 'Thoat shop', '', 0, ''),
('toolbar/toggle', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320746f6f6c626172223b7d, 'toolbar_toggle_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'toolbar/toggle', 'Toggle drawer visibility', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('trang-chu', '', '', '1', 0x613a303a7b7d, 'page_default', 0x613a303a7b7d, '', 1, 1, 0, '', 'trang-chu', 'Trang chủ', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('user', '', '', '1', 0x613a303a7b7d, 'user_page', 0x613a303a7b7d, '', 1, 1, 0, '', 'user', 'User account', 'user_menu_title', '', '', 'a:0:{}', 6, '', '', -10, 'modules/user/user.pages.inc'),
('user/%', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_view_access', 0x613a313a7b693a303b693a313b7d, 'user_view_page', 0x613a313a7b693a303b693a313b7d, '', 2, 2, 0, '', 'user/%', 'My account', 'user_page_title', 'a:1:{i:0;i:1;}', '', 'a:0:{}', 6, '', '', 0, ''),
('user/%/cancel', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_cancel_access', 0x613a313a7b693a303b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a22757365725f63616e63656c5f636f6e6669726d5f666f726d223b693a313b693a313b7d, '', 5, 3, 0, '', 'user/%/cancel', 'Cancel account', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/user/user.pages.inc'),
('user/%/cancel/confirm/%/%', 0x613a333a7b693a313b733a393a22757365725f6c6f6164223b693a343b4e3b693a353b4e3b7d, '', 'user_cancel_access', 0x613a313a7b693a303b693a313b7d, 'user_cancel_confirm', 0x613a333a7b693a303b693a313b693a313b693a343b693a323b693a353b7d, '', 44, 6, 0, '', 'user/%/cancel/confirm/%/%', 'Confirm account cancellation', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/user/user.pages.inc'),
('user/%/edit', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_edit_access', 0x613a313a7b693a303b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31373a22757365725f70726f66696c655f666f726d223b693a313b693a313b7d, '', 5, 3, 1, 'user/%', 'user/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/user/user.pages.inc'),
('user/%/edit/account', 0x613a313a7b693a313b613a313a7b733a31383a22757365725f63617465676f72795f6c6f6164223b613a323a7b693a303b733a343a22256d6170223b693a313b733a363a2225696e646578223b7d7d7d, '', 'user_edit_access', 0x613a313a7b693a303b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31373a22757365725f70726f66696c655f666f726d223b693a313b693a313b7d, '', 11, 4, 1, 'user/%/edit', 'user/%', 'Account', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/user/user.pages.inc'),
('user/%/shortcuts', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'shortcut_set_switch_access', 0x613a313a7b693a303b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31393a2273686f72746375745f7365745f737769746368223b693a313b693a313b7d, '', 5, 3, 1, 'user/%', 'user/%', 'Shortcuts', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('user/%/view', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_view_access', 0x613a313a7b693a303b693a313b7d, 'user_view_page', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'user/%', 'user/%', 'View', 't', '', '', 'a:0:{}', 140, '', '', -10, ''),
('user/autocomplete', '', '', 'user_access', 0x613a313a7b693a303b733a32303a2261636365737320757365722070726f66696c6573223b7d, 'user_autocomplete', 0x613a303a7b7d, '', 3, 2, 0, '', 'user/autocomplete', 'User autocomplete', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/user/user.pages.inc'),
('user/login', '', '', 'user_is_anonymous', 0x613a303a7b7d, 'user_page', 0x613a303a7b7d, '', 3, 2, 1, 'user', 'user', 'Log in', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/user/user.pages.inc'),
('user/logout', '', '', 'user_is_logged_in', 0x613a303a7b7d, 'user_logout', 0x613a303a7b7d, '', 3, 2, 0, '', 'user/logout', 'Log out', 't', '', '', 'a:0:{}', 6, '', '', 10, 'modules/user/user.pages.inc'),
('user/password', '', '', '1', 0x613a303a7b7d, 'drupal_get_form', 0x613a313a7b693a303b733a393a22757365725f70617373223b7d, '', 3, 2, 1, 'user', 'user', 'Request new password', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/user/user.pages.inc');
INSERT INTO `menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('user/register', '', '', 'user_register_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31383a22757365725f72656769737465725f666f726d223b7d, '', 3, 2, 1, 'user', 'user', 'Create new account', 't', '', '', 'a:0:{}', 132, '', '', 0, ''),
('user/reset/%/%/%', 0x613a333a7b693a323b4e3b693a333b4e3b693a343b4e3b7d, '', '1', 0x613a303a7b7d, 'drupal_get_form', 0x613a343a7b693a303b733a31353a22757365725f706173735f7265736574223b693a313b693a323b693a323b693a333b693a333b693a343b7d, '', 24, 5, 0, '', 'user/reset/%/%/%', 'Reset password', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/user/user.pages.inc'),
('xoa-san-pham', '', '', '1', 0x613a303a7b7d, 'menuLoad', 0x613a313a7b693a303b733a33393a2250726f6475637453686f70436f6e74726f6c6c65722f70726f6475637444656c65746553686f70223b7d, '', 1, 1, 0, '', 'xoa-san-pham', 'xóa sản phẩm', 't', '', '', 'a:0:{}', 0, 'Xóa sản phẩm', '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `node`
--

CREATE TABLE IF NOT EXISTS `node` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `node_access`
--

CREATE TABLE IF NOT EXISTS `node_access` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';

--
-- Dumping data for table `node_access`
--

INSERT INTO `node_access` (`nid`, `gid`, `realm`, `grant_view`, `grant_update`, `grant_delete`) VALUES
(0, 0, 'all', 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `node_comment_statistics`
--

CREATE TABLE IF NOT EXISTS `node_comment_statistics` (
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

-- --------------------------------------------------------

--
-- Table structure for table `node_revision`
--

CREATE TABLE IF NOT EXISTS `node_revision` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `node_type`
--

CREATE TABLE IF NOT EXISTS `node_type` (
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

--
-- Dumping data for table `node_type`
--

INSERT INTO `node_type` (`type`, `name`, `base`, `module`, `description`, `help`, `has_title`, `title_label`, `custom`, `modified`, `locked`, `disabled`, `orig_type`) VALUES
('article', 'Article', 'node_content', 'node', 'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.', '', 1, 'Title', 1, 1, 0, 0, 'article'),
('page', 'Basic page', 'node_content', 'node', 'Use <em>basic pages</em> for your static content, such as an ''About us'' page.', '', 1, 'Title', 1, 1, 0, 0, 'page');

-- --------------------------------------------------------

--
-- Table structure for table `queue`
--

CREATE TABLE IF NOT EXISTS `queue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rdf_mapping`
--

CREATE TABLE IF NOT EXISTS `rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.',
  PRIMARY KEY (`type`,`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores custom RDF mappings for user defined content types...';

--
-- Dumping data for table `rdf_mapping`
--

INSERT INTO `rdf_mapping` (`type`, `bundle`, `mapping`) VALUES
('node', 'article', 0x613a31313a7b733a31313a226669656c645f696d616765223b613a323a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a383a226f673a696d616765223b693a313b733a31323a22726466733a736565416c736f223b7d733a343a2274797065223b733a333a2272656c223b7d733a31303a226669656c645f74616773223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31303a2264633a7375626a656374223b7d733a343a2274797065223b733a333a2272656c223b7d733a373a2272646674797065223b613a323a7b693a303b733a393a2273696f633a4974656d223b693a313b733a31333a22666f61663a446f63756d656e74223b7d733a353a227469746c65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a383a2264633a7469746c65223b7d7d733a373a2263726561746564223b613a333a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a373a2264633a64617465223b693a313b733a31303a2264633a63726561746564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a373a226368616e676564223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31313a2264633a6d6f646966696564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a343a22626f6479223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31353a22636f6e74656e743a656e636f646564223b7d7d733a333a22756964223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6861735f63726561746f72223b7d733a343a2274797065223b733a333a2272656c223b7d733a343a226e616d65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a393a22666f61663a6e616d65223b7d7d733a31333a22636f6d6d656e745f636f756e74223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6e756d5f7265706c696573223b7d733a383a226461746174797065223b733a31313a227873643a696e7465676572223b7d733a31333a226c6173745f6163746976697479223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a32333a2273696f633a6c6173745f61637469766974795f64617465223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d7d),
('node', 'page', 0x613a393a7b733a373a2272646674797065223b613a313a7b693a303b733a31333a22666f61663a446f63756d656e74223b7d733a353a227469746c65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a383a2264633a7469746c65223b7d7d733a373a2263726561746564223b613a333a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a373a2264633a64617465223b693a313b733a31303a2264633a63726561746564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a373a226368616e676564223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31313a2264633a6d6f646966696564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a343a22626f6479223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31353a22636f6e74656e743a656e636f646564223b7d7d733a333a22756964223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6861735f63726561746f72223b7d733a343a2274797065223b733a333a2272656c223b7d733a343a226e616d65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a393a22666f61663a6e616d65223b7d7d733a31333a22636f6d6d656e745f636f756e74223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6e756d5f7265706c696573223b7d733a383a226461746174797065223b733a31313a227873643a696e7465676572223b7d733a31333a226c6173745f6163746976697479223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a32333a2273696f633a6c6173745f61637469766974795f64617465223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d7d);

-- --------------------------------------------------------

--
-- Table structure for table `registry`
--

CREATE TABLE IF NOT EXISTS `registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  PRIMARY KEY (`name`,`type`),
  KEY `hook` (`type`,`weight`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';

--
-- Dumping data for table `registry`
--

INSERT INTO `registry` (`name`, `type`, `filename`, `module`, `weight`) VALUES
('AccessDeniedTestCase', 'class', 'modules/system/system.test', 'system', 0),
('AdminMetaTagTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ArchiverInterface', 'interface', 'includes/archiver.inc', '', 0),
('ArchiverTar', 'class', 'modules/system/system.archiver.inc', 'system', 0),
('ArchiverZip', 'class', 'modules/system/system.archiver.inc', 'system', 0),
('Archive_Tar', 'class', 'modules/system/system.tar.inc', 'system', 0),
('BatchMemoryQueue', 'class', 'includes/batch.queue.inc', '', 0),
('BatchQueue', 'class', 'includes/batch.queue.inc', '', 0),
('BlockAdminThemeTestCase', 'class', 'modules/block/block.test', 'block', -5),
('BlockCacheTestCase', 'class', 'modules/block/block.test', 'block', -5),
('BlockHashTestCase', 'class', 'modules/block/block.test', 'block', -5),
('BlockHiddenRegionTestCase', 'class', 'modules/block/block.test', 'block', -5),
('BlockHTMLIdTestCase', 'class', 'modules/block/block.test', 'block', -5),
('BlockInvalidRegionTestCase', 'class', 'modules/block/block.test', 'block', -5),
('BlockTemplateSuggestionsUnitTest', 'class', 'modules/block/block.test', 'block', -5),
('BlockTestCase', 'class', 'modules/block/block.test', 'block', -5),
('BlockViewModuleDeltaAlterWebTest', 'class', 'modules/block/block.test', 'block', -5),
('ColorTestCase', 'class', 'modules/color/color.test', 'color', 0),
('CommentActionsTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentAnonymous', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentApprovalTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentBlockFunctionalTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentContentRebuild', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentController', 'class', 'modules/comment/comment.module', 'comment', 0),
('CommentFieldsTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentHelperCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentInterfaceTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentNodeAccessTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentNodeChangesTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentPagerTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentPreviewTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentRSSUnitTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentThreadingTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentTokenReplaceTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('ConfirmFormTest', 'class', 'modules/system/system.test', 'system', 0),
('ContextualDynamicContextTestCase', 'class', 'modules/contextual/contextual.test', 'contextual', 0),
('CronQueueTestCase', 'class', 'modules/system/system.test', 'system', 0),
('CronRunTestCase', 'class', 'modules/system/system.test', 'system', 0),
('DashboardBlocksTestCase', 'class', 'modules/dashboard/dashboard.test', 'dashboard', 0),
('Database', 'class', 'includes/database/database.inc', '', 0),
('DatabaseCondition', 'class', 'includes/database/query.inc', '', 0),
('DatabaseConnection', 'class', 'includes/database/database.inc', '', 0),
('DatabaseConnectionNotDefinedException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseConnection_mysql', 'class', 'includes/database/mysql/database.inc', '', 0),
('DatabaseConnection_pgsql', 'class', 'includes/database/pgsql/database.inc', '', 0),
('DatabaseConnection_sqlite', 'class', 'includes/database/sqlite/database.inc', '', 0),
('DatabaseDriverNotSpecifiedException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseLog', 'class', 'includes/database/log.inc', '', 0),
('DatabaseSchema', 'class', 'includes/database/schema.inc', '', 0),
('DatabaseSchemaObjectDoesNotExistException', 'class', 'includes/database/schema.inc', '', 0),
('DatabaseSchemaObjectExistsException', 'class', 'includes/database/schema.inc', '', 0),
('DatabaseSchema_mysql', 'class', 'includes/database/mysql/schema.inc', '', 0),
('DatabaseSchema_pgsql', 'class', 'includes/database/pgsql/schema.inc', '', 0),
('DatabaseSchema_sqlite', 'class', 'includes/database/sqlite/schema.inc', '', 0),
('DatabaseStatementBase', 'class', 'includes/database/database.inc', '', 0),
('DatabaseStatementEmpty', 'class', 'includes/database/database.inc', '', 0),
('DatabaseStatementInterface', 'interface', 'includes/database/database.inc', '', 0),
('DatabaseStatementPrefetch', 'class', 'includes/database/prefetch.inc', '', 0),
('DatabaseStatement_sqlite', 'class', 'includes/database/sqlite/database.inc', '', 0),
('DatabaseTaskException', 'class', 'includes/install.inc', '', 0),
('DatabaseTasks', 'class', 'includes/install.inc', '', 0),
('DatabaseTasks_mysql', 'class', 'includes/database/mysql/install.inc', '', 0),
('DatabaseTasks_pgsql', 'class', 'includes/database/pgsql/install.inc', '', 0),
('DatabaseTasks_sqlite', 'class', 'includes/database/sqlite/install.inc', '', 0),
('DatabaseTransaction', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionCommitFailedException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionExplicitCommitNotAllowedException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionNameNonUniqueException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionNoActiveException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionOutOfOrderException', 'class', 'includes/database/database.inc', '', 0),
('DateTimeFunctionalTest', 'class', 'modules/system/system.test', 'system', 0),
('DBLogTestCase', 'class', 'modules/dblog/dblog.test', 'dblog', 0),
('DefaultMailSystem', 'class', 'modules/system/system.mail.inc', 'system', 0),
('DeleteQuery', 'class', 'includes/database/query.inc', '', 0),
('DeleteQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', 0),
('DrupalCacheArray', 'class', 'includes/bootstrap.inc', '', 0),
('DrupalCacheInterface', 'interface', 'includes/cache.inc', '', 0),
('DrupalDatabaseCache', 'class', 'includes/cache.inc', '', 0),
('DrupalDefaultEntityController', 'class', 'includes/entity.inc', '', 0),
('DrupalEntityControllerInterface', 'interface', 'includes/entity.inc', '', 0),
('DrupalFakeCache', 'class', 'includes/cache-install.inc', '', 0),
('DrupalLocalStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', 0),
('DrupalPrivateStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', 0),
('DrupalPublicStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', 0),
('DrupalQueue', 'class', 'modules/system/system.queue.inc', 'system', 0),
('DrupalQueueInterface', 'interface', 'modules/system/system.queue.inc', 'system', 0),
('DrupalReliableQueueInterface', 'interface', 'modules/system/system.queue.inc', 'system', 0),
('DrupalSetMessageTest', 'class', 'modules/system/system.test', 'system', 0),
('DrupalStreamWrapperInterface', 'interface', 'includes/stream_wrappers.inc', '', 0),
('DrupalTemporaryStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', 0),
('DrupalUpdateException', 'class', 'includes/update.inc', '', 0),
('DrupalUpdaterInterface', 'interface', 'includes/updater.inc', '', 0),
('EnableDisableTestCase', 'class', 'modules/system/system.test', 'system', 0),
('EntityFieldQuery', 'class', 'includes/entity.inc', '', 0),
('EntityFieldQueryException', 'class', 'includes/entity.inc', '', 0),
('EntityMalformedException', 'class', 'includes/entity.inc', '', 0),
('EntityPropertiesTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldAttachOtherTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldAttachStorageTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldAttachTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldBulkDeleteTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldCrudTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldDisplayAPITestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldException', 'class', 'modules/field/field.module', 'field', 0),
('FieldFormTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldInfo', 'class', 'modules/field/field.info.class.inc', 'field', 0),
('FieldInfoTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldInstanceCrudTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldsOverlapException', 'class', 'includes/database/database.inc', '', 0),
('FieldSqlStorageTestCase', 'class', 'modules/field/modules/field_sql_storage/field_sql_storage.test', 'field_sql_storage', 0),
('FieldTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldTranslationsTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldUIAlterTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', 0),
('FieldUIManageDisplayTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', 0),
('FieldUIManageFieldsTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', 0),
('FieldUITestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', 0),
('FieldUpdateForbiddenException', 'class', 'modules/field/field.module', 'field', 0),
('FieldValidationException', 'class', 'modules/field/field.attach.inc', 'field', 0),
('FileFieldDisplayTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldPathTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldRevisionTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldValidateTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldWidgetTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileManagedFileElementTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FilePrivateTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileTaxonomyTermTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileTokenReplaceTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileTransfer', 'class', 'includes/filetransfer/filetransfer.inc', '', 0),
('FileTransferChmodInterface', 'interface', 'includes/filetransfer/filetransfer.inc', '', 0),
('FileTransferException', 'class', 'includes/filetransfer/filetransfer.inc', '', 0),
('FileTransferFTP', 'class', 'includes/filetransfer/ftp.inc', '', 0),
('FileTransferFTPExtension', 'class', 'includes/filetransfer/ftp.inc', '', 0),
('FileTransferLocal', 'class', 'includes/filetransfer/local.inc', '', 0),
('FileTransferSSH', 'class', 'includes/filetransfer/ssh.inc', '', 0),
('FilterAdminTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterCRUDTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterDefaultFormatTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterDOMSerializeTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterFormatAccessTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterHooksTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterNoFormatTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterSecurityTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterSettingsTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterUnitTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FloodFunctionalTest', 'class', 'modules/system/system.test', 'system', 0),
('FrontPageTestCase', 'class', 'modules/system/system.test', 'system', 0),
('HelpTestCase', 'class', 'modules/help/help.test', 'help', 0),
('HookRequirementsTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ImageAdminStylesUnitTest', 'class', 'modules/image/image.test', 'image', 0),
('ImageAdminUiTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageDimensionsScaleTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageDimensionsTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageEffectsUnitTest', 'class', 'modules/image/image.test', 'image', 0),
('ImageFieldDefaultImagesTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageFieldDisplayTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageFieldTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageFieldValidateTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageStyleFlushTest', 'class', 'modules/image/image.test', 'image', 0),
('ImageStylesPathAndUrlTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageThemeFunctionWebTestCase', 'class', 'modules/image/image.test', 'image', 0),
('InfoFileParserTestCase', 'class', 'modules/system/system.test', 'system', 0),
('InsertQuery', 'class', 'includes/database/query.inc', '', 0),
('InsertQuery_mysql', 'class', 'includes/database/mysql/query.inc', '', 0),
('InsertQuery_pgsql', 'class', 'includes/database/pgsql/query.inc', '', 0),
('InsertQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', 0),
('InvalidMergeQueryException', 'class', 'includes/database/database.inc', '', 0),
('IPAddressBlockingTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ListDynamicValuesTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', 0),
('ListDynamicValuesValidationTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', 0),
('ListFieldTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', 0),
('ListFieldUITestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', 0),
('MailSystemInterface', 'interface', 'includes/mail.inc', '', 0),
('MemoryQueue', 'class', 'modules/system/system.queue.inc', 'system', 0),
('MenuNodeTestCase', 'class', 'modules/menu/menu.test', 'menu', 0),
('MenuTestCase', 'class', 'modules/menu/menu.test', 'menu', 0),
('MergeQuery', 'class', 'includes/database/query.inc', '', 0),
('ModuleDependencyTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ModuleRequiredTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ModuleTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ModuleUpdater', 'class', 'modules/system/system.updater.inc', 'system', 0),
('ModuleVersionTestCase', 'class', 'modules/system/system.test', 'system', 0),
('MultiStepNodeFormBasicOptionsTest', 'class', 'modules/node/node.test', 'node', 0),
('NewDefaultThemeBlocks', 'class', 'modules/block/block.test', 'block', -5),
('NodeAccessBaseTableTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessFieldTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessPagerTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessRebuildTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessRecordsTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAdminTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeBlockFunctionalTest', 'class', 'modules/node/node.test', 'node', 0),
('NodeBlockTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeBuildContent', 'class', 'modules/node/node.test', 'node', 0),
('NodeController', 'class', 'modules/node/node.module', 'node', 0),
('NodeCreationTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeEntityFieldQueryAlter', 'class', 'modules/node/node.test', 'node', 0),
('NodeEntityViewModeAlterTest', 'class', 'modules/node/node.test', 'node', 0),
('NodeFeedTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeLoadHooksTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeLoadMultipleTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodePageCacheTest', 'class', 'modules/node/node.test', 'node', 0),
('NodePostSettingsTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeQueryAlter', 'class', 'modules/node/node.test', 'node', 0),
('NodeRevisionPermissionsTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeRevisionsTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeRSSContentTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeSaveTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTitleTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTitleXSSTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTokenReplaceTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTypePersistenceTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTypeTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeWebTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NoFieldsException', 'class', 'includes/database/database.inc', '', 0),
('NoHelpTestCase', 'class', 'modules/help/help.test', 'help', 0),
('NonDefaultBlockAdmin', 'class', 'modules/block/block.test', 'block', -5),
('NumberFieldTestCase', 'class', 'modules/field/modules/number/number.test', 'number', 0),
('OptionsSelectDynamicValuesTestCase', 'class', 'modules/field/modules/options/options.test', 'options', 0),
('OptionsWidgetsTestCase', 'class', 'modules/field/modules/options/options.test', 'options', 0),
('PageEditTestCase', 'class', 'modules/node/node.test', 'node', 0),
('PageNotFoundTestCase', 'class', 'modules/system/system.test', 'system', 0),
('PagePreviewTestCase', 'class', 'modules/node/node.test', 'node', 0),
('PagerDefault', 'class', 'includes/pager.inc', '', 0),
('PageTitleFiltering', 'class', 'modules/system/system.test', 'system', 0),
('PageViewTestCase', 'class', 'modules/node/node.test', 'node', 0),
('PathLanguageTestCase', 'class', 'modules/path/path.test', 'path', 0),
('PathLanguageUITestCase', 'class', 'modules/path/path.test', 'path', 0),
('PathMonolingualTestCase', 'class', 'modules/path/path.test', 'path', 0),
('PathTaxonomyTermTestCase', 'class', 'modules/path/path.test', 'path', 0),
('PathTestCase', 'class', 'modules/path/path.test', 'path', 0),
('Query', 'class', 'includes/database/query.inc', '', 0),
('QueryAlterableInterface', 'interface', 'includes/database/query.inc', '', 0),
('QueryConditionInterface', 'interface', 'includes/database/query.inc', '', 0),
('QueryExtendableInterface', 'interface', 'includes/database/select.inc', '', 0),
('QueryPlaceholderInterface', 'interface', 'includes/database/query.inc', '', 0),
('QueueTestCase', 'class', 'modules/system/system.test', 'system', 0),
('RdfCommentAttributesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfCrudTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfGetRdfNamespacesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfMappingDefinitionTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfMappingHookTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfRdfaMarkupTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfTrackerAttributesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RetrieveFileTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SchemaCache', 'class', 'includes/bootstrap.inc', '', 0),
('SearchAdvancedSearchForm', 'class', 'modules/search/search.test', 'search', 0),
('SearchBlockTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchCommentCountToggleTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchCommentTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchConfigSettingsForm', 'class', 'modules/search/search.test', 'search', 0),
('SearchEmbedForm', 'class', 'modules/search/search.test', 'search', 0),
('SearchExactTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchExcerptTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchExpressionInsertExtractTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchKeywordsConditions', 'class', 'modules/search/search.test', 'search', 0),
('SearchLanguageTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchMatchTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchNodeAccessTest', 'class', 'modules/search/search.test', 'search', 0),
('SearchNodeTagTest', 'class', 'modules/search/search.test', 'search', 0),
('SearchNumberMatchingTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchNumbersTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchPageOverride', 'class', 'modules/search/search.test', 'search', 0),
('SearchPageText', 'class', 'modules/search/search.test', 'search', 0),
('SearchQuery', 'class', 'modules/search/search.extender.inc', 'search', 0),
('SearchRankingTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchSetLocaleTest', 'class', 'modules/search/search.test', 'search', 0),
('SearchSimplifyTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchTokenizerTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SelectQuery', 'class', 'includes/database/select.inc', '', 0),
('SelectQueryExtender', 'class', 'includes/database/select.inc', '', 0),
('SelectQueryInterface', 'interface', 'includes/database/select.inc', '', 0),
('SelectQuery_pgsql', 'class', 'includes/database/pgsql/select.inc', '', 0),
('SelectQuery_sqlite', 'class', 'includes/database/sqlite/select.inc', '', 0),
('ShortcutLinksTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', 0),
('ShortcutSetsTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', 0),
('ShortcutTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', 0),
('ShutdownFunctionsTest', 'class', 'modules/system/system.test', 'system', 0),
('SiteMaintenanceTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SkipDotsRecursiveDirectoryIterator', 'class', 'includes/filetransfer/filetransfer.inc', '', 0),
('StreamWrapperInterface', 'interface', 'includes/stream_wrappers.inc', '', 0),
('SummaryLengthTestCase', 'class', 'modules/node/node.test', 'node', 0),
('SystemAdminTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SystemAuthorizeCase', 'class', 'modules/system/system.test', 'system', 0),
('SystemBlockTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SystemIndexPhpTest', 'class', 'modules/system/system.test', 'system', 0),
('SystemInfoAlterTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SystemMainContentFallback', 'class', 'modules/system/system.test', 'system', 0),
('SystemQueue', 'class', 'modules/system/system.queue.inc', 'system', 0),
('SystemThemeFunctionalTest', 'class', 'modules/system/system.test', 'system', 0),
('SystemValidTokenTest', 'class', 'modules/system/system.test', 'system', 0),
('TableSort', 'class', 'includes/tablesort.inc', '', 0),
('TaxonomyEFQTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyHooksTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyLegacyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyLoadMultipleTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyRSSTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermController', 'class', 'modules/taxonomy/taxonomy.module', 'taxonomy', 0),
('TaxonomyTermFieldMultipleVocabularyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermFieldTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermFunctionTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermIndexTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyThemeTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTokenReplaceTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyVocabularyController', 'class', 'modules/taxonomy/taxonomy.module', 'taxonomy', 0),
('TaxonomyVocabularyFunctionalTest', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyVocabularyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyWebTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TestingMailSystem', 'class', 'modules/system/system.mail.inc', 'system', 0),
('TextFieldTestCase', 'class', 'modules/field/modules/text/text.test', 'text', 0),
('TextSummaryTestCase', 'class', 'modules/field/modules/text/text.test', 'text', 0),
('TextTranslationTestCase', 'class', 'modules/field/modules/text/text.test', 'text', 0),
('ThemeRegistry', 'class', 'includes/theme.inc', '', 0),
('ThemeUpdater', 'class', 'modules/system/system.updater.inc', 'system', 0),
('TokenReplaceTestCase', 'class', 'modules/system/system.test', 'system', 0),
('TokenScanTest', 'class', 'modules/system/system.test', 'system', 0),
('TruncateQuery', 'class', 'includes/database/query.inc', '', 0),
('TruncateQuery_mysql', 'class', 'includes/database/mysql/query.inc', '', 0),
('TruncateQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', 0),
('UpdateQuery', 'class', 'includes/database/query.inc', '', 0),
('UpdateQuery_pgsql', 'class', 'includes/database/pgsql/query.inc', '', 0),
('UpdateQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', 0),
('Updater', 'class', 'includes/updater.inc', '', 0),
('UpdaterException', 'class', 'includes/updater.inc', '', 0),
('UpdaterFileTransferException', 'class', 'includes/updater.inc', '', 0),
('UpdateScriptFunctionalTest', 'class', 'modules/system/system.test', 'system', 0),
('UserAccountLinksUnitTests', 'class', 'modules/user/user.test', 'user', 0),
('UserAdminTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserAuthmapAssignmentTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserAutocompleteTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserBlocksUnitTests', 'class', 'modules/user/user.test', 'user', 0),
('UserCancelTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserController', 'class', 'modules/user/user.module', 'user', 0),
('UserCreateTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserEditedOwnAccountTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserEditTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserLoginTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserPasswordResetTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserPermissionsTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserPictureTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserRegistrationTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserRoleAdminTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserRolesAssignmentTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserSaveTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserSignatureTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserTimeZoneFunctionalTest', 'class', 'modules/user/user.test', 'user', 0),
('UserTokenReplaceTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserUserSearchTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserValidateCurrentPassCustomForm', 'class', 'modules/user/user.test', 'user', 0),
('UserValidationTestCase', 'class', 'modules/user/user.test', 'user', 0);

-- --------------------------------------------------------

--
-- Table structure for table `registry_file`
--

CREATE TABLE IF NOT EXISTS `registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';

--
-- Dumping data for table `registry_file`
--

INSERT INTO `registry_file` (`filename`, `hash`) VALUES
('includes/actions.inc', '859c360d93c9e1b480b2aea97bace00fec80b78ec241d689d50c11c1b9d3724f'),
('includes/ajax.inc', 'bcf9ebd2d63beccea24f2d12cc402a59ba4f0720983e2e1cb82cd6919f21aa94'),
('includes/archiver.inc', '42862bf8819db773fed5c36a8f989a3ff9539a5180164f0cf1f17df26968de0e'),
('includes/authorize.inc', 'f5fe0b9f9c23f9493a42b7b87a1d815f6cf2607042a710c9263d5df78ff35cbb'),
('includes/batch.inc', '2f70e5c137d16e15a6e671ae147332bc31909df233c34128208cd2f018847390'),
('includes/batch.queue.inc', '9bceecc4155daefbe11c87856d034f75634fa8b42ff21c4ee3366794b92bc0ec'),
('includes/bootstrap.inc', 'ff58caa42aa641ff5bcfc6cc2312416dae059f753cbbaf8427736f59965028d9'),
('includes/cache-install.inc', '7405c3a6b7d9a93f88ab299d467d0eff0b17ad36ee4126265f4c6c159204fd90'),
('includes/cache.inc', 'a654efdd1043aec026dd6272a7f5ca57bee82d570ce6c97240eb76bfaad20c83'),
('includes/common.inc', '15263f4439cccd70c0ab8f4204900748522a9408be9f7d65514bc53d2e8fa68e'),
('includes/database/database.inc', '8379205fc94712c9866071c199f4e674cbc4ce2f52530e3afb7be0e9d12c4f02'),
('includes/database/log.inc', '8f413b2a9797b5882642ea8db86439a195c628da691e9c5cab829df25d82dd20'),
('includes/database/mysql/database.inc', 'd46b3188dd3722c49abc6588fa3a5f56004bbd69a81b04b4e96d7fe9a6d22c88'),
('includes/database/mysql/install.inc', '8895c89a3a308c944f141245afd9382faa06dd5c28a4eb2a0076fb95a765e8fb'),
('includes/database/mysql/query.inc', '1bfaa2c759e431d699c353cd86f59a02b6dcb2b7afd775576e082155e23d5474'),
('includes/database/mysql/schema.inc', '0512fb10448f83560e0e93175cb98926d359ba1c19dfaf89091ff954c5396d02'),
('includes/database/pgsql/database.inc', 'c5d5a67d74a47161c1f4b724b1836a0e90ab7787aa7cd19943f41b6b25ba900d'),
('includes/database/pgsql/install.inc', '8c12e3a5d1318c095975db1e1db6addc285e48c2fded0e8cdedbb3c69f4365ba'),
('includes/database/pgsql/query.inc', '4def4aef89e3e971bee2538c485a254cc680a7369e098946088cda0caeaddb18'),
('includes/database/pgsql/schema.inc', '2b970d1a846dfe761e3c3a651b1e123316e29057edcfe8fdf6d72ed5a21bdad8'),
('includes/database/pgsql/select.inc', '5f6abd312afeffced8ad049abb9890589df17b05de6ef514a8df60b641a5da5c'),
('includes/database/prefetch.inc', 'd001592b2c8967a1848d685dc830dfdc6b88c28b802a09a5abfc5e0f1d5af5f6'),
('includes/database/query.inc', '5e29340a7c28bd995a7e001885a5eaedbd58be51cc84eb2abb55a3cae161663f'),
('includes/database/schema.inc', '37044fb7d65582a0022074e0b26d47c36655760152cea5fb5825d90ef35dd1ce'),
('includes/database/select.inc', '057e8fdfcec7f321d5c84f90335a893d126ac4deb43b5095c4d0b2a37a9ca21e'),
('includes/database/sqlite/database.inc', 'bc44135e8f74fd17756812115ed64fc1fb48bab55c6e86ebf22364a3115fd5be'),
('includes/database/sqlite/install.inc', '4f2c42c5fdbaef9f2b28f61f244754755a7ebd356ccc9947c03de80d1ed48019'),
('includes/database/sqlite/query.inc', '64b39522fbb82408c93aca47501583d9fff84e9ddf32bfa105c45da300019c94'),
('includes/database/sqlite/schema.inc', '2de4711ea7b16e3dfdca76fc5dce97b7166e432fcd17ce9d64e95b8483a06bfa'),
('includes/database/sqlite/select.inc', '17d91e8b050487801fbca0023faa7d370490f56e3c069cd707dfb320716fa750'),
('includes/date.inc', '78db5787e7ff1ee4b3ef89cb7d5766c40bab6432cc708080d8198dc8a08ed948'),
('includes/entity.inc', 'aa886cb959da973fff08ad85a0dc0eed05202f2647a508469aef0f650443cc00'),
('includes/errors.inc', '4d8bb04e2efeb179913c3895411ab35b4b45e5aa03eb48d36e2e58adc44428f0'),
('includes/file.inc', '8467f8eb648c7e6f66f85930c6224fce67562a1fc00d98a71847174c83441d88'),
('includes/file.mimetypes.inc', '3f7558f1d6cc5ce54cd8afc34c9946e6291fc7894e78e1eec9fd2829303eb60e'),
('includes/filetransfer/filetransfer.inc', '19c1838b3465797bc3a8c4880efae05f7a76658ac858a6e4a645a63662e57dc7'),
('includes/filetransfer/ftp.inc', 'ef1472c4f7ed05c93e0116148a81181cf81b8293b81b5b87bc4808e11b4f9968'),
('includes/filetransfer/local.inc', '37cd2835cf0f0df5b637542ea8deffe4d5b50bf325a9f69b689386fe9d7c934c'),
('includes/filetransfer/ssh.inc', '7da26ffc1451b63b373b54ed8c134b6f51f64565edab770049a3031c3e70bcd9'),
('includes/form.inc', '99d011db8b0a6b61c04b73ea1d0bb2def641579be3f8e89244a58b96c8b09857'),
('includes/graph.inc', '2f847387a1fc05bc7dbd555d63bb4108cdfb6dea52d0f5a2ccfa3cf52dfab868'),
('includes/image.inc', '5c058a24f3664c03556617773c398189d73b681d962dfb6b7aa17244cc1aa355'),
('includes/install.core.inc', '3a97d3c7c5f550e0f383d797c61aa148bf8b9d7f0101caa3ab3627097ee46008'),
('includes/install.inc', '68b4a25fa55a4cbff138536c55000d4149a7864a1f34290bdfa609e0d46147bb'),
('includes/iso.inc', '0b5499b1578ff12f1361dd68433c5254be458c4b7100d42bbcc7450aac1f6f3e'),
('includes/json-encode.inc', '026d78220c634efe7baf0c1d4835c2ba1a4d4e9b284954e6d70c3a9dbed2a825'),
('includes/language.inc', '3349118f652cff5da4b43dd5bcbad9df3968e165939404bdd96715ff4b2cafb5'),
('includes/locale.inc', 'f25e194f7dab3669d1fa354a7000ec6b1c8053f46fe88852a70bdc639caef0d7'),
('includes/lock.inc', '84481b291a7b7d28ac6c7f54f3fe2ecd15d74423aa9e28baec2e85d50092d615'),
('includes/mail.inc', '07edabc0f904c814010298eb7dadb86633fcf9ddef30ba47e359c7f9d4f8fbe4'),
('includes/menu.inc', 'b1718109de2fdac0e99183c785b101a9d4c1830da21bbbeb3de22c062aa82613'),
('includes/module.inc', '964a6fd1db4efe16b54bc9437e27f3846e14453fb1d490184ef77da1ab13f9e0'),
('includes/pager.inc', '0e88b406e896c45f0d7c78b9f105d067df8bdc1dac9aa4df7cb17a8fd85a0b80'),
('includes/password.inc', 'e630c55e393e85c44150d295c1aa9a9d0f40a428e43b61f38a75082da371354e'),
('includes/path.inc', '43e24e30a182fcbdb4a778f70db725d5d8e6bbbc6fc4d4b5cf827983b5390539'),
('includes/registry.inc', '5c514e8a7c3af6750ef824e7268b255b2a0d22ef87527be377ab69db6c8fe21a'),
('includes/session.inc', 'b394b9ff290563943d498c78c396e0e89ad9a593cc17e9b8efb960f778531187'),
('includes/stream_wrappers.inc', 'bd534ecba834ecbd5438b8ca58ce027cb5984f8e61535de2ef6fb2a8ec68a16d'),
('includes/tablesort.inc', '3e4f789838ffb4aea03c2a98119507a88ebc74f0e71a4d23b8468969aa0fcc64'),
('includes/theme.inc', '3f6a7aa60b6ab2f59f97528cf967a7cba3f354533f0c6d8a1dd63af017403ca1'),
('includes/theme.maintenance.inc', '56f862149825bc1b669ec5f735ce1e89e10e56b781cd2acd81c428c821df39cd'),
('includes/token.inc', '7e268ac14fd364d9b04bbdf60701772233557da649747932ee0d7998878d3b96'),
('includes/unicode.entities.inc', 'e1a42c70df8e5e2f546e79bd9a69eb39085559ff24e45d53d84d51d7e00547e3'),
('includes/unicode.inc', '6dfea063b1241f511f8f16b0632f9437034670074fe808cd43ac2ef366d732aa'),
('includes/update.inc', '50bf04a0f2ba7431d1d7eb96c33ed5cf7396b345fc0c69b740a7b1e6b6225533'),
('includes/updater.inc', 'a9dea2f035e323874929e69beb800b5ff5e73e3b6a904e728788a37ccf008415'),
('includes/utility.inc', '94c2b587b95740533a83354b12d6f68f8f810e19dbb5652c388da470f88ea4be'),
('includes/xmlrpc.inc', '8c586c3afa10c009a468a1d2da32d9749aa413343da4ed584740a0383a3ff9a6'),
('includes/xmlrpcs.inc', 'd2ac209c397201a6b4c55d304b95106f5f2642ec41f22bd252b601e3abfdd801'),
('modules/block/block.test', 'b0968136c024cca3ec9384f4b339095c186068e111d38208562b10268103f704'),
('modules/color/color.test', '8384abb75de38e38e9f9fc6f4d6700b033f8b4fbf81c32d1425a6cc4ac2bbf41'),
('modules/comment/comment.module', '3ab24322a90a253f70716c1c3871f5136e849de6d139b5f7da6c0d9643234bf0'),
('modules/comment/comment.test', 'a4a0ac46c8c8faf5f4fa02e853ff37cc52e87e53952d1dc20e61226a63536348'),
('modules/contextual/contextual.test', 'ea3d4b5752d1a2e159c51d933ed54695ba41976e635dbb3c224ce426d093a888'),
('modules/dashboard/dashboard.test', '73109fa8ee522914cf417adfcf860d5e52eb7e17fdc155fb0d6cf3a8ef587dd3'),
('modules/dblog/dblog.test', 'a19e85e59b922dd31d407c082691223e8aa63e0d5458c0020d28ac0e461628fa'),
('modules/field/field.attach.inc', '13f74d34fab9b8b29c9385d47b341438b186756e4cd48ba703d9a3e27530dbef'),
('modules/field/field.info.class.inc', '9f78fe500e537a0530c665d1a4e24e5d477c21750b18ba7ad32cdb79adf563c7'),
('modules/field/field.module', 'cfe39892a44887d5bcdc86f439a51c8c440b31d77838b4307e22d8369a04bdaa'),
('modules/field/modules/field_sql_storage/field_sql_storage.test', '90b05508fa925e91cd86e30a346b89840505e0b91e17c6b2f0c79a974b818e8d'),
('modules/field/modules/list/tests/list.test', 'f9707dde3e6ec2a0551651105d6e60576e4fa42f51f097136d3663876066f6d3'),
('modules/field/modules/number/number.test', '3d495c619e1a4cfdefdd1af902662ae2c7e2fca2dc50ce8d480689cea15a9e26'),
('modules/field/modules/options/options.test', '2f3b35e2160672b398fbf25a2eb1444072fa4ded15d50400f8bbd2976cf57eae'),
('modules/field/modules/text/text.test', '9cdd20be63154a7320394863b059f7fbbc2321f0a1ab428aa212026416562fad'),
('modules/field/tests/field.test', '7398771cfbf4099d02b1d808a1aa36f6689e7aeef6e94cca0c7ff57b788afe27'),
('modules/field_ui/field_ui.test', 'd0e498445f02efb64fde4c2ec820af23abed312ecbdf32798b24e34ac6a98ca1'),
('modules/file/tests/file.test', '5aaa144e9ea90182da3d3d0bb9fa7b54f56aa10af3680d2b729883e9db3c95d7'),
('modules/filter/filter.test', '683245f1fdca6385be6cb2f15d3f00be98fcfcc3217bbe2f3e29520847d58e8a'),
('modules/help/help.test', 'b8bfed778911b9678882f51d7e10621f22310bf445e269d174b098fb881cea50'),
('modules/image/image.test', '00adeedc873aef14d73c99ef5842a42d1fc2342dcb9fbcfb265563d6a848c746'),
('modules/menu/menu.test', 'c794992fe5949ad5998edf71efccb3400e7245818b4eef61ae4951078a59e4e1'),
('modules/node/node.module', 'b6e3d4f578c9f1a3de37e33a133622de8e3df05a0b2634efaf76dd15a44c2b21'),
('modules/node/node.test', '42ea592189fcf07751be4a846559537250aee597942681d2090eb37251aeb1e4'),
('modules/path/path.test', '164c888c4c51a28ffb83892b938323cf8b9cd6690cd8b32ba1a536cacd66916d'),
('modules/rdf/rdf.test', '7de4968052028f2cb10cd863a1366be7f3f44cdb436e977c971dd0d9fa5946c4'),
('modules/search/search.extender.inc', 'ab6cbc747e79bb8422873f985ef9246e4b25ca0b41401df41b6d06a2669340fa'),
('modules/search/search.test', '565c8969c40a4d9fc8ec8998384f0031f1beaddfca3905f23fd941337c07a271'),
('modules/shortcut/shortcut.test', '0500f73ceca0b5420c13c9a7f80840f730318c7f0272fdf935c270c6ab6d1610'),
('modules/system/system.archiver.inc', 'fe7ad8067602e3e706fad1f6caf3d318a16512e06f4a19f892b696d781506b64'),
('modules/system/system.mail.inc', 'b07bc848006f7c5955607de44442e04dac092b5800e5015a86a7c110f19640c3'),
('modules/system/system.queue.inc', 'b5284a68d70d5ce4840a1e7f18f5450fbed71e0516f588ec8adeac7010dbb857'),
('modules/system/system.tar.inc', '95034047452d379fbe587a822562a25adcc7cf0e72250f14d4f896c0a4e6ce17'),
('modules/system/system.test', 'a5724f5cdda557a453ac8111d024aee6266f21876698354515f7211acdb77f8c'),
('modules/system/system.updater.inc', '4b4d23058f2af162bbbc886e981ce1b60373aa49a4126ae9d8018748758f57ab'),
('modules/taxonomy/taxonomy.module', '906b18ce5dc68c9cd7ad4401203b6d2b616076b62c44949f975f321c0d42c03a'),
('modules/taxonomy/taxonomy.test', 'af5703c63b1f7270aa07767b2fb271849e0899cbd1ac7da725df7038ac8735f4'),
('modules/user/user.module', '85a360dca642f0a1b802c81996fc2b27a1916f124e98401c4abb69b0568c5070'),
('modules/user/user.test', '54d11e323f4b66e532c3124307e04bd61bb581c8edf76e53094104bff4cefdb6');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE IF NOT EXISTS `role` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores user roles.' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`rid`, `name`, `weight`) VALUES
(3, 'Administrator', 2),
(1, 'anonymous user', 0),
(2, 'authenticated user', 1),
(4, 'Manager', 3);

-- --------------------------------------------------------

--
-- Table structure for table `role_permission`
--

CREATE TABLE IF NOT EXISTS `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';

--
-- Dumping data for table `role_permission`
--

INSERT INTO `role_permission` (`rid`, `permission`, `module`) VALUES
(1, 'access comments', 'comment'),
(1, 'access content', 'node'),
(1, 'use text format filtered_html', 'filter'),
(2, 'access comments', 'comment'),
(2, 'access content', 'node'),
(2, 'post comments', 'comment'),
(2, 'skip comment approval', 'comment'),
(2, 'use text format filtered_html', 'filter'),
(3, 'access administration pages', 'system'),
(3, 'access comments', 'comment'),
(3, 'access content', 'node'),
(3, 'access content overview', 'node'),
(3, 'access contextual links', 'contextual'),
(3, 'access dashboard', 'dashboard'),
(3, 'access overlay', 'overlay'),
(3, 'access protected Admin', 'Admin'),
(3, 'access protected HSS Admin', 'HSSAdmin'),
(3, 'access protected HSS Core', 'Core'),
(3, 'access site in maintenance mode', 'system'),
(3, 'access site reports', 'system'),
(3, 'access toolbar', 'toolbar'),
(3, 'access user profiles', 'user'),
(3, 'administer actions', 'system'),
(3, 'administer blocks', 'block'),
(3, 'administer comments', 'comment'),
(3, 'administer content types', 'node'),
(3, 'administer filters', 'filter'),
(3, 'administer image styles', 'image'),
(3, 'administer menu', 'menu'),
(3, 'administer modules', 'system'),
(3, 'administer nodes', 'node'),
(3, 'administer permissions', 'user'),
(3, 'administer search', 'search'),
(3, 'administer shortcuts', 'shortcut'),
(3, 'administer site configuration', 'system'),
(3, 'administer software updates', 'system'),
(3, 'administer taxonomy', 'taxonomy'),
(3, 'administer themes', 'system'),
(3, 'administer url aliases', 'path'),
(3, 'administer users', 'user'),
(3, 'block IP addresses', 'system'),
(3, 'bypass node access', 'node'),
(3, 'cancel account', 'user'),
(3, 'change own username', 'user'),
(3, 'create article content', 'node'),
(3, 'create page content', 'node'),
(3, 'create url aliases', 'path'),
(3, 'customize shortcut links', 'shortcut'),
(3, 'delete any article content', 'node'),
(3, 'delete any page content', 'node'),
(3, 'delete own article content', 'node'),
(3, 'delete own page content', 'node'),
(3, 'delete revisions', 'node'),
(3, 'delete terms in 1', 'taxonomy'),
(3, 'edit any article content', 'node'),
(3, 'edit any page content', 'node'),
(3, 'edit own article content', 'node'),
(3, 'edit own comments', 'comment'),
(3, 'edit own page content', 'node'),
(3, 'edit terms in 1', 'taxonomy'),
(3, 'post comments', 'comment'),
(3, 'revert revisions', 'node'),
(3, 'search content', 'search'),
(3, 'select account cancellation method', 'user'),
(3, 'skip comment approval', 'comment'),
(3, 'switch shortcut sets', 'shortcut'),
(3, 'use advanced search', 'search'),
(3, 'use text format filtered_html', 'filter'),
(3, 'use text format full_html', 'filter'),
(3, 'view own unpublished content', 'node'),
(3, 'view revisions', 'node'),
(3, 'view the administration theme', 'system');

-- --------------------------------------------------------

--
-- Table structure for table `search_dataset`
--

CREATE TABLE IF NOT EXISTS `search_dataset` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Search item ID, e.g. node ID for nodes.',
  `type` varchar(16) NOT NULL COMMENT 'Type of item, e.g. node.',
  `data` longtext NOT NULL COMMENT 'List of space-separated words from the item.',
  `reindex` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Set to force node reindexing.',
  PRIMARY KEY (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items that will be searched.';

-- --------------------------------------------------------

--
-- Table structure for table `search_index`
--

CREATE TABLE IF NOT EXISTS `search_index` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'The search_total.word that is associated with the search item.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item to which the word belongs.',
  `type` varchar(16) NOT NULL COMMENT 'The search_dataset.type of the searchable item to which the word belongs.',
  `score` float DEFAULT NULL COMMENT 'The numeric score of the word, higher being more important.',
  PRIMARY KEY (`word`,`sid`,`type`),
  KEY `sid_type` (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the search index, associating words, items and...';

-- --------------------------------------------------------

--
-- Table structure for table `search_node_links`
--

CREATE TABLE IF NOT EXISTS `search_node_links` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item containing the link to the node.',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT 'The search_dataset.type of the searchable item containing the link to the node.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid that this item links to.',
  `caption` longtext COMMENT 'The text used to link to the node.nid.',
  PRIMARY KEY (`sid`,`type`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items (like nodes) that link to other nodes, used...';

-- --------------------------------------------------------

--
-- Table structure for table `search_total`
--

CREATE TABLE IF NOT EXISTS `search_total` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique word in the search index.',
  `count` float DEFAULT NULL COMMENT 'The count of the word in the index using Zipf’s law to equalize the probability distribution.',
  PRIMARY KEY (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search totals for words.';

-- --------------------------------------------------------

--
-- Table structure for table `semaphore`
--

CREATE TABLE IF NOT EXISTS `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';

-- --------------------------------------------------------

--
-- Table structure for table `sequences`
--

CREATE TABLE IF NOT EXISTS `sequences` (
  `value` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
  PRIMARY KEY (`value`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores IDs.' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `sequences`
--

INSERT INTO `sequences` (`value`) VALUES
(3);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
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

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`uid`, `sid`, `ssid`, `hostname`, `timestamp`, `cache`, `session`) VALUES
(1, 'C5fO7vwAvcufX6dLLbQYQ38lws3KmYfQIr6fYJp0Zmg', '', '117.4.250.39', 1461656259, 0, ''),
(1, 'hLnPsad3LnzwwN0l_l-pwko49EU64Oojv9zc4xUHEw4', '', '117.5.159.41', 1461601237, 0, ''),
(1, 'htCiIRJHZf37xQiU5Xs7L6soJB3R2QpsNpPs5n47YW4', '', '117.1.112.202', 1461655152, 0, ''),
(0, 'kU6mxNl1XQwTD7dwM0-gEWl6c-BCj-EmUMiGV1jSIUA', '', '14.177.21.38', 1461574682, 0, 0x496c6c51584e3751744c61676b784b486741594359634d54366a74535a6872313930576653465143535a754971626638534a5a7977666362416c5933663831366e575754386e4e4d697a624746566b5a554b356a4d78444d6c5836766839615854734f76374b53476e65376e717459486644683476515544574e6f4155727258386a4f617036414d4548553063375563594a494a636d577a517a3146486d43385f3270734132664e444973376c685a734352634c53334631452d427076764478),
(0, 'RkPJPp1NUm7hSU07zi1PMwQjs0CzBF1b4AhT8FCDU5w', '', '117.1.112.202', 1461656213, 0, 0x787a61456f7037466b706e5a314b774b7454686f41564f5031303930337a4733587046746c68525230554d39397274344e754169464b33376f55557872506e30447871637a6276354c625f6c713668506847564666316a3552647a766c69674e393559346f52636d57677678594e65494c644448662d50686a5579564f5a78693873312d357339797034576d4d666e617234585876727961634b4949444c677a4c6b34643534616e5a4b526d685856754e523153635457564c643042417054354f45335a33546f4c4b38514d59756a39734153576e4d50653654426f53497835503850707438594a67376671686d74746c6e59497a694e477838724d4e783874785f66427930745655587a577a31736e4369325268307839476d684f2d69395731374e6132566c546b4a324c537164785a693530624470507946434e3379326673714b7a4f524d79643763614b696d4641572d4a7957586745504a71367674597769484747507857434466496d623673535346617a484973416635796d4d7a5450714975536d7a74497454535f2d757661707750326e6a3559456664724f7633524d4c6e6f6a764a55687a6e654e4366684336574b622d614d355a315959364e54757633356849623936354236394f335a49526c5f616e6b645753376e526d75444f6d6d5364654a4b3637574637445f746b543661744d7a4c495f454f6f4c6d7a366732323037684334773333375f7368776938736e49796c63424355414a6e696f753679627555435a6a456f706b51626e673672754d43686f41584f317451496167366766694c7a47366b7a66354f367541775a3873316f76707534302d30376c435470506e6355744e35347556324a695f613150786958627737494d344d636d5162734d74727a61386670716e5373704577573734634a567837387841666651766248392d5a30484d324c4c447738745038614e654430673065506b6c586755655f353065785546634b654e41305876524d795f634a6f7939504b70706f7a494267633775386a756c6e6c5f44636153556e4f744b6d6779337559594843734f49474e4c7065645856467a443174414a584c396a4c2d5f4c6b42637073496b6a574f5a41314f75502d504a537258647a65646b3642514e62642d665372556a6b4539684132474f6c34506e445f466365514449726c67423865444661746a6c5267744939474b5f49446346514a576d6b37775248436a6168636e486a4638413348477a44774e3369395354486e6c4253703054566f77455f47506b486d5170643734345667495158326d4f6279585250614f7a7a31474134614c53625559784c31635f492d353576686d6e3233526e68677163714d4432537a56326439536d6f5f587552757077504f65685a7342634544764e706348645a513766536769),
(0, 'WrzYm3r0Zlk4Ho9_tcGAtRL25VXnHnEe-y9TBRx02jg', '', '117.4.252.45', 1461574578, 0, 0x636a43533741453457746933614b7073594a3066316872646467786351754449494175436f51527067667337644a6b724252644f6759377349486d62485572463047326656315661375835464d365a6f67725967755a4a4671326a7736736232746b727241734231626c556d544c763246354c54454b4966334e764e3635425962556e693344427053795f484642744443425937664a786d554846586d39684b314e6632753678535962717444545071576971624370425255556654476c4646),
(0, 'Zj8LXENewdLk9RXSLhx7A4Lk0r2chdgt_DqNwdJk27Q', '', '14.177.21.38', 1461574685, 0, 0x496c6c51584e3751744c61676b784b486741594359634d54366a74535a6872313930576653465143535a754971626638534a5a7977666362416c5933663831366e575754386e4e4d697a624746566b5a554b356a4d78444d6c5836766839615854734f76374b53476e65376e717459486644683476515544574e6f4155727258386a4f617036414d4548553063375563594a494a636d577a517a3146486d43385f3270734132664e444973376c685a734352634c53334631452d427076764478);

-- --------------------------------------------------------

--
-- Table structure for table `shortcut_set`
--

CREATE TABLE IF NOT EXISTS `shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.',
  PRIMARY KEY (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';

--
-- Dumping data for table `shortcut_set`
--

INSERT INTO `shortcut_set` (`set_name`, `title`) VALUES
('shortcut-set-1', 'Default');

-- --------------------------------------------------------

--
-- Table structure for table `shortcut_set_users`
--

CREATE TABLE IF NOT EXISTS `shortcut_set_users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid for this set.',
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The shortcut_set.set_name that will be displayed for this user.',
  PRIMARY KEY (`uid`),
  KEY `set_name` (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to shortcut sets.';

-- --------------------------------------------------------

--
-- Table structure for table `system`
--

CREATE TABLE IF NOT EXISTS `system` (
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

--
-- Dumping data for table `system`
--

INSERT INTO `system` (`filename`, `name`, `type`, `owner`, `status`, `bootstrap`, `schema_version`, `weight`, `info`) VALUES
('modules/aggregator/aggregator.module', 'aggregator', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a31303a2241676772656761746f72223b733a31313a226465736372697074696f6e223b733a35373a22416767726567617465732073796e6469636174656420636f6e74656e7420285253532c205244462c20616e642041746f6d206665656473292e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31353a2261676772656761746f722e74657374223b7d733a393a22636f6e666967757265223b733a34313a2261646d696e2f636f6e6669672f73657276696365732f61676772656761746f722f73657474696e6773223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31343a2261676772656761746f722e637373223b733a33333a226d6f64756c65732f61676772656761746f722f61676772656761746f722e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/aggregator/tests/aggregator_test.module', 'aggregator_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32333a2241676772656761746f72206d6f64756c65207465737473223b733a31313a226465736372697074696f6e223b733a34363a22537570706f7274206d6f64756c6520666f722061676772656761746f722072656c617465642074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/block/block.module', 'block', 'module', '', 1, 0, 7009, -5, 0x613a31333a7b733a343a226e616d65223b733a353a22426c6f636b223b733a31313a226465736372697074696f6e223b733a3134303a22436f6e74726f6c73207468652076697375616c206275696c64696e6720626c6f636b732061207061676520697320636f6e737472756374656420776974682e20426c6f636b732061726520626f786573206f6620636f6e74656e742072656e646572656420696e746f20616e20617265612c206f7220726567696f6e2c206f6620612077656220706167652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31303a22626c6f636b2e74657374223b7d733a393a22636f6e666967757265223b733a32313a2261646d696e2f7374727563747572652f626c6f636b223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/block/tests/block_test.module', 'block_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a22426c6f636b2074657374223b733a31313a226465736372697074696f6e223b733a32313a2250726f7669646573207465737420626c6f636b732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/blog/blog.module', 'blog', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a343a22426c6f67223b733a31313a226465736372697074696f6e223b733a32353a22456e61626c6573206d756c74692d7573657220626c6f67732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a22626c6f672e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/book/book.module', 'book', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a343a22426f6f6b223b733a31313a226465736372697074696f6e223b733a36363a22416c6c6f777320757365727320746f2063726561746520616e64206f7267616e697a652072656c6174656420636f6e74656e7420696e20616e206f75746c696e652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a22626f6f6b2e74657374223b7d733a393a22636f6e666967757265223b733a32373a2261646d696e2f636f6e74656e742f626f6f6b2f73657474696e6773223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a383a22626f6f6b2e637373223b733a32313a226d6f64756c65732f626f6f6b2f626f6f6b2e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/color/color.module', 'color', 'module', '', 1, 0, 7001, 0, 0x613a31323a7b733a343a226e616d65223b733a353a22436f6c6f72223b733a31313a226465736372697074696f6e223b733a37303a22416c6c6f77732061646d696e6973747261746f727320746f206368616e67652074686520636f6c6f7220736368656d65206f6620636f6d70617469626c65207468656d65732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31303a22636f6c6f722e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/comment/comment.module', 'comment', 'module', '', 1, 0, 7009, 0, 0x613a31343a7b733a343a226e616d65223b733a373a22436f6d6d656e74223b733a31313a226465736372697074696f6e223b733a35373a22416c6c6f777320757365727320746f20636f6d6d656e74206f6e20616e642064697363757373207075626c697368656420636f6e74656e742e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a343a2274657874223b7d733a353a2266696c6573223b613a323a7b693a303b733a31343a22636f6d6d656e742e6d6f64756c65223b693a313b733a31323a22636f6d6d656e742e74657374223b7d733a393a22636f6e666967757265223b733a32313a2261646d696e2f636f6e74656e742f636f6d6d656e74223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31313a22636f6d6d656e742e637373223b733a32373a226d6f64756c65732f636f6d6d656e742f636f6d6d656e742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/contact/contact.module', 'contact', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a373a22436f6e74616374223b733a31313a226465736372697074696f6e223b733a36313a22456e61626c65732074686520757365206f6620626f746820706572736f6e616c20616e6420736974652d7769646520636f6e7461637420666f726d732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31323a22636f6e746163742e74657374223b7d733a393a22636f6e666967757265223b733a32333a2261646d696e2f7374727563747572652f636f6e74616374223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/contextual/contextual.module', 'contextual', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a31363a22436f6e7465787475616c206c696e6b73223b733a31313a226465736372697074696f6e223b733a37353a2250726f766964657320636f6e7465787475616c206c696e6b7320746f20706572666f726d20616374696f6e732072656c6174656420746f20656c656d656e7473206f6e206120706167652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31353a22636f6e7465787475616c2e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/dashboard/dashboard.module', 'dashboard', 'module', '', 1, 0, 0, 0, 0x613a31333a7b733a343a226e616d65223b733a393a2244617368626f617264223b733a31313a226465736372697074696f6e223b733a3133363a2250726f766964657320612064617368626f617264207061676520696e207468652061646d696e69737472617469766520696e7465726661636520666f72206f7267616e697a696e672061646d696e697374726174697665207461736b7320616e6420747261636b696e6720696e666f726d6174696f6e2077697468696e20796f757220736974652e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a353a2266696c6573223b613a313a7b693a303b733a31343a2264617368626f6172642e74657374223b7d733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a22626c6f636b223b7d733a393a22636f6e666967757265223b733a32353a2261646d696e2f64617368626f6172642f637573746f6d697a65223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/dblog/dblog.module', 'dblog', 'module', '', 1, 1, 7002, 0, 0x613a31323a7b733a343a226e616d65223b733a31363a224461746162617365206c6f6767696e67223b733a31313a226465736372697074696f6e223b733a34373a224c6f677320616e64207265636f7264732073797374656d206576656e747320746f207468652064617461626173652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31303a2264626c6f672e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/field.module', 'field', 'module', '', 1, 0, 7003, 0, 0x613a31343a7b733a343a226e616d65223b733a353a224669656c64223b733a31313a226465736372697074696f6e223b733a35373a224669656c642041504920746f20616464206669656c647320746f20656e746974696573206c696b65206e6f64657320616e642075736572732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a343a7b693a303b733a31323a226669656c642e6d6f64756c65223b693a313b733a31363a226669656c642e6174746163682e696e63223b693a323b733a32303a226669656c642e696e666f2e636c6173732e696e63223b693a333b733a31363a2274657374732f6669656c642e74657374223b7d733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31373a226669656c645f73716c5f73746f72616765223b7d733a383a227265717569726564223b623a313b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31353a227468656d652f6669656c642e637373223b733a32393a226d6f64756c65732f6669656c642f7468656d652f6669656c642e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/field_sql_storage/field_sql_storage.module', 'field_sql_storage', 'module', '', 1, 0, 7002, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a224669656c642053514c2073746f72616765223b733a31313a226465736372697074696f6e223b733a33373a2253746f726573206669656c64206461746120696e20616e2053514c2064617461626173652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a32323a226669656c645f73716c5f73746f726167652e74657374223b7d733a383a227265717569726564223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/list/list.module', 'list', 'module', '', 1, 0, 7002, 0, 0x613a31323a7b733a343a226e616d65223b733a343a224c697374223b733a31313a226465736372697074696f6e223b733a36393a22446566696e6573206c697374206669656c642074797065732e205573652077697468204f7074696f6e7320746f206372656174652073656c656374696f6e206c697374732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a353a226669656c64223b693a313b733a373a226f7074696f6e73223b7d733a353a2266696c6573223b613a313a7b693a303b733a31353a2274657374732f6c6973742e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/list/tests/list_test.module', 'list_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a393a224c6973742074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220746865204c697374206d6f64756c652074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/number/number.module', 'number', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a363a224e756d626572223b733a31313a226465736372697074696f6e223b733a32383a22446566696e6573206e756d65726963206669656c642074797065732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a31313a226e756d6265722e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/options/options.module', 'options', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a373a224f7074696f6e73223b733a31313a226465736372697074696f6e223b733a38323a22446566696e65732073656c656374696f6e2c20636865636b20626f7820616e6420726164696f20627574746f6e207769646765747320666f72207465787420616e64206e756d65726963206669656c64732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a31323a226f7074696f6e732e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/text/text.module', 'text', 'module', '', 1, 0, 7000, 0, 0x613a31343a7b733a343a226e616d65223b733a343a2254657874223b733a31313a226465736372697074696f6e223b733a33323a22446566696e65732073696d706c652074657874206669656c642074797065732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a393a22746578742e74657374223b7d733a383a227265717569726564223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b733a31313a226578706c616e6174696f6e223b733a37333a224669656c64207479706528732920696e20757365202d20736565203c6120687265663d222f61646d696e2f7265706f7274732f6669656c6473223e4669656c64206c6973743c2f613e223b7d),
('modules/field/tests/field_test.module', 'field_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31343a224669656c64204150492054657374223b733a31313a226465736372697074696f6e223b733a33393a22537570706f7274206d6f64756c6520666f7220746865204669656c64204150492074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a353a2266696c6573223b613a313a7b693a303b733a32313a226669656c645f746573742e656e746974792e696e63223b7d733a373a2276657273696f6e223b733a343a22372e3433223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field_ui/field_ui.module', 'field_ui', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a383a224669656c64205549223b733a31313a226465736372697074696f6e223b733a33333a225573657220696e7465726661636520666f7220746865204669656c64204150492e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a31333a226669656c645f75692e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/file/file.module', 'file', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a343a2246696c65223b733a31313a226465736372697074696f6e223b733a32363a22446566696e657320612066696c65206669656c6420747970652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a31353a2274657374732f66696c652e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/file/tests/file_module_test.module', 'file_module_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a393a2246696c652074657374223b733a31313a226465736372697074696f6e223b733a35333a2250726f766964657320686f6f6b7320666f722074657374696e672046696c65206d6f64756c652066756e6374696f6e616c6974792e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/filter/filter.module', 'filter', 'module', '', 1, 0, 7010, 0, 0x613a31343a7b733a343a226e616d65223b733a363a2246696c746572223b733a31313a226465736372697074696f6e223b733a34333a2246696c7465727320636f6e74656e7420696e207072657061726174696f6e20666f7220646973706c61792e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a2266696c7465722e74657374223b7d733a383a227265717569726564223b623a313b733a393a22636f6e666967757265223b733a32383a2261646d696e2f636f6e6669672f636f6e74656e742f666f726d617473223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/forum/forum.module', 'forum', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a353a22466f72756d223b733a31313a226465736372697074696f6e223b733a32373a2250726f76696465732064697363757373696f6e20666f72756d732e223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a383a227461786f6e6f6d79223b693a313b733a373a22636f6d6d656e74223b7d733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31303a22666f72756d2e74657374223b7d733a393a22636f6e666967757265223b733a32313a2261646d696e2f7374727563747572652f666f72756d223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a393a22666f72756d2e637373223b733a32333a226d6f64756c65732f666f72756d2f666f72756d2e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/help/help.module', 'help', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a343a2248656c70223b733a31313a226465736372697074696f6e223b733a33353a224d616e616765732074686520646973706c6179206f66206f6e6c696e652068656c702e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a2268656c702e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/image/image.module', 'image', 'module', '', 1, 0, 7005, 0, 0x613a31353a7b733a343a226e616d65223b733a353a22496d616765223b733a31313a226465736372697074696f6e223b733a33343a2250726f766964657320696d616765206d616e6970756c6174696f6e20746f6f6c732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a343a2266696c65223b7d733a353a2266696c6573223b613a313a7b693a303b733a31303a22696d6167652e74657374223b7d733a393a22636f6e666967757265223b733a33313a2261646d696e2f636f6e6669672f6d656469612f696d6167652d7374796c6573223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b733a383a227265717569726564223b623a313b733a31313a226578706c616e6174696f6e223b733a37333a224669656c64207479706528732920696e20757365202d20736565203c6120687265663d222f61646d696e2f7265706f7274732f6669656c6473223e4669656c64206c6973743c2f613e223b7d),
('modules/image/tests/image_module_test.module', 'image_module_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a22496d6167652074657374223b733a31313a226465736372697074696f6e223b733a36393a2250726f766964657320686f6f6b20696d706c656d656e746174696f6e7320666f722074657374696e6720496d616765206d6f64756c652066756e6374696f6e616c6974792e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a32343a22696d6167655f6d6f64756c655f746573742e6d6f64756c65223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/locale/locale.module', 'locale', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a363a224c6f63616c65223b733a31313a226465736372697074696f6e223b733a3131393a2241646473206c616e67756167652068616e646c696e672066756e6374696f6e616c69747920616e6420656e61626c657320746865207472616e736c6174696f6e206f6620746865207573657220696e7465726661636520746f206c616e677561676573206f74686572207468616e20456e676c6973682e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a226c6f63616c652e74657374223b7d733a393a22636f6e666967757265223b733a33303a2261646d696e2f636f6e6669672f726567696f6e616c2f6c616e6775616765223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/locale/tests/locale_test.module', 'locale_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a224c6f63616c652054657374223b733a31313a226465736372697074696f6e223b733a34323a22537570706f7274206d6f64756c6520666f7220746865206c6f63616c65206c617965722074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/menu/menu.module', 'menu', 'module', '', 1, 0, 7003, 0, 0x613a31333a7b733a343a226e616d65223b733a343a224d656e75223b733a31313a226465736372697074696f6e223b733a36303a22416c6c6f77732061646d696e6973747261746f727320746f20637573746f6d697a65207468652073697465206e617669676174696f6e206d656e752e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a226d656e752e74657374223b7d733a393a22636f6e666967757265223b733a32303a2261646d696e2f7374727563747572652f6d656e75223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/node/node.module', 'node', 'module', '', 1, 0, 7015, 0, 0x613a31353a7b733a343a226e616d65223b733a343a224e6f6465223b733a31313a226465736372697074696f6e223b733a36363a22416c6c6f777320636f6e74656e7420746f206265207375626d697474656420746f20746865207369746520616e6420646973706c61796564206f6e2070616765732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a31313a226e6f64652e6d6f64756c65223b693a313b733a393a226e6f64652e74657374223b7d733a383a227265717569726564223b623a313b733a393a22636f6e666967757265223b733a32313a2261646d696e2f7374727563747572652f7479706573223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a383a226e6f64652e637373223b733a32313a226d6f64756c65732f6e6f64652f6e6f64652e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/node/tests/node_access_test.module', 'node_access_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32343a224e6f6465206d6f64756c6520616363657373207465737473223b733a31313a226465736372697074696f6e223b733a34333a22537570706f7274206d6f64756c6520666f72206e6f6465207065726d697373696f6e2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/node/tests/node_test.module', 'node_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a224e6f6465206d6f64756c65207465737473223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f72206e6f64652072656c617465642074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/node/tests/node_test_exception.module', 'node_test_exception', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32373a224e6f6465206d6f64756c6520657863657074696f6e207465737473223b733a31313a226465736372697074696f6e223b733a35303a22537570706f7274206d6f64756c6520666f72206e6f64652072656c6174656420657863657074696f6e2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/openid/openid.module', 'openid', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a363a224f70656e4944223b733a31313a226465736372697074696f6e223b733a34383a22416c6c6f777320757365727320746f206c6f6720696e746f20796f75722073697465207573696e67204f70656e49442e223b733a373a2276657273696f6e223b733a343a22372e3433223b733a373a227061636b616765223b733a343a22436f7265223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a226f70656e69642e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/openid/tests/openid_test.module', 'openid_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a224f70656e49442064756d6d792070726f7669646572223b733a31313a226465736372697074696f6e223b733a33333a224f70656e49442070726f7669646572207573656420666f722074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a226f70656e6964223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/overlay/overlay.module', 'overlay', 'module', '', 0, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a373a224f7665726c6179223b733a31313a226465736372697074696f6e223b733a35393a22446973706c617973207468652044727570616c2061646d696e697374726174696f6e20696e7465726661636520696e20616e206f7665726c61792e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/path/path.module', 'path', 'module', '', 1, 0, 0, 0, 0x613a31333a7b733a343a226e616d65223b733a343a2250617468223b733a31313a226465736372697074696f6e223b733a32383a22416c6c6f777320757365727320746f2072656e616d652055524c732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a22706174682e74657374223b7d733a393a22636f6e666967757265223b733a32343a2261646d696e2f636f6e6669672f7365617263682f70617468223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/php/php.module', 'php', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31303a225048502066696c746572223b733a31313a226465736372697074696f6e223b733a35303a22416c6c6f777320656d6265646465642050485020636f64652f736e69707065747320746f206265206576616c75617465642e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a383a227068702e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/poll/poll.module', 'poll', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a343a22506f6c6c223b733a31313a226465736372697074696f6e223b733a39353a22416c6c6f777320796f7572207369746520746f206361707475726520766f746573206f6e20646966666572656e7420746f7069637320696e2074686520666f726d206f66206d756c7469706c652063686f696365207175657374696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a22706f6c6c2e74657374223b7d733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a383a22706f6c6c2e637373223b733a32313a226d6f64756c65732f706f6c6c2f706f6c6c2e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/profile/profile.module', 'profile', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a373a2250726f66696c65223b733a31313a226465736372697074696f6e223b733a33363a22537570706f72747320636f6e666967757261626c6520757365722070726f66696c65732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31323a2270726f66696c652e74657374223b7d733a393a22636f6e666967757265223b733a32373a2261646d696e2f636f6e6669672f70656f706c652f70726f66696c65223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/rdf/rdf.module', 'rdf', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a333a22524446223b733a31313a226465736372697074696f6e223b733a3134383a22456e72696368657320796f757220636f6e74656e742077697468206d6574616461746120746f206c6574206f74686572206170706c69636174696f6e732028652e672e2073656172636820656e67696e65732c2061676772656761746f7273292062657474657220756e6465727374616e64206974732072656c6174696f6e736869707320616e6420617474726962757465732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a383a227264662e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/rdf/tests/rdf_test.module', 'rdf_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a22524446206d6f64756c65207465737473223b733a31313a226465736372697074696f6e223b733a33383a22537570706f7274206d6f64756c6520666f7220524446206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/search/search.module', 'search', 'module', '', 1, 0, 7000, 0, 0x613a31343a7b733a343a226e616d65223b733a363a22536561726368223b733a31313a226465736372697074696f6e223b733a33363a22456e61626c657320736974652d77696465206b6579776f726420736561726368696e672e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a31393a227365617263682e657874656e6465722e696e63223b693a313b733a31313a227365617263682e74657374223b7d733a393a22636f6e666967757265223b733a32383a2261646d696e2f636f6e6669672f7365617263682f73657474696e6773223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a227365617263682e637373223b733a32353a226d6f64756c65732f7365617263682f7365617263682e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/search/tests/search_embedded_form.module', 'search_embedded_form', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32303a2253656172636820656d62656464656420666f726d223b733a31313a226465736372697074696f6e223b733a35393a22537570706f7274206d6f64756c6520666f7220736561726368206d6f64756c652074657374696e67206f6620656d62656464656420666f726d732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/search/tests/search_extra_type.module', 'search_extra_type', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a2254657374207365617263682074797065223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220736561726368206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/search/tests/search_node_tags.module', 'search_node_tags', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a225465737420736561726368206e6f64652074616773223b733a31313a226465736372697074696f6e223b733a34343a22537570706f7274206d6f64756c6520666f72204e6f64652073656172636820746167732074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/shortcut/shortcut.module', 'shortcut', 'module', '', 1, 0, 0, 0, 0x613a31333a7b733a343a226e616d65223b733a383a2253686f7274637574223b733a31313a226465736372697074696f6e223b733a36303a22416c6c6f777320757365727320746f206d616e61676520637573746f6d697a61626c65206c69737473206f662073686f7274637574206c696e6b732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31333a2273686f72746375742e74657374223b7d733a393a22636f6e666967757265223b733a33363a2261646d696e2f636f6e6669672f757365722d696e746572666163652f73686f7274637574223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d);
INSERT INTO `system` (`filename`, `name`, `type`, `owner`, `status`, `bootstrap`, `schema_version`, `weight`, `info`) VALUES
('modules/simpletest/simpletest.module', 'simpletest', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a373a2254657374696e67223b733a31313a226465736372697074696f6e223b733a35333a2250726f76696465732061206672616d65776f726b20666f7220756e697420616e642066756e6374696f6e616c2074657374696e672e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a35303a7b693a303b733a31353a2273696d706c65746573742e74657374223b693a313b733a32343a2264727570616c5f7765625f746573745f636173652e706870223b693a323b733a31383a2274657374732f616374696f6e732e74657374223b693a333b733a31353a2274657374732f616a61782e74657374223b693a343b733a31363a2274657374732f62617463682e74657374223b693a353b733a31353a2274657374732f626f6f742e74657374223b693a363b733a32303a2274657374732f626f6f7473747261702e74657374223b693a373b733a31363a2274657374732f63616368652e74657374223b693a383b733a31373a2274657374732f636f6d6d6f6e2e74657374223b693a393b733a32343a2274657374732f64617461626173655f746573742e74657374223b693a31303b733a32323a2274657374732f656e746974795f637275642e74657374223b693a31313b733a33323a2274657374732f656e746974795f637275645f686f6f6b5f746573742e74657374223b693a31323b733a32333a2274657374732f656e746974795f71756572792e74657374223b693a31333b733a31363a2274657374732f6572726f722e74657374223b693a31343b733a31353a2274657374732f66696c652e74657374223b693a31353b733a32333a2274657374732f66696c657472616e736665722e74657374223b693a31363b733a31353a2274657374732f666f726d2e74657374223b693a31373b733a31363a2274657374732f67726170682e74657374223b693a31383b733a31363a2274657374732f696d6167652e74657374223b693a31393b733a31353a2274657374732f6c6f636b2e74657374223b693a32303b733a31353a2274657374732f6d61696c2e74657374223b693a32313b733a31353a2274657374732f6d656e752e74657374223b693a32323b733a31373a2274657374732f6d6f64756c652e74657374223b693a32333b733a31363a2274657374732f70616765722e74657374223b693a32343b733a31393a2274657374732f70617373776f72642e74657374223b693a32353b733a31353a2274657374732f706174682e74657374223b693a32363b733a31393a2274657374732f72656769737472792e74657374223b693a32373b733a31373a2274657374732f736368656d612e74657374223b693a32383b733a31383a2274657374732f73657373696f6e2e74657374223b693a32393b733a32303a2274657374732f7461626c65736f72742e74657374223b693a33303b733a31363a2274657374732f7468656d652e74657374223b693a33313b733a31383a2274657374732f756e69636f64652e74657374223b693a33323b733a31373a2274657374732f7570646174652e74657374223b693a33333b733a31373a2274657374732f786d6c7270632e74657374223b693a33343b733a32363a2274657374732f757067726164652f757067726164652e74657374223b693a33353b733a33343a2274657374732f757067726164652f757067726164652e636f6d6d656e742e74657374223b693a33363b733a33333a2274657374732f757067726164652f757067726164652e66696c7465722e74657374223b693a33373b733a33323a2274657374732f757067726164652f757067726164652e666f72756d2e74657374223b693a33383b733a33333a2274657374732f757067726164652f757067726164652e6c6f63616c652e74657374223b693a33393b733a33313a2274657374732f757067726164652f757067726164652e6d656e752e74657374223b693a34303b733a33313a2274657374732f757067726164652f757067726164652e6e6f64652e74657374223b693a34313b733a33353a2274657374732f757067726164652f757067726164652e7461786f6e6f6d792e74657374223b693a34323b733a33343a2274657374732f757067726164652f757067726164652e747269676765722e74657374223b693a34333b733a33393a2274657374732f757067726164652f757067726164652e7472616e736c617461626c652e74657374223b693a34343b733a33333a2274657374732f757067726164652f757067726164652e75706c6f61642e74657374223b693a34353b733a33313a2274657374732f757067726164652f757067726164652e757365722e74657374223b693a34363b733a33363a2274657374732f757067726164652f7570646174652e61676772656761746f722e74657374223b693a34373b733a33333a2274657374732f757067726164652f7570646174652e747269676765722e74657374223b693a34383b733a33313a2274657374732f757067726164652f7570646174652e6669656c642e74657374223b693a34393b733a33303a2274657374732f757067726164652f7570646174652e757365722e74657374223b7d733a393a22636f6e666967757265223b733a34313a2261646d696e2f636f6e6669672f646576656c6f706d656e742f74657374696e672f73657474696e6773223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/actions_loop_test.module', 'actions_loop_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a22416374696f6e73206c6f6f702074657374223b733a31313a226465736372697074696f6e223b733a33393a22537570706f7274206d6f64756c6520666f7220616374696f6e206c6f6f702074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/ajax_forms_test.module', 'ajax_forms_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32363a22414a415820666f726d2074657374206d6f636b206d6f64756c65223b733a31313a226465736372697074696f6e223b733a32353a225465737420666f7220414a415820666f726d2063616c6c732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/ajax_test.module', 'ajax_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a393a22414a41582054657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f7220414a4158206672616d65776f726b2074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/batch_test.module', 'batch_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31343a224261746368204150492074657374223b733a31313a226465736372697074696f6e223b733a33353a22537570706f7274206d6f64756c6520666f72204261746368204150492074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/boot_test_1.module', 'boot_test_1', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a224561726c7920626f6f747374726170207465737473223b733a31313a226465736372697074696f6e223b733a33393a224120737570706f7274206d6f64756c6520666f7220686f6f6b5f626f6f742074657374696e672e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/boot_test_2.module', 'boot_test_2', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a224561726c7920626f6f747374726170207465737473223b733a31313a226465736372697074696f6e223b733a34343a224120737570706f7274206d6f64756c6520666f7220686f6f6b5f626f6f7420686f6f6b2074657374696e672e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/common_test.module', 'common_test', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a31313a22436f6d6d6f6e2054657374223b733a31313a226465736372697074696f6e223b733a33323a22537570706f7274206d6f64756c6520666f7220436f6d6d6f6e2074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a31353a22636f6d6d6f6e5f746573742e637373223b733a34303a226d6f64756c65732f73696d706c65746573742f74657374732f636f6d6d6f6e5f746573742e637373223b7d733a353a227072696e74223b613a313a7b733a32313a22636f6d6d6f6e5f746573742e7072696e742e637373223b733a34363a226d6f64756c65732f73696d706c65746573742f74657374732f636f6d6d6f6e5f746573742e7072696e742e637373223b7d7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/common_test_cron_helper.module', 'common_test_cron_helper', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32333a22436f6d6d6f6e20546573742043726f6e2048656c706572223b733a31313a226465736372697074696f6e223b733a35363a2248656c706572206d6f64756c6520666f722043726f6e52756e54657374436173653a3a7465737443726f6e457863657074696f6e7328292e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/database_test.module', 'database_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31333a2244617461626173652054657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f72204461746162617365206c617965722074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/drupal_autoload_test/drupal_autoload_test.module', 'drupal_autoload_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32353a2244727570616c20636f64652072656769737472792074657374223b733a31313a226465736372697074696f6e223b733a34353a22537570706f7274206d6f64756c6520666f722074657374696e672074686520636f64652072656769737472792e223b733a353a2266696c6573223b613a323a7b693a303b733a33343a2264727570616c5f6175746f6c6f61645f746573745f696e746572666163652e696e63223b693a313b733a33303a2264727570616c5f6175746f6c6f61645f746573745f636c6173732e696e63223b7d733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/drupal_system_listing_compatible_test/drupal_system_listing_compatible_test.module', 'drupal_system_listing_compatible_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33373a2244727570616c2073797374656d206c697374696e6720636f6d70617469626c652074657374223b733a31313a226465736372697074696f6e223b733a36323a22537570706f7274206d6f64756c6520666f722074657374696e67207468652064727570616c5f73797374656d5f6c697374696e672066756e6374696f6e2e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/drupal_system_listing_incompatible_test/drupal_system_listing_incompatible_test.module', 'drupal_system_listing_incompatible_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33393a2244727570616c2073797374656d206c697374696e6720696e636f6d70617469626c652074657374223b733a31313a226465736372697074696f6e223b733a36323a22537570706f7274206d6f64756c6520666f722074657374696e67207468652064727570616c5f73797374656d5f6c697374696e672066756e6374696f6e2e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/entity_cache_test.module', 'entity_cache_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a22456e746974792063616368652074657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f722074657374696e6720656e746974792063616368652e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a32383a22656e746974795f63616368655f746573745f646570656e64656e6379223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/entity_cache_test_dependency.module', 'entity_cache_test_dependency', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32383a22456e74697479206361636865207465737420646570656e64656e6379223b733a31313a226465736372697074696f6e223b733a35313a22537570706f727420646570656e64656e6379206d6f64756c6520666f722074657374696e6720656e746974792063616368652e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/entity_crud_hook_test.module', 'entity_crud_hook_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32323a22456e74697479204352554420486f6f6b732054657374223b733a31313a226465736372697074696f6e223b733a33353a22537570706f7274206d6f64756c6520666f72204352554420686f6f6b2074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/entity_query_access_test.module', 'entity_query_access_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32343a22456e74697479207175657279206163636573732074657374223b733a31313a226465736372697074696f6e223b733a34393a22537570706f7274206d6f64756c6520666f7220636865636b696e6720656e7469747920717565727920726573756c74732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/error_test.module', 'error_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a224572726f722074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f72206572726f7220616e6420657863657074696f6e2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/file_test.module', 'file_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a393a2246696c652074657374223b733a31313a226465736372697074696f6e223b733a33393a22537570706f7274206d6f64756c6520666f722066696c652068616e646c696e672074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31363a2266696c655f746573742e6d6f64756c65223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/filter_test.module', 'filter_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31383a2246696c7465722074657374206d6f64756c65223b733a31313a226465736372697074696f6e223b733a33333a2254657374732066696c74657220686f6f6b7320616e642066756e6374696f6e732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/form_test.module', 'form_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a22466f726d4150492054657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f7220466f726d204150492074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/image_test.module', 'image_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a22496d6167652074657374223b733a31313a226465736372697074696f6e223b733a33393a22537570706f7274206d6f64756c6520666f7220696d61676520746f6f6c6b69742074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/menu_test.module', 'menu_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22486f6f6b206d656e75207465737473223b733a31313a226465736372697074696f6e223b733a33373a22537570706f7274206d6f64756c6520666f72206d656e7520686f6f6b2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/module_test.module', 'module_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a224d6f64756c652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f72206d6f64756c652073797374656d2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/path_test.module', 'path_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22486f6f6b2070617468207465737473223b733a31313a226465736372697074696f6e223b733a33373a22537570706f7274206d6f64756c6520666f72207061746820686f6f6b2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/psr_0_test/psr_0_test.module', 'psr_0_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a225053522d302054657374206361736573223b733a31313a226465736372697074696f6e223b733a34343a225465737420636c617373657320746f20626520646973636f76657265642062792073696d706c65746573742e223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/psr_4_test/psr_4_test.module', 'psr_4_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a225053522d342054657374206361736573223b733a31313a226465736372697074696f6e223b733a34343a225465737420636c617373657320746f20626520646973636f76657265642062792073696d706c65746573742e223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/requirements1_test.module', 'requirements1_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31393a22526571756972656d656e747320312054657374223b733a31313a226465736372697074696f6e223b733a38303a22546573747320746861742061206d6f64756c65206973206e6f7420696e7374616c6c6564207768656e206974206661696c7320686f6f6b5f726571756972656d656e74732827696e7374616c6c27292e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/requirements2_test.module', 'requirements2_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31393a22526571756972656d656e747320322054657374223b733a31313a226465736372697074696f6e223b733a39383a22546573747320746861742061206d6f64756c65206973206e6f7420696e7374616c6c6564207768656e20746865206f6e6520697420646570656e6473206f6e206661696c7320686f6f6b5f726571756972656d656e74732827696e7374616c6c292e223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a31383a22726571756972656d656e7473315f74657374223b693a313b733a373a22636f6d6d656e74223b7d733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/session_test.module', 'session_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a2253657373696f6e2074657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f722073657373696f6e20646174612074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_dependencies_test.module', 'system_dependencies_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32323a2253797374656d20646570656e64656e63792074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31393a225f6d697373696e675f646570656e64656e6379223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_incompatible_core_version_dependencies_test.module', 'system_incompatible_core_version_dependencies_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a35303a2253797374656d20696e636f6d70617469626c6520636f72652076657273696f6e20646570656e64656e636965732074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a33373a2273797374656d5f696e636f6d70617469626c655f636f72655f76657273696f6e5f74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_incompatible_core_version_test.module', 'system_incompatible_core_version_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33373a2253797374656d20696e636f6d70617469626c6520636f72652076657273696f6e2074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22352e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_incompatible_module_version_dependencies_test.module', 'system_incompatible_module_version_dependencies_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a35323a2253797374656d20696e636f6d70617469626c65206d6f64756c652076657273696f6e20646570656e64656e636965732074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a34363a2273797374656d5f696e636f6d70617469626c655f6d6f64756c655f76657273696f6e5f7465737420283e322e3029223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_incompatible_module_version_test.module', 'system_incompatible_module_version_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33393a2253797374656d20696e636f6d70617469626c65206d6f64756c652076657273696f6e2074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_project_namespace_test.module', 'system_project_namespace_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32393a2253797374656d2070726f6a656374206e616d6573706163652074657374223b733a31313a226465736372697074696f6e223b733a35383a22537570706f7274206d6f64756c6520666f722074657374696e672070726f6a656374206e616d65737061636520646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31333a2264727570616c3a66696c746572223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_test.module', 'system_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a2253797374656d2074657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f722073797374656d2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31383a2273797374656d5f746573742e6d6f64756c65223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/taxonomy_test.module', 'taxonomy_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32303a225461786f6e6f6d792074657374206d6f64756c65223b733a31313a226465736372697074696f6e223b733a34353a222254657374732066756e6374696f6e7320616e6420686f6f6b73206e6f74207573656420696e20636f7265222e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a383a227461786f6e6f6d79223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/theme_test.module', 'theme_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a225468656d652074657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f72207468656d652073797374656d2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/update_script_test.module', 'update_script_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31383a22557064617465207363726970742074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465207363726970742074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/update_test_1.module', 'update_test_1', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a225570646174652074657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f72207570646174652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/update_test_2.module', 'update_test_2', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a225570646174652074657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f72207570646174652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/update_test_3.module', 'update_test_3', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a225570646174652074657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f72207570646174652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/url_alter_test.module', 'url_alter_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a2255726c5f616c746572207465737473223b733a31313a226465736372697074696f6e223b733a34353a224120737570706f7274206d6f64756c657320666f722075726c5f616c74657220686f6f6b2074657374696e672e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/xmlrpc_test.module', 'xmlrpc_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a22584d4c2d5250432054657374223b733a31313a226465736372697074696f6e223b733a37353a22537570706f7274206d6f64756c6520666f7220584d4c2d525043207465737473206163636f7264696e6720746f207468652076616c696461746f72312073706563696669636174696f6e2e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/statistics/statistics.module', 'statistics', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a2253746174697374696373223b733a31313a226465736372697074696f6e223b733a33373a224c6f677320616363657373207374617469737469637320666f7220796f757220736974652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31353a22737461746973746963732e74657374223b7d733a393a22636f6e666967757265223b733a33303a2261646d696e2f636f6e6669672f73797374656d2f73746174697374696373223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/syslog/syslog.module', 'syslog', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a363a225379736c6f67223b733a31313a226465736372697074696f6e223b733a34313a224c6f677320616e64207265636f7264732073797374656d206576656e747320746f207379736c6f672e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a227379736c6f672e74657374223b7d733a393a22636f6e666967757265223b733a33323a2261646d696e2f636f6e6669672f646576656c6f706d656e742f6c6f6767696e67223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/system/system.module', 'system', 'module', '', 1, 0, 7080, 0, 0x613a31343a7b733a343a226e616d65223b733a363a2253797374656d223b733a31313a226465736372697074696f6e223b733a35343a2248616e646c65732067656e6572616c207369746520636f6e66696775726174696f6e20666f722061646d696e6973747261746f72732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a363a7b693a303b733a31393a2273797374656d2e61726368697665722e696e63223b693a313b733a31353a2273797374656d2e6d61696c2e696e63223b693a323b733a31363a2273797374656d2e71756575652e696e63223b693a333b733a31343a2273797374656d2e7461722e696e63223b693a343b733a31383a2273797374656d2e757064617465722e696e63223b693a353b733a31313a2273797374656d2e74657374223b7d733a383a227265717569726564223b623a313b733a393a22636f6e666967757265223b733a31393a2261646d696e2f636f6e6669672f73797374656d223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/system/tests/cron_queue_test.module', 'cron_queue_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a2243726f6e2051756575652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f72207468652063726f6e2071756575652072756e6e65722e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/system/tests/system_cron_test.module', 'system_cron_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a2253797374656d2043726f6e2054657374223b733a31313a226465736372697074696f6e223b733a34353a22537570706f7274206d6f64756c6520666f722074657374696e67207468652073797374656d5f63726f6e28292e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d);
INSERT INTO `system` (`filename`, `name`, `type`, `owner`, `status`, `bootstrap`, `schema_version`, `weight`, `info`) VALUES
('modules/taxonomy/taxonomy.module', 'taxonomy', 'module', '', 1, 0, 7011, 0, 0x613a31353a7b733a343a226e616d65223b733a383a225461786f6e6f6d79223b733a31313a226465736372697074696f6e223b733a33383a22456e61626c6573207468652063617465676f72697a6174696f6e206f6620636f6e74656e742e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a373a226f7074696f6e73223b7d733a353a2266696c6573223b613a323a7b693a303b733a31353a227461786f6e6f6d792e6d6f64756c65223b693a313b733a31333a227461786f6e6f6d792e74657374223b7d733a393a22636f6e666967757265223b733a32343a2261646d696e2f7374727563747572652f7461786f6e6f6d79223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b733a383a227265717569726564223b623a313b733a31313a226578706c616e6174696f6e223b733a37333a224669656c64207479706528732920696e20757365202d20736565203c6120687265663d222f61646d696e2f7265706f7274732f6669656c6473223e4669656c64206c6973743c2f613e223b7d),
('modules/toolbar/toolbar.module', 'toolbar', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a373a22546f6f6c626172223b733a31313a226465736372697074696f6e223b733a39393a2250726f7669646573206120746f6f6c62617220746861742073686f77732074686520746f702d6c6576656c2061646d696e697374726174696f6e206d656e75206974656d7320616e64206c696e6b732066726f6d206f74686572206d6f64756c65732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/tracker/tracker.module', 'tracker', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a373a22547261636b6572223b733a31313a226465736372697074696f6e223b733a34353a22456e61626c657320747261636b696e67206f6620726563656e7420636f6e74656e7420666f722075736572732e223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a373a22636f6d6d656e74223b7d733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31323a22747261636b65722e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/translation/tests/translation_test.module', 'translation_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32343a22436f6e74656e74205472616e736c6174696f6e2054657374223b733a31313a226465736372697074696f6e223b733a34393a22537570706f7274206d6f64756c6520666f722074686520636f6e74656e74207472616e736c6174696f6e2074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/translation/translation.module', 'translation', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31393a22436f6e74656e74207472616e736c6174696f6e223b733a31313a226465736372697074696f6e223b733a35373a22416c6c6f777320636f6e74656e7420746f206265207472616e736c6174656420696e746f20646966666572656e74206c616e6775616765732e223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a226c6f63616c65223b7d733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31363a227472616e736c6174696f6e2e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/trigger/tests/trigger_test.module', 'trigger_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a22547269676765722054657374223b733a31313a226465736372697074696f6e223b733a33333a22537570706f7274206d6f64756c6520666f7220547269676765722074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a343a22372e3433223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/trigger/trigger.module', 'trigger', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a373a2254726967676572223b733a31313a226465736372697074696f6e223b733a39303a22456e61626c657320616374696f6e7320746f206265206669726564206f6e206365727461696e2073797374656d206576656e74732c2073756368206173207768656e206e657720636f6e74656e7420697320637265617465642e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31323a22747269676765722e74657374223b7d733a393a22636f6e666967757265223b733a32333a2261646d696e2f7374727563747572652f74726967676572223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/update/tests/aaa_update_test.module', 'aaa_update_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22414141205570646174652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a343a22372e3433223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/update/tests/bbb_update_test.module', 'bbb_update_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22424242205570646174652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a343a22372e3433223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/update/tests/ccc_update_test.module', 'ccc_update_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22434343205570646174652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a343a22372e3433223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/update/tests/update_test.module', 'update_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a225570646174652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/update/update.module', 'update', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31343a22557064617465206d616e61676572223b733a31313a226465736372697074696f6e223b733a3130343a22436865636b7320666f7220617661696c61626c6520757064617465732c20616e642063616e207365637572656c7920696e7374616c6c206f7220757064617465206d6f64756c657320616e64207468656d65732076696120612077656220696e746572666163652e223b733a373a2276657273696f6e223b733a343a22372e3433223b733a373a227061636b616765223b733a343a22436f7265223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a227570646174652e74657374223b7d733a393a22636f6e666967757265223b733a33303a2261646d696e2f7265706f7274732f757064617465732f73657474696e6773223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/user/tests/user_form_test.module', 'user_form_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32323a2255736572206d6f64756c6520666f726d207465737473223b733a31313a226465736372697074696f6e223b733a33373a22537570706f7274206d6f64756c6520666f72207573657220666f726d2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/user/user.module', 'user', 'module', '', 1, 0, 7018, 0, 0x613a31353a7b733a343a226e616d65223b733a343a2255736572223b733a31313a226465736372697074696f6e223b733a34373a224d616e6167657320746865207573657220726567697374726174696f6e20616e64206c6f67696e2073797374656d2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a31313a22757365722e6d6f64756c65223b693a313b733a393a22757365722e74657374223b7d733a383a227265717569726564223b623a313b733a393a22636f6e666967757265223b733a31393a2261646d696e2f636f6e6669672f70656f706c65223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a383a22757365722e637373223b733a32313a226d6f64756c65732f757365722f757365722e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('profiles/standard/standard.profile', 'standard', 'module', '', 1, 0, 0, 1000, 0x613a31353a7b733a343a226e616d65223b733a383a225374616e64617264223b733a31313a226465736372697074696f6e223b733a35313a22496e7374616c6c207769746820636f6d6d6f6e6c792075736564206665617475726573207072652d636f6e666967757265642e223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a32313a7b693a303b733a353a22626c6f636b223b693a313b733a353a22636f6c6f72223b693a323b733a373a22636f6d6d656e74223b693a333b733a31303a22636f6e7465787475616c223b693a343b733a393a2264617368626f617264223b693a353b733a343a2268656c70223b693a363b733a353a22696d616765223b693a373b733a343a226c697374223b693a383b733a343a226d656e75223b693a393b733a363a226e756d626572223b693a31303b733a373a226f7074696f6e73223b693a31313b733a343a2270617468223b693a31323b733a383a227461786f6e6f6d79223b693a31333b733a353a2264626c6f67223b693a31343b733a363a22736561726368223b693a31353b733a383a2273686f7274637574223b693a31363b733a373a22746f6f6c626172223b693a31373b733a373a226f7665726c6179223b693a31383b733a383a226669656c645f7569223b693a31393b733a343a2266696c65223b693a32303b733a333a22726466223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a353a226d74696d65223b693a313435383138373933383b733a373a227061636b616765223b733a353a224f74686572223b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b733a363a2268696464656e223b623a313b733a383a227265717569726564223b623a313b733a31373a22646973747269627574696f6e5f6e616d65223b733a363a2244727570616c223b7d),
('sites/all/modules/autoLoad/Core.module', 'Core', 'module', '', 1, 0, 0, 0, 0x613a31313a7b733a343a226e616d65223b733a343a22436f7265223b733a31313a226465736372697074696f6e223b733a31373a22446576656c6f706572206279207465616d223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a333a22444556223b733a373a2276657273696f6e223b733a373a22372e782d312e31223b733a393a22646174657374616d70223b733a31303a2231323236333437383237223b733a353a226d74696d65223b693a313436313633383330343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/autoLoad/HSSCore/HSSCore.module', 'HSSCore', 'module', '', 1, 0, 0, 0, 0x613a31313a7b733a343a226e616d65223b733a31353a2248535320436f7265206d6f64756c65223b733a31313a226465736372697074696f6e223b733a31363a22446576656c6f70657220627920485353223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31313a22485353206d6f64756c6573223b733a373a2276657273696f6e223b733a373a22372e782d312e31223b733a393a22646174657374616d70223b733a31303a2231323236333437383237223b733a353a226d74696d65223b693a313435383138373933383b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/backend/Admin.module', 'Admin', 'module', '', 1, 0, 0, 0, 0x613a31313a7b733a343a226e616d65223b733a353a2241646d696e223b733a31313a226465736372697074696f6e223b733a31373a22446576656c6f706572206279207465616d223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a343a22436f7265223b7d733a373a227061636b616765223b733a333a22444556223b733a373a2276657273696f6e223b733a373a22372e782d312e31223b733a393a22646174657374616d70223b733a31303a2231323236333437383237223b733a353a226d74696d65223b693a313436313634323139313b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/backend/HSSAdmin/HSSAdmin.module', 'HSSAdmin', 'module', '', 1, 0, 0, 0, 0x613a31313a7b733a343a226e616d65223b733a353a2241646d696e223b733a31313a226465736372697074696f6e223b733a31373a22446576656c6f706572206279207465616d223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a343a22436f7265223b7d733a373a227061636b616765223b733a333a22444556223b733a373a2276657273696f6e223b733a373a22372e782d312e31223b733a393a22646174657374616d70223b733a31303a2231323236333437383237223b733a353a226d74696d65223b693a313435383138393434363b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/frontend/Site.module', 'Site', 'module', '', 1, 0, 0, 0, 0x613a31313a7b733a343a226e616d65223b733a343a2253697465223b733a31313a226465736372697074696f6e223b733a31373a22446576656c6f706572206279207465616d223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a333a22444556223b733a373a2276657273696f6e223b733a373a22372e782d312e31223b733a393a22646174657374616d70223b733a31303a2231323236333437383237223b733a353a226d74696d65223b693a313436313634363133393b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/shop/Shop.module', 'Shop', 'module', '', 1, 0, 0, 0, 0x613a31313a7b733a343a226e616d65223b733a343a2253686f70223b733a31313a226465736372697074696f6e223b733a31373a22446576656c6f706572206279207465616d223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a333a22444556223b733a373a2276657273696f6e223b733a373a22372e782d312e31223b733a393a22646174657374616d70223b733a31303a2231323236333437383237223b733a353a226d74696d65223b693a313436313634363134333b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/themes/theme_default/theme_default.info', 'theme_default', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 1, 0, -1, 0, 0x613a31373a7b733a343a226e616d65223b733a31333a2264656661756c74207468656d65223b733a31313a226465736372697074696f6e223b733a31333a2264656661756c74207468656d65223b733a343a22636f7265223b733a333a22372e78223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a2276657273696f6e223b733a333a22372e78223b733a373a2270726f6a656374223b733a31333a2264656661756c74207468656d65223b733a393a22646174657374616d70223b733a31303a2231333332353137383436223b733a373a22726567696f6e73223b613a383a7b733a363a22686561646572223b733a363a22486561646572223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a226c656674223b733a343a224c656674223b733a353a227269676874223b733a353a225269676874223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31333a226373732f7374796c652e637373223b733a34343a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f6373732f7374796c652e637373223b7d7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a34353a2273697465732f616c6c2f7468656d65732f7468656d655f64656661756c742f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383732393333323b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d),
('themes/bartik/bartik.info', 'bartik', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 1, 0, -1, 0, 0x613a31393a7b733a343a226e616d65223b733a363a2242617274696b223b733a31313a226465736372697074696f6e223b733a34383a224120666c657869626c652c207265636f6c6f7261626c65207468656d652077697468206d616e7920726567696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a373a22726567696f6e73223b613a32303a7b733a363a22686561646572223b733a363a22486561646572223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a383a226665617475726564223b733a383a224665617475726564223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a31333a22736964656261725f6669727374223b733a31333a2253696465626172206669727374223b733a31343a22736964656261725f7365636f6e64223b733a31343a2253696465626172207365636f6e64223b733a31343a2274726970747963685f6669727374223b733a31343a225472697074796368206669727374223b733a31353a2274726970747963685f6d6964646c65223b733a31353a225472697074796368206d6964646c65223b733a31333a2274726970747963685f6c617374223b733a31333a225472697074796368206c617374223b733a31383a22666f6f7465725f6669727374636f6c756d6e223b733a31393a22466f6f74657220666972737420636f6c756d6e223b733a31393a22666f6f7465725f7365636f6e64636f6c756d6e223b733a32303a22466f6f746572207365636f6e6420636f6c756d6e223b733a31383a22666f6f7465725f7468697264636f6c756d6e223b733a31393a22466f6f74657220746869726420636f6c756d6e223b733a31393a22666f6f7465725f666f75727468636f6c756d6e223b733a32303a22466f6f74657220666f7572746820636f6c756d6e223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2230223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32383a227468656d65732f62617274696b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373933383b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d),
('themes/garland/garland.info', 'garland', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 0, 0, -1, 0, 0x613a31393a7b733a343a226e616d65223b733a373a224761726c616e64223b733a31313a226465736372697074696f6e223b733a3131313a2241206d756c74692d636f6c756d6e207468656d652077686963682063616e20626520636f6e6669677572656420746f206d6f6469667920636f6c6f727320616e6420737769746368206265747765656e20666978656420616e6420666c756964207769647468206c61796f7574732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a31333a226761726c616e645f7769647468223b733a353a22666c756964223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32393a227468656d65732f6761726c616e642f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373933383b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d),
('themes/seven/seven.info', 'seven', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 1, 0, -1, 0, 0x613a31393a7b733a343a226e616d65223b733a353a22536576656e223b733a31313a226465736372697074696f6e223b733a36353a22412073696d706c65206f6e652d636f6c756d6e2c207461626c656c6573732c20666c7569642077696474682061646d696e697374726174696f6e207468656d652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2231223b7d733a373a22726567696f6e73223b613a383a7b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31333a22736964656261725f6669727374223b733a31333a2246697273742073696465626172223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a31343a22726567696f6e735f68696464656e223b613a333a7b693a303b733a31333a22736964656261725f6669727374223b693a313b733a383a22706167655f746f70223b693a323b733a31313a22706167655f626f74746f6d223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f736576656e2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373934303b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d),
('themes/stark/stark.info', 'stark', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 0, 0, -1, 0, 0x613a31383a7b733a343a226e616d65223b733a353a22537461726b223b733a31313a226465736372697074696f6e223b733a3230383a2254686973207468656d652064656d6f6e737472617465732044727570616c27732064656661756c742048544d4c206d61726b757020616e6420435353207374796c65732e20546f206c6561726e20686f7720746f206275696c6420796f7572206f776e207468656d6520616e64206f766572726964652044727570616c27732064656661756c7420636f64652c2073656520746865203c6120687265663d22687474703a2f2f64727570616c2e6f72672f7468656d652d6775696465223e5468656d696e672047756964653c2f613e2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3433223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231343536333433353036223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a31323a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31343a2264617368626f6172645f6d61696e223b733a31363a2244617368626f61726420286d61696e29223b733a31373a2264617368626f6172645f73696465626172223b733a31393a2244617368626f61726420287369646562617229223b733a31383a2264617368626f6172645f696e616374697665223b733a32303a2244617368626f6172642028696e61637469766529223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f737461726b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313435383138373934303b733a31353a226f7665726c61795f726567696f6e73223b613a333a7b693a303b733a31343a2264617368626f6172645f6d61696e223b693a313b733a31373a2264617368626f6172645f73696465626172223b693a323b733a31383a2264617368626f6172645f696e616374697665223b7d733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d);

-- --------------------------------------------------------

--
-- Table structure for table `taxonomy_index`
--

CREATE TABLE IF NOT EXISTS `taxonomy_index` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  KEY `term_node` (`tid`,`sticky`,`created`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';

-- --------------------------------------------------------

--
-- Table structure for table `taxonomy_term_data`
--

CREATE TABLE IF NOT EXISTS `taxonomy_term_data` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores term information.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `taxonomy_term_hierarchy`
--

CREATE TABLE IF NOT EXISTS `taxonomy_term_hierarchy` (
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.',
  PRIMARY KEY (`tid`,`parent`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';

-- --------------------------------------------------------

--
-- Table structure for table `taxonomy_vocabulary`
--

CREATE TABLE IF NOT EXISTS `taxonomy_vocabulary` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `taxonomy_vocabulary`
--

INSERT INTO `taxonomy_vocabulary` (`vid`, `name`, `machine_name`, `description`, `hierarchy`, `module`, `weight`) VALUES
(1, 'Tags', 'tags', 'Use tags to group articles on similar topics into categories.', 0, 'taxonomy', 0);

-- --------------------------------------------------------

--
-- Table structure for table `url_alias`
--

CREATE TABLE IF NOT EXISTS `url_alias` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
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

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uid`, `name`, `pass`, `mail`, `theme`, `signature`, `signature_format`, `created`, `access`, `login`, `status`, `timezone`, `language`, `picture`, `init`, `data`) VALUES
(0, '', '', '', '', '', NULL, 0, 0, 0, 0, NULL, '', 0, '', NULL),
(1, 'admin', '$S$DblqiZ8G3j2KqgWe0jMGknBDo99L3UOoR3o964Rju.fHU78GqRU5', 'nguyenduypt86@gmail.com', '', '', 'filtered_html', 1458142935, 1461656259, 1461641552, 1, 'Asia/Ho_Chi_Minh', '', 0, 'nguyenduypt86@gmail.com', 0x623a303b),
(2, 'manager', '$S$D1Rva.ik7jWbtvTlhtfbZ5qwVgFW9WpN5QNh3cFNbVi7qG6aFw6n', 'pt.soleil@gmail.com', '', '', 'filtered_html', 1458146407, 1461398571, 1461398352, 1, 'Asia/Ho_Chi_Minh', '', 0, 'pt.soleil@gmail.com', 0x623a303b),
(3, 'tthgiang0206', '$S$Dhb3at.88YoWFNlxeT.SE/9DST.e3rTud2ovCcSxrdMQA82WDISo', 'systemrv1@gmail.com', '', '', 'filtered_html', 1461294299, 1461381948, 1461377687, 1, 'Asia/Ho_Chi_Minh', '', 0, 'systemrv1@gmail.com', 0x623a303b);

-- --------------------------------------------------------

--
-- Table structure for table `users_roles`
--

CREATE TABLE IF NOT EXISTS `users_roles` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: role.rid for role.',
  PRIMARY KEY (`uid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';

--
-- Dumping data for table `users_roles`
--

INSERT INTO `users_roles` (`uid`, `rid`) VALUES
(1, 3),
(2, 4),
(3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `variable`
--

CREATE TABLE IF NOT EXISTS `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';

--
-- Dumping data for table `variable`
--

INSERT INTO `variable` (`name`, `value`) VALUES
('admin_theme', 0x733a353a22736576656e223b),
('clean_url', 0x733a313a2231223b),
('comment_page', 0x693a303b),
('cron_key', 0x733a34333a226c4c66375f5a3962513061305a7171356e4e7351354e5558594f366c34533477515279507a7062734a356f223b),
('cron_last', 0x693a313436313635323731333b),
('css_js_query_string', 0x733a363a226f3638356c75223b),
('date_default_timezone', 0x733a31363a22417369612f486f5f4368695f4d696e68223b),
('default_nodes_main', 0x733a323a223130223b),
('drupal_http_request_fails', 0x623a303b),
('drupal_private_key', 0x733a34333a22715877333152676446674c564f7662786e4f634877326a5a50446c6449682d4e724e6e5f566d70366d3351223b),
('file_temporary_path', 0x733a31323a22443a5c78616d70705c746d70223b),
('filter_fallback_format', 0x733a31303a22706c61696e5f74657874223b),
('install_profile', 0x733a383a227374616e64617264223b),
('install_task', 0x733a343a22646f6e65223b),
('install_time', 0x693a313435383134333332313b),
('menu_expanded', 0x613a303a7b7d),
('menu_masks', 0x613a33353a7b693a303b693a3530313b693a313b693a3439333b693a323b693a3235303b693a333b693a3234373b693a343b693a3234363b693a353b693a3234353b693a363b693a3132353b693a373b693a3132333b693a383b693a3132323b693a393b693a3132313b693a31303b693a3131373b693a31313b693a36333b693a31323b693a36323b693a31333b693a36313b693a31343b693a36303b693a31353b693a35393b693a31363b693a35383b693a31373b693a34343b693a31383b693a33313b693a31393b693a33303b693a32303b693a32393b693a32313b693a32383b693a32323b693a32343b693a32333b693a32313b693a32343b693a31353b693a32353b693a31343b693a32363b693a31333b693a32373b693a31313b693a32383b693a373b693a32393b693a363b693a33303b693a353b693a33313b693a343b693a33323b693a333b693a33333b693a323b693a33343b693a313b7d),
('node_admin_theme', 0x733a313a2231223b),
('node_options_page', 0x613a313a7b693a303b733a363a22737461747573223b7d),
('node_submitted_page', 0x623a303b),
('path_alias_whitelist', 0x613a303a7b7d),
('site_403', 0x733a383a22706167652d343033223b),
('site_404', 0x733a383a22706167652d343034223b),
('site_default_country', 0x733a323a22564e223b),
('site_frontpage', 0x733a393a227472616e672d636875223b),
('site_mail', 0x733a32333a226e677579656e6475797074383640676d61696c2e636f6d223b),
('site_name', 0x733a31303a224769616e2048c3a06e67223b),
('site_slogan', 0x733a303a22223b),
('theme_default', 0x733a31333a227468656d655f64656661756c74223b),
('user_admin_role', 0x733a313a2233223b),
('user_pictures', 0x733a313a2231223b),
('user_picture_dimensions', 0x733a393a22313032347831303234223b),
('user_picture_file_size', 0x733a333a22383030223b),
('user_picture_style', 0x733a393a227468756d626e61696c223b),
('user_register', 0x693a323b);

-- --------------------------------------------------------

--
-- Table structure for table `watchdog`
--

CREATE TABLE IF NOT EXISTS `watchdog` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `web_banner`
--

CREATE TABLE IF NOT EXISTS `web_banner` (
  `banner_id` int(11) NOT NULL AUTO_INCREMENT,
  `banner_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `banner_image` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `banner_image_temp` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Lưu image lỗi để sau xóa',
  `banner_link` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `banner_order` tinyint(5) DEFAULT '1' COMMENT 'thứ tự hiển thị',
  `banner_is_target` tinyint(5) DEFAULT '0' COMMENT '0: Không mở tab mới, 1: mở tab mới',
  `banner_type` tinyint(5) DEFAULT '0' COMMENT '1:banner home to, 2: banner home nhỏ,3: banner trái, 4 banner phải',
  `banner_page` tinyint(5) DEFAULT '0' COMMENT '1: trang chủ, 2: trang list,3: trang detail, 4: trang list danh mục',
  `banner_category_id` int(11) DEFAULT '0',
  `banner_status` tinyint(5) DEFAULT '0',
  `banner_is_run_time` tinyint(5) DEFAULT '0' COMMENT '0: không có time chay,1: có thời gian chạy quảng cáo',
  `banner_start_time` int(11) DEFAULT '0',
  `banner_end_time` int(11) DEFAULT '0',
  `banner_is_shop` tinyint(5) DEFAULT '0' COMMENT '0: Không phải banner shop,1: quảng cáo banner của shop',
  `banner_shop_id` int(11) DEFAULT '0',
  `banner_create_time` int(11) DEFAULT '0',
  `banner_update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`banner_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `web_banner`
--

INSERT INTO `web_banner` (`banner_id`, `banner_name`, `banner_image`, `banner_image_temp`, `banner_link`, `banner_order`, `banner_is_target`, `banner_type`, `banner_page`, `banner_category_id`, `banner_status`, `banner_is_run_time`, `banner_start_time`, `banner_end_time`, `banner_is_shop`, `banner_shop_id`, `banner_create_time`, `banner_update_time`) VALUES
(1, 'Quảng cáo slider trang chủ 1', '02-13-16-20-04-2016-1.jpg', 'a:3:{i:0;s:25:"02-06-33-20-04-2016-1.jpg";i:1;s:25:"02-13-05-20-04-2016-2.jpg";i:2;s:25:"02-13-16-20-04-2016-1.jpg";}', 'http://sieuthigiare.vn', 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1461135993, 1461136403),
(3, 'Quảng cáo slider trang chủ 2', '02-11-43-20-04-2016-2.jpg', 'a:1:{i:0;s:25:"02-11-43-20-04-2016-2.jpg";}', 'http://sieuthigiare.vn', 2, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1461136303, 1461137605),
(4, 'Quảng cáo ảnh nhỏ trang chủ 1', '02-54-32-20-04-2016-hn-home.jpg', 'a:1:{i:0;s:31:"02-54-32-20-04-2016-hn-home.jpg";}', 'http://sieuthigiare.vn', 1, 0, 2, 1, 0, 1, 0, 0, 0, 0, 0, 1461138872, 1461138888),
(5, 'Quảng cáo ảnh nhỏ trang chủ 2', '02-55-27-20-04-2016-home-hn2.jpg', 'a:1:{i:0;s:32:"02-55-27-20-04-2016-home-hn2.jpg";}', 'http://sieuthigiare.vn', 2, 0, 2, 1, 0, 1, 0, 0, 0, 0, 0, 1461138927, 1461138937),
(6, 'Quảng cáo danh mục điện tử công nghệ', '12-39-49-24-04-2016-dienthoaicu1.jpg', 'a:2:{i:0;s:30:"03-12-03-20-04-2016-banner.jpg";i:1;s:36:"12-39-49-24-04-2016-dienthoaicu1.jpg";}', 'http://sieuthigiare.vn', 1, 0, 1, 1, 43, 1, 0, 0, 0, 0, 0, 1461139923, 1461476395),
(7, 'Quảng cáo cho danh mục mỹ phẩm', '02-07-37-22-04-2016-bi-quyet-lam-trang-da-cap-toc-bang-my-pham.jpg', 'a:1:{i:0;s:66:"02-07-37-22-04-2016-bi-quyet-lam-trang-da-cap-toc-bang-my-pham.jpg";}', 'http://dev.sanphamredep.com', 1, 0, 1, 1, 164, 1, 0, 0, 0, 0, 0, 1461308857, 1461308863);

-- --------------------------------------------------------

--
-- Table structure for table `web_category`
--

CREATE TABLE IF NOT EXISTS `web_category` (
  `category_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category_parent_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `category_content_front` tinyint(2) DEFAULT '0',
  `category_status` tinyint(1) NOT NULL DEFAULT '0',
  `category_image_background` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_icons` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_order` tinyint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`),
  KEY `status` (`category_status`) USING BTREE,
  KEY `id_parrent` (`category_parent_id`,`category_status`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT AUTO_INCREMENT=177 ;

--
-- Dumping data for table `web_category`
--

INSERT INTO `web_category` (`category_id`, `category_name`, `category_parent_id`, `category_content_front`, `category_status`, `category_image_background`, `category_icons`, `category_order`) VALUES
(1, 'Thời trang áo tắm', 24, 0, 0, NULL, NULL, 0),
(2, 'Váy dài', 24, 0, 0, NULL, NULL, 0),
(3, 'Áo', 24, 0, 0, NULL, NULL, 0),
(4, 'Du lịch', 0, 0, 0, NULL, NULL, 0),
(5, 'Phụ kiện công nghệ', 43, 0, 1, NULL, NULL, 0),
(6, 'Phòng khách sạn', 4, 0, 1, NULL, NULL, 0),
(7, 'Ẩm thực, Spa, Giải trí', 0, 1, 1, NULL, NULL, 0),
(8, 'Ô tô', 7, 0, 0, NULL, NULL, 0),
(9, 'Nhà hàng', 7, 0, 1, NULL, NULL, 0),
(10, 'Váy ngắn', 24, 0, 0, NULL, NULL, 0),
(11, 'Chân váy', 24, 0, 0, NULL, NULL, 0),
(13, 'Resort&amp;Nghỉ dưỡng', 4, 0, 1, NULL, NULL, 0),
(14, 'Khám phá', 4, 0, 1, NULL, NULL, 0),
(15, 'Ăn vặt&amp;Cafe', 7, 0, 0, NULL, NULL, 0),
(16, 'Ẩm thực', 7, 0, 1, NULL, NULL, 0),
(17, 'Quần áo&amp;Phụ kiện trẻ em', 24, 0, 0, NULL, NULL, 0),
(19, 'Quần áo&amp;Phụ kiện nam', 24, 0, 0, NULL, NULL, 0),
(23, 'Mỹ phẩm&amp;Làm đẹp', 24, 0, 0, NULL, NULL, 0),
(24, 'Thời trang &amp; Phụ kiện', 0, 0, 0, NULL, NULL, 0),
(25, 'Tham quan', 4, 0, 1, NULL, NULL, 0),
(26, 'test danhmuc', 21, 0, 0, NULL, NULL, 0),
(27, 'Đồ điện gia dụng', 86, 0, 1, NULL, NULL, 0),
(28, 'Channel', 27, 0, 0, NULL, NULL, 0),
(29, 'Phụ kiện', 24, 0, 0, NULL, NULL, 0),
(30, 'Maybeline', 27, 0, 0, NULL, NULL, 0),
(32, 'Thời trang nữ', 24, 0, 0, NULL, NULL, 0),
(33, 'Đồ dùng tiện ích', 27, 0, 0, NULL, NULL, 0),
(41, 'Mẹ và bé', 0, 0, 1, NULL, NULL, 0),
(42, 'Điện máy', 0, 0, 0, NULL, NULL, 0),
(43, 'Điện tử công nghệ', 0, 1, 1, NULL, NULL, 0),
(44, 'Điện thoại', 43, 0, 1, NULL, NULL, 0),
(45, 'Xe cộ', 0, 0, 0, NULL, NULL, 0),
(50, 'Điện lạnh', 86, 0, 1, NULL, NULL, 0),
(53, 'Thời trang trẻ em', 41, 0, 1, NULL, NULL, 0),
(56, 'Đồ chơi - Đồ dùng', 41, 0, 1, NULL, NULL, 0),
(59, 'Xe đạp', 45, 0, 1, NULL, NULL, 0),
(65, 'Trang điểm - Làm tóc', 0, 0, 0, NULL, NULL, 0),
(66, 'Mỹ phẩm', 7, 0, 0, NULL, NULL, 0),
(69, 'Spa &amp; Làm đẹp', 7, 0, 0, NULL, NULL, 0),
(72, 'Spa - Masage', 0, 0, 0, NULL, NULL, 0),
(75, 'Trang điểm - Chăm sóc tóc', 69, 0, 0, NULL, NULL, 0),
(78, 'Chăm sóc sức khỏe', 69, 0, 0, NULL, NULL, 0),
(81, 'Tivi, Video &amp; Âm thanh', 43, 0, 0, NULL, NULL, 0),
(83, 'Phòng ngủ - Phòng tắm', 0, 0, 0, NULL, NULL, 0),
(86, 'Gia dụng &amp; Nội thất', 0, 0, 1, NULL, NULL, 0),
(89, 'Nội thất phòng tắm', 86, 0, 1, NULL, NULL, 0),
(90, 'Thực phẩm', 0, 0, 0, NULL, NULL, 0),
(91, 'Thực phẩm bổ dưỡng', 90, 0, 1, NULL, NULL, 0),
(92, 'Vật dụng nhà bếp', 86, 0, 1, NULL, NULL, 0),
(93, 'Sữa - Đồ ngọt', 90, 0, 1, NULL, NULL, 0),
(94, 'Thực phẩm gia đình', 90, 0, 1, NULL, NULL, 0),
(95, 'Thực phẩm chức năng', 90, 0, 1, NULL, NULL, 0),
(97, 'Thời trang', 0, 0, 1, NULL, NULL, 0),
(98, 'Áo sơmi nam', 97, 0, 1, NULL, NULL, 0),
(99, 'Áo khoác, Vest nam', 97, 0, 1, NULL, NULL, 0),
(102, 'Quần và Áo phông nam', 97, 0, 1, NULL, NULL, 0),
(103, 'Đồ lót, Đồ bơi nam', 97, 0, 1, NULL, NULL, 0),
(104, 'Đồ thể thao nam', 97, 0, 1, NULL, NULL, 0),
(105, 'Thời trang bầu', 41, 0, 1, NULL, NULL, 0),
(106, 'Đầm, chân váy', 97, 0, 1, NULL, NULL, 0),
(107, 'Áo sơ mi nữ', 97, 0, 1, NULL, NULL, 0),
(108, 'Áo Khoác và Vest', 97, 0, 1, NULL, NULL, 0),
(110, 'Đồ lót, đồ bơi nữ', 97, 0, 1, NULL, NULL, 0),
(111, 'Đồ thể thao, mặc nhà', 97, 0, 1, NULL, NULL, 0),
(113, 'Quần & chân váy nữ', 97, 0, 1, NULL, NULL, 0),
(115, 'Phụ kiện Nữ', 97, 0, 1, NULL, NULL, 0),
(116, 'Túi, Ví', 115, 0, 0, NULL, NULL, 0),
(117, 'Trang sức', 115, 0, 0, NULL, NULL, 0),
(118, 'Khác', 115, 0, 0, NULL, NULL, 0),
(119, 'Phụ kiện Nam', 97, 0, 1, NULL, NULL, 0),
(120, 'Túi, Ví nam', 119, 0, 0, NULL, NULL, 0),
(121, 'Thắt lưng', 119, 0, 0, NULL, NULL, 0),
(122, 'Giày dép Nữ', 97, 0, 1, NULL, NULL, 0),
(123, 'Giày cao gót', 122, 0, 0, NULL, NULL, 0),
(124, 'Giày đế bằng', 122, 0, 0, NULL, NULL, 0),
(125, 'Boots nam', 122, 0, 0, NULL, NULL, 0),
(126, 'Sandals', 122, 0, 0, NULL, NULL, 0),
(127, 'Giày dép Nam', 97, 0, 1, NULL, NULL, 0),
(128, 'Giày Âu', 127, 0, 0, NULL, NULL, 0),
(129, 'Giày lười', 127, 0, 0, NULL, NULL, 0),
(130, 'Boots', 127, 0, 0, NULL, NULL, 0),
(131, 'Giày thể thao', 127, 0, 0, NULL, NULL, 0),
(132, 'Giày buộc dây, Sneaker', 127, 0, 0, NULL, NULL, 0),
(133, 'Thời trang trẻ em', 0, 0, 0, NULL, NULL, 0),
(134, 'Thời trang bé trai', 133, 0, 0, NULL, NULL, 0),
(135, 'Thời trang bé gái', 133, 0, 0, NULL, NULL, 0),
(136, 'Phụ kiện bé trai', 133, 0, 0, NULL, NULL, 0),
(137, 'Phụ kiện bé gái', 133, 0, 0, NULL, NULL, 0),
(138, 'Giày dép bé trai', 133, 0, 0, NULL, NULL, 0),
(139, 'Giày dép bé gái', 0, 0, 0, NULL, NULL, 0),
(140, 'Máy tính, laptop', 43, 0, 1, NULL, NULL, 0),
(141, 'Máy tính bảng', 43, 0, 1, NULL, NULL, 0),
(143, 'Máy in', 43, 0, 1, NULL, NULL, 0),
(144, 'Màn hình', 43, 0, 1, NULL, NULL, 0),
(145, 'Máy ảnh - Máy quay', 43, 0, 1, NULL, NULL, 0),
(146, 'Mỹ phẩm nam', 96, 0, 0, NULL, NULL, 0),
(147, 'Thiết bị an ninh', 43, 0, 1, NULL, NULL, 0),
(148, 'Tivi - Âm thanh - Thiết bị Số', 43, 0, 1, NULL, NULL, 0),
(150, 'Ô tô', 45, 0, 1, NULL, NULL, 0),
(151, 'Xe máy', 45, 0, 1, NULL, NULL, 0),
(152, 'Dụng cụ nhà bếp', 86, 0, 0, NULL, NULL, 0),
(153, 'Dụng cụ nhà bếp', 86, 0, 0, NULL, NULL, 0),
(154, 'Đồ điện gia dụng', 86, 0, 0, NULL, NULL, 0),
(155, 'Sản phẩm tiện ích', 86, 0, 1, NULL, NULL, 0),
(156, 'Nội thất phòng ngủ', 86, 0, 0, NULL, NULL, 0),
(157, 'Nội thất và trang trí nhà ở', 86, 0, 1, NULL, NULL, 0),
(158, 'Thể Thao - Dã ngoại', 0, 0, 0, NULL, NULL, 0),
(159, 'Máy tập thể thao các loại', 158, 0, 1, NULL, NULL, 0),
(160, 'Dụng cụ thể thao', 158, 0, 1, NULL, NULL, 0),
(161, 'Đồ dùng dã ngoại', 158, 0, 1, NULL, NULL, 0),
(162, 'Xe đạp thể thao', 158, 0, 1, NULL, NULL, 0),
(163, 'Các loại khác', 158, 0, 1, NULL, NULL, 0),
(164, 'Mỹ phẩm - làm đẹp', 0, 0, 1, NULL, NULL, 0),
(165, 'Trang điểm', 164, 0, 1, NULL, NULL, 0),
(166, 'Chăm sóc cơ thể', 164, 0, 1, NULL, NULL, 0),
(167, 'Chăm sóc tóc', 164, 0, 1, NULL, NULL, 0),
(168, 'Chăm sóc da mặt', 164, 0, 1, NULL, NULL, 0),
(169, 'Quần áo - Phụ kiện thể thao', 158, 0, 1, NULL, NULL, 0),
(170, 'Đồ dùng cho mẹ', 41, 0, 1, NULL, NULL, 0),
(171, 'Thực phẩm và dụng cụ ăn uống', 41, 0, 1, NULL, NULL, 0),
(172, 'Đồ dùng cho bé', 41, 0, 1, NULL, NULL, 0),
(173, 'Xe và các thiết bị an toàn', 41, 0, 1, NULL, NULL, 0),
(174, 'Bé học và chơi', 41, 0, 1, NULL, NULL, 0),
(175, 'Đồ gia dụng tiện ích', 41, 0, 0, NULL, NULL, 0),
(176, 'Thiết bị y tế &amp; Làm đẹp', 164, 0, 1, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `web_comment`
--

CREATE TABLE IF NOT EXISTS `web_comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_parent_id` int(11) DEFAULT '0' COMMENT 'Comment cha, câu hỏi trước',
  `comment_product_id` int(11) DEFAULT NULL,
  `comment_product_name` varchar(255) DEFAULT NULL,
  `comment_shop_id` int(11) DEFAULT NULL COMMENT 'Id shop được bình luận',
  `comment_shop_name` varchar(255) DEFAULT NULL,
  `comment_customer_name` varchar(255) DEFAULT NULL COMMENT 'tên khách comment',
  `comment_content` tinytext COMMENT 'Nội dung conmetn',
  `comment_is_reply` tinyint(5) DEFAULT '0' COMMENT '0: chưa trả lời, 1: đã trả lời',
  `comment_create` int(11) DEFAULT NULL COMMENT 'tg hỏi',
  `comment_reply` int(11) DEFAULT '0' COMMENT 'Thời gian trả lời',
  `comment_status` tinyint(5) DEFAULT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `web_config_info`
--

CREATE TABLE IF NOT EXISTS `web_config_info` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores news content.' AUTO_INCREMENT=11 ;

--
-- Dumping data for table `web_config_info`
--

INSERT INTO `web_config_info` (`id`, `uid`, `title`, `keyword`, `intro`, `content`, `img`, `created`, `status`, `meta_title`, `meta_keywords`, `meta_description`) VALUES
(1, 1, 'Thông tin chân trang bên trái', 'SITE_FOOTER_LEFT', 'Hà Nội:\r\nSố 10 ngách 224/6 đường Hoàng Mai -Hoàng Văn Thụ - Hoàng Mai - Hà Nội\r\nĐT: 0946.721.638 - 0913.922.986\r\nEmail: hotro@sanphamredep.com', '<p>\r\n	<strong>H&agrave; Nội:</strong><br />\r\n	Số 10 ng&aacute;ch 224/6 đường Ho&agrave;ng Mai -Ho&agrave;ng Văn Thụ - Ho&agrave;ng Mai - H&agrave; Nội<br />\r\n	ĐT: 0946.721.638 - 0913.922.986<br />\r\n	Email: hotro@sanphamredep.com</p>', NULL, '1447794727', 1, '', '', ''),
(2, 1, 'Thông tin giới thiệu', 'SITE_INTRO', '', '<p>\r\n	X&atilde; hội ng&agrave;y c&agrave;ng ph&aacute;t triển, cuộc sống ng&agrave;y c&agrave;ng được n&acirc;ng cao, v&agrave; những nhu cầu tiện nghi cho cuộc sống con người cũng v&igrave; thế m&agrave; n&acirc;ng l&ecirc;n, k&egrave;m theo đ&oacute; l&agrave; những th&uacute; vui sưu tầm v&agrave; sở hữu những gi&aacute; trị nghệ thuật ng&agrave;y c&agrave;ng lớn. Phụ kiện thời trang từ xưa đến nay lu&ocirc;n l&agrave; biểu tượng của thời gian. SanPhamReDep.COM l&agrave; nơi cung cấp v&agrave; phục vụ tốt nhất về c&aacute;c loại sản phẩm gi&uacute;p kh&aacute;ch h&agrave;ng trang bị cho m&igrave;nh phụ kiện thời trang ho&agrave;n mỹ nhất.</p>\r\n<p>\r\n	<strong>Mọi th&ocirc;ng tin chi tiết vui l&ograve;ng li&ecirc;n hệ về:</strong></p>\r\n<p>\r\n	Email hợp t&aacute;c: pt.soleil@gmail.com<br />\r\n	Địa chỉ: Số 64/68, Ho&agrave;ng Văn Thụ, Ho&agrave;ng Mai, H&agrave; Nội<br />\r\n	Li&ecirc;n hệ: 0913.922.986(Mr.Anh)</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>\r\n<p>\r\n	&nbsp;</p>', NULL, '1441430611', 1, '', '', ''),
(4, 1, 'Thông tin bài liên hệ', 'SITE_CONTACT', '', '<p>\r\n	X&atilde; hội ng&agrave;y c&agrave;ng ph&aacute;t triển, cuộc sống ng&agrave;y c&agrave;ng được n&acirc;ng cao, v&agrave; những nhu cầu tiện nghi cho cuộc sống con người cũng v&igrave; thế m&agrave; n&acirc;ng l&ecirc;n, k&egrave;m theo đ&oacute; l&agrave; những th&uacute; vui sưu tầm v&agrave; sở hữu những sản phẩm phục vụ cho cuộc sống ng&agrave;y c&agrave;ng lớn. SanPhamReDep.COM l&agrave; nơi cung cấp v&agrave; phục vụ tốt nhất về c&aacute;c loại sản phẩm n&agrave;y.</p>', NULL, '1441430633', 1, '', '', ''),
(8, 1, 'Hướng dẫn mua hàng - nhận hàng - thanh toán', 'SITE_GUIDE_BUY_PAY', '', '<p>\r\n	<strong>Mua đơn giản nhất</strong>: gọi điện trực tiếp đến 0913 922 986 v&agrave; l&agrave;m theo hướng dẫn.</p>\r\n<p>\r\n	<strong>Mua nhanh nhất</strong>: Nhắn 1 tin nhắn gồm: Họ t&ecirc;n + Địa chỉ + M&atilde; sản phẩm đến 0913 922 986. Shop sẽ gọi lại x&aacute;c nhận v&agrave; chuyển h&agrave;ng cho bạn.</p>\r\n<p>\r\n	<strong>Mua ch&iacute;nh x&aacute;c nhất</strong>: Đặt h&agrave;ng tr&ecirc;n website</p>\r\n<p>\r\n	- <em><strong>Bước 1</strong></em>: Lựa chọn mẫu sản phẩm ưng &yacute; tr&ecirc;n website: SanPhamReDep.COM</p>\r\n<p>\r\n	-<em><strong> Bước 2</strong></em>: Điền đầy đủ th&ocirc;ng tin v&agrave;o &ocirc; nhập v&agrave; số lượng bạn muốn mua:</p>\r\n<p>\r\n	- <em><strong>Bước 3</strong></em> - Gửi đơn h&agrave;ng: Sau khi điền xong bạn bấm v&agrave;o n&uacute;t GỬI ĐƠN H&Agrave;NG</p>\r\n<p>\r\n	<strong>NHẬN H&Agrave;NG</strong></p>\r\n<p>\r\n	Sau 2-4 ng&agrave;y bạn đặt h&agrave;ng, sản phẩm bạn mua sẽ được giao tận tay bạn ở nh&agrave; hoặc bất cứ địa điểm n&agrave;o bạn muốn trong giờ h&agrave;nh ch&iacute;nh nh&eacute; (Từ 8h s&aacute;ng đến 17h chiều).</p>\r\n<p>\r\n	<strong>THANH TO&Aacute;N</strong></p>\r\n<p>\r\n	Thanh to&aacute;n rất đơn giản, khi n&agrave;o nhận được h&agrave;ng bạn chỉ cần gửi tiền cho người giao l&agrave; xong, kh&ocirc;ng cần chuyển khoản, vừa tiết kiệm thời gian vừa an to&agrave;n.</p>', NULL, '1441430673', 1, '', '', ''),
(9, 1, 'Nội dung meta SEO trang chủ', 'SITE_SEO_HOME', 'Không cần để nội dung...', 'Không cần để nội dung...', '07-2015/10-41-20-21-07-2015-sanphamtructuyen.jpg', '1437450080', 1, 'Thời trang nam, thời trang nữ, thời trang trẻ em, phụ kiện thời trang, đồ gia dụng', 'Thời trang nam, thời trang nữ, thời trang trẻ em, phụ kiện thời trang, đồ gia dụng', 'Thời trang nam, thời trang nữ, thời trang trẻ em, phụ kiện thời trang, đồ gia dụng'),
(10, 1, 'Hotline đầu trang', 'SITE_HOTLINE', 'Hotline đầu trang', '0946.721.638 - 0913.922.986', NULL, '1446789341', 1, '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `web_contact`
--

CREATE TABLE IF NOT EXISTS `web_contact` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_title` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'tên liên hệ',
  `contact_content` mediumtext CHARACTER SET utf8,
  `contact_content_reply` mediumtext CHARACTER SET utf8,
  `contact_user_id_send` int(11) DEFAULT '0' COMMENT '0: khách vãng lai gửi, > 0 shop gửi liên hệ',
  `contact_user_name_send` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `contact_phone_send` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `contact_email_send` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `contact_type` tinyint(5) DEFAULT '1' COMMENT '1:loại gửi , 2: loại nhận',
  `contact_reason` tinyint(5) DEFAULT '1' COMMENT 'Lý do gửi liên hệ: 1: liên hệ ở ngoài site, 2: shop liên hệ với quản trị',
  `contact_status` tinyint(5) DEFAULT '1' COMMENT '1: liên hệ mới, 2: đã xác nhận,3: đã xử lý',
  `contact_time_creater` int(11) DEFAULT NULL,
  `contact_user_id_update` int(11) DEFAULT NULL COMMENT 'Người xử lý liên hệ',
  `contact_user_name_update` varchar(255) DEFAULT NULL,
  `contact_time_update` int(11) DEFAULT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `web_contact`
--

INSERT INTO `web_contact` (`contact_id`, `contact_title`, `contact_content`, `contact_content_reply`, `contact_user_id_send`, `contact_user_name_send`, `contact_phone_send`, `contact_email_send`, `contact_type`, `contact_reason`, `contact_status`, `contact_time_creater`, `contact_user_id_update`, `contact_user_name_update`, `contact_time_update`) VALUES
(1, 'test tí nào', '<p>nội dung li&ecirc;n hệ</p>\r\n', '<p>quản trị đ&atilde; xử l&yacute; vấn đ&egrave; n&agrave;y<br />\r\n&nbsp;</p>\r\n', 5, 'Shop quần áo đẹp', '0938413368', 'manhquynh1984@gmail.com', 1, 2, 3, 1460729213, NULL, NULL, 1460796544);

-- --------------------------------------------------------

--
-- Table structure for table `web_news`
--

CREATE TABLE IF NOT EXISTS `web_news` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `web_order`
--

CREATE TABLE IF NOT EXISTS `web_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_product_id` int(11) DEFAULT NULL,
  `order_product_name` varchar(255) DEFAULT NULL,
  `order_product_price_sell` int(11) DEFAULT NULL,
  `order_product_image` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `order_category_id` int(11) DEFAULT NULL,
  `order_category_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `order_product_type_price` tinyint(5) DEFAULT '1' COMMENT 'kiểu hiển thị tiền của SP: 1: hiên thị giá, 2: liên hệ shop',
  `order_product_province` tinyint(11) DEFAULT NULL COMMENT 'tỉnh thành của sản phẩm',
  `order_customer_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Tên khách hàng',
  `order_customer_phone` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `order_customer_email` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `order_customer_address` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `order_customer_note` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `order_quality_buy` int(11) DEFAULT NULL COMMENT 'số lượng mua',
  `order_user_shop_id` int(11) DEFAULT NULL,
  `order_user_shop_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `order_status` tinyint(5) DEFAULT '1' COMMENT '0:đơn hàng bị xóa1: đơn hàng mới, 2: đơn hàng đã xác nhận, 3:đơn hàng hoàn thành,4: đơn hàng bị hủy',
  `order_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `web_product`
--

CREATE TABLE IF NOT EXISTS `web_product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price_sell` int(11) DEFAULT '0' COMMENT 'Giá bán',
  `product_price_market` int(11) DEFAULT '0' COMMENT 'Giá thị trường',
  `product_price_input` int(11) DEFAULT '0' COMMENT 'giá nhập',
  `product_type_price` tinyint(5) DEFAULT '1' COMMENT 'Kiểu hiển thị giá bán: 1:hiển thị giá số, 2: hiển thị giá liên hệ',
  `product_selloff` varchar(255) DEFAULT NULL COMMENT 'text thông báo thông tin giảm giá, sp dinh kèm, khuyến mại...',
  `product_is_hot` tinyint(5) DEFAULT '0' COMMENT '0: SP bthuong,1:sản phẩm nổi bật,2:sản phẩm giảm giá....',
  `product_sort_desc` text COMMENT 'mô tả ngắn',
  `product_content` text COMMENT 'nội dung sản phẩm',
  `product_image` varchar(255) DEFAULT NULL COMMENT 'ảnh SP chính ',
  `product_image_hover` varchar(255) DEFAULT NULL COMMENT 'ảnh khi hover chuột vào SP',
  `product_image_other` text COMMENT 'danh sach ảnh khác',
  `product_order` int(10) DEFAULT '100' COMMENT 'sắp xếp hiển thị sản phẩm ở trang list',
  `category_id` int(11) DEFAULT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `quality_input` int(11) DEFAULT '0' COMMENT 'Số lượng nhập hàng',
  `quality_out` int(11) DEFAULT '0' COMMENT 'Số lượng đã xuất',
  `product_status` tinyint(5) DEFAULT '1' COMMENT '0:ẩn, 1:hiện,',
  `is_block` tinyint(5) DEFAULT '1' COMMENT '0: bị khóa, 1: không bị khóa',
  `user_shop_id` int(11) DEFAULT '0' COMMENT 'Id user shop',
  `user_shop_name` varchar(255) DEFAULT NULL COMMENT 'Tên shop tạo sản phẩm',
  `is_shop` tinyint(5) DEFAULT '0' COMMENT '0: sp của shop thường, 1: sản phẩm của shop vip',
  `shop_province` int(10) DEFAULT NULL COMMENT 'Tỉnh thành của shop',
  `time_created` int(11) DEFAULT NULL,
  `time_update` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=142 ;

--
-- Dumping data for table `web_product`
--

INSERT INTO `web_product` (`product_id`, `product_code`, `product_name`, `product_price_sell`, `product_price_market`, `product_price_input`, `product_type_price`, `product_selloff`, `product_is_hot`, `product_sort_desc`, `product_content`, `product_image`, `product_image_hover`, `product_image_other`, `product_order`, `category_id`, `category_name`, `quality_input`, `quality_out`, `product_status`, `is_block`, `user_shop_id`, `user_shop_name`, `is_shop`, `shop_province`, `time_created`, `time_update`) VALUES
(33, NULL, 'Son BJ Velvet', 300000, 330000, 300000, 1, '', 2, '<p>H&agrave;ng chuẩn Ph&aacute;p.N&oacute;i kh&ocirc;ng với h&agrave;ng Fake.</p>\r\n\r\n<p>&nbsp;</p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(102, 102, 102); font-family:helvetica,arial,sans-serif; font-size:12px">- L&agrave; d&ograve;ng son được c&aacute;c blogger nổi tiếng tr&ecirc;n thế giới hết lời ca ngợi như một loại son dạng lỏng đỉnh của đỉnh &ndash; son kem tốt nhất &ndash; &rdquo; The Best Liquid Lipstick&rdquo;</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(102, 102, 102); font-family:helvetica,arial,sans-serif; font-size:12px">- Bảng m&agrave;u son Bourjois đẹp tinh tế, đa dạng về m&agrave;u sắc ứng dụng, m&agrave;u n&agrave;o nh&igrave;n cũng muốn iu muốn rước về hết như &yacute;. Thưởng cho đ&ocirc;i m&ocirc;i xinh đẹp của bạn một m&agrave;u nắng rực rỡ nh&eacute;</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(102, 102, 102); font-family:helvetica,arial,sans-serif; font-size:12px">- Điểm đặc biệt gi&uacute;p cho Bourjois Rouge Edition Velvet d&agrave;nh được nhiều sự ưu &aacute;i đ&oacute; ch&iacute;nh l&agrave; c&ocirc;ng thức l&acirc;u tr&ocirc;i, bền m&agrave;u l&ecirc;n tới 24h.</span></p>\r\n', '04-42-43-21-04-2016-sonbj.jpg', '04-42-30-21-04-2016-son-bj.jpg', 'a:2:{i:0;s:30:"04-42-30-21-04-2016-son-bj.jpg";i:1;s:29:"04-42-43-21-04-2016-sonbj.jpg";}', 0, 165, 'Trang điểm', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461231335, 1461471233),
(34, NULL, 'Son Shu Uemura', 600000, 650000, 600000, 1, '', 2, '<p>Son m&ocirc;i m&agrave;u l&igrave; d&ograve;ng mới Rouge Unlimited Supreme Matte</p>\r\n', '<p><strong>Son Shu Uemura&nbsp;</strong></p>\r\n\r\n<p>-&nbsp;<a href="http://thegioisonmoi.com/son-shu-uemura" style="outline: 0px; margin: 0px; padding: 0px; color: rgb(139, 0, 72); text-decoration: none; cursor: pointer; border: 0px; font-family: inherit; font-size: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; transition: color 0.2s ease-out 0s;">Son Shu Uemura</a>&nbsp;với chất son l&igrave; nhưng l&ecirc;n m&ocirc;i rất mịn kh&ocirc;ng l&agrave;m kh&ocirc; m&ocirc;i.</p>\r\n\r\n<p>-&nbsp;<a href="http://thegioisonmoi.com/son-shu-uemura" style="outline: 0px; margin: 0px; padding: 0px; color: rgb(139, 0, 72); text-decoration: none; cursor: pointer; border: 0px; font-family: inherit; font-size: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; transition: color 0.2s ease-out 0s;">Shu Uemura</a>&nbsp;L&ecirc;n m&agrave;u &nbsp;mềm mượt, lướt tr&ecirc;n m&ocirc;i cực k&igrave; dễ d&agrave;ng, chỉ lướt son 1 lần l&agrave; m&agrave;u l&ecirc;n chuẩn x&aacute;c như tr&ecirc;n thỏi.</p>\r\n\r\n<p>-&nbsp;<a href="http://thegioisonmoi.com/son-shu-uemura" style="outline: 0px; margin: 0px; padding: 0px; color: rgb(139, 0, 72); text-decoration: none; cursor: pointer; border: 0px; font-family: inherit; font-size: inherit; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; line-height: inherit; transition: color 0.2s ease-out 0s;">Son Shu&nbsp;</a>Che khuyết điểm của m&ocirc;i như nếp nhăn &amp; m&ocirc;i th&acirc;m rất hiệu quả.</p>\r\n\r\n<p><strong>Quy c&aacute;ch:&nbsp;</strong>Thỏi 3.2g</p>\r\n\r\n<p><strong>Xuất xứ:&nbsp;</strong>Made in Japan</p>\r\n', '05-30-15-21-04-2016-son-shu-uemura-rouge-unlimited-matte-nhat-ban-1.jpg', '05-30-15-21-04-2016-son-shu-uemura-rouge-unlimited-matte-nhat-ban-1.jpg', 'a:1:{i:0;s:71:"05-30-15-21-04-2016-son-shu-uemura-rouge-unlimited-matte-nhat-ban-1.jpg";}', 0, 165, 'Trang điểm', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461233550, 1461469161),
(35, NULL, 'Catrice Ultimade Colour', 265000, 300000, 0, 1, '', 1, '<p><font color="#141823">H&agrave;ng Aut chuẩn 100%.</font></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px">&nbsp;D&ograve;ng son nhiều dưỡng gi&uacute;p đ&ocirc;i m&ocirc;i lu&ocirc;n mềm mịn,m&agrave;u sắc nổi bật gi&uacute;p đ&ocirc;i m&ocirc;i th&ecirc;m tươi s&aacute;ng cả ng&agrave;y d&agrave;i.</span></p>\r\n', '05-33-58-21-04-2016-192892512071277959790204177193177260823075n.jpg', '05-33-58-21-04-2016-192892512071277959790204177193177260823075n.jpg', 'a:1:{i:0;s:67:"05-33-58-21-04-2016-192892512071277959790204177193177260823075n.jpg";}', 0, 165, 'Trang điểm', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461234838, NULL),
(36, NULL, 'Collection Exclusive  L''Oreal.', 300000, 350000, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Collection Exclusive l&agrave; bộ sưu tập mới đầy m&agrave;u sắc của L&#39;Oreal.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Collection Exclusive l&agrave; bộ sưu tập mới đầy m&agrave;u sắc của L&#39;Oreal.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Thiết kế vỏ ngo&agrave;i sang trọng với m&agrave;u đen huyền b&iacute;, t&ecirc;n sản phẩm được in tinh tế v&agrave; cuốn h&uacute;t, Collection Exclusive thực sự đ&atilde; mang một sức h&uacute;t v&agrave; sự l&ocirc;i cuốn k&igrave; diệu với c&aacute;c qu&yacute; c&ocirc; Ch&acirc;u &Acirc;u .</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Vẻ ngo&agrave;i bắt mắt đ&atilde; l&agrave; một điểm mạnh của d&ograve;ng sản phẩm n&agrave;y, nhưng điều khiến c&aacute;c c&ocirc; g&aacute;i m&ecirc; mẩn thỏi son n&agrave;y ch&iacute;nh l&agrave; chất son mềm mịn, bắt m&ocirc;i</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">&nbsp;v&agrave; m&agrave;u sắc thực sự tinh tế.<br />\r\n- Chất son l&igrave; nhưng vẫn c&oacute; độ b&oacute;ng v&agrave; độ ẩm, gi&uacute;p son b&aacute;m m&ocirc;i v&agrave; l&acirc;u tr&ocirc;i hơn 12h.<br />\r\n- Thừa hưởng đặc t&iacute;nh hương thơm của thương hiệu L&#39;Oreal, d&ograve;ng Collection Exclusive mang hương thơm nước hoa quyến rũ đến kh&oacute; cưỡng, kh&ocirc;ng chỉ nằm ở chất son m&agrave; m&agrave;u sắc cũng được coi l&agrave; thế mạnh của d&ograve;ng sản phẩm n&agrave;y.<br />\r\n- Collection Exclusive xứng đ&aacute;ng l&agrave; d&ograve;ng son bỏ t&uacute;i của bất k&igrave; c&ocirc; g&aacute;i n&agrave;o.</span></p>\r\n', '05-36-34-21-04-2016-1034280912071274059790596102233539838489939n.jpg', '05-36-34-21-04-2016-1034280912071274059790596102233539838489939n.jpg', 'a:1:{i:0;s:68:"05-36-34-21-04-2016-1034280912071274059790596102233539838489939n.jpg";}', 0, 165, 'Trang điểm', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461234994, NULL),
(37, NULL, 'Son Firin', 120000, 150000, 120000, 1, '', 1, '<p>Son chuẩn Nga</p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Son giống như sương sớm l&agrave;m ẩm những c&aacute;nh hoa tinh tế của hoa hồng, son m&ocirc;i &quot;si&ecirc;u dưỡng&quot; được thiết kế đặc biệt cho m&ocirc;i, giữ ẩm suốt cả ng&agrave;y!</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Son m&ocirc;i n&agrave;y được thiết kế đặc biệt c&ocirc;ng thức giữ ẩm, m&agrave; l&agrave; 85% bao gồm c&aacute;c th&agrave;nh phần tự nhi&ecirc;n.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Lipstick &quot;si&ecirc;u dưỡng&quot; cho m&ocirc;i b&oacute;ng v&agrave; thời trang c&ugrave;ng một l&uacute;c kh&ocirc;ng tr&ocirc;i!</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Ch&uacute;ng t&ocirc;i chỉ cung cấp c&aacute;c m&agrave;u sắc thời trang nhất</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Đặc biệt: son m&ocirc;i chứa một bộ lọc tia cực t&iacute;m!<br />\r\n- Son m&ocirc;i &quot;tinh tế&quot; chủ yếu bao gồm c&aacute;c th&agrave;nh phần tự nhi&ecirc;n.</span></p>\r\n', '05-39-55-21-04-2016-863812071275993123739211492266779449737n.jpg', '05-40-11-21-04-2016-151461312071276559790343913846481741023166n.jpg', 'a:2:{i:0;s:64:"05-39-55-21-04-2016-863812071275993123739211492266779449737n.jpg";i:1;s:67:"05-40-11-21-04-2016-151461312071276559790343913846481741023166n.jpg";}', 0, 165, 'Trang điểm', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461235195, 1461240489),
(39, NULL, 'Beauskin Hàn Quốc', 300000, 350000, 300000, 1, '', 1, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Beauskin&nbsp;</span>H&agrave;n Quốc</p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Beauskin l&agrave; nh&atilde;n hiệu mỹ phẩm cao cấp H&agrave;n Quốc c&oacute; mặt ở rất nhiều quốc gia tr&ecirc;n thế giới. C&aacute;c sản phẩm của Beauskin đều được sản xuất theo những c&ocirc;ng thức độc đ&aacute;o, mang lại hiệu quả l&agrave;m đẹp cao. Với 100% th&agrave;nh phần chiết xuất từ thi&ecirc;n nhi&ecirc;n, Beauskin cam kết n&oacute;i kh&ocirc;ng với chất h&oacute;a học, chất tạo m&agrave;u nh&acirc;n tạo, dầu kho&aacute;ng, cồn, Benzophenone, đem lại c&aacute;c sản phẩm chăm s&oacute;c da an to&agrave;n cho sức khỏe.&nbsp;</span></p>\r\n', '05-43-12-21-04-2016-94382412071274993123835521106172164972509n.jpg', '05-43-12-21-04-2016-94382412071274993123835521106172164972509n.jpg', 'a:1:{i:0;s:66:"05-43-12-21-04-2016-94382412071274993123835521106172164972509n.jpg";}', 0, 165, 'Trang điểm', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461235392, 1461240257),
(40, NULL, 'Son P2 Full color lipstick', 265000, 300000, 0, 1, '', 1, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">D&ograve;ng son P2 Full color lipstick</span></p>\r\n\r\n<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Xuất xứ : EU</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">D&ograve;ng son P2 Full color lipstick l&ecirc;n m&agrave;u rất chuẩn v&agrave; tự nhi&ecirc;n. V&igrave; l&agrave; d&ograve;ng son tinh khiết như t&ecirc;n gọi n&ecirc;n son P2 Full c&oacute; c&ocirc;ng thức si&ecirc;u nhẹ kh&ocirc;ng chứa chất nhũ h&oacute;a v&agrave; chất tạo hương (n&ecirc;n son kh&ocirc;ng c&oacute; m&ugrave;i hương). Tuy vậy P2 Full color lipstick vẫn bền m&agrave;u v&agrave; tỏa s&aacute;ng rực rỡ. C&aacute;c tinh thể si&ecirc;u mịn chứa acid hyaluronic gi&uacute;p bảo vệ độ ẩm v&agrave; giữ cho đ&ocirc;i m&ocirc;i lu&ocirc;n căng mọng gợi cảm. Sản phẩm đ&atilde; được chứng nhận an to&agrave;n cho sức khỏe.</span></p>\r\n', '05-50-03-21-04-2016-1188522812071278293123507945007904444840555n.jpg', '05-50-03-21-04-2016-1188522812071278293123507945007904444840555n.jpg', 'a:1:{i:0;s:68:"05-50-03-21-04-2016-1188522812071278293123507945007904444840555n.jpg";}', 0, 165, 'Trang điểm', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461235803, NULL),
(42, NULL, 'Son gió  Mood Matcher', 100000, 150000, 100000, 1, '', 1, '<p><strong>Son gi&oacute; M&ocirc;i Mood Matcher</strong></p>\r\n\r\n<p><strong>Xuất xứ : USA</strong></p>\r\n', '<p style="text-align:justify"><a href="http://www.cachtrangda.com/trang-da/son-moi-mood-matcher-usa-chinh-hang.html" style="margin: 0px; padding: 0px; outline: none; color: rgb(5, 107, 205); text-decoration: none;"><strong>Son M&ocirc;i Mood Matcher USA&nbsp;</strong></a>l&agrave; sản phẩm của một trong những h&atilde;ng mỹ phẩm nổi tiếng của Mỹ, Son M&ocirc;i Mood Matcher USA sẽ mang đến cho bạn một l&agrave;n m&ocirc;i tươi tắn, quyến rũ v&agrave; gi&uacute;p bạn tự tin hơn khi xuất hiện trước mọi người.</p>\r\n\r\n<p style="text-align:justify">Son M&ocirc;i Mood Matcher USA kh&ocirc;ng chỉ gi&uacute;p ngăn ngừa t&aacute;c hại &ocirc; nhiễm của m&ocirc;i trường, giảm thiểu sự xuất hiện nếp nhăn tr&ecirc;n m&ocirc;i, duy tr&igrave; độ ẩm tự nhi&ecirc;n cho m&ocirc;i m&agrave; c&ograve;n mang lại cho bạn một l&agrave;n m&ocirc;i hồng thật tự nhi&ecirc;n.</p>\r\n\r\n<p style="text-align:justify">&nbsp;</p>\r\n', '05-56-28-21-04-2016-1299091812338970333020963587962384416707277n.jpg', '05-56-37-21-04-2016-129986501233897006635432669105479702984599n.jpg', 'a:2:{i:0;s:68:"05-56-28-21-04-2016-1299091812338970333020963587962384416707277n.jpg";i:1;s:67:"05-56-37-21-04-2016-129986501233897006635432669105479702984599n.jpg";}', 0, 165, 'Trang điểm', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461236188, 1461469302),
(43, NULL, 'Sheep Placenta Costar 35000mg', 900000, 1100000, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Sheep Placenta Costar 35000mg chiết xuất ho&agrave;n to&agrave;n tự nhi&ecirc;n từ nhau thai cừu &Uacute;c.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Sheep Placenta Costar 35000mg chiết xuất ho&agrave;n to&agrave;n tự nhi&ecirc;n từ nhau thai cừu &Uacute;c, gi&uacute;p tăng cường hệ miễn dịch, chống lại qu&aacute; tr&igrave;nh oxy h&oacute;a, mang đến cho bạn l&agrave;n da mịn m&agrave;ng, săn chắc như &yacute;.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Hộp 100v ng&agrave;y uống 1 vi&ecirc;n khi đ&oacute;i để hấp thụ thuốc tốt hơn.</span></p>\r\n', '06-00-07-21-04-2016-343mz1395043674.jpg', '06-00-07-21-04-2016-343mz1395043674.jpg', 'a:1:{i:0;s:39:"06-00-07-21-04-2016-343mz1395043674.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461236407, NULL),
(44, NULL, 'Cao Linh Chi Hàn Quốc', 550000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Cao Linh Chi H&agrave;n Quốc - Chiết xuất Cao nguy&ecirc;n chất - 250gr (5 lọ *50gr)</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Cao Linh Chi H&agrave;n Quốc - Chiết xuất Cao nguy&ecirc;n chất - 250gr (5 lọ *50gr)</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">-Ph&ograve;ng &amp; chữa c&aacute;c bệnh: Tiểu đường, mỡ nhiễm m&aacute;u, c&aacute;c bệnh về gan, mật, thận suy.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">-Điều ho&agrave; huyết &aacute;p, suy nhược, b&eacute;o ph&igrave;.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">-Thuốc bồi bổ chống suy dinh dưỡng, hậu sản, bổ &acirc;m, an thai.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">-Tr&aacute;ng dương</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">-Ti&ecirc;u độc; bổ m&aacute;u; trị suy giảm tr&iacute; nhớ.<br />\r\n-S&aacute;ng da, l&agrave;m cho l&agrave;n da tươi s&aacute;ng v&agrave; hồng h&agrave;o dần sau khi d&ugrave;ng.</span></p>\r\n', '06-04-22-21-04-2016-cao-linh-chi-hop-vang-1.jpg', '06-04-22-21-04-2016-cao-linh-chi-hop-vang-1.jpg', 'a:1:{i:0;s:47:"06-04-22-21-04-2016-cao-linh-chi-hop-vang-1.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461236662, 1461554024),
(45, NULL, 'Tảo lục chlorella Royal DX Nhật Bản', 600000, 650000, 0, 1, '', 2, '<p>Tảo lục chlorella Royal DX Nhật Bản 1550 vi&ecirc;n chứa h&agrave;m lượng Cholorophyll cao nhất trong c&aacute;c lo&agrave;i thực vật m&agrave; con người được biết đến.</p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Tảo lục chlorella Royal DX Nhật Bản 1550 vi&ecirc;n chứa h&agrave;m lượng Cholorophyll cao nhất trong c&aacute;c lo&agrave;i thực vật m&agrave; con người được biết đến. Tảo ho&agrave;ng gia chứa đầy đủ c&aacute;c vitamin, axit amin, axit b&eacute;o kh&ocirc;ng no, acid nucleic,&hellip;gi&uacute;p tăng cường sức khỏe, n&acirc;ng cao sức đề kh&aacute;ng cho cơ thể, l&agrave;m đẹp da, l&agrave;m chậm tiến tr&igrave;nh l&atilde;o h&oacute;a, ngăn ngừa bệnh ung thư, giảm b&eacute;o ph&igrave;.</span></p>\r\n', '06-06-45-21-04-2016-201304155637toroyaldxa.jpg', '06-06-45-21-04-2016-201304155637toroyaldxa.jpg', 'a:1:{i:0;s:46:"06-06-45-21-04-2016-201304155637toroyaldxa.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461236805, 1461553996),
(47, NULL, 'Váy quần  bò đẹp', 0, 0, 0, 2, 'Đang giảm giá nhiều nếu mua cả cáo và quần', 1, '<p>Năm nay v&aacute;y b&ograve; l&ecirc;n ng&ocirc;i ạ. Bao nhiều cũng hết<br />\r\nVề 2 mẫu v&aacute;y c&uacute;c v&agrave; tua rua.</p>\r\n', '<p>Năm nay v&aacute;y b&ograve; l&ecirc;n ng&ocirc;i ạ. Bao nhiều cũng hết<br />\r\nVề 2 mẫu v&aacute;y c&uacute;c v&agrave; tua rua.</p>\r\n', '11-04-05-23-04-2016-12.jpg', '11-53-41-23-04-2016-13.jpg', 'a:2:{i:0;s:26:"11-04-05-23-04-2016-12.jpg";i:1;s:26:"11-53-41-23-04-2016-13.jpg";}', 1, 106, 'Đầm, chân váy', 0, 0, 1, 1, 8, 'Mum chip''s shop', 2, 22, 1461427427, 1461430427),
(49, NULL, 'Iphone 5 16GB Trắng', 0, 0, 0, 2, 'Combo 7 quà tặng kèm theo', 2, '<p>M&agrave;n h&igrave;nh</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">C&ocirc;ng nghệ m&agrave;n h&igrave;nh</span></p>\r\n\r\n<p>LED-backlit IPS LCD</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Độ ph&acirc;n giải</span></p>\r\n\r\n<p>640 x 1136 pixels</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">M&agrave;n h&igrave;nh rộng</span></p>\r\n\r\n<p>4&quot;</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Cảm ứng</span></p>\r\n\r\n<p>Cảm ứng điện dung đa điểm</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Mặt k&iacute;nh cảm ứng</span></p>\r\n\r\n<p>K&iacute;nh cường lực</p>\r\n\r\n<p>Camera sau</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Độ ph&acirc;n giải</span></p>\r\n\r\n<p>8 MP</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Quay phim</span></p>\r\n\r\n<p>Quay phim FullHD 1080p@30fps</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Đ&egrave;n Flash</span></p>\r\n\r\n<p>C&oacute;</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Chụp ảnh n&acirc;ng cao</span></p>\r\n\r\n<p>Camera trước</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Độ ph&acirc;n giải</span></p>\r\n\r\n<p>1.2 MP</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Quay phim</span></p>\r\n\r\n<p>C&oacute;</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Videocall</span></p>\r\n\r\n<p>C&oacute;</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Th&ocirc;ng tin kh&aacute;c</span></p>\r\n\r\n<p>Hệ điều h&agrave;nh - CPU</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Hệ điều h&agrave;nh</span></p>\r\n\r\n<p>iOS 6</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Chipset (h&atilde;ng SX CPU)</span></p>\r\n\r\n<p>Apple A6 2 nh&acirc;n 32-bit</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Tốc độ CPU</span></p>\r\n\r\n<p>1.3 GHz</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Chip đồ họa (GPU)</span></p>\r\n\r\n<p>PowerVR SGX543MP3</p>\r\n\r\n<p>Bộ nhớ &amp; Lưu trữ</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">RAM</span></p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Bộ nhớ trong (ROM)</span></p>\r\n\r\n<p>16 GB</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Bộ nhớ c&ograve;n lại (khả dụng)</span></p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Thẻ nhớ ngo&agrave;i</span></p>\r\n\r\n<p>Kh&ocirc;ng</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Hỗ trợ thẻ tối đa</span></p>\r\n\r\n<p>Kh&ocirc;ng</p>\r\n\r\n<p>Kết nối</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Băng tần 2G</span></p>\r\n\r\n<p>GSM 850/900/1800/1900</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Băng tần 3G</span></p>\r\n\r\n<p>HSDPA 850/900/1900/2100 , LTE 850/1800/2100</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">H&ocirc;̃ trợ 4G</span></p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Số khe sim</span></p>\r\n\r\n<p>1 Sim</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Loại Sim</span></p>\r\n\r\n<p>Nano SIM</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Wifi</span></p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">GPS</span></p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Bluetooth</span></p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">NFC</span></p>\r\n\r\n<p>Kh&ocirc;ng</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">C&ocirc;̉ng k&ecirc;́t n&ocirc;́i/sạc</span></p>\r\n\r\n<p>USB 2.0</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Jack tai nghe</span></p>\r\n\r\n<p>3.5 mm</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Kết nối kh&aacute;c</span></p>\r\n\r\n<p>Kh&ocirc;ng</p>\r\n\r\n<p>Thiết kế &amp; Trọng lượng</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Thiết kế</span></p>\r\n\r\n<p>Nguy&ecirc;n khối</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Chất liệu</span></p>\r\n\r\n<p>Nhựa, nh&ocirc;m</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">K&iacute;ch thước</span></p>\r\n\r\n<p>D&agrave;i 123.8 mm - Ngang 58.6 mm - D&agrave;y 7.6 mm</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Trọng lượng</span></p>\r\n\r\n<p>112</p>\r\n\r\n<p>Th&ocirc;ng tin pin</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Dung lượng pin</span></p>\r\n\r\n<p>1440 mAh</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Loại pin</span></p>\r\n\r\n<p>Pin chuẩn Li-Ion</p>\r\n\r\n<p>Giải tr&iacute; &amp; Ứng dụng</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Xem phim</span></p>\r\n\r\n<p>MP4,&nbsp;WMV,&nbsp;H.263,&nbsp;H.264(MPEG4-AVC)</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Nghe nhạc</span></p>\r\n\r\n<p>MP3,&nbsp;WAV,&nbsp;WMA,&nbsp;eAAC+</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Ghi &acirc;m</span></p>\r\n\r\n<p>C&oacute;</p>\r\n\r\n<p><span style="color:rgb(102, 102, 102)">Radio</span></p>\r\n\r\n<p>Kh&ocirc;ng</p>\r\n', '<h1>Đập hộp iPhone 5 trước ng&agrave;y l&ecirc;n kệ</h1>\r\n\r\n<p><span style="color:rgb(68, 68, 68); font-family:arial,sans-serif; font-size:16px"><strong>1) Kiểu d&aacute;ng thiết kế</strong></span><span style="color:rgb(68, 68, 68); font-family:arial,sans-serif; font-size:16px">iPhone 5 sở hữu &quot;body&quot; mỏng hơn cả tiền bối iPhone 4S khoảng 18% (mỏngchỉ 7,6 mm) v&agrave; nhẹ hơn đến 20% (112gram), m&agrave;n h&igrave;nh Retina nới rộng l&ecirc;n 4inch với độ ph&acirc;n giải 1.136 x 640 pixel (giữ nguy&ecirc;n mật độ điểm ảnh326ppi).</span></p>\r\n\r\n<div style="margin: 0px; padding: 0px; font-size: 16px; line-height: 25px; color: rgb(68, 68, 68); font-family: arial, sans-serif; text-align: center;"><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/iphone-5-hands-on-slashgear-086.jpg" /></div>\r\n\r\n<p><span style="color:rgb(68, 68, 68); font-family:arial,sans-serif; font-size:16px">Nhờ chiều d&agrave;i tăng l&ecirc;n, iPhone 5 c&oacute; th&ecirc;m một d&ograve;ng hiển thị icon v&agrave; nhiềuđất diễn hơn cho ứng dụng kh&aacute;c. Độ b&atilde;o h&ograve;a m&agrave;u sắc được tăng th&ecirc;m 44%,mang đến khả năng hiển thị h&igrave;nh ảnh sống động hơn. Cảm biến cảm ứng đượct&iacute;ch hợp ngay tr&ecirc;n m&agrave;n h&igrave;nh hiển thị n&ecirc;n bộ phận hiển thị c&ograve;n mỏng hơntrước 30%.Phần nắp lưng của iPhone 5 sử dụng chất liệu kim loại nguy&ecirc;n khối thayv&igrave; lớp k&iacute;nh b&oacute;ng bẩy, từ đ&oacute; đ&atilde; phần n&agrave;o gi&uacute;p người d&ugrave;ng hạn chế rủi rokhi đ&aacute;nh rơi m&aacute;y.</span><span style="color:rgb(68, 68, 68); font-family:arial,sans-serif; font-size:16px"><strong>2) Phần cứng</strong></span><span style="color:rgb(68, 68, 68); font-family:arial,sans-serif; font-size:16px">iPhone 5 d&ugrave;ng ch&iacute;p xử l&yacute; A6 gi&uacute;p cho m&aacute;y khởi chạy ở tốc độ tối đa v&agrave;gấp đ&ocirc;i so với d&ograve;ng ch&iacute;p A5 tiền nhiệm, trong khi k&iacute;ch thước của ch&iacute;plại giảm 22%. C&ugrave;ng với đ&oacute; l&agrave; khả năng xử l&yacute; đồ họa được n&acirc;ng cao. Theoth&ocirc;ng số m&agrave; Apple cung cấp, người d&ugrave;ng được trải nghiệm cảm gi&aacute;c lướtweb nhanh gấp 2,1 lần v&agrave; tải nhạc nhanh gấp 1,9 lần th&ocirc;ng thường.Qua đ&oacute;, iPhone 5 được trang bị kết nối 4G LTE b&ecirc;n cạnh đường truyềnGPRS, EDGE, EV-DO v&agrave; HSPA hiện h&agrave;nh. Điều n&agrave;y khiến m&aacute;y trở n&ecirc;n ph&ugrave; hợpvới hầu hết c&aacute;c thị trường ti&ecirc;n tiến, từ ch&acirc;u Mỹ đến ch&acirc;u &Aacute;.</span></p>\r\n\r\n<div style="margin: 0px; padding: 0px; font-size: 16px; line-height: 25px; color: rgb(68, 68, 68); font-family: arial, sans-serif; text-align: center;"><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/iphone-5-hands-on-slashgear-054.jpg" /><em><strong>iPhone 5 h&igrave;nh tr&ecirc;n đang d&ugrave;ng mạng 4G LTE của Verizon</strong></em></div>\r\n\r\n<p><span style="color:rgb(68, 68, 68); font-family:arial,sans-serif; font-size:16px">Tuy iPhone 5 đang ngồi chung một con thuyền với 4G LTE, nhưng m&aacute;y vẫncho người d&ugrave;ng đ&agrave;m thoại &quot;m&otilde;i miệng&quot; với 8 tiếng th&ocirc;ng qua 3G, 8 tiếngduyệt web tr&ecirc;n 3G, 10 tiếng duyệt web tr&ecirc;n Wi-Fi, 10 tiếng xem video, 40tiếng nghe nhạc v&agrave; thời gian chờ xuy&ecirc;n suốt trong 225 tiếng.Được biết tốc độ download khi trải nghiệm c&ugrave;ng c&ocirc;ng nghệ kết nối 4G LTEtr&ecirc;n iPhone 5 khoảng 13Mbps v&agrave; khả năng tải file l&ecirc;n đến 3Mbps.Chưa ngừng tại đ&oacute;, iPhone 5 t&iacute;ch hợp camera 8MP với độ ph&acirc;n giải tốtnhất 3.264 x 2.448 pixel. M&aacute;y giới thiệu nhiều c&ocirc;ng nghệ hấp dẫn nhưchiếu s&aacute;ng mặt sau, bộ lọc hồng ngoại, ống k&iacute;nh 5 th&agrave;nh phần, khẩu độlớn nhất f/2.4, tốc độ chụp tăng th&ecirc;m 40%... Ngo&agrave;i ra, ch&iacute;p A6 xử l&yacute;th&ocirc;ng minh gi&uacute;p m&aacute;y chụp bớt nhiễu, chụp thiếu s&aacute;ng tốt v&agrave; chế độparonama c&oacute; thể sản xuất khung h&igrave;nh l&ecirc;n tới 28MP.</span></p>\r\n\r\n<div style="margin: 0px; padding: 0px; font-size: 16px; line-height: 25px; color: rgb(68, 68, 68); font-family: arial, sans-serif; text-align: center;"><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/P1030790-580x325.jpg" /><em><strong>Camera ch&iacute;nh ph&iacute;a sau c&oacute; khả năng ghi h&igrave;nh ở độ ph&acirc;n giải Full HD 1080p</strong></em></div>\r\n\r\n<p><span style="color:rgb(68, 68, 68); font-family:arial,sans-serif; font-size:16px">Camera ch&iacute;nh cho ph&eacute;p ghi h&igrave;nh Full HD 1080p v&agrave; nhận diện tối đa 10khu&ocirc;n mặt kh&aacute;c nhau, hỗ trợ chụp ảnh ngay khi đang quay phim. Chưa hết,camera trước được n&acirc;ng cấp để quay phim HD 720p, gi&uacute;p đ&agrave;m thoại FaceTimetốt hơn trước rất nhiều.</span></p>\r\n\r\n<div style="margin: 0px; padding: 0px; font-size: 16px; line-height: 25px; color: rgb(68, 68, 68); font-family: arial, sans-serif; text-align: center;"><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/IMG_04661-281x500.jpg" /><em><strong>Khả năng đ&agrave;m thoại qua FaceTime chuẩn n&eacute;t hơn trước rất nhiều</strong></em><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/IMG_05491-580x187.jpg" /><em><strong>T&iacute;nh năng chup Panoramic</strong></em></div>\r\n\r\n<p><span style="color:rgb(68, 68, 68); font-family:arial,sans-serif; font-size:16px"><strong>3) Nền tảng IOS 6</strong></span><span style="color:rgb(68, 68, 68); font-family:arial,sans-serif; font-size:16px">Hệ điều h&agrave;nh iOS 6 được c&agrave;i sẵn tr&ecirc;n iPhone 5, bao gồm nhiều ứng dụngnổi bật như Apple Maps, Passbook, Siri cải tiến v&agrave; chat FaceTime quas&oacute;ng 3G. Tương tự tiền bối iPhone 4S, iPhone 5 duy tr&igrave; 3 mức dung lượng16, 32 v&agrave; 64GB. Một điều đ&aacute;ng buồn l&agrave; m&aacute;y kh&ocirc;ng được &quot;cộng t&aacute;c&quot; với giaothức tầm ngắn NFC, như đ&atilde; r&ograve; rỉ tin đồn c&aacute;ch nay v&agrave;i th&aacute;ng.</span></p>\r\n\r\n<div style="margin: 0px; padding: 0px; font-size: 16px; line-height: 25px; color: rgb(68, 68, 68); font-family: arial, sans-serif; text-align: center;"><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/IMG_04621-281x500.jpg" />Ứng dụng Maps &quot;c&acirc;y nh&agrave; l&aacute; vườn&quot; của Apple<img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/IMG_03531-281x500.jpg" />C&ocirc; n&agrave;ng trợ l&yacute; Siri &quot;v&ocirc; đối&quot; của nh&agrave; T&aacute;o</div>\r\n\r\n<p><strong>Loạt h&igrave;nh ảnh khui h&ocirc;p iPhone 5</strong></p>\r\n\r\n<div style="margin: 0px; padding: 0px; font-size: 16px; line-height: 25px; color: rgb(68, 68, 68); font-family: arial, sans-serif; text-align: center;"><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/iphone-5-hands-on-slashgear-002.jpg" /><em><strong>Ảnh tr&ecirc;n hộp tr&ocirc;ng giống như ảnh quảng c&aacute;o iPhone 5 tr&ecirc;n website của Apple</strong></em><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/iphone-5-hands-on-slashgear-004.jpg" /><em><strong>iPhone 5 đ&atilde; tho&aacute;t ly khỏi họp</strong></em><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/iphone-5-hands-on-slashgear-001.jpg" /><em><strong>Tai nghe m&agrave;u trắng theo phong c&aacute;ch truyền thống của Apple</strong></em><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/iphone-5-hands-on-slashgear-013.jpg" /><em><strong>Khởi chạy tr&ecirc;n nền tảng IOS 6</strong></em><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/iphone-5-hands-on-slashgear-014.jpg" /><em><strong>Cạnh tr&aacute;i l&agrave; n&uacute;t tăng giảm &acirc;m lượng v&agrave; chế độ rung&nbsp;</strong></em><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/iphone-5-hands-on-slashgear-015.jpg" /><em><strong>Phần dưới đ&aacute;y của m&aacute;y l&agrave; hệ thống loa, cổng kết nối Lightning v&agrave; jack 3.5 mm</strong></em><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/iphone-5-hands-on-slashgear-018.jpg" /><em><strong>Cạnh phải c&oacute; khai chứa Nano-Sim</strong></em><img alt="" src="http://cdn.thegioididong.com/Files/2012/09/19/45465/iphone-5-hands-on-slashgear-016.jpg" /><em><strong>Logo Apple hiển thị r&otilde; n&eacute;t ở mặt sau</strong></em></div>\r\n', '12-50-15-24-04-2016-ip5trag.jpg', '12-50-29-24-04-2016-ip5trag2.jpg', 'a:3:{i:0;s:31:"12-50-15-24-04-2016-ip5trag.jpg";i:1;s:32:"12-50-29-24-04-2016-ip5trag2.jpg";i:2;s:32:"12-50-39-24-04-2016-ip5trag3.jpg";}', 0, 44, 'Điện thoại', 0, 0, 1, 1, 9, 'Quốc Đạt SmartPhone', 2, 5, 1461477015, NULL),
(54, NULL, 'Đông trùng Hạ Thảo', 1000000, 0, 1000000, 1, '', 2, '<p>Nước Đ&ocirc;ng tr&ugrave;ng hạ thảo Daedong H&agrave;n Quốc hộp 60 g&oacute;i - Dong Chung Ha Cho Korea.</p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Nước Đ&ocirc;ng tr&ugrave;ng hạ thảo Daedong H&agrave;n Quốc hộp 60 g&oacute;i - Dong Chung Ha Cho Korea.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Tăng cường hoạt động miễn dịch tế b&agrave;o cũng như miễn dịch cơ thể.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Uống 1 đến 2 lần một ng&agrave;y, mỗi lần 1 g&oacute;i đ&ocirc;ng tr&ugrave;ng hạ thảo nước Daedong, lắc đều trước khi uống, bảo quản nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t tr&aacute;nh &aacute;nh s&aacute;ng trực tiếp từ mặt trời.</span></p>\r\n', '10-23-49-25-04-2016-nuoc-dong-trung-ha-thao-daedong-dong-chung-ha-cho-isaria-japonica-gold-2.jpg', '10-23-49-25-04-2016-nuoc-dong-trung-ha-thao-daedong-dong-chung-ha-cho-isaria-japonica-gold-2.jpg', 'a:1:{i:0;s:96:"10-23-49-25-04-2016-nuoc-dong-trung-ha-thao-daedong-dong-chung-ha-cho-isaria-japonica-gold-2.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461554629, 1461555867),
(56, NULL, 'Collagen EX Nhật', 550000, 0, 0, 1, '', 2, '<p><em>Nước uống shiseido collagen Ex&nbsp;</em><span style="background-color:rgb(255, 255, 255)">chứa h&agrave;m lượng collagen cần thiết để duy tr&igrave; sự tươi trẻ, l&aacute;ng mịn của l&agrave;n da sau tuổi 25. sản phẩm được chiết xuất từ collagen của c&aacute;, vitamin C, vitamin B v&agrave; c&aacute;c th&agrave;nh phần thảo dược tự nhi&ecirc;n.</span></p>\r\n', '<p><a href="http://healthmart.vn/product/collagen-shiseido-ex-dang-nuoc" style="box-sizing: border-box; color: rgb(0, 0, 0); text-decoration: none; font-family: Verdana, Geneva, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);" title="nuoc uong shiseido collagen ex"><em>Nước uống shiseido collagen Ex&nbsp;</em></a><span style="background-color:rgb(255, 255, 255); font-family:verdana,geneva,sans-serif; font-size:14px">chứa h&agrave;m lượng collagen cần thiết để duy tr&igrave; sự tươi trẻ, l&aacute;ng mịn của l&agrave;n da sau tuổi 25. sản phẩm được chiết xuất từ collagen của c&aacute;, vitamin C, vitamin B v&agrave; c&aacute;c th&agrave;nh phần thảo dược tự nhi&ecirc;n.</span></p>\r\n\r\n<h3>C&ocirc;ng dụng l&agrave;m đẹp da của collagen shiseido ex</h3>\r\n\r\n<ul>\r\n	<li><strong><em>Collagen SSD EX</em>&nbsp;</strong>dạng nước&nbsp;gi&uacute;p cho &ldquo;lớp đệm&rdquo; ở da được x&acirc;y dựng v&agrave; củng cố với đầy đủ t&iacute;nh đ&agrave;n hồi v&agrave; sự săn chắc, gi&uacute;p trẻ h&oacute;a v&agrave; ngăn ngừa tối đa sự l&atilde;o h&oacute;a da.</li>\r\n	<li>Collagen SSD EX gi&uacute;p bổ sung collagen cho l&agrave;n da, rất cần thiết gi&uacute;p chị em phụ nữ k&eacute;o d&agrave;i tuổi thanh xu&acirc;n, giữ l&agrave;n da lu&ocirc;n trẻ trung, tươi m&aacute;t.</li>\r\n	<li>Với c&ocirc;ng thức ho&agrave;n hảo gồm:&nbsp;Erythritol, giảm xi-r&ocirc; maltose, collagen peptide (c&oacute; nguồn gốc từ c&aacute;), nước tr&aacute;i c&acirc;y nam việt quất, chiết xuất từ ​​khoai t&acirc;y konjac, quit chiết xuất tr&aacute;i c&acirc;y, (c&oacute; nguồn gốc từ c&aacute;) peptide elastin, acidulant, vitamin C, nước hoa, oligosaccharide cyclic, polysaccharide chất l&agrave;m đặc, vitamin B6 , vitamin E, vitamin B2, acid hyaluronic, chất ngọt (acesulfame kali, sucralose), (gelatin, một số đậu n&agrave;nh th&ocirc;)</li>\r\n	<li><strong><u>Shiseido collagen Ex</u></strong><a href="http://collagenshiseido.net/2014/02/10/shiseido-collagen-ex-dang-nuoc-uong/" style="box-sizing: border-box; color: rgb(45, 92, 136); text-decoration: none;" title="shiseido collagen ex dạng nước uống">&nbsp;</a>l&agrave; loại thực phẩm thẩm mỹ đ&atilde; được cấp bằng s&aacute;ng chế số 4917180&nbsp;về c&aacute;c loại h&oacute;a mỹ phẩm tại Nhật Bản.</li>\r\n	<li>\r\n	<h4>Th&agrave;nh phần dinh dưỡng c&oacute; trong 01 chai collagen shiseido ex 50 ml- mẫu mới (liều d&ugrave;ng/ ng&agrave;y.</h4>\r\n	</li>\r\n</ul>\r\n', '10-25-02-25-04-2016-1271768015453142124485945519590297989901866n.jpg', '10-25-02-25-04-2016-1271768015453142124485945519590297989901866n.jpg', 'a:1:{i:0;s:68:"10-25-02-25-04-2016-1271768015453142124485945519590297989901866n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461554702, NULL),
(57, NULL, 'Tảo lục chlorella Royal Nhật Bản', 600000, 0, 600000, 1, '', 2, '<p><span style="color:rgb(78, 82, 93)">Tảo Chlorella tự nhi&ecirc;n - loại tảo n&agrave;y v&ocirc; c&ugrave;ng qu&yacute; gi&aacute; c&oacute; chứa th&agrave;nh phần protein, vitamin, kho&aacute;ng chất, c&aacute;c axit amin cao d&agrave;nh cho người gầy muốn tăng c&acirc;n, l&agrave;m đẹp da, chống l&atilde;o h&oacute;a v&agrave; hỗ trợ điều trị c&aacute;c bệnh m&atilde;n t&iacute;nh.</span></p>\r\n', '<p><span style="color:rgb(78, 82, 93); font-family:arial,helvetica,sans-serif; font-size:small">Tảo Chlorella tự nhi&ecirc;n - loại tảo n&agrave;y v&ocirc; c&ugrave;ng qu&yacute; gi&aacute; c&oacute; chứa th&agrave;nh phần protein, vitamin, kho&aacute;ng chất, c&aacute;c axit amin cao d&agrave;nh cho người gầy muốn tăng c&acirc;n, l&agrave;m đẹp da, chống l&atilde;o h&oacute;a v&agrave; hỗ trợ điều trị c&aacute;c bệnh m&atilde;n t&iacute;nh.</span></p>\r\n\r\n<div class="prod-info" style="margin: 0px; padding: 0px 0px 10px; width: 1000px; float: left; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: rgb(204, 204, 204); text-align: justify; color: rgb(78, 82, 93); font-family: OpenSans-Regular, Tahoma, sans-serif; font-size: 13px; line-height: 18.2px;">\r\n<h4><span style="color:rgb(255, 102, 0); font-family:arial,helvetica,sans-serif; font-size:small">Hướng dẫn sử dụng tảo biển ho&agrave;ng gia Nhật Bản&nbsp;Chlorella Royal DX</span></h4>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:small">* &nbsp;Người lớn: Ng&agrave;y uống từ 20-30 vi&ecirc;n trước bữa ăn hoặc sau bữa ăn, chia l&agrave;m 2 lần uống</span></p>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:small">* &nbsp;Trẻ em: Uống 5-10 vi&ecirc;n / 1 ng&agrave;y, c&oacute; thể uống trước v&agrave; sau bữa ăn</span></p>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:small">* &nbsp;D&ugrave;ng cho người tăng c&acirc;n: C&aacute;c bạn uống sau ăn, ng&agrave;y từ 10-15 vi&ecirc;n, chia l&agrave;m 2 lần uống</span></p>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:small">* &nbsp;D&ugrave;ng cho người giảm b&eacute;o: C&aacute;c bạn n&ecirc;n d&ugrave;ng trước khi ăn, ng&agrave;y từ 10-15 vi&ecirc;n, chia l&agrave;m 2 lần uống</span></p>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:small">* &nbsp;D&ugrave;ng để chăm s&oacute;c sức khỏe th&igrave; ng&agrave;y c&aacute;c bạn uống từ 5-8 vi&ecirc;n, ng&agrave;y uống 2 lần</span></p>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:small">* &nbsp;Những người đang điều trị c&aacute;c bệnh m&atilde;n t&iacute;nh: ng&agrave;y 10-15 vi&ecirc;n / lần, chia l&agrave;m 3 lần uống / ng&agrave;y</span></p>\r\n</div>\r\n', '10-29-49-25-04-2016-127177601545314229115259168154803237178100n.jpg', '10-29-49-25-04-2016-127177601545314229115259168154803237178100n.jpg', 'a:1:{i:0;s:67:"10-29-49-25-04-2016-127177601545314229115259168154803237178100n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461554989, 1461556003),
(58, NULL, 'Sâm Thực phẩm chức năng hồng sâm củ khô 6 năm tuổi  ( loại 20 – 150 gr)', 0, 0, 0, 2, '', 2, '<p><strong>Hồng s&acirc;m củ kh&ocirc; 6 năm tuổi</strong><span style="background-color:rgb(255, 255, 255); color:rgb(17, 17, 17)">&nbsp;l&agrave; sản phẩm rất được ưa chuộng tại H&agrave;n Quốc. Chất lượng của nh&acirc;n s&acirc;m l&agrave;m hồng s&acirc;m thuộc loại tốt nhất hiện nay, được khai th&aacute;c trực tiếp từ H&agrave;n Quốc, nơi cho chất lượng nh&acirc;n s&acirc;m tốt nhất thế giới.</span></p>\r\n', '<p>Th&ocirc;ng tin sản phẩm :</p>\r\n\r\n<p>T&ecirc;n sản phẩm :&nbsp;<strong>Thực phẩm chức năng hồng s&acirc;m củ kh&ocirc; 6 năm tuổi &ndash; Korean red Ginseng Root</strong>&nbsp;( loại 75gr)</p>\r\n\r\n<p><strong>Được chứng nhận c&oacute; th&agrave;nh phần v&agrave; c&ocirc;ng dụng như sau :</strong></p>\r\n\r\n<p><a href="http://nhansamlinhchi.net.vn/wp-content/uploads/2014/12/123455.png" style="margin: 0px; padding: 0px; border: 0px; font-style: inherit; font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline; color: rgb(187, 126, 10);"><img alt="123455" height="552" src="http://nhansamlinhchi.net.vn/wp-content/uploads/2014/12/123455.png" width="977" /></a></p>\r\n', '10-36-57-25-04-2016-hong-sam-hop-thiec-600g.jpg', '10-36-57-25-04-2016-hong-sam-hop-thiec-600g.jpg', 'a:1:{i:0;s:47:"10-36-57-25-04-2016-hong-sam-hop-thiec-600g.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461555417, NULL),
(59, NULL, 'Cao Linh Chi Hàn Quốc ', 980000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Cao linh chi c&ocirc; đặc Gold hộp gỗ của H&agrave;n Quốc:100% nguy&ecirc;n chất lỏng chiết xuất từ nấm linh. Ho&agrave;n to&agrave;n kh&ocirc;ng c&oacute; chất độc hại v&agrave; phụ gia, an to&agrave;n khi sử dụng.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Cao linh chi c&ocirc; đặc Gold hộp gỗ của H&agrave;n Quốc:100% nguy&ecirc;n chất lỏng chiết xuất từ nấm linh. Ho&agrave;n to&agrave;n kh&ocirc;ng c&oacute; chất độc hại v&agrave; phụ gia, an to&agrave;n khi sử dụng.</span></p>\r\n\r\n<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Hộp 3 lọ * 120gr</span></p>\r\n\r\n<p><font color="#141823" face="helvetica, arial, sans-serif"><span style="font-size:14px; line-height:22.4px">Xuất xứ : H&agrave;n Quốc</span></font></p>\r\n', '10-42-07-25-04-2016-cao-linh-chi-co-tot-khong-2.jpg', '10-42-07-25-04-2016-cao-linh-chi-co-tot-khong-2.jpg', 'a:1:{i:0;s:51:"10-42-07-25-04-2016-cao-linh-chi-co-tot-khong-2.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461555727, NULL),
(60, NULL, 'Dầu cá Omega 3 Costar Úc', 750000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Dầu c&aacute; Omega 3 Costar &Uacute;c 1000mg 365 vi&ecirc;n</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Dầu c&aacute; Omega 3 Costar &Uacute;c 1000mg 365 vi&ecirc;n.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Ph&ograve;ng ngừa tim mạch, tăng cường thị lực</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">-Hỗ trợ tăng tr&iacute; nhớ, tăng khả năng tập trung.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">-Bổ sung h&agrave;m lượng DHA gi&uacute;p mắt tinh anh hơn, bảo vệ mắt tốt hơn.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">-Gi&uacute;p ngăn ngừa c&aacute;c nếp nhăn bằng việc duy tr&igrave; sản sinh ra sebum khỏe mạnh cho da v&igrave; thế ngăn ngừa qu&aacute; tr&igrave;nh l&atilde;o ho&aacute; da. Bổ sung dầu c&aacute; h&agrave;ng ng&agrave;y gi&uacute;p giảm bớt c&aacute;c triệu chứng của da kh&ocirc;, bong tr&oacute;c, ch&agrave;m , vi&ecirc;m da v&agrave; mụn.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Hộp 365 vi&ecirc;n uống 1v mỗi ng&agrave;y sau ăn.</span></p>\r\n', '10-45-35-25-04-2016-1438333465-31072015160425.jpg', '10-45-35-25-04-2016-1438333465-31072015160425.jpg', 'a:1:{i:0;s:49:"10-45-35-25-04-2016-1438333465-31072015160425.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461555935, NULL),
(61, NULL, 'Bio - Marine Collagen 4in1 Costar', 700000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Vi&ecirc;n Uống Bio - Marine Collagen 4in1 Costar của &Uacute;c gi&uacute;p tăng cường vẻ b&oacute;ng l&aacute;ng s&aacute;ng mịn cho l&agrave;n da ngay từ b&ecirc;n trong.</span><br />\r\n&nbsp;</p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Vi&ecirc;n Uống Bio - Marine Collagen 4in1 Costar của &Uacute;c gi&uacute;p tăng cường vẻ b&oacute;ng l&aacute;ng s&aacute;ng mịn cho l&agrave;n da ngay từ b&ecirc;n trong.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Gi&uacute;p trẻ h&oacute;a l&agrave;n da, tăng độ dẻo dai của l&agrave;n da, cho một d&aacute;ng vẻ v&agrave; cảm gi&aacute;c tươi trẻ, đầy sức sống. C&ocirc;ng thức n&agrave;y c&ograve;n gi&uacute;p bảo vệ chống oxy h&oacute;a cho c&aacute;c m&ocirc; tế b&agrave;o da, gi&uacute;p lưu giữ tuổi thanh xu&acirc;n cho l&agrave;n da.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Hộp 120v ng&agrave;y uống 1 đến 2 vi&ecirc;n tốt nhất trước bữa ăn khi đang đ&oacute;i để hấp thụ nhiều hơn.</span></p>\r\n', '10-47-53-25-04-2016-biomarinecollagen4in1costar1.jpg', '10-47-53-25-04-2016-biomarinecollagen4in1costar1.jpg', 'a:1:{i:0;s:52:"10-47-53-25-04-2016-biomarinecollagen4in1costar1.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461556073, NULL);
INSERT INTO `web_product` (`product_id`, `product_code`, `product_name`, `product_price_sell`, `product_price_market`, `product_price_input`, `product_type_price`, `product_selloff`, `product_is_hot`, `product_sort_desc`, `product_content`, `product_image`, `product_image_hover`, `product_image_other`, `product_order`, `category_id`, `category_name`, `quality_input`, `quality_out`, `product_status`, `is_block`, `user_shop_id`, `user_shop_name`, `is_shop`, `shop_province`, `time_created`, `time_update`) VALUES
(62, NULL, 'Thuốc bổ xương khớp BlackMores Glucosamine Sulfate 1500mg', 990000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">&nbsp;Thuốc bổ xương khớp BlackMores Glucosamine Sulfate 1500mg điều trị thuận tiện nhất với liều d&ugrave;ng 1 vi&ecirc;n /ng&agrave;y, gi&uacute;p l&agrave;m giảm vi&ecirc;m, sưng v&agrave; gi&uacute;p l&agrave;m giảm cơn đau do vi&ecirc;m xương khớp. Tạo chất nhờn, giảm hao m&ograve;n sụn.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Thuốc bổ xương khớp BlackMores Glucosamine Sulfate 1500mg điều trị thuận tiện nhất với liều d&ugrave;ng 1 vi&ecirc;n /ng&agrave;y, gi&uacute;p l&agrave;m giảm vi&ecirc;m, sưng v&agrave; gi&uacute;p l&agrave;m giảm cơn đau do vi&ecirc;m xương khớp. Tạo chất nhờn, giảm hao m&ograve;n sụn.</span></p>\r\n', '10-50-14-25-04-2016-glucosaminesulfate1500blackmorebx800x800x4.jpg', '10-50-14-25-04-2016-glucosaminesulfate1500blackmorebx800x800x4.jpg', 'a:1:{i:0;s:66:"10-50-14-25-04-2016-glucosaminesulfate1500blackmorebx800x800x4.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461556214, NULL),
(63, NULL, 'Bổ Mắt Bilberry Costar', 650000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Vi&ecirc;n Uống Bổ Mắt Bilberry Costar:</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Hỗ trợ chức năng v&agrave; thị lực cho mắt được khỏe mạnh, bảo vệ cấu tr&uacute;c của mắt, trị c&aacute;c chứng bệnh về mắt như : x&oacute;t mắt, nhức mắt, chảy nước mắt, mắt l&atilde;o h&oacute;a, mắt mờ.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Hộp 60v Uống 1 vi&ecirc;n 1 ng&agrave;y hoặc theo khuyến c&aacute;o của chuy&ecirc;n gia y tế.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px">Vi&ecirc;n Uống Bổ Mắt Bilberry Costar:</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px">Hỗ trợ chức năng v&agrave; thị lực cho mắt được khỏe mạnh, bảo vệ cấu tr&uacute;c của mắt, trị c&aacute;c chứng bệnh về mắt như : x&oacute;t mắt, nhức mắt, chảy nước mắt, mắt l&atilde;o h&oacute;a, mắt mờ.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px">Hộp 60v Uống 1 vi&ecirc;n 1 ng&agrave;y hoặc theo khuyến c&aacute;o của chuy&ecirc;n gia y tế.</span></p>\r\n', '10-52-37-25-04-2016-img8342.jpg', '10-52-37-25-04-2016-img8342.jpg', 'a:1:{i:0;s:31:"10-52-37-25-04-2016-img8342.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461556357, NULL),
(64, NULL, 'Liver Detox costar', 750000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Liver Detox costar hỗ trợ chức năng gan, lọc v&agrave; đ&agrave;o thải độc tố, hỗ trợ điều trị gan nhiễm mỡ, men gan cao ,người c&oacute; chức năng gan k&eacute;m hay mẩn ngứa nổi mề đay, thường xuy&ecirc;n tiếp x&uacute;c với rượu bia.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Hộp 100v uống 1 vi&ecirc;n h&agrave;ng ng&agrave;y, trước bữa ăn.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Liver Detox costar hỗ trợ chức năng gan, lọc v&agrave; đ&agrave;o thải độc tố, hỗ trợ điều trị gan nhiễm mỡ, men gan cao ,người c&oacute; chức năng gan k&eacute;m hay mẩn ngứa nổi mề đay, thường xuy&ecirc;n tiếp x&uacute;c với rượu bia.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Hộp 100v uống 1 vi&ecirc;n h&agrave;ng ng&agrave;y, trước bữa ăn.</span></p>\r\n', '11-00-22-25-04-2016-img8343.jpg', '11-00-22-25-04-2016-img8343.jpg', 'a:1:{i:0;s:31:"11-00-22-25-04-2016-img8343.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461556822, NULL),
(65, NULL, 'Nhau thai cừu Costar Sheep Placenta 15000mg', 850000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Nhau thai cừu Costar Sheep Placenta 15000mg l&agrave; sự kết hợp t&agrave;i t&igrave;nh giữ nhau thai cừu v&agrave; c&aacute;c th&agrave;nh phần thảo dược, dược liệu tốt nhất đem đến khả năng &lsquo;nẩy mầm da&rsquo; tăng cường sự miễn dịch v&agrave; x&oacute;a đi c&aacute;c vết th&acirc;m n&aacute;m hiệu quả.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Hộp 100v ng&agrave;y uống 1-2v l&uacute;c đ&oacute;i.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Nhau thai cừu Costar Sheep Placenta 15000mg l&agrave; sự kết hợp t&agrave;i t&igrave;nh giữ nhau thai cừu v&agrave; c&aacute;c th&agrave;nh phần thảo dược, dược liệu tốt nhất đem đến khả năng &lsquo;nẩy mầm da&rsquo; tăng cường sự miễn dịch v&agrave; x&oacute;a đi c&aacute;c vết th&acirc;m n&aacute;m hiệu quả.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Hộp 100v ng&agrave;y uống 1-2v l&uacute;c đ&oacute;i.</span></p>\r\n', '11-02-51-25-04-2016-nhau-thai-cuu-15000mg.jpg', '11-02-51-25-04-2016-nhau-thai-cuu-15000mg.jpg', 'a:1:{i:0;s:45:"11-02-51-25-04-2016-nhau-thai-cuu-15000mg.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461556971, NULL),
(66, NULL, 'Placentra Gold Plus 50000mg Của Costar Úc', 950000, 0, 950000, 1, '', 2, '<p>Nhau Thai Cừu Chống L&atilde;o H&oacute;a Trị N&aacute;m T&agrave;n Nhang</p>\r\n\r\n<p>Placentra Gold Plus 50000mg Của Costar Australia&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n', '<p>Nhau Thai Cừu H&agrave;m Lượng 50000mg Trị N&aacute;m, T&agrave;n Nhang V&agrave; L&agrave;m Trắng Da của &Uacute;c:</p>\r\n\r\n<p>Vi&ecirc;n&nbsp;nhau thai cừu Essence of baby sheep&nbsp;Placentra Gold Plus 50000mg&nbsp;c&oacute; t&aacute;c dụng đặc biệt trong việc loại bỏ n&aacute;m v&agrave; vết th&acirc;m, đ&oacute;ng vai tr&ograve; rất quan trọng trong việc t&aacute;i tạo hồng cầu trong m&aacute;u, cung cấp năng lượng v&agrave; những chất dinh dưỡng cho cơ thể, l&agrave;m đẹp v&agrave; trẻ h&oacute;a da mặt v&agrave; giữ cơ thể&nbsp;lu&ocirc;n c&acirc;n đối.</p>\r\n', '04-05-34-25-04-2016-vien-uong-nhau-thai-50000-mg-costar-essence-of-baby-sheep-placentra-gold-plusvien-uong-costar-placentra-50000mg.png', '04-05-34-25-04-2016-vien-uong-nhau-thai-50000-mg-costar-essence-of-baby-sheep-placentra-gold-plusvien-uong-costar-placentra-50000mg.png', 'a:1:{i:0;s:135:"04-05-34-25-04-2016-vien-uong-nhau-thai-50000-mg-costar-essence-of-baby-sheep-placentra-gold-plusvien-uong-costar-placentra-50000mg.png";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461557078, 1461575145),
(67, NULL, 'Vitamin bà bầu Blackmores', 1000000, 0, 0, 1, '', 2, '<p>Cung cấp Vitamin cho b&agrave; bầu.</p>\r\n', '<p><span style="background-color:rgb(240, 240, 240); color:rgb(20, 20, 20); font-family:tahoma,verdana,geneva,sans-serif; font-size:16px">T&Iacute;NH NĂNG V&Agrave; C&Ocirc;NG DỤNG:</span><br />\r\n<br />\r\n<span style="background-color:rgb(240, 240, 240); color:rgb(20, 20, 20); font-family:tahoma,verdana,geneva,sans-serif; font-size:16px">Cung c&acirc;́p 20 dưỡng ch&acirc;́t quan trọng c&acirc;̀n cho bà b&acirc;̀u trong li&ecirc;̀u dùng hàng ngày g&ocirc;̀m có:</span><br />\r\n<br />\r\n<span style="background-color:rgb(240, 240, 240); color:rgb(20, 20, 20); font-family:tahoma,verdana,geneva,sans-serif; font-size:16px">&bull; Sắt (dạng ít táo bón)</span><br />\r\n<span style="background-color:rgb(240, 240, 240); color:rgb(20, 20, 20); font-family:tahoma,verdana,geneva,sans-serif; font-size:16px">&bull; 1000 IU of vitamin D3</span><br />\r\n<span style="background-color:rgb(240, 240, 240); color:rgb(20, 20, 20); font-family:tahoma,verdana,geneva,sans-serif; font-size:16px">&bull; 500 &micro;g axit folic c&acirc;̀n thi&ecirc;́n dùng trước sinh ít nh&acirc;́t 1 tháng và trong quá trình mang thai nhằm giảm nguy cơ trẻ bị khuy&ecirc;́t t&acirc;̣t não/ nứt c&ocirc;̣t s&ocirc;́ng.</span><br />\r\n<span style="background-color:rgb(240, 240, 240); color:rgb(20, 20, 20); font-family:tahoma,verdana,geneva,sans-serif; font-size:16px">&bull; 150 &micro;g iot cần thiết cho sự ph&aacute;t triển b&igrave;nh thường của n&atilde;o trẻ, kỹ năng v&acirc;̣n đ&ocirc;̣ng li&ecirc;n quan đ&ecirc;́n thị giác v&agrave; d&acirc;̀u cá c&ocirc; đặc và kh&ocirc;ng mùi, giàu DHA c&acirc;̀n thi&ecirc;́t cho sự phát ti&ecirc;̉n bình thường của não trẻ, khả năng nhìn và h&ecirc;̣ th&ocirc;́ng th&acirc;̀n kinh, cải ti&ecirc;́n hơn- Vi&ecirc;n nhỏ cải ti&ecirc;́n hơn</span><br />\r\n<span style="background-color:rgb(240, 240, 240); color:rgb(20, 20, 20); font-family:tahoma,verdana,geneva,sans-serif; font-size:16px">&bull; Hỗ trợ dinh dưỡng tổng hợp cho b&eacute; với 17 chất dinh dưỡng gồm 10 vitamin, 6 chất kho&aacute;ng v&agrave; c&aacute;c ax&iacute;t b&eacute;o omega-3.</span><br />\r\n<br />\r\n<span style="background-color:rgb(240, 240, 240); color:rgb(20, 20, 20); font-family:tahoma,verdana,geneva,sans-serif; font-size:16px">Blackmores thường xuy&ecirc;n thử nghiệm những hoạt t&iacute;nh của dầu c&aacute; ngừ để đảm bảo rằng bạn c&oacute; thể ho&agrave;n to&agrave;n y&ecirc;n t&acirc;m khi uống thuốc của Blackmores.</span></p>\r\n', '11-09-59-25-04-2016-glucosaminesulfate1500blackmorebx800x800x4.jpg', '11-09-59-25-04-2016-glucosaminesulfate1500blackmorebx800x800x4.jpg', 'a:1:{i:0;s:66:"11-09-59-25-04-2016-glucosaminesulfate1500blackmorebx800x800x4.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461557383, NULL),
(68, NULL, 'Sụn Vi Cá Mập Costar Úc', 900000, 0, 0, 1, '', 1, '<p><strong><span style="color:rgb(255, 0, 0)"><u>- C&ocirc;ng dụng Sụn Vi C&aacute; Mập Costar &Uacute;c:</u></span><span style="color:rgb(255, 0, 0)"><u>Chữa trị c&aacute;c bệnh về xương khớp:</u></span>- Hỗ trợ phục hồi v&agrave; bảo dưỡng chất nhờn b&ocirc;i trơn khớp v&agrave; c&aacute;c m&ocirc; khớp, chống l&atilde;o h&oacute;a xương.- Hỗ trợ gi&uacute;p l&agrave;m l&agrave;nh c&aacute;c khớp bị tổn thương do vận động. Chống vi&ecirc;m nhiễm, gi&uacute;p l&agrave;m hết c&aacute;c triệu chứng của vi&ecirc;m xương khớp- Sử dụng để ph&ograve;ng ngừa v&agrave; điều trị c&aacute;c bệnh tho&aacute;i h&oacute;a khớp- Gi&uacute;p ổn định c&aacute;c bệnh vi&ecirc;m nhiễm da như bệnh vẩy nến v&agrave; eczema<br />\r\n<span style="color:rgb(255, 0, 0)"><u>- Chữa c&aacute;c bệnh về mắt:</u></span>Chondroitin tạo độ ẩm th&iacute;ch hợp cho mắt, gi&uacute;p mắt điều tiết tốt. N&oacute; cũng nu&ocirc;i dưỡng c&aacute;c tế b&agrave;o gi&aacute;c mạc, t&aacute;i tạo lớp phim nước mắt trước gi&aacute;c mạc, tăng cường t&iacute;nh đ&agrave;n hồi của thấu k&iacute;nh thể mi. Chất n&agrave;y c&ograve;n hạn chế sự kh&ocirc; mắt, mỏi mắt, hoa mắt khi mắt phải l&agrave;m việc nhiều.<br />\r\n<span style="color:rgb(255, 0, 0)"><u>- Bồi bổ cơ thể:</u></span>Cung cấp c&aacute;c chất: calci, phostpho, kẽm... c&oacute; c&ocirc;ng dụng th&uacute;c đẩy sự ph&aacute;t triển của: xương, răng, c&aacute;c enzym ti&ecirc;u h&oacute;a v&agrave; hoạt động của thận v&agrave; tiền liệt tuyến.</strong></p>\r\n', '<p><strong><span style="color:rgb(51, 51, 51)"><span style="font-family:helvetica"><span style="color:rgb(255, 0, 0)"><u>- C&ocirc;ng dụng Sụn Vi C&aacute; Mập Costar &Uacute;c:</u></span><span style="color:rgb(255, 0, 0)"><u>Chữa trị c&aacute;c bệnh về xương khớp:</u></span>- Hỗ trợ phục hồi v&agrave; bảo dưỡng chất nhờn b&ocirc;i trơn khớp v&agrave; c&aacute;c m&ocirc; khớp, chống l&atilde;o h&oacute;a xương.- Hỗ trợ gi&uacute;p l&agrave;m l&agrave;nh c&aacute;c khớp bị tổn thương do vận động. Chống vi&ecirc;m nhiễm, gi&uacute;p l&agrave;m hết c&aacute;c triệu chứng của vi&ecirc;m xương khớp- Sử dụng để ph&ograve;ng ngừa v&agrave; điều trị c&aacute;c bệnh tho&aacute;i h&oacute;a khớp- Gi&uacute;p ổn định c&aacute;c bệnh vi&ecirc;m nhiễm da như bệnh vẩy nến v&agrave; eczema</span></span><br />\r\n<span style="color:rgb(51, 51, 51)"><span style="font-family:helvetica"><span style="color:rgb(255, 0, 0)"><u>- Chữa c&aacute;c bệnh về mắt:</u></span>Chondroitin tạo độ ẩm th&iacute;ch hợp cho mắt, gi&uacute;p mắt điều tiết tốt. N&oacute; cũng nu&ocirc;i dưỡng c&aacute;c tế b&agrave;o gi&aacute;c mạc, t&aacute;i tạo lớp phim nước mắt trước gi&aacute;c mạc, tăng cường t&iacute;nh đ&agrave;n hồi của thấu k&iacute;nh thể mi. Chất n&agrave;y c&ograve;n hạn chế sự kh&ocirc; mắt, mỏi mắt, hoa mắt khi mắt phải l&agrave;m việc nhiều.</span></span><br />\r\n<span style="color:rgb(51, 51, 51)"><span style="font-family:helvetica"><span style="color:rgb(255, 0, 0)"><u>- Bồi bổ cơ thể:</u></span>Cung cấp c&aacute;c chất: calci, phostpho, kẽm... c&oacute; c&ocirc;ng dụng th&uacute;c đẩy sự ph&aacute;t triển của: xương, răng, c&aacute;c enzym ti&ecirc;u h&oacute;a v&agrave; hoạt động của thận v&agrave; tiền liệt tuyến.</span></span><br />\r\n<span style="color:rgb(51, 51, 51)"><span style="font-family:helvetica"><span style="color:rgb(255, 0, 0)"><u>- Hướng dẫn sử dụng Sụn Vi C&aacute; Mập:</u></span>Uống 3-6 vi&ecirc;n chia 1-2 lần/ng&agrave;y sau mỗi bữa ăn</span></span><br />\r\n<span style="color:rgb(51, 51, 51)"><span style="font-family:helvetica"><span style="color:rgb(255, 0, 0)"><u>- C&aacute;ch bảo quản:</u></span>Để nơi kh&ocirc; r&aacute;o, tho&aacute;ng m&aacute;t. Tr&aacute;nh xa tầm tay trẻ em.</span></span><br />\r\n<span style="color:rgb(51, 51, 51)"><span style="font-family:helvetica"><span style="color:rgb(255, 0, 0)"><u>- Lưu &yacute;:</u></span>- Kh&ocirc;ng d&ugrave;ng qu&aacute; liều chỉ định- Phụ nữ mang thai v&agrave; đang cho con b&uacute;, trẻ em dưới 18 tuổi, người đang điều trị với thuốc n&ecirc;n tham khảo &yacute; kiến b&aacute;c sĩ trước khi dung- Đọc kỹ hướng dẫn sử dụng trước khi d&ugrave;ng</span></span></strong></p>\r\n', '11-15-38-25-04-2016-muathuoctot.com140479780384029115.jpg', '11-15-38-25-04-2016-muathuoctot.com140479780384029115.jpg', 'a:1:{i:0;s:57:"11-15-38-25-04-2016-muathuoctot.com140479780384029115.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461557738, NULL),
(69, NULL, 'Bổ gan giải độc Hàn Quốc', 550000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">- Nước bổ gan giải độc H&agrave;n Quốc bồi bổ cơ thể, thanh nhiệt giải độc cơ thể, đ&agrave;o thải c&aacute;c chất độc hại trong m&aacute;u, bổ gan, tăng cường chức năng gan, giải rượu, ph&ograve;ng chống ngộ độc rượu.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Nước bổ gan giải độc H&agrave;n Quốc bồi bổ cơ thể, thanh nhiệt giải độc cơ thể, đ&agrave;o thải c&aacute;c chất độc hại trong m&aacute;u, bổ gan, tăng cường chức năng gan, giải rượu, ph&ograve;ng chống ngộ độc rượu.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Thể t&iacute;ch: 70mlx30 t&uacute;i</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Th&agrave;nh phần: chiết xuất từ 100% nguy&ecirc;n liệu thi&ecirc;n nhi&ecirc;n.</span></p>\r\n', '11-24-03-25-04-2016-nuoc-bo-gan-giai-doc-hovenia-dulcis-han-quoc.jpg', '11-24-03-25-04-2016-nuoc-bo-gan-giai-doc-hovenia-dulcis-han-quoc.jpg', 'a:1:{i:0;s:68:"11-24-03-25-04-2016-nuoc-bo-gan-giai-doc-hovenia-dulcis-han-quoc.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461558223, NULL),
(70, NULL, 'Spring Leaf Shark Cartilage 750mg', 950000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Spring Leaf Shark Cartilage vi&ecirc;n nang cung cấp cứu trợ tạm thời đau vi&ecirc;m khớp. N&oacute; cũng c&oacute; thể gi&uacute;p giảm vi&ecirc;m khớp li&ecirc;n quan với vi&ecirc;m khớp. </span></p>\r\n\r\n<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Th&agrave;nh phần hoạt động mỗi Capsule: Mỗi vi&ecirc;n nang chứa bột sụn c&aacute; mập thi&ecirc;n nhi&ecirc;n 750 mg.</span></p>\r\n\r\n<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Liều d&ugrave;ng / Hướng: Người lớn uống mỗi ng&agrave;y 1-3 vi&ecirc;n trước bữa ăn, hoặc theo chỉ dẫn của chuy&ecirc;n gia y tế của bạn.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,lucida grande,sans-serif; font-size:13px">Spring Leaf Shark Cartilage vi&ecirc;n nang cung cấp cứu trợ tạm thời đau vi&ecirc;m khớp. N&oacute; cũng c&oacute; thể gi&uacute;p giảm vi&ecirc;m khớp li&ecirc;n quan với vi&ecirc;m khớp.</span></p>\r\n\r\n<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,lucida grande,sans-serif; font-size:13px">Th&agrave;nh phần hoạt động mỗi Capsule: Mỗi vi&ecirc;n nang chứa bột sụn c&aacute; mập thi&ecirc;n nhi&ecirc;n 750 mg. </span></p>\r\n\r\n<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,lucida grande,sans-serif; font-size:13px">Liều d&ugrave;ng / Hướng: Người lớn uống mỗi ng&agrave;y 1-3 vi&ecirc;n trước bữa ăn, hoặc theo chỉ dẫn của chuy&ecirc;n gia y tế của bạn.</span></p>\r\n', '11-25-47-25-04-2016-img8350.jpg', '11-25-47-25-04-2016-img8350.jpg', 'a:1:{i:0;s:31:"11-25-47-25-04-2016-img8350.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461558347, NULL),
(71, NULL, ' Viên uống bổ khớp Glucosamine 1500mg Costar', 1500000, 0, 0, 1, '', 2, '<p><strong>&nbsp;Vi&ecirc;n uống bổ khớp Glucosamine 1500mg Costar</strong></p>\r\n\r\n<p><span style="color:rgb(0, 0, 205)"><strong>H&atilde;ng sản xuất:</strong></span>&nbsp;<strong>Costar &Uacute;c</strong></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Thuốc hỗ trợ khớp Glucosamine 1500mg HCL Costar - &Uacute;c</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Giảm đau vi&ecirc;m khớp</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Giảm sưng / ph&ugrave; nề do vi&ecirc;m khớp</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Gi&uacute;p tăng cường sự vận động của khớp.</span></p>\r\n\r\n<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Hộp 365 vi&ecirc;n uống 1v/ng&agrave;y</span></p>\r\n', '12-10-58-25-04-2016-img8354.jpg', '12-10-58-25-04-2016-img8354.jpg', 'a:1:{i:0;s:31:"12-10-58-25-04-2016-img8354.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461561058, NULL),
(72, NULL, 'Glucosamine Orihiro 1500mg của Nhật', 800000, 0, 0, 1, '', 2, '<p><strong>Vi&ecirc;n uống bổ sương khớp Glucosamin thương hiệu Orihiro từ Nhật Bản</strong>&nbsp;với th&agrave;nh phần được chiết xuất trực tiếp từ t&ocirc;m, cua biển, c&oacute; bổ sung th&ecirc;m&nbsp;<strong>Chondroitine &amp; MSM</strong>&nbsp;c&oacute; trong sụn vi c&aacute; mập c&ocirc;ng dụng l&agrave;m chậm qu&aacute; tr&igrave;nh l&atilde;o h&oacute;a của sụn khớp, tăng cương v&agrave; t&aacute;i tạo sụn khớp, giảm đau cho người bệnh xương khớp, tăng chất nhờn trong c&aacute;c khớp &hellip;</p>\r\n\r\n<p>Nh&agrave; sản xuất:&nbsp;<strong>Orihiro, Nhật Bản</strong></p>\r\n\r\n<p>Quy c&aacute;ch: dạng vi&ecirc;n, hộp 900 vi&ecirc;n n&eacute;n</p>\r\n', '<h2>Giới thiệu vi&ecirc;n uống Glucosamin&nbsp;Orihiro 1500mg của Nhật Bản</h2>\r\n\r\n<p><a href="http://healthmart.vn/product/glucosamine-orihiro-1500mg-cua-nhat" style="box-sizing: border-box; color: rgb(45, 92, 136); text-decoration: none;" title="Viên uống Glucosamin Orihiro 1500mg của Nhật ">Vi&ecirc;n uống Glucosamin Orihiro 1500mg của Nhật</a>&nbsp;gi&uacute;p ngăn chứng bệnh tho&aacute;i h&oacute;a khớp một c&aacute;ch c&oacute; kết quả tốt với những th&agrave;nh phần ch&iacute;nh được b&agrave;o chế từ vỏ lo&agrave;i gi&aacute;p x&aacute;c như t&ocirc;m biển, cua biển, c&oacute; bổ sung chất Chondroitin &amp; MSM tinh chế từ sụn vi c&aacute; mập.</p>\r\n\r\n<h3>Th&agrave;nh phần chứa trong vi&ecirc;n uống Glucosamine Orihiro 1500mg như sau</h3>\r\n\r\n<ul>\r\n	<li>Chiết xuất từ ​​sụn vi c&aacute; mập (chứa chondroitin) &ndash; 100mg</li>\r\n	<li>L&ecirc;n men collagen thủy ph&acirc;n &ndash; 100mg</li>\r\n	<li>Chiết xuất mầm đậu n&agrave;nh &ndash; 6mg</li>\r\n	<li>Đậu n&agrave;nh isoflavone aglycone &middot;&middot;&middot; 1.6mg</li>\r\n	<li>Thấp trọng lượng ph&acirc;n tử acid hyaluronic &middot;&middot;&middot; 1mg</li>\r\n	<li>Chiết xuất từ ​​sụn g&agrave; (collagen tu&yacute;p II) &ndash; 10mg</li>\r\n</ul>\r\n\r\n<p>C&ocirc;ng dụng của vi&ecirc;n uống Glucosamine Orihiro 1500mg như sau:</p>\r\n\r\n<ul>\r\n	<li><u>Vi&ecirc;n uống Glucosamine Orihiro 1500mg</u>&nbsp;gi&uacute;p bổ sung glucosamine cho sụn khớp, tăng cường v&agrave; t&aacute;i tạo sụn, l&agrave;m giảm qu&aacute; tr&igrave;nh ph&aacute; hủy sụn khớp sau tuổi 40.</li>\r\n	<li>Bổ sung v&agrave; tăng cường lượng canci để nu&ocirc;i dưỡng sụn khớp, cải thiện khả năng hấp thụ canxi của sụn khớp</li>\r\n	<li>Glucosamin Orihiro gi&uacute;p bổ sung chất nhờn cho khớp, l&agrave;m gia tăng độ nhờn v&agrave; c&aacute;c hoạt dịch ở c&aacute;c khớp</li>\r\n	<li>Sản phẩm c&ograve;n c&oacute; c&ocirc;ng dụng l&agrave;m giảm một phần hoặc cắt hẳn c&aacute;c cơn đau ở khớp đối với những bệnh nh&acirc;n bệnh khớp m&atilde;n t&iacute;nh.</li>\r\n	<li>\r\n	<h3>Chỉ định sử dụng vi&ecirc;n uống Glucosamine Orihiro 1500mg như sau:</h3>\r\n	</li>\r\n	<li>C&oacute; thể sử dụng vi&ecirc;n uống Glucosamin trong mọi thể của bệnh tho&aacute;i ho&aacute; xương khớp, vi&ecirc;m khớp</li>\r\n	<li>Hư xương khớp: Hư đốt sống cổ, hư khớp h&aacute;ng, vi&ecirc;m khớp b&aacute;n cấp v&agrave; m&atilde;n t&iacute;nh;</li>\r\n	<li>Lo&atilde;ng xương;</li>\r\n	<li>Chấn thương thể thao li&ecirc;n quan đến g&acirc;n, sụn, d&acirc;y chằng;</li>\r\n	<li>Bệnh gout</li>\r\n</ul>\r\n\r\n<h4>Hướng dẫn sử dụng, liều d&ugrave;ng</h4>\r\n\r\n<ul>\r\n	<li>Ng&agrave;y 10 vi&ecirc;n chia 2 lần, uống sau khi ăn.</li>\r\n	<li>T&aacute;c dụng phụ: t&aacute;c dụng phụ của glucosamine rất hiếm gặp, rất hiếm khi bị rối loạn đường ti&ecirc;u h&oacute;a như ợ n&oacute;ng, kh&oacute; chịu v&ugrave;ng thượng vị. (Những người dị ứng với t&ocirc;m- cua biển cũng n&ecirc;n thận trọng khi tin tưởng thường xuy&ecirc;n thường xuy&ecirc;n d&ugrave;ng)</li>\r\n</ul>\r\n', '12-18-47-25-04-2016-glucosamine-orihiro-900-vien-nhat-ban-1.jpg', '12-18-47-25-04-2016-glucosamine-orihiro-900-vien-nhat-ban-1.jpg', 'a:1:{i:0;s:63:"12-18-47-25-04-2016-glucosamine-orihiro-900-vien-nhat-ban-1.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461561337, NULL),
(74, NULL, 'Thuốc bổ não. tăng cường trí nhớ - DHA & EPA Orihiro', 0, 0, 0, 2, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">DHA giữ vai tr&ograve; cực kỳ quan trọng trong qu&aacute; tr&igrave;nh ph&aacute;t triển của thai nhi, sơ sinh v&agrave; cả ở tuổi gi&agrave;. H&agrave;m lượng DHA trong n&atilde;o tăng 300 dến 500% ở n&atilde;o trẻ trong 3 th&aacute;ng cuối thời kỳ thai ngh&eacute;n. Bổ sung DHA cho c&aacute;c b&agrave; mẹ đang mang thai đem lại lợi &iacute;ch cho sự ph&aacute;t triển của n&atilde;o thai nhi, tăng chỉ số IQ ph&aacute;</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">t triển n&atilde;o bộ n&atilde;o v&agrave; chức năng thị gi&aacute;c của thai nhi (mang thai c&aacute;c b&agrave; mẹ chuyển DHA trực tiếp đến thai nhi để hỗ trợ ph&aacute;t triển n&atilde;o nhanh ch&oacute;ng v&agrave; v&otilde;ng mạc. DHA được cung cấp cho trẻ sơ sinh qua sữa mẹ).</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Thuốc bổ n&atilde;o. tăng cường tr&iacute; nhớ - DHA &amp; EPA Orihiro</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Sản xuất : Nhật</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Đ&ocirc;i đi&ecirc;̀u v&ecirc;̀ DHA</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">T&aacute;c dụng: DHA giữ vai tr&ograve; cực kỳ quan trọng trong qu&aacute; tr&igrave;nh ph&aacute;t triển của thai nhi, sơ sinh v&agrave; cả ở tuổi gi&agrave;. H&agrave;m lượng DHA trong n&atilde;o tăng 300 dến 500% ở n&atilde;o trẻ trong 3 th&aacute;ng cuối thời kỳ thai ngh&eacute;n. Bổ sung DHA cho c&aacute;c b&agrave; mẹ đang mang thai đem lại lợi &iacute;ch cho sự ph&aacute;t triển của n&atilde;o thai nhi, tăng chỉ số IQ ph&aacute;</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">t triển n&atilde;o bộ n&atilde;o v&agrave; chức năng thị gi&aacute;c của thai nhi (mang thai c&aacute;c b&agrave; mẹ chuyển DHA trực tiếp đến thai nhi để hỗ trợ ph&aacute;t triển n&atilde;o nhanh ch&oacute;ng v&agrave; v&otilde;ng mạc. DHA được cung cấp cho trẻ sơ sinh qua sữa mẹ).<br />\r\n. -N&atilde;o v&agrave; v&otilde;ng mạc mắt l&agrave; 2 cơ quan đ&ograve;i hỏi h&agrave;m lượng DHA cao nhất để duy tr&igrave; c&aacute;c hoạt động thần kinh (như khả năng học tập v&agrave; ph&aacute;t triển tr&iacute; tuệ)v&agrave; sư tinh tường, nhanh nhạy ở cả người trẻ v&agrave; người gi&agrave;. DHA l&agrave; cơ sở hạ tầng của m&ocirc; n&atilde;o v&agrave; v&otilde;ng mạc mắt. N&oacute; gi&uacute;p t&aacute;i tạo c&aacute;c chất dẫn truyền thần kinh như phosphatidylserine giữ vai tr&ograve; quan trọng trong chức năng của n&atilde;o. DHA v&agrave; EPA b&igrave;nh thường kh&ocirc;ng c&oacute; trong nguồn thực phẩm gi&agrave;u ALA (a-linoleic acid) như dầu canola v&agrave; quả hạch. C&aacute;c nh&agrave; khoa học khuyến c&aacute;o rằng trong thời kỳ mang thai v&agrave; cho con b&uacute; lượng DHA được cung cấp chỉ đ&aacute;p ứng được 20% nhu cầu DHA cho cả mẹ v&agrave; con (300mg/ng&agrave;y). Lượng DHA cung cấp cho trẻ nhỏ l&agrave; cực kỳ thấp l&agrave; một vấn đề đang đặc biệt được quan t&acirc;m (trung b&igrave;nh 19mg/ng&agrave;y cho trẻ 3 tuổi ở Bắc Mỹ). Nh&igrave;n chung,nhu cầu ng&agrave;y c&agrave;ng tăng của cộng đồng về c&aacute;c sản phẩm của c&aacute; v&agrave; c&aacute;c thực phẩm chức năng c&oacute; chứa DHA&nbsp;<br />\r\nThực phẩm chức năng gi&uacute;p bổ n&atilde;o orihiro của Nhật<br />\r\nThuốc bổ n&atilde;o dha của nhật hộp 90 vi&ecirc;n Orihiro DHA 525 l&agrave; sản phẩm tăng cường sức khỏe - tr&iacute; n&atilde;o của Nhật Bản, với c&ocirc;ng thức DHA chiếm tới 70% , bổ sung nguồn DHA cao cho đối tượng l&agrave; người lao động vất vả, thức đ&ecirc;m, l&agrave;m việc tr&iacute; &oacute;c, sức khỏe sa s&uacute;t, đầu &oacute;c mệt mỏi, ăn uống thiếu chất đặc biệt l&agrave; thức ăn từ c&aacute;c loại c&aacute;&hellip; vi&ecirc;n thuốc uống bổ n&atilde;o dha Orihiro của Nhật cũng l&agrave; sản phẩm thay thế th&iacute;ch hợp để cho những ai đ&atilde; từng sử dụng c&aacute;c loại sản phẩm DHA &amp; EPA kh&aacute;c với h&agrave;m lượng lớn, với gi&aacute; th&agrave;nh rẻ hơn v&agrave; với mục đ&iacute;ch duy tr&igrave; lượng DHA &amp; EPA cần thiết cho cơ thể khỏe mạnh.<br />\r\n<br />\r\nDHA l&agrave; g&igrave;<br />\r\nDHA l&agrave; acid b&eacute;o kh&ocirc;ng no cần thiết, c&oacute; t&ecirc;n gọi đầy đủ l&agrave; DocosaHexaenoicAacid m&agrave; cơ thể con người kh&ocirc;ng tự tổng hợp được.<br />\r\nDHA cần thiết cho ph&aacute;t triển ho&agrave;n thiện chức năng nh&igrave;n của mắt, sự ph&aacute;t triển ho&agrave;n hảo hệ thần kinh. Ở người trưởng th&agrave;nh, DHA c&oacute; t&aacute;c dụng giảm cholesterol to&agrave;n phần, triglyceride m&aacute;u, LDL-cholesterol (cholesterol xấu) g&acirc;y vữa xơ động mạnh - căn nguy&ecirc;n bệnh nhồi m&aacute;u cơ tim.<br />\r\nNếu thiếu DHA trong qu&aacute; tr&igrave;nh ph&aacute;t triển, trẻ sẽ c&oacute; chỉ số th&ocirc;ng minh IQ thấp. DHA c&oacute; nhiều trong dầu c&aacute;, c&aacute; v&agrave; thủy sản.<br />\r\n<br />\r\nC&ocirc;ng dụng của thuốc bổ n&atilde;o dha 525mg hộp 90 vi&ecirc;n<br />\r\nThuốc bổ n&atilde;o dha của nhật hộp 90 vi&ecirc;n rất hiệu quả trong việc bổ sung DHA &amp; EPA cho những người l&agrave;m việc tr&iacute; &oacute;c với cường độ mạnh, những người thức đ&ecirc;m, ăn uống thiếu chất, những người lao động vất vả. Thực phẩm chức năng gi&uacute;p bổ n&atilde;o orihiro của Nhật c&oacute; hiệu quả l&agrave;m tăng cường tr&iacute; nhớ cho học sinh trong học tập.Gi&uacute;p s&aacute;ng mắt,nh&igrave;n r&otilde; hơn nếu được cung cấp DHA đầy đủ<br />\r\nVi&ecirc;n uống bổ n&atilde;o DHA 525mg hộp 90 vi&ecirc;n c&ograve;n được d&ugrave;ng như một loại thuốc điều trị bệnh tiền đ&igrave;nh hiệu quả do c&oacute; chứa th&agrave;nh phần DHA h&agrave;m lượng cao, thuốc bổ n&atilde;o dha 525mg lọ 90 vi&ecirc;n đ&oacute;ng vai tr&ograve; như một loại thuốc chữa rối loạn tiền đ&igrave;nh dưỡng n&atilde;o. N&oacute; c&ograve;n được d&ugrave;ng l&agrave;m thuốc bổ n&atilde;o tăng tr&iacute; nhớ d&agrave;nh cho người gi&agrave; rất hiệu quả.<br />\r\n<br />\r\nHướng dẫn sử dụng:<br />\r\nTrẻ em ng&agrave;y d&ugrave;ng 1 vi&ecirc;n / ng&agrave;y<br />\r\nNgười lớn 3 vi&ecirc;n/ ng&agrave;y.</span></p>\r\n', '12-25-03-25-04-2016-12791042119990167003496697340983155302227n.jpg', '12-25-03-25-04-2016-12791042119990167003496697340983155302227n.jpg', 'a:1:{i:0;s:66:"12-25-03-25-04-2016-12791042119990167003496697340983155302227n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461561792, NULL),
(76, NULL, 'Sữa tươi Devondale Úc túi 1kg', 410000, 0, 410000, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255)">Sữa tươi dạng bột Devondale (nguy&ecirc;n kem) (1kg) sản xuất tại &Uacute;c v&ocirc; c&ugrave;ng nổi tiếng tr&ecirc;n thế giới bởi h&agrave;m lượng canxi v&agrave; c&aacute;c chất dinh dưỡng rất cao gi&uacute;p b&eacute; l&ecirc;n c&acirc;n v&agrave; ph&aacute;t triển chiều cao c&acirc;n đối. Đặc biệt, sữa thơm ngon v&agrave; b&eacute;o ngậy, c&oacute; thể cho b&eacute; uống theo nhu cầu. D&agrave;nh cho b&eacute; từ 2&nbsp;tuổi trở l&ecirc;n.</span></p>\r\n', '<h1>Sữa tươi dạng bột Devondale (nguy&ecirc;n kem) (1kg)</h1>\r\n\r\n<ul>\r\n	<li>Sữa tươi dạng bột Devondale l&agrave; h&atilde;ng sữa tươi nổi tiếng số 1 của &uacute;c ,được xuất sang c&aacute;c nước tr&ecirc;n thế giới với h&agrave;m lượng canxi rất cao, gi&uacute;p cung cấp canxi,tăng chiều cao.</li>\r\n	<li>1kg pha được 7 l&iacute;t sữa tươi nước</li>\r\n	<li>đặc điểm của loại sữa tươi dạng bột n&agrave;y kg c&oacute; chất bảo quản như những loại sữa tươi nước th&ocirc;ng thường n&ecirc;n ho&agrave;n to&agrave;n an to&agrave;n cho con y&ecirc;u của ch&uacute;ng ta sử dụng, giữa l&uacute;c thị trường sữa đang biến động v&igrave; nhiều sữa nhiễm khuẩn v&agrave; độc hại th&igrave; đ&acirc;y l&agrave; loại sữa c&aacute;c mẹ c&oacute; thể y&ecirc;n t&acirc;m chọn lựa cho con m&igrave;nh.&nbsp;</li>\r\n	<li>Tất cả c&aacute;c sản phẩm sữa của Devondale đều l&agrave; sữa tươi nguy&ecirc;n chất, kh&ocirc;ng c&oacute; đường, kh&ocirc;ng sử dụng chất bảo quản, kh&ocirc;ng hương liệu, kh&ocirc;ng chất phụ gia như&nbsp;những loại sữa tươi nước th&ocirc;ng thường n&ecirc;n rất tốt cho sức khỏe, đặc biệt l&agrave; sức khỏe v&agrave; sự ph&aacute;t triển về chiều cao của trẻ.</li>\r\n</ul>\r\n\r\n<p><strong>C&aacute;ch d&ugrave;ng:</strong><br />\r\n-&gt; Để pha 1 ly sữa 250ml th&igrave; lấy 1/3 ly (35gr sữa bột) cho v&agrave;o ly sau đ&oacute; cho 1 nửa ly nước n&oacute;ng hoặc lạnh t&ugrave;y th&iacute;ch v&agrave;o quậy đều cho đến khi tan hết bột sữa rồi đổ nốt 1 nửa ly nước c&ograve;n lại v&agrave;o..</p>\r\n\r\n<p>-&gt; Để pha 1 l&iacute;t sữa th&igrave; lấy 1+1/3 ly (140gr sữa bột) cho v&agrave;o b&igrave;nh sau đ&oacute; cho 500ml nước n&oacute;ng hoặc lạnh tuỳ th&iacute;ch v&agrave;o quậy đều cho đến khi tan hết bột sữa th&igrave; đổ nốt 500ml nước c&ograve;n lại v&agrave;o...</p>\r\n\r\n<p>-&gt; Bảo quản ở nơi kh&ocirc; tho&aacute;ng<br />\r\n-&gt; Sữa đ&atilde; pha nước xin giữ ở tủ lạnh 4 độ C v&agrave; sử dụng kg qu&aacute; 3 ng&agrave;y từ l&uacute;c pha..</p>\r\n\r\n<ul>\r\n	<li>Ngo&agrave;i c&ocirc;ng dụng pha th&agrave;nh sữa tươi bạn c&oacute; d&ugrave;ng để l&agrave;m b&aacute;nh nữa nh&eacute;..</li>\r\n	<li>Sữa kh&ocirc;ng chất bảo quản.&nbsp;</li>\r\n	<li>Sản phẩm NK &amp; sx tại &Uacute;c.&nbsp;</li>\r\n</ul>\r\n', '12-28-52-25-04-2016-1282142111999049733679691381425398110916765n.jpg', '12-28-52-25-04-2016-1282142111999049733679691381425398110916765n.jpg', 'a:1:{i:0;s:68:"12-28-52-25-04-2016-1282142111999049733679691381425398110916765n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461562132, 1461567262),
(78, NULL, 'SỮa ENSURE ÚC', 750000, 0, 750000, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">T&aacute;c dụng của sữa Ensure; &ndash; Bổ sung vi chất &ndash; Bồi dưỡng sức khỏe &ndash; Chống l&atilde;o h&oacute;a &ndash; K&iacute;ch th&iacute;ch ph&aacute;t triển c&aacute;c tế b&agrave;o m&ocirc;, cơ v&agrave; xương sụn &ndash; Bổ sung dinh dưỡng, vitamin, protein v&agrave; kho&aacute;ng chất &ndash; Tăng cường tốc độ phục hồi sau phẫu thuật hoặc tập luyện vất vả &ndash; Gi&uacute;p tăng cường sức khỏe cho ch&iacute;nh m&igrave;nh v&agrave; người th&acirc;n &ndash; D&ugrave;ng cho người gi&agrave;, trẻ em biến ăn, người lớn mới khỏi bệnh,</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">T&aacute;c dụng của sữa Ensure; &ndash; Bổ sung vi chất &ndash; Bồi dưỡng sức khỏe &ndash; Chống l&atilde;o h&oacute;a &ndash; K&iacute;ch th&iacute;ch ph&aacute;t triển c&aacute;c tế b&agrave;o m&ocirc;, cơ v&agrave; xương sụn &ndash; Bổ sung dinh dưỡng, vitamin, protein v&agrave; kho&aacute;ng chất &ndash; Tăng cường tốc độ phục hồi sau phẫu thuật hoặc tập luyện vất vả &ndash; Gi&uacute;p tăng cường sức khỏe cho ch&iacute;nh m&igrave;nh v&agrave; người th&acirc;n &ndash; D&ugrave;ng cho người gi&agrave;, trẻ em biến ăn, người lớn mới khỏi bệnh,&hellip; Sữa Ensure cũng hạn chế n</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">gười sử dụng, vậy những ai n&ecirc;n d&ugrave;ng v&agrave; ai kh&ocirc;ng n&ecirc;n d&ugrave;ng sữa Ensure n&agrave;y Loại sữa n&agrave;y c&oacute; thể ph&ugrave; hợp với rất nhiều người, từ trẻ em tới người lớn. Nếu bạn l&agrave; một bệnh nh&acirc;n muốn hồi phục nhanh sau khi phẫu thuật, điều trị th&igrave; đ&acirc;y l&agrave; một sản phẩm ph&ugrave; hợp. Với người cao tuổi th&igrave; đ&acirc;y cũng l&agrave; một thức uống gi&uacute;p lấy lại v&agrave; duy tr&igrave; sức khỏe tốt. Những ai đang muốn c&acirc;n bằng lại qu&aacute; tr&igrave;nh hấp thụ chất dĩnh dưỡng sau khi bị rối loạn, những ai muốn tăng c&acirc;n th&igrave; đ&acirc;y cũng l&agrave; một sản phẩm ph&ugrave; hợp. Hay thậm ch&iacute; bạn sợ ăn tinh bột v&igrave; b&eacute;o th&igrave; một chai sữa ensure c&oacute; chức năng thay thế một bữa ăn, sẽ gi&uacute;p bạn đảm bảo v&oacute;c d&aacute;ng cho m&igrave;nh.<br />\r\n<br />\r\nXuất xứ : Ch&acirc;u &Acirc;u.</span></p>\r\n', '12-32-28-25-04-2016-photo-2.jpg', '12-32-28-25-04-2016-photo-2.jpg', 'a:1:{i:0;s:31:"12-32-28-25-04-2016-photo-2.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461562348, 1461567253),
(80, NULL, 'Ruốc cá hồi Aeon Nhật', 160000, 0, 160000, 1, '', 2, '<p>Ruốc c&aacute; hồi</p>\r\n', '<p>L&agrave;m từ c&aacute; hồi tươi ngon tuyệt&nbsp;hảo</p>\r\n', '12-35-30-25-04-2016-photo-3.jpg', '12-35-30-25-04-2016-photo-3.jpg', 'a:1:{i:0;s:31:"12-35-30-25-04-2016-photo-3.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461562530, 1461567210),
(81, NULL, 'Viên uống phát triển chiều cao Nhật', 1500000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">C&ocirc;ng dụng của sản phẩm vi&ecirc;n uống tăng chiều cao của Nhật:</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Những người thấp thường l&agrave; do qu&aacute; tr&igrave;nh sản xuất Gh kh&ocirc;ng đủ cho sự ph&aacute;t triển cơ thể, với vi&ecirc;n uống Gh creation chứa hocmon tăng trưởng nhằm t&aacute;c động v&agrave;o c&aacute;c cơ quan gi&uacute;p sản sinh nhiều hocmon tăng trưởng, từ đ&oacute; gi&uacute;p ph&aacute;t triển chiều cao một c&aacute;ch tự nhi&ecirc;n, kh&ocirc;ng c&oacute; t&aacute;c dung phụ hay ảnh hưởng đến sinh l&yacute; của con người.<br />\r\nThuốc tăng chiều cao Gh creation gi&uacute;p bạn tăng chiều cao từ 5 đến 10 cm trong khoảng thời gian ngắn, gi&uacute;p bạn tự tin với v&oacute;c d&aacute;ng của m&igrave;nh, mang &aacute;o quần thoải m&aacute;i với sở th&iacute;ch .</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Th&agrave;nh phần c&oacute; trong GH Creation 270 vi&ecirc;n:</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">C&oacute; c&aacute;c chất glycerophosphocholine, đ&acirc;y l&agrave; chất kh&ocirc;ng thể thiếu trong qu&aacute; tr&igrave;nh ph&aacute;t triển, hoạt độn hằng ng&agrave;y của cơ thể.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">C&aacute;c axit amin thiết yếu cấu th&agrave;nh n&ecirc;n hocmon tăng trưởng, Bonpeppu, Purotetaito, Coral Canxi cung cấp một lượng lớn canxi, chất dinh dưỡng cho xương ph&aacute;t triển khỏe mạnh.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">C&ocirc;ng dụng của sản phẩm vi&ecirc;n uống tăng chiều cao của Nhật:</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Những người thấp thường l&agrave; do qu&aacute; tr&igrave;nh sản xuất Gh kh&ocirc;ng đủ cho sự ph&aacute;t triển cơ thể, với vi&ecirc;n uống Gh creation chứa hocmon tăng trưởng nhằm t&aacute;c động v&agrave;o c&aacute;c cơ quan gi&uacute;p sản sinh nhiều hocmon tăng trưởng, từ đ&oacute; gi&uacute;p ph&aacute;t triển chiều cao một c&aacute;ch tự nhi&ecirc;n, kh&ocirc;ng c&oacute; t&aacute;c dung phụ hay ảnh hưởng đến sinh l&yacute; của con người.<br />\r\nThuốc tăng chiều cao Gh creation gi&uacute;p bạn tăng chiều cao từ 5 đến 10 cm trong khoảng thời gian ngắn, gi&uacute;p bạn tự tin với v&oacute;c d&aacute;ng của m&igrave;nh, mang &aacute;o quần thoải m&aacute;i với sở th&iacute;ch .<br />\r\n<br />\r\nSử dụng theo liệu tr&igrave;nh trong 3 th&aacute;ng gi&uacute;p bạn tăng 5 &ndash; 10 cm t&ugrave;y theo thể trạng từng người.<br />\r\nMỗi ng&agrave;y uống 3 vi&ecirc;n, uống trước khi đi ngủ. Trong v&ograve;ng 3 giờ sau khi uống kh&ocirc;ng ăn hay uống th&ecirc;m g&igrave; kh&aacute;c.<br />\r\nNgo&agrave;i ra bạn c&oacute; thể kết hợp với chế độ dinh dưỡng c&oacute; thịt, c&aacute;, rau cũ quả&hellip;những thực phẩm cung cấp nhiều đạm v&agrave; canxi cho cơ thể.<br />\r\nTh&iacute;ch hợp cho độ tuổi từ 10-30.</span><br />\r\n&nbsp;</p>\r\n', '12-39-09-25-04-2016-1035414112070091593242176322865630245731427n.jpg', '12-39-09-25-04-2016-1035414112070091593242176322865630245731427n.jpg', 'a:1:{i:0;s:68:"12-39-09-25-04-2016-1035414112070091593242176322865630245731427n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461562749, NULL),
(82, NULL, 'Bột Collagen Shishedo Nhật', 460000, 0, 0, 1, '', 2, '<p><em><strong>Collagen shiseido dạng bột</strong></em><span style="background-color:rgb(255, 255, 255); color:rgb(68, 68, 68)">&nbsp;chứa th&agrave;nh phần collagen l&ecirc;n đến 5000mg, c&oacute; bổ sung th&ecirc;m vitamin C với c&ocirc;ng dụng ch&iacute;nh: bổ sung collagen cho l&agrave;n da sau tuổi 25, chống l&atilde;o h&oacute;a, chống nhăn da v&agrave; chảy sệ.</span></p>\r\n', '<p><a href="http://healthmart.vn/product/shiseido-the-collagen-dang-bot" style="box-sizing: border-box; color: rgb(45, 92, 136); text-decoration: none; font-family: Verdana, Geneva, sans-serif; font-size: 14px; line-height: 20px; background-color: rgb(255, 255, 255);" title="collagen shiseido dạng bột"><em><strong>Collagen shiseido dạng bột</strong></em></a><span style="background-color:rgb(255, 255, 255); color:rgb(68, 68, 68); font-family:verdana,geneva,sans-serif; font-size:14px">&nbsp;chứa th&agrave;nh phần collagen l&ecirc;n đến 5000mg, c&oacute; bổ sung th&ecirc;m vitamin C với c&ocirc;ng dụng ch&iacute;nh: bổ sung collagen cho l&agrave;n da sau tuổi 25, chống l&atilde;o h&oacute;a, chống nhăn da v&agrave; chảy sệ.</span></p>\r\n\r\n<h3>C&aacute;ch d&ugrave;ng collagen shiseido dạng bột:</h3>\r\n\r\n<ul>\r\n	<li>D&ugrave;ng 01 muỗng/ ng&agrave;y</li>\r\n	<li>C&oacute; thể pha chung với c&aacute;c loại nước uống: tr&agrave;, cafe, hoặc nước</li>\r\n	<li>Sau khi mở t&uacute;i cần tr&aacute;nh &aacute;nh s&aacute;ng mặt trời</li>\r\n	<li>Để nơi tho&aacute;ng m&aacute;t v&agrave; kh&ocirc; r&aacute;o</li>\r\n	<li>M&agrave;u sắc của bột c&oacute; thể bị biến đổi, nhưng kh&ocirc;ng ảnh hưỡng g&igrave; đến chất lượng, miễn l&agrave; trước hạn sử dụng.</li>\r\n	<li>Nếu dị ứng với một th&agrave;nh phần n&agrave;o của thuốc th&igrave; kh&ocirc;ng n&ecirc;n d&ugrave;ng. H&atilde;y tham khảo &yacute; kiến b&aacute;c sĩ.</li>\r\n	<li>Phụ nữ c&oacute; thai xin tham khảo &yacute; kiến b&aacute;c sĩ trước khi d&ugrave;ng.</li>\r\n</ul>\r\n', '12-41-57-25-04-2016-1281465712043996329185038422216827022331432n.jpg', '12-41-57-25-04-2016-1281465712043996329185038422216827022331432n.jpg', 'a:1:{i:0;s:68:"12-41-57-25-04-2016-1281465712043996329185038422216827022331432n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461562917, NULL);
INSERT INTO `web_product` (`product_id`, `product_code`, `product_name`, `product_price_sell`, `product_price_market`, `product_price_input`, `product_type_price`, `product_selloff`, `product_is_hot`, `product_sort_desc`, `product_content`, `product_image`, `product_image_hover`, `product_image_other`, `product_order`, `category_id`, `category_name`, `quality_input`, `quality_out`, `product_status`, `is_block`, `user_shop_id`, `user_shop_name`, `is_shop`, `shop_province`, `time_created`, `time_update`) VALUES
(83, NULL, 'Collagen Meiji Premium 5000mg', 560000, 0, 560000, 1, '', 2, '<p><span style="color:rgb(0, 0, 0)">Collagen Meiji Premium t&uacute;i v&agrave;ng l&agrave; sản phẩm collagen cao cấp của Meiji tại Nhật. Với th&agrave;nh phần l&agrave; 100% collagen c&aacute; c&oacute; bổ sung th&ecirc;m Hyaluronic Acid v&agrave; Coenzyme Q10,&nbsp;</span><strong>Collagen Meiji Premium</strong><span style="color:rgb(0, 0, 0)">&nbsp;l&agrave;m tăng độ đ&agrave;n hồi v&agrave; săn chắc cho da, cho bạn l&agrave;n da mịn m&agrave;ng, tươi trẻ, kh&ocirc;ng nếp nhăn.</span></p>\r\n\r\n<p>Nh&agrave; sản xuất: Meiji, Nhật Bản</p>\r\n\r\n<p>&nbsp;</p>\r\n', '<h4><span style="color:rgb(0, 0, 0)">Hướng dẫn sử dụng Meiji Collagen Premium</span></h4>\r\n\r\n<ul>\r\n	<li><span style="color:rgb(0, 0, 0)">Liều d&ugrave;ng: d&ugrave;ng 01 muỗng/ ng&agrave;y, mỗi hộp d&ugrave;ng được 28 ng&agrave;y, d&ugrave;ng sau 06 tuần sẽ thấy được hiệu quả.</span></li>\r\n	<li><span style="color:rgb(0, 0, 0)">C&aacute;ch d&ugrave;ng: c&oacute; thể pha chung với tr&agrave;, cafe, hoặc c&aacute;c loại thực phẩm kh&aacute;c v&igrave; sản phẩm kh&ocirc;ng m&agrave;u, kh&ocirc;ng m&ugrave;i, rất dễ sử dụng.</span></li>\r\n	<li><span style="color:rgb(0, 0, 0)">Sau khi mở hộp, t&uacute;i, cần giữ sản phẩm trong hộp k&iacute;n, tr&aacute;nh tiếp x&uacute;c với kh&ocirc;ng kh&iacute;, tr&aacute;nh &aacute;nh nắng mặt trời chiếu v&agrave;o trực tiếp, bảo quản nơi kh&ocirc; r&aacute;o, tho&aacute;ng m&aacute;t</span></li>\r\n	<li><span style="color:rgb(0, 0, 0)">Phụ nữ mang thai v&agrave; cho con b&uacute; kh&ocirc;ng n&ecirc;n sử dụng</span></li>\r\n	<li><span style="color:rgb(0, 0, 0)">Nếu bạn đang uống c&aacute;c loại thuốc chữa bệnh hay điều trị, h&atilde;y hỏi kỹ b&aacute;c sĩ hay dược sĩ của bạn trước khi sử dụng thức uống n&agrave;y</span></li>\r\n	<li><span style="color:rgb(0, 0, 0)">Sau khi uống thuốc, nguy&ecirc;n liệu c&oacute; thể c&oacute; l&agrave;m nước tiểu c&oacute; m&agrave;u v&agrave;ng. Bạn kh&ocirc;ng cần bận t&acirc;m đến điều n&agrave;y.</span></li>\r\n</ul>\r\n\r\n<p><span style="color:rgb(0, 0, 0)">từ kh&oacute;a li&ecirc;n quan</span></p>\r\n\r\n<ul>\r\n	<li><span style="color:rgb(0, 0, 0)"><em>collagen meiji</em></span></li>\r\n	<li><span style="color:rgb(0, 0, 0)"><em>collagen meiji premium dang bot</em></span></li>\r\n	<li><span style="color:rgb(0, 0, 0)"><em>meiji collagen dang bot</em></span></li>\r\n	<li><span style="color:rgb(0, 0, 0)"><em>collagen amino meiji</em></span></li>\r\n</ul>\r\n', '04-03-38-25-04-2016-collagen-meiji-premium-trong-tui-nhua.jpg', '04-03-38-25-04-2016-collagen-meiji-premium-trong-tui-nhua.jpg', 'a:1:{i:0;s:61:"04-03-38-25-04-2016-collagen-meiji-premium-trong-tui-nhua.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 0, 1, 6, 'Hàng xách tay', 2, 22, 1461563254, 1461575067),
(84, NULL, 'Vòng điều hòa huyết áp Nhật Bản ', 350000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">T&aacute;c dụng V&ograve;ng điều h&ograve;a huyết &aacute;p Nhật Bản :</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">+ Điều h&ograve;a ổn định huyết &aacute;p, lưu th&ocirc;ng m&aacute;u v&ugrave;ng đầu, cổ</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">+ Chống đau cứng, nhức mỏi vai cổ</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">+ Khi đi tầu xe đeo rất tốt v&igrave; v&ograve;ng n&agrave;y gi&uacute;p tuần ho&agrave;n m&aacute;u n&ecirc;n kh&ocirc;ng g&acirc;y ra cảm gi&aacute;c ch&oacute;ng mặt, say xe.</span><br />\r\n&nbsp;</p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">T&aacute;c dụng V&ograve;ng điều h&ograve;a huyết &aacute;p Nhật Bản :</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">+ Điều h&ograve;a ổn định huyết &aacute;p, lưu th&ocirc;ng m&aacute;u v&ugrave;ng đầu, cổ</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">+ Chống đau cứng, nhức mỏi vai cổ</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">+ Khi đi tầu xe đeo rất tốt v&igrave; v&ograve;ng n&agrave;y gi&uacute;p tuần ho&agrave;n m&aacute;u n&ecirc;n kh&ocirc;ng g&acirc;y ra cảm gi&aacute;c ch&oacute;ng mặt, say xe.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">( B&ecirc;n trong v&ograve;ng được t&iacute;ch hợp đ&aacute; từ t&iacute;nh hiệu quả điều trị đau nhức vai, cổ, gi&uacute;p tiếp cận tới những v&ugrave;ng m&aacute;u huyết bị bế tắc, căng cứng)<br />\r\n<br />\r\n- Dưới 60 c&acirc;n: D&ugrave;ng v&ograve;ng 45cm<br />\r\n- Từ 60 c&acirc;n ~ 75 c&acirc;n: D&ugrave;ng v&ograve;ng 50cm<br />\r\n- Tr&ecirc;n 75 c&acirc;n: D&ugrave;ng v&ograve;ng 60cm</span></p>\r\n', '12-47-58-25-04-2016-1114118412424872691097394451838526804972545n.jpg', '12-49-32-25-04-2016-1308734812424872891097374325093080733967026n.jpg', 'a:2:{i:0;s:68:"12-47-58-25-04-2016-1114118412424872691097394451838526804972545n.jpg";i:1;s:68:"12-49-32-25-04-2016-1308734812424872891097374325093080733967026n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461563278, NULL),
(85, NULL, 'Vòng đuổi muỗi Pháp', 400000, 0, 0, 1, '', 2, '<p><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Nhờ sự kết hợp c&aacute;c loại tinh dầu đặc biệt của bảy loại kh&aacute;c nhau được b&agrave;o chế từ c&aacute;c loại c&acirc;y tự nhi&ecirc;n đ&atilde; c&oacute; khả năng chống lại muỗi, c&ocirc;n tr&ugrave;ng.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Parakito gi&uacute;p c&aacute;c mẹ bảo vệ b&eacute; y&ecirc;u v&agrave; gia đ&igrave;nh khỏi muỗi trong suốt cả ng&agrave;y d&agrave;i, giải quyết mối lo bị ngứa v&agrave; mẩn đỏ của c&aacute;c b&eacute;.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Đặc điểm của v&ograve;ng đeo tay chống muỗi Parakito</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Nhờ sự kết hợp c&aacute;c loại tinh dầu đặc biệt của bảy loại kh&aacute;c nhau được b&agrave;o chế từ c&aacute;c loại c&acirc;y tự nhi&ecirc;n đ&atilde; c&oacute; khả năng chống lại muỗi, c&ocirc;n tr&ugrave;ng.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Parakito gi&uacute;p c&aacute;c mẹ bảo vệ b&eacute; y&ecirc;u v&agrave; gia đ&igrave;nh khỏi muỗi trong suốt cả ng&agrave;y d&agrave;i, giải quyết mối lo bị ngứa v&agrave; mẩn đỏ của c&aacute;c b&eacute;.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">V&ograve;ng đeo tay Parakito c&oacute; thể t&aacute;i chế nhiều lần với c&aacute;c vi&ecirc;n nang ( Sẵn 2 vi&ecirc;n khi mua v&ograve;ng)<br />\r\nVi&ecirc;n Parakito dạng nang với th&agrave;nh phần tr&aacute;nh muỗi tự nhi&ecirc;n, kh&ocirc;ng c&oacute; th&agrave;nh phần độc hại, kh&ocirc;ng g&acirc;y k&iacute;ch ứng ra rất an to&agrave;n cho cả gia đ&igrave;nh<br />\r\nV&ograve;ng chống muỗi đeo ray Parakito mẹ v&agrave; b&eacute; c&oacute; thể đeo v&ograve;ng chống muỗi Parakito ở tay, ch&acirc;n, t&uacute;i x&aacute;ch.<br />\r\n<br />\r\nV&ograve;ng đeo tay Parakito với thời gian sử dụng l&ecirc;n đến 15 ng&agrave;y/ 1 vi&ecirc;n, hơn nữa v&ograve;ng đeo Parakito c&ograve;n kh&ocirc;ng thấm nước trong điều kiện mưa hay khi tắm, đi bơi m&agrave; qu&ecirc;n th&aacute;o v&ograve;ng.<br />\r\nĐặt vi&ecirc;n Parakito v&agrave;o lớp lưới tr&ecirc;n v&ograve;ng đeo hoặc m&oacute;c kh&oacute;a hướng ra ngo&agrave;i.</span></p>\r\n', '12-51-26-25-04-2016-1306218112424873591097301804434287782344348n.jpg', '12-51-26-25-04-2016-1306218112424873591097301804434287782344348n.jpg', 'a:1:{i:0;s:68:"12-51-26-25-04-2016-1306218112424873591097301804434287782344348n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461563486, NULL),
(86, NULL, 'Sản phẩm Vitamin D-Fluoretten 500 I.E', 250000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">ản phẩm Vitamin D-Fluoretten 500 I.E. của Sanofi c&oacute; th&agrave;nh phần ch&iacute;nh gồm Vitamin D v&agrave; Natrium fluorid. Sự kết hợp giữa Vitamin D (tăng khả năng hấp thụ canxi, ph&aacute;t triển bảo vệ xương) v&agrave; muối Fluorid được sử dụng để ngăn ngừa chứng c&ograve;i xương, l&agrave;m chắc xương, răng mọc nhanh, ph&ograve;ng ngừa s&acirc;u răng ở trẻ em.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">ản phẩm Vitamin D-Fluoretten 500 I.E. của Sanofi c&oacute; th&agrave;nh phần ch&iacute;nh gồm Vitamin D v&agrave; Natrium fluorid. Sự kết hợp giữa Vitamin D (tăng khả năng hấp thụ canxi, ph&aacute;t triển bảo vệ xương) v&agrave; muối Fluorid được sử dụng để ngăn ngừa chứng c&ograve;i xương, l&agrave;m chắc xương, răng mọc nhanh, ph&ograve;ng ngừa s&acirc;u răng ở trẻ em.</span></p>\r\n', '12-54-49-25-04-2016-d500moi24174zoom.jpg', '12-55-00-25-04-2016-d-f-414730f2229.jpg', 'a:2:{i:0;s:40:"12-54-49-25-04-2016-d500moi24174zoom.jpg";i:1;s:39:"12-55-00-25-04-2016-d-f-414730f2229.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461563667, NULL),
(87, NULL, 'Bộ chăm sóc răng miệng cho bé', 225000, 0, 225000, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Bộ đồ chăm s&oacute;c răng miệng cho b&eacute;</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">&nbsp;l&agrave; h&agrave;ng nội địa H&agrave;n Quốc gi&uacute;p k&iacute;ch th&iacute;ch c&aacute;c b&eacute; tự chăm s&oacute;c răng miệng cho ch&iacute;nh m&igrave;nh, gi&uacute;p con sớm biết tự lập.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Bộ đồ chăm s&oacute;c răng miệng cho b&eacute;&nbsp;l&agrave; h&agrave;ng nội địa H&agrave;n Quốc gi&uacute;p k&iacute;ch th&iacute;ch c&aacute;c b&eacute; tự chăm s&oacute;c răng miệng cho ch&iacute;nh m&igrave;nh, gi&uacute;p con sớm biết tự lập. Bộ sản phẩm rất dễ d&agrave;ng cho b&eacute; sử dụng, bao gồm:</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">+ 1 tu&yacute;p kem đ&aacute;nh răng 75g</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">+ 1 cốc c&oacute; nắp đậy (17cm)</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">+ 2 b&agrave;n chải đ&aacute;nh răng cho b&eacute; (17cm)</span></p>\r\n', '12-56-47-25-04-2016-img8288.jpg', '12-56-47-25-04-2016-img8288.jpg', 'a:1:{i:0;s:31:"12-56-47-25-04-2016-img8288.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461563798, 1461567147),
(89, NULL, 'Kem dưỡng Buchen cho bé', 50000, 0, 50000, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Kem dưỡng da m&ugrave;i quả D&acirc;u chăm s&oacute;c da mặt cho trẻ nhỏ, d&agrave;nh cho tất cả c&aacute;c loại da. L&agrave; một tổng hợp c&aacute;c th&agrave;nh phần tự nhi&ecirc;n cung cấp cho da c&aacute;c loại a-x&iacute;t b&eacute;o thiết yếu v&agrave; độ ẩm.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Kem dưỡng da m&ugrave;i quả D&acirc;u chăm s&oacute;c da mặt cho trẻ nhỏ, d&agrave;nh cho tất cả c&aacute;c loại da. L&agrave; một tổng hợp c&aacute;c th&agrave;nh phần tự nhi&ecirc;n cung cấp cho da c&aacute;c loại a-x&iacute;t b&eacute;o thiết yếu v&agrave; độ ẩm. C&aacute;c loại dầu thực vật, c&aacute;c th&agrave;nh phần dưỡng ẩm trong kem chăm s&oacute;c v&agrave; bảo vệ l&agrave;n da mỏng manh, gi&uacute;p da khỏi bị kh&ocirc;.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Th&agrave;nh phần: C&oacute; tinh dầu c&acirc;y cỏ nguy&ecirc;n chất như dầu hạt dẻ, dầu c&acirc;y Carite cung cấp cho da độ ẩm cần thiết&nbsp;</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">v&agrave; gi&uacute;p da trẻ lu&ocirc;n mềm mại, mịn m&agrave;ng, kh&ocirc;ng kh&ocirc;, ngứa.<br />\r\n&ndash; Kh&ocirc;ng chứa dầu, kho&aacute;ng chất, kh&ocirc;ng chứa m&agrave;u nh&acirc;n tạo, kh&ocirc;ng g&acirc;y k&iacute;ch ứng, hỗ trợ chức năng bảo vệ da.<br />\r\n&ndash; M&ugrave;i d&acirc;u ngọt dịu, lu&ocirc;n đem lại cảm gi&aacute;c dễ chịu, thoải m&aacute;i.<br />\r\nHướng dẫn sử dụng: B&ocirc;i v&agrave; thoa đều kem l&ecirc;n da sau mỗi lần rửa mặt hoặc trước khi đi ra ngo&agrave;i sẽ tr&aacute;nh cho da khỏi bị mất nước.</span></p>\r\n', '12-58-59-25-04-2016-kemduongdabudchenhuongdautayrung.jpg', '12-58-59-25-04-2016-kemduongdabudchenhuongdautayrung.jpg', 'a:1:{i:0;s:56:"12-58-59-25-04-2016-kemduongdabudchenhuongdautayrung.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461563939, 1461567133),
(90, NULL, 'Sữa tươi A2 Úc', 550000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Sữa tươi A2 cho b&eacute; từ 1 tuổi trở l&ecirc;n với 100% protein A2, lượng canxi cao tốt cho ti&ecirc;u h&oacute;a, hấp thu v&agrave; sức khỏe tương lai của trẻ.</span></p>\r\n', '<p><span style="color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px; line-height:22.4px">Sữa tươi A2 cho b&eacute; từ 1 tuổi trở l&ecirc;n với 100% protein A2, lượng canxi cao tốt cho ti&ecirc;u h&oacute;a, hấp thu v&agrave; sức khỏe tương lai của trẻ.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Sữa tươi A2 non &ndash; GMO tốt cho ti&ecirc;u h&oacute;a , gi&agrave;u canxi, kh&ocirc;ng chứa những nguy cơ g&acirc;y hại m&agrave; protein A1 g&acirc;y ra v&agrave; tốt cho sức khỏe tương lai của b&eacute;.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Hướng dẫn c&aacute;ch pha: v&igrave; l&agrave; sữa tươi n&ecirc;n c&aacute;c mẹ kh&ocirc;ng cần pha qu&aacute; c&ocirc;ng thức, nhiệt độ nước n&oacute;ng, lạnh đều được. Hoặc pha the</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">o tỉ lệ 35g bột pha với 250ml nước. Vị sữa thơm ngon, b&eacute;o ngậy.<br />\r\nBảo quản nơi tho&aacute;ng m&aacute;t, tr&aacute;nh &aacute;nh nắng trực tiếp. Sau khi mở t&uacute;i d&ugrave;ng trong một th&aacute;ng.</span></p>\r\n', '01-01-53-25-04-2016-1292438612294315204153143079171401087518461n.jpg', '01-02-02-25-04-2016-1293659312294315304153133634851680740332604n.jpg', 'a:2:{i:0;s:68:"01-01-53-25-04-2016-1292438612294315204153143079171401087518461n.jpg";i:1;s:68:"01-02-02-25-04-2016-1293659312294315304153133634851680740332604n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461564049, NULL),
(92, NULL, 'Thuốc ho Prospan Đức chai 100ml', 250000, 0, 250000, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Siro Prospan mang đến bộ ba t&aacute;c động:</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">- long đờm</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">- gi&atilde;n phế quản</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">- giảm ho,<br />\r\nđược sử dụng để điều trị c&aacute;c triệu chứng cảm lạnh th&ocirc;ng thường, ho v&agrave; đờm, vi&ecirc;m đường h&ocirc; hấp, vi&ecirc;m phế quản, d&ugrave;ng được cho cả người lớn v&agrave; trẻ em. Đặc biệt, siro ho Prospan c&oacute; độ an to&agrave;n cao nhờ th&agrave;nh phần ch&iacute;nh l&agrave; thảo dược, kh&ocirc;ng chứa đường, cồn, kh&ocirc;ng c&oacute; chất tạo m&agrave;u, c&oacute; m&ugrave;i thơm v&agrave; vị dễ chịu ph&ugrave; hợp cho trẻ nhỏ.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Siro Prospan mang đến bộ ba t&aacute;c động:</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- long đờm</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- gi&atilde;n phế quản</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- giảm ho,<br />\r\nđược sử dụng để điều trị c&aacute;c triệu chứng cảm lạnh th&ocirc;ng thường, ho v&agrave; đờm, vi&ecirc;m đường h&ocirc; hấp, vi&ecirc;m phế quản, d&ugrave;ng được cho cả người lớn v&agrave; trẻ em. Đặc biệt, siro ho Prospan c&oacute; độ an to&agrave;n cao nhờ th&agrave;nh phần ch&iacute;nh l&agrave; thảo dược, kh&ocirc;ng chứa đường, cồn, kh&ocirc;ng c&oacute; chất tạo m&agrave;u, c&oacute; m&ugrave;i thơm v&agrave; vị dễ chịu ph&ugrave; hợp cho trẻ nhỏ.<br />\r\n<br />\r\nSiro ho Prospan 100ml (d&ugrave;ng theo ml):<br />\r\n- Trẻ em dưới 6 tuổi: 2,5ml x 2lần/ng&agrave;y.<br />\r\n- Trẻ từ 6 đến 12 tuổi: 5ml x 2lần/ng&agrave;y<br />\r\n- Trẻ em tr&ecirc;n 12 tuổi v&agrave; người lớn: 5ml x 3lần/ng&agrave;y</span></p>\r\n', '01-04-38-25-04-2016-1296370012294323137485681748019871016252858n.jpg', '01-04-38-25-04-2016-1296370012294323137485681748019871016252858n.jpg', 'a:1:{i:0;s:68:"01-04-38-25-04-2016-1296370012294323137485681748019871016252858n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461564278, 1461567121),
(94, NULL, 'SIRO HO CẢM SỐT PABURON S - NHẬT (3M+)', 300000, 0, 300000, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">SIRO HO CẢM SỐT PABURON S - NHẬT (3M+)</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Được chiết suất ho&agrave;n to&agrave;n tự nhi&ecirc;n, kh&ocirc;ng c&oacute; c&aacute;c chất độc hại, chất bảo quản, an to&agrave;n khi sử dụng cho trẻ nhỏ.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">C&ocirc;ng dụng: d&ugrave;ng để điều trị những triệu chứng ho, chảy nước mũi, sốt,đau họng, hắt hơi, c&oacute; đờm v&agrave; c&aacute;c triệu chứng cảm lạnh như nghẹt mũi, ớn lạnh, nhức đầu, đau khớp v&agrave; cơ khi bị cảm được c&aacute;c bệnh viện Nhật tin d&ugrave;ng.</span></p>\r\n', '<div class="text_exposed_root text_exposed" id="id_571db1a640ecf6186659668" style="display: inline;"><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">SIRO HO CẢM SỐT PABURON S - NHẬT (3M+)<br />\r\n<br />\r\nĐược chiết suất ho&agrave;n to&agrave;n tự nhi&ecirc;n, kh&ocirc;ng c&oacute; c&aacute;c chất độc hại, chất bảo quản, an to&agrave;n khi sử dụng cho trẻ nhỏ.<br />\r\n<br />\r\nC&ocirc;ng dụng: d&ugrave;ng để điều trị những triệu chứng ho, chảy nước mũi, sốt,đau họng, hắt hơi, c&oacute; đờm v&agrave; c&aacute;c triệu chứng cảm lạnh như nghẹt mũi, ớn lạnh, nhức đầu, đau khớp v&agrave; cơ khi bị cảm được c&aacute;c bệnh viện Nhật tin d&ugrave;ng.<br />\r\n<br />\r\nLiều d&ugrave;ngSiro ho cảm sốt PABURON S 120ml&nbsp;<br />\r\nC&aacute;ch d&ugrave;ng : 1 ng&agrave;y 3 lần, uống sau khi ăn.<br />\r\nTrẻ từ 3 th&aacute;ng đến 1 tuổi: mỗi lần 5ml.<br />\r\nTrẻ từ 1 đến 2 tuổi: mỗi lần 7.5ml.<br />\r\nTrẻ từ 3 đến 6 tuổi: mỗi lần 10ml.<br />\r\n<br />\r\nSau khi mở nắp phải bảo quản nơi tho&aacute;ng m&aacute;t dưới 25 độ c, tr&aacute;nh &aacute;nh nắng mặt trời.</span></div>\r\n\r\n<div class="pts fbPhotoLegacyTagList" id="fbPhotoSnowliftLegacyTagList" style="padding-top: 5px; color: rgb(20, 24, 35); font-family: helvetica, arial, sans-serif; font-size: 12px; line-height: 16.08px; background-color: rgb(255, 255, 255);">\r\n<div>&nbsp;</div>\r\n</div>\r\n\r\n<div class="mvm fbPhotosPhotoOwnerButtons stat_elem" id="fbPhotoSnowliftOwnerButtons" style="margin-top: 10px; margin-bottom: 10px; line-height: 20px; color: rgb(20, 24, 35); font-family: helvetica, arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);">\r\n<div class="_51xa _3-8m _3-90" id="photosTruncatingUIButtonGroup" style="box-shadow: rgba(0, 0, 0, 0.0470588) 0px 1px 1px; display: inline-block; vertical-align: middle; white-space: nowrap; margin-bottom: 4px; margin-top: 4px; margin-right: 8px;">&nbsp;</div>\r\n</div>\r\n', '01-06-26-25-04-2016-1293107212294510604133608701470065625457663n.jpg', '01-06-26-25-04-2016-1293107212294510604133608701470065625457663n.jpg', 'a:1:{i:0;s:68:"01-06-26-25-04-2016-1293107212294510604133608701470065625457663n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461564386, 1461567106),
(96, NULL, 'Bộ thô Nhật', 65000, 0, 65000, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Bộ th&ocirc; Nhật cho b&eacute; 0-6m(&lt; 9kg)</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Chất th&ocirc; ho&agrave;n to&agrave;n tho&aacute;ng m&aacute;t thấm mồ h&ocirc;i.M&ugrave;a n&agrave;y nh&agrave; c&oacute; b&eacute; trong độ tuổi n&agrave;y sắm l&agrave; v&ocirc; c&ugrave;ng hợp l&yacute; nh&eacute;.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Bộ th&ocirc; Nhật cho b&eacute; 0-6m.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Chất th&ocirc; ho&agrave;n to&agrave;n tho&aacute;ng m&aacute;t thấm mồ h&ocirc;i.M&ugrave;a n&agrave;y nh&agrave; c&oacute; b&eacute; trong độ tuổi n&agrave;y sắm l&agrave; v&ocirc; c&ugrave;ng hợp l&yacute; nh&eacute;.</span></p>\r\n', '01-08-35-25-04-2016-1300666112354594798125181787571555738524285n.jpg', '01-08-35-25-04-2016-1300666112354594798125181787571555738524285n.jpg', 'a:1:{i:0;s:68:"01-08-35-25-04-2016-1300666112354594798125181787571555738524285n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461564515, 1461567094),
(97, NULL, 'Sữa Meji Nhật', 550000, 0, 0, 1, '', 2, '<p>Sữa Meiji l&agrave; một sản phẩm nổi tiếng của Nhật. Sữa Meiji c&oacute; th&agrave;nh phần dinh dưỡng dựa tr&ecirc;n nghi&ecirc;n cứu &ldquo;Dinh dưỡng v&agrave; ph&aacute;t triển của trẻ nhỏ&rdquo; v&agrave; &ldquo;Th&agrave;nh phần sữa mẹ&rdquo; cung cấp cho c&aacute;c b&eacute; một hệ dưỡng chất tối ưu, gi&uacute;p c&aacute;c b&eacute; ph&aacute;t triển to&agrave;n diện, khỏe mạnh.</p>\r\n\r\n<p>&nbsp;</p>\r\n', '<p>Sữa Meiji l&agrave; một sản phẩm nổi tiếng của Nhật. Sữa Meiji c&oacute; th&agrave;nh phần dinh dưỡng dựa tr&ecirc;n nghi&ecirc;n cứu &ldquo;Dinh dưỡng v&agrave; ph&aacute;t triển của trẻ nhỏ&rdquo; v&agrave; &ldquo;Th&agrave;nh phần sữa mẹ&rdquo; cung cấp cho c&aacute;c b&eacute; một hệ dưỡng chất tối ưu, gi&uacute;p c&aacute;c b&eacute; ph&aacute;t triển to&agrave;n diện, khỏe mạnh.</p>\r\n\r\n<p>&ndash; Sữa Meiji cung cấp sắt, can-xi, vitamin D, vitamin C v&agrave; c&aacute;c loại kho&aacute;ng chất, vitamin thiết yếu kh&aacute;c<br />\r\n&ndash; Sữa cũng bổ sung ax&iacute;t -linolenic (omega 3) v&agrave; ax&iacute;t linoleic (omega 6) với h&agrave;m lượng c&acirc;n bằng, bổ sung DHA (docosahexaenoic acid) gi&uacute;p tăng trưởng tr&iacute; n&atilde;o v&agrave; ph&aacute;t triển v&otilde;ng mạc mắt cho trẻ.<br />\r\n&ndash; Sữa Meiji c&oacute; taurin gi&uacute;p x&acirc;y dựng cơ thể khỏe mạnh; bổ sung th&ecirc;m DHA, arachidonic v&agrave; cholesterol với tỷ lệ c&acirc;n bằng hợp l&yacute; hỗ trợ tối đa sự ph&aacute;t triển tự nhi&ecirc;n của trẻ nhỏ.<br />\r\n&ndash; Sữa c&oacute; chứa chứa nhiều Nucleotides c&oacute; trong sữa mẹ v&agrave; cung cấp c&aacute;c protein c&acirc;n bằng, cần thiết<br />\r\n&ndash; Sữa Meiji chứa Fructooligosaccharides (FOS) để bảo vệ c&aacute;c vi khuẩn c&oacute; lợi trong đường ruột, nucleotides v&agrave; taurine, gi&uacute;p tăng cường hệ miễn dịch v&agrave; gia tăng h&igrave;nh th&agrave;nh c&aacute;c vi khuẩn c&oacute; lợi cho đường ruột.<br />\r\n&ndash; Cơ sở sản xuất sản phẩm Meiji ho&agrave;n to&agrave;n tự động, đảm bảo chất lượng theo giấy chứng nhận ti&ecirc;u chuẩn quốc tế ISO9001</p>\r\n', '01-10-30-25-04-2016-1270537015453141957819297992849938349122863n.jpg', '01-10-30-25-04-2016-1270537015453141957819297992849938349122863n.jpg', 'a:1:{i:0;s:68:"01-10-30-25-04-2016-1270537015453141957819297992849938349122863n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461564630, NULL),
(99, NULL, 'Vitamin tổng hợp Multi Sanostol Sirup số 3 Đức', 560000, 0, 560000, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">TH&Agrave;NH PHẦN Vitamin tổng hợp Multi Sanostol Sirup :&nbsp;</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">- Retinolpalmitat (entspr.24000 I.E. Vit.A) 13.2mg</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">- Coleaclciferol (entspr.20000 I.E. Vit.D3) 0,05mg<br />\r\n- Thiaminchlorid- Hydrochlorid* (Vit. B1) 20 mg<br />\r\n- Riboflavinphosphat- Natrium* (Vit. B2) 20mg<br />\r\n- Pyridoxin- Hydrochlorid (Vit.B6) 10mg<br />\r\n- Ascorbinsaure (Vit.C) 1000mg<br />\r\n- All- Rac- Alpha -Tocopherol -Acetal*(Vit.E) 20mg<br />\r\n- Nicotinamid 100mg<br />\r\n- Dexpanthenol*(Ph.Eur.) 40mg</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Vitamin tổng hợp Multi Sanostol Sirup số 3 Đức</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">TH&Agrave;NH PHẦN Vitamin tổng hợp Multi Sanostol Sirup :&nbsp;</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Retinolpalmitat (entspr.24000 I.E. Vit.A) 13.2mg</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Coleaclciferol (entspr.20000 I.E. Vit.D3) 0,05mg<br />\r\n- Thiaminchlorid- Hydrochlorid* (Vit. B1) 20 mg<br />\r\n- Riboflavinphosphat- Natrium* (Vit. B2) 20mg<br />\r\n- Pyridoxin- Hydrochlorid (Vit.B6) 10mg<br />\r\n- Ascorbinsaure (Vit.C) 1000mg<br />\r\n- All- Rac- Alpha -Tocopherol -Acetal*(Vit.E) 20mg<br />\r\n- Nicotinamid 100mg<br />\r\n- Dexpanthenol*(Ph.Eur.) 40mg<br />\r\n<br />\r\nC&Ocirc;NG DỤNG :&nbsp;<br />\r\n- Mỗi ng&agrave;y cho c&aacute;c b&eacute; uống từ 5ml_10ml, trước bữa ăn s&aacute;ng 30 ph&uacute;t gi&uacute;p c&aacute;c b&eacute; hấp thụ thức ăn tốt hơn v&agrave; tăng cường sức đề kh&aacute;ng cho b&eacute; .<br />\r\n- Sử dụng cho trẻ từ 3 tuổi trở l&ecirc;n.<br />\r\n- Dạng si r&ocirc; cung cấp một lượng vitamin v&agrave; kho&aacute;ng chất cần thiết gi&uacute;p b&eacute; bổ sung những kho&aacute;ng chất c&ograve;n thiếu để hỗ trợ ti&ecirc;u h&oacute;a, c&ograve;i xương, ph&aacute;t triển tr&iacute; n&atilde;o, tăng cường khả năng đề kh&aacute;ng v&agrave; gi&uacute;p b&eacute; ph&aacute;t triển một c&aacute;ch c&acirc;n đối v&agrave; to&agrave;n diện!<br />\r\n- Cung cấp đầy đủ c&aacute;c loại vitamin cần thiết cho c&aacute;c b&eacute;, gi&uacute;p c&aacute;c b&eacute; tăng cường sức đề kh&aacute;ng, ăn uống ngon miệng hơn, m&ugrave;i vị hơi ngọt ngọt chua chua rất dễ uống.<br />\r\n<br />\r\nH&atilde;y cho b&eacute; thưởng thức Siro vitamin Sanostol mỗi ng&agrave;y để gi&uacute;p b&eacute; bổ sung đầy đủ tất cả c&aacute;c loại vitamin v&agrave; kho&aacute;ng chất c&ograve;n thiếu từ chế độ ăn h&agrave;ng ng&agrave;y.<br />\r\n<br />\r\nBẢO QUẢN : ở nhiệt độ dưới 25 độ sau khi mở nắp.<br />\r\n<br />\r\nHộp 460ml</span><br />\r\n&nbsp;</p>\r\n', '01-13-39-25-04-2016-1300029312363584330559562331377621501972748n.jpg', '04-00-47-25-04-2016-12963606123635843972262245930175233311154n.jpg', 'a:1:{i:0;s:66:"04-00-47-25-04-2016-12963606123635843972262245930175233311154n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461564826, 1461574864),
(100, NULL, 'Áo HM xuất', 165000, 0, 0, 1, '', 1, '<p>&Aacute;o HM xuất.</p>\r\n', '<p>Aos thun HM xuất thấm mồ h&ocirc;i chất cực đẹp.</p>\r\n', '01-15-28-25-04-2016-1301269912354595731458423229406799129028283n.jpg', '01-15-28-25-04-2016-1301269912354595731458423229406799129028283n.jpg', 'a:1:{i:0;s:68:"01-15-28-25-04-2016-1301269912354595731458423229406799129028283n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461564928, NULL),
(102, NULL, 'Lăn Muỗi Đốt Muhi Nhật', 210000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Nhờ c&oacute; cảm gi&aacute;c m&aacute;t lạnh sau khi b&ocirc;i loại kem n&agrave;y m&agrave; cơn ngứa của trẻ giảm nhanh ch&oacute;ng lại kh&ocirc;ng hề để lại sẹo tr&ecirc;n da của b&eacute;. Đặc biệt với những b&eacute; g&aacute;i, ba mẹ sẽ kh&ocirc;ng c&ograve;n phải bận t&acirc;m về những</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">vết sẹo do muỗi đốt hay do c&ocirc;n tr&ugrave;ng cắn tr&ecirc;n da của b&eacute;.<br />\r\nMuhi trị muỗi đốt kh&aacute; hiệu quả. Những nốt muỗi đốt sưng to, tấy v&agrave; ngứa tr&ecirc;n da của trẻ sau một 1 đến 2 ng&agrave;y sử dụng sản phẩm sẽ mất hẳn. Da b&eacute; trở lại như ban đầu khi kh&ocirc;ng bị muỗi đốt. Trẻ bị c&ocirc;n tr&ugrave;ng cắn kh&ocirc;ng c&ograve;n l&agrave; nỗi lo lắng của c&aacute;c mẹ c&oacute; con nhỏ nữa.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">&nbsp;Lăn Muỗi Đốt Muhi Nhật (Kem B&ocirc;i Trị C&ocirc;n Tr&ugrave;ng Đốt)</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Nhờ c&oacute; cảm gi&aacute;c m&aacute;t lạnh sau khi b&ocirc;i loại kem n&agrave;y m&agrave; cơn ngứa của trẻ giảm nhanh ch&oacute;ng lại kh&ocirc;ng hề để lại sẹo tr&ecirc;n da của b&eacute;. Đặc biệt với những b&eacute; g&aacute;i, ba mẹ sẽ kh&ocirc;ng c&ograve;n phải bận t&acirc;m về những</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">vết sẹo do muỗi đốt hay do c&ocirc;n tr&ugrave;ng cắn tr&ecirc;n da của b&eacute;.<br />\r\nMuhi trị muỗi đốt kh&aacute; hiệu quả. Những nốt muỗi đốt sưng to, tấy v&agrave; ngứa tr&ecirc;n da của trẻ sau một 1 đến 2 ng&agrave;y sử dụng sản phẩm sẽ mất hẳn. Da b&eacute; trở lại như ban đầu khi kh&ocirc;ng bị muỗi đốt. Trẻ bị c&ocirc;n tr&ugrave;ng cắn kh&ocirc;ng c&ograve;n l&agrave; nỗi lo lắng của c&aacute;c mẹ c&oacute; con nhỏ nữa.<br />\r\n<br />\r\nXuất xứ : Nhật Bản<br />\r\nDung t&iacute;ch : 50ml</span></p>\r\n', '01-18-59-25-04-2016-1299864212363795963871735662799312538325351n.jpg', '01-18-59-25-04-2016-1299864212363795963871735662799312538325351n.jpg', 'a:1:{i:0;s:68:"01-18-59-25-04-2016-1299864212363795963871735662799312538325351n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461565139, NULL),
(103, NULL, 'Xịt chống muỗi và côn trùng cắn Nhật', 250000, 0, 0, 1, '', 2, '<p>Cho c&ocirc;n tr&ugrave;ng tr&aacute;nh xa kh&ocirc;ng lo muỗi đốt.</p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px">Cho c&ocirc;n tr&ugrave;ng tr&aacute;nh xa kh&ocirc;ng lo muỗi đốt.</span></p>\r\n', '01-20-47-25-04-2016-1247261612363745897210074485892895768287524n.jpg', '01-20-47-25-04-2016-1247261612363745897210074485892895768287524n.jpg', 'a:1:{i:0;s:68:"01-20-47-25-04-2016-1247261612363745897210074485892895768287524n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461565247, NULL),
(104, NULL, 'Lucas’ Papaw Ointment (Thuốc mỡ đu đủ Lucas) – Kem đa năng.', 150000, 0, 150000, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Lucas&rsquo; Papaw Ointment (Thuốc mỡ đu đủ Lucas) &ndash; Kem đa năng.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Lucas&rsquo; Papaw Ointment (Thuốc mỡ đu đủ Lucas) &ndash; Kem đa năng.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">&ndash; Th&agrave;nh phần l&agrave;nh t&iacute;nh, nhiều c&ocirc;ng dụng v&agrave; ph&aacute;t huy thật sự hiệu quả chứ kh&ocirc;ng chỉ l&agrave; quảng c&aacute;o.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">&ndash; Mang lại độ ẩm v&agrave; dịu tuyệt đối với tất cả c&ocirc;ng dụng.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">&ndash; Gi&aacute; th&agrave;nh rẻ, tiết kiệm, dạng tu&yacute;p tiện lợi.<br />\r\n<br />\r\n- D&ugrave;ng cho cả người lớn v&agrave; trẻ em trong trường hợp bỏng nhẹ hoặc muỗi hay c&ocirc;n tr&ugrave;ng cắn.<br />\r\n<br />\r\n&ndash;&gt; L&agrave; sản phẩm n&ecirc;n c&oacute; v&agrave; mang theo v&igrave; nhiều c&ocirc;ng dụng để ứng ph&oacute; nhất thời.</span><br />\r\n&nbsp;</p>\r\n', '01-22-16-25-04-2016-1300020812363795897205078141126497134847686n.jpg', '01-22-16-25-04-2016-1300020812363795897205078141126497134847686n.jpg', 'a:1:{i:0;s:68:"01-22-16-25-04-2016-1300020812363795897205078141126497134847686n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461565336, 1461565396),
(105, NULL, 'Milk calcium Bio island', 500000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Milk calcium Bio island l&agrave; d&ograve;ng sản phẩm c&oacute; nguồn gốc từ sữa b&ograve; non, gi&uacute;p xương v&agrave; răng ph&aacute;t triển khoẻ mạnh, c&oacute; bổ sung th&ecirc;m vitamin D gi&uacute;p trẻ ph&aacute;t triển chiều cao tối đa.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Milk calcium Bio island l&agrave; d&ograve;ng sản phẩm c&oacute; nguồn gốc từ sữa b&ograve; non, gi&uacute;p xương v&agrave; răng ph&aacute;t triển khoẻ mạnh, c&oacute; bổ sung th&ecirc;m vitamin D gi&uacute;p trẻ ph&aacute;t triển chiều cao tối đa. Đặc biệt sữa canxi Bio Island l&agrave; nguồn canxi tự nhi&ecirc;n n&ecirc;n rất dễ hấp thụ v&agrave; kh&ocirc;ng lắng cặn.</span></p>\r\n\r\n<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Hộp : 90v&nbsp;</span></p>\r\n\r\n<p><font color="#141823" face="helvetica, arial, sans-serif"><span style="font-size:14px; line-height:22.4px">Xuất xứ : &Uacute;c</span></font></p>\r\n', '04-09-47-25-04-2016-1234155511458422421075768293138607386542889n.jpg', '04-09-47-25-04-2016-1234155511458422421075768293138607386542889n.jpg', 'a:1:{i:0;s:68:"04-09-47-25-04-2016-1234155511458422421075768293138607386542889n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461575387, NULL),
(106, NULL, 'Dầu Vicks Baby Balsam', 225000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">- Nhiễm lạnh sẽ g&acirc;y ra c&aacute;c triệu chứng như ho, sổ mũi, ngạt mũi hay nặng hơn l&agrave; vi&ecirc;m đường h&ocirc; hấp, vi&ecirc;m phổi. V&igrave; thế, giữ ấm cho em b&eacute; l&agrave; việc v&ocirc; c&ugrave;ng quan trọng.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">- Dầu Vicks Baby Balsam l&agrave; sản phẩm được rất nhiều c&aacute;c b&agrave; mẹ ở nước ngo&agrave;i tin d&ugrave;ng v&agrave; l&agrave; loại dầu rất hiệu quả trong việc gi&uacute;p trẻ giảm ho, chống ngạt khi trời lạnh hoặc nằm điều h&ograve;a .</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Nhiễm lạnh sẽ g&acirc;y ra c&aacute;c triệu chứng như ho, sổ mũi, ngạt mũi hay nặng hơn l&agrave; vi&ecirc;m đường h&ocirc; hấp, vi&ecirc;m phổi. V&igrave; thế, giữ ấm cho em b&eacute; l&agrave; việc v&ocirc; c&ugrave;ng quan trọng.</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">- Dầu Vicks Baby Balsam l&agrave; sản phẩm được rất nhiều c&aacute;c b&agrave; mẹ ở nước ngo&agrave;i tin d&ugrave;ng v&agrave; l&agrave; loại dầu rất hiệu quả trong việc gi&uacute;p trẻ giảm ho, chống ngạt khi trời lạnh hoặc nằm điều h&ograve;a .</span></p>\r\n', '04-12-43-25-04-2016-123664801145842795440854303343288756227599n.jpg', '04-12-43-25-04-2016-123664801145842795440854303343288756227599n.jpg', 'a:1:{i:0;s:67:"04-12-43-25-04-2016-123664801145842795440854303343288756227599n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461575563, NULL),
(107, NULL, 'Chăn lưới 4 mùa cho bé', 170000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255)">Chăn lưới bốn m&ugrave;a l&agrave; loại chăn c&oacute; cấu tr&uacute;c c&aacute;c sợi cotton đan kiểu mắt lưới v&agrave;o với nhau. Chăn lưới ko chỉ th&iacute;ch hợp cho trẻ sơ sinh,m&agrave; c&ograve;n th&iacute;ch hợp cho người lớn đặc biệt l&agrave; người gi&agrave; v&agrave; c&aacute;c mẹ bầu.</span></p>\r\n\r\n<p>Chất liệu :100% Cotton</p>\r\n\r\n<p>Nhập khẩu từ&nbsp;Trung Quốc</p>\r\n\r\n<p>K&iacute;ch thước&nbsp;100 x 140 x 2cm</p>\r\n', '<h2>Chi tiết sản phẩm</h2>\r\n\r\n<p><strong>chăn lưới bốn m&ugrave;a cho b&eacute;</strong><span style="background-color:rgb(255, 255, 255); font-family:arial; font-size:12px">: Chăn lưới bốn m&ugrave;a h&agrave;ng xuất Nga với chất liệu 100% cotton cho b&eacute; c&oacute; giấc ngủ th&ocirc;ng tho&aacute;ng kh&ocirc;ng mồ h&ocirc;i. H&agrave;ng chỉ c&oacute; tại Colorful Shop, gi&aacute; cực y&ecirc;u.</span></p>\r\n\r\n<ul>\r\n	<li>Chăn lưới bốn m&ugrave;a l&agrave; loại chăn c&oacute; cấu tr&uacute;c đặc biệt khi c&aacute;c sợi cotton được đan kiểu mắt lưới v&agrave;o với nhau.&nbsp;Chăn lưới ko chỉ th&iacute;ch hợp cho trẻ sơ sinh, trẻ nhỏ m&agrave; c&ograve;n th&iacute;ch hợp cho người lớn đặc biệt l&agrave; người gi&agrave; v&agrave; c&aacute;c mẹ bầu để c&oacute; cảm gi&aacute;c thoải m&aacute;i nhất.</li>\r\n</ul>\r\n\r\n<p><img alt="Chăn lưới bốn mùa" src="http://www.sacmauchobe.com/media/product/16457_chan_luoi2.jpg" /></p>\r\n\r\n<h4 style="text-align:center"><span style="color:rgb(51, 102, 255)"><em><strong><span style="font-size:10pt">Chăn lưới bốn m&ugrave;a m&agrave;u xanh dương.</span></strong></em></span></h4>\r\n\r\n<ul>\r\n	<li>C&aacute;c mắt lưới ko những gi&uacute;p tạo sự th&ocirc;ng tho&aacute;ng cho l&agrave;n da b&eacute; m&agrave; c&ograve;n l&agrave;m giảm nguy cơ đột tử khi ngủ cho c&aacute;c b&eacute; v&ocirc; t&igrave;nh &uacute;p chăn l&ecirc;n mặt.</li>\r\n	<li>Chăn c&oacute; t&aacute;c dụng k&eacute;p: M&ugrave;a lạnh chăn giữ ấm cho b&eacute; khi ngủ m&agrave; ko lo bị b&iacute;,bị hầm, kh&ocirc;ng tho&aacute;t được hồ m&ocirc;i. M&ugrave;a h&egrave;, từng cơn gi&oacute; sẽ len lỏi v&agrave;o từng mắt lưới nhỏ chạm v&agrave;o da thịt b&eacute;, khiến b&eacute; lu&ocirc;n c&oacute; cảm gi&aacute;c m&aacute;t mẻ thoải m&aacute;i. Thế mới gọi l&agrave;&nbsp;<strong>Chăn lưới bốn m&ugrave;a</strong>&nbsp;được chứ.</li>\r\n	<li>C&oacute; thể giữ ấm nhiều hơn nếu gấp đ&ocirc;i chăn lại khi đắp v&igrave; c&aacute;c mắt lưới xen kẽ, đan lại với nhau.&nbsp;</li>\r\n</ul>\r\n\r\n<p><img alt="Chăn lưới bốn mùa" src="http://www.sacmauchobe.com/media/product/16457_chan_luoi4.jpg" /></p>\r\n\r\n<h4 style="text-align:center"><span style="color:rgb(51, 102, 255)"><em><strong><span style="font-size:10pt">Chăn lưới bốn m&ugrave;a m&agrave;u hồng.</span></strong></em></span></h4>\r\n\r\n<ul>\r\n	<li>C&aacute;c mắt lưới đan v&agrave;o nhau c&oacute; độ kh&iacute;t vừa phải để c&oacute; độ tho&aacute;ng kh&iacute; cho b&eacute; v&agrave; chắc chắn lại vừa tạo được độ mềm rủ chắc tay cho chăn.</li>\r\n	<li>Chăn c&oacute; độ bền cao, kh&ocirc;ng nh&atilde;o theo thời gian v&igrave; mắt lưới chắc chắn, kh&ocirc;ng phai m&agrave;u.</li>\r\n	<li>C&oacute; thể gấp lại l&agrave;m gối cho b&eacute; tho&aacute;ng đầu hoặc trải l&agrave;m thảm cho b&eacute; chơi.</li>\r\n	<li>Thậm ch&iacute;, chăn lưới bốn m&ugrave;a c&oacute; thể quấn ngo&agrave;i b&eacute; sơ sinh để tạo cảm gi&aacute;c th&ocirc;ng tho&aacute;ng thoải m&aacute;i, b&eacute; ngủ ngon giấc. C&aacute;c mẹ nhớ đặt một chiếc&nbsp;<a href="http://www.sacmauchobe.com/khan-xo-sua-golden-baby-3-lop/p16322.html" style="text-decoration: none; color: rgb(28, 91, 141); max-width: 100%; font-weight: bold;">khăn x&ocirc;</a>&nbsp;v&agrave;o cổ b&eacute; để tr&aacute;nh rớt sữa ra chăn nh&eacute;, m&ugrave;a n&agrave;y phải giặt chăn li&ecirc;n tục th&igrave; cực lắm.</li>\r\n</ul>\r\n\r\n<h4>C&aacute;ch bảo quản Chăn lưới bốn m&ugrave;a:&nbsp;</h4>\r\n\r\n<p>Giặt chăn ri&ecirc;ng với quần &aacute;o v&agrave; giặt bằng tay. Nếu giặt m&aacute;y, c&aacute;c mẹ n&ecirc;n cho v&agrave;o t&uacute;i giặt để đảm bảo độ bền. Vắt nhẹ v&agrave; phơi trong b&oacute;ng r&acirc;m.</p>\r\n\r\n<p>Kh&ocirc;ng d&ugrave;ng chất tẩy, chỉ l&agrave; ủ khi cần thiết.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<table border="1" bordercolor="#CCCCCC" cellpadding="3" cellspacing="0" id="tb-product-spec" style="background-color:rgb(255, 255, 255); border-collapse:collapse; border-color:rgb(238, 238, 238); color:rgb(0, 0, 0); font-family:arial; font-size:12px; line-height:21px; width:384px">\r\n	<tbody>\r\n		<tr>\r\n			<td style="border-color:rgb(238, 238, 238)">&nbsp;</td>\r\n			<td style="border-color:rgb(238, 238, 238)">&nbsp;</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n', '04-21-16-25-04-2016-1299862112390283394556322455009036866561048n.jpg', '04-21-16-25-04-2016-1299862112390283394556322455009036866561048n.jpg', 'a:1:{i:0;s:68:"04-21-16-25-04-2016-1299862112390283394556322455009036866561048n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461576076, NULL),
(108, NULL, 'Giày HM xuất', 220000, 0, 0, 1, '', 1, '<p>Gi&agrave;y HM xuất da mềm mại cho đ&ocirc;i ch&acirc;n b&eacute; y&ecirc;u.</p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px">Gi&agrave;y HM xuất da mềm mại cho đ&ocirc;i ch&acirc;n b&eacute; y&ecirc;u.</span></p>\r\n', '04-27-12-25-04-2016-1301276312390282527889743375400579759577166n.jpg', '04-27-12-25-04-2016-1301276312390282527889743375400579759577166n.jpg', 'a:1:{i:0;s:68:"04-27-12-25-04-2016-1301276312390282527889743375400579759577166n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461576432, NULL),
(109, NULL, 'Mũ HM cho bé', 125000, 0, 0, 1, '', 2, '<p>Mũ HM cho b&eacute; y&ecirc;u c&aacute; t&iacute;nh.</p>\r\n\r\n<p>&nbsp;</p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(51, 51, 51); font-family:sans-serif,arial,verdana,trebuchet ms; font-size:13px">Mũ HM cho b&eacute; y&ecirc;u c&aacute; t&iacute;nh.</span></p>\r\n\r\n<p><font face="sans-serif, arial, verdana, trebuchet ms">H&agrave;ng Trung Quốc xuất khẩu</font></p>\r\n\r\n<p><font face="sans-serif, arial, verdana, trebuchet ms">C&oacute; sz S,M,L,XL c&oacute; chun sau.</font></p>\r\n', '04-32-24-25-04-2016-1292327112300604936857504744930606582506473n.jpg', '04-32-24-25-04-2016-1292327112300604936857504744930606582506473n.jpg', 'a:1:{i:0;s:68:"04-32-24-25-04-2016-1292327112300604936857504744930606582506473n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461576744, NULL);
INSERT INTO `web_product` (`product_id`, `product_code`, `product_name`, `product_price_sell`, `product_price_market`, `product_price_input`, `product_type_price`, `product_selloff`, `product_is_hot`, `product_sort_desc`, `product_content`, `product_image`, `product_image_hover`, `product_image_other`, `product_order`, `category_id`, `category_name`, `quality_input`, `quality_out`, `product_status`, `is_block`, `user_shop_id`, `user_shop_name`, `is_shop`, `shop_province`, `time_created`, `time_update`) VALUES
(110, NULL, 'Mũ Next cho bé', 135000, 0, 0, 1, '', 2, '<p>Mũ Next cho b&eacute; c&aacute; t&iacute;nh.</p>\r\n', '<p>H&agrave;ng Trung Quốc xuất khẩu sang AUT</p>\r\n\r\n<p>C&oacute; sx S,M,L,XL</p>\r\n', '04-35-19-25-04-2016-1296391512300605036857492923470732904864227n.jpg', '04-35-19-25-04-2016-1296391512300605036857492923470732904864227n.jpg', 'a:1:{i:0;s:68:"04-35-19-25-04-2016-1296391512300605036857492923470732904864227n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461576919, NULL),
(111, NULL, 'Kem chống nắng DABO white sunblock cream SPF50 PA+++', 110000, 0, 0, 1, '', 2, '<p><strong>Mi&ecirc;u tả:</strong></p>\r\n\r\n<p><strong>DABO white sunblock cream SPF50 PA+++</strong><br />\r\nNh&atilde;n hiệu: NEXXEN<br />\r\nDung t&iacute;ch: 70 ml<br />\r\nXuất xứ: Made in Korea</p>\r\n', '<p><span style="background-color:rgb(236, 232, 222); color:rgb(51, 51, 51); font-family:verdana,geneva,sans-serif; font-size:12px"><span style="font-size:14px">Với c&ocirc;ng thức ưu việt vượt trội t&aacute;c dụng nổi bất l&agrave; bảo vệ da khỏi bị đen, sạm, ch&aacute;y nắng, n&aacute;m, t&agrave;n nhang v&agrave; l&atilde;o h&oacute;a do &aacute;nh nắng mặt trời, đặc biệt l&agrave; khả năng ngăn chặn t&aacute;c hại của tia UVA v&agrave; tia UVB đối với da.</span></span><br />\r\n<br />\r\n<span style="background-color:rgb(236, 232, 222); color:rgb(51, 51, 51); font-family:verdana,geneva,sans-serif; font-size:12px"><span style="font-size:14px">Kem chống nắng Dabo c&oacute; khả năng ngăn cản &nbsp;tia UVA c&oacute; trong &aacute;nh nắng mặt trời một c&aacute;ch tối ưu (độ PA đạt mức cao nhất l&agrave; PA+++ ). Do đ&oacute;, da bạn được bảo vệ khỏi bị đen, sạm, ch&aacute;y nắng, ngăn ngừa ung thư da từ t&aacute;c hại của tia UVA c&oacute; trong &nbsp;&aacute;nh nắng mặt trời.</span></span><br />\r\n<br />\r\n<span style="background-color:rgb(236, 232, 222); color:rgb(51, 51, 51); font-family:verdana,geneva,sans-serif; font-size:14px">Kem chống nắng Dabo b</span><span style="background-color:rgb(236, 232, 222); color:rgb(51, 51, 51); font-family:verdana,geneva,sans-serif; font-size:12px"><span style="font-size:14px">ảo vệ da chống lại tia UVB từ hơn 8 giờ. Do đ&oacute;&nbsp;bảo&nbsp;vệ da bạn khỏi bị n&aacute;m, t&agrave;n nhang v&agrave; nhăn nheo (l&atilde;o h&oacute;a) &nbsp;khi tiếp x&uacute;c với &aacute;nh nắng mặt trời li&ecirc;n tục trong hơn 8 giờ.</span></span><br />\r\n<br />\r\n&nbsp;</p>\r\n\r\n<div style="margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: Arial, Helvetica, sans-serif; font-size: 12px; line-height: 18px; text-align: center; background-color: rgb(236, 232, 222);"><img alt="DABO white sunblock cream SPF50 " src="http://chuyenhangxachtay.vn/Uploaded/Members/5701/images/DABO%20white%20sunblock%20cream%20SPF50%204.jpg" /></div>\r\n\r\n<div style="margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: Arial, Helvetica, sans-serif; font-size: 12px; line-height: 18px; text-align: center; background-color: rgb(236, 232, 222);">&nbsp;</div>\r\n\r\n<p><br />\r\n&nbsp;</p>\r\n\r\n<div style="margin: 0px; padding: 0px; color: rgb(51, 51, 51); font-family: Arial, Helvetica, sans-serif; font-size: 12px; line-height: 18px; text-align: center; background-color: rgb(236, 232, 222);"><span style="font-family:verdana,geneva,sans-serif"><span style="font-size:14px"><img alt="DABO white sunblock cream SPF50 " src="http://chuyenhangxachtay.vn/Uploaded/Members/5701/images/DABO%20white%20sunblock%20cream%20SPF50%203.jpg" /></span></span></div>\r\n\r\n<p><br />\r\n&nbsp;</p>\r\n\r\n<h3><span style="font-family:verdana,geneva,sans-serif"><span style="font-size:14px">C&ocirc;ng dụng:</span></span></h3>\r\n\r\n<p><span style="font-size:14px"><span style="font-family:verdana,geneva,sans-serif">Ngăn ngừa đen, sạm v&agrave; l&atilde;o h&oacute;a da bởi tia nắng mặt trời, ngăn ngừa n&aacute;m v&agrave; t&agrave;n nhang v&agrave; c&aacute;c vết nhăn tr&ecirc;n da do tiếp x&uacute;c với &aacute;nh nắng.</span></span><br />\r\n&nbsp;</p>\r\n\r\n<p><span style="font-family:verdana,geneva,sans-serif"><span style="font-size:14px"><strong>C&aacute;ch sử dụng:</strong>&nbsp;Thoa đều&nbsp;l&ecirc;n to&agrave;n bộ v&ugrave;ng da sẽ tiếp x&uacute;c với &aacute;nh nắng. Để c&oacute; hiệu quả tối ưu, cần thoa kem trước khi đi ra ngo&agrave;i từ 20-25 ph&uacute;t trở l&ecirc;n. Sau khi d&ugrave;ng xong n&ecirc;n l&agrave;m sạch lớp kem cũ tr&ecirc;n da bằng việc tẩy trang nhẹ.<br />\r\n<br />\r\n<br />\r\nSản phẩm ph&ugrave; hợp với mọi loại da, đặc biệt da dầu.&nbsp;</span></span></p>\r\n\r\n<h3>&nbsp;</h3>\r\n\r\n<h3 style="text-align:center"><span style="font-family:verdana,geneva,sans-serif"><span style="font-size:14px"><img alt="" src="http://chuyenhangxachtay.vn/Uploaded/Members/5701/images/DABO%20white%20sunblock%20cream%20SPF50%206.jpg" /></span></span></h3>\r\n\r\n<h3>&nbsp;</h3>\r\n\r\n<h3 style="text-align:center">&nbsp;</h3>\r\n\r\n<h3><span style="font-family:verdana,geneva,sans-serif"><span style="font-size:14px">Khuyến c&aacute;o đối với sản phẩm:&nbsp;</span></span></h3>\r\n\r\n<p><span style="font-family:verdana,geneva,sans-serif"><span style="font-size:14px">-Tr&aacute;nh tiếp x&uacute;c với nước v&igrave; n&oacute; sẽ khiến phần kem chống nắng bị mất dần đi v&agrave; hiệu quả chống nắng giảm s&uacute;t.<br />\r\n- C&aacute;c bạn tuyệt đối kh&ocirc;ng thoa kem chống nắng v&agrave;o c&aacute;c phần ni&ecirc;m mạc bị tổn thương, nhất l&agrave; ở v&ugrave;ng mắt, mũi, miệng&hellip; v&igrave; n&oacute; c&oacute; thể g&acirc;y k&iacute;ch ứng rất mạnh.<br />\r\n- Kh&ocirc;ng d&ugrave;ng kem chống nắng kết hợp với thuốc b&ocirc;i ngo&agrave;i da. Điều n&agrave;y c&oacute; thể dẫn đến t&igrave;nh trạng tương t&aacute;c thuốc..</span></span></p>\r\n', '04-43-28-25-04-2016-dabo-white-sunblock-cream-spf50-1.jpg', '04-43-28-25-04-2016-dabo-white-sunblock-cream-spf50-1.jpg', 'a:1:{i:0;s:57:"04-43-28-25-04-2016-dabo-white-sunblock-cream-spf50-1.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461577329, NULL),
(112, NULL, 'Kem chống nắng 3w Clinic Intensive UV Sunblock Cream SPF 50 Pa+++', 110000, 0, 0, 1, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(51, 51, 51)">Kem chống nắng 3w Clinic Intensive UV Sunblock Cream SPF 50 Pa+++</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(51, 51, 51)">- Dung t&iacute;ch: 70ml . Ph&ugrave; hợp với: Mọi loại da</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(51, 51, 51)">- Th&agrave;nh phần: Với chiết xuất từ th&agrave;nh phần c&acirc;y nha đam, kem c&oacute; t&aacute;c dụng bảo vệ da, tạo m&agrave;n ngăn tia tử ngoại từ &aacute;nh nắng mặt trời đồng thời c&ograve;n c&oacute; t&aacute;c dụng duy tr&igrave; độ ẩm, cung cấp nước, bổ sung c&aacute;c chất c&ograve;n thiếu nu&ocirc;i dưỡng l&agrave;n da của bạn.</span></p>\r\n', '<p><span style="color:rgb(51, 51, 51); font-family:new roboto,helvetica,arial,sans-serif">Kem chống nắng 3w Clinic Intensive UV Sunblock Cream SPF 50 Pa+++</span><br />\r\n<span style="color:rgb(51, 51, 51); font-family:new roboto,helvetica,arial,sans-serif">- Dung t&iacute;ch: 70ml . Ph&ugrave; hợp với: Mọi loại da</span><br />\r\n<span style="color:rgb(51, 51, 51); font-family:new roboto,helvetica,arial,sans-serif">- Th&agrave;nh phần: Với chiết xuất từ th&agrave;nh phần c&acirc;y nha đam, kem c&oacute; t&aacute;c dụng bảo vệ da, tạo m&agrave;n ngăn tia tử ngoại từ &aacute;nh nắng mặt trời đồng thời c&ograve;n c&oacute; t&aacute;c dụng duy tr&igrave; độ ẩm, cung cấp nước, bổ sung c&aacute;c chất c&ograve;n thiếu nu&ocirc;i dưỡng l&agrave;n da của bạn.</span><br />\r\n<span style="color:rgb(51, 51, 51); font-family:new roboto,helvetica,arial,sans-serif">- C&ocirc;ng dụng: Chỉ số chống nắng cao: SPF 50 PA +++ bảo vệ da tối ưu trong 120 ph&uacute;t hoạt động ngo&agrave;i trời nắng.</span><br />\r\n<span style="color:rgb(51, 51, 51); font-family:new roboto,helvetica,arial,sans-serif">- Bảo vệ da dịu nhẹ, an to&agrave;n, kh&ocirc;ng g&acirc;y k&iacute;ch ứng.</span><br />\r\n<span style="color:rgb(51, 51, 51); font-family:new roboto,helvetica,arial,sans-serif">- Sản phẩm th&iacute;ch hợp với mọi loại da v&agrave; kh&ocirc;ng g&acirc;y nhờn.</span><br />\r\n<span style="color:rgb(51, 51, 51); font-family:new roboto,helvetica,arial,sans-serif">- Dưỡng chất thấm s&acirc;u v&agrave; nu&ocirc;i dưỡng bảo vệ da từ b&ecirc;n trong, tạo cho bạn cảm gi&aacute;c thoải m&aacute;i.</span><br />\r\n<span style="color:rgb(51, 51, 51); font-family:new roboto,helvetica,arial,sans-serif">- Lớp kem mềm mại, hương thơm dễ chịu sau khi được thoa l&ecirc;n da sẽ thấm s&acirc;u v&agrave;o b&ecirc;n trong tế b&agrave;o, kh&ocirc;ng g&acirc;y nhờn v&agrave; mang lại cho bạn cảm gi&aacute;c thực sự thoải m&aacute;i.</span><br />\r\n<span style="color:rgb(51, 51, 51); font-family:new roboto,helvetica,arial,sans-serif">****C&aacute;ch d&ugrave;ng: D&ugrave;ng sau c&aacute;c bước dưỡng da v&agrave; trước khi trang điểm. B&ocirc;i trước khi ra nắng 30&prime; để đạt hiệu quả chống nắng tốt nhất. B&ocirc;i một lượng kem vừa phải l&ecirc;n ng&oacute;n tay trỏ, xoa đều khắp da mặt theo hướng từ trong ra ngo&agrave;i.</span><br />\r\n<span style="color:rgb(51, 51, 51); font-family:new roboto,helvetica,arial,sans-serif">- Xuất xứ: H&agrave;n Quốc</span><br />\r\n<span style="color:rgb(51, 51, 51); font-family:new roboto,helvetica,arial,sans-serif">- H&atilde;ng sản xuất: 3W Clinic.</span></p>\r\n', '04-48-07-25-04-2016-kem-chong-nang-3w-clinic-500.png', '04-48-07-25-04-2016-kem-chong-nang-3w-clinic-500.png', 'a:1:{i:0;s:52:"04-48-07-25-04-2016-kem-chong-nang-3w-clinic-500.png";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461577687, NULL),
(113, NULL, 'THE FACESHOP NATURAL SUN SUPER PERFECT SUN CREAM', 160000, 0, 0, 1, '', 2, '<p>Xuất xứ:H&agrave;n Quốc</p>\r\n\r\n<p>D&ograve;ng chức năng:Dưỡng trắng da</p>\r\n\r\n<p>Loại da:Mọi loại da</p>\r\n\r\n<p>Hoạt t&iacute;nh:</p>\r\n\r\n<p>Dung t&iacute;ch/Khối lượng:50ml</p>\r\n', '<div style="clear:both;">Th&ocirc;ng tin</div>\r\n\r\n<p><strong><em>Natural Sun Super Perfect Sun Cream</em></strong>&nbsp;với chiết xuất từ 600&micro;m&nbsp;hoa hướng dương c&oacute; t&aacute;c dụng ngăn chặn c&aacute;c tia UVA v&agrave; UVB ảnh hưởng đến l&agrave;n da. Bảo vệ l&agrave;n da tốt hơn v&agrave; giảm dầu nhờn, tạo cảm gi&aacute;c tho&aacute;i m&aacute;i, tự tin khi đi ra đường.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img alt="" height="547" src="http://myphamhq.vn/uploadwb/image/the%20faceshop/kem%20chong%20nang/the%20faceshop%20Natural%20Sun%20Super%20Perfect%20Sun%20Cream%202.jpg" width="555" /><img alt="" height="228" src="http://myphamhq.vn/uploadwb/image/the%20faceshop/kem%20chong%20nang/the%20faceshop%20Natural%20Sun%20Super%20Perfect%20Sun%20Cream%203.jpg" width="555" />&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Hướng dẫn sử dụng:</strong></p>\r\n\r\n<p>Đầu ti&ecirc;n mấy b&eacute; b&ocirc;i một lượng vừa đủ l&ecirc;n da mặt v&agrave; cổ sau đ&oacute; t&aacute;n theo chiều cấu tạo da</p>\r\n\r\n<p>Sử dụng trước v&agrave; sau khi ra ngo&agrave;i nắng trước 10 ph&uacute;t&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Khuyến c&aacute;o:&nbsp;</strong></p>\r\n\r\n<p>- Chỉ sử dụng trực tiếp tr&ecirc;n l&agrave;n da.</p>\r\n\r\n<p>- Tr&aacute;nh xa tầm tay của trẻ em.</p>\r\n\r\n<p>- Kh&ocirc;ng b&ocirc;i l&ecirc;n vết thương hở hoặc l&agrave;n da bị trầy xước. Tr&aacute;nh b&ocirc;i v&agrave;o mắt.</p>\r\n\r\n<div>&nbsp;</div>\r\n', '04-50-41-25-04-2016-the-faceshop-natural-sun-super-perfect-sun-cream-2.jpg', '04-50-41-25-04-2016-the-faceshop-natural-sun-super-perfect-sun-cream-2.jpg', 'a:1:{i:0;s:74:"04-50-41-25-04-2016-the-faceshop-natural-sun-super-perfect-sun-cream-2.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461577841, NULL),
(114, NULL, 'Kem chống nắng Sundance của Đức', 265000, 0, 265000, 1, '', 2, '<p><span style="color:rgb(255, 0, 0)"><strong>Kem chống nắng Sundance của Đức.</strong></span></p>\r\n\r\n<p>Bạn đang chuẩn bị tham gia một buổi du lịch/ d&atilde; ngoại ngo&agrave;i trời nhưng lại lo lắng về l&agrave;n da của m&igrave;nh sẽ bỏng r&aacute;t khi tiếp x&uacute;c l&acirc;u với &aacute;nh nắng.&nbsp;<em>Kem chống nắng Sundance của Đức</em>&nbsp;ch&iacute;nh l&agrave; giải ph&aacute;p tối ưu gi&uacute;p bạn ngăn chặn những tổn hại về da để bạn lu&ocirc;n tự tin v&agrave; rạng ngời ngay cả trong c&aacute;i nắng oi bức.</p>\r\n', '<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small"><strong>Xuất xứ v&agrave; c&ocirc;ng dụng của kem chống nắng Sundance của Đức.</strong></span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small"><em>Kem chống nắng Sundance&nbsp;</em>l&agrave; một trong những sản phẩm kem chống nắng được kh&aacute;ch h&agrave;ng ưa chuộng v&agrave; tin d&ugrave;ng trong suốt thời gian qua. Sundance l&agrave; sản phẩm chiến lược đến từ DM- c&ocirc;ng ty mỹ phẩm h&agrave;ng đầu&nbsp; của Đức. Đ&acirc;y l&agrave; thương hiệu quen thuộc của phụ nữ Đức cũng như h&agrave;ng triệu phụ nữ t&ecirc;n to&agrave;n Thế Giới. Với chỉ số chống nắng kh&aacute; cao, Sundance gi&uacute;p ngăn chặn những t&aacute;c hại từ tia UV đồng thời bảo vệ l&agrave;n da lu&ocirc;n khỏe mạnh. Đặc biệt sản phẩm n&agrave;y c&oacute; hiệu quả sử dụng k&eacute;o d&agrave;i sau nhiều giờ sử dụng, kh&ocirc;ng g&acirc;y cảm gi&aacute;c bết r&iacute;t tr&ecirc;n da. Th&ocirc;ng thường, da bạn sẽ trở n&ecirc;n xỉn m&agrave;u, kh&ocirc; r&aacute;p sau khi vui đ&ugrave;a dưới biển trong những ng&agrave;y h&egrave;, &nbsp;<em>kem chống nắng Sundance của Đức</em>&nbsp;sẽ tạo n&ecirc;n lớp m&agrave;n bảo vệ kh&ocirc;ng rửa tr&ocirc;i ngay cả khi bạn thỏa th&iacute;ch vui đ&ugrave;a h&agrave;ng giờ liền dưới nước.</span></p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small"><img alt="" height="334" src="http://mommybaby.vn/upload-files/4404436tai_xuong__1.jpg" width="500" /></span></p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small"><em>Kem chống nắng Sundance của Đức tạo n&ecirc;n lớp m&agrave;ng bảo vệ tối ưu cho da.</em></span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small">&nbsp;</span></strong><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small"><strong>Ưu thế vượt trội của kem chống nắng Sundance của Đức.</strong></span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small">Với c&ocirc;ng nghệ ti&ecirc;n tiến nhất,&nbsp;<em>kem chống nắng Sundance của Đức</em>&nbsp;tạo n&ecirc;n một lớp m&agrave;ng lọc Meroxyl ngăn chặn tối ưu c&aacute;c tia tử ngoại g&acirc;y hại cho l&agrave;n da. Đồng thời việc sử dụng thường xuy&ecirc;n cũng gi&uacute;p giảm nguy cơ h&igrave;nh th&agrave;nh c&aacute;c đốm n&acirc;u, th&acirc;m n&aacute;m, kh&ocirc; r&aacute;p v&agrave; xỉn m&agrave;u da do t&aacute;c động trực tiếp của &aacute;nh nắng mặt trời. Ngo&agrave;i việc l&agrave;m giảm qu&aacute; tr&igrave;nh l&atilde;o h&oacute;a da do t&aacute;c động m&ocirc;i trường, Sundance c&ograve;n l&agrave;m cải thiện sắc tố da, gi&uacute;p da đều m&agrave;u, rạng rỡ. Đặc biệt,&nbsp;<em>kem chống nắng Sundance của Đức</em>&nbsp;c&oacute; thể sử dụng cho cả mặt v&agrave; to&agrave;n th&acirc;n n&ecirc;n kh&aacute;ch h&agrave;ng ho&agrave;n to&agrave;n c&oacute; thể y&ecirc;n t&acirc;m m&agrave; kh&ocirc;ng lo sợ k&iacute;ch ứng da.</span></p>\r\n\r\n<p style="text-align:center"><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small"><img alt="" height="669" src="http://mommybaby.vn/upload-files/KCNnguoilon.jpg" width="500" /></span></p>\r\n\r\n<p style="text-align:center"><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small"><em>Tạm biệt l&agrave;n da đen sạm, sỉn m&agrave;u với kem chống nắng Sundance của Đức.</em></span></p>\r\n\r\n<p style="text-align:center">&nbsp;</p>\r\n\r\n<p style="text-align:center">&nbsp;</p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small"><strong>C&aacute;ch sử dụng, liều d&ugrave;ng v&agrave; một v&agrave;i lưu &yacute; về kem chống nắng Sundance của Đức.</strong></span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small">- Liều d&ugrave;ng: lấy một lượng vừa đủ&nbsp;<em>kem chống nắng Sundance của Đức</em>, thoa đều l&ecirc;n to&agrave;n bộ bề mặt da mặt v&agrave; to&agrave;n th&acirc;n( những vị tr&iacute; dễ chịu ảnh hưởng của &aacute;nh nắng mặt trời: cổ, vai, c&aacute;nh tay&hellip;). Lưu &yacute;: kh&ocirc;ng n&ecirc;n thoa một lớp&nbsp; d&agrave;y, m&agrave; chỉ một lớp mỏng vừa đủ.</span></p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small">- C&aacute;ch d&ugrave;ng:</span></p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small">+ N&ecirc;n thoa 30 ph&uacute;t trước khi ra nắng để kem được thẩm thấu v&agrave;o da v&agrave; ph&aacute;t huy t&aacute;c dụng.</span></p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small">+ Khi tiếp x&uacute;c qu&aacute; l&acirc;u dưới nắng, sau 3-4 giờ n&ecirc;n thoa kem lại một lần để đảm bảo hiệu quả chống nắng tối ưu.</span></p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small">-&nbsp;<em>Kem chống nắng Sundance của Đức</em>&nbsp;ho&agrave;n to&agrave;n kh&ocirc;ng g&acirc;y k&iacute;ch ứng da, kể cả da nhờn v&agrave; mụn.</span></p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small">- Đối với những bạn g&aacute;i thường xuy&ecirc;n trang điểm, c&oacute; thể thoa một lớp Sundance b&ecirc;n dưới lớp phấn trang điểm để lớp nền được ho&agrave;n hảo hơn đồng thời bảo vệ tốt cho da.</span></p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small">- &hellip;.</span></p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small"><img alt="" height="667" src="http://mommybaby.vn/upload-files/IMG_2650_zpscdb56fe7_1.jpg" width="500" /></span></p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small"><em>Kem chống nắng Sundance của Đức gi&uacute;p bảo vệ da khỏi t&aacute;c hại của &aacute;nh mắt mặt trời v&agrave; cả tia UVA,UVB.</em></span></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><span style="font-family:tahoma,arial,helvetica,sans-serif; font-size:small"><em>Kem chống nắng Sundance của Đức</em>&nbsp;được xem như phương ph&aacute;p bảo vệ l&agrave;n da khỏi những t&aacute;c hại của &aacute;nh nắng mặt trời như: sạm da, th&acirc;m n&aacute;m, da kh&ocirc; r&aacute;p, kh&ocirc;ng đều m&agrave;u&hellip; Sản phẩm n&agrave;y ho&agrave;n to&agrave;n kh&ocirc;ng chứa hương liệu n&ecirc;n kh&ocirc;ng g&acirc;y m&ugrave;i kh&oacute; chịu khi sử dụng. Sundance g&oacute;p phần mang đến cho bạn l&agrave;n da khỏe khoắn, mịn m&agrave;ng c&ugrave;ng vẻ tươi tắn, rạng ngời ngay cả trong những ng&agrave;y h&egrave; oi bức.</span></p>\r\n', '04-53-20-25-04-2016-1280289411989647301286606378750061794333028n.jpg', '04-53-20-25-04-2016-1280289411989647301286606378750061794333028n.jpg', 'a:1:{i:0;s:68:"04-53-20-25-04-2016-1280289411989647301286606378750061794333028n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461578000, 1461578177),
(115, NULL, 'Kính Dior Super full box', 450000, 0, 0, 1, '', -1, '<p>K&iacute;nh thời trang.</p>\r\n', '<p>K&iacute;nh thời trang.</p>\r\n', '04-56-59-25-04-2016-101270612079262458991755116683219684675903n.jpg', '04-56-59-25-04-2016-101270612079262458991755116683219684675903n.jpg', 'a:1:{i:0;s:67:"04-56-59-25-04-2016-101270612079262458991755116683219684675903n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461578219, NULL),
(116, NULL, 'Kính Versace super  full box', 450000, 0, 0, 1, '', -1, '<p>K&iacute;nh thời trang.</p>\r\n', '<p>K&iacute;nh thời trang.</p>\r\n', '04-58-25-25-04-2016-1283256412079269458991055304544238410475637n.jpg', '04-58-25-25-04-2016-1283256412079269458991055304544238410475637n.jpg', 'a:1:{i:0;s:68:"04-58-25-25-04-2016-1283256412079269458991055304544238410475637n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461578305, NULL),
(117, NULL, 'Kính Miumiu super full box', 420000, 0, 0, 1, '', -1, '<p>K&iacute;nh thời trang</p>\r\n', '<p>K&iacute;nh thời trang.</p>\r\n', '04-59-54-25-04-2016-128145521217528764938923727355394568717176n.jpg', '04-59-54-25-04-2016-128145521217528764938923727355394568717176n.jpg', 'a:1:{i:0;s:67:"04-59-54-25-04-2016-128145521217528764938923727355394568717176n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461578394, NULL),
(118, NULL, 'Kính Miumiu super full box', 450000, 0, 0, 1, '', -1, '<p>k&iacute;nh thời trang</p>\r\n', '<p>K&iacute;nh thời trang.</p>\r\n', '05-01-44-25-04-2016-130064601233263366698796392219420919203344n.jpg', '05-01-44-25-04-2016-130064601233263366698796392219420919203344n.jpg', 'a:1:{i:0;s:67:"05-01-44-25-04-2016-130064601233263366698796392219420919203344n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461578504, NULL),
(119, NULL, 'Kính Channel super fullbox', 450000, 0, 0, 1, '', -1, '<p>K&iacute;nh thời trang</p>\r\n', '<p>K&iacute;nh thời trang.</p>\r\n', '05-02-57-25-04-2016-1293823012332633466987988258381412463205447n.jpg', '05-02-57-25-04-2016-1293823012332633466987988258381412463205447n.jpg', 'a:1:{i:0;s:68:"05-02-57-25-04-2016-1293823012332633466987988258381412463205447n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461578577, NULL),
(120, NULL, 'Kính Channel super fullbox', 450000, 0, 0, 1, '', 2, '<p>K&iacute;nh thời trang</p>\r\n', '<p>k&iacute;nh thời trang.</p>\r\n', '05-04-04-25-04-2016-1300709212332633300321338258299426756181108n.jpg', '05-04-04-25-04-2016-1300709212332633300321338258299426756181108n.jpg', 'a:1:{i:0;s:68:"05-04-04-25-04-2016-1300709212332633300321338258299426756181108n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461578644, NULL),
(122, NULL, 'Kính Rayban super fullbox', 550000, 0, 0, 1, '', -1, '<p>K&iacute;nh thời trang</p>\r\n', '<p>K&iacute;nh thời trang.</p>\r\n', '05-06-14-25-04-2016-1293308012234587776792555795939633267287327n.jpg', '05-06-14-25-04-2016-1293308012234587776792555795939633267287327n.jpg', 'a:1:{i:0;s:68:"05-06-14-25-04-2016-1293308012234587776792555795939633267287327n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461578774, NULL),
(123, NULL, 'Kính Dior Super full box', 450000, 0, 0, 1, '', -1, '<p>K&iacute;nh thời trang</p>\r\n', '<p>K&iacute;nh thời trang</p>\r\n', '05-08-21-25-04-2016-191809312332633966987936429370501031445875n.jpg', '05-08-21-25-04-2016-191809312332633966987936429370501031445875n.jpg', 'a:1:{i:0;s:67:"05-08-21-25-04-2016-191809312332633966987936429370501031445875n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461578901, NULL),
(124, NULL, ' Kính Mắt Thời Trang Gentle Monster', 550000, 0, 0, 1, '', -1, '<p>K&iacute;nh thời trang</p>\r\n', '<p>K&iacute;nh thời trang</p>\r\n', '05-09-48-25-04-2016-1293819812332634700321196032913807547118337n.jpg', '05-09-48-25-04-2016-1293819812332634700321196032913807547118337n.jpg', 'a:1:{i:0;s:68:"05-09-48-25-04-2016-1293819812332634700321196032913807547118337n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461578988, NULL),
(125, NULL, 'Kính Rayban super fullbox dáng gập', 600000, 0, 600000, 1, '', -1, '<p>K&iacute;nh thời trang</p>\r\n', '<p>K&iacute;nh thời trang</p>\r\n', '05-11-25-25-04-2016-1299861112332635400321124058500879931026472n.jpg', '05-11-25-25-04-2016-1299861112332635400321124058500879931026472n.jpg', 'a:1:{i:0;s:68:"05-11-25-25-04-2016-1299861112332635400321124058500879931026472n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461579085, 1461579149),
(126, NULL, 'Kính Place Mỹ cho bé yêu', 220000, 0, 0, 1, '', -1, '<p>K&iacute;nh thời trang cho b&eacute;</p>\r\n', '<p>K&iacute;nh thời trang cho b&eacute;</p>\r\n', '05-13-16-25-04-2016-1259260512218697145048282489154061304834419n.jpg', '05-13-16-25-04-2016-1259260512218697145048282489154061304834419n.jpg', 'a:1:{i:0;s:68:"05-13-16-25-04-2016-1259260512218697145048282489154061304834419n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461579195, NULL),
(127, NULL, 'Kính Sundance cho bé UV 100%', 250000, 0, 0, 1, '', -1, '<p>K&iacute;nh thời trang cho b&eacute;</p>\r\n', '<p>K&iacute;nh thời trang cho b&eacute;</p>\r\n', '05-14-32-25-04-2016-1282144912079313958986608520891053696456129n.jpg', '05-14-32-25-04-2016-1282144912079313958986608520891053696456129n.jpg', 'a:1:{i:0;s:68:"05-14-32-25-04-2016-1282144912079313958986608520891053696456129n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461579272, NULL),
(128, NULL, 'Kính Rayban cho bé yêu', 210000, 0, 0, 1, '', 2, '<p>K&iacute;nh thời trang cho b&eacute;</p>\r\n', '<p>K&iacute;nh thời trang cho b&eacute; y&ecirc;u&nbsp;</p>\r\n\r\n<p>C&oacute; nhiều m&agrave;u để lựa chọn : Xanh l&aacute;, v&agrave;ng, xanh da trời, xanh da trời pha xanh l&aacute; fullbox</p>\r\n', '05-16-25-25-04-2016-129634461233166476708485228427484463522288n.jpg', '05-16-25-25-04-2016-129634461233166476708485228427484463522288n.jpg', 'a:1:{i:0;s:67:"05-16-25-25-04-2016-129634461233166476708485228427484463522288n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461579385, NULL),
(129, NULL, 'Áo chống nắng Uniqlo Nhật ', 450000, 0, 0, 1, '', -1, '<p><strong>&nbsp;&Aacute;o chống nắng Uniqlo Nhật Bản chống tia cực t&iacute;m bảo vệ da</strong></p>\r\n\r\n<p>&Aacute;nh nắng mặt trời ch&iacute;nh l&agrave; một trong những kẻ th&ugrave; số 1 của l&agrave;n da.<em><strong>&nbsp;&Aacute;o chống nắng Uniqlo của Nhật&nbsp;</strong></em>sẽ l&agrave; &ldquo;chiến binh dũng cảm&rdquo; bảo vệ hiệu quả l&agrave;n da của bạn trước nguy cơ bị kh&ocirc; r&aacute;p, sạm đen dưới t&aacute;c động của &aacute;nh nắng mặt trời.</p>\r\n', '<p style="text-align:center"><span style="font-family:arial,helvetica,sans-serif"><strong><span style="font-size:18pt">&nbsp;&Aacute;o chống nắng Uniqlo Nhật Bản chống tia cực t&iacute;m bảo vệ da</span></strong></span></p>\r\n\r\n<p style="text-align:justify"><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">&Aacute;nh nắng mặt trời ch&iacute;nh l&agrave; một trong những kẻ th&ugrave; số 1 của l&agrave;n da.<em><strong><a href="http://chiaki.vn/ao-chong-nang-uniqlo-nhat-ban-chong-tia-cuc-tim-bao-ve-da" style="box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(51, 122, 183); text-decoration: none; background-color: transparent;">&nbsp;&Aacute;o chống nắng Uniqlo của Nhật&nbsp;</a></strong></em>sẽ l&agrave; &ldquo;chiến binh dũng cảm&rdquo; bảo vệ hiệu quả l&agrave;n da của bạn trước nguy cơ bị kh&ocirc; r&aacute;p, sạm đen dưới t&aacute;c động của &aacute;nh nắng mặt trời.</span></p>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:11pt"><img alt="Áo chống nắng Uniqlo được rất nhiều người tin chọn sử dụng" height="442" src="http://chiaki.vn/upload/news/content/2016/02/ao-chong-nang-uniqlo-nhat-ban4-chiaki-vn-jpg-1455596616-16022016112336.jpg" width="442" /></span></p>\r\n\r\n<p style="text-align:center"><em><span style="font-family:arial,helvetica,sans-serif; font-size:10pt">&Aacute;o chống nắng Uniqlo được rất nhiều người tin chọn sử dụng</span></em></p>\r\n\r\n<h3 style="text-align:justify"><span style="font-family:arial,helvetica,sans-serif"><strong><span style="font-size:12pt">Tại sao n&ecirc;n sử dụng &aacute;o chống nắng?</span></strong></span></h3>\r\n\r\n<ul>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">&Aacute;o chống nắng gi&uacute;p che chắn phần th&acirc;n v&agrave; hai c&aacute;nh tay bạn khỏi c&aacute;c yếu tố kh&oacute;i bụi, nắng v&agrave; gi&oacute; khi bạn di chuyển</span></li>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">V&agrave;o m&ugrave;a h&egrave;, thời tiết nắng n&oacute;ng ch&oacute;i chang c&oacute; thể khiến l&agrave;n da của bạn trở n&ecirc;n kh&ocirc; r&aacute;p, sạm đen, thậm ch&iacute; l&agrave; ch&aacute;y nắng nếu kh&ocirc;ng sử dụng &aacute;o chống nắng khi đi ngo&agrave;i đường</span></li>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">Tia UV từ &aacute;nh nắng mặt trời c&oacute; khả năng l&agrave;m da ch&aacute;y sạm, tia UVA l&agrave;m l&atilde;o h&oacute;a, thậm ch&iacute; g&acirc;y ung thư da. Bởi vậy, mặc &aacute;o chống nắng sẽ gi&uacute;p bạn giảm c&aacute;c nguy cơ kh&ocirc;ng mong muốn về da</span></li>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt"><a href="http://chiaki.vn/search/s/%C3%A1o%20ch%E1%BB%91ng%20n%E1%BA%AFng" style="box-sizing: border-box; margin: 0px; padding: 0px; color: rgb(51, 122, 183); text-decoration: none; background-color: transparent;">&Aacute;o chống nắng</a>&nbsp;c&ograve;n c&oacute; khả năng gi&uacute;p h&uacute;t thấm mồ h&ocirc;i, cho cảm gi&aacute;c tho&aacute;ng m&aacute;t dễ chịu hơn khi bạn di chuyển dưới trời nắng n&oacute;ng</span></li>\r\n</ul>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:11pt"><img alt="Sử dụng áo chống nắng giúp bảo vệ làn da hiệu quả dưới cái nắng gay gắt của mùa hè" height="420" src="http://chiaki.vn/upload/news/content/2016/02/ao-chong-nang-uniqlo-nhat-ban2-chiaki-vn-jpg-1455596683-16022016112443.jpg" width="420" /></span></p>\r\n\r\n<p style="text-align:center"><em><span style="font-family:arial,helvetica,sans-serif; font-size:10pt">Sử dụng &aacute;o chống nắng gi&uacute;p bảo vệ l&agrave;n da hiệu quả dưới c&aacute;i nắng gay gắt của m&ugrave;a h&egrave;</span></em></p>\r\n\r\n<h3 style="text-align:justify"><span style="font-family:arial,helvetica,sans-serif"><strong><span style="font-size:12pt">Ưu điểm vượt trội của &aacute;o chống nắng Uniqlo Nhật Bản l&agrave; g&igrave;?</span></strong></span></h3>\r\n\r\n<ul>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">&Aacute;o chống nắng Uniqlo được thiết kế kiểu d&aacute;ng trẻ trung, lịch sự, dễ d&agrave;ng sử dụng v&agrave; ph&ugrave; hợp với nhiều lứa tuổi kh&aacute;c nhau</span></li>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">&Aacute;o chống nắng Uniqlo được l&agrave;m từ chất liệu cotton cực kỳ tho&aacute;ng m&aacute;t, h&uacute;t thấm mồ h&ocirc;i kh&aacute; nhanh với c&ocirc;ng nghệ UV CUT chống tia tử ngoại, bảo vệ da khỏi 96% t&aacute;c hại của c&aacute;c tia UV, &aacute;nh nắng gay gắt của những ng&agrave;y h&egrave; n&oacute;ng nực</span></li>\r\n</ul>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:11pt"><img alt="Áo chống nắng Uniqlo giúp chống tia UV hiệu quả và mang lại cảm giác thoáng mát khi mặc" height="368" src="http://chiaki.vn/upload/news/content/2016/02/ao-chong-nang-uniqlo-nhat-ban1-chiaki-vn-jpg-1455596852-16022016112732.jpg" width="592" /></span></p>\r\n\r\n<p style="text-align:center"><em><span style="font-family:arial,helvetica,sans-serif; font-size:10pt">&Aacute;o chống nắng Uniqlo gi&uacute;p chống tia UV hiệu quả v&agrave; mang lại cảm gi&aacute;c tho&aacute;ng m&aacute;t khi mặc</span></em></p>\r\n\r\n<ul>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">Sản phẩm &aacute;o chống nắng của Nhật n&agrave;y c&oacute; chức năng l&agrave;m m&aacute;t với c&ocirc;ng nghệ Cooling v&agrave; c&ocirc;ng nghệ lưới tho&aacute;ng kh&iacute; hiện đại</span></li>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">Sử dụng &aacute;o chống nắng Uniqlo bạn c&oacute; thể thoải m&aacute;i di chuyển dưới thời tiết nắng n&oacute;ng m&agrave; kh&ocirc;ng cần b&ocirc;i kem chống nắng, đặc biệt hữu &iacute;ch cho c&aacute;c chị em mới tắm trắng, l&agrave;n da dễ bị tổn thương v&agrave; dễ bắt nắng</span></li>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">&Aacute;o chống nắng Uniqlo được thiết kế thời trang dưới dạng &aacute;o kho&aacute;c chống nắng k&eacute;o kh&oacute;a, c&oacute; mũ rộng c&oacute; thể tr&ugrave;m ra ngo&agrave;i mũ bảo hiểm, gi&uacute;p che chắn cả g&aacute;y của bạn</span></li>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">Phần tay &aacute;o chống nắng n&agrave;y d&agrave;i, c&oacute; thể tr&ugrave;m k&iacute;n b&agrave;n tay với đường kho&eacute;t để giữ tay &aacute;o kh&ocirc;ng bị bay, rất tiện lợi khi đi xe</span></li>\r\n</ul>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:11pt"><img alt="Áo chống nắng Uniqlo có thiết kế tay dài, xẻ lỗ tiện dụng" src="http://chiaki.vn/upload/news/content/2016/04/ao-chong-nang-uniqlo1-chiaki-vn-jpg-1461549287-25042016085447.jpg" width="420" /></span></p>\r\n\r\n<p style="text-align:center"><em><span style="font-family:arial,helvetica,sans-serif; font-size:10pt">&Aacute;o chống nắng Uniqlo c&oacute; thiết kế tay d&agrave;i, xẻ lỗ tiện dụng</span></em></p>\r\n\r\n<ul>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">&Aacute;o chống nắng Uniqlo kh&ocirc;ng chỉ gi&uacute;p chống nắng hiệu quả m&agrave; c&ograve;n hợp thời trang, dễ phối hợp với c&aacute;c loại trang phục kh&aacute;c, khiến bạn lu&ocirc;n tự tin khi thamm gia giao th&ocirc;ng</span></li>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">&Aacute;o c&oacute; nhiều m&agrave;u sắc nh&atilde; nhặn với c&aacute;c size kh&aacute;c nhau cho bạn thoải m&aacute;i lựa chọn theo sở th&iacute;ch c&aacute; nh&acirc;n v&agrave; đặc biệt ph&ugrave; hợp cho cả nam v&agrave; nữ</span></li>\r\n	<li><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">Chất liệu cao cấp kh&ocirc;ng bị bai d&atilde;o, kh&ocirc;ng bạc m&agrave;u v&agrave; giặt sạch rất nhanh kể cả khi bị d&iacute;nh bẩn v&igrave; c&aacute;c loại đồ ăn thức uống</span></li>\r\n</ul>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:11pt"><img alt="Áo chống nắng Uniqlo có rất nhiều màu sắc cho bạn lựa chọn" height="314" src="http://chiaki.vn/upload/news/content/2016/02/ao-chong-nang-uniqlo-nhat-ban6-chiaki-vn-jpg-1455596959-16022016112919.jpg" width="558" /></span></p>\r\n\r\n<p style="text-align:center"><em><span style="font-family:arial,helvetica,sans-serif; font-size:10pt">&Aacute;o chống nắng Uniqlo c&oacute; rất nhiều m&agrave;u sắc cho bạn lựa chọn</span></em></p>\r\n\r\n<h3 style="text-align:justify"><strong><span style="font-family:arial,helvetica,sans-serif; font-size:12pt">Kinh nghiệm chọn mua &aacute;o chống nắng Uniqlo Nhật ch&iacute;nh h&atilde;ng</span></strong></h3>\r\n\r\n<p style="text-align:justify"><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">&Aacute;o chống nắng Uniqlo xuất hiện tr&ecirc;n thị trường Việt Nam từ năm 2014 v&agrave; tạo n&ecirc;n một &ldquo;cơn sốt&rdquo; cho người ti&ecirc;u d&ugrave;ng. C&oacute; kh&aacute; nhiều loại &aacute;o chống nắng nh&aacute;i theo kiểu d&aacute;ng v&agrave; mẫu m&atilde; &aacute;o chống nắng Uniqlo, bởi vậy, h&atilde;y trở th&agrave;nh người ti&ecirc;u d&ugrave;ng th&ocirc;ng th&aacute;i với những kinh nghiệm mua h&agrave;ng ch&iacute;nh h&atilde;ng sau đ&acirc;y:</span></p>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">- Th&ocirc;ng thường, những chiếc &aacute;o chống nắng Uniqlo giả c&oacute; m&agrave;u sắc sặc sỡ hơn, d&acirc;y &aacute;o kh&aacute;c m&agrave;u</span></p>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">- &Aacute;o chống nắng Uniqlo giả c&oacute; chất liệu &aacute;o dầy hơn, th&ocirc;, sờ kh&ocirc;ng m&aacute;t tay v&agrave; kh&ocirc;ng c&oacute; khả năng thấm h&uacute;t mồ h&ocirc;i như &aacute;o chống nắng Uniqlo thật</span></p>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">- Tem m&aacute;c &aacute;o giả sẽ mờ, th&ocirc;ng tin kh&ocirc;ng r&otilde; r&agrave;ng, gi&aacute; ghi tr&ecirc;n m&aacute;c kh&ocirc;ng tr&ugrave;ng khớp với số tiền tr&ecirc;n web ch&iacute;nh h&atilde;ng</span></p>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">- &Aacute;o chống nắng giả c&oacute; thể bị x&ugrave;, chảy d&atilde;o sau 1-2 lần giặt</span></p>\r\n\r\n<p><span style="font-family:arial,helvetica,sans-serif; font-size:11pt"><img alt="Tem mác thật trên áo chống nắng Uniqlo chính hãng " height="386" src="http://chiaki.vn/upload/news/content/2016/02/ao-chong-nang-uniqlo-nhat-ban7-chiaki-vn-jpg-1455607206-16022016142006.jpg" width="400" /></span></p>\r\n\r\n<p style="text-align:center"><em><span style="font-family:arial,helvetica,sans-serif; font-size:10pt">Tem m&aacute;c thật tr&ecirc;n &aacute;o chống nắng Uniqlo ch&iacute;nh h&atilde;ng&nbsp;</span></em></p>\r\n\r\n<p style="text-align:center"><em><span style="font-family:arial,helvetica,sans-serif; font-size:10pt"><img alt="Áo chống nắng Uniqlo chính hãng có giá ghi trên tem trùng giá tiền trên web chính hãng" src="http://chiaki.vn/upload/news/content/2016/02/ao-chong-nang-uniqlo-nhat-ban8-chiaki-vn-jpg-1455607281-16022016142121.jpg" width="400" /></span></em>&nbsp;</p>\r\n\r\n<p style="text-align:center"><em><span style="font-family:arial,helvetica,sans-serif; font-size:10pt">&Aacute;o chống nắng Uniqlo ch&iacute;nh h&atilde;ng c&oacute; gi&aacute; ghi tr&ecirc;n tem tr&ugrave;ng gi&aacute; tiền tr&ecirc;n web ch&iacute;nh h&atilde;ng</span></em></p>\r\n\r\n<h3 style="text-align:justify"><span style="font-family:arial,helvetica,sans-serif"><strong><span style="font-size:12pt">Th&ocirc;ng tin sản phẩm</span></strong></span></h3>\r\n\r\n<p style="text-align:justify"><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">Xuất xứ: Nhật Bản</span></p>\r\n\r\n<p style="text-align:justify"><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">M&agrave;u sắc: Đa dạng</span></p>\r\n\r\n<p style="text-align:justify"><span style="font-family:arial,helvetica,sans-serif; font-size:11pt">Size: S, M, L</span></p>\r\n', '05-18-30-25-04-2016-1267089312218696178381712873380945810991398n.jpg', '05-18-30-25-04-2016-1267089312218696178381712873380945810991398n.jpg', 'a:1:{i:0;s:68:"05-18-30-25-04-2016-1267089312218696178381712873380945810991398n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461579510, NULL),
(130, NULL, 'Mũ chống nắng Hàn Quốc', 185000, 0, 0, 1, '', -1, '<p>Mũ chống nắng H&agrave;n thời trang.</p>\r\n', '<p>Mũ chống nắng H&agrave;n thời trang đủ m&agrave;u sắc lựa chọn.</p>\r\n\r\n<p>Th&iacute;ch hợp đi biển.Tho&aacute;ng m&aacute;t kh&ocirc;ng sợ mồ h&ocirc;i.</p>\r\n', '05-21-52-25-04-2016-1280472212234590276792307985834084012908594n.jpg', '05-21-52-25-04-2016-1280472212234590276792307985834084012908594n.jpg', 'a:1:{i:0;s:68:"05-21-52-25-04-2016-1280472212234590276792307985834084012908594n.jpg";}', 0, 176, 'Thiết bị y tế &amp; Làm đẹp', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461579712, NULL),
(132, NULL, 'Bleu de chanel EDP pour home', 0, 0, 0, 2, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Bleu de Chanel một m&ugrave;i hương mới của Chanel vừa c&oacute; mặt tr&ecirc;n thị trường v&agrave;o năm 2010. Bleu de Chanel l&agrave; một m&ugrave;i hương gỗ đặc trưng v&agrave; kết hợp với c&aacute;c hương liệu như hạt ti&ecirc;u hồng, hương bưởi, gỗ đ&agrave;n hương l&agrave;m tăng th&ecirc;m n&eacute;t mạnh mẽ v&agrave; nam t&iacute;nh cho m&ugrave;i hương n&agrave;y.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Bleu de chanel EDP pour homme</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">C&ugrave;ng nh&atilde;n hiệu: Chanel</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Bleu de Chanel một m&ugrave;i hương mới của Chanel vừa c&oacute; mặt tr&ecirc;n thị trường v&agrave;o năm 2010. Bleu de Chanel l&agrave; một m&ugrave;i hương gỗ đặc trưng v&agrave; kết hợp với c&aacute;c hương liệu như hạt ti&ecirc;u hồng, hương bưởi, gỗ đ&agrave;n hương l&agrave;m tăng th&ecirc;m n&eacute;t mạnh mẽ v&agrave; nam t&iacute;nh cho m&ugrave;i hương n&agrave;y</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">M&ugrave;i hương đặc trưng:<br />\r\n<br />\r\nHương nhục đậu khấu, gừng, gỗ đ&agrave;n hương, hoắc hương, bạc h&agrave;, hoa nh&agrave;i, bưởi, cỏ vertier, hương tuyết t&ugrave;ng, hạt ti&ecirc;u hồng.<br />\r\n<br />\r\nPhong c&aacute;ch:<br />\r\n<br />\r\nNam t&iacute;nh, mạnh mẽ.</span></p>\r\n', '05-25-52-25-04-2016-23-08-2013-bleu-de-chanel-for-men-100ml-1.jpg', '05-25-52-25-04-2016-23-08-2013-bleu-de-chanel-for-men-100ml-1.jpg', 'a:1:{i:0;s:65:"05-25-52-25-04-2016-23-08-2013-bleu-de-chanel-for-men-100ml-1.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461579952, NULL),
(133, NULL, '1 Million', 0, 0, 0, 2, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Paco Rabanne giới thiệu hương thơm mới tươi m&aacute;t v&agrave; quyến rũ với &aacute;nh s&aacute;ng rực rỡ của v&agrave;ng. Nh&agrave; s&aacute;ng tạo Paco Rabanne đ&atilde; n&oacute;i trong tất cả c&aacute;c nền văn minh v&agrave; t&ocirc;n gi&aacute;o, v&agrave;ng lu&ocirc;n lu&ocirc;n được t&iacute;ch trữ v&agrave; l&agrave;m mọi người say m&ecirc;. V&agrave;ng ở xung quanh ch&uacute;ng ta: trong kiến tr&uacute;c, thiết kế, đồ trang sức, quần &aacute;o, phụ kiện, thời trang ...N&oacute; lu&ocirc;n g&acirc;y sự ch&uacute; &yacute; v&agrave; được coi trọn</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">g tr&ecirc;n to&agrave;n thế giới v&agrave; c&oacute; một gi&aacute; trị rất thi&ecirc;ng li&ecirc;ng. Lấy cảm hứng từ đ&oacute;, vỏ chai đ&atilde; được thiết kế với sắc th&aacute;i của v&agrave;ng. N&oacute; tượng trưng cho sức mạnh, sự gi&agrave;u c&oacute;, sang trọng, sự bền vững&hellip;</span></p>\r\n\r\n<p>&nbsp;</p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">1 Million</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">C&ugrave;ng nh&atilde;n hiệu: Paco Rabanne</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Paco Rabanne giới thiệu hương thơm mới tươi m&aacute;t v&agrave; quyến rũ với &aacute;nh s&aacute;ng rực rỡ của v&agrave;ng. Nh&agrave; s&aacute;ng tạo Paco Rabanne đ&atilde; n&oacute;i trong tất cả c&aacute;c nền văn minh v&agrave; t&ocirc;n gi&aacute;o, v&agrave;ng lu&ocirc;n lu&ocirc;n được t&iacute;ch trữ v&agrave; l&agrave;m mọi người say m&ecirc;. V&agrave;ng ở xung quanh ch&uacute;ng ta: trong kiến tr&uacute;c, thiết kế, đồ trang sức, quần &aacute;o, phụ kiện, thời trang ...N&oacute; lu&ocirc;n g&acirc;y sự ch&uacute; &yacute; v&agrave; được coi trọn</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">g tr&ecirc;n to&agrave;n thế giới v&agrave; c&oacute; một gi&aacute; trị rất thi&ecirc;ng li&ecirc;ng. Lấy cảm hứng từ đ&oacute;, vỏ chai đ&atilde; được thiết kế với sắc th&aacute;i của v&agrave;ng. N&oacute; tượng trưng cho sức mạnh, sự gi&agrave;u c&oacute;, sang trọng, sự bền vững&hellip;</span></p>\r\n\r\n<p><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Hương thơm n&agrave;y được lấy cảm hứng từ d&ograve;ng thời trang kim loại của Paco Rabanne v&agrave; được tạo ra bởi sự hợp t&aacute;c của ba nh&agrave; s&aacute;ng tạo nước hoa nổi tiếng: Christophe Raynaud, Olivier Pescheux v&agrave; Michel Girard với sự pha trộn của c&aacute;c m&ugrave;i hương: bưởi ch&ugrave;m, cam đỏ, bạc h&agrave;, hoa hồng, quế, gia vị, da, gỗ, hoắc hương v&agrave; hổ ph&aacute;ch.<br />\r\n<br />\r\nM&ugrave;i hương đặc trưng:<br />\r\n<br />\r\nCam, bưởi ch&ugrave;m, bạc h&agrave;, hoa hồng, quế, gia vị, hoắc hương, gỗ trắng, hổ ph&aacute;ch.<br />\r\n<br />\r\nPhong c&aacute;ch:<br />\r\n<br />\r\nVui vẻ, lịch l&atilde;m, quyến rũ.<br />\r\n<br />\r\nD&ograve;ng EDT&nbsp;</span></p>\r\n', '05-28-47-25-04-2016-1292320012296499203934742463387753263813424n.jpg', '05-28-47-25-04-2016-1292320012296499203934742463387753263813424n.jpg', 'a:1:{i:0;s:68:"05-28-47-25-04-2016-1292320012296499203934742463387753263813424n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461580127, NULL);
INSERT INTO `web_product` (`product_id`, `product_code`, `product_name`, `product_price_sell`, `product_price_market`, `product_price_input`, `product_type_price`, `product_selloff`, `product_is_hot`, `product_sort_desc`, `product_content`, `product_image`, `product_image_hover`, `product_image_other`, `product_order`, `category_id`, `category_name`, `quality_input`, `quality_out`, `product_status`, `is_block`, `user_shop_id`, `user_shop_name`, `is_shop`, `shop_province`, `time_created`, `time_update`) VALUES
(134, NULL, 'My Burberry Limited for women', 0, 0, 0, 2, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Burberry giới thiệu sản phẩm nước hoa mới v&agrave;o th&aacute;ng 9 năm 2014 mang t&ecirc;n My Burberry. My Burberry được lấy cảm hứng từ những chiếc &aacute;o kho&aacute;c mang thương hiệu Burberry v&agrave; khu vườn London sau khi mưa. Được c&ocirc;ng bố l&agrave; hương thơm mới c&oacute; nhiệm vụ lọt v&agrave;o top 10 tại đấu trường sang trọng. Đ&acirc;y l&agrave; 1 trong trong bộ sưu tập nước hoa lớn nhất đang được chuẩn bị ra mắt.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">My Burberry Limited for women</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Burberry giới thiệu sản phẩm nước hoa mới v&agrave;o th&aacute;ng 9 năm 2014 mang t&ecirc;n My Burberry. My Burberry được lấy cảm hứng từ những chiếc &aacute;o kho&aacute;c mang thương hiệu Burberry v&agrave; khu vườn London sau khi mưa. Được c&ocirc;ng bố l&agrave; hương thơm mới c&oacute; nhiệm vụ lọt v&agrave;o top 10 tại đấu trường sang trọng. Đ&acirc;y l&agrave; 1 trong trong bộ sưu tập nước hoa lớn nhất đang được chuẩn bị ra mắt.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Hương đặc</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">&nbsp;trưng:<br />\r\n<br />\r\nTh&agrave;nh phần của My Burberry mở đầu với đậu ngọt v&agrave; hương của cam qu&yacute;t bergamot dẫn đến c&acirc;y phong lữ, hoa lan Nam Phi v&agrave; mộc qua v&agrave;ng ở hương giữa; hương cuối với hoắc hương, hoa Damask &amp; hoa hồng. C&aacute;c th&agrave;nh phần hương thơm được h&ograve;a huyệt bởi nh&agrave; sản xuất Francis Kurkdjian!<br />\r\n<br />\r\nD&ograve;ng EDP chai 50ml</span></p>\r\n', '05-30-14-25-04-2016-nuochoamyburberrylimitededp.jpg', '05-30-14-25-04-2016-nuochoamyburberrylimitededp.jpg', 'a:1:{i:0;s:51:"05-30-14-25-04-2016-nuochoamyburberrylimitededp.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461580214, NULL),
(135, NULL, 'Lancom Trésor In Love', 0, 0, 0, 2, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">C&ugrave;ng nh&atilde;n hiệu: Lanc&ocirc;me</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Th&aacute;ng 03 năm 2010 Lanc&ocirc;me đ&atilde; tung ra thị trường một m&ugrave;i hương mới Tr&eacute;sor in Love để bắt đầu c&acirc;u chuyện mới, c&acirc;u chuyện t&igrave;nh y&ecirc;u của những t&acirc;m hồn l&atilde;ng mạn. Với hương thơm nhẹ nh&agrave;ng, sản phẩm nước hoa mới n&agrave;y thể hiện cảm gi&aacute;c của người phụ nữ đang y&ecirc;u v&agrave; sống hết m&igrave;nh cho t&igrave;nh y&ecirc;u. Kiểu d&aacute;ng chai ấn tượng với những đường cong mềm mại, nữ t&iacute;nh. Đặc biệt tr&ecirc;n</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">&nbsp;cổ chai c&oacute; một b&ocirc;ng hồng bằng satin m&agrave;u đen tăng th&ecirc;m sự quyến rũ, l&agrave;m cho mỗi chai nước hoa Tr&eacute;sor in Love trở th&agrave;nh duy nhất.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Tr&eacute;sor In Love</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">C&ugrave;ng nh&atilde;n hiệu: Lanc&ocirc;me</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Th&aacute;ng 03 năm 2010 Lanc&ocirc;me đ&atilde; tung ra thị trường một m&ugrave;i hương mới Tr&eacute;sor in Love để bắt đầu c&acirc;u chuyện mới, c&acirc;u chuyện t&igrave;nh y&ecirc;u của những t&acirc;m hồn l&atilde;ng mạn. Với hương thơm nhẹ nh&agrave;ng, sản phẩm nước hoa mới n&agrave;y thể hiện cảm gi&aacute;c của người phụ nữ đang y&ecirc;u v&agrave; sống hết m&igrave;nh cho t&igrave;nh y&ecirc;u. Kiểu d&aacute;ng chai ấn tượng với những đường cong mềm mại, nữ t&iacute;nh. Đặc biệt tr&ecirc;n</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">&nbsp;cổ chai c&oacute; một b&ocirc;ng hồng bằng satin m&agrave;u đen tăng th&ecirc;m sự quyến rũ, l&agrave;m cho mỗi chai nước hoa Tr&eacute;sor in Love trở th&agrave;nh duy nhất.<br />\r\n<br />\r\nM&ugrave;i hương đặc trưng:<br />\r\n<br />\r\nSự pha trộn nhiều hương tr&aacute;i c&acirc;y, hạt ti&ecirc;u hoa violet, hương gỗ b&aacute;ch hương, xạ hương, Hoa l&agrave;i, Hoa mộc lan, Trầm hương, Xạ&nbsp;<br />\r\n<br />\r\nPhong c&aacute;ch:<br />\r\n<br />\r\nL&atilde;ng mạn, ki&ecirc;u sa, khi&ecirc;u kh&iacute;ch.</span></p>\r\n', '05-31-50-25-04-2016-nuochoa-lacome12-9-2013-5-48-45-pm.jpg', '05-31-50-25-04-2016-nuochoa-lacome12-9-2013-5-48-45-pm.jpg', 'a:1:{i:0;s:58:"05-31-50-25-04-2016-nuochoa-lacome12-9-2013-5-48-45-pm.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461580310, NULL),
(136, NULL, 'Lancome Tresor Midnight Rose', 0, 0, 0, 2, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">C&ugrave;ng nh&atilde;n hiệu: Lanc&ocirc;me</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Tresor Midnight Rose l&agrave; phi&ecirc;n bản mới ra mắt v&agrave;o th&aacute;ng ch&iacute;n vừa qua. Phi&ecirc;n bản n&agrave;y tinh t&ecirc;́ hơn hẳn với chi&ecirc;́t xu&acirc;́t từ m&acirc;m x&ocirc;i, hạt ti&ecirc;u hồng, g&ocirc;̃ tuy&ecirc;́t t&ugrave;ng v&agrave; xạ hương.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Mọi loại nước hoa của Lanc&ocirc;me đều c&oacute; vẻ l&atilde;ng mạn của ri&ecirc;ng n&oacute;. Tresor Midnight Rose c&ograve;n tạo cho người d&ugrave;ng cảm gi&aacute;c lạc quan, vui vẻ, tr&agrave;n đầy nặng lượng. Hương thơm của Tresor Midnight Rose l&agrave; sự ấm &aacute;p, ngọt ng&agrave;o nhưng huyền diệu với &yacute; tưởng một b&ocirc;ng hoa chỉ nở v&agrave;o l&uacute;c nửa đ&ecirc;m.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Tresor Midnight Rose</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">C&ugrave;ng nh&atilde;n hiệu: Lanc&ocirc;me</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Tresor Midnight Rose l&agrave; phi&ecirc;n bản mới ra mắt v&agrave;o th&aacute;ng ch&iacute;n vừa qua. Phi&ecirc;n bản n&agrave;y tinh t&ecirc;́ hơn hẳn với chi&ecirc;́t xu&acirc;́t từ m&acirc;m x&ocirc;i, hạt ti&ecirc;u hồng, g&ocirc;̃ tuy&ecirc;́t t&ugrave;ng v&agrave; xạ hương.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Mọi loại nước hoa của Lanc&ocirc;me đều c&oacute; vẻ l&atilde;ng mạn của ri&ecirc;ng n&oacute;. Tresor Midnight Rose c&ograve;n tạo cho người d&ugrave;ng cảm gi&aacute;c lạc quan, vui vẻ, tr&agrave;n đầy nặng lượng. Hương thơm của Tresor Midnight Rose l&agrave; sự ấm &aacute;p, ngọt ng&agrave;o nhưng huyền diệu với &yacute; tưởng một b&ocirc;ng hoa chỉ nở v&agrave;o l&uacute;c nửa đ&ecirc;m.<br />\r\n<br />\r\nHương đặc trưng:<br />\r\n<br />\r\nHương đầu : Tuyết t&ugrave;ng, vanilla&nbsp;<br />\r\nHương giữa : Hoa nh&agrave;i, hoa mẫu đơn, hạt ti&ecirc;u hồng&nbsp;<br />\r\nHương cuối : M&acirc;m x&ocirc;i, hoa hồng...<br />\r\n<br />\r\nPhong c&aacute;ch:<br />\r\n<br />\r\nNhẹ nh&agrave;ng, tinh tế, quyến rũ.</span></p>\r\n', '05-32-51-25-04-2016-xt701.jpg', '05-32-51-25-04-2016-xt701.jpg', 'a:1:{i:0;s:29:"05-32-51-25-04-2016-xt701.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461580371, NULL),
(137, NULL, 'Gucci Première', 0, 0, 0, 2, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">C&ugrave;ng nh&atilde;n hiệu: Gucci</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Nh&agrave; thời trang &Yacute; của Gucci ra mắt một loại nước hoa mới với hương thơm từ những cảm hứng của bộ sưu tập thời trang cao cấp Gucci Premiere được tr&igrave;nh chiếu tại Li&ecirc;n Hoa Phim Cannes 2010 (Cannes Film Festival). Gucci Premi&egrave;re mang phong c&aacute;ch hiện đại nữ t&iacute;nh, hấp dẫn v&agrave; quyến rũ như chiếc v&aacute;y thời trang cao cấp ho&agrave;n hảo v&agrave; được quảng c&aacute;o bởi nữ diễn vi&ecirc;n tuyệt&nbsp;</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">đẹp Blake Lively.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Gucci Premi&egrave;re</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">C&ugrave;ng nh&atilde;n hiệu: Gucci</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Nh&agrave; thời trang &Yacute; của Gucci ra mắt một loại nước hoa mới với hương thơm từ những cảm hứng của bộ sưu tập thời trang cao cấp Gucci Premiere được tr&igrave;nh chiếu tại Li&ecirc;n Hoa Phim Cannes 2010 (Cannes Film Festival). Gucci Premi&egrave;re mang phong c&aacute;ch hiện đại nữ t&iacute;nh, hấp dẫn v&agrave; quyến rũ như chiếc v&aacute;y thời trang cao cấp ho&agrave;n hảo v&agrave; được quảng c&aacute;o bởi nữ diễn vi&ecirc;n tuyệt&nbsp;</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">đẹp Blake Lively.<br />\r\n<br />\r\nM&ugrave;i hương đặt trưng:<br />\r\n<br />\r\nHương đầu: Hương thơm sẽ mở ra sự sang trọng, phấn khởi của rượu s&acirc;m banh cổ điển. Bất ngờ với hợp chất ph&aacute; sủi bọt của cam bergamot, hoa cam v&agrave; ăn mừng truyền tải sự phấn k&iacute;ch của lối v&agrave;o thảm đỏ.<br />\r\nHương giữa: Hương giữa chiết xuất từ những b&ocirc;ng hoa trắng rực rỡ được tẩm với xạ hương hiện đại thể hiện sự gợi cảm.<br />\r\nHương cuối: ấm &aacute;p, dễ chịu của nước hoa xuất ph&aacute;t từ kh&oacute;i da tinh tế v&agrave; kem gỗ hương ch&uacute;ng l&agrave; h&igrave;nh anh thu nhỏ của sự quyết rũ tuyệt đối&nbsp;<br />\r\n<br />\r\nPhong c&aacute;ch:<br />\r\n<br />\r\nNữ t&iacute;nh, hấp dẫn v&agrave; quyến rủ.<br />\r\n<br />\r\nD&ograve;ng EDP</span></p>\r\n', '05-47-33-25-04-2016-24a1167e13ac23a599725c0d2327ed15.jpg', '05-47-33-25-04-2016-24a1167e13ac23a599725c0d2327ed15.jpg', 'a:1:{i:0;s:56:"05-47-33-25-04-2016-24a1167e13ac23a599725c0d2327ed15.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461580520, 1461581257),
(139, NULL, 'Chance Eau de toilette', 0, 0, 0, 2, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">C&ugrave;ng nh&atilde;n hiệu: Chanel</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Nước hoa Chance do CHANEL s&aacute;ng chế c&oacute; m&ugrave;i hương đầy nữ t&iacute;nh, l&agrave; sự pha trộn từ hương thơm gợi cảm v&agrave; ngọt ng&agrave;o, trẻ trung, tươi tắn Chanel Chance l&agrave; sự kết hợp của hương c&acirc;y lan dạ hương, xạ hương trắng v&agrave; hoa hồng kế tiếp l&agrave; n&eacute;t trong trắng ng&acirc;y thơ của vetiver trắng v&agrave; c&acirc;y irit, kết th&uacute;c bằng m&ugrave;i hương hổ ph&aacute;ch v&agrave; c&acirc;y hoắc hương.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Chance Eau de toilette</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">C&ugrave;ng nh&atilde;n hiệu: Chanel</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Nước hoa Chance do CHANEL s&aacute;ng chế c&oacute; m&ugrave;i hương đầy nữ t&iacute;nh, l&agrave; sự pha trộn từ hương thơm gợi cảm v&agrave; ngọt ng&agrave;o, trẻ trung, tươi tắn Chanel Chance l&agrave; sự kết hợp của hương c&acirc;y lan dạ hương, xạ hương trắng v&agrave; hoa hồng kế tiếp l&agrave; n&eacute;t trong trắng ng&acirc;y thơ của vetiver trắng v&agrave; c&acirc;y irit, kết th&uacute;c bằng m&ugrave;i hương hổ ph&aacute;ch v&agrave; c&acirc;y hoắc hương.</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">M&ugrave;i Hương đặc trưng:<br />\r\n<br />\r\nHoa Hồng, Lan dạ hương, Vetiver trắng, hổ ph&aacute;ch, Hoắc hương.<br />\r\n<br />\r\nPhong c&aacute;ch:<br />\r\n<br />\r\nGợi cảm, trẻ trung, nữ t&iacute;nh.</span></p>\r\n', '05-36-42-25-04-2016-1293670612230542977197037500584243912539152n.jpg', '05-36-42-25-04-2016-1293670612230542977197037500584243912539152n.jpg', 'a:1:{i:0;s:68:"05-36-42-25-04-2016-1293670612230542977197037500584243912539152n.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461580602, NULL),
(140, NULL, 'Channe Chance Eau fraiche', 0, 0, 0, 2, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">C&ugrave;ng nh&atilde;n hiệu: Chanel</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Một lời mời gọi thật tươi m&aacute;t, một lời hứa tr&agrave;n ngập hạnh ph&uacute;c. Chance Eau Fraiche đ&atilde; đưa hương thơm truyền thống c&ugrave;a Chanel l&ecirc;n một tầm cao mới, nhẹ nh&agrave;ng hơn, hiện đại hơn, tươi trẻ hơn. Hương hoa cỏ m&aacute;t nhẹ, gọi mời được chứa đựng b&ecirc;n trong chai thủy tinh xanh l&aacute; c&acirc;y nhạt thật xinh xắn v&agrave; trẻ trung. Mở đầu với hương cam chanh v&agrave; hoa thuỷ ti&ecirc;n thuần kh</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">iết v&agrave; tươi m&aacute;t, Chance Eau Fraiche ngay từ đầu đ&atilde; tạo được sự kh&aacute;c lạ với d&ograve;ng nước hoa cổ điển truyền thống của Lanc&ocirc;me. Kế tiếp l&agrave; hương hoa l&agrave;i v&agrave; tầng hương cuối gồm c&aacute;c loại gỗ v&agrave; thảo mộc sẽ cho bạn một cảm nhận mới mẻ v&agrave; tr&agrave;n đẩy sức sống mới.</span></p>\r\n', '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Chance Eau fraiche</span><br />\r\n<br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">C&ugrave;ng nh&atilde;n hiệu: Chanel</span><br />\r\n<span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">Một lời mời gọi thật tươi m&aacute;t, một lời hứa tr&agrave;n ngập hạnh ph&uacute;c. Chance Eau Fraiche đ&atilde; đưa hương thơm truyền thống c&ugrave;a Chanel l&ecirc;n một tầm cao mới, nhẹ nh&agrave;ng hơn, hiện đại hơn, tươi trẻ hơn. Hương hoa cỏ m&aacute;t nhẹ, gọi mời được chứa đựng b&ecirc;n trong chai thủy tinh xanh l&aacute; c&acirc;y nhạt thật xinh xắn v&agrave; trẻ trung. Mở đầu với hương cam chanh v&agrave; hoa thuỷ ti&ecirc;n thuần kh</span><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">iết v&agrave; tươi m&aacute;t, Chance Eau Fraiche ngay từ đầu đ&atilde; tạo được sự kh&aacute;c lạ với d&ograve;ng nước hoa cổ điển truyền thống của Lanc&ocirc;me. Kế tiếp l&agrave; hương hoa l&agrave;i v&agrave; tầng hương cuối gồm c&aacute;c loại gỗ v&agrave; thảo mộc sẽ cho bạn một cảm nhận mới mẻ v&agrave; tr&agrave;n đẩy sức sống mới.<br />\r\n<br />\r\nM&ugrave;i hương đặc trưng:<br />\r\n<br />\r\nCam chanh, Hoa thủy ti&ecirc;n, Hoa l&agrave;i, Gỗ Teak, Hương lau, Hoắc hương, Hổ ph&aacute;ch, Xạ hương trắng.<br />\r\n<br />\r\nPhong c&aacute;ch:<br />\r\n<br />\r\nTươi m&aacute;t, hiện đại</span></p>\r\n', '05-40-29-25-04-2016-itemxl4036559878658.jpg', '05-40-29-25-04-2016-itemxl4036559878658.jpg', 'a:1:{i:0;s:43:"05-40-29-25-04-2016-itemxl4036559878658.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461580818, NULL),
(141, NULL, 'Channel Chance', 0, 0, 0, 2, '', 2, '<p><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35)">Chance, nghĩa l&agrave; May mắn, ch&iacute;nh l&agrave; cuộc sống của bạn. May mắn đến với bạn khi bạn kh&ocirc;ng mong đợi n&oacute; xảy ra nhất. Cũng như thế, Chanel Chance đến với bạn một c&aacute;ch bất ngờ đầy th&uacute; vị trong một hương thơm với sắc hồng &oacute;ng &aacute;nh, b&ecirc;n trong một thiết kế h&igrave;nh tr&ograve;n, biểu tượng cho v&ograve;ng tr&ograve;n may mắn. Chance, hương thơm mới từ Chanel, l&agrave; một kết hợp đầy bất ngờ, l&agrave; sự va chạm của những&nbsp;l&agrave;n s&oacute;ng hương hoa tươi m&aacute;t bất tận, to&aacute;t l&ecirc;n một vẻ quyến rũ nồng n&agrave;n. Chanel Chance mang một t&ecirc;n gọi l&agrave;m gợi l&ecirc;n một cảm gi&aacute;c thần thoại. Nếu Chanel v&agrave; Chance mang những n&eacute;t giống nhau, đ&oacute; kh&ocirc;ng chỉ l&agrave; do may mắn, đ&oacute; c&ograve;n l&agrave; v&igrave; ch&uacute;ng được s&aacute;ng tạo n&ecirc;n để d&agrave;nh cho nhau. Như những đợt s&oacute;ng tươi m&aacute;t, h&ograve;a với hương hoa thơm ng&aacute;t c&ugrave;ng những th&agrave;nh phần gia vị đặc biệt khiến cho Chanel Chance trở n&ecirc;n rất gơi cảm v&agrave; ngọt ng&agrave;o, nữ t&iacute;nh đến đ&aacute;ng kinh ngạc, dồi d&agrave;o năng lượng sống, t&aacute;o bạo pha ch&uacute;t gợi t&igrave;nh v&agrave; nghịch ngợm.</span></p>\r\n', '<div class="text_exposed_root text_exposed" id="id_571df12d7fd561582136971" style="display: inline;"><span style="background-color:rgb(255, 255, 255); color:rgb(20, 24, 35); font-family:helvetica,arial,sans-serif; font-size:14px">C&ugrave;ng nh&atilde;n hiệu: Chanel<br />\r\nChance, nghĩa l&agrave; May mắn, ch&iacute;nh l&agrave; cuộc sống của bạn. May mắn đến với bạn khi bạn kh&ocirc;ng mong đợi n&oacute; xảy ra nhất. Cũng như thế, Chanel Chance đến với bạn một c&aacute;ch bất ngờ đầy th&uacute; vị trong một hương thơm với sắc hồng &oacute;ng &aacute;nh, b&ecirc;n trong một thiết kế h&igrave;nh tr&ograve;n, biểu tượng cho v&ograve;ng tr&ograve;n may mắn. Chance, hương thơm mới từ Chanel, l&agrave; một kết hợp đầy bất ngờ, l&agrave; sự va chạm của những&nbsp;l&agrave;n s&oacute;ng hương hoa tươi m&aacute;t bất tận, to&aacute;t l&ecirc;n một vẻ quyến rũ nồng n&agrave;n. Chanel Chance mang một t&ecirc;n gọi l&agrave;m gợi l&ecirc;n một cảm gi&aacute;c thần thoại. Nếu Chanel v&agrave; Chance mang những n&eacute;t giống nhau, đ&oacute; kh&ocirc;ng chỉ l&agrave; do may mắn, đ&oacute; c&ograve;n l&agrave; v&igrave; ch&uacute;ng được s&aacute;ng tạo n&ecirc;n để d&agrave;nh cho nhau. Như những đợt s&oacute;ng tươi m&aacute;t, h&ograve;a với hương hoa thơm ng&aacute;t c&ugrave;ng những th&agrave;nh phần gia vị đặc biệt khiến cho Chanel Chance trở n&ecirc;n rất gơi cảm v&agrave; ngọt ng&agrave;o, nữ t&iacute;nh đến đ&aacute;ng kinh ngạc, dồi d&agrave;o năng lượng sống, t&aacute;o bạo pha ch&uacute;t gợi t&igrave;nh v&agrave; nghịch ngợm.<br />\r\n<br />\r\nM&ugrave;i hương đặc trưng:&nbsp;<br />\r\n<br />\r\nTi&ecirc;u hồng, Chanh, Lan dạ hương, Hoa l&agrave;i, Hoa irit, Hổ ph&aacute;ch, Hoắc hương, Cỏ Vetiver, Xạ hương trắng.<br />\r\n<br />\r\nPhong c&aacute;ch:&nbsp;<br />\r\n<br />\r\nNữ t&iacute;nh, gợi cảm, tươi m&aacute;t.</span></div>\r\n\r\n<div class="pts fbPhotoLegacyTagList" id="fbPhotoSnowliftLegacyTagList" style="padding-top: 5px; color: rgb(20, 24, 35); font-family: helvetica, arial, sans-serif; font-size: 12px; line-height: 16.08px; background-color: rgb(255, 255, 255);">\r\n<div>&nbsp;</div>\r\n</div>\r\n\r\n<div class="mvm fbPhotosPhotoOwnerButtons stat_elem" id="fbPhotoSnowliftOwnerButtons" style="margin-top: 10px; margin-bottom: 10px; line-height: 20px; color: rgb(20, 24, 35); font-family: helvetica, arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);">\r\n<div class="_51xa _3-8m _3-90" id="photosTruncatingUIButtonGroup" style="box-shadow: rgba(0, 0, 0, 0.0470588) 0px 1px 1px; display: inline-block; vertical-align: middle; white-space: nowrap; margin-bottom: 4px; margin-top: 4px; margin-right: 8px;">&nbsp;</div>\r\n</div>\r\n', '05-42-00-25-04-2016-d74fd6a8e5744f8.jpg', '05-42-00-25-04-2016-d74fd6a8e5744f8.jpg', 'a:1:{i:0;s:39:"05-42-00-25-04-2016-d74fd6a8e5744f8.jpg";}', 0, 166, 'Chăm sóc cơ thể', 0, 0, 1, 1, 6, 'Hàng xách tay', 2, 22, 1461580920, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `web_province`
--

CREATE TABLE IF NOT EXISTS `web_province` (
  `province_id` int(11) NOT NULL AUTO_INCREMENT,
  `province_name` varchar(255) NOT NULL,
  `province_position` tinyint(4) NOT NULL,
  `province_status` varchar(20) NOT NULL,
  `province_area` tinyint(4) NOT NULL COMMENT 'Vùng miền của tỉnh thành',
  PRIMARY KEY (`province_id`),
  KEY `position` (`province_position`),
  KEY `status` (`province_status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=73 ;

--
-- Dumping data for table `web_province`
--

INSERT INTO `web_province` (`province_id`, `province_name`, `province_position`, `province_status`, `province_area`) VALUES
(3, 'Bạc Liêu', 6, '1', 3),
(4, 'Bắc Cạn', 7, '1', 1),
(5, 'Bắc Giang', 6, '1', 1),
(6, 'Bắc Ninh', 7, '1', 1),
(7, 'Bến Tre', 8, '1', 3),
(8, 'Bình Dương', 9, '1', 3),
(9, 'Bình Định', 10, '1', 2),
(10, 'Bình Phước', 11, '1', 2),
(11, 'Bình Thuận', 12, '1', 2),
(12, 'Cà Mau', 13, '1', 3),
(13, 'Cao Bằng', 14, '1', 1),
(14, 'Cần Thơ', 8, '1', 3),
(15, 'Đà Nẵng', 3, '1', 2),
(17, 'Đồng Nai', 18, '1', 3),
(18, 'Đồng Tháp', 19, '1', 3),
(19, 'Gia Lai', 20, '1', 2),
(20, 'Hà Giang', 21, '1', 1),
(21, 'Hà Nam', 22, '1', 1),
(22, 'Hà Nội', 1, '1', 1),
(23, 'Hà Tây', 24, '1', 1),
(24, 'Hà Tĩnh', 25, '1', 2),
(25, 'Hải Dương', 26, '1', 1),
(26, 'Hải Phòng', 5, '1', 1),
(27, 'Hòa Bình', 28, '1', 1),
(28, 'Hưng Yên', 29, '1', 1),
(29, 'TP Hồ Chí Minh', 2, '1', 3),
(30, 'Khánh Hòa', 31, '1', 2),
(31, 'Kiên Giang', 32, '1', 3),
(32, 'Kon Tum', 33, '1', 2),
(33, 'Lai Châu', 34, '1', 1),
(34, 'Lạng Sơn', 35, '1', 1),
(35, 'Lào Cai', 36, '1', 1),
(36, 'Lâm Đồng', 37, '1', 2),
(37, 'Long An', 38, '1', 3),
(38, 'Nam Định', 39, '1', 1),
(39, 'Nghệ An', 40, '1', 2),
(40, 'Ninh Bình', 41, '1', 1),
(41, 'Ninh Thuận', 42, '1', 2),
(42, 'Phú Thọ', 43, '1', 1),
(43, 'Phú Yên', 44, '1', 2),
(44, 'Quảng Bình', 45, '1', 2),
(45, 'Quảng Nam', 46, '1', 2),
(46, 'Quảng Ngãi', 47, '1', 2),
(47, 'Quảng Ninh', 7, '1', 1),
(48, 'Quảng Trị', 49, '1', 2),
(49, 'Sóc Trăng', 50, '1', 3),
(50, 'Sơn La', 51, '1', 1),
(51, 'Tây Ninh', 52, '1', 3),
(52, 'Thái Bình', 53, '1', 1),
(53, 'Thái Nguyên', 54, '1', 1),
(54, 'Thanh Hóa', 55, '1', 1),
(55, 'Thừa Thiên Huế', 56, '1', 2),
(56, 'Tiền Giang', 57, '1', 3),
(57, 'Trà Vinh', 58, '1', 3),
(58, 'Tuyên Quang', 59, '1', 1),
(59, 'Vĩnh Long', 60, '1', 3),
(60, 'Vĩnh Phúc', 61, '1', 1),
(61, 'Yên Bái', 62, '1', 1),
(66, 'An giang', 62, '1', 3),
(67, 'Vũng Tàu', 6, '1', 3),
(68, 'Nha Trang', 4, '1', 0),
(69, 'Điện Biên', 0, '1', 0),
(70, 'Hậu Giang', 0, '1', 0),
(71, 'Đắk Nông', 0, '1', 0),
(72, 'Đắk Lắc', 0, '1', 0);

-- --------------------------------------------------------

--
-- Table structure for table `web_supplier`
--

CREATE TABLE IF NOT EXISTS `web_supplier` (
  `supplier_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(50) DEFAULT NULL COMMENT 'Tên Brand hiển thị',
  `supplier_phone` varchar(20) DEFAULT NULL,
  `supplier_hot_line` varchar(20) DEFAULT NULL,
  `supplier_email` varchar(255) DEFAULT NULL,
  `supplier_website` varchar(255) DEFAULT NULL,
  `supplier_status` tinyint(1) DEFAULT '1',
  `supplier_created` int(11) DEFAULT '0',
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=895 ;

--
-- Dumping data for table `web_supplier`
--

INSERT INTO `web_supplier` (`supplier_id`, `supplier_name`, `supplier_phone`, `supplier_hot_line`, `supplier_email`, `supplier_website`, `supplier_status`, `supplier_created`) VALUES
(107, 'Demo2', '0904488737', '', 'demo@gmail.com', 'demo.vn', 1, 1410606257),
(117, 'SIÊU THỊ ĐIỆN MÁY HC', '18001788', '', 'online@hc.com.vn', 'http://hc.com.vn', 1, 1410630351),
(119, 'Robot Tosy', '04 3248 4666', '04 3248 4666', 'kinhdoanh@tosy.com', 'http://vn.tosy.com', 1, 1410773906),
(122, 'VietBike', '[04]668.00.9', '01999-88-000', 'info@xedapgap.com', 'http://xedapgap.com/', 1, 1410776269),
(125, 'BooShop', '(04) 3978106', '0936.30.36.3', 'order@bosua.vn', 'http://bosua.vn', 1, 1410834872),
(128, 'Canifa Fashion', '(04) 3564209', '04.3577.2870', 'chamsockhachhang@canifa.vn', 'http://canifa.com/', 1, 1410839663),
(131, 'Khách sạn Daewoo Hà Nội', '043 8315000', '', 'sales@daewoohotel.com', 'http://www.daewoohotel.com/', 1, 1410847197),
(134, 'Chudu24.vn', '1900545440', '1900545440', 'chudu24@gmail.com', 'http://chudu24.vn', 1, 1410847463),
(136, 'Saigontourist', '0838225874', '083822 5874', 'saigontourist@gmail.com.vn', 'http://www.saigon-tourist.com/', 1, 1410850104),
(137, 'Kangaroo', '0473 095 588', '092.335.5588', 'kstore@kangaroo.vn', 'http://store.kangaroo.vn', 1, 1411200117),
(139, 'Masscom Việt Nam', '0437679171', '0437679171', 'hotro@masscom.vn', 'http://masstel.vn/site/index', 1, 1411371261),
(141, 'Toàn Anh', '01673886886', '', 'thoaluuthi@muachung.vn', '', 1, 1411440013),
(143, 'Nhà hàng L''annam', '0984901157', '0912032100', 'annambuffet@gmail.com', 'http://annambuffet.vn/', 1, 1411531987),
(146, 'Sunhouse', '043736 66 76', '18006680', 'info@sunhouse.com.vn', 'http://www.sunhouse.com.vn', 0, 1411731247),
(149, 'test', '0973446306', '', 'test@gmail.com', 'test.vn', 1, 1411784613),
(152, 'Điện máy DigiCity', '(04)730 888 86', '1900.6662', 'info@digicity.vn', 'http://digicity.vn/', 1, 1411789925),
(155, 'Mykingdom', '0854318717', '0966032003', 'info@viettinhanh.com.vn', 'viettinhanh.com.vn', 1, 1411962977),
(158, 'Aspen Clinic &amp; Spa', '0963770682', '0435562580', 'p.phuonglinh@gmail.com', 'http://aspenclinic.com.vn/', 1, 1411985979),
(160, 'Myota Vietnam', '0422428238', '', 'kho@myota.com.vn', '', 1, 1412048493),
(161, 'Công ty Ngọc Vũ', '01674 911 800', '043976 56', 'myphamngocvu@gmail.com', 'kma.vn', 1, 1412050455),
(164, 'Royal Lotus Hạ Long', '03 3626 9999', '04 7306 8689', 'info@royallotushotelhalong.com', 'http://royallotushotelhalong.com/', 1, 1412138143),
(167, 'Vietourist', '0915 943 383', '0873 00 10 2', 'info@vietourist.com.vn', 'http://vietourist.com.vn/', 1, 1412139502),
(169, 'MerPerle Hòn Tằm Resort', '08 3785 0927 - 103', '0906683059', 'sales@merperle.vn', 'http://www.merperle.vn', 1, 1412156552),
(170, 'Little Paris Resort', '0623743716', '', 'info@littleparisresort.com.vn', 'http://www.littleparisresort.com.vn/​​​', 1, 1412236521),
(173, 'Villa Delsol Beach Resort', '062.384.555', '062.384.555', 'sm@villadelsol.com.vn', 'http://www.villadelsol.com.vn/', 1, 1412324343),
(176, 'La Sapinette', '063 3550 979', '', 'rsvn@lasapinette.com', 'http://www.lasapinette.com/?m=home', 1, 1412324928),
(179, 'Xe đạp điện Nghĩa Hải', '096 728 7777', '04.351 60766', 'sales@nghiahai.vn', 'http://www.xedapdien.com/', 1, 1412332966),
(182, 'xemlamua.vn', '0979 68 66 88', '0979 68 66', 'info@xemlamua.vn', 'http://www.xemlamua.vn', 1, 1412584073),
(185, 'Khách sạn Vian', '0511.3931319', '', 'sales@vianhoteldanang.vn', 'www.vianhoteldanang.vn', 1, 1412657243),
(188, 'Khách sạn Trendy', '0511 3945657', '', 'saletrendy@yahoo.com', 'http://trendyhotel.com.vn', 1, 1412657890),
(190, 'Emeraude Classic Cruise', '(84-4) 3935 1888', '', 'customer1@emeraude-cruises.com', 'http://www.emeraude-cruises.com/', 1, 1412667300),
(191, 'Khách sạn Mường Thanh', '05113 929 929', '', 'sales2@danang.muongthanh.vn', 'danang.muongthanh.vn', 1, 1412671999),
(194, 'Ancient House River', '0510 3 930 777', '0510 3 930 7', 'sales@ancinenthouseriver.com', 'http://www.ancienthouseriver.com/', 1, 1412673162),
(196, 'Khách sạn Eldora Huế', '054 386 6666', '', 'esa@eldorahotel.com', 'eldorahotel.com', 1, 1412673949),
(198, 'Dalat Palace Luxury', '063 3825 444', '', 'palace.reservations@dalatresorts.com', 'http://www.dalatresorts.com/index.php/vi/dalatpalace', 1, 1412678817),
(200, 'Shambala Spa', '04 3933 9898', '', 'shambala.hn@gmail.com', 'http://shambala.vn', 1, 1412763653),
(202, 'Cửa hàng Ngọc Lan', '0914 817 028', '0914 817 028', 'ngocquynh08101988@gmail.com', '', 1, 1412766241),
(212, 'Siêu thị Ga Gối', '0919716533', '0919716533', 'mrs.ngocbao@gmail.com', '', 1, 1412844250),
(214, 'Modern Life', '0945458811', '18001715', 'trang.nguyenthanh@goldsun.vn', 'http://www.modernlife.vn/', 1, 1412929033),
(215, 'Goldsun Việt Nam', '0437658111', '0945 458 811', 'ngtrang68@gmail.com', 'http://www.goldsun.vn/', 1, 1412933087),
(218, 'Victory Hotel', '0839303182', '', 'nhahangvictory@victoryhotel.com.vn', 'http://www.victoryhotel.com.vn/facilities_service.php', 1, 1412998930),
(221, 'Oriflame HCM Shop', '0908085436', '', 'huutiennhansu9999@gmail.com', 'https://www.facebook.com/pages/Oriflame-HCM/535060059885680', 1, 1412999992),
(223, 'Công ty Phát Việt', '04 3 5141429', '', 'pvdistribution69@yahoo.com', 'http://pvdistribution.com/', 1, 1413448737),
(224, 'Sứ Buffet', '043 9413338', '096 438 8844', 'letansubuffet@gmail.com', 'www.subuffet.com', 1, 1416198202),
(225, 'Dalat Hotel Du Parc', '063 3825 777', '063 3825 7', 'duparc.reservations@dalatresorts.com', '', 1, 1416223169),
(226, 'Siêu thị mẹ &amp; bé Babysol', '04 35668669', '1900 6496', 'dang.tuanh@echovietnam.com', 'http://www.babysol.vn/', 1, 1416283254),
(228, 'hồ chí minh', '0973445255', '', 'hcm@gmail.com', '', 1, 1416301085),
(230, 'Nhà Hàng Alfresco''s', '0908131568', '0908131568', 'ld@alfrescosgroup.com', '', 1, 1416371592),
(231, 'Eden Saigon Hotel', '0988896545', '0988896545', 'fb@edensaigonhotel.com', 'https://www.edensaigonhotel.com/', 1, 1416373143),
(232, 'Lakeside Hotel', '043 8350111', '0928004213', 'hoanganh.marketing@lakesidehotel.com.vn', 'lakesidehotel.com.vn', 1, 1416374001),
(233, 'Yến A Hoàng', '01296507173', '01296507173', 'dangchitam2006vn@yahoo.com', '', 1, 1416379742),
(234, 'Yến sào Chấn Phi', '0903766683', '0903766683', 'yensaochanphi@yahoo.com', 'http://www.yensaochanphi.com/', 1, 1416379989),
(235, 'Ví Nam Nữ The Real Partner', '0908142737', '0908142737', 'cosothanhtrieu@gmail.com', '', 1, 1416380218),
(236, 'Moriitalia', '090.222.3773', '043.564.3611', 'hanh09071982@gmail.com', 'moriitalia.com', 1, 1416395869),
(237, 'Wa Japanese Cuisine', '04.37153663', '04.37153663', 'wahanoi@gmail.com', 'http://wa-cuisine.com/', 1, 1416545064),
(238, 'Kidsplaza', '08.3830.6358', '08.3830.6358', 'contact@kidsplaza.vn', 'http://www.kidsplaza.vn/', 1, 1416545868),
(239, 'Thời trang Remmy', '04.6670.0808', '094 242 1111', 'sales@remmy.vn', 'http://remmy.vn/', 1, 1416556745),
(240, 'Trung Tâm Điều Trị Da Công Nghệ Cao  Nữ Hoàng Thẩm', '0934427282', '0934427282', 'ngocmytran78@gmail.com', '', 1, 1416562115),
(241, 'NaSaTouRist - Sài Gòn Năm Sao', '0917.000.978', '0917.000.978', 'info@nasatourist.com', 'nasatourist.com', 1, 1416625423),
(242, 'Quán Ăn Ngon', '(04)39461485', '090 212 6963', 'sales@phuchungthinh.vn', 'http://www.ngonhanoi.com.vn/', 1, 1416627060),
(243, 'KM VIỆT NAM', '0976 800 825', '', 'km@kmcosmetic.com.vn', 'http://myphamnhatban.vn/default.aspx', 1, 1416630420),
(244, 'Nhà Hàng Ngân Đình', '0967990688', '0967990688', 'donghai.nguyen@windsorplazahotel.com', '', 1, 1416800314),
(245, 'BANDOLINI', '04.3543 4430', '', 'bandolini.shoes@gmail.com', 'http://bandolini.com.vn/', 1, 1416902832),
(246, 'Windsor Plaza', '0967990689', '0967990688', 'donghai.nguyen@gmail.com', '', 1, 1417062133),
(247, 'Aroma Beach Resort &amp; Spa Mũi Né', '0623.828288', '', 'reservation@aromabeachresort.com', 'http://www.aromabeachresort.com/', 1, 1417084147),
(248, 'Hue Riverside Boutique Resort', '054.3978484', '054.3938301', 'info@hueriversideresort.com', 'http://www.hueriversideresort.com/', 1, 1417084753),
(249, 'Thời trang Phan Nguyễn', '0122.6366.066', '', 'thoitrangphannguyen2014@gmail.com', 'http://www.pnf.vn/', 1, 1417142805),
(250, 'Thời trang Venice', '0985 79 8686', '0915308286', 'tiensm@gmail.com', 'http://www.venice.esitevn.com/', 1, 1417144783),
(251, 'Khách sạn Cẩm Đô Đà Lạt', '0633 822 732', '', 'camdosale@gmail.com', 'www.camdohotel.com', 1, 1417410463),
(252, 'Khách sạn Valentine - TPHCM', '08 38 30 38 33', '', 'valentinehotelvn@gmail.com', 'www.valentinehotelvn.com', 1, 1417421899),
(253, 'Osaka Village Dalat', '0633.533.160', '', 'osakadalat@yahoo.com.vn', '', 1, 1417423441),
(254, 'Khách sạn Nhật Thành - Nha Trang', '058.222.0.555', '', 'sales@nhatthanhhotel.com.vn', 'http://nhatthanhhotel.com.vn/VN/', 1, 1417425529),
(255, 'Thời trang Pacolano', '096.456.7676', '', 'PACOLANO.CO@gmail.com', 'http://pacolano.com.vn/', 1, 1417428099),
(256, 'Khoảnh Khắc Việt', '099 352 6888', '099 352 6888', 'tuanhm76@gmail.com', 'http://khoanhkhacviet.com/', 1, 1417511786),
(257, 'BIBOMART', '0437871168', '1900 5555 80', 'info@bibomart.com.vn', 'http://bibomart.com.vn/', 1, 1417516722),
(258, 'Nhà hàng 1915INDOCHINE', '043 976 1915', '0986 79 1915', 'ngocnguyenthinhu@muachung.vn', 'http://1915indochine.com.vn/', 1, 1417574646),
(259, 'KIDS PLAZA', '0473000088', '1900.609', 'hoailethithu@muachung.vn', 'http://www.kidsplaza.vn/', 1, 1417662685),
(260, 'PANASONIC', '0900000000', '', 'PANASONIC@gmail.com', '', 1, 1417675431),
(261, 'TOSHIBA', '0900000001', '', 'TOSHIBA@gmail.com', '', 1, 1417675486),
(262, 'CTY TNHH PHÚC NGỌC ANH', '083.9434988', '0933.77.3903', 'phucngocanh@gmail.com', '', 1, 1417675981),
(263, 'Nhà hàng Java Crawfish', '0437150150', '01239159999', 'info@javacrawfish.com', 'https://www.facebook.com/JavaCrawfish', 1, 1418007678),
(264, 'Phú Thịnh Boutique Resort &amp; Spa - Hội An', '0510 392 3923', '', 'sm@phuthinhhotels.com', 'www.phuthinhhotels.com', 1, 1418029398),
(265, 'Thời trang NEM', '04.39393664', '04.39393664', 'lienhe@newnem.com', 'http://www.newnem.com/', 1, 1418099798),
(266, 'Mazano Fashion', '0933.128.986', '0933.128.986', 'thaocao.marzano@gmail.com', 'http://www.marzano.com.vn/', 1, 1418180344),
(267, 'Icook', '(84 4) 3722 6354', '0435.186.186', 'icook@ggg.com.vn', 'http://www.ggg.com.vn/', 1, 1418785762),
(269, 'TopHit', '(04) 6.281.9555', '(04)62819555', 'quyen.newnem@gmail.com', 'https://www.facebook.com/tophitfashion/info?tab=page_info', 1, 1418974230),
(270, 'Champs Việt nam', '0903868896', '0903868896', 'nguyenkhachung862@gmail.com', 'http://champs-vn.com/', 1, 1419327602),
(271, 'Khách sạn Thanh Lịch', '054.3877877', '054.3877877', 'sales@eleganthotel.com.vn', 'http://thanhlichhotel.com.vn/', 1, 1419330079),
(272, 'KHÁCH SẠN CENDELUXE', '057.3818.818', '057.3818.818', 'sm5@hkh.vn', 'http://www.cendeluxehotel.com', 1, 1419333031),
(273, 'Church Boutique Hàng Cá', '04 3923 4499', '04 3923 4499', 'ecom1@hkh.vn', 'http://hangca.churchhotel.com.vn/', 1, 1419333391),
(274, 'Playboy', '043.736.8282', '', 'linhnt712@gmail.com', 'https://www.facebook.com/liveplaylove?ref=ts&amp;fref=ts', 1, 1419395695),
(275, 'Funai', '0909.007.054', '0909.007.054', 'trung.funai@gmail.com', 'http://funai.com.vn/', 1, 1419490855),
(276, 'Khách sạn Đèn Lồng Đỏ', '0977 689 137', '0977 689 137', 'thuyphan@denlongdo.vn', '', 1, 1419508895),
(277, 'Miu xinh', '0973222222', '', 'miu@gmail.com', '', 1, 1420015213),
(278, 'CÔNG TY TRÀ HÀN', '(08)38208572', '094.5454.388', 'miiulee@yahoo.com.vn', 'http://nokchawon2013.koreasme.com/cerfificates.html', 1, 1420019695),
(279, 'VVindsor Spa', '38323288_2330', '38323288_233', 'kelly.law@windsorplazahotel.com', 'www.windsorplazahotel.com', 1, 1420021567),
(287, 'Mắt kính Việt', '08.62913379', '0918888515', 'matkinhviet.vn@gmail.com', 'matkinhviet.vn', 1, 1420517599),
(288, 'Đồng Hồ Hải Triều', '01253246810', '01253246810', 'lienhe@DongHoHaiTrieu.Com', 'DongHoHaiTrieu.Com', 1, 1421133347),
(289, 'Nhà hàng Yakiniku Gensan', '091 233 50 00', '0942782228', 'yakinikugensan149@gmail.com', 'http://yakinikugensan.vn/', 1, 1421309642),
(290, 'Điện máy Bình Minh', '086292 5323', '0902438777', 'info@dienmaybinhminh.com', 'http://dienmaybinhminh.com/', 1, 1421312780),
(291, 'Skinlover', '0947639522', '0933584286', 'anhnguyen1512@gmail.com', 'http://skinlovers.vn/', 1, 1421735897),
(292, 'Shoptretho', '0982120066', '0982120066', 'cskh.shoptretho@gmail.com', 'https://shoptretho.vn/', 1, 1421739865),
(293, 'Eveline', '0982988298', '0933584286', 'trieuvi.bui@gmail.com', 'http://eveline.vn/', 1, 1421913479),
(294, 'Nhà hàng Ý Mondo', '0989 130 876', '0989 130 876', 'linh.nt@mondogroup.vn', 'www.mondo.vn', 1, 1421918149),
(295, 'HONG SHUAN Co..Ltd', '08 66 836 813', '098 636 9133', 'hongshuan@hongshuan.com', 'www.hongshuan.com', 1, 1422266904),
(296, 'Công ty TNHH Thế Giới Huy Hoàng', '091.654.0404', '0938 515 404', 'thegioihuyhoang@gmail.com', 'http://www.casauhuyhoang.com', 1, 1422349576),
(297, 'ZPizza', '043 719 5959', '', 'trangtth@zpizza.vn', 'http://www.zpizza.vn/products-lang-vn-place--active_food-156-food_id-145.htm', 1, 1422497975),
(298, 'Bệnh viện đa khoa quốc tế Thu Cúc', '04 383 55555', '0964080999', 'tuvan@thucuchospital.vn', 'http://thammythucuc.vn/', 1, 1423124984),
(299, 'Royal Baby Việt Nam', '0987.557.575', '0987.557.575', 'skh.royalbike@gmail.com', 'http://xedaphoanggia.com', 1, 1423191538),
(300, 'Công ty Cổ phần vàng bạc đá quý Phú Nhuận', '08 3995 9336', '08 3995 9336', 'pnj@pnj.com.vn', 'www.shopping.pnj.com.vn', 1, 1423290085),
(301, 'Trộm vía', '0978 197 124', '098.212.0066', 'hoangthaont35@gmail.com', 'http://tromvia.com/', 1, 1423452010),
(302, 'Thế giới hải sản', '0987728085', '090 448 2626', 'nhahangsieuthithegioihaisan@gmail.com', 'thegioihaisan.vn', 1, 1425543650),
(303, 'Du thuyền Bhaya', '0919744141', '0933 446 542', 'sales@bhayacruises.com', 'www.bhayacruises.com/', 1, 1425613851),
(304, 'CÔNG TY CỔ PHẦN MAY NANIO', '3845 6785', '0913 978 665', 'congtynanio@gmail.com', 'www.nanio.vn', 1, 1425629023),
(305, 'Nhà Hàng Moo Beef Steak', '0932342979', '0932342979', 'hiepmbs72nt@gmail.com', 'http://moobeefsteak.com.vn', 1, 1425958888),
(306, 'techdemo', '0904488733', '', 'tlkit158@gmail.com', '', 1, 1425959440),
(313, 'Thương hiệu Mommy', '0989343340', '0946868080', 'nguyenminhhai.fm@gmail.com', 'http://mommy.vn', 1, 1425975479),
(314, 'Saigon Smile Spa', '0919.34.1881', '', 'caring@saigonsmilespa.com.vn', 'saigonsmilespa.com.vn', 1, 1426562561),
(315, 'Nhà hàng Shinbashi', '0936686562', '', 'shinbashikt214@gmail.com', 'http://www.shinbashi.com.vn', 1, 1426652548),
(316, 'Nhà hàng Ao Ta', '0976989739', '', 'trangtq@aota.com.vn', 'http://aota.com.vn', 1, 1427959907),
(317, 'Nhà hàng Á Gia', '09032.33339', '0968.223583', 'duyvietkfbs@gmail.com', 'agia.com.vn', 1, 1429672758),
(318, 'Bếp từ nhập khẩu Rovigo - Italia', '0915981199', '0942086699', 'info@rovigo-italy.vn', 'www.rovigo-italy.vn', 1, 1430734230),
(348, 'Công ty TNHH Thương mại và Đầu tư Gia Phú', '0962285304', '0962285304', 'vantoan89bn@gmail.com', NULL, 1, 1431317425),
(349, 'CÔNG TY CỔ PHẦN QUỐC TẾ THIÊN ANH', '043 563 8733', '043 563 8733', 'lethuanbluecom@gmail.com', NULL, 1, 1431334069),
(350, 'Lovely Korea Beauty Premium', '0984650538', '0984650538', 'nguyentrongcuong.mba@gmail.com', 'http://lovelykorea.com.vn/', 1, 1431334111),
(351, 'Lê Công Tài - Nguyễn Thị Trà', '0968223223', '0968223223', 'lecongtai_1987@yahoo.com', NULL, 1, 1431404222),
(352, 'Đồ gia dụng Magic One', '04.85855952', '04.85855952', 'magicone.vn@gmail.com', 'http://magicone.vn/page/gioithieu/5', 1, 1431430341),
(353, 'Sanosan - Chan chứa tình mẹ', '04. 37281440', '04. 37281440', 'contact@zinniadistribution.vn', 'http://sanosan.vn/ve-sanosan/', 1, 1431430755),
(354, 'Vương quốc trẻ thơ - Kid''s Kingdom', '0976925208', '0976925208', 'Kidskingdom2010@gmail.com', 'http://kidskingdom.vn/index.php/vi/gioi-thieu/thu-ngo', 1, 1431431563),
(355, 'Đồ chơi Toptoys', '0947.144.921', '0947.144.921', 'congluan@tanthuanduc.com', '', 1, 1431431740),
(356, 'Nội thất cao cấp Koenic', '0968922296', '0968922296', 'thuydt@huratech.com', '', 1, 1431435036),
(357, 'CÔNG TY TNHH MỘT THÀNH VIÊN CORA FOOD & BEVERAGE', '0438215555', '0438215555', 'coracafe.vn@gmail.com', NULL, 1, 1431483555),
(358, 'Công ty TNHH Thực Phẩm Khánh Long', '(04) 3 627 8866- 096', '(04) 3 627 8866- 096', 'khanhlongfood@gmail.com', NULL, 1, 1431488125),
(359, 'Shop Hàn Quốc', '0983386887', '0983386887', '', NULL, 1, 1431494128),
(360, 'CÔNG TY CỔ PHẦN ĐẦU TƯ VÀ KINH DOANH THƯƠNG MẠI HA', '0439746403', '0439746403', 'thinhbd@haneltrading.com.vn', NULL, 1, 1431505419),
(361, 'CÔNG TY CỔ PHẦN TẬP ĐOÀN SUNHOUSE', '0439746403', '0439746403', 'anhpd@sunhouse.com.vn', '', 0, 1431506246),
(362, 'Công ty cổ phần thương mại quốc tế Phú Sỹ', '0983663319', '0983663319', '', NULL, 1, 1431506459),
(363, 'Plan Do See Việt Nam', '0942 907 077', '0942 907 077', 'quannh@plandosee.com.vn', 'http://plandosee.com.vn/vi.html', 1, 1431591659),
(364, 'CÔNG TY TNHH SX &TM Minh Thảo', '0984444433', '0984444433', 'minhthao3d@gmail.com', NULL, 1, 1431593857),
(365, 'THẾ GIỚI ĐẤT NẶN DOH-WORLD', '01236113689', '01236113689', 'nguyenquanganh@thegioidatnan.com', '', 1, 1431595668),
(366, 'Phú Gia Trading', '0988818843', '0988818843', 'phamduy@phugiatrading.com.vn', '', 1, 1431663658),
(367, 'CÔNG TY TNHH VẬT TƯ THIẾT BỊ KỸ THUẬT VIỆT LONG', '0984 849 236', '0984 849 236', 'Dinhxuanhao.vietlong@gmail.com', NULL, 1, 1431922545),
(368, 'Đồ gia dụng thông minh Facare', '0946 693 281', '0946 693 281', 'tieulan80@yahoo.com', 'http://www.coluami.vn/', 1, 1431933464),
(370, 'CÔNG TY TNHH Công nghệ Giải pháp phần mềm GP', '0943881700', '0943881700', 'halampard@gmail.com', NULL, 1, 1432009725),
(371, 'Công ty TNHH TBCS Y tế Đại gia đình Phương Đông', '0435738311', '0435738311', '', NULL, 1, 1432020181),
(372, 'Khoa học và kỹ thuật Bách khoa', '0983640844', '0983640844', 'hn@gmail.com', '', 1, 1432024288),
(373, 'KM Việt Nam', '0976800825', '0976800825', 'km@kmcosmetic.com', 'http://kmcosmetic.com/gioi-thieu.html', 1, 1432092958),
(374, 'Shop Bảo Hân.net', '0975 656 558', '0975 656 558', '', NULL, 1, 1432112296),
(375, 'Công ty CP Sản xuất và TMDV Picker', '0904 791 065', '0904 791 065', '', NULL, 1, 1432121466),
(376, 'Vegionbiotech', '01649614250', '01649614250', '', NULL, 1, 1432179985),
(377, 'CÔNG TY CỔ PHẦN ELMICH', '0916 57 3883', '0916 57 3883', 'minhngoc.nguyen@elmich.vn', NULL, 1, 1432291455),
(378, 'AIME Việt Nam', '0943300677', '0943300677', 'f', '', 1, 1432299529),
(386, 'CÔNGTY CỔ PHẦN KỸ THUẬT CÔNG TRÌNH THANH PHÚC', 'Tel : 04.3646.2166', 'Tel : 04.3646.2166', 'dinh.thanhphucjsc@gmail.com', NULL, 1, 1432351997),
(387, 'Dr Brown''s', '0987757886', '0987757886', 'huy.focushn@gmail.com', 'http://www.drbrowns.com.vn/', 1, 1432356421),
(388, 'Orico', '0972 833 807', '0972 833 807', 'xuandatpt@gmail.com', 'http://linaco.vn', 1, 1432521162),
(389, 'Sữa Celia', '04629608888', '04629608888', 'info@ceia.vn', '', 1, 1432523443),
(390, 'Remax', '0988068881', '0988068881', 'jno.kool@gmail.com', 'iremax.vn', 1, 1432524697),
(391, 'Công ty TNHH Humana Việt Nam', '0979 400 888', '0979 400 888', 'chuc.dominh@huamana.com.vn', NULL, 1, 1432613517),
(392, 'CTY TNHH THƯƠNG MẠI VÀ TƯ VẤN MINH ANH', '043 5377935', '043 5377935', 'info@minhanhltd.com', NULL, 1, 1432715438),
(393, 'CÔNG TY CỔ PHẦN XUẤT NHẬP KHẨU THƯƠNG MẠI ĐÀI LINH', '04.3538 1818', '04.3538 1818', '', NULL, 1, 1432720988),
(394, 'CTY TNHH Aimica Việt Nam', '0866818862', '0838639033', 'rs503.micavn@gmail.com', 'www.i-mica.com.vn', 1, 1432783333),
(395, 'CTY TNHH TM DV Tin Học BNI', '0839225733', '0839225733', '', NULL, 1, 1432790757),
(396, 'CÔNG TY TNHH THƯƠNG MẠI DỊCH VỤ KHƯƠNG VIỆT', '0838685800', '0838685800', '', NULL, 1, 1432791024),
(397, 'APOLLO', '0987234568', '0987234568', '', NULL, 1, 1432791836),
(398, 'Công ty TNHH Thương Mại Dịch Vụ Phúc Hải', '0', '0', '', NULL, 1, 1432798683),
(399, 'Công Ty Cổ Phần Điện Thoại Di Động Thành Công ( Th', '0839901199', '0839901199', 'sale@thanhcongmobile.com', NULL, 1, 1432800204),
(400, 'CÔNG TY TNHH KỸ THUẬT ICOOL', '0862515671', '0862515671', 'ndang.khoa90@gmail.com', NULL, 1, 1432830044),
(401, 'Công Ty TNHH Một Thành Viên Kỹ Thuật Và Khoa Học O', '1800577776', '1800577776', '', NULL, 1, 1432870353),
(402, 'Công ty TNHH TMDV XNK Tân Ngôi Sao May Mắn', '0839778983, 08384684', '0839778983, 08384684', '', NULL, 1, 1432870840),
(403, 'CÔNG TY TNHH MỘT THÀNH VIÊN THƯƠNG MẠI DỊCH VỤ XUẤ', '0', '0', '', NULL, 1, 1432871266),
(404, 'Công ty Cổ phần Hội tụ Thông minh', '0839105566', '0839105566', 'info@smartcom.com.vn', NULL, 1, 1432871785),
(405, 'DIGIWORLD', '08.39290059', '08.39290059', '', '', 1, 1432872212),
(406, 'CÔNG TY TNHH MỘT THÀNH VIÊN THƯƠNG MẠI ÔNG VUA SỐ', 'o', 'o', '', NULL, 1, 1432873107),
(407, 'Goodhealth', '0437264222', '0437264222', 'info@goodhealth.com.vn', '', 1, 1432884077),
(408, 'Công ty Cổ phần Masscom Việt Nam', '0835171250', '0835171250', '', NULL, 1, 1432961463),
(409, 'CÔNG TY CỔ PHẦN ĐẦU TƯ LÊ BẢO MINH', '(08) 3838 6666', '(08) 3838 6666', 'info@lebaominh.vn', NULL, 1, 1433130892),
(411, 'AHANKEN ASIA CO., LTD', '0908770438', '0908770438', '', NULL, 1, 1433301403),
(412, 'Made in USA', '0908669797', '0908669797', '', NULL, 1, 1433302600),
(413, 'CÔNG TY CỔ PHẦN PHÂN PHỐI SẢN PHẨM CÔNG NGHỆ CAO D', '083910 7979', '083910 7979', '', NULL, 1, 1433305192),
(414, 'NHÀ HÀNG SỨ BUFFET', '04 39413338', '04 39413338', '', NULL, 1, 1433321161),
(415, 'Cty CP Aqua Sportswear', '0903857358', '0903857358', '', NULL, 1, 1433403057),
(416, 'Tân Phạm Gia', '0903927607', '0903927607', '', NULL, 1, 1433403130),
(417, 'Bình Tiên Đồng Nai', '0908303027', '0908303027', '', NULL, 1, 1433403182),
(418, 'M.M', '0903332556', '0903332556', '', NULL, 1, 1433403290),
(419, 'Cty TNHH MTV SXTM Trường Thắng', '01672488929', '01672488929', '', NULL, 1, 1433403354),
(420, 'Cửa hàng Depkool', '01672488929', '01672488929', '', NULL, 1, 1433403412),
(421, 'CP Thời Trang Kowil VN S', '0909 533 777', '0909 533 777', '', NULL, 1, 1433403452),
(422, 'Công ty TNHH thiết bị y tế Minh Khoa', '0862925655', '0862925655', '', NULL, 1, 1433407946),
(423, 'Công ty Cổ phần Thương hiệu Quốc tế', '0982201174', '0982201174', 'tamnm@ibcgroup.com.vn', NULL, 1, 1433409956),
(424, 'Cty CP Công Nghệ Viễn Thông Phúc Thịnh', '0938905838 - 0934311', '0938905838 - 0934311', 'thangnguyen@phucthinhgroup.vn', NULL, 1, 1433410818),
(425, 'Chi nhánh Cty TNHH Syn Style', '0904717973 Chị Hạnh ', '0904717973 Chị Hạnh ', '', NULL, 1, 1433411111),
(426, 'Cty TNHH Mậu Đạt', '0902775175', '0902775175', '', NULL, 1, 1433411243),
(427, 'Cty Thương Mại Dịch Vụ XNK Nam Tiên', '0913401543', '0913401543', '', NULL, 1, 1433411303),
(428, 'Cty TNHH MTV Thiên Sao Kim', '0938644913 Mr Quân -', '0938644913 Mr Quân -', '', NULL, 1, 1433411387),
(429, 'Cty TNHH Sản Xuất TMDV XNK Song Tấn', '0918436655', '0918436655', 'quocbao@sotapc.com', NULL, 1, 1433411458),
(430, 'Cty TNHH TMDV Kỹ Thuật Viễn Thoại', '0918177474 Ms Mai - ', '0918177474 Ms Mai - ', 'vienthoaico.ltd@gmail.com', NULL, 1, 1433411553),
(431, 'Công ty CP Xuất Nhập Khẩu và Thương Mại MANIGO', '0466879393', '0466879393', '', NULL, 1, 1433434893),
(432, 'Cty TNHH P.N.I', '090 2455 597', '090 2455 597', '', NULL, 1, 1433469357),
(433, 'Cty CP May BÌNH MINH', '0909977179', '0909977179', '', NULL, 1, 1433469418),
(434, 'CÔNG TY TNHH KHÔNG GIAN CÔNG NGHỆ', '0838424517', '0838424517', 'sales.executive@techmate.vn', NULL, 1, 1433473068),
(435, 'Thời trang Allura', '0438525188', '0438525188', 'vynm@yahoo.com', '', 1, 1433474112),
(436, 'Công ty TNHH Phát triển thương mại và dịch vụ Nam ', '0961005518', '0961005518', 'nguyenson.nt93@gmail.com', NULL, 1, 1433479732),
(437, 'Cty TNHH TM DV Phân Phối Phú An Gia', '0916611072', '0916611072', '', NULL, 1, 1433491677),
(438, 'Yêu Sống', '0906 025 016', '0906 025 016', 'duc.ntm@spsvietnam.com', '', 1, 1433506567),
(439, 'Công ty cổ phần đầu tư phát triển Vĩnh Phát', '0919 268 269', '0919 268 269', 'nguyenchithanh.hypt@gmail.com', NULL, 1, 1433682846),
(440, 'Công ty TNHH Một Thành Viên Yến Sào Tâm Yến', '0916664118', '0916664118', 'duccanh1810@gmail.com', NULL, 1, 1433738234),
(441, 'Công ty TNHH Gia Huy', '0907044018', '0907044018', '', NULL, 1, 1433827479),
(442, 'Công ty TNHH Phạm', '04.373.22.189', '04.373.22.189', 'phamltdco@gmail.com', NULL, 1, 1433843367),
(443, 'Comet Việt Nam', '0436341688', '0436341688', '0436341688@gmail.com', '', 1, 1433845041),
(444, 'Chị Nhàn', '0914608688', '0914608688', 'monngonmientay@gmail.com', NULL, 1, 1433932192),
(445, 'Công ty TNHH Thương mại Xuất nhập khẩu Đức Sơn', '6416448', '6416448', '', NULL, 1, 1433989012),
(446, 'Test Công ty CP VALUE', '0912326698', '0912326698', '', NULL, 1, 1433989516),
(447, 'Công ty TNHH Một Thành Viên Yến Sào Tâm Yến', '0916664118', '0916664118', 'ducanh1810@gmail.com', NULL, 1, 1434007585),
(448, 'Thời trang ALIZA', '0912906926', '0912906926', 'anhphuong1973@gmail.com', '', 1, 1434010399),
(449, 'CÔNG TY TNHH PHÂN PHỐI SNB', '04.39335399', '04.39335399', '', NULL, 1, 1434011539),
(450, 'Vivitoys', '0908293866', '0908293866', 'anhtm.vivitoys@gmail.com', 'http://vivitoy.com/', 1, 1434027044),
(451, 'X.L VIET NAM', '0918.65.85.92 - 0919', '0918.65.85.92 - 0919', 'xlvietnam68@gmail.com', '', 1, 1434168224),
(452, 'CÔNG TY CỔ PHẦN PHÁT TRIỂN NHÀ BẮC TRUNG NAM', '0122 580 2223', '0122 580 2223', '', NULL, 1, 1434185310),
(453, 'OSAKA', '08.9707.257/258', '08.9707.257/258', '', '', 1, 1434360653),
(454, 'Công Ty TNHH CB JAPAN VIỆT NAM', '0975 70 1518​', '0975 70 1518​', 'linh.cbjapan@gmail.com', NULL, 1, 1434429098),
(455, 'MamanBébé', '0915918893', '0915918893', 'Hoai.lt@mamanbebe.vn', NULL, 1, 1434443179),
(456, 'Công ty TNHH Glocal Kim', '04.378.36.150', '04.378.36.150', 'khanhly.gk@gmail.com', NULL, 1, 1434447736),
(457, 'CÔNG TY TNHH TRÀ XANH FUJI', '08 7309 0949 - 09142', '08 7309 0949 - 09142', 'bottraxanh@gmail.com', NULL, 1, 1434513390),
(458, 'CÔNG TY CỔ PHẦN ĐẦU TƯ LIÊN KẾT TƯƠNG LAI', '0939333191', '0939333191', 'thamcao@futurelink.com.vn', NULL, 1, 1434513736),
(459, 'GOLDDAY Việt Nam', '0963 750 296', '0963 750 296', 'bachphuong@goldday.vn', '', 1, 1434679768),
(460, 'Thời trang Busaba', '01675.078.060', '01675.078.060', 'Busaba.thailan@gmail.com', 'http://busabashop.com/', 1, 1435037532),
(461, 'Beautee collagen', '093 221 6466', '093 221 6466', 'vananh@nhatanhcorp.vn', '', 1, 1435070511),
(462, 'Công ty TNHH TM &amp; DV Phân Phối Ánh Dương', '043.9413145', '043.9413145', 'info@phanphoianhduong.com.vn', '', 1, 1435560512),
(463, 'CÔNG TY TNHH AN GIA TIẾN', '08. 3930 7278', '08. 3930 7278', 'angiatien@angiatien.com', NULL, 1, 1435579419),
(464, 'Donlim', '0838230611', '0838230611', 'lvdha@fimexco.com.vn', '', 1, 1435583083),
(465, 'CÔNG TY TNHH THƯƠNG MẠI VẠN AN', '(04) 3 8626345', '(04) 3 8626345', '', NULL, 1, 1435891777),
(466, 'Butnon', '0984 882 352', '04 372 62 072', 'phi41290@gmail.com', 'http://butnon.com.vn/', 1, 1436155811),
(467, 'Tường phi', '08.38100912', '08.38100912', 'bodetour@yahoo.com', '', 1, 1436254253),
(468, 'CÔNG TY TNHH THƯƠNG MẠI VÀ DỊCH VỤ M.U.C VIỆT NAM', '0462.973.973', '0462.973.973', '', NULL, 1, 1436322727),
(469, 'Tupperware Việt Nam', '0974 071 294', '0974 071 294', 'languidevn@gmail.com', '', 1, 1436323320),
(470, 'Dunamex', '04 35120393', '04 35120393', 'info@dunamex.vn', 'http://dunamex.vn/?go=PageSingleContent&amp;igid=889', 1, 1436325047),
(471, 'Máy lọc nước Karofi', '0911109000', '0911109000', 'maylocnuocduynam@gmail.com', 'http://maylocnuocduynam.vn/', 1, 1436332788),
(501, 'Blacker', '0839231923', '0839231923', 'sales@blacker.com.vn', 'http://www.blacker.com.vn', 1, 1436414674),
(502, 'Midea', '0838165839', '0838165839', 'nguyenthuc1608@gmail.com', '', 1, 1436414874),
(503, 'Quạt điện cao cấp Nhật Bản', '0838272783', '0838272783', 'sales@knkvietnam.com.vn', 'http://kdk.com.vn/vi/gioi-thieu-cong-ty_a1', 1, 1436544756),
(504, 'BBcooker', '046 297 2345', '046 297 2345', 'vanthanh@bbcooker.vn', 'http://bbcooker.vn', 1, 1436850373),
(505, 'Hệ Thống POPO.VN', '0989555126', '0989555126', 'hethongpopo@gmail.com', NULL, 1, 1436947149),
(506, 'Công ty TNHH  Đông Dương Sài Gòn', '090.222.3773', '090.222.3773', 'tm10@saigonindochina.com', NULL, 1, 1437014758),
(507, 'Mỹ phẩm MAIKA', '0907290189', '0907290189', 'maibui@myphammaika.vn', '', 1, 1437361079),
(508, 'Công ty TNHH STD Quốc Tế', '0973.862.491', '0973.862.491', '', NULL, 1, 1437466868),
(509, 'CÔNG TY CỔ PHẦN GOLDSUN VIỆT NAM', '0437658111', '0437658111', '', NULL, 1, 1437475920),
(510, 'Microlife', '(08) 353 99 709 – 35', '(08) 353 99 709 – 35', 'info@biomeq.com.vn', 'http://www.microlifevn.com', 1, 1437535262),
(511, 'True Blue', '04.35406572', '04.35406572', 'a', '', 1, 1437559671),
(512, 'Eurohome', '(04).6275.2488', '(04).6275.2488', 'luongvt@eurovision.com.vn', '', 1, 1437560083),
(513, 'Ucomen', '(08) 6264 7573', '(08) 6264 7573', 'info@openmize.com', '', 1, 1437619319),
(514, 'Công ty TNHH Thương mại và đầu tư Xuân Anh', '0978341289', '0978341289', '', NULL, 1, 1438053686),
(515, 'Carnaval Restaurants', '0901.795.658', '0901.795.658', 'nhahangcarnaval@gmail.com', '', 1, 1438143929),
(516, 'CÔNG TY CỔ PHẦN ĐẦU TƯ  & PHÁT TRIỂN THƯƠNG MẠI VI', '0982.936.344', '0982.936.344', 'media@faster.vn', NULL, 1, 1438222251),
(517, 'Justin House', '0838590189', '0838590189', 'kieu.banh@kimsoncorp.com', '', 1, 1438225313),
(518, 'BEESMART', '0862819177', '0862819177', 'Infor@beesmart.vn', '', 1, 1438229607),
(519, 'CHI NHÁNH CÔNG TY CỔ PHẦN BÓNG ĐÈN PHÍCH NƯỚC RẠNG', '0837545233', '0837545233', 'duan.rangdong@gmail.com', NULL, 1, 1438229836),
(520, 'Gali', '083517008', '083517008', 'thuky_pkd@gali.com.vn', '', 1, 1438230727),
(521, 'La Cell', '0905198333', '0905198333', 'nguyenhangdoantrinh@gmail.com', '', 1, 1438232923),
(522, 'CÔNG TY CỔ PHẦN THƯƠNG MẠI CARPA VIỆTvNAM', '0462552288', '0462552288', '', NULL, 1, 1438599697),
(523, 'RoyalCooks', '0466753579', '0466753579', 'giapnt@royalcooks.vn', '', 1, 1438656225),
(524, 'Vivantjoie', '090 222 1358', '090 222 1358', '', '', 1, 1438668933),
(525, 'CỔ PHẦN VÀ SẢN XUẤT VÀ THƯƠNG MẠI A2T', '0973858933', '0973858933', '', NULL, 1, 1438669651),
(526, 'Beer &amp; Barrel', '08 39 333 345', '08 39 333 345', 'infor@beerandbarrel.com.vn', '', 1, 1438689968),
(527, 'Pisen', '0862651266', '0862651266', 'tranthihienna@gamek.vn', '', 1, 1438751469),
(528, 'Triumph Việt Nam', '0904.431.222', '0904.431.222', 'promotion-info.vietnam@triumph.com', '', 1, 1438758391),
(529, 'Chuchu Baby', '0987.207.642', '0987.207.642', 'ngthuynga.nd@gmail.com', '', 1, 1438848285),
(530, 'NH Ấn Độ Spice India', '0908471776', '0908471776', 'spiceindia.dist1@gmail.com', NULL, 1, 1439002394),
(531, 'Teka', '0466.812.901', '0466.812.901', 'elegantluxury484@gmail.com', '', 1, 1439007564),
(547, 'Gunners &amp; Western', '838162854', '838162854', 'nguyenthuc1608@gmail.com -1', '', 1, 1439282201),
(548, 'Chanli Spa', '0965911818', '0965911818', 'chanlispa@yahoo.com', '', 1, 1439287059),
(549, 'Spa Tropic', '0908138546', '0908138546', 'minhtam1.spa@gmail.com', '', 1, 1439355817),
(550, 'NGUYỄN THỊ CHÂU', '0908138545', '0908138545', 'minhtam.spa@gmail.com', NULL, 1, 1439356187),
(551, 'Moen', '04.3987.6740', '04.3987.6740', 'info@thietbivesinh123.com', '', 1, 1439370289),
(552, 'CÔNG TY TNHH MTV NHÀ HÀNG TRƯỜNG THỊNH', '38242411', '38242411', 'tbminh12@gmail.com', NULL, 1, 1439435018),
(553, 'CÔNG TY TNHH ĐẦU TƯ PETRO ELECTRIC VIỆT NAM', '0919118255', '0919118255', 'sactotvn@gmail.com', NULL, 1, 1439438557),
(554, 'Công Ty TNHH Mỹ Phẩm Hankyung Việt Nam', '04.3974.9724', '04.3974.9724', 'info@itsskin.com.vn', NULL, 1, 1439439440),
(555, 'Chính Hãng FPT', '04 7300 6666', '04 7300 6666', 'fpt_trading@fpt.com.vn', '', 1, 1439536492),
(556, 'Beurer', '04 35773151', '04 35773151', 'info@thietbiyte-eu.vn', '', 1, 1439784352),
(557, 'Ohi@ma', '0838031661 - 0862941', '0838031661 - 0862941', 'hoamai54@yahoo.com', '', 1, 1439874410),
(558, 'TCL', '04.32484627', '04.32484627', 'thienhoanglong868@gmail.com', '', 1, 1439891012),
(559, 'Mattana', '04.3533 4853', '04.3533 4853', '', '', 1, 1439952672),
(560, 'Phụ kiện Samsung', '01233698888', '01233698888', 'phongdd@itvn.vn', '', 1, 1439953016),
(561, 'Nhà Hàng Chay 3 Lá', '(08) 6683 0303', '(08) 6683 0303', 'nguyentonhoangdung77@gmail.com', '', 1, 1439956821),
(562, 'Yến Sào Sài Gòn Anpha', '0838300980', '0838300980', 'trolygddh.anpha@gmail.com', '', 1, 1440045467),
(563, 'Tiross', '(08) 3995 3597', '(08) 3995 3597', 'phanle0928@gmail.com', '', 1, 1440065304),
(564, 'NHA KHOA BẠCH KIM', '( 84.8) 3920.99.69', '( 84.8) 3920.99.69', 'drnhan@nhakhoaplatinum.com', '', 1, 1440217846),
(565, 'NHA KHOA BẠCH KIM', '( 84.8) 3920.99.69', '( 84.8) 3920.99.69', 'drnhan@nhakhoaplatinum.com', NULL, 1, 1440217999),
(566, 'Salon Hiếu Trang', '01203888666', '01203888666', 'hieutranghp363@gmail.com', '', 1, 1440400714),
(567, 'CB Japan', '04.32.00.99.70', '04.32.00.99.70', 'tthuong90@gmail.com', '', 1, 1440467530),
(568, 'CÔNG TY TNHH NHÀ HÀNG KHÁCH SẠN VÀ DU LỊCH VĨNH AN', '( 84) 85404 2220', '( 84) 85404 2220', '', NULL, 1, 1440473130),
(569, 'Nhà Hàng Chay Om Mani Padme Hum', '(08) 3837 5613 - 090', '(08) 3837 5613 - 090', 'chungnguyenom@gmail.com', '', 1, 1440480026),
(570, 'Frezzii', '2345', '0437264222', '123', '', 1, 1440659280),
(571, 'CÔNG TY TNHH MR DEE', '0913714352', '0913714352', '', NULL, 1, 1440661009),
(572, 'Blooms', '0904537877', '', 'thucphamchucnang102@gmail.com', '', 1, 1440820358),
(573, 'Vplus', '0904537878', '', 'thucphamchucnang103@gmail.com', '', 1, 1440820421),
(574, 'CÔNG TY TNHH GOLDENDOLPHIN', '0902206600', '0902206600', 'phamphihung83@gmail.com', NULL, 1, 1440822125),
(575, 'Cty TNHH TMDV và ĐT Nhất Long', '043.6420958', '043.6420958', 'Nhatlongcompany@yahoo.com', '', 1, 1440988305),
(576, 'Born Free', '0000000', '', '0000000', '', 1, 1440991111),
(577, 'CÔNG TY TNHH TM DV EDEN', '0973533339', '0973533339', '', NULL, 1, 1440993675),
(578, 'Công ty CPTM tổng hợp XNK TVH', '0435881127', '0435881127', '', NULL, 1, 1441017846),
(579, 'CÔNG TY CỔ PHẦN GOLDSUN VIỆT NAM', '01679308727', '01679308727', 'anh.phamnhat@goldsun.vn', NULL, 1, 1441074054),
(580, 'Teka', '0903262940', '', 'viet.teka@gmail.com', '', 1, 1441076818),
(581, 'Hatha Fitness &amp; Yoga', '0838265388', '0838265388', 'hieutruong2205@gmail.com', '', 1, 1441082849),
(582, 'Modern Life', '12345678', '', '12345678', 'http://www.modernlife.vn/', 1, 1441083065),
(583, 'CÔNG TY CỔ PHẦN KỸ NGHỆ VÀ THƯƠNG MẠI NHẬT MINH', '0914.838.968', '0914.838.968', '', NULL, 1, 1441102129),
(584, 'Phụ Kiện Samsung', '0967838021', '01233698888', 'phongdd@phukiensamsung.com', 'http://www.phukiensamsung.com/', 0, 1441246949),
(585, 'Hanoi Tech Buy', '04 3873 7855', '0902206600', 'phamphihung803@gmail.com', 'http://hanoitechbuy.com/', 1, 1441247426),
(586, 'Beaumore', NULL, '1900636466', 'cskh@nemo.vn', NULL, 1, 1444126738),
(587, 'Mills Ray', NULL, '1900636466', 'cskh@nemo.vn', NULL, 1, 1444126738),
(588, 'Công ty TNHH Hàng nhập khẩu Châu Âu', '0988088886', '0988088886', 'admin-eui@eu-imports.com.vn', NULL, 1, 1441257819),
(589, 'Công Ty Cổ Phần Chìa Khóa Lê', '0918192220', '0918192220', 'vinguyen@comtamcali.com', NULL, 1, 1441277054),
(590, 'Công ty TNHH Faso Việt Nam', '0436408627', '0436408627', '', NULL, 1, 1441340126),
(591, 'Chi nhánh công ty TNHH Happycook', '3600583091-001', '3600583091-001', 'hoa.dao@happycook.com.vn', NULL, 1, 1441343594),
(592, 'Konigin', '0965999699', '0965999699', 'konigin.vn@gmail.com', '', 1, 1441343859),
(593, 'Ohui', '0376.662.888', '0376.662.888', '', '', 1, 1441591472),
(594, 'Forci', '0439921286', '0439921286', '', '', 1, 1441591776),
(595, 'Suzuran Baby', '( 84) 462537335', '( 84) 462537335', '', '', 1, 1441594809),
(596, 'Chi nhánh Công ty Cổ phần công nghệ Silicom Hà Nội', '04.37323232', '04.37323232', 'kd4.hn@silicom.com.vn', '', 1, 1441605281),
(597, 'Fornix', '08 62636162', '08 62636162', 'mr.tungha@gmail.com', '', 1, 1441682733),
(598, 'CÔNG TY TNHH SẢN XUẤT VÀ XÂY DỰNG HOÀNG GIA', '0986296904', '0986296904', 'mart@lottebeverage.vn', NULL, 1, 1441686328),
(599, 'GOLD CARE', '84822242168', '84822242168', 'trieubui@gilos.com.vn', '', 1, 1441688921),
(600, 'Smart Salt', '0839913728', '0839913728', 'lily.nguyen@smart-health.com.vn', '', 1, 1441691444),
(601, 'Mai Hoàng', '01663818639', '01663818639', '', '', 1, 1441701594),
(602, 'Digiworld', '04 3936 4333', '04 3936 4333', '', '', 1, 1441707252),
(603, 'Digiworld Hà Nội', '043 - 9388568', '043 - 93885', 'support@digiworldhanoi.vn', 'http://digiworldhanoi.vn/', 1, 1441707690),
(604, 'VIFAMI', '04. 6252 6252', '04. 6252 6252', '', '', 1, 1441777553),
(605, 'Kyoritsu VietNam', '0914 363 555', '0914 363 555', 'nguyendt.ste@gmail.com', '', 1, 1441797698),
(606, 'Công ty TNHH Beuer N&C Việt Nam', '0462603264', '0462603264', 'dungmkt998@gmail.com', NULL, 1, 1441854925),
(607, 'TVS - Italy', '(84 4) 632 1502', '(84 4) 632 1502', 'Bổ sung sau', '', 1, 1441861134),
(608, 'CÔNG TY CỔ PHẦN TỐT GỖ', '043 5668509/ : 0902 ', '043 5668509/ : 0902 ', 'thuyngoc7903@gmail.com', NULL, 1, 1441880765),
(609, 'QUARTET', '(08)  3920 5920', '(08)  3920 5920', 'sale@bnp.vn', '', 1, 1441881213),
(610, ': CÔNG TY TNHH CÔNG NGHỆ THÔNG TIN NÓNG ĐỎ', '(08) 38630664', '(08) 38630664', '', NULL, 1, 1441892861),
(611, 'POOMKO', '043 5668509', '0983888822', 'phuhg@poomko.com', 'http://poomko.vn/', 1, 1441940952),
(612, 'SUNHOUSE', '0974 782 143', '0974 782 143', 'dungtk@sunhouse.com.vn', '', 1, 1441946432),
(613, 'VitaDairy', '(04) 3 641 6557', '(04) 3 641 6557', 'info@vitadairy.com.vn', 'http://vitadairy.com.vn/', 1, 1442031501),
(614, 'Sowun', '08 377 38 234', '08 377 38 234', 'nhung@hoangbachconex.com.vn', '', 1, 1442067213),
(615, 'Yến sào Nam Việt', '04.6296.2828', '04.6296.2828', '', '', 1, 1442459285),
(616, 'Mũ bảo hiểm Chita', '0977.927.385', '0977.927.385', '', '', 1, 1442477119),
(617, 'Mũ bảo hiểm Chita', '04.36210238', '', 'chitab@chithanhvn.com', 'http://www.chithanhvn.com/', 1, 1442479056),
(618, 'Hệ thống cửa hàng Enmax', '0904781386', '0904781386', 'nguyenanh.tmh@gmail.com', NULL, 1, 1442562022),
(619, 'CÔNG TY TNHH VĨNH TÍN', '0603866668', '0603866668', '', NULL, 1, 1442636267),
(620, 'Công Ty Cổ Phần Phát Triển Thương Mại Và Dịch Vụ Q', '0973596890', '0973596890', 'tinnguyen.quanganhjsc@gmail.com', NULL, 1, 1442747442),
(621, 'CÔNG TY CỔ PH ̀N XU ́T NH ̣P KH ̉U VÀ DỊCH VỤ ', '043.996.9997', '043.996.9997', 'dieptran@tmtshop.vn', NULL, 1, 1442747863),
(622, 'IT''S SKIN', '04.3974.9724', '04.3974.9724', 'info@itsskin.com.vn', '', 1, 1442825493),
(623, 'Công Ty TNHH Phẫu Thuật Thẫm Mỹ Măt Ngọc', '0938073488', '0938073488', 'huynhhuuthach@gmail.com', NULL, 1, 1442854330),
(629, 'Công Ty TNHH Sản Phẩm Tiêu Dùng TOSHIBA - Việt Nam', '8975433', '8975433', 'cuong-nguyenhuy@toshiba.com.vn', NULL, 1, 1442939332),
(630, 'ADELL Việt Nam', '(04) 37346996', '', 'kimanh@adell.com', '', 1, 1442992322),
(631, 'Spigen', '043-540-6389', '043-540-6389', 'spigen.vtt@gmail.com', '', 1, 1443069341),
(632, 'Phụ kiện KIANEX', '(08) 62 935 427', '(08) 62 935 427', 'huy@kianex.vn', 'http://kianex.vn', 1, 1443155996),
(633, 'Công ty cổ phần dịch vụ Vietlife', '0963 392 531', '0963 392 531', '', NULL, 1, 1443433169),
(634, 'Nanakids', '(08) 39142606 -  391', '(08) 39142606 -  391', 'Info@nanakids.vn', '', 1, 1443459034),
(635, 'CÔNG TY TNHH TM DV PHÚC THÀNH AN', '0854102218', '0854102218', 'cs2@pta.vn', NULL, 1, 1443506601),
(636, 'SPIGEN', '(04). 6278 0046', '(04). 6278 0046', 'hao.tran@phongthai.vn', '', 1, 1443511033),
(637, 'Phong Thái', '04) 6278 3718', '', 'huyenqt@phongthai.vn', '', 1, 1443511783),
(638, 'GGMM', '', '', 'hoa@gmail.com', '', 1, 1443516452),
(639, 'Công Ty Cổ Phần Ngôi Nhà Ánh Dương Miền Nam', '08 38691014', '08 38691014', 'trinhph@sunhouse.com.vn', NULL, 1, 1443586061),
(640, 'Hưng Long', '844 36285888', '844 36285888', '', '', 1, 1443599112),
(641, 'Bluedio', '097395 3333', '097395 3333', 'info@tainghe.com.vn', '', 1, 1443602138),
(642, 'CÔNG TY TNHH THƯƠNG MẠI DỊCH VỤ CÔNG NGHỆ START', '0918 455 855', '0918 455 855', 'info@sotate.com', NULL, 1, 1443603906),
(643, 'Whoo', '0900000000', '', 'sdsadsads@dssdsjdhsajdsajk', '', 1, 1443684632),
(644, 'Sinbo', '(04)36340532', '(04)36340532', 'update...', '', 1, 1443769204),
(645, 'Audio Technica', '(08) 6 292 4428 -  (', '(08) 6 292 4428 -  (', 'sang.nguyen@synstyle.com.vn', '', 1, 1443770342),
(646, 'iOne', '0437331830', '0437331830', '', '', 1, 1443838626),
(647, 'Philiger', '212324233443', '', '12312321234324', '', 1, 1443848482),
(648, 'Steven Spa &amp; Salon', '(08) 6672 4888', '(08) 6672 4888', 'phuchoang117@gmail.com', '', 1, 1443850845),
(649, 'Chicco', '000123', '', 'emailkhongphainhap', '', 1, 1444009846),
(650, 'CÔNG TY TNHH MTV KOVIN', '08-3601-9564', '08-3601-9564', 'duan.lh@kovin.vn', NULL, 1, 1444028164),
(651, 'Công Ty TNHH Việt Chí Thành', '043 85 25 373', '043 85 25 373', '', NULL, 1, 1444037175),
(652, 'CÔNG TY TNHH ĐẦU TƯ THƯƠNG MẠI KỸ THUẬT PHƯƠNG ANH', '0915696933', '0915696933', 'mydieu12@gmail.com', NULL, 1, 1444063637),
(653, 'TEASANA', '04.363 21079', '04.363 21079', 'teasana', '', 1, 1444116172),
(654, 'Công ty TNHH MTV Ra Beaute Vina', '0839308398', '0839308398', 'annaphan20@gmail.com', NULL, 1, 1444122387),
(655, 'Công Ty TNHH Điện Tử - Điện Lạnh Bình Minh', '0848 3945 3483', '0848 3945 3483', 'support@binhminhcompany.com', NULL, 1, 1444138269),
(656, 'Anker', '123123123', '', 'emailkhongco', '', 1, 1444185293),
(657, 'Công ty cổ phần xuất nhập khẩu Tency', '0462538162', '0462538162', 'minh.nguyet@tenbike.com.vn', NULL, 1, 1444274725),
(658, 'CÔNG TY TNHH MTV NHIỆM MÀU', '84 8 39939919', '84 8 39939919', 'qui.chau@miraclediamond.vn', NULL, 1, 1444287528),
(659, 'R&amp;B', '111111111', '', 'emailkhongcodau', '', 1, 1444364765),
(660, 'Công ty cổ phần HTB Việt Nam', '0912.146.147', '0912.146.147', 'trongduyg2@gmail.com', NULL, 1, 1444372244),
(661, 'HP', '(84 4) 3537 8637', '(84 4) 3537 8637', '', '', 1, 1444372937),
(662, 'CosMedical', '08 3846 4480', '08 3846 4480', '', '', 1, 1444374517),
(663, 'EDUGAME', '0822165171', '0822165171', 'songchau912@gmail.com', 'http://www.edugames.edu.vn/hmp/', 1, 1444374707),
(664, 'CÔNG TY CỔ PHẦN XUẤT NHẬP KHẨU THƯƠNG MẠI ĐÀI LINH', '043 538 1818', '043 538 1818', 'huongpt@dailinhgroup.vn', NULL, 1, 1444397979),
(665, 'Mỹ phẩm thiên nhiên', '123765', '', 'khongcodau', '', 1, 1444400801),
(666, 'Hotor', '5431', '', 'lamgicoha', '', 1, 1444619075),
(667, 'Song Long', '0866741149', '0866741149', 'happyplastic1202@gmail.com', '', 1, 1444624911),
(668, 'Sản phẩm Hàn Quốc', '0983 386 887', '0983 386 887', 'linhct0508g@gmail.com', '', 1, 1444705430),
(669, 'CÔNG TY TNHH ĐIỆN TỬ ĐIỆN LẠNH VIỆT NHẬT', '083.8112084', '083.8112084', '', NULL, 1, 1444709180),
(670, 'ARGO', '08-35180099', '08-35180099', '', '', 1, 1444712110),
(671, 'Công ty TNHH CÔNG TY CỔ PHẦN MỸ PHẨM KANG NAM', '04.62.923.873', '04.62.923.873', '', NULL, 1, 1444728492),
(680, 'CÔNG TY TNHH THẾ GIỚI TÚI XÁCH', '(08) 3845 4966', '(08) 3845 4966', 'info@thegioituixach.com.vn', NULL, 1, 1444918103),
(681, 'CN TẠI TPHCM –CÔNG TY TNHH PHÂN PHỐI SNB', '08.38208554', '08.38208554', 'saleshcm00.01@snb.com.vn', NULL, 1, 1444918559),
(682, 'CHI NHÁNH CÔNG TY TNHH ĐỒ DÙNG GIA ĐÌNH SA PA TẠI ', '043.7833770/71', '043.7833770/71', 'dafang2vn@gmail.com', NULL, 1, 1444962909),
(683, 'Bormioli Rocco', '11211', '', 'khongcogica', '', 1, 1444963003),
(684, 'Công ty TNHH Thương Mại thế giới đẹp Sam Lan', '0946081010', '0946081010', 'nhulan@samlan.vn', NULL, 1, 1444963898),
(685, 'Bormioli Rocco', '121212121212', '', 'AAA', '', 1, 1444975775),
(686, 'Động Lực Group', '(84,4)5588418', '(84,4)5588418', 'dongluc', '', 1, 1444982966),
(687, 'Topmost Bike', '0964079882', '0964079882', 'topmostbikevn@gmail.com', '', 1, 1445220526),
(688, 'CÔNG TY CP THIẾT BỊ CÔNG NGHỆ CAO TM', '(04) 3576 3435', '(04) 3576 3435', '', NULL, 1, 1445221617),
(689, 'Braun Electronic Việt Nam', '0982098490', '0982098490', 'tranhoa070984@gmail.com', '', 1, 1445223916),
(690, 'Sport Mart', '04.3747.3747', '04.3747.3747', 'tanlienminhjsc@gmail.com', '', 1, 1445225731),
(691, 'Xuân Phát', '0936 366 166', '0936 366 166', '', '', 1, 1445334275),
(692, 'CÔNG TY CỔ PHẦN VINANOI', '0862 789 409', '0862 789 409', 'mevabe@mbcare.vn', NULL, 1, 1445355859),
(693, 'Iwaki', '109', '', 'abcdef', '', 1, 1445394893),
(694, 'CÔNG TY CỔ PHẦN LỘC ĐẠI QUÝ', '0906508403', '0906508403', 'samnguyen@chefman.vn', NULL, 1, 1445445342),
(695, 'CÔNG TY TNHH THƯƠNG MẠI VÀ DỊCH VỤ XUẤT NHẬP KHẨU ', 'nhap sau', 'nhap sau', '', NULL, 1, 1445480716),
(696, 'Mai Kế Sport', 'Nhập sau', 'Nhập sau', '', '', 1, 1445565708),
(697, 'LAICA', '(04) 3640 4157', '(04) 3640 4157', 'laica', '', 1, 1445567625),
(698, 'CHI NHÁNH CÔNG TY CỔ PHẦN KIM LONG', '0837514422', '0837514422', '', NULL, 1, 1445600070),
(699, 'Hamilton Beach', '3241', '', 'hahaaaa', '', 1, 1445825740),
(700, 'Bialetti', '67545', '', 'aaaaaaaaa', '', 1, 1445838104),
(701, 'Dualit', '567890', '', 'adc', '', 1, 1445840184),
(702, 'Gorenje', '04 35121878 - 0911 4', '0989 288443', 'phong0710@thanhlong.vn', '', 1, 1445918773),
(703, 'CÔNG TY TNHH SX.TM.DV.XNK SONG TẤN', '(08) 35178540 / (08)', '(08) 35178540 / (08)', 'info@songtan.vn', NULL, 1, 1446135684),
(704, 'CTCP Đầu Tư TMDV Tam Tân Quý', '08 3716 4209', '08 3716 4209', 'info@ysdn.vn', NULL, 1, 1446174034),
(705, 'Lacor', '11111111111111111111', '', 'hahahav', '', 1, 1446174403),
(706, 'CS', '5131', '', '333', '', 1, 1446174522),
(707, 'Kitchen Aid', '233333333', '', 'bababa', '', 1, 1446174834),
(708, 'STANLEY', '122121212121', '', 'VVVVVVV', '', 1, 1446174877),
(709, 'CARLMANN', '23111231312312312312', '', 'VVVVVVVVVVVVVVVVVVVVVVVVVVV', '', 1, 1446174897),
(710, 'Đông Trùng Hạ Thảo Kim Lai', '04.3514 7871', '04.3514 7871', '', '', 1, 1446435144),
(711, 'NIKE', '0942362111', '', 'DONGXU@GMAIL.COM', '', 1, 1446612452),
(712, 'K-GIN', '0904.981.981', '0904.981.981', 'ntthu262@gmail.com', '', 1, 1446629045),
(713, 'Công Ty TNHH TM Khánh Tân', '043 636 9456', '043 636 9456', 'khanhtan88@yahoo.com', NULL, 1, 1446694198),
(714, 'CT TNHH THƯƠNG MẠI VÀ SẢN XUẤT NGUYÊN SINH', '04.6685.1818', '04.6685.1818', 'nguyensinhvietnam@gmail.com', NULL, 1, 1446710348),
(715, 'Yến sào Thiên Hoàng', '0903.402.486', '0903.402.486', 'vietthufood@gmail.com', '', 1, 1446711949),
(716, 'Công ty TNHH SX TM Ngôi Sao Xanh', '08 3916 5678', '08 3916 5678', 'info@bluestar-vn.com', NULL, 1, 1446736697),
(717, 'CHARTERHOUSE', '11111111111111111111', '', 'aaaa', '', 1, 1446778240),
(718, 'Moriitalia', '12121214', '', 'fg', '', 1, 1446778370),
(719, 'Tinh dầu Lam Hà', '04.36250718', '04.36250718', '', '', 1, 1446786566),
(720, 'BẢO QUANG', '(04) 37723626', '(04) 37723626', '', '', 1, 1446787206),
(721, 'RoyalBaby', '0987557575', '0987557575', 'cskh.royalbike@gmail.com', '', 1, 1447124732),
(722, 'Mizuno', '04 3944 9999 / 04 38', '04 3944 9999 / 04 38', 'hongminh1901@gmail.com', '', 1, 1447147316),
(723, 'Hoàng Gia Yến', '0917021177', '0917021177', 'hoanggiayen', '', 1, 1447150969),
(724, 'NUTRIBEN', '0854361528', '0854361528', '', '', 1, 1447216350),
(725, 'Hộ kinh doanh Hoàng Thị Mai Yến', '04.6673.9157', '04.6673.9157', 'samnamnamtrieu@gmail.com', NULL, 1, 1447407886),
(726, 'Simba', '08.376.26.266', '08.376.26.266', '', '', 1, 1447730435),
(727, 'Công ty cổ phần Elmich', '0916 57 3883', '0916 57 3883', 'vuthinhutrang.vcu@gmail.com', NULL, 1, 1447737343),
(728, 'FASO', '4444444', '4444444', 'faso', '', 1, 1447737737),
(729, 'MYKINGDOM', '08.54319051', '08.54319051', '', '', 1, 1447833904),
(730, 'CÔNG TY TNHH THƯƠNG MẠI VÀ DỊCH VỤ XUẤT NHẬP KHẨU ', '04-38511616', '04-38511616', '', NULL, 1, 1447908410),
(731, 'CÔNG TY CP ĐẦU TƯ PHÁT TRIỂN CÔNG NGHỆ THỜI ĐẠI MỚ', '04-353 77777', '04-353 77777', '', NULL, 1, 1447919145),
(732, 'Lật đật Nga', '0838342881', '0838342881', '', '', 1, 1447927150),
(733, 'Thảm thổ nhĩ kỳ Antalya', '0904.892.293', '0904.892.293', '', '', 1, 1447991147),
(734, 'Rossi', '043.687.5555', '043.687.5555', '', '', 1, 1448267219),
(735, 'Bosch', '0436276396', '0436276396', 'sdsvietnam', '', 1, 1448350663),
(736, 'HỘ KINH DOANH TRẦN PHÚC THỌ', '0943422268', '0943422268', 'phucthokc@gmail.com', NULL, 1, 1448359522),
(737, 'Alodienthoai VN', '1122', '1122', '1122', 'http://alodienthoai.net/', 1, 1448359839),
(738, 'Bell Shark', '08.3977.8927', '08.3977.8927', 'phuongpham7785@gmail.com', '', 1, 1448381317),
(739, 'Công Ty Cổ Phần Tương Lai Việt', '08. 3502 3930', '08. 3502 3930', 'sales@baby-autoru.com', '', 1, 1448438620),
(740, 'Autoru', '0906975456', '', 'order.autoru@gmail.com', 'http://www.baby-autoru.com/', 1, 1448512913),
(741, 'CÔNG TY TNHH SẢN XUẤT, THƯƠNG MẠI VÀ DỊCH VỤ ĐỨC M', '(090) 469-7677', '(090) 469-7677', 'tranducmanh@gmail.com', NULL, 1, 1448526830),
(742, 'Duc Minh Mobile', '0904697677', '', 'ducmanh0309@gmail.com', 'http://www.ducminhmobile.net/', 1, 1448527098),
(743, 'Apelson', '046 6633779', '046 6633779', 'nguyendung.nsv@gmail.com', '', 1, 1448590970),
(744, 'NGUỒN SỐNG VIỆT', '08. 37480859', '08. 37480859', '', '', 1, 1448601257),
(745, 'Công ty TNHH Việt Năng', '043.9332476', '043.9332476', 'vietnangltd@vietnang.vn', NULL, 1, 1448602830);
INSERT INTO `web_supplier` (`supplier_id`, `supplier_name`, `supplier_phone`, `supplier_hot_line`, `supplier_email`, `supplier_website`, `supplier_status`, `supplier_created`) VALUES
(746, 'Supor', '0466729696', '0466729696', 'namphuong3868@gmail.com', '', 1, 1448604205),
(747, 'Công ty cổ phần kỹ thuật công nghệ Nam Thành', '094 345 3210', '094 345 3210', 'sale03@namthanh.com.vn', NULL, 1, 1448604509),
(748, 'Công ty TNHH FIRST Việt Nam', '04.37830794', '04.37830794', 'tiross.thanglong@gmail.com', NULL, 1, 1448604683),
(749, 'CÔNG TY TNHH TIN HỌC Á ĐÔNG VI NA', '04.35130610', '04.35130610', 'vuthanhlamvn@gmail.com', NULL, 1, 1448606423),
(750, 'OGAWA', '( 84 8) 5.413.3222/', '( 84 8) 5.413.3222/', 'minh.tran@ogawaworld.net', 'www.ogawa.net.vn', 1, 1448609747),
(751, 'Công ty TNHH Winline Việt Nam', '0915258233', '0915258233', 'winlinevietnam@gmail.com', '', 1, 1448612747),
(752, 'Công ty Cổ phần Tâm Mỹ', '03513616789', '0912478289', 'trungmiranda@gmail.com', 'http://miranda.vn', 1, 1448615840),
(753, 'Mật ong Hoa Bốn Mùa', '043. 7846965', '043. 7846965', '', '', 1, 1448616345),
(754, 'SMARTPARKING', 'acb', '', 'acv', '', 0, 1448675846),
(755, 'BNL (Hàn Quốc)', '08. 3773 0779', '08. 3773 0779', 'bnl.acehappy@gmail.com', '', 1, 1448676729),
(756, 'SMARTPARKING', 'AAA', '', 'GHS', '', 1, 1448678215),
(757, 'TRUNG TÂM CHĂM SÓC KHÁCH HÀNG S U N T E K', '01237197997', '01237197997', 'suntek.kd@gmail.com', NULL, 1, 1448678590),
(758, 'SUNTEK', '04 66528661', '04 66528661', 'hieucv1797@gmail.com', 'http://suntekvietnam.vn/vn/', 1, 1448679087),
(759, 'Clever Dog', '0984.227.505', '0984.227.505', 'tuyentran@foscam.vn', 'http://foscam.vn/', 1, 1448702613),
(760, 'Foscam', '(08) 22101327', '', 'support@huyenvu.vn', 'http://foscam.vn/', 1, 1448702777),
(761, 'CÔNG TY CỔ PHẦN THỜI TRANG PHAN NGUYỄN', 'ag', 'ag', '', '', 1, 1448854973),
(762, 'CÔNG TY TNHH ĐẠI ĐOÀN GIA', '0983330380', '0983330380', 'dung.transy@gmail.com', NULL, 1, 1448857278),
(763, 'Đại Đoàn Gia', '046326686', '046326686', 'sydung@daidoangia.com', 'http://daidoangia.vn/', 1, 1448857489),
(764, 'Hauck', '08. 3899 6300', '08. 3899 6300', 'sale1@royalkid.net', 'http://www.royalkid.net/', 1, 1448943897),
(765, 'BABYTOP', '08. 3961 8992', '08. 3961 8992', 'nghilucco@hcm.fpt.vn', '', 1, 1448945408),
(766, 'B-BAGS', 'AGAGAG', '', 'GSHASH', '', 1, 1448956241),
(767, 'Miracle', '0838215855', '0838215855', 'qui.chau@miraclediamond.vn', 'http://www.miraclediamond.vn/', 1, 1449073710),
(768, 'PHAN NGUYEN', 'AFAF', '', 'AGSH', '', 1, 1449110573),
(769, 'HUYNDAI WACORTEC', '04 66756742 - 046675', '04 66756742 - 046675', '', '', 1, 1449113574),
(770, 'Kho Di Động', '0983605699', '0983605699', 'khodidong', '', 1, 1449136700),
(771, 'Kho Di Động', '(098) 360-5699', '(098) 360-56', 'thanhtd@diemsangviet.vn', '', 1, 1449136823),
(772, 'OMRON', '04.85886151', '04.85886151', 'ưewewewew', '', 1, 1449174922),
(773, 'CÔNG TY TNHH KINH DOANH VÀ DỊCH VỤ THANH LOAN', '0935665995', '0935665995', 'hiennn1302@gmail.com', NULL, 1, 1449217329),
(774, 'Phụ kiện Phương Loan', '(093) 566-5995', '', 'hiennn1302@yahoo.com', '', 1, 1449217550),
(775, 'ÔNG TY TNHH THỜI TRANG MẶT TRỜI HỒNG', '08.22124030 - 08.383', '08.22124030 - 08.383', '', NULL, 1, 1449232675),
(776, 'The Herbal Cup', '( 84) 90 979 1200 -', '( 84) 90 979 1200 -', 'customer.service@theherbalcup.vn', 'www.theherbalcup.vn', 1, 1449244082),
(777, 'RIONET', '21343254', '', '43423423423', '', 1, 1449255363),
(778, 'Ching Ching', '04 35668556', '04 35668556', 'info@dochoihanoi', '', 1, 1449290247),
(779, 'CT CP TM DV TRUYỀN THÔNG TNG VIỆT NAM', '0438647120', '0438647120', '', NULL, 1, 1449297473),
(780, 'PSF', 'AGGE', '', 'ẦGAG', '', 1, 1449392014),
(781, 'Dynamic Vina', '08.62622670', '08.62622670', '', '', 1, 1449456885),
(782, 'CÔNG TY TNHH NHẬT LINH', '0903458888', '0903458888', '', NULL, 1, 1449457754),
(783, 'LIOA', 'AHAHAE', '', 'AGG', '', 1, 1449457930),
(784, 'Vinalon', '08.3731.2414', '08.3731.2414', 'maihanh1216@gmail.com', '', 1, 1449459984),
(785, 'Kho đồ chơi Sóng Mới', '046402372', '046402372', '', '', 1, 1449463823),
(786, 'BÙI NGỌC CƯỜNG', '0986552211', '0986552211', '', NULL, 1, 1449470787),
(787, 'SEEBABY', 'AGAG', '', 'AGAGFFF', '', 1, 1449470861),
(788, 'IQTOY', 'AGA', '', 'AGEAGAGA', '', 1, 1449470879),
(789, 'LIVAX', '0462573215', '0462573215', '', '', 1, 1449477918),
(790, 'JANGIN', '6544654353', '', 'ádassadada', '', 1, 1449482277),
(791, 'FarmaCell', '08. 3984 3646', '08. 3984 3646', 'hunghyco@gmail.com', '', 1, 1449558436),
(792, 'CÔNG TY CỔ PHẦN THIẾT BỊ BÁCH KHOA', '0916979903', '0916979903', 'huynq@bkc.vn', NULL, 1, 1449563628),
(793, 'Bach Khoa Computer', '0916 979 903', '', 'homeshopping@gmail.com', '', 1, 1449563768),
(794, 'Tupperware Việt Nam', 'điền sau', 'điền sau', 'điền sau', '', 1, 1449669443),
(795, 'Beurer Việt Nam', '04.35773151', '04.35773151', 'info@thietbiyte-eu.vn', '', 1, 1449713038),
(796, 'Grow''n Up', '0917172188', '', 'hoanglinh@dochoihanoi.vn', '', 1, 1449723559),
(797, 'Công ty TNHH IDO Việt Nam', '0988070908', '0988070908', 'phuong@ido.com.vn', NULL, 1, 1449727529),
(798, 'T.LONG', '08. 6264 4646', '08. 6264 4646', 'ly.thanhlongcoltd@gmail.com', '', 1, 1449737336),
(799, 'AN SINH', '04-35377123', '04-35377123', '', '', 1, 1449739058),
(800, 'FOREVER', '08 6673 1460', '08 6673 1460', 'chuong@mucimax.com', 'http://forever-k.com.vn/', 1, 1449765067),
(801, 'Công ty CP Tư vấn thiết kế và xây dựng V-Home', '04.62541919', '04.62541919', '', NULL, 1, 1449806464),
(802, 'V-Home', '0965197222', '', 'noithatvhome@gmail.com', '', 1, 1449806643),
(803, 'Công Ty TNHH Sản Phẩm Trẻ Em Chí Việt', '08. 6653 4524', '08. 6653 4524', '', NULL, 1, 1449816515),
(804, 'CÔNG TY TNHH IQTOYS VIỆT NAM', '0938150880', '0938150880', '', NULL, 1, 1449825721),
(805, 'IQTOYS', 'ẦGAGGGG', '', 'AGAGGGGG', '', 1, 1449825778),
(806, 'OSHITSU', '65411231323', '', 'rgtregergfrfg', '', 1, 1449889053),
(807, 'CÔNG TY CỔ PHẦN PHÁT TRIỂN THƯƠNG HIỆU HẠT GẠO QUỐ', '04625517777', '04625517777', '', NULL, 1, 1449890200),
(808, 'PISEN', 'AHGAG', '', 'AGEL', '', 1, 1449890248),
(809, 'HANSTAND', '(84.8) 3 7445409', '(84.8) 3 7445409', 'phuong.pham_sophia@ce.com.vn', 'http://www.ce.com.vn/', 1, 1449895704),
(810, 'CÔNG TY TNHH THƯƠNG MẠI ĐIỆN TỬ HÀ VY', '0944944139', '0944944139', 'havymobile@gmail.com', NULL, 1, 1450019451),
(811, 'Hà Vy Mobile', '094813333', '', 'thuanhn89@gmail.com', '', 1, 1450019717),
(812, 'CÔNG TY TNHH B-UNI HÀ NỘI', '043 8134 322', '043 8134 322', '', NULL, 1, 1450061610),
(813, 'Công ty Cổ phần Thiết bị Vật tư La Bàn', '08 38490953', '08 38490953', 'info@nkxlock.com', '', 1, 1450061674),
(814, 'OnGuard', '+84.(0)903919995', '', 'giangnguyen@nkxlock.com', '', 1, 1450062022),
(815, 'AUM', 'AGEHK', '', 'SGSG', '', 1, 1450062365),
(816, 'SCITECH', '04-37616222', '04-37616222', 'contact@scitech.com.vn', '', 1, 1450063246),
(817, 'CÔNG TY TNHH GIA DỤNG CAO CẤP VIỆT NHẬT', '04. 6273.0579', '04. 6273.0579', '', NULL, 1, 1450065068),
(818, 'TANAKA', 'YIUT', '', 'KFUKUK', '', 1, 1450065133),
(819, 'BRAVO', 'NGN', '', 'HSJ', '', 1, 1450065161),
(820, 'Tiross Việt Nam', '11111111111111111111', '', '111111111111111111111111111', '', 1, 1450066313),
(821, 'CÔNG TY CỔ PHẦN BẢO KHÁNH VIỆT NAM', '043.5161816', '043.5161816', '', NULL, 1, 1450075779),
(822, 'A.O.Smith', 'kfku', '', 'kkfk', '', 1, 1450075863),
(823, 'JAPAKO KOMAX', '0466830288', '0466830288', '', '', 1, 1450080955),
(824, 'GOWI', '08. 3964 1401', '08. 3964 1401', 'huong.l.tran@mbcare.com.vn', '', 1, 1450162310),
(825, 'ABLOY', '0903.821.839', '', 'giangnh@nkxlock.com', '', 1, 1450173233),
(826, 'Beurer', 'vvvvv', '', 'vvvv', '', 1, 1450231478),
(827, 'Nuk', '08. 3970 8925', '08. 3970 8925', '', '', 1, 1450235533),
(828, 'Công Ty TNHH Vạn Thiên Sa', '08 7515049', '08 7515049', '', '', 1, 1450327669),
(829, 'Edena', '0935191626', '', 'thanhnhon@edena.com.vn', '', 1, 1450327798),
(830, 'Eufood', '741', '', 'ewe', '', 1, 1450339812),
(831, 'CROWN SPACE', '043.9289259', '043.9289259', '', '', 1, 1450347340),
(832, 'Vita Fruits', 'trt', '', 'gftghfgh', '', 1, 1450413300),
(833, 'Rapoo', '11111111111111111111', '', '1111111111111111111111111111111111111', '', 1, 1450422413),
(834, 'IEA', '0945637799', '0945637799', 'quanghai.iea@gmail.com', 'www.iea.com.vn', 1, 1450515728),
(835, 'MODULO HOME', '(84) 8. 66 83 97 50', '(84) 8. 66 83 97 50', 'nam.bui@bnfurniture.net', 'http://www.modulohome.com/', 1, 1450521624),
(836, 'Microlab', 'vsvsa', '', 'aaasa', '', 1, 1450678651),
(837, 'Phụ kiện Samsung', '01233896666', '01233896666', 'sale@itvn.vn', '', 1, 1450683386),
(838, 'Syn Style', '0945385050 - 0943935', '0945385050 - 0943935', '', '', 1, 1450687965),
(839, 'Bébé Cadum', '0907036254', '', 'huongtt@hnfgroup.com.vn', '', 1, 1450693397),
(840, 'CÔNG TY TNHH DỊCH VỤ PHÁT TRIỂN Á CHÂU', '08 3601 6018', '08 3601 6018', '', NULL, 1, 1450751518),
(841, 'IQTOYS', 'LIUGM', '', 'KKED', '', 1, 1450751554),
(842, 'Diamond', '123456789', '', 'hoa9@gmail.com', '', 1, 1450760181),
(843, 'Công ty TNHH Lan Anh', '0987456295', '0987456295', 'phuongquyen92@gmail.com', '', 1, 1450771400),
(844, 'Công ty Cổ phần Saiko Việt Nam', '04.37321795', '04.37321795', 'dohongquyen79@gmail.com', NULL, 1, 1450838728),
(845, 'Yison', '0985575850', '', 'miptt@thanhmy.com.vn', '', 1, 1450855272),
(846, 'Yoshikawa', '6565656565', '', '56565656565', '', 1, 1450858239),
(847, 'GoodLife', '08. 3895 3356', '08. 3895 3356', 'dangxuanhinh@gmail.com', '', 1, 1450933227),
(848, 'ZEBRA', '08. 3834 6118', '08. 3834 6118', 'hang-inoxnt.com.vn', '', 1, 1450933940),
(849, 'CÔNG TY CỔ PHẦN DEBORAH', '043.783.1461', '043.783.1461', 'info@deborah.vn', NULL, 1, 1450944051),
(850, 'Bosi', 'acc', '', 'avc', '', 1, 1451008907),
(851, 'GLASSLOCK', '04 3785 1555', '04 3785 1555', '', '', 1, 1451026785),
(852, 'Công ty TNHH Thương mại và Hữu Nghị Lê Gia', '0936 433 503', '0936 433 503', 'quanghanh259@gmail.com', NULL, 1, 1451045644),
(853, 'Soylove', 'vb', '', 'vb', '', 1, 1451046489),
(854, 'Tefal', 'qưqưqưq', '', 'qưqq', '', 1, 1451047775),
(855, 'Braun Việt Nam', 'ccccc', '', 'cccc', '', 1, 1451051133),
(856, 'PEACE WORLD', '(08)39846010', '(08)39846010', 'beptietkiem@gmail.com', 'www.peaceworld.com.vn', 1, 1451109647),
(857, 'LAVAR', '08 3601 9799', '08 3601 9799', 'pei.finance@gmail.com', 'http://pei.vn', 1, 1451110677),
(858, 'Braun', '11111111', '', 'abcxyz', '', 1, 1451442183),
(859, 'Severin', '22222222', '', 'zxcvbnm', '', 1, 1451442254),
(860, 'CÔNG TY TNHH MTV NHIỆM MẦU', '(08) 399 399 19', '(08) 399 399 19', 'info@miraclediamond.vn', NULL, 1, 1451449726),
(861, 'CÔNG TY CỔ PHẦN THIẾT BỊ KỸ THUẬT VÀ ĐỒ CHƠI AN TO', '84 0996959079', '84 0996959079', '', NULL, 1, 1451530132),
(862, 'ANTONA', 'MUR6', '', 'JYDEJ', '', 1, 1451530539),
(863, 'Woody', '08 3727 3730', '08 3727 3730', 'info@happytimevn.com', '', 1, 1451536979),
(864, 'CÔNG TY TNHH MẬT ONG MANUKA ANZ', '08 3559 4415', '08 3559 4415', '', NULL, 1, 1451806971),
(865, 'Công ty cổ phần phát triển Ong miền núi', '043.5651749', '043.5651749', '', NULL, 1, 1451807462),
(866, 'CÔNG TY CỔ PHẦN SAGASO', '0839401368', '0839401368', '', NULL, 1, 1451808165),
(867, 'Khang Nhung Mobile', '0975700899', '0975700899', '', '', 1, 1451835954),
(868, 'CÔNG TY CP THIẾT BỊ CHĂM SÓC SỨC KHỎE SỐ 1', '7341210', '7341210', '', NULL, 1, 1451880103),
(869, 'THỦY TINH NGỌC', 'UIO', '', 'TÊNR', '', 1, 1451883842),
(870, 'La Fonte', 'ácv', '', 'acvbn', '', 1, 1451975590),
(871, 'Rachael Ray', 'zxcccccccc', '', 'vvvvvvvvvvvxxxxx', '', 1, 1451979827),
(872, 'Indochina Sài Gòn', 'hjhjhjhjhj', '', 'hjhjhjhj', '', 1, 1451982866),
(873, 'ĐỒ CHƠI TRẺ EM AND', '0942003286', '0942003286', '', NULL, 1, 1452072948),
(874, 'Công ty CP KD TM &amp; DV Thuận Hưng', 'sdfsfsd', '', 'fsdfsdf', '', 1, 1452102310),
(875, 'Công ty TNHH SAKI', '04-38684459', '04-38684459', 'info@saki.net.vn', NULL, 1, 1452135938),
(876, 'PTA', 'KIK', '', 'JYRJ', '', 1, 1452137335),
(877, 'Saki', 'hk', '', 'hk', '', 1, 1452137782),
(878, 'TOMMEE TIPPEE', '123456', '', '456789', '', 1, 1452153211),
(879, 'Công Ty TNHH Dệt May Phương Đông', '08. 3762 2249 - 08. ', '08. 3762 2249 - 08. ', '', NULL, 1, 1452222771),
(880, 'willendrof', '(08) 3758 0239', '(08) 3758 0239', '', '', 1, 1452237977),
(881, 'Kangaroo', '0436281699', '0436281699', 'nguyenngoctu@kangaroo.vn', '', 1, 1452272056),
(882, 'Hộ kinh doanh Nguyễn Tuấn Anh', '0932252286 - 0968585', '0932252286 - 0968585', '', NULL, 1, 1452439960),
(883, 'New Life', '08. 6298 9577', '08. 6298 9577', 'newlifetphcm@gmail.com', '', 1, 1452479571),
(884, 'RELAXSAN', '1456768', '', '55477798', '', 1, 1452481730),
(885, 'BeneCheck', '987564', '', '12358', '', 1, 1452481955),
(886, 'VUPIESSE', '14566', '', 'vhj', '', 1, 1452482240),
(887, 'Công ty TNHH lông vũ Anh và Em', '04 62816115', '04 62816115', '', NULL, 1, 1452484545),
(888, 'Peace’s BY HVTB', '08. 3839 05904', '08. 3839 05904', 'thaibinhhoangvu@gmail.com', '', 1, 1452485479),
(889, 'Auldey', '789523', '', '15879', '', 1, 1452501150),
(890, 'Công ty TNHH PBH Việt Nam', '04.6259.8614', '04.6259.8614', 'pbhoutdoor@gmail.com', NULL, 1, 1452734310),
(891, 'Công ty TNHH Thể thao Đức Trung', '043.935.0506', '043.935.0506', 'trungnd@dtgroup.vn', NULL, 1, 1452737490),
(892, 'Tiko', '08. 3923 9229', '08. 3923 9229', '', '', 1, 1452738770),
(893, 'Sport1', 'yu', '', 'yu', '', 1, 1452749733),
(894, 'HASA Fashion', '0437164399', '0437164399', '', '', 1, 1452759359);

-- --------------------------------------------------------

--
-- Table structure for table `web_support_online`
--

CREATE TABLE IF NOT EXISTS `web_support_online` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores support online content.' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `web_support_online`
--

INSERT INTO `web_support_online` (`id`, `uid`, `catid`, `title`, `title_alias`, `yahoo`, `skyper`, `phone`, `mobile`, `email`, `created`, `order_no`, `img`, `status`) VALUES
(1, 1, NULL, 'Nguyen Duy', NULL, 'pt.soleil', 'nguyenduypt86', NULL, '0913922986', 'nguyenduypt86@gmail.com', '1459144973', 1, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `web_user_shop`
--

CREATE TABLE IF NOT EXISTS `web_user_shop` (
  `shop_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(250) DEFAULT NULL COMMENT 'Tên shop, cửa hàng hiển thị',
  `user_shop` varchar(100) DEFAULT NULL COMMENT 'Tên dăng nhập của shop',
  `user_password` varchar(100) DEFAULT NULL,
  `shop_phone` varchar(255) DEFAULT NULL,
  `shop_address` varchar(255) DEFAULT NULL,
  `shop_email` varchar(100) DEFAULT NULL,
  `shop_province` int(10) DEFAULT NULL COMMENT 'tinh thanh',
  `shop_category` int(11) DEFAULT '0' COMMENT 'Danh mục của shop đang sửa dụng',
  `shop_category_name` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `web_user_shop`
--

INSERT INTO `web_user_shop` (`shop_id`, `shop_name`, `user_shop`, `user_password`, `shop_phone`, `shop_address`, `shop_email`, `shop_province`, `shop_category`, `shop_category_name`, `shop_about`, `shop_transfer`, `number_limit_product`, `is_shop`, `is_login`, `time_access`, `shop_status`, `shop_created`, `time_start_vip`, `time_end_vip`) VALUES
(4, 'Shop Teen', 'nguyenduy', '$S$DaBjYpXX5iV926/deKctbCPOUdJtIp4oH.sSMY2Z5WWnjxAIFoUk', '0913922986', '', 'nguyenduypt86@gmail.com', 22, 43, 'Điện tử công nghệ', '', '', 12, 0, 1, 1461656013, 1, 1458564097, NULL, NULL),
(5, 'Shop quần áo đẹp', 'shop_manhquynh', '$S$Dh3CQmErCXbk6oSlZsdNth5QdwuhdmBaPCwyPIOcVmCW2g3DnXJp', '0938413368', 'Việt Hưng - Long Biên Hà Nội', 'manhquynh1984@gmail.com', 22, 41, '', '<p>giới thiệu chung của shop quỳnh</p>\r\n', '<p>Ch&iacute;nh s&aacute;ch giao nhận của shop quỳnh</p>\r\n', 12, 0, 1, 1461293556, 1, 1459258585, NULL, NULL),
(6, 'Hàng xách tay', 'hangxachtay', '$S$DU4eUbAi0fiqcF5OzH8IrlPN8b3XifgA7wi2wBS6efzFtxZ4a003', '0904 999 801 Zalo/Viber/Imsg', 'Ki ốt 6 Ngõ 49 Phố Đức Giang Long Biên Hà Nội', 'fullmoon2384@gmail.com', 22, 164, 'Mỹ phẩm - làm đẹp', '<p>TO&Agrave;N BỘ H&Agrave;NG X&Aacute;CH TAY V&Agrave; ORD TỪ MỸ, &Uacute;C, NHẬT, ANH, ĐỨC, H&Agrave;N, NGA....DO NGƯỜI NH&Agrave; M&Igrave;NH MANG VỀ NH&Eacute; H&Agrave;NG CHUẨN 100% . KH&Aacute;CH C&Oacute; THỂ KIỂM TRA THOẢI M&Aacute;I LU&Ocirc;N Ạ.<br />\r\nH&Agrave;NG C&Oacute; SẴN TẠI: KI ỐT SỐ 6 NG&Otilde; 49 PHỐ ĐỨC GIANG,Q. LONG BI&Ecirc;N, TP. H&Agrave; NỘI.</p>\r\n\r\n<p>&nbsp;</p>\r\n', '<p><em>☎</em>&nbsp;L/H: QUA FB/ZALO/SDT:&nbsp;<strong>0904 999 801/0934401588</strong></p>\r\n\r\n<p><em>✈</em>&nbsp;SHIP TO&Agrave;N QUỐC, C&Oacute; SHIP CODE.</p>\r\n\r\n<p>H&Agrave;NG ORDER KH&Aacute;CH H&Agrave;NG VUI L&Ograve;NG CHUYỂN KHOẢN TRƯỚC 70% GI&Aacute; TRỊ SẢN PHẨM.</p>\r\n\r\n<p>STK :&nbsp;<strong>0541001532101 NGUYỄN THỊ NGUYỆT</strong>&nbsp;(Vietcombank chi nh&aacute;nh Chương Dương )</p>\r\n', 1000, 2, 0, 1461581400, 1, 1461230733, NULL, NULL),
(7, 'Shop thời trang online ', 'shop_hathanh', '$S$D/medc1p5j90.sVhwgK42teM4AZisRT7z3Z9/0Yy0zhF9NQiobNL', '0943722595', 'Sài Đồng- Long Biên - Hà nội', 'nguyenthuha611983@gmail.com', 22, 164, 'Làm đẹp &amp; Sức khỏe', '<p>Giới thiệu chung của shop</p>\r\n', '<p>Ch&iacute;nh s&aacute;ch giao nhận của shop</p>\r\n', 100, 2, 0, 1461293534, 1, 1461293012, NULL, NULL),
(8, 'Mum chip''s shop', 'mumchipshop', '$S$DUhbj.pEhbrU8IJ1hR1w4/26va2NimF3lGVDYYfUywi5NLftS0lj', '0919866826', 'P801, tầng 8, 47 lê văn hưu, hai bà trưng', 'lecuc144@gmail.com', 22, 97, 'Thời trang nữ', '<p>Giới thiệu của shop</p>\r\n', '<p>Ch&iacute;nh s&aacute;ch vận chuyển, giao h&agrave;ng của shop</p>\r\n', 100, 2, 0, 0, 1, 1461427074, NULL, NULL),
(9, 'Quốc Đạt SmartPhone', 'hoantrang9', '$S$D1Lrx.6xdPFE5gxI5usd8dJOKuhHSR24rdT1pT3d.MPKMsKnOcrl', '0961087345', 'Số 173 - Ngã 4 TT Cao Thượng - Tân Yên- Bắc Giang', 'truongxuanhoan3790@gmail.com', 5, 43, 'Điện tử công nghệ', '<p><strong>Đi&ecirc;̣n thoại chính hãng </strong>. Cam k&ecirc;́t giá t&ocirc;́t nh&acirc;́t thị trường !</p>\r\n', '<p><strong>Chuy&ecirc;̉n phát nhanh - Thu&acirc;̣n ti&ecirc;̣n - Nhanh chóng - Uy tín</strong></p>\r\n', 20, 2, 0, 0, 1, 1461474395, NULL, NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
