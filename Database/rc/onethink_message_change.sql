/*调整消息的应用名称和类型*/


ALTER TABLE  `onethink_message` ADD  `appname` VARCHAR( 30 ) NOT NULL;
ALTER TABLE  `onethink_message` ADD  `apptype` VARCHAR( 30 ) NOT NULL;
ALTER TABLE  `onethink_message` ADD  `source_id` INT NOT NULL;
ALTER TABLE  `onethink_message` ADD  `find_id` INT NOT NULL;
ALTER TABLE  `onethink_message` ADD  `talk_id` INT NOT NULL;
ALTER TABLE  `onethink_message` ADD  `status` TINYINT NOT NULL;

-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- 主机: 127.0.0.1
-- 生成日期: 2014 年 03 月 19 日 13:39
-- 服务器版本: 5.5.24-log
-- PHP 版本: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- 数据库: `oneplus`
--

-- --------------------------------------------------------

--
-- 表的结构 `onethink_talk`
--

CREATE TABLE IF NOT EXISTS `onethink_talk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(11) NOT NULL,
  `uids` varchar(100) NOT NULL,
  `appname` varchar(30) NOT NULL,
  `apptype` varchar(30) NOT NULL,
  `source_id` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `source_title` varchar(100) NOT NULL,
  `source_content` text NOT NULL,
  `source_url` varchar(200) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `message_id` int(11) NOT NULL,
  `other_uid` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='会话表' AUTO_INCREMENT=22 ;

--
-- 转存表中的数据 `onethink_talk`
--


-- --------------------------------------------------------

--
-- 表的结构 `onethink_talk_message`
--

CREATE TABLE IF NOT EXISTS `onethink_talk_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) NOT NULL,
  `uid` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `talk_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='聊天消息表' AUTO_INCREMENT=101 ;

--
-- 转存表中的数据 `onethink_talk_message`
--

