-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- 主机: 127.0.0.1
-- 生成日期: 2014 年 03 月 14 日 02:14
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
  `type` tinyint(4) NOT NULL COMMENT ''0系统消息,1用户消息,2应用消息'',
  `is_read` tinyint(4) NOT NULL,
  `last_toast` int(11) NOT NULL,
  `url` varchar(400) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT=''OnePlus新增消息表'' AUTO_INCREMENT=37 ;

--
-- 转存表中的数据 `onethink_message`
--

INSERT INTO `onethink_message` (`id`, `from_uid`, `to_uid`, `title`, `content`, `create_time`, `type`, `is_read`, `last_toast`, `url`) VALUES
(36, 2, 2, ''yixiao2020回复了您的帖子。'', ''回复内容：eeee'', 1394762346, 2, 0, 1394762347, ''/OnePlus/index.php?s=/Forum/Index/detail/id/7.html''),
(35, 2, 2, ''yixiao2020回复了您的帖子。'', ''回复内容：323232'', 1394762341, 2, 0, 1394762342, ''/OnePlus/index.php?s=/Forum/Index/detail/id/7.html''),
(34, 2, 2, ''yixiao2020回复了您的帖子。'', ''回复内容：ddd'', 1394762268, 2, 0, 1394762268, ''/OnePlus/index.php?s=/Forum/Index/detail/id/7.html''),
(33, 2, 2, ''yixiao2020回复了您的帖子。'', ''回复内容：dd'', 1394762260, 2, 0, 1394762261, ''/OnePlus/index.php?s=/Forum/Index/detail/id/7.html''),
(32, 2, 2, ''yixiao2020回复了您的帖子。'', ''回复内容：ddd'', 1394762236, 2, 0, 1394762236, ''/OnePlus/index.php?s=/Forum/Index/detail/id/7.html''),
(31, 2, 2, ''yixiao2020回复了您的帖子。'', ''回复内容：dwawda'', 1394762231, 2, 0, 1394762231, ''/OnePlus/index.php?s=/Forum/Index/detail/id/7.html''),
(30, 2, 2, ''yixiao2020回复了您的帖子。'', ''回复内容：awdwad'', 1394762222, 2, 0, 1394762223, ''/OnePlus/index.php?s=/Forum/Index/detail/id/7.html''),
(29, 2, 1, ''yixiao2020评论了您的微博。'', ''评论内容：dwadwad'', 1394761164, 2, 0, 1394761168, ''/OnePlus/index.php?s=/Weibo/Index/index.html''),
(28, 2, 1, ''yixiao2020评论了您的微博。'', ''评论内容：cz'', 1394761158, 2, 0, 1394761158, ''/OnePlus/index.php?s=/Weibo/Index/index.html''),
(27, 2, 1, ''yixiao2020回复了您的帖子。'', ''回复内容：dwadaw'', 1394761131, 2, 0, 1394761132, ''/OnePlus/index.php?s=/Forum/Index/detail/id/5.html''),
(26, 1, 1, ''admin回复了您的帖子。'', ''回复内容：大娃娃的'', 1394760991, 2, 0, 1394760991, ''/OnePlus/index.php?s=/Forum/Index/detail/id/5.html'');
