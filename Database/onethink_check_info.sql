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
-- 表的结构 `onethink_check_info`
--

CREATE TABLE IF NOT EXISTS `onethink_check_info` (
  `uid` int(11) DEFAULT NULL,
  `con_num` int(11) DEFAULT '1',
  `total_num` int(11) DEFAULT '1',
  `ctime` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `onethink_check_info`
--

INSERT INTO `onethink_check_info` (`uid`, `con_num`, `total_num`, `ctime`) VALUES
(1, 1, 1, 1395238274),
(28, 1, 1, 1395238274),
(1, 1, 2, 1395281087),
(27, 1, 1, 1395301594),
(29, 1, 1, 1395302678),
(30, 1, 1, 1395308325),
(31, 1, 1, 1395308479),
(33, 1, 1, 1395308710),
(0, 1, 1, 1395319126),
(34, 1, 1, 1395319428),
(35, 1, 1, 1395319602),
(36, 1, 1, 1395319695),
(62, 1, 1, 1395319956),
(63, 1, 1, 1395320121),
(1, 2, 3, 1395362879),
(37, 1, 1, 1395363089),
(28, 1, 2, 1395363125),
(29, 2, 2, 1395363881),
(30, 2, 2, 1395363921),
(31, 2, 2, 1395364064),
(40, 1, 1, 1395364192),
(38, 1, 1, 1395364344),
(39, 1, 1, 1395364457),
(64, 1, 1, 1395364521);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
