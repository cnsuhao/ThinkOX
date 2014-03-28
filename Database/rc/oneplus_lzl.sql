-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2014 年 03 月 17 日 09:02
-- 服务器版本: 5.5.24-log
-- PHP 版本: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `oneplus`
--

-- --------------------------------------------------------

--
-- 表的结构 `onethink_forum_lzl_reply`
--

CREATE TABLE IF NOT EXISTS `onethink_forum_lzl_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `to_f_reply_id` int(11) NOT NULL,
  `to_reply_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `uid` int(11) NOT NULL,
  `to_uid` int(11) NOT NULL,
  `ctime` int(11) NOT NULL,
  `is_del` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=54 ;

--
-- 转存表中的数据 `onethink_forum_lzl_reply`
--

INSERT INTO `onethink_forum_lzl_reply` (`id`, `post_id`, `to_f_reply_id`, `to_reply_id`, `content`, `uid`, `to_uid`, `ctime`, `is_del`) VALUES
(1, 6, 1, 0, '斯蒂芬森的是', 25, 0, 0, 0),
(2, 6, 1, 0, 'dfresdg', 25, 0, 0, 0),
(3, 6, 2, 0, '阿萨德第三方的身份', 25, 0, 0, 0),
(4, 6, 2, 0, '斯蒂芬森持续督导萨芬', 25, 0, 0, 0),
(5, 6, 1, 0, '的分开了的烦恼和旅客发送到 弗兰克公里的分开地方', 25, 0, 0, 0),
(6, 6, 1, 0, '羡慕的报告i的吧的呢herb然后呢', 1, 0, 0, 0),
(7, 6, 1, 1, '送达方式大夫撒旦成功', 25, 0, 0, 0),
(8, 6, 1, 1, '还将扩大发挥郭富城飞过海', 25, 0, 0, 0),
(9, 6, 1, 1, '但是否感到十分', 2, 25, 0, 0),
(10, 6, 1, 5, '回复@xjt ：aa', 25, 25, 1395027622, 0),
(48, 6, 1, 0, 'sssss', 25, 0, 1395036237, 0),
(47, 6, 1, 5, '回复@xjt ：aaaa', 25, 25, 1395036197, 0),
(46, 6, 1, 0, '多对多', 25, 0, 1395035599, 0),
(45, 6, 1, 5, '回复@xjt ：ssx', 25, 25, 1395035469, 0),
(44, 6, 1, 5, '回复@xjt ：ddd', 25, 25, 1395035456, 0),
(43, 6, 2, 0, 'cccc', 25, 0, 1395035443, 0),
(18, 6, 1, 1, '回复@xjt ：xsfsd', 25, 25, 1395027883, 0),
(42, 6, 2, 0, 'zzz', 25, 0, 1395035420, 0),
(41, 6, 1, 0, 'ddd', 25, 0, 1395035385, 0),
(40, 6, 1, 0, 'vbcv', 25, 0, 1395035340, 0),
(39, 6, 1, 0, 'dddd', 25, 0, 1395035334, 0),
(38, 6, 1, 0, 'ssss', 25, 0, 1395035298, 0),
(37, 6, 1, 0, 'ffff', 25, 0, 1395035115, 0),
(34, 6, 2, 4, '回复@xjt ：fff', 25, 25, 1395034085, 0),
(35, 6, 2, 0, 'ddd', 25, 0, 1395034209, 0),
(36, 6, 2, 34, '回复@xjt ：eeee', 25, 25, 1395034533, 0),
(49, 6, 1, 2, '回复@xjt ：aaaaa', 25, 25, 1395036349, 0),
(50, 6, 1, 2, '回复@xjt ：fff', 25, 25, 1395036369, 0),
(51, 6, 1, 2, '回复@xjt ：fff', 25, 25, 1395036401, 0),
(52, 6, 2, 34, '回复@xjt ：dfs', 25, 25, 1395036435, 0),
(53, 6, 2, 0, 'gf', 25, 0, 1395036776, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
