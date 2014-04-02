-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2014 年 03 月 21 日 01:16
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
-- 表的结构 `onethink_user_cdata`
--

CREATE TABLE IF NOT EXISTS `onethink_user_cdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` text,
  `mtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- 转存表中的数据 `onethink_user_cdata`
--

INSERT INTO `onethink_user_cdata` (`id`, `uid`, `key`, `value`, `mtime`) VALUES
(1, 1, 'check_connum', '1', '2014-03-20 02:04:47'),
(2, 1, 'check_totalnum', '2', '2014-03-20 02:04:47'),
(3, 28, 'check_connum', '1', '2014-03-20 03:00:31'),
(4, 28, 'check_totalnum', '2', '2014-03-20 03:00:31'),
(5, 36, 'check_connum', '1', '2014-03-20 12:48:15'),
(6, 36, 'check_totalnum', '1', '2014-03-20 12:48:15'),
(7, 62, 'check_connum', '1', '2014-03-20 12:52:36'),
(8, 62, 'check_totalnum', '1', '2014-03-20 12:52:36'),
(9, 63, 'check_connum', '1', '2014-03-20 12:55:21'),
(10, 63, 'check_totalnum', '1', '2014-03-20 12:55:21'),
(11, 37, 'check_connum', '1', '2014-03-21 00:51:29'),
(12, 37, 'check_totalnum', '1', '2014-03-21 00:51:29'),
(13, 29, 'check_connum', '2', '2014-03-21 01:04:42'),
(14, 29, 'check_totalnum', '2', '2014-03-21 01:04:42'),
(15, 30, 'check_connum', '2', '2014-03-21 01:05:22'),
(16, 30, 'check_totalnum', '2', '2014-03-21 01:05:22'),
(17, 31, 'check_connum', '2', '2014-03-21 01:07:44'),
(18, 31, 'check_totalnum', '2', '2014-03-21 01:07:44'),
(19, 40, 'check_connum', '1', '2014-03-21 01:09:53'),
(20, 40, 'check_totalnum', '1', '2014-03-21 01:09:53'),
(21, 38, 'check_connum', '1', '2014-03-21 01:12:24'),
(22, 38, 'check_totalnum', '1', '2014-03-21 01:12:24');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
