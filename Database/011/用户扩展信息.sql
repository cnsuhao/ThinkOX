--
-- 表的结构 `thinkox_field`
--

CREATE TABLE IF NOT EXISTS `thinkox_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `field_data` varchar(1000) NOT NULL,
  `createTime` int(11) NOT NULL,
  `changeTime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;

--
-- 表的结构 `thinkox_field_setting`
--

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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;


--
-- 表的结构 `thinkox_profile_group`
--

CREATE TABLE IF NOT EXISTS `thinkox_profile_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(25) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `createTime` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

ALTER TABLE  `thinkox_field_setting` ADD  `child_form_type` VARCHAR( 25 ) NOT NULL
--
-- 添加表中的数据 `thinkox_menu`
--

INSERT INTO `thinkox_menu` (`id`, `title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`) VALUES
(10000, '扩展资料', 16, 0, 'Admin/User/profile', 0, '', '用户管理', 0),
(10001, '添加、编辑分组', 10000, 0, 'Admin/User/editProfile', 0, '', '', 0),
(10002, '分组排序', 10000, 0, 'Admin/User/sortProfile', 0, '', '', 0),
(10003, '字段列表', 10000, 0, 'Admin/User/field', 0, '', '', 0),
(10004, '添加、编辑字段', 10003, 0, 'Admin/User/editFieldSetting', 0, '', '', 0),
(10005, '字段排序', 10003, 0, 'Admin/User/sortField', 0, '', '', 0);