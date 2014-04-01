-- -----------------------------
-- Think MySQL Data Transfer 
-- 
-- Host     : 127.0.0.1
-- Port     : 3306
-- Database : op
-- 
-- Part : #1
-- Date : 2014-03-14 10:20:44
-- -----------------------------

SET FOREIGN_KEY_CHECKS = 0;


-- -----------------------------
-- Table structure for `onethink_action`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_action`;
CREATE TABLE `onethink_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text NOT NULL COMMENT '行为规则',
  `log` text NOT NULL COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表';

-- -----------------------------
-- Records of `onethink_action`
-- -----------------------------
INSERT INTO `onethink_action` VALUES ('1', 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', '1', '1', '1387181220');
INSERT INTO `onethink_action` VALUES ('2', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '0', '1380173180');
INSERT INTO `onethink_action` VALUES ('3', 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '1', '1383285646');
INSERT INTO `onethink_action` VALUES ('4', 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', '2', '0', '1386139726');
INSERT INTO `onethink_action` VALUES ('5', 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '0', '1383285551');
INSERT INTO `onethink_action` VALUES ('6', 'update_config', '更新配置', '新增或修改或删除配置', '', '', '1', '1', '1383294988');
INSERT INTO `onethink_action` VALUES ('7', 'update_model', '更新模型', '新增或修改模型', '', '', '1', '1', '1383295057');
INSERT INTO `onethink_action` VALUES ('8', 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', '1', '1', '1383295963');
INSERT INTO `onethink_action` VALUES ('9', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', '1', '1', '1383296301');
INSERT INTO `onethink_action` VALUES ('10', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', '1', '1', '1383296392');
INSERT INTO `onethink_action` VALUES ('11', 'update_category', '更新分类', '新增或修改或删除分类', '', '', '1', '1', '1383296765');

-- -----------------------------
-- Table structure for `onethink_action_log`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_action_log`;
CREATE TABLE `onethink_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- -----------------------------
-- Records of `onethink_action_log`
-- -----------------------------
INSERT INTO `onethink_action_log` VALUES ('1', '1', '1', '0', 'member', '1', 'admin在2014-03-08 14:05登录了后台', '1', '1394258755');
INSERT INTO `onethink_action_log` VALUES ('2', '1', '1', '0', 'member', '1', 'admin在2014-03-08 14:33登录了后台', '1', '1394260432');
INSERT INTO `onethink_action_log` VALUES ('3', '1', '1', '0', 'member', '1', 'admin在2014-03-08 15:25登录了后台', '1', '1394263540');
INSERT INTO `onethink_action_log` VALUES ('4', '1', '1', '0', 'member', '1', 'admin在2014-03-10 17:56登录了后台', '1', '1394445367');
INSERT INTO `onethink_action_log` VALUES ('5', '1', '1', '0', 'member', '1', 'admin在2014-03-10 18:00登录了后台', '1', '1394445616');
INSERT INTO `onethink_action_log` VALUES ('6', '1', '1', '0', 'member', '1', 'admin在2014-03-10 18:00登录了后台', '1', '1394445653');
INSERT INTO `onethink_action_log` VALUES ('7', '1', '1', '0', 'member', '1', 'admin在2014-03-11 08:50登录了后台', '1', '1394499041');
INSERT INTO `onethink_action_log` VALUES ('8', '1', '1', '3232267009', 'member', '1', 'admin在2014-03-11 13:56登录了后台', '1', '1394517417');
INSERT INTO `onethink_action_log` VALUES ('9', '9', '1', '0', 'channel', '2', '操作url：/op/index.php?s=/Admin/Channel/edit.html', '1', '1394517445');
INSERT INTO `onethink_action_log` VALUES ('10', '1', '1', '3232267009', 'member', '1', 'admin在2014-03-11 13:57登录了后台', '1', '1394517448');
INSERT INTO `onethink_action_log` VALUES ('11', '9', '1', '0', 'channel', '2', '操作url：/op/index.php?s=/Admin/Channel/edit.html', '1', '1394517452');
INSERT INTO `onethink_action_log` VALUES ('12', '9', '1', '0', 'channel', '3', '操作url：/op/index.php?s=/Admin/Channel/edit.html', '1', '1394517463');
INSERT INTO `onethink_action_log` VALUES ('13', '9', '1', '0', 'channel', '2', '操作url：/op/index.php?s=/Admin/Channel/edit.html', '1', '1394517481');
INSERT INTO `onethink_action_log` VALUES ('14', '9', '1', '0', 'channel', '3', '操作url：/op/index.php?s=/Admin/Channel/edit.html', '1', '1394517490');
INSERT INTO `onethink_action_log` VALUES ('15', '1', '1', '3232267009', 'member', '1', 'admin在2014-03-11 14:44登录了后台', '1', '1394520289');
INSERT INTO `onethink_action_log` VALUES ('16', '10', '1', '0', 'Menu', '122', '操作url：/op/index.php?s=/Admin/Menu/add.html', '1', '1394528947');
INSERT INTO `onethink_action_log` VALUES ('17', '10', '1', '0', 'Menu', '123', '操作url：/op/index.php?s=/Admin/Menu/add.html', '1', '1394528980');
INSERT INTO `onethink_action_log` VALUES ('18', '10', '1', '0', 'Menu', '122', '操作url：/op/index.php?s=/Admin/Menu/edit.html', '1', '1394530843');
INSERT INTO `onethink_action_log` VALUES ('19', '10', '1', '0', 'Menu', '123', '操作url：/op/index.php?s=/Admin/Menu/edit.html', '1', '1394530853');
INSERT INTO `onethink_action_log` VALUES ('20', '1', '1', '0', 'member', '1', 'admin在2014-03-12 08:47登录了后台', '1', '1394585258');
INSERT INTO `onethink_action_log` VALUES ('21', '1', '1', '0', 'member', '1', 'admin在2014-03-12 08:47登录了后台', '1', '1394585265');
INSERT INTO `onethink_action_log` VALUES ('22', '1', '1', '0', 'member', '1', 'admin在2014-03-12 08:48登录了后台', '1', '1394585286');
INSERT INTO `onethink_action_log` VALUES ('23', '1', '1', '0', 'member', '1', 'admin在2014-03-12 08:48登录了后台', '1', '1394585304');
INSERT INTO `onethink_action_log` VALUES ('24', '1', '1', '0', 'member', '1', 'admin在2014-03-12 08:49登录了后台', '1', '1394585346');
INSERT INTO `onethink_action_log` VALUES ('25', '1', '1', '0', 'member', '1', 'admin在2014-03-12 08:50登录了后台', '1', '1394585400');
INSERT INTO `onethink_action_log` VALUES ('26', '1', '1', '0', 'member', '1', 'admin在2014-03-12 08:52登录了后台', '1', '1394585553');
INSERT INTO `onethink_action_log` VALUES ('27', '1', '1', '0', 'member', '1', 'admin在2014-03-12 08:52登录了后台', '1', '1394585575');
INSERT INTO `onethink_action_log` VALUES ('28', '1', '1', '0', 'member', '1', 'admin在2014-03-12 08:53登录了后台', '1', '1394585620');
INSERT INTO `onethink_action_log` VALUES ('29', '1', '1', '0', 'member', '1', 'admin在2014-03-12 08:54登录了后台', '1', '1394585687');
INSERT INTO `onethink_action_log` VALUES ('30', '1', '2', '3232267009', 'member', '2', 'yixiao2020在2014-03-12 09:03登录了后台', '1', '1394586237');
INSERT INTO `onethink_action_log` VALUES ('31', '1', '3', '0', 'member', '3', 'test在2014-03-12 09:06登录了后台', '1', '1394586414');
INSERT INTO `onethink_action_log` VALUES ('32', '1', '2', '3232267009', 'member', '2', 'yixiao2020在2014-03-12 09:10登录了后台', '1', '1394586642');
INSERT INTO `onethink_action_log` VALUES ('33', '9', '1', '0', 'channel', '1', '操作url：/op/index.php?s=/Admin/Channel/edit.html', '1', '1394586872');
INSERT INTO `onethink_action_log` VALUES ('34', '1', '1', '0', 'member', '1', 'admin在2014-03-12 11:11登录了后台', '1', '1394593890');
INSERT INTO `onethink_action_log` VALUES ('35', '1', '1', '0', 'member', '1', 'admin在2014-03-12 11:18登录了后台', '1', '1394594290');
INSERT INTO `onethink_action_log` VALUES ('36', '1', '2', '0', 'member', '2', 'yixiao2020在2014-03-12 12:47登录了后台', '1', '1394599654');
INSERT INTO `onethink_action_log` VALUES ('37', '1', '1', '0', 'member', '1', 'admin在2014-03-12 14:21登录了后台', '1', '1394605303');
INSERT INTO `onethink_action_log` VALUES ('38', '10', '1', '0', 'Menu', '124', '操作url：/op/index.php?s=/Admin/Menu/add.html', '1', '1394614960');
INSERT INTO `onethink_action_log` VALUES ('39', '10', '1', '0', 'Menu', '125', '操作url：/op/index.php?s=/Admin/Menu/add.html', '1', '1394614977');
INSERT INTO `onethink_action_log` VALUES ('40', '10', '1', '0', 'Menu', '126', '操作url：/op/index.php?s=/Admin/Menu/add.html', '1', '1394614993');
INSERT INTO `onethink_action_log` VALUES ('41', '10', '1', '0', 'Menu', '127', '操作url：/op/index.php?s=/Admin/Menu/add.html', '1', '1394615009');
INSERT INTO `onethink_action_log` VALUES ('42', '10', '1', '0', 'Menu', '126', '操作url：/op/index.php?s=/Admin/Menu/edit.html', '1', '1394615030');
INSERT INTO `onethink_action_log` VALUES ('43', '1', '1', '0', 'member', '1', 'admin在2014-03-13 12:48登录了后台', '1', '1394686082');
INSERT INTO `onethink_action_log` VALUES ('44', '1', '3', '0', 'member', '3', 'test在2014-03-13 13:03登录了后台', '1', '1394687038');
INSERT INTO `onethink_action_log` VALUES ('45', '1', '1', '0', 'member', '1', 'admin在2014-03-13 13:36登录了后台', '1', '1394688981');
INSERT INTO `onethink_action_log` VALUES ('46', '9', '1', '0', 'channel', '2', '操作url：/op/index.php?s=/Admin/Channel/edit.html', '1', '1394689097');
INSERT INTO `onethink_action_log` VALUES ('47', '9', '1', '0', 'channel', '3', '操作url：/op/index.php?s=/Admin/Channel/edit.html', '1', '1394689101');
INSERT INTO `onethink_action_log` VALUES ('48', '10', '1', '0', 'Menu', '126', '操作url：/op/index.php?s=/Admin/Menu/edit.html', '1', '1394689130');
INSERT INTO `onethink_action_log` VALUES ('49', '1', '3', '0', 'member', '3', 'test在2014-03-13 13:42登录了后台', '1', '1394689330');
INSERT INTO `onethink_action_log` VALUES ('50', '1', '1', '0', 'member', '1', 'admin在2014-03-13 13:42登录了后台', '1', '1394689345');
INSERT INTO `onethink_action_log` VALUES ('51', '9', '1', '0', 'channel', '2', '操作url：/op/index.php?s=/Admin/Channel/edit.html', '1', '1394692439');
INSERT INTO `onethink_action_log` VALUES ('52', '9', '1', '0', 'channel', '3', '操作url：/op/index.php?s=/Admin/Channel/edit.html', '1', '1394692449');
INSERT INTO `onethink_action_log` VALUES ('53', '1', '1', '0', 'member', '1', 'admin在2014-03-13 14:59登录了后台', '1', '1394693990');
INSERT INTO `onethink_action_log` VALUES ('54', '1', '3', '0', 'member', '3', 'test在2014-03-13 15:15登录了后台', '1', '1394694905');
INSERT INTO `onethink_action_log` VALUES ('55', '1', '1', '0', 'member', '1', 'admin在2014-03-13 15:15登录了后台', '1', '1394694926');
INSERT INTO `onethink_action_log` VALUES ('56', '1', '1', '0', 'member', '1', 'admin在2014-03-13 15:15登录了后台', '1', '1394694941');
INSERT INTO `onethink_action_log` VALUES ('57', '1', '3', '0', 'member', '3', 'test在2014-03-13 15:17登录了后台', '1', '1394695021');
INSERT INTO `onethink_action_log` VALUES ('58', '1', '1', '0', 'member', '1', 'admin在2014-03-13 15:17登录了后台', '1', '1394695049');
INSERT INTO `onethink_action_log` VALUES ('59', '1', '1', '0', 'member', '1', 'admin在2014-03-13 15:23登录了后台', '1', '1394695399');
INSERT INTO `onethink_action_log` VALUES ('60', '1', '1', '0', 'member', '1', 'admin在2014-03-13 16:17登录了后台', '1', '1394698644');
INSERT INTO `onethink_action_log` VALUES ('61', '10', '1', '0', 'Menu', '128', '操作url：/op/index.php?s=/Admin/Menu/add.html', '1', '1394701322');
INSERT INTO `onethink_action_log` VALUES ('62', '1', '3', '0', 'member', '3', 'test在2014-03-13 17:20登录了后台', '1', '1394702404');
INSERT INTO `onethink_action_log` VALUES ('63', '1', '1', '0', 'member', '1', 'admin在2014-03-13 17:22登录了后台', '1', '1394702538');
INSERT INTO `onethink_action_log` VALUES ('64', '1', '1', '0', 'member', '1', 'admin在2014-03-14 08:47登录了后台', '1', '1394758047');
INSERT INTO `onethink_action_log` VALUES ('65', '1', '3', '0', 'member', '3', 'test在2014-03-14 08:51登录了后台', '1', '1394758275');
INSERT INTO `onethink_action_log` VALUES ('66', '1', '14', '0', 'member', '14', '左手悲伤在2014-03-14 09:03登录了后台', '1', '1394759012');
INSERT INTO `onethink_action_log` VALUES ('67', '1', '1', '0', 'member', '1', 'admin在2014-03-14 09:32登录了后台', '1', '1394760767');

-- -----------------------------
-- Table structure for `onethink_addons`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_addons`;
CREATE TABLE `onethink_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- -----------------------------
-- Records of `onethink_addons`
-- -----------------------------
INSERT INTO `onethink_addons` VALUES ('15', 'EditorForAdmin', '后台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1383126253', '0');
INSERT INTO `onethink_addons` VALUES ('2', 'SiteStat', '站点统计信息', '统计站点的基础信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"1\",\"display\":\"1\",\"status\":\"0\"}', 'thinkphp', '0.1', '1379512015', '0');
INSERT INTO `onethink_addons` VALUES ('3', 'DevTeam', '开发团队信息', '开发团队成员信息', '1', '{\"title\":\"OneThink\\u5f00\\u53d1\\u56e2\\u961f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512022', '0');
INSERT INTO `onethink_addons` VALUES ('4', 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512036', '0');
INSERT INTO `onethink_addons` VALUES ('5', 'Editor', '前台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"300px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1379830910', '0');
INSERT INTO `onethink_addons` VALUES ('6', 'Attachment', '附件', '用于文档模型上传附件', '1', 'null', 'thinkphp', '0.1', '1379842319', '1');
INSERT INTO `onethink_addons` VALUES ('9', 'SocialComment', '通用社交化评论', '集成了各种社交化评论插件，轻松集成到系统中。', '1', '{\"comment_type\":\"1\",\"comment_uid_youyan\":\"\",\"comment_short_name_duoshuo\":\"\",\"comment_data_list_duoshuo\":\"\"}', 'thinkphp', '0.1', '1380273962', '0');
INSERT INTO `onethink_addons` VALUES ('16', 'Avatar', '头像插件', '用于头像的上传', '1', '{\"random\":\"1\"}', 'caipeichao', '0.1', '1394449710', '1');
INSERT INTO `onethink_addons` VALUES ('17', 'Tianyi', '天翼短信插件', '用于发送手机短信验证码、模板短信', '1', '{\"expire\":\"120\",\"clean_interval\":\"86400\",\"app_id\":\"668228660000034680\",\"app_secret\":\"75e30521444f11fb3ec265d3c809e443\",\"access_token\":\"2389ae5bb8c44603337203f9f4aacf171392971135771\",\"refresh_token\":\"0cbb07946822ca74c70f4288fc50dc531392971135772\",\"update_access_token_interval\":\"1728000\"}', 'caipeichao', '0.1', '1394519345', '0');

-- -----------------------------
-- Table structure for `onethink_attachment`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_attachment`;
CREATE TABLE `onethink_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';


-- -----------------------------
-- Table structure for `onethink_attribute`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_attribute`;
CREATE TABLE `onethink_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL,
  `validate_time` tinyint(1) unsigned NOT NULL,
  `error_info` varchar(100) NOT NULL,
  `validate_type` varchar(25) NOT NULL,
  `auto_rule` varchar(100) NOT NULL,
  `auto_time` tinyint(1) unsigned NOT NULL,
  `auto_type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

-- -----------------------------
-- Records of `onethink_attribute`
-- -----------------------------
INSERT INTO `onethink_attribute` VALUES ('1', 'uid', '用户ID', 'int(10) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1384508362', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('2', 'name', '标识', 'char(40) NOT NULL ', 'string', '', '同一根节点下标识不重复', '1', '', '1', '0', '1', '1383894743', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('3', 'title', '标题', 'char(80) NOT NULL ', 'string', '', '文档标题', '1', '', '1', '0', '1', '1383894778', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('4', 'category_id', '所属分类', 'int(10) unsigned NOT NULL ', 'string', '', '', '0', '', '1', '0', '1', '1384508336', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('5', 'description', '描述', 'char(140) NOT NULL ', 'textarea', '', '', '1', '', '1', '0', '1', '1383894927', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('6', 'root', '根节点', 'int(10) unsigned NOT NULL ', 'num', '0', '该文档的顶级文档编号', '0', '', '1', '0', '1', '1384508323', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('7', 'pid', '所属ID', 'int(10) unsigned NOT NULL ', 'num', '0', '父文档编号', '0', '', '1', '0', '1', '1384508543', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('8', 'model_id', '内容模型ID', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '该文档所对应的模型', '0', '', '1', '0', '1', '1384508350', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('9', 'type', '内容类型', 'tinyint(3) unsigned NOT NULL ', 'select', '2', '', '1', '1:目录\r\n2:主题\r\n3:段落', '1', '0', '1', '1384511157', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('10', 'position', '推荐位', 'smallint(5) unsigned NOT NULL ', 'checkbox', '0', '多个推荐则将其推荐值相加', '1', '1:列表推荐\r\n2:频道页推荐\r\n4:首页推荐', '1', '0', '1', '1383895640', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('11', 'link_id', '外链', 'int(10) unsigned NOT NULL ', 'num', '0', '0-非外链，大于0-外链ID,需要函数进行链接与编号的转换', '1', '', '1', '0', '1', '1383895757', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('12', 'cover_id', '封面', 'int(10) unsigned NOT NULL ', 'picture', '0', '0-无封面，大于0-封面图片ID，需要函数处理', '1', '', '1', '0', '1', '1384147827', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('13', 'display', '可见性', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', '1', '0:不可见\r\n1:所有人可见', '1', '0', '1', '1386662271', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('14', 'deadline', '截至时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '0-永久有效', '1', '', '1', '0', '1', '1387163248', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('15', 'attach', '附件数量', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1387260355', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('16', 'view', '浏览量', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895835', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('17', 'comment', '评论数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895846', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('18', 'extend', '扩展统计字段', 'int(10) unsigned NOT NULL ', 'num', '0', '根据需求自行使用', '0', '', '1', '0', '1', '1384508264', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('19', 'level', '优先级', 'int(10) unsigned NOT NULL ', 'num', '0', '越高排序越靠前', '1', '', '1', '0', '1', '1383895894', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('20', 'create_time', '创建时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '1', '', '1', '0', '1', '1383895903', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('21', 'update_time', '更新时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '0', '', '1', '0', '1', '1384508277', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('22', 'status', '数据状态', 'tinyint(4) NOT NULL ', 'radio', '0', '', '0', '-1:删除\r\n0:禁用\r\n1:正常\r\n2:待审核\r\n3:草稿', '1', '0', '1', '1384508496', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('23', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '2', '0', '1', '1384511049', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('24', 'content', '文章内容', 'text NOT NULL ', 'editor', '', '', '1', '', '2', '0', '1', '1383896225', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('25', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '参照display方法参数的定义', '1', '', '2', '0', '1', '1383896190', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('26', 'bookmark', '收藏数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '2', '0', '1', '1383896103', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('27', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '3', '0', '1', '1387260461', '1383891252', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `onethink_attribute` VALUES ('28', 'content', '下载详细描述', 'text NOT NULL ', 'editor', '', '', '1', '', '3', '0', '1', '1383896438', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('29', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '3', '0', '1', '1383896429', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('30', 'file_id', '文件ID', 'int(10) unsigned NOT NULL ', 'file', '0', '需要函数处理', '1', '', '3', '0', '1', '1383896415', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('31', 'download', '下载次数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '3', '0', '1', '1383896380', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `onethink_attribute` VALUES ('32', 'size', '文件大小', 'bigint(20) unsigned NOT NULL ', 'num', '0', '单位bit', '1', '', '3', '0', '1', '1383896371', '1383891252', '', '0', '', '', '', '0', '');

-- -----------------------------
-- Table structure for `onethink_auth_extend`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_auth_extend`;
CREATE TABLE `onethink_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- -----------------------------
-- Records of `onethink_auth_extend`
-- -----------------------------
INSERT INTO `onethink_auth_extend` VALUES ('1', '1', '1');
INSERT INTO `onethink_auth_extend` VALUES ('1', '1', '2');
INSERT INTO `onethink_auth_extend` VALUES ('1', '2', '1');
INSERT INTO `onethink_auth_extend` VALUES ('1', '2', '2');
INSERT INTO `onethink_auth_extend` VALUES ('1', '3', '1');
INSERT INTO `onethink_auth_extend` VALUES ('1', '3', '2');
INSERT INTO `onethink_auth_extend` VALUES ('1', '4', '1');
INSERT INTO `onethink_auth_extend` VALUES ('1', '37', '1');

-- -----------------------------
-- Table structure for `onethink_auth_group`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_auth_group`;
CREATE TABLE `onethink_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_auth_group`
-- -----------------------------
INSERT INTO `onethink_auth_group` VALUES ('1', 'admin', '1', '默认用户组', '', '1', '218,220');
INSERT INTO `onethink_auth_group` VALUES ('3', 'admin', '1', '产品发布', '', '1', '');
INSERT INTO `onethink_auth_group` VALUES ('2', 'admin', '1', '测试用户', '测试用户', '1', '1,2,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,82,83,84,88,89,90,91,92,93,96,97,100,102,103,195');

-- -----------------------------
-- Table structure for `onethink_auth_group_access`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_auth_group_access`;
CREATE TABLE `onethink_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_auth_group_access`
-- -----------------------------
INSERT INTO `onethink_auth_group_access` VALUES ('1', '1');
INSERT INTO `onethink_auth_group_access` VALUES ('1', '3');

-- -----------------------------
-- Table structure for `onethink_auth_rule`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_auth_rule`;
CREATE TABLE `onethink_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=223 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_auth_rule`
-- -----------------------------
INSERT INTO `onethink_auth_rule` VALUES ('1', 'admin', '2', 'Admin/Index/index', '首页', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('2', 'admin', '2', 'Admin/Article/mydocument', '内容', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('3', 'admin', '2', 'Admin/User/index', '用户', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('4', 'admin', '2', 'Admin/Addons/index', '扩展', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('5', 'admin', '2', 'Admin/Config/group', '系统', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('7', 'admin', '1', 'Admin/article/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('8', 'admin', '1', 'Admin/article/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('9', 'admin', '1', 'Admin/article/setStatus', '改变状态', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('10', 'admin', '1', 'Admin/article/update', '保存', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('11', 'admin', '1', 'Admin/article/autoSave', '保存草稿', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('12', 'admin', '1', 'Admin/article/move', '移动', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('13', 'admin', '1', 'Admin/article/copy', '复制', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('14', 'admin', '1', 'Admin/article/paste', '粘贴', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('15', 'admin', '1', 'Admin/article/permit', '还原', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('16', 'admin', '1', 'Admin/article/clear', '清空', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('17', 'admin', '1', 'Admin/article/index', '文档列表', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('18', 'admin', '1', 'Admin/article/recycle', '回收站', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('19', 'admin', '1', 'Admin/User/addaction', '新增用户行为', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('20', 'admin', '1', 'Admin/User/editaction', '编辑用户行为', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('21', 'admin', '1', 'Admin/User/saveAction', '保存用户行为', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('22', 'admin', '1', 'Admin/User/setStatus', '变更行为状态', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('23', 'admin', '1', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('24', 'admin', '1', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('25', 'admin', '1', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('26', 'admin', '1', 'Admin/User/index', '用户信息', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('27', 'admin', '1', 'Admin/User/action', '用户行为', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('28', 'admin', '1', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('29', 'admin', '1', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('30', 'admin', '1', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('31', 'admin', '1', 'Admin/AuthManager/createGroup', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('32', 'admin', '1', 'Admin/AuthManager/editGroup', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('33', 'admin', '1', 'Admin/AuthManager/writeGroup', '保存用户组', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('34', 'admin', '1', 'Admin/AuthManager/group', '授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('35', 'admin', '1', 'Admin/AuthManager/access', '访问授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('36', 'admin', '1', 'Admin/AuthManager/user', '成员授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('37', 'admin', '1', 'Admin/AuthManager/removeFromGroup', '解除授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('38', 'admin', '1', 'Admin/AuthManager/addToGroup', '保存成员授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('39', 'admin', '1', 'Admin/AuthManager/category', '分类授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('40', 'admin', '1', 'Admin/AuthManager/addToCategory', '保存分类授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('41', 'admin', '1', 'Admin/AuthManager/index', '权限管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('42', 'admin', '1', 'Admin/Addons/create', '创建', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('43', 'admin', '1', 'Admin/Addons/checkForm', '检测创建', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('44', 'admin', '1', 'Admin/Addons/preview', '预览', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('45', 'admin', '1', 'Admin/Addons/build', '快速生成插件', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('46', 'admin', '1', 'Admin/Addons/config', '设置', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('47', 'admin', '1', 'Admin/Addons/disable', '禁用', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('48', 'admin', '1', 'Admin/Addons/enable', '启用', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('49', 'admin', '1', 'Admin/Addons/install', '安装', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('50', 'admin', '1', 'Admin/Addons/uninstall', '卸载', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('51', 'admin', '1', 'Admin/Addons/saveconfig', '更新配置', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('52', 'admin', '1', 'Admin/Addons/adminList', '插件后台列表', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('53', 'admin', '1', 'Admin/Addons/execute', 'URL方式访问插件', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('54', 'admin', '1', 'Admin/Addons/index', '插件管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('55', 'admin', '1', 'Admin/Addons/hooks', '钩子管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('56', 'admin', '1', 'Admin/model/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('57', 'admin', '1', 'Admin/model/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('58', 'admin', '1', 'Admin/model/setStatus', '改变状态', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('59', 'admin', '1', 'Admin/model/update', '保存数据', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('60', 'admin', '1', 'Admin/Model/index', '模型管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('61', 'admin', '1', 'Admin/Config/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('62', 'admin', '1', 'Admin/Config/del', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('63', 'admin', '1', 'Admin/Config/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('64', 'admin', '1', 'Admin/Config/save', '保存', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('65', 'admin', '1', 'Admin/Config/group', '网站设置', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('66', 'admin', '1', 'Admin/Config/index', '配置管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('67', 'admin', '1', 'Admin/Channel/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('68', 'admin', '1', 'Admin/Channel/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('69', 'admin', '1', 'Admin/Channel/del', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('70', 'admin', '1', 'Admin/Channel/index', '导航管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('71', 'admin', '1', 'Admin/Category/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('72', 'admin', '1', 'Admin/Category/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('73', 'admin', '1', 'Admin/Category/remove', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('74', 'admin', '1', 'Admin/Category/index', '分类管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('75', 'admin', '1', 'Admin/file/upload', '上传控件', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('76', 'admin', '1', 'Admin/file/uploadPicture', '上传图片', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('77', 'admin', '1', 'Admin/file/download', '下载', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('94', 'admin', '1', 'Admin/AuthManager/modelauth', '模型授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('79', 'admin', '1', 'Admin/article/batchOperate', '导入', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('80', 'admin', '1', 'Admin/Database/index?type=export', '备份数据库', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('81', 'admin', '1', 'Admin/Database/index?type=import', '还原数据库', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('82', 'admin', '1', 'Admin/Database/export', '备份', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('83', 'admin', '1', 'Admin/Database/optimize', '优化表', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('84', 'admin', '1', 'Admin/Database/repair', '修复表', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('86', 'admin', '1', 'Admin/Database/import', '恢复', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('87', 'admin', '1', 'Admin/Database/del', '删除', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('88', 'admin', '1', 'Admin/User/add', '新增用户', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('89', 'admin', '1', 'Admin/Attribute/index', '属性管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('90', 'admin', '1', 'Admin/Attribute/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('91', 'admin', '1', 'Admin/Attribute/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('92', 'admin', '1', 'Admin/Attribute/setStatus', '改变状态', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('93', 'admin', '1', 'Admin/Attribute/update', '保存数据', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('95', 'admin', '1', 'Admin/AuthManager/addToModel', '保存模型授权', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('96', 'admin', '1', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('97', 'admin', '1', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('98', 'admin', '1', 'Admin/Config/menu', '后台菜单管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('99', 'admin', '1', 'Admin/Article/mydocument', '内容', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('100', 'admin', '1', 'Admin/Menu/index', '菜单管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('101', 'admin', '1', 'Admin/other', '其他', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('102', 'admin', '1', 'Admin/Menu/add', '新增', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('103', 'admin', '1', 'Admin/Menu/edit', '编辑', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('104', 'admin', '1', 'Admin/Think/lists?model=article', '文章管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('105', 'admin', '1', 'Admin/Think/lists?model=download', '下载管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('106', 'admin', '1', 'Admin/Think/lists?model=config', '配置管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('107', 'admin', '1', 'Admin/Action/actionlog', '行为日志', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('108', 'admin', '1', 'Admin/User/updatePassword', '修改密码', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('109', 'admin', '1', 'Admin/User/updateNickname', '修改昵称', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('110', 'admin', '1', 'Admin/action/edit', '查看行为日志', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('205', 'admin', '1', 'Admin/think/add', '新增数据', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('111', 'admin', '2', 'Admin/article/index', '文档列表', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('112', 'admin', '2', 'Admin/article/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('113', 'admin', '2', 'Admin/article/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('114', 'admin', '2', 'Admin/article/setStatus', '改变状态', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('115', 'admin', '2', 'Admin/article/update', '保存', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('116', 'admin', '2', 'Admin/article/autoSave', '保存草稿', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('117', 'admin', '2', 'Admin/article/move', '移动', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('118', 'admin', '2', 'Admin/article/copy', '复制', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('119', 'admin', '2', 'Admin/article/paste', '粘贴', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('120', 'admin', '2', 'Admin/article/batchOperate', '导入', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('121', 'admin', '2', 'Admin/article/recycle', '回收站', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('122', 'admin', '2', 'Admin/article/permit', '还原', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('123', 'admin', '2', 'Admin/article/clear', '清空', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('124', 'admin', '2', 'Admin/User/add', '新增用户', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('125', 'admin', '2', 'Admin/User/action', '用户行为', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('126', 'admin', '2', 'Admin/User/addAction', '新增用户行为', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('127', 'admin', '2', 'Admin/User/editAction', '编辑用户行为', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('128', 'admin', '2', 'Admin/User/saveAction', '保存用户行为', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('129', 'admin', '2', 'Admin/User/setStatus', '变更行为状态', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('130', 'admin', '2', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('131', 'admin', '2', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('132', 'admin', '2', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('133', 'admin', '2', 'Admin/AuthManager/index', '权限管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('134', 'admin', '2', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('135', 'admin', '2', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('136', 'admin', '2', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('137', 'admin', '2', 'Admin/AuthManager/createGroup', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('138', 'admin', '2', 'Admin/AuthManager/editGroup', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('139', 'admin', '2', 'Admin/AuthManager/writeGroup', '保存用户组', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('140', 'admin', '2', 'Admin/AuthManager/group', '授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('141', 'admin', '2', 'Admin/AuthManager/access', '访问授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('142', 'admin', '2', 'Admin/AuthManager/user', '成员授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('143', 'admin', '2', 'Admin/AuthManager/removeFromGroup', '解除授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('144', 'admin', '2', 'Admin/AuthManager/addToGroup', '保存成员授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('145', 'admin', '2', 'Admin/AuthManager/category', '分类授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('146', 'admin', '2', 'Admin/AuthManager/addToCategory', '保存分类授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('147', 'admin', '2', 'Admin/AuthManager/modelauth', '模型授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('148', 'admin', '2', 'Admin/AuthManager/addToModel', '保存模型授权', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('149', 'admin', '2', 'Admin/Addons/create', '创建', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('150', 'admin', '2', 'Admin/Addons/checkForm', '检测创建', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('151', 'admin', '2', 'Admin/Addons/preview', '预览', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('152', 'admin', '2', 'Admin/Addons/build', '快速生成插件', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('153', 'admin', '2', 'Admin/Addons/config', '设置', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('154', 'admin', '2', 'Admin/Addons/disable', '禁用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('155', 'admin', '2', 'Admin/Addons/enable', '启用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('156', 'admin', '2', 'Admin/Addons/install', '安装', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('157', 'admin', '2', 'Admin/Addons/uninstall', '卸载', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('158', 'admin', '2', 'Admin/Addons/saveconfig', '更新配置', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('159', 'admin', '2', 'Admin/Addons/adminList', '插件后台列表', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('160', 'admin', '2', 'Admin/Addons/execute', 'URL方式访问插件', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('161', 'admin', '2', 'Admin/Addons/hooks', '钩子管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('162', 'admin', '2', 'Admin/Model/index', '模型管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('163', 'admin', '2', 'Admin/model/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('164', 'admin', '2', 'Admin/model/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('165', 'admin', '2', 'Admin/model/setStatus', '改变状态', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('166', 'admin', '2', 'Admin/model/update', '保存数据', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('167', 'admin', '2', 'Admin/Attribute/index', '属性管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('168', 'admin', '2', 'Admin/Attribute/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('169', 'admin', '2', 'Admin/Attribute/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('170', 'admin', '2', 'Admin/Attribute/setStatus', '改变状态', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('171', 'admin', '2', 'Admin/Attribute/update', '保存数据', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('172', 'admin', '2', 'Admin/Config/index', '配置管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('173', 'admin', '2', 'Admin/Config/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('174', 'admin', '2', 'Admin/Config/del', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('175', 'admin', '2', 'Admin/Config/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('176', 'admin', '2', 'Admin/Config/save', '保存', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('177', 'admin', '2', 'Admin/Menu/index', '菜单管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('178', 'admin', '2', 'Admin/Channel/index', '导航管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('179', 'admin', '2', 'Admin/Channel/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('180', 'admin', '2', 'Admin/Channel/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('181', 'admin', '2', 'Admin/Channel/del', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('182', 'admin', '2', 'Admin/Category/index', '分类管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('183', 'admin', '2', 'Admin/Category/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('184', 'admin', '2', 'Admin/Category/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('185', 'admin', '2', 'Admin/Category/remove', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('186', 'admin', '2', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('187', 'admin', '2', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('188', 'admin', '2', 'Admin/Database/index?type=export', '备份数据库', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('189', 'admin', '2', 'Admin/Database/export', '备份', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('190', 'admin', '2', 'Admin/Database/optimize', '优化表', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('191', 'admin', '2', 'Admin/Database/repair', '修复表', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('192', 'admin', '2', 'Admin/Database/index?type=import', '还原数据库', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('193', 'admin', '2', 'Admin/Database/import', '恢复', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('194', 'admin', '2', 'Admin/Database/del', '删除', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('195', 'admin', '2', 'Admin/other', '其他', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('196', 'admin', '2', 'Admin/Menu/add', '新增', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('197', 'admin', '2', 'Admin/Menu/edit', '编辑', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('198', 'admin', '2', 'Admin/Think/lists?model=article', '应用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('199', 'admin', '2', 'Admin/Think/lists?model=download', '下载管理', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('200', 'admin', '2', 'Admin/Think/lists?model=config', '应用', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('201', 'admin', '2', 'Admin/Action/actionlog', '行为日志', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('202', 'admin', '2', 'Admin/User/updatePassword', '修改密码', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('203', 'admin', '2', 'Admin/User/updateNickname', '修改昵称', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('204', 'admin', '2', 'Admin/action/edit', '查看行为日志', '-1', '');
INSERT INTO `onethink_auth_rule` VALUES ('206', 'admin', '1', 'Admin/think/edit', '编辑数据', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('207', 'admin', '1', 'Admin/Menu/import', '导入', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('208', 'admin', '1', 'Admin/Model/generate', '生成', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('209', 'admin', '1', 'Admin/Addons/addHook', '新增钩子', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('210', 'admin', '1', 'Admin/Addons/edithook', '编辑钩子', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('211', 'admin', '1', 'Admin/Article/sort', '文档排序', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('212', 'admin', '1', 'Admin/Config/sort', '排序', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('213', 'admin', '1', 'Admin/Menu/sort', '排序', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('214', 'admin', '1', 'Admin/Channel/sort', '排序', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('215', 'admin', '1', 'Admin/Category/operate/type/move', '移动', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('216', 'admin', '1', 'Admin/Category/operate/type/merge', '合并', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('217', 'admin', '1', 'Admin/Forum/forum', '贴吧管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('218', 'admin', '1', 'Admin/Forum/post', '帖子管理', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('219', 'admin', '1', 'Admin/Forum/editForum', '编辑／发表帖子', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('220', 'admin', '1', 'Admin/Forum/editPost', 'edit pots', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('221', 'admin', '2', 'Admin//Admin/Forum/index', '讨论区', '1', '');
INSERT INTO `onethink_auth_rule` VALUES ('222', 'admin', '2', 'Admin//Admin/Weibo/index', '微博', '1', '');

-- -----------------------------
-- Table structure for `onethink_avatar`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_avatar`;
CREATE TABLE `onethink_avatar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `path` varchar(70) NOT NULL,
  `create_time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `is_temp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_avatar`
-- -----------------------------
INSERT INTO `onethink_avatar` VALUES ('35', '1', '2014-03-11/531ed0a6e0706-d520e9ee.jpg', '1394613879', '1', '0');

-- -----------------------------
-- Table structure for `onethink_category`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_category`;
CREATE TABLE `onethink_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '关联模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text NOT NULL COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- -----------------------------
-- Records of `onethink_category`
-- -----------------------------
INSERT INTO `onethink_category` VALUES ('1', 'blog', '博客', '0', '0', '10', '', '', '', '', '', '', '', '2', '2,1', '0', '0', '1', '0', '0', '1', '', '1379474947', '1382701539', '1', '0');
INSERT INTO `onethink_category` VALUES ('2', 'default_blog', '默认分类', '1', '1', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '1', '1', '0', '1', '1', '', '1379475028', '1386839751', '1', '31');

-- -----------------------------
-- Table structure for `onethink_channel`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_channel`;
CREATE TABLE `onethink_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_channel`
-- -----------------------------
INSERT INTO `onethink_channel` VALUES ('1', '0', '首页', 'Home/Index/index', '1', '1379475111', '1394586872', '1', '0');
INSERT INTO `onethink_channel` VALUES ('2', '0', '讨论区', 'Forum/Index/index', '2', '1379475131', '1394692439', '1', '0');
INSERT INTO `onethink_channel` VALUES ('3', '0', '微博', 'Weibo/Index/index', '3', '1379475154', '1394692449', '1', '0');

-- -----------------------------
-- Table structure for `onethink_config`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_config`;
CREATE TABLE `onethink_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_config`
-- -----------------------------
INSERT INTO `onethink_config` VALUES ('1', 'WEB_SITE_TITLE', '1', '网站标题', '1', '', '网站标题前台显示标题', '1378898976', '1379235274', '1', 'OneThink内容管理框架', '1');
INSERT INTO `onethink_config` VALUES ('2', 'WEB_SITE_DESCRIPTION', '2', '网站描述', '1', '', '网站搜索引擎描述', '1378898976', '1379235841', '1', 'OneThink内容管理框架', '5');
INSERT INTO `onethink_config` VALUES ('3', 'WEB_SITE_KEYWORD', '2', '网站关键字', '1', '', '网站搜索引擎关键字', '1378898976', '1381390100', '1', 'ThinkPHP,OneThink', '19');
INSERT INTO `onethink_config` VALUES ('4', 'WEB_SITE_CLOSE', '4', '关闭站点', '1', '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1379235296', '1', '1', '6');
INSERT INTO `onethink_config` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1379235348', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', '8');
INSERT INTO `onethink_config` VALUES ('10', 'WEB_SITE_ICP', '1', '网站备案号', '1', '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', '1378900335', '1379235859', '1', '', '21');
INSERT INTO `onethink_config` VALUES ('11', 'DOCUMENT_POSITION', '3', '文档推荐位', '2', '', '文档推荐位，推荐到多个位置KEY值相加即可', '1379053380', '1379235329', '1', '1:列表页推荐\r\n2:频道页推荐\r\n4:网站首页推荐', '11');
INSERT INTO `onethink_config` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '文档可见性', '2', '', '文章可见性仅影响前台显示，后台不收影响', '1379056370', '1379235322', '1', '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', '14');
INSERT INTO `onethink_config` VALUES ('13', 'COLOR_STYLE', '4', '后台色系', '1', 'default_color:默认\r\nblue_color:紫罗兰', '后台颜色风格', '1379122533', '1379235904', '1', 'default_color', '23');
INSERT INTO `onethink_config` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '配置分组', '4', '', '配置分组', '1379228036', '1384418383', '1', '1:基本\r\n2:内容\r\n3:用户\r\n4:系统', '15');
INSERT INTO `onethink_config` VALUES ('21', 'HOOKS_TYPE', '3', '钩子的类型', '4', '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', '1379313397', '1379313407', '1', '1:视图\r\n2:控制器', '17');
INSERT INTO `onethink_config` VALUES ('22', 'AUTH_CONFIG', '3', 'Auth配置', '4', '', '自定义Auth.class.php类配置', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '20');
INSERT INTO `onethink_config` VALUES ('23', 'OPEN_DRAFTBOX', '4', '是否开启草稿功能', '2', '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', '1379484332', '1379484591', '1', '1', '10');
INSERT INTO `onethink_config` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '自动保存草稿时间', '2', '', '自动保存草稿的时间间隔，单位：秒', '1379484574', '1386143323', '1', '60', '9');
INSERT INTO `onethink_config` VALUES ('25', 'LIST_ROWS', '0', '后台每页记录数', '2', '', '后台数据每页显示记录数', '1379503896', '1380427745', '1', '10', '24');
INSERT INTO `onethink_config` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '是否允许用户注册', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '1', '12');
INSERT INTO `onethink_config` VALUES ('27', 'CODEMIRROR_THEME', '4', '预览插件的CodeMirror主题', '4', '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', '1379814385', '1384740813', '1', 'ambiance', '13');
INSERT INTO `onethink_config` VALUES ('28', 'DATA_BACKUP_PATH', '1', '数据库备份根路径', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', './Data/', '16');
INSERT INTO `onethink_config` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '18');
INSERT INTO `onethink_config` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '22');
INSERT INTO `onethink_config` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '25');
INSERT INTO `onethink_config` VALUES ('32', 'DEVELOP_MODE', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '1', '26');
INSERT INTO `onethink_config` VALUES ('33', 'ALLOW_VISIT', '3', '不受限控制器方法', '0', '', '', '1386644047', '1386644741', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', '2');
INSERT INTO `onethink_config` VALUES ('34', 'DENY_VISIT', '3', '超管专限控制器方法', '0', '', '仅超级管理员可访问的控制器方法', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '3');
INSERT INTO `onethink_config` VALUES ('35', 'REPLY_LIST_ROWS', '0', '回复列表每页条数', '2', '', '', '1386645376', '1387178083', '1', '10', '4');
INSERT INTO `onethink_config` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '后台允许访问IP', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1387165553', '1', '', '27');
INSERT INTO `onethink_config` VALUES ('37', 'SHOW_PAGE_TRACE', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1387165685', '1', '0', '7');

-- -----------------------------
-- Table structure for `onethink_document`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_document`;
CREATE TABLE `onethink_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';

-- -----------------------------
-- Records of `onethink_document`
-- -----------------------------
INSERT INTO `onethink_document` VALUES ('1', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '10', '0', '0', '0', '1387260660', '1387263112', '1');

-- -----------------------------
-- Table structure for `onethink_document_article`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_document_article`;
CREATE TABLE `onethink_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

-- -----------------------------
-- Records of `onethink_document_article`
-- -----------------------------
INSERT INTO `onethink_document_article` VALUES ('1', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');

-- -----------------------------
-- Table structure for `onethink_document_download`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_document_download`;
CREATE TABLE `onethink_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';


-- -----------------------------
-- Table structure for `onethink_file`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_file`;
CREATE TABLE `onethink_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `create_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='文件表';

-- -----------------------------
-- Records of `onethink_file`
-- -----------------------------
INSERT INTO `onethink_file` VALUES ('1', 'b812c8fcc3cec3fdd2c20975d488d4', '531eb3d114f8d.jpg', '2014-03-11/', 'jpg', 'image/jpeg', '105171', 'd6903bc773c2d1264fc17f2f5ce8a33e', '02745a1d1c8f633566bcc31b0eb34b6e416133b6', '0', '1394521041');
INSERT INTO `onethink_file` VALUES ('2', '5801ad5ad6eddc451dabc0ba0c4b4f', '531eb3f5db425.jpg', '2014-03-11/', 'jpg', 'image/jpeg', '8553', 'e9be72e439fa75d487735c18047ccf81', '2c7448899628f237fe6fb518d365630902aaa4f5', '0', '1394521077');
INSERT INTO `onethink_file` VALUES ('3', '5086f061d950a7b0208c22b6db060d', '531eb449ceee6.jpg', '2014-03-11/', 'jpg', 'image/jpeg', '7209', '9d1a9e7139663cc152d4b21756e68a34', '189450a20d5617b17fc1ce8e758c14c7805d05b8', '0', '1394521161');
INSERT INTO `onethink_file` VALUES ('4', 'fengjing1.jpg', '531eb48bc2df9.jpg', '2014-03-11/', 'jpg', 'image/jpeg', '66383', '4c68126fe1ad81b1d2ac2b6b87d96c4e', 'c13dedaab894df32672b09235ee011a880cf7e26', '0', '1394521227');
INSERT INTO `onethink_file` VALUES ('5', 'hunli1.jpg', '531eb4cc86245.jpg', '2014-03-11/', 'jpg', 'image/jpeg', '67161', 'f18765ee3bd7b17225d433aefdb14b63', '29698328c200813b5f8d981fa8bf499af1201a87', '0', '1394521292');
INSERT INTO `onethink_file` VALUES ('6', 'f3d3572c11dfa9ec3f3f111960d0f7', '531eb4e274c24.jpg', '2014-03-11/', 'jpg', 'image/jpeg', '34785', '7b8663f76efce5b6a1b3abadd74d39ab', '8dd49247f442a01d6b0e927b72292d274694b006', '0', '1394521314');
INSERT INTO `onethink_file` VALUES ('7', 'Jellyfish.jpg', '531eb85e75e43.jpg', '2014-03-11/', 'jpg', 'image/jpeg', '775702', '5a44c7ba5bbe4ec867233d67e4806848', '3b15be84aff20b322a93c0b9aaa62e25ad33b4b4', '0', '1394522206');
INSERT INTO `onethink_file` VALUES ('8', 'e7cd7b899e510fb32914fcd7db33c8', '531ed0a6e0706.jpg', '2014-03-11/', 'jpg', 'image/jpeg', '122776', '2c46a8ac0685b71399b7b51bb39b634d', '3ede3059ec105297bc25ccc35bd6644a1ed3a136', '0', '1394528415');
INSERT INTO `onethink_file` VALUES ('9', 'Koala.jpg', '531fd1c8399b5.jpg', '2014-03-12/', 'jpg', 'image/jpeg', '780831', '2b04df3ecc1d94afddff082d139c6f15', '9c3dcb1f9185a314ea25d51aed3b5881b32f420c', '0', '1394594248');
INSERT INTO `onethink_file` VALUES ('10', 'Tulips.jpg', '531fd1cc72e7e.jpg', '2014-03-12/', 'jpg', 'image/jpeg', '620888', 'fafa5efeaf3cbe3b23b2748d13e629a1', '54c2f1a1eb6f12d681a5c7078421a5500cee02ad', '0', '1394594252');
INSERT INTO `onethink_file` VALUES ('11', 'Penguins.jpg', '531fd1d686d39.jpg', '2014-03-12/', 'jpg', 'image/jpeg', '777835', '9d377b10ce778c4938b3c7e2c63a229a', 'df7be9dc4f467187783aca68c7ce98e4df2172d0', '0', '1394594262');
INSERT INTO `onethink_file` VALUES ('12', '黑板报1.png', '531fd1fd5e142.png', '2014-03-12/', 'png', 'image/png', '70513', 'e5370e801e44ad4899f7e16df7506ce1', 'b9b6da683dab4a523062f851824e6a56f710bc4a', '0', '1394594301');
INSERT INTO `onethink_file` VALUES ('13', '微刊_tra.png', '531fd205c570c.png', '2014-03-12/', 'png', 'image/png', '84408', '982dbdf7b46483cde7dd79c47cd3cf6e', '15278bdd50725a5075f2f958f8bf32830418b705', '0', '1394594309');

-- -----------------------------
-- Table structure for `onethink_forum`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_forum`;
CREATE TABLE `onethink_forum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `post_count` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `allow_user_group` text NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_forum`
-- -----------------------------
INSERT INTO `onethink_forum` VALUES ('1', '默认板块', '2433180', '9', '1', '1', '4');
INSERT INTO `onethink_forum` VALUES ('2', '测试板块', '1394615400', '0', '1', '1', '2');
INSERT INTO `onethink_forum` VALUES ('3', '意见反馈', '1394616120', '0', '1', '1', '3');
INSERT INTO `onethink_forum` VALUES ('4', '产品下载', '1394692260', '2', '1', '3', '1');

-- -----------------------------
-- Table structure for `onethink_forum_bookmark`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_forum_bookmark`;
CREATE TABLE `onethink_forum_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_forum_bookmark`
-- -----------------------------
INSERT INTO `onethink_forum_bookmark` VALUES ('17', '1', '6', '1394528528');

-- -----------------------------
-- Table structure for `onethink_forum_post`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_forum_post`;
CREATE TABLE `onethink_forum_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `parse` int(11) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `last_reply_time` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `reply_count` int(11) NOT NULL,
  `is_top` tinyint(4) NOT NULL COMMENT '是否置顶',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_forum_post`
-- -----------------------------
INSERT INTO `onethink_forum_post` VALUES ('3', '1', '1', '可以帮我设计一个函数的问题 。 最后回答的答案是...', '0', '<span style=\"font-family:Arial, 宋体;font-size:14px;line-height:24px;background-color:#FFFFFF;\">可以帮我设计一个函数的问题 不用太复杂。 最后回答的答案是1126</span>', '1394447649', '1394447649', '1', '1394447649', '17', '0', '1');
INSERT INTO `onethink_forum_post` VALUES ('5', '1', '1', '什么是 Drude 模型？它在固体物理中的意义是什么？', '0', '<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">谢邀，题主提了个好问题。（上来就这么卖萌真的好吗！）</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">--------------------------------正文分割线------------------------------------------------------------------------</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">Drude模型是固体物理最基本的模型之一，由德国物理学家P Drude在</span><b>1900</b><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">年提出。同志们，那是1900年，就在这一年的4月27日，我们伟大的开尔文勋爵说：“动力学理论认为热和光都是运动的方式，现在这一理论的优美和明晰，正被两朵乌云笼罩着。”是的，那个时候，相对论和量子力学还没出现，爱因斯坦和玻尔这两位巨人还是名不见经传的新人。然而就在经典力学的框架里，Paul Drude 提出了这个简单而又深刻的模型，</span><b>在一定程度上成功的</b><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">解释了金属导电的原理以及一系列相关问题。可惜Drude在这个理论提出6年后就去世了，没能来得及见证Drude模型在量子时代的发展。</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">Drude模型的基础是一个非常简单的想法：把金属中的电子看做气体。基于此，Drude提出了如下假设。</span><br />\r\n<ol style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	<li>\r\n		金属由两部分组成，一是可以<b>自由运动的电子</b>，二是<b>固定不动的离子实</b>，这些可以自由运动的电子使金属导电的成分。\r\n	</li>\r\n	<li>\r\n		将自由电子看做带电的小硬球，它们的运动遵循牛顿第二定律。在忽略电子-电子和电子-离子间电磁相互作用（内场）的情况下，它们在金属中运动或并发生碰撞。<b>这一假设被称为独立自由电子气假设。</b>事实上，后来的研究证明，忽略电子间的相互作用对实验结果影响并不大，但大多数情况下，电子-离子相互作用是不能忽略的。<br />\r\n	</li>\r\n	<li>\r\n		Drude模型中的碰撞遵循经典碰撞模型，具有瞬时性的特点。事实上电子在金属中的散射机制非常复杂，但在此我们<b>不考虑这些散射机制的详细原理</b>，<b>只关心电子会发生碰撞并在碰撞瞬间改变速度。</b>接下来的两条假设将会更具体的对碰撞进行描述。\r\n	</li>\r\n	<li>\r\n		假设电子在金属中的碰撞遵循泊松过程。每个电子在单位时间内碰撞的概率是<img src=\"http://zhihu.com/equation?tex=%5Cfrac%7B1%7D%7B%5Ctau%7D+\" alt=\"\\frac{1}{\\tau} \" />，即在<img src=\"http://zhihu.com/equation?tex=dt\" alt=\"dt\" />时间内发生碰撞的概率为<img src=\"http://zhihu.com/equation?tex=%5Cfrac%7Bdt%7D%7B%5Ctau%7D\" alt=\"\\frac{dt}{\\tau}\" />，其中<img src=\"http://zhihu.com/equation?tex=%5Ctau\" alt=\"\\tau\" />被称为弛豫时间（又叫平均自由时间），其意义是在任意一个粒子距离下一次碰撞（或上一次碰撞）发生的时间的平均值。这是Drude模型最中最重要的概念。\r\n	</li>\r\n	<li>\r\n		假设电子<b>只能</b>通过碰撞才能与周围环境达到热平衡（事实上这也是自由独立粒子假设的必然结果），即是说每次碰撞的结果都是随机的，与碰撞前电子的状态没有任何关系，只于碰撞发生地点的温度有关。\r\n	</li>\r\n</ol>\r\n<br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">以上就是Drude模型中的全部假设，简单漂亮有逻辑。但是光说不练假把式，下面就来以最基本的金属直流电阻为例来说明Drude模型的应用。</span><br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">让我们先回顾欧姆定律：</span><img src=\"http://zhihu.com/equation?tex=V%3DIR\" alt=\"V=IR\" /><br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">其微观形式为：</span><img src=\"http://zhihu.com/equation?tex=%5Cbar%7BE%7D%3D%5Crho+%5Cbar%7Bj%7D\" alt=\"\\bar{E}=\\rho \\bar{j}\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">*,</span><img src=\"http://zhihu.com/equation?tex=%5Crho%3D%5Cfrac%7B1%7D%7B%5Csigma%7D\" alt=\"\\rho=\\frac{1}{\\sigma}\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">,其中</span><img src=\"http://zhihu.com/equation?tex=%5Crho\" alt=\"\\rho\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">为电阻率，</span><img src=\"http://zhihu.com/equation?tex=%5Csigma\" alt=\"\\sigma\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">为电导率，接下来就用Drude模型来解释电导率</span><img src=\"http://zhihu.com/equation?tex=%5Csigma\" alt=\"\\sigma\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">的意义。</span><br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">假设某处电子密度为</span><img src=\"http://zhihu.com/equation?tex=n\" alt=\"n\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">,平均运动速度为</span><img src=\"http://zhihu.com/equation?tex=%5Cbar%7Bv%7D+\" alt=\"\\bar{v} \" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">,那么显然电流和该处电子运动方向平行且相反，由电流的定义，我们可以写出：</span><img src=\"http://zhihu.com/equation?tex=%5Cbar%7Bj%7D%3D-ne%5Cbar%7Bv%7D\" alt=\"\\bar{j}=-ne\\bar{v}\" /><br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">无外场且热平衡时时，金属内的电子处处都在进行无规则的热运动，因此平均速度</span><img src=\"http://zhihu.com/equation?tex=%5Cbar%7Bv%7D%3D0\" alt=\"\\bar{v}=0\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">，</span><img src=\"http://zhihu.com/equation?tex=%5Cbar%7Bj%7D%3D0\" alt=\"\\bar{j}=0\" /><br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">将外场</span><img src=\"http://zhihu.com/equation?tex=%5Cbar%7BE%7D\" alt=\"\\bar{E}\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">添加进模型。考虑处于时刻0的一个电子，假设它距离上一次碰撞的时间为</span><img src=\"http://zhihu.com/equation?tex=t\" alt=\"t\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">，初始速度为</span><img src=\"http://zhihu.com/equation?tex=%5Cbar%7Bv_0%7D\" alt=\"\\bar{v_0}\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">，由假设2，0时刻它的速度为</span><img src=\"http://zhihu.com/equation?tex=%5Cbar%7Bv%7D%3D%5Cbar%7Bv_0%7D-e%5Cbar%7BE%7Dt%2Fm\" alt=\"\\bar{v}=\\bar{v_0}-e\\bar{E}t/m\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">.接下来我们对0时刻金属内所有的电子求平均，由假设5，</span><img src=\"http://zhihu.com/equation?tex=%5Cbar%7Bv_0%7D\" alt=\"\\bar{v_0}\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">的平均值为0，由假设4，</span><img src=\"http://zhihu.com/equation?tex=t\" alt=\"t\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">的平均值为</span><img src=\"http://zhihu.com/equation?tex=%5Ctau\" alt=\"\\tau\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">，因此速度的平均值</span><img src=\"http://zhihu.com/equation?tex=%5Cbar%7Bv_%7Bavg%7D%7D%3D-e%5Cbar%7BE%7D%5Ctau%2Fm\" alt=\"\\bar{v_{avg}}=-e\\bar{E}\\tau/m\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">，将该值代入</span><img src=\"http://zhihu.com/equation?tex=%5Cbar%7Bj%7D%3D-ne%5Cbar%7Bv%7D\" alt=\"\\bar{j}=-ne\\bar{v}\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">中，得到</span><img src=\"http://zhihu.com/equation?tex=%5Cbar%7Bj%7D%3D%5Cfrac%7Bne%5E2%5Ctau%7D%7Bm%7D%5Cbar%7BE%7D\" alt=\"\\bar{j}=\\frac{ne^2\\tau}{m}\\bar{E}\" /><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">。将该式与欧姆定律比较，可以得到：</span><br />\r\n<img src=\"http://zhihu.com/equation?tex=%5Csigma%3D%5Cfrac%7Bne%5E2%5Ctau%7D%7Bm%7D\" alt=\"\\sigma=\\frac{ne^2\\tau}{m}\" /><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">哒哒哒，这样我们就用Drude模型把电导率的表达式推出来了。事实上，由于电阻率非常方便测量，我们大部分时候都是用上面这个公式 去求弛豫时间。</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">上面只是Drude模型最简单的一个应用，我们还可以用它去求霍尔效应系数，交流电阻等等问题，在准确性方面都有着不错的表现。这里不详细讨论，有兴趣的童鞋可以去看下面列出的参考文献。</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">*鉴于知乎蛋疼的公式编辑器，此处用上横线代表矢量，所有平均值均有说明。</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">参考文献：Neil W Ashcroft &lt;Solid State Physics&gt;&nbsp;</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">——————————————————————————————————</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">PS：这题我是自问自答的，主要原因是我觉得现在知乎上自然科学领域类的问题普遍比较水，大量问题都集中在民科研究兴趣范围内，于是希望能有更多的人来分享相关领域的一些干货。二来也想借这种自问自答来梳理一下学习思路和知识体系。本人非大牛，只是普通物理系学生一枚，出错在所难免，还希望各位大神看到问题或答案后有任何想法能不吝赐教，本人在此先行谢过。如果效果不错以后我会继续采取这种形式来分享我的知识和学习结果。多谢您充满耐心看完这么一大段 : )</span>', '1394451319', '1394451319', '1', '1394451319', '46', '1', '1');
INSERT INTO `onethink_forum_post` VALUES ('6', '1', '1', '腾讯出钱，出微信，牺牲易迅到底寻求到什么？只是为一个京东的董事会席位吗？', '0', '<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">我只不过是分享了一篇我认为分析的很在理的文章，举手之劳，大家给予这么多赞，诚惶诚恐；第一次答题感谢大家的鼓励，为了让大家更好的理解腾讯入股京东事宜，接下来跟大家分享一个海通证券研究所的研究摘录，这份摘录将从腾讯和京东双方利益交换的角度，用数据说话，分析此次事件对电商格局的影响，话不多说，直接上报告！</span><br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">---------------------------------------------------------------------------------------------------------------------------------</span><br />\r\n<strong>事件：</strong><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">3 月 7 日消息，腾讯与京东的资本联姻已成定局。腾讯电商正在就此事召开会议，正式确定腾讯电商与京东的合并方案：腾讯微购物并入微信，其他腾讯拍拍、QQ 团购、易迅网等线上电商并入京东。京东已经有人员开始入驻易迅，开始对易迅的仓库、库存以及相关资产做盘点，而刘强东也已经和马化腾见面商讨合并一事。</span> \r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	<strong>我们的观点：</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	<strong>总体而言，腾讯与京东的资本联姻，将显著改变互联网及移动互联网时代的电商竞争格局，主要互联网电商竞争参与者的地位和趋势展望将发生变化。</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	（1）从<strong>腾讯</strong>角度，虽然剥离电商B2C业务将减少其收入约20%的比例，但可提升毛利率8个百分点左右。同时，<strong>从现实角度，其依靠易迅赶超阿里、京东等实物电商继而改变现有电商格局的可能性较小，通过以资源换取京东股份和远优于易迅的电商平台，将使其能够专注于信息服务，着力于完善微信</strong><strong>O2O</strong><strong>生态圈，并借助京东丰富微信支付的电商应用场景，有助于其进一步增强移动互联网入口和微信支付等的竞争力</strong>。\r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	（2）从<strong>京东</strong>角度，易迅、拍拍网和QQ团购并入京东后，可为京东新增C2C和团购运营平台，京东旗下将形成京东+易迅B2C、拍拍网C2C、团购等多业务板块，市场份额提升。更重要的是，京东将可获得微信流量额用户关系导入，打通O2O，从互联网电商快速买入移动互联网竞争高地，相对于阿里巴巴等的竞争力将进一步提升，短期的效果在于，京东的上市估值空间将进一步被打开。<strong>不考虑合并后京东可能的</strong><strong>O2O</strong><strong>发展空间，我们静态测算腾讯的入股比例在</strong><strong>16-20%</strong><strong>的可能性更大，测算腾讯电商对京东的估值增厚区间为</strong><strong>9.7%-18.1%</strong><strong>，中枢为</strong><strong>13.6%</strong><strong>；</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	<strong>以下是我们的进一步分析，敬请参考！</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	<strong>（1）腾讯：静态测算剥离B2C业务减少收入20%、提升毛利率8个百分点，专注打造微信O2O生态圈的</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	腾讯2013上半年实现收入280亿元，同比增长38.58%，毛利率55.04%，其中电子商务服务收入占比14.7%（2012年10.1%），毛利率6.27%（2012年5.31%），毛利额占比仅1.7%（2012年0.9%）。<strong>我们初步测算预计，腾讯2013全年收入约600亿元，假设电商收入占比15%，合约90亿元，对应增速约100%；若腾讯剥离电商业务，静态测算其2013上半年毛利率将大幅提升8.4个百分点至63.5%</strong><strong>。</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	腾讯旗下电商资产主要包括<strong>：（A</strong><strong>）易迅网：</strong>2006年上线，在2013年B2C市场（含平台式）中，天猫以50.1%的市场份额居首位；<strong>京东份额</strong><strong>22.4%（超1000亿元），若加上腾讯电商的3.1%（约150-200亿元），合计25.5%，与第3位苏宁易购（4.9%）的差距将进一步拉大（中国电子商务研究中心数据）。</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	<strong>（</strong><strong>B</strong><strong>）拍拍网</strong>：2005年上线，较淘宝网晚两年，在2013年C2C市场中，淘宝网份额高达96.5%（对应约1.1万亿交易额），拍拍网占3.4%（对应约600亿交易额），易趣网占0.1%。\r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	<strong>（</strong><strong>C）QQ团购</strong>：2010年上线，2013年1月腾讯旗下高朋网与F团、QQ团三者合并，由高朋网运营，2013年团购市场份额合计6.41%，仅次于美团网（16.44%，阿里巴巴投资），第3-7名依次为拉手网（5.13%）、糯米网（5.06%，百度收购）、大众点评（4.87%，腾讯持股20%）、窝窝团（4.68%）、满座网（1.39%，苏宁收购）。<strong>若以高朋+</strong><strong>大众点评计，市场份额合计达11.28%，与美团网同为团购市场第一阵营，远高于其他网站5%或以下的份额。</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	<strong>（D）腾讯微购物：</strong>&nbsp;2014年1月初上线，致力于打造O2O一体化购物平台，目前入驻65个品牌（包括绫致旗下vero moda、only、jack jones三个品牌）。\r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	<strong>除上述所析经营层面影响外，在战略层面腾讯还可通过京东平台推广微信支付，后续若将微购物、京东B2C、QQ团购等多业务接入微信，可进一步完善微信O2O生态圈，增强与阿里巴巴的对战筹码。</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	<strong>（2）京东：电商业务多元化，对接微信入口打开估值想像空间</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	我们认为，易迅原有资产并入京东后，可分享后者较优的供应链效率，提高竞争力，但因涉及人员、资产和物流等资源整合，预计两者合并后在B2C市场的规模效应发挥仍需一段时间；拍拍网和QQ团购并入京东后，为京东新增C2C和团购运营平台，<strong>京东旗下将形成京东</strong><strong>+易迅B2C、拍拍网C2C、团购等多业务板块。</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	在移动购物市场，淘宝无线占比76.6%，第2-5及市场份额依次为手机京东6%、手机腾讯电商1.5%、苏宁易购0.8%、手机亚马逊中国0.6%（艾瑞数据）。若腾讯对整合后的京东全面开放微信入口，京东有望分享微信流量，提升移动端市场份额；更重要的是，对接微信入口有望迅速京东打开O2O发展空间，这也是提升其上市估值的关键所在。\r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	自2月中旬传出腾讯入股京东事项至今，媒体虽多次捕风捉影地报道进展，但并未确定入股比例和金额，目前有16-20%和5-6%两种说法。<strong>不考虑合并后京东可能的</strong><strong>O2O发展空间，我们静态测算腾讯的入股比例在16-20%的可能性更大：</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	（A）以腾讯电商2013年90亿人民币（合约15亿美元）为基数，分别给以2014年60%、80%和100%增速，给以0.8、1.0和1.2倍PS，对应腾讯电商估值区间为18.6-34.8亿美元；\r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	（B）按之前《对京东商城招股书的深度分析——国内B2C电商领导企业，创新业务成长是盈利机会20140207》中给以的京东估值中枢192亿美元（2014年60%收入增速、1倍PS），<strong>测算腾讯电商对京东的估值增厚区间为9.7%-18.1%，中枢为13.6%</strong><strong>；</strong> \r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	（C）若另外加上部分现金对价，腾讯持股比例很可能达16-20%。\r\n</p>\r\n<p style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;\">\r\n	无论腾讯持股比例为5-6%还是16-20%，股份很可能为A类股（投票权比例为1:1），投票权仍较小；而刘强东目前直接间接所持有23.67%股份为B类股（投票权比例为1:20），对应投票权超85%，足以保持京东运营的独立性。\r\n</p>\r\n<img src=\"http://p2.zhimg.com/a6/f2/a6f2d851126869f5fe49d2efb8abd106_m.jpg\" class=\"origin_image zh-lightbox-thumb lazy\" width=\"763\" style=\"height:168.38794233289644px;width:584px;\" /><br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">----------------------------------------------------------------------------------------------------------</span><br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">易迅网员工，分享一篇文章，或许对解答各位知友的疑惑有些许帮助，全文引用如下！</span><br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">-------------------------------------------------------------------------------------------------------------</span><br />\r\n<strong>从全资收购到割给京东，腾讯为何玩法变了？</strong><br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">2014-03-06 赵楠 村里那点儿事 文/赵楠（个人微信：zhaonan）&nbsp;</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">我有一个在易迅做技术的同学，昨天他对我说，过两天易迅就会开一个内部员工的会议，到那天，一切就都明朗了。&nbsp;</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">我明白我这个同学所说的“明朗”是指什么，腾讯入股京东的传闻飘了半个多月，易迅是否会并入京东，易迅的员工比刘强东还要着急。而他所说的“过两天”，也就指的是这周五了。</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">他告诉我，他已做好了两手准备。如果易迅仍然保留，他就不动；而如果并入京东，他就打算去广研工作。过去一周，他已在腾讯内部的RTX上与微信的相关技术负责人打好了照面。而从易迅找技术人才的，除了最翘首的微信，还有腾讯的其他部门。“在传闻面前，没有人会无动于衷。更何况，你要面对的是一个没有辟谣的传闻。”他在微信上留下了这句话。&nbsp;</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">“很难理解腾讯高层会把在电商领域的‘亲儿子’给割出去。”传闻发出后，我这个同学起初一点也不相信，但不同的媒体又相继传了几次，外电都报道了，他自己也开始怀疑了。&nbsp;</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">不理解的不只有他，还有当当网的李国庆。昨天，李国庆在交流时说，刘强东不会给腾讯控股权，腾讯还把电商交出去，这是战略上要放弃电商的节奏？&nbsp;</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">或许用“战略上放弃”这个字眼有些严重了。</span><strong>但衡量这个问题的标准是，如果没有这个业务，其它的平台级公司是否会威胁到腾讯的战略安全？</strong><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">这是一个非常有意思的辨证。现在来看，显然已不会被威胁到，因此腾讯完全可以通过战略投资来替代非得自己去做的模式。&nbsp;</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">那是否之前就会被威胁呢？之前的威胁和现在的不被威胁分界线在哪呢？</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">这个问题从腾讯投资部彭志坚的话里可以找到一些眉目。之前腾讯为什么到处投资电商，甚至将易迅全资收购又转为全资子公司？那是因为在2010年，腾讯突然开始觉得电商是用户在互联网上的一个非常重要的生活场景，而这个频次使用非常之高的生活场景是足以独立支撑起一个又一个新的平台和生态的。这个生态包括在线交易、用户池、支付、互联网金融，大数据和云端服务，以及外延的流量生态。而这个生态又不受腾讯所掌控。这对腾讯来说是非常危险的事情，超强的粘性场景一旦让用户习惯建立起来后，会极大的分流腾讯的用户。&nbsp;</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">因此也可以看到，2010年，腾讯开始多点投资布局电商，可以说在任何一个重要的垂直品类，在当时看来未来有可能往平台方向发展的垂直电商，均有腾讯投资的身影，腾讯已在外围拉起了一道防线。除此之外，腾讯把易迅转成了“亲儿子”，而“亲儿子”的策略很明显，就是死死拖着京东的后腿，试图延缓京东的发展时间。要知道，京东是很有可能成为TABLE之后又一个平台级的互联网公司，而绝不仅仅是一个平台级的电商公司。现在来看，京东的象限不仅是电商已有证明。这就像几个有核武器的国家，谁会希望又一个国家拥有核武器呢？</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">但腾讯现在已不用担心这个问题。</span><strong>原先的担心是电商这个重要的生活场景生态不在自己的掌控之内</strong><span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">，但现在和未来是属于移动互联网时代的，而且，在这个时代里，腾讯还有了微信。&nbsp;</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">在PC互联网，QQ客户端不具有网罗电商生态的能力，但</span><strong>在移动互联网，微信却在一步一步的渗透电商，网罗电商。&nbsp;</strong><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">这是因为，与PC互联网不同，移动互联网让用户的购物行为变成了一个可以随时随地的事儿。而微信在手机上的巨大粘性正在让它无限接近一个操作系统或是一个手机Windows的价值。从前，大家都在淘宝、京东上购物，第一入口是浏览器，是网址；而现在，第一入口是微信，微信的API接口和UGC内容越来越多，但微信的使用依然很薄很轻便。在这种情况下，假设京东接入了微信，那么京东就只是微信的一个后台供应链，给微信打工的，京东苦哈苦哈的干了十年还不到10%的毛利率里面还要拿出一部分与微信分成。</span><br />\r\n<br />\r\n<strong>那如果京东等电商的价值链都在微信上，都在腾讯的体系里，那腾讯为什么还非得自己做电商呢？就算自己做，那得花多少时间成本才能达到一个有战略影响力的程度呢？</strong><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">也许，这个原因就是李国庆说的“战略上放弃”，</span><strong>但准确的说，腾讯放弃的并不是电商，而是由于之前自身没有对电商生态的掌控力，所玩的一些防御性策略到现在已经没有意义了，现在有了微信，对移动电商、O2O生态已能起到一定程度的掌控，就可以换种玩法。</strong><br />\r\n<br />\r\n<strong>这种玩法是什么？就是你通过进入我的微信，从而纳入我的生态体系，然后我投资你，拿你一定的股份，从而对你有一定的话语权，这个话语权可以不控股，但要有一定的约束性，并能给我一定的战略安全保证。</strong><br />\r\n<br />\r\n<strong>这个战略安全保证是什么？说白了就是二股东的身份，能够进入董事会，除了你和我之外，不能有其他的战略大手在里面。</strong><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">可以看到，今年以来，腾讯已经转变了很多过去的投资思路。而未来如对大众点评、京东的这种投资模式仍将继续下去。</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">周五易迅内部会宣布什么，大家都在期待。而如果将易迅并入京东，腾讯还没有控股，也不需要再怎么惊奇了。当然，一旦将易迅并入京东，刘强东是否还会以1比20权赴美上市还不好说，刘强东是否允许腾讯也拥有一股多权的B类股也不好说，但相信腾讯也知道刘强东对于京东的意义是无人可替的。&nbsp;</span><br />\r\n<br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">-----------------------------&nbsp;</span><br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">村里那点儿事 {公众号：clndes} wemedia联盟 创办人：赵楠，《第一财经日报》记者</span><br />\r\n<span style=\"color:#222222;font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;font-size:13px;line-height:22.100000381469727px;\">------------------------------------------------------------------------------------------------------------------</span>', '1394451445', '1394452349', '1', '1394759023', '244', '7', '0');
INSERT INTO `onethink_forum_post` VALUES ('7', '2', '1', 'dawdwa', '0', 'wdaawd', '1394599663', '1394599663', '1', '1394599663', '9', '1', '0');
INSERT INTO `onethink_forum_post` VALUES ('8', '1', '1', 'adfsdfassdf', '0', 'dfasfdasadfsfad', '1394615997', '1394615997', '1', '1394615997', '3', '1', '0');
INSERT INTO `onethink_forum_post` VALUES ('9', '1', '2', 'adfsfdsfdas', '0', 'dfasfdasdfasdfasnjidvkb fduiaslegde ,', '1394616126', '1394616126', '1', '1394616126', '10', '1', '0');
INSERT INTO `onethink_forum_post` VALUES ('10', '1', '1', 'fdasfdasfdas', '0', 'fdsfbhfadilasfhbdofh9 d', '1394617128', '1394617128', '1', '1394617128', '2', '0', '0');
INSERT INTO `onethink_forum_post` VALUES ('11', '3', '4', 'OnePlus 0.1 发布', '0', '<p>\r\n	大撒的发生都发生的发撒的方式\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<a class=\"ke-insertfile\" href=\"http://www.baidu.com\" target=\"_blank\">http://www.baidu.com</a>\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	afsddfasadsafdsadfs\r\n</p>', '2014', '2014', '1', '2014', '9', '1', '0');
INSERT INTO `onethink_forum_post` VALUES ('12', '1', '4', 'dfasdfsdfs', '0', 'dfdfs', '2014', '2014', '1', '2014', '2', '0', '0');
INSERT INTO `onethink_forum_post` VALUES ('13', '0', '0', 'fdasdfsdfasdfas', '0', 'addfasfdasdfasdfasdfas', '2014', '2014', '0', '2014', '0', '0', '0');
INSERT INTO `onethink_forum_post` VALUES ('14', '14', '1', 'dfasdfasfdasafds', '0', 'fddfasadfsdfs', '1394759516', '1394759516', '1', '1394759516', '1', '0', '0');
INSERT INTO `onethink_forum_post` VALUES ('15', '14', '1', 'dfsafdas', '0', 'dfasdfasdfas', '1394759519', '1394759519', '1', '1394759519', '1', '0', '0');
INSERT INTO `onethink_forum_post` VALUES ('16', '14', '1', 'dfasadfsd', '0', 'fasdfasafds', '1394759523', '1394759523', '1', '1394759523', '1', '0', '0');
INSERT INTO `onethink_forum_post` VALUES ('17', '14', '1', 'fdsasdf', '0', 'fdasfdasafds', '1394759526', '1394759526', '1', '1394759526', '1', '0', '0');
INSERT INTO `onethink_forum_post` VALUES ('18', '14', '1', 'fdasadfsdfs', '0', 'dfasfdasfdas', '1394759533', '1394759533', '1', '1394759533', '1', '0', '0');
INSERT INTO `onethink_forum_post` VALUES ('19', '14', '1', 'dfdfassdf', '0', 'dfsadfasadfs', '1394759538', '1394759538', '1', '1394759538', '1', '0', '0');
INSERT INTO `onethink_forum_post` VALUES ('20', '14', '1', 'dfasadfsfads', '0', 'dfasdfasdfas', '1394759542', '1394759542', '1', '1394759542', '3', '0', '0');

-- -----------------------------
-- Table structure for `onethink_forum_post_reply`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_forum_post_reply`;
CREATE TABLE `onethink_forum_post_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `parse` int(11) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_forum_post_reply`
-- -----------------------------
INSERT INTO `onethink_forum_post_reply` VALUES ('1', '1', '6', '0', 'dsdfsfdsfdasfsd', '1394453687', '1394453687', '1');
INSERT INTO `onethink_forum_post_reply` VALUES ('2', '1', '6', '0', '<span style=\"font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;background-color:#FFFFFF;color:#222222;font-size:13px;line-height:22.100000381469727px;\">、用户池、支付、互联网金融，大数据和云端服务，以及外延的流量生态。而这个生态又不受腾讯所掌控。这对腾讯来说是非常危险的事情，超强的粘性场景一旦让用户习惯建立起来后，会极大的分流腾讯的用户。&nbsp;</span><br />\n<br />\n<span style=\"font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;background-color:#FFFFFF;color:#222222;font-size:13px;line-height:22.100000381469727px;\">因此也可以看到，2010年，腾讯开始多点投资布局电商，可以说在任何一个重要的垂直品类，在当时看来未来有可能往平台方向发展的垂直电商，均有腾讯投资的身影，腾讯已在外围拉起了一道防线。除此之外，腾讯把易迅转成了“亲儿子”，而“亲儿子”的策略很明显，就是死死拖着京东的后腿，试图延缓京东的发展时间。要知道，京东是很有可能成为TABLE之后又一个平台级的互联网公司，而绝不仅仅是一个平台级的电商公司。现在来看，京东的象限不仅是电商已有证明。这就像几个有核武器的国家，谁会希望又一个国家拥有核武器呢？</span><br />\n<br />\n<span style=\"font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;background-color:#FFFFFF;color:#222222;font-size:13px;line-height:22.100000381469727px;\">但腾讯现在已不用担心这个问题。</span><strong>原先的担心是电商这个重要的生活场景生态不在自己的掌控之内</strong><span style=\"font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;background-color:#FFFFFF;color:#222222;font-size:13px;line-height:22.100000381469727px;\">，但现在和未来是属于移动互联网时代的，而且，在这个时代里，腾讯还有了微信。&nbsp;</span><br />\n<br />\n<span style=\"font-family:\'Helvetica Neue\', Helvetica, Arial, sans-serif;background-color:#FFFFFF;color:#222222;font-size:13px;line-height:22.100000381469727px;\">在PC互联网，QQ客户端不具有网罗电商生态的能力，但</span><strong>在移动互联网，微信却在一步一步的渗透电商，网罗电商。&nbsp;</strong><br />', '1394454405', '1394454405', '1');
INSERT INTO `onethink_forum_post_reply` VALUES ('3', '1', '5', '0', 'hjuih uk. hiybolguil gui jl,ghil&nbsp;', '1394525055', '1394525055', '1');
INSERT INTO `onethink_forum_post_reply` VALUES ('4', '3', '6', '0', 'fdsafas', '1394586155', '1394586155', '1');
INSERT INTO `onethink_forum_post_reply` VALUES ('5', '2', '6', '0', 'fdasfdsa', '1394586166', '1394586166', '1');
INSERT INTO `onethink_forum_post_reply` VALUES ('6', '3', '6', '0', 'afds', '1394586432', '1394586432', '1');
INSERT INTO `onethink_forum_post_reply` VALUES ('7', '1', '9', '0', 'dfasfdsfhbd ashflfefdrefierg', '1394616139', '1394616139', '1');
INSERT INTO `onethink_forum_post_reply` VALUES ('8', '1', '8', '0', 'fdas', '1394617253', '1394617253', '1');
INSERT INTO `onethink_forum_post_reply` VALUES ('9', '1', '7', '0', 'fdasafdsfda', '1394617258', '1394617258', '1');
INSERT INTO `onethink_forum_post_reply` VALUES ('10', '3', '6', '0', '顶', '1394687451', '1394687451', '1');
INSERT INTO `onethink_forum_post_reply` VALUES ('11', '3', '11', '0', '下载地址：&nbsp;<a class=\"ke-insertfile\" href=\"/op/Uploads/Editor/2014-03-13/53215c2564584.jpg\" target=\"_blank\">/op/Uploads/Editor/2014-03-13/53215c2564584.jpg</a>', '1394695218', '1394695218', '1');
INSERT INTO `onethink_forum_post_reply` VALUES ('12', '14', '6', '0', 'fdsaafdsfdasdfasfdas', '1394759023', '1394759023', '1');

-- -----------------------------
-- Table structure for `onethink_hooks`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_hooks`;
CREATE TABLE `onethink_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text NOT NULL COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_hooks`
-- -----------------------------
INSERT INTO `onethink_hooks` VALUES ('1', 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '0', '');
INSERT INTO `onethink_hooks` VALUES ('2', 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', '1', '0', 'ReturnTop');
INSERT INTO `onethink_hooks` VALUES ('3', 'documentEditForm', '添加编辑表单的 扩展内容钩子', '1', '0', 'Attachment');
INSERT INTO `onethink_hooks` VALUES ('4', 'documentDetailAfter', '文档末尾显示', '1', '0', 'Attachment,SocialComment,Avatar,Tianyi');
INSERT INTO `onethink_hooks` VALUES ('5', 'documentDetailBefore', '页面内容前显示用钩子', '1', '0', '');
INSERT INTO `onethink_hooks` VALUES ('6', 'documentSaveComplete', '保存文档数据后的扩展钩子', '2', '0', 'Attachment');
INSERT INTO `onethink_hooks` VALUES ('7', 'documentEditFormContent', '添加编辑表单的内容显示钩子', '1', '0', 'Editor');
INSERT INTO `onethink_hooks` VALUES ('8', 'adminArticleEdit', '后台内容编辑页编辑器', '1', '1378982734', 'EditorForAdmin');
INSERT INTO `onethink_hooks` VALUES ('13', 'AdminIndex', '首页小格子个性化显示', '1', '1382596073', 'SiteStat,SystemInfo,DevTeam');
INSERT INTO `onethink_hooks` VALUES ('14', 'topicComment', '评论提交方式扩展钩子。', '1', '1380163518', 'Editor');
INSERT INTO `onethink_hooks` VALUES ('16', 'app_begin', '应用开始', '2', '1384481614', '');

-- -----------------------------
-- Table structure for `onethink_member`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_member`;
CREATE TABLE `onethink_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  `signature` text NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- -----------------------------
-- Records of `onethink_member`
-- -----------------------------
INSERT INTO `onethink_member` VALUES ('1', 'admin', '0', '0000-00-00', '', '20', '36', '0', '1394258721', '0', '1394760767', '1', 'dfasafdsdfs');
INSERT INTO `onethink_member` VALUES ('2', 'yixiao2020', '0', '0000-00-00', '', '10', '3', '3232267009', '1394586237', '0', '1394599654', '1', '');
INSERT INTO `onethink_member` VALUES ('3', 'test', '0', '0000-00-00', '', '20', '7', '0', '1394586414', '0', '1394758275', '1', '');
INSERT INTO `onethink_member` VALUES ('14', '左手悲伤', '0', '0000-00-00', '', '10', '1', '0', '1394759012', '0', '1394759012', '1', '');

-- -----------------------------
-- Table structure for `onethink_menu`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_menu`;
CREATE TABLE `onethink_menu` (
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
) ENGINE=MyISAM AUTO_INCREMENT=129 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_menu`
-- -----------------------------
INSERT INTO `onethink_menu` VALUES ('1', '首页', '0', '1', 'Index/index', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('2', '内容', '0', '2', 'Article/mydocument', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('3', '文档列表', '2', '0', 'article/index', '1', '', '内容', '0');
INSERT INTO `onethink_menu` VALUES ('4', '新增', '3', '0', 'article/add', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('5', '编辑', '3', '0', 'article/edit', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('6', '改变状态', '3', '0', 'article/setStatus', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('7', '保存', '3', '0', 'article/update', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('8', '保存草稿', '3', '0', 'article/autoSave', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('9', '移动', '3', '0', 'article/move', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('10', '复制', '3', '0', 'article/copy', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('11', '粘贴', '3', '0', 'article/paste', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('12', '导入', '3', '0', 'article/batchOperate', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('13', '回收站', '2', '0', 'article/recycle', '1', '', '内容', '0');
INSERT INTO `onethink_menu` VALUES ('14', '还原', '13', '0', 'article/permit', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('15', '清空', '13', '0', 'article/clear', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('16', '用户', '0', '3', 'User/index', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('17', '用户信息', '16', '0', 'User/index', '0', '', '用户管理', '0');
INSERT INTO `onethink_menu` VALUES ('18', '新增用户', '17', '0', 'User/add', '0', '添加新用户', '', '0');
INSERT INTO `onethink_menu` VALUES ('19', '用户行为', '16', '0', 'User/action', '0', '', '行为管理', '0');
INSERT INTO `onethink_menu` VALUES ('20', '新增用户行为', '19', '0', 'User/addaction', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('21', '编辑用户行为', '19', '0', 'User/editaction', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('22', '保存用户行为', '19', '0', 'User/saveAction', '0', '\"用户->用户行为\"保存编辑和新增的用户行为', '', '0');
INSERT INTO `onethink_menu` VALUES ('23', '变更行为状态', '19', '0', 'User/setStatus', '0', '\"用户->用户行为\"中的启用,禁用和删除权限', '', '0');
INSERT INTO `onethink_menu` VALUES ('24', '禁用会员', '19', '0', 'User/changeStatus?method=forbidUser', '0', '\"用户->用户信息\"中的禁用', '', '0');
INSERT INTO `onethink_menu` VALUES ('25', '启用会员', '19', '0', 'User/changeStatus?method=resumeUser', '0', '\"用户->用户信息\"中的启用', '', '0');
INSERT INTO `onethink_menu` VALUES ('26', '删除会员', '19', '0', 'User/changeStatus?method=deleteUser', '0', '\"用户->用户信息\"中的删除', '', '0');
INSERT INTO `onethink_menu` VALUES ('27', '权限管理', '16', '0', 'AuthManager/index', '0', '', '用户管理', '0');
INSERT INTO `onethink_menu` VALUES ('28', '删除', '27', '0', 'AuthManager/changeStatus?method=deleteGroup', '0', '删除用户组', '', '0');
INSERT INTO `onethink_menu` VALUES ('29', '禁用', '27', '0', 'AuthManager/changeStatus?method=forbidGroup', '0', '禁用用户组', '', '0');
INSERT INTO `onethink_menu` VALUES ('30', '恢复', '27', '0', 'AuthManager/changeStatus?method=resumeGroup', '0', '恢复已禁用的用户组', '', '0');
INSERT INTO `onethink_menu` VALUES ('31', '新增', '27', '0', 'AuthManager/createGroup', '0', '创建新的用户组', '', '0');
INSERT INTO `onethink_menu` VALUES ('32', '编辑', '27', '0', 'AuthManager/editGroup', '0', '编辑用户组名称和描述', '', '0');
INSERT INTO `onethink_menu` VALUES ('33', '保存用户组', '27', '0', 'AuthManager/writeGroup', '0', '新增和编辑用户组的\"保存\"按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('34', '授权', '27', '0', 'AuthManager/group', '0', '\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组', '', '0');
INSERT INTO `onethink_menu` VALUES ('35', '访问授权', '27', '0', 'AuthManager/access', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('36', '成员授权', '27', '0', 'AuthManager/user', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('37', '解除授权', '27', '0', 'AuthManager/removeFromGroup', '0', '\"成员授权\"列表页内的解除授权操作按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('38', '保存成员授权', '27', '0', 'AuthManager/addToGroup', '0', '\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)', '', '0');
INSERT INTO `onethink_menu` VALUES ('39', '分类授权', '27', '0', 'AuthManager/category', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('40', '保存分类授权', '27', '0', 'AuthManager/addToCategory', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('41', '模型授权', '27', '0', 'AuthManager/modelauth', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('42', '保存模型授权', '27', '0', 'AuthManager/addToModel', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `onethink_menu` VALUES ('43', '扩展', '0', '6', 'Addons/index', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('44', '插件管理', '43', '1', 'Addons/index', '0', '', '扩展', '0');
INSERT INTO `onethink_menu` VALUES ('45', '创建', '44', '0', 'Addons/create', '0', '服务器上创建插件结构向导', '', '0');
INSERT INTO `onethink_menu` VALUES ('46', '检测创建', '44', '0', 'Addons/checkForm', '0', '检测插件是否可以创建', '', '0');
INSERT INTO `onethink_menu` VALUES ('47', '预览', '44', '0', 'Addons/preview', '0', '预览插件定义类文件', '', '0');
INSERT INTO `onethink_menu` VALUES ('48', '快速生成插件', '44', '0', 'Addons/build', '0', '开始生成插件结构', '', '0');
INSERT INTO `onethink_menu` VALUES ('49', '设置', '44', '0', 'Addons/config', '0', '设置插件配置', '', '0');
INSERT INTO `onethink_menu` VALUES ('50', '禁用', '44', '0', 'Addons/disable', '0', '禁用插件', '', '0');
INSERT INTO `onethink_menu` VALUES ('51', '启用', '44', '0', 'Addons/enable', '0', '启用插件', '', '0');
INSERT INTO `onethink_menu` VALUES ('52', '安装', '44', '0', 'Addons/install', '0', '安装插件', '', '0');
INSERT INTO `onethink_menu` VALUES ('53', '卸载', '44', '0', 'Addons/uninstall', '0', '卸载插件', '', '0');
INSERT INTO `onethink_menu` VALUES ('54', '更新配置', '44', '0', 'Addons/saveconfig', '0', '更新插件配置处理', '', '0');
INSERT INTO `onethink_menu` VALUES ('55', '插件后台列表', '44', '0', 'Addons/adminList', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('56', 'URL方式访问插件', '44', '0', 'Addons/execute', '0', '控制是否有权限通过url访问插件控制器方法', '', '0');
INSERT INTO `onethink_menu` VALUES ('57', '钩子管理', '43', '2', 'Addons/hooks', '0', '', '扩展', '0');
INSERT INTO `onethink_menu` VALUES ('58', '模型管理', '68', '3', 'Model/index', '0', '', '系统设置', '0');
INSERT INTO `onethink_menu` VALUES ('59', '新增', '58', '0', 'model/add', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('60', '编辑', '58', '0', 'model/edit', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('61', '改变状态', '58', '0', 'model/setStatus', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('62', '保存数据', '58', '0', 'model/update', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('63', '属性管理', '68', '0', 'Attribute/index', '1', '网站属性配置。', '', '0');
INSERT INTO `onethink_menu` VALUES ('64', '新增', '63', '0', 'Attribute/add', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('65', '编辑', '63', '0', 'Attribute/edit', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('66', '改变状态', '63', '0', 'Attribute/setStatus', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('67', '保存数据', '63', '0', 'Attribute/update', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('68', '系统', '0', '4', 'Config/group', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('69', '网站设置', '68', '1', 'Config/group', '0', '', '系统设置', '0');
INSERT INTO `onethink_menu` VALUES ('70', '配置管理', '68', '4', 'Config/index', '0', '', '系统设置', '0');
INSERT INTO `onethink_menu` VALUES ('71', '编辑', '70', '0', 'Config/edit', '0', '新增编辑和保存配置', '', '0');
INSERT INTO `onethink_menu` VALUES ('72', '删除', '70', '0', 'Config/del', '0', '删除配置', '', '0');
INSERT INTO `onethink_menu` VALUES ('73', '新增', '70', '0', 'Config/add', '0', '新增配置', '', '0');
INSERT INTO `onethink_menu` VALUES ('74', '保存', '70', '0', 'Config/save', '0', '保存配置', '', '0');
INSERT INTO `onethink_menu` VALUES ('75', '菜单管理', '68', '5', 'Menu/index', '0', '', '系统设置', '0');
INSERT INTO `onethink_menu` VALUES ('76', '导航管理', '68', '6', 'Channel/index', '0', '', '系统设置', '0');
INSERT INTO `onethink_menu` VALUES ('77', '新增', '76', '0', 'Channel/add', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('78', '编辑', '76', '0', 'Channel/edit', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('79', '删除', '76', '0', 'Channel/del', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('80', '分类管理', '68', '2', 'Category/index', '0', '', '系统设置', '0');
INSERT INTO `onethink_menu` VALUES ('81', '编辑', '80', '0', 'Category/edit', '0', '编辑和保存栏目分类', '', '0');
INSERT INTO `onethink_menu` VALUES ('82', '新增', '80', '0', 'Category/add', '0', '新增栏目分类', '', '0');
INSERT INTO `onethink_menu` VALUES ('83', '删除', '80', '0', 'Category/remove', '0', '删除栏目分类', '', '0');
INSERT INTO `onethink_menu` VALUES ('84', '移动', '80', '0', 'Category/operate/type/move', '0', '移动栏目分类', '', '0');
INSERT INTO `onethink_menu` VALUES ('85', '合并', '80', '0', 'Category/operate/type/merge', '0', '合并栏目分类', '', '0');
INSERT INTO `onethink_menu` VALUES ('86', '备份数据库', '68', '0', 'Database/index?type=export', '0', '', '数据备份', '0');
INSERT INTO `onethink_menu` VALUES ('87', '备份', '86', '0', 'Database/export', '0', '备份数据库', '', '0');
INSERT INTO `onethink_menu` VALUES ('88', '优化表', '86', '0', 'Database/optimize', '0', '优化数据表', '', '0');
INSERT INTO `onethink_menu` VALUES ('89', '修复表', '86', '0', 'Database/repair', '0', '修复数据表', '', '0');
INSERT INTO `onethink_menu` VALUES ('90', '还原数据库', '68', '0', 'Database/index?type=import', '0', '', '数据备份', '0');
INSERT INTO `onethink_menu` VALUES ('91', '恢复', '90', '0', 'Database/import', '0', '数据库恢复', '', '0');
INSERT INTO `onethink_menu` VALUES ('92', '删除', '90', '0', 'Database/del', '0', '删除备份文件', '', '0');
INSERT INTO `onethink_menu` VALUES ('93', '其他', '0', '5', 'other', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('96', '新增', '75', '0', 'Menu/add', '0', '', '系统设置', '0');
INSERT INTO `onethink_menu` VALUES ('98', '编辑', '75', '0', 'Menu/edit', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('104', '下载管理', '102', '0', 'Think/lists?model=download', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('105', '配置管理', '102', '0', 'Think/lists?model=config', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('106', '行为日志', '16', '0', 'Action/actionlog', '0', '', '行为管理', '0');
INSERT INTO `onethink_menu` VALUES ('108', '修改密码', '16', '0', 'User/updatePassword', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('109', '修改昵称', '16', '0', 'User/updateNickname', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('110', '查看行为日志', '106', '0', 'action/edit', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('112', '新增数据', '58', '0', 'think/add', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('113', '编辑数据', '58', '0', 'think/edit', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('114', '导入', '75', '0', 'Menu/import', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('115', '生成', '58', '0', 'Model/generate', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('116', '新增钩子', '57', '0', 'Addons/addHook', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('117', '编辑钩子', '57', '0', 'Addons/edithook', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('118', '文档排序', '3', '0', 'Article/sort', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('119', '排序', '70', '0', 'Config/sort', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('120', '排序', '75', '0', 'Menu/sort', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('121', '排序', '76', '0', 'Channel/sort', '1', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('122', '讨论区', '0', '7', '/Admin/Forum/index', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('123', '微博', '0', '8', '/Admin/Weibo/index', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('124', '贴吧管理', '122', '0', 'Forum/forum', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('125', '帖子管理', '122', '0', 'Forum/post', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('126', '编辑／发表帖子', '124', '0', 'Forum/editForum', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('127', 'edit pots', '125', '0', 'Forum/editPost', '0', '', '', '0');
INSERT INTO `onethink_menu` VALUES ('128', '排序', '124', '0', 'Forum/sortForum', '0', '', '', '0');

-- -----------------------------
-- Table structure for `onethink_message`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_message`;
CREATE TABLE `onethink_message` (
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='OnePlus新增消息表';

-- -----------------------------
-- Records of `onethink_message`
-- -----------------------------
INSERT INTO `onethink_message` VALUES ('1', '2', '1', '您的微博有人评论了', '李小冉说，I付出款啊啊啊啊 <img src=\"a\"/>', '1394447649', '1', '1', '1394715268', '');
INSERT INTO `onethink_message` VALUES ('2', '2', '1', '你的帖子有人回复了', '点对点', '1394447649', '1', '1', '1394714956', '');
INSERT INTO `onethink_message` VALUES ('3', '2', '1', '你的帖子有人回复了', '点对点', '1394447649', '1', '1', '0', '');
INSERT INTO `onethink_message` VALUES ('4', '2', '1', '你的帖子有人回复了', '点对点', '1394447649', '1', '1', '1394715486', '');
INSERT INTO `onethink_message` VALUES ('5', '2', '1', '你的帖子有人回复了', '点对点', '1394447649', '2', '1', '1394715515', '');
INSERT INTO `onethink_message` VALUES ('6', '2', '1', '你的帖子有人回复了', '点对点', '1394447649', '2', '0', '1394715628', '');

-- -----------------------------
-- Table structure for `onethink_model`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_model`;
CREATE TABLE `onethink_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text NOT NULL COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text NOT NULL COMMENT '属性列表（表的字段）',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text NOT NULL COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

-- -----------------------------
-- Records of `onethink_model`
-- -----------------------------
INSERT INTO `onethink_model` VALUES ('1', 'document', '基础文档', '0', '', '1', '{\"1\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\"]}', '1:基础', '', '', '', '', 'id:编号\r\ntitle:标题:article/index?cate_id=[category_id]&pid=[id]\r\ntype|get_document_type:类型\r\nlevel:优先级\r\nupdate_time|time_format:最后更新\r\nstatus_text:状态\r\nview:浏览\r\nid:操作:[EDIT]&cate_id=[category_id]|编辑,article/setstatus?status=-1&ids=[id]|删除', '0', '', '', '1383891233', '1384507827', '1', 'MyISAM');
INSERT INTO `onethink_model` VALUES ('2', 'article', '文章', '1', '', '1', '{\"1\":[\"3\",\"24\",\"2\",\"5\"],\"2\":[\"9\",\"13\",\"19\",\"10\",\"12\",\"16\",\"17\",\"26\",\"20\",\"14\",\"11\",\"25\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题:article/edit?cate_id=[category_id]&id=[id]\r\ncontent:内容', '0', '', '', '1383891243', '1387260622', '1', 'MyISAM');
INSERT INTO `onethink_model` VALUES ('3', 'download', '下载', '1', '', '1', '{\"1\":[\"3\",\"28\",\"30\",\"32\",\"2\",\"5\",\"31\"],\"2\":[\"13\",\"10\",\"27\",\"9\",\"12\",\"16\",\"17\",\"19\",\"11\",\"20\",\"14\",\"29\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');

-- -----------------------------
-- Table structure for `onethink_picture`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_picture`;
CREATE TABLE `onethink_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- -----------------------------
-- Table structure for `onethink_tianyi_verify`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_tianyi_verify`;
CREATE TABLE `onethink_tianyi_verify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(20) NOT NULL,
  `verify` varchar(6) NOT NULL,
  `expire` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_tianyi_verify`
-- -----------------------------
INSERT INTO `onethink_tianyi_verify` VALUES ('1', '13732254927', '143543', '1394522582', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('2', '13732254927', '747140', '1394522619', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('3', '13732254927', '837461', '1394522647', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('4', '13732254927', '864520', '1394522673', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('5', '13732254927', '369331', '1394522708', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('6', '13732254927', '629711', '1394522717', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('7', '13732254927', '330304', '1394522840', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('8', '13732254927', '493424', '1394522870', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('9', '13732254927', '819244', '1394522905', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('10', '13732254927', '063775', '1394522915', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('11', '13732254927', '187999', '1394522936', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('12', '13732254927', '530787', '1394522993', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('13', '13732254927', '797310', '1394523024', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('14', '13732254927', '885041', '1394523048', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('15', '13732254927', '278108', '1394687174', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('16', '13732254927', '812405', '1394687232', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('17', '13732254927', '069639', '1394687240', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('18', '13732254927', '513097', '1394687248', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('19', '13732254927', '573854', '1394687255', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('20', '13732254927', '352668', '1394687261', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('21', '13732254927', '565052', '1394687276', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('22', '13732254927', '233743', '1394687742', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('23', '13732254927', '984134', '1394687758', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('24', '13732254927', '264856', '1394687807', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('25', '13732254927', '739251', '1394687819', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('26', '13732254927', '771797', '1394688129', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('27', '13732254927', '123456', '1394688141', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('28', '13732254927', '123456', '1394688150', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('29', '13732254927', '123456', '1394688165', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('30', '13732254927', '123456', '1394688172', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('31', '13732254927', '123456', '1394688174', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('32', '13732254927', '123456', '1394688174', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('33', '13732254927', '123456', '1394688233', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('34', '13732254927', '123456', '1394688258', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('35', '13732254927', '123456', '1394688313', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('36', '13732254927', '123456', '1394688343', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('37', '13732254927', '123456', '1394688416', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('38', '13732254927', '123456', '1394688426', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('39', '13732254927', '629748', '1394758402', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('40', '13732254927', '055330', '1394758478', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('41', '13732254927', '577465', '1394761740', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('42', '13732254927', '725539', '1394761863', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('43', '13732254927', '444274', '1394761890', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('44', '13732254927', '545084', '1394761932', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('45', '13732254927', '254368', '1394762042', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('46', '13732254927', '283968', '1394762212', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('47', '13732254927', '123456', '1394762236', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('48', '13732254927', '123456', '1394762372', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('49', '13732254927', '123456', '1394763262', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('50', '13732254927', '123456', '1394763292', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('51', '13732254927', '123456', '1394763311', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('52', '13732254928', '123456', '1394763331', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('53', '13732254928', '123456', '1394763578', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('54', '13732254928', '123456', '1394763591', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('55', '13732254928', '123456', '1394763612', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('56', '13732254928', '123456', '1394763619', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('57', '13732254928', '123456', '1394763625', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('58', '13732254927', '123456', '1394763655', '-1');
INSERT INTO `onethink_tianyi_verify` VALUES ('59', '13732254928', '123456', '1394763668', '-1');

-- -----------------------------
-- Table structure for `onethink_ucenter_admin`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_ucenter_admin`;
CREATE TABLE `onethink_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- -----------------------------
-- Records of `onethink_ucenter_admin`
-- -----------------------------
INSERT INTO `onethink_ucenter_admin` VALUES ('1', '1', '1');
INSERT INTO `onethink_ucenter_admin` VALUES ('2', '1', '1');

-- -----------------------------
-- Table structure for `onethink_ucenter_app`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_ucenter_app`;
CREATE TABLE `onethink_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用表';


-- -----------------------------
-- Table structure for `onethink_ucenter_member`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_ucenter_member`;
CREATE TABLE `onethink_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- -----------------------------
-- Records of `onethink_ucenter_member`
-- -----------------------------
INSERT INTO `onethink_ucenter_member` VALUES ('1', 'admin', 'b8ad5ba41e19f520e702a7790169529e', 'admin@admin2.com', '123456789', '1394522230', '0', '1394760767', '0', '1394522230', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('2', 'yixiao2020', '2aff5e93d37aaae383f8e5a2ed57a743', 'yixiao2020@qq.com', '', '1394586228', '3232267009', '1394599654', '0', '1394586228', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('3', 'test', 'b8ad5ba41e19f520e702a7790169529e', 'fdsafasdfas@fdasf.com', '13732254927', '1394586408', '0', '1394758275', '0', '1394586408', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('4', 'monoly', 'b53a2c058d1153ca02236cd65bcf7843', '2391142234@qq.com', '', '1394623418', '242050969', '1394712407', '242053097', '1394623418', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('5', 'willy_wx', 'e48ccb5cdedcf3b668652b37cc1c1968', 'willy_wx@163.com', '', '1394624235', '3670902657', '1394624250', '3670902657', '1394624235', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('6', 'lg', '0756aef07aa41e88feb6a22848757084', '826319429@qq.com', '', '1394629521', '1881571206', '1394629541', '1881571206', '1394629521', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('7', 'qqqq', '9d2cb960a94b0dede7eac0c58187101d', 'qqq@sss.com', '', '1394631495', '1034099866', '1394631512', '1034099866', '1394631495', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('8', 'goudan', '36bcdd7d6175f265e1067400ecfb906a', '673286882@qq.com', '', '1394638304', '987136374', '1394638325', '987136374', '1394638304', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('9', 'kekk', '9343f68c9c6b872887007bb9dec85869', '12331qq@q.com', '', '1394641902', '2059479920', '0', '0', '1394641902', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('10', 'kashu', '9343f68c9c6b872887007bb9dec85869', '123123@1231231231.com', '', '1394641967', '2059479920', '1394720644', '1884716413', '1394641967', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('11', '82331085', '0bb9e1ecc970236881c69259a1a70b64', '82331085@163.com', '', '1394647420', '1697180245', '1394647438', '1697180245', '1394647420', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('12', 'biaoget', '49b48f3d9b838b92214bf1857349f6b0', 'biaogets@qq.com', '', '1394669264', '2946193175', '1394669273', '2946193175', '1394669264', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('13', '小绵羊', '73a03f80cec8239ba5d6fd7cc638bf68', '382392150@qq.com', '', '1394677933', '3027296499', '1394677957', '3027296499', '1394677933', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('14', '左手悲伤', 'b8ad5ba41e19f520e702a7790169529e', '348566931@qq.com', '13732254928', '1394686982', '1999774205', '1394759012', '0', '1394686982', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('15', 'lanxera', 'abceae4b2359d445a3104c516d4cc975', 'lanxera@yeah.net', '', '1394689764', '1962854489', '1394689780', '1962854489', '1394689764', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('16', 'maydole', '69a3b5dfc830b24f0253d13096358975', '16565@qq.com', '', '1394693214', '3661763473', '1394716694', '1879435804', '1394693214', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('17', 'kuwoo', '4ab253205e6d20877a14356c42c3cdfa', 'wangkun218@yeah.net', '', '1394693486', '30053891', '1394693502', '30053891', '1394693486', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('18', 'mx2118', '77fd366dcdc6ee9502de536bc9a9fac7', 'zing.l@163.com', '', '1394705233', '2105512993', '1394705248', '2105512993', '1394705233', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('19', 'yo846tt', '2063b5d96bd49ff6e82d9595f66781a1', 'yo846tt@qq.com', '', '1394715891', '1701325056', '1394715930', '1701325056', '1394715891', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('20', 'variya', '3d4cbfd304ff541cad43f4b6c60020ba', 'variya@qq.com', '', '1394716327', '2876862554', '1394716360', '2876862554', '1394716327', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('21', 'Joy', '691aa77796650a10f12b72f64969b5b7', 'joy@cnunk.com', '', '1394716427', '3657768596', '1394716439', '3657768596', '1394716427', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('22', 'awen', 'ea9a1b1f93f9b216867136b6d46107b7', '403951711@qq.com', '', '1394717284', '1710566379', '1394719544', '1710566379', '1394717284', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('23', 'coolre', '72e3ef1128c066a0e6d88a19cb700886', 'coolre@aliyun.com', '', '1394726336', '606119044', '1394726357', '606119044', '1394726336', '1');
INSERT INTO `onethink_ucenter_member` VALUES ('24', 'ouyangxue88', 'b41a5bb046b684d86c6d037f0172ab7a', '804393659@qq.com', '', '1394736330', '2936561404', '1394736352', '2936561404', '1394736330', '1');

-- -----------------------------
-- Table structure for `onethink_ucenter_setting`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_ucenter_setting`;
CREATE TABLE `onethink_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';


-- -----------------------------
-- Table structure for `onethink_url`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_url`;
CREATE TABLE `onethink_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表';


-- -----------------------------
-- Table structure for `onethink_userdata`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_userdata`;
CREATE TABLE `onethink_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- -----------------------------
-- Table structure for `onethink_weibo`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_weibo`;
CREATE TABLE `onethink_weibo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `comment_count` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_weibo`
-- -----------------------------
INSERT INTO `onethink_weibo` VALUES ('52', '1', 'd', '1394510040', '1', '1');
INSERT INTO `onethink_weibo` VALUES ('53', '1', 'fcdf', '1394510045', '4', '1');
INSERT INTO `onethink_weibo` VALUES ('54', '1', 'fddfasdfadfasdfascdfasadasdfasdfas', '1394514329', '0', '1');
INSERT INTO `onethink_weibo` VALUES ('55', '1', '231123', '1394520295', '0', '1');
INSERT INTO `onethink_weibo` VALUES ('56', '1', '21323', '1394520306', '2', '1');
INSERT INTO `onethink_weibo` VALUES ('57', '1', '文档', '1394525892', '3', '1');
INSERT INTO `onethink_weibo` VALUES ('58', '3', 'fdsafads', '1394587116', '1', '1');
INSERT INTO `onethink_weibo` VALUES ('59', '2', '123213', '1394605112', '2', '1');
INSERT INTO `onethink_weibo` VALUES ('60', '14', 'fdasfsd', '1394759208', '1', '1');

-- -----------------------------
-- Table structure for `onethink_weibo_comment`
-- -----------------------------
DROP TABLE IF EXISTS `onethink_weibo_comment`;
CREATE TABLE `onethink_weibo_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `weibo_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- -----------------------------
-- Records of `onethink_weibo_comment`
-- -----------------------------
INSERT INTO `onethink_weibo_comment` VALUES ('40', '1', '53', '123\n', '1394510104', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('41', '1', '53', 'fdasdsf', '1394514178', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('42', '1', '53', 'dfass', '1394514180', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('43', '1', '56', '21323', '1394520309', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('44', '1', '53', '我打', '1394525896', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('45', '1', '52', '大', '1394525900', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('46', '3', '57', 'fdsafs', '1394587120', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('47', '3', '56', 'fdsafsd', '1394587125', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('48', '2', '57', 'dawwa', '1394603996', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('49', '2', '57', 'czczx', '1394604000', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('50', '1', '59', 'fdasdf', '1394615065', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('51', '1', '59', 'fadsdfsdfs', '1394615070', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('52', '14', '60', 'dfdass', '1394759211', '1');
INSERT INTO `onethink_weibo_comment` VALUES ('53', '14', '58', 'fdafs', '1394759215', '1');
