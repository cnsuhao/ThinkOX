-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- 主机: 127.0.0.1
-- 生成日期: 2014 年 06 月 12 日 03:16
-- 服务器版本: 5.5.24-log
-- PHP 版本: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- 数据库: `rc6`
--

-- --------------------------------------------------------

--
-- 表的结构 `thinkox_field`
--

DROP TABLE IF EXISTS `thinkox_field`;
CREATE TABLE IF NOT EXISTS `thinkox_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `field_data` varchar(1000) NOT NULL,
  `createTime` int(11) NOT NULL,
  `changeTime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

-- --------------------------------------------------------

--
-- 表的结构 `thinkox_field_group`
--

DROP TABLE IF EXISTS `thinkox_field_group`;
CREATE TABLE IF NOT EXISTS `thinkox_field_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(25) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `createTime` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

--
-- 表的结构 `thinkox_field_setting`
--

DROP TABLE IF EXISTS `thinkox_field_setting`;
CREATE TABLE IF NOT EXISTS `thinkox_field_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(25) NOT NULL,
  `profile_group_id` int(11) NOT NULL,
  `visiable` tinyint(4) NOT NULL DEFAULT '1',
  `required` tinyint(4) NOT NULL DEFAULT '0',
  `sort` int(11) NOT NULL,
  `form_type` varchar(25) NOT NULL,
  `form_default_value` varchar(200) NOT NULL,
  `validation` varchar(25) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `createTime` int(11) NOT NULL,
  `child_form_type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=34 ;
