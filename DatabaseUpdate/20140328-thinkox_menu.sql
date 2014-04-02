-- phpMyAdmin SQL Dump
-- version 4.1.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 28, 2014 at 08:14 AM
-- Server version: 5.5.33
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tox`
--

-- --------------------------------------------------------

--
-- Table structure for table `thinkox_menu`
--

CREATE TABLE IF NOT EXISTS `thinkox_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=147 ;

--
-- Dumping data for table `thinkox_menu`
--

REPLACE INTO `thinkox_menu` (`id`, `title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`) VALUES
(122, '讨论区', 0, 7, 'Forum/index', 0, '', '', 0),
(123, '微博', 0, 8, 'Weibo/weibo', 0, '', '', 0),
(124, '板块管理', 122, 1, 'Forum/forum', 0, '', '板块', 0),
(125, '帖子管理', 122, 3, 'Forum/post', 0, '', '帖子', 0),
(126, '编辑／发表帖子', 124, 0, 'Forum/editForum', 0, '', '', 0),
(127, 'edit pots', 125, 0, 'Forum/editPost', 0, '', '', 0),
(128, '排序', 124, 0, 'Forum/sortForum', 0, '', '', 0),
(129, 'SEO', 0, 9, 'SEO/index', 0, '', '', 0),
(130, '新增、编辑', 132, 0, 'SEO/editRule', 0, '', '', 0),
(131, '排序', 132, 0, 'SEO/sortRule', 0, '', '', 0),
(132, '规则管理', 129, 0, 'SEO/index', 0, '', '规则', 0),
(133, '回复管理', 122, 5, '/Admin/Forum/reply', 0, '', '回复', 0),
(134, '新增 编辑', 133, 0, 'Forum/editReply', 0, '', '', 0),
(140, '编辑回复', 138, 0, 'Weibo/editComment', 0, '', '', 0),
(139, '编辑微博', 137, 0, 'Weibo/editWeibo', 0, '', '', 0),
(137, '微博管理', 123, 1, 'Weibo/weibo', 0, '', '微博', 0),
(138, '回复管理', 123, 3, 'Weibo/comment', 0, '', '回复', 0),
(141, '板块回收站', 122, 2, 'Forum/forumTrash', 0, '', '板块', 0),
(142, '帖子回收站', 122, 4, 'Forum/postTrash', 0, '', '帖子', 0),
(143, '回复回收站', 122, 6, 'Forum/replyTrash', 0, '', '回复', 0),
(144, '微博回收站', 123, 2, 'Weibo/weiboTrash', 0, '', '微博', 0),
(145, '回复回收站', 123, 4, 'Weibo/commentTrash', 0, '', '回复', 0),
(146, '规则回收站', 129, 0, 'SEO/ruleTrash', 0, '', '规则', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
