-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- 主机: 127.0.0.1
-- 生成日期: 2014 年 03 月 13 日 13:05
-- 服务器版本: 5.5.24-log
-- PHP 版本: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- 数据库: `oneplus`
--

-- --------------------------------------------------------

--
-- 表的结构 `onethink_message`
--

CREATE TABLE IF NOT EXISTS `onethink_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_uid` int(11) NOT NULL,
  `to_uid` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '0系统消息,1用户消息,2应用消息',
  `is_read` tinyint(4) NOT NULL,
  `last_toast` int(11) NOT NULL,
  `url` varchar(400) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='OnePlus新增消息表' AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `onethink_message`
--

INSERT INTO `onethink_message` (`id`, `from_uid`, `to_uid`, `title`, `content`, `create_time`, `type`, `is_read`, `last_toast`, `url`) VALUES
(1, 2, 1, '您的微博有人评论了', '李小冉说，I付出款啊啊啊啊 <img src="a"/>', 1394447649, 1, 1, 1394715268, ''),
(2, 2, 1, '你的帖子有人回复了', '点对点', 1394447649, 1, 1, 1394714956, ''),
(3, 2, 1, '你的帖子有人回复了', '点对点', 1394447649, 1, 1, 0, ''),
(4, 2, 1, '你的帖子有人回复了', '点对点', 1394447649, 1, 1, 1394715486, ''),
(5, 2, 1, '你的帖子有人回复了', '点对点', 1394447649, 2, 1, 1394715515, ''),
(6, 2, 1, '你的帖子有人回复了', '点对点', 1394447649, 2, 0, 1394715628, '');
