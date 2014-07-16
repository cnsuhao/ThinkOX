
ALTER TABLE  `thinkox_member` ADD  `pos_province` INT NOT NULL;
ALTER TABLE  `thinkox_member` ADD  `pos_city` INT NOT NULL;
ALTER TABLE  `thinkox_member` ADD  `pos_district` INT NOT NULL;
ALTER TABLE  `thinkox_member` ADD  `pos_community` INT NOT NULL;
ALTER TABLE  `thinkox_member` ADD  `tox_money` INT NOT NULL;

ALTER TABLE  `thinkox_field_group` ADD  `visiable` TINYINT( 4 ) NOT NULL DEFAULT  '1';
ALTER TABLE  `thinkox_weibo` ADD  `repost_count` INT NOT NULL;


/*——————————————————————商城——————————————————————————————*/

CREATE TABLE IF NOT EXISTS `thinkox_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(25) NOT NULL COMMENT '商品名称',
  `goods_ico` int(11) NOT NULL COMMENT '商品图标',
  `goods_introduct` varchar(100) NOT NULL COMMENT '商品简介',
  `goods_detail` varchar(1000) NOT NULL COMMENT '商品详情',
  `tox_money_need` int(11) NOT NULL COMMENT '需要金币数',
  `goods_num` int(11) NOT NULL COMMENT '商品余量',
  `changetime` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '状态，-1：删除；0：禁用；1：启用',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `category_id` int(11) NOT NULL,
  `is_new` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否为新品',
  `sell_num` int(11) NOT NULL DEFAULT '0' COMMENT '已出售量',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='商品信息' AUTO_INCREMENT=13 ;


CREATE TABLE IF NOT EXISTS `thinkox_shop_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `address` varchar(200) NOT NULL,
  `zipcode` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `change_time` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `phone` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED AUTO_INCREMENT=3 ;


CREATE TABLE IF NOT EXISTS `thinkox_shop_buy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `goods_num` int(11) NOT NULL COMMENT '购买数量',
  `status` tinyint(4) NOT NULL COMMENT '状态，-1：未领取；0：申请领取；1：已领取',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `createtime` int(11) NOT NULL COMMENT '购买时间',
  `gettime` int(11) NOT NULL COMMENT '交易结束时间',
  `address_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='购买商品信息表' AUTO_INCREMENT=55 ;


CREATE TABLE IF NOT EXISTS `thinkox_shop_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;


INSERT INTO `thinkox_shop_category` (`id`, `title`, `create_time`, `update_time`, `status`, `pid`, `sort`) VALUES
(1, '奖品', 1403507725, 1403507717, 1, 0, 0),
(2, '实体', 1403507752, 1403507745, 1, 0, 0);

CREATE TABLE IF NOT EXISTS `thinkox_shop_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ename` varchar(25) NOT NULL COMMENT '标识',
  `cname` varchar(25) NOT NULL COMMENT '中文名称',
  `changetime` int(11) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='商店配置' AUTO_INCREMENT=3 ;


INSERT INTO `thinkox_shop_config` (`id`, `ename`, `cname`, `changetime`) VALUES
(1, 'tox_money', '金币', 1403507688),
(2, 'min_sell_num', '10', 1403489181);


CREATE TABLE IF NOT EXISTS `thinkox_shop_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `message` varchar(500) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

CREATE TABLE IF NOT EXISTS `thinkox_shop_see` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;





/*————————————————————消息提示————————————————————*/
CREATE TABLE IF NOT EXISTS `thinkox_talk_push` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '接收推送的用户id',
  `source_id` int(11) NOT NULL COMMENT '来源id',
  `create_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '状态，0为未提示，1为未点击，-1为已点击',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='对话推送表' AUTO_INCREMENT=78 ;

DROP TABLE IF EXISTS `thinkox_talk_message_push`;
CREATE TABLE IF NOT EXISTS `thinkox_talk_message_push` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `source_id` int(11) NOT NULL COMMENT '来源消息id',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `status` tinyint(4) NOT NULL,
  `talk_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=gbk COMMENT='会话消息推送通知' AUTO_INCREMENT=40 ;





/*————————————————————活动——————————————————————*/
DROP TABLE IF EXISTS `thinkox_event`;
CREATE TABLE IF NOT EXISTS `thinkox_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '发起人',
  `title` varchar(255) NOT NULL COMMENT '活动名称',
  `explain` text NOT NULL COMMENT '详细内容',
  `sTime` int(11) NOT NULL COMMENT '活动开始时间',
  `eTime` int(11) NOT NULL COMMENT '活动结束时间',
  `address` varchar(255) NOT NULL COMMENT '活动地点',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `limitCount` int(11) NOT NULL COMMENT '限制人数',
  `cover_id` int(11) NOT NULL COMMENT '封面ID',
  `deadline` int(11) NOT NULL,
  `attentionCount` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `reply_count` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `signCount` int(11) NOT NULL,
  `is_recommend` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `thinkox_event_attend`;
CREATE TABLE IF NOT EXISTS `thinkox_event_attend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `creat_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '0为报名，1为参加',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `thinkox_event_type`;
CREATE TABLE IF NOT EXISTS `thinkox_event_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `allow_post` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


/*——————————————专辑——————————————————*/
ALTER TABLE  `thinkox_issue_content` ADD  `url` VARCHAR( 200 ) NOT NULL;


/*——————————————————————后台导航菜单————————————————————*/
DROP TABLE IF EXISTS `thinkox_menu`;
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=216 ;

INSERT INTO `thinkox_menu` (`id`, `title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`) VALUES
(1, '首页', 0, 1, 'Index/index', 0, '', '', 0),
(2, '博客', 0, 2, 'Article/mydocument', 0, '', '', 0),
(3, '文档列表', 2, 0, 'article/index', 1, '', '内容', 0),
(4, '新增', 3, 0, 'article/add', 0, '', '', 0),
(5, '编辑', 3, 0, 'article/edit', 0, '', '', 0),
(6, '改变状态', 3, 0, 'article/setStatus', 0, '', '', 0),
(7, '保存', 3, 0, 'article/update', 0, '', '', 0),
(8, '保存草稿', 3, 0, 'article/autoSave', 0, '', '', 0),
(9, '移动', 3, 0, 'article/move', 0, '', '', 0),
(10, '复制', 3, 0, 'article/copy', 0, '', '', 0),
(11, '粘贴', 3, 0, 'article/paste', 0, '', '', 0),
(12, '导入', 3, 0, 'article/batchOperate', 0, '', '', 0),
(13, '回收站', 2, 0, 'article/recycle', 1, '', '内容', 0),
(14, '还原', 13, 0, 'article/permit', 0, '', '', 0),
(15, '清空', 13, 0, 'article/clear', 0, '', '', 0),
(16, '用户', 0, 3, 'User/index', 0, '', '', 0),
(17, '用户信息', 16, 0, 'User/index', 0, '', '用户管理', 0),
(18, '新增用户', 17, 0, 'User/add', 0, '添加新用户', '', 0),
(19, '用户行为', 16, 0, 'User/action', 0, '', '行为管理', 0),
(20, '新增用户行为', 19, 0, 'User/addaction', 0, '', '', 0),
(21, '编辑用户行为', 19, 0, 'User/editaction', 0, '', '', 0),
(22, '保存用户行为', 19, 0, 'User/saveAction', 0, '"用户->用户行为"保存编辑和新增的用户行为', '', 0),
(23, '变更行为状态', 19, 0, 'User/setStatus', 0, '"用户->用户行为"中的启用,禁用和删除权限', '', 0),
(24, '禁用会员', 19, 0, 'User/changeStatus?method=forbidUser', 0, '"用户->用户信息"中的禁用', '', 0),
(25, '启用会员', 19, 0, 'User/changeStatus?method=resumeUser', 0, '"用户->用户信息"中的启用', '', 0),
(26, '删除会员', 19, 0, 'User/changeStatus?method=deleteUser', 0, '"用户->用户信息"中的删除', '', 0),
(27, '权限管理', 16, 0, 'AuthManager/index', 0, '', '用户管理', 0),
(28, '删除', 27, 0, 'AuthManager/changeStatus?method=deleteGroup', 0, '删除用户组', '', 0),
(29, '禁用', 27, 0, 'AuthManager/changeStatus?method=forbidGroup', 0, '禁用用户组', '', 0),
(30, '恢复', 27, 0, 'AuthManager/changeStatus?method=resumeGroup', 0, '恢复已禁用的用户组', '', 0),
(31, '新增', 27, 0, 'AuthManager/createGroup', 0, '创建新的用户组', '', 0),
(32, '编辑', 27, 0, 'AuthManager/editGroup', 0, '编辑用户组名称和描述', '', 0),
(33, '保存用户组', 27, 0, 'AuthManager/writeGroup', 0, '新增和编辑用户组的"保存"按钮', '', 0),
(34, '授权', 27, 0, 'AuthManager/group', 0, '"后台 \\ 用户 \\ 用户信息"列表页的"授权"操作按钮,用于设置用户所属用户组', '', 0),
(35, '访问授权', 27, 0, 'AuthManager/access', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"访问授权"操作按钮', '', 0),
(36, '成员授权', 27, 0, 'AuthManager/user', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"成员授权"操作按钮', '', 0),
(37, '解除授权', 27, 0, 'AuthManager/removeFromGroup', 0, '"成员授权"列表页内的解除授权操作按钮', '', 0),
(38, '保存成员授权', 27, 0, 'AuthManager/addToGroup', 0, '"用户信息"列表页"授权"时的"保存"按钮和"成员授权"里右上角的"添加"按钮)', '', 0),
(39, '分类授权', 27, 0, 'AuthManager/category', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"分类授权"操作按钮', '', 0),
(40, '保存分类授权', 27, 0, 'AuthManager/addToCategory', 0, '"分类授权"页面的"保存"按钮', '', 0),
(41, '模型授权', 27, 0, 'AuthManager/modelauth', 0, '"后台 \\ 用户 \\ 权限管理"列表页的"模型授权"操作按钮', '', 0),
(42, '保存模型授权', 27, 0, 'AuthManager/addToModel', 0, '"分类授权"页面的"保存"按钮', '', 0),
(43, '扩展', 0, 998, 'Addons/index', 0, '', '', 0),
(44, '插件管理', 43, 1, 'Addons/index', 0, '', '扩展', 0),
(45, '创建', 44, 0, 'Addons/create', 0, '服务器上创建插件结构向导', '', 0),
(46, '检测创建', 44, 0, 'Addons/checkForm', 0, '检测插件是否可以创建', '', 0),
(47, '预览', 44, 0, 'Addons/preview', 0, '预览插件定义类文件', '', 0),
(48, '快速生成插件', 44, 0, 'Addons/build', 0, '开始生成插件结构', '', 0),
(49, '设置', 44, 0, 'Addons/config', 0, '设置插件配置', '', 0),
(50, '禁用', 44, 0, 'Addons/disable', 0, '禁用插件', '', 0),
(51, '启用', 44, 0, 'Addons/enable', 0, '启用插件', '', 0),
(52, '安装', 44, 0, 'Addons/install', 0, '安装插件', '', 0),
(53, '卸载', 44, 0, 'Addons/uninstall', 0, '卸载插件', '', 0),
(54, '更新配置', 44, 0, 'Addons/saveconfig', 0, '更新插件配置处理', '', 0),
(55, '插件后台列表', 44, 0, 'Addons/adminList', 0, '', '', 0),
(56, 'URL方式访问插件', 44, 0, 'Addons/execute', 0, '控制是否有权限通过url访问插件控制器方法', '', 0),
(57, '钩子管理', 43, 2, 'Addons/hooks', 0, '', '扩展', 0),
(58, '模型管理', 2, 3, 'Model/index', 0, '', '系统设置', 0),
(59, '新增', 58, 0, 'model/add', 0, '', '', 0),
(60, '编辑', 58, 0, 'model/edit', 0, '', '', 0),
(61, '改变状态', 58, 0, 'model/setStatus', 0, '', '', 0),
(62, '保存数据', 58, 0, 'model/update', 0, '', '', 0),
(63, '属性管理', 68, 0, 'Attribute/index', 1, '网站属性配置。', '', 0),
(64, '新增', 63, 0, 'Attribute/add', 0, '', '', 0),
(65, '编辑', 63, 0, 'Attribute/edit', 0, '', '', 0),
(66, '改变状态', 63, 0, 'Attribute/setStatus', 0, '', '', 0),
(67, '保存数据', 63, 0, 'Attribute/update', 0, '', '', 0),
(68, '系统', 0, 9999, 'Config/group', 0, '', '', 0),
(69, '网站设置', 68, 1, 'Config/group', 0, '', '系统设置', 0),
(70, '配置管理', 68, 4, 'Config/index', 0, '', '系统设置', 0),
(71, '编辑', 70, 0, 'Config/edit', 0, '新增编辑和保存配置', '', 0),
(72, '删除', 70, 0, 'Config/del', 0, '删除配置', '', 0),
(73, '新增', 70, 0, 'Config/add', 0, '新增配置', '', 0),
(74, '保存', 70, 0, 'Config/save', 0, '保存配置', '', 0),
(75, '菜单管理', 68, 5, 'Menu/index', 0, '', '系统设置', 0),
(76, '导航管理', 68, 6, 'Channel/index', 0, '', '系统设置', 0),
(77, '新增', 76, 0, 'Channel/add', 0, '', '', 0),
(78, '编辑', 76, 0, 'Channel/edit', 0, '', '', 0),
(79, '删除', 76, 0, 'Channel/del', 0, '', '', 0),
(80, '分类管理', 2, 2, 'Category/index', 0, '', '系统设置', 0),
(81, '编辑', 80, 0, 'Category/edit', 0, '编辑和保存栏目分类', '', 0),
(82, '新增', 80, 0, 'Category/add', 0, '新增栏目分类', '', 0),
(83, '删除', 80, 0, 'Category/remove', 0, '删除栏目分类', '', 0),
(84, '移动', 80, 0, 'Category/operate/type/move', 0, '移动栏目分类', '', 0),
(85, '合并', 80, 0, 'Category/operate/type/merge', 0, '合并栏目分类', '', 0),
(86, '备份数据库', 68, 20, 'Database/index?type=export', 0, '', '数据备份', 0),
(87, '备份', 86, 0, 'Database/export', 0, '备份数据库', '', 0),
(88, '优化表', 86, 0, 'Database/optimize', 0, '优化数据表', '', 0),
(89, '修复表', 86, 0, 'Database/repair', 0, '修复数据表', '', 0),
(90, '还原数据库', 68, 0, 'Database/index?type=import', 0, '', '数据备份', 0),
(91, '恢复', 90, 0, 'Database/import', 0, '数据库恢复', '', 0),
(92, '删除', 90, 0, 'Database/del', 0, '删除备份文件', '', 0),
(93, '其他', 0, 5, 'other', 1, '', '', 0),
(96, '新增', 75, 0, 'Menu/add', 0, '', '系统设置', 0),
(98, '编辑', 75, 0, 'Menu/edit', 0, '', '', 0),
(104, '下载管理', 102, 0, 'Think/lists?model=download', 0, '', '', 0),
(105, '配置管理', 102, 0, 'Think/lists?model=config', 0, '', '', 0),
(106, '行为日志', 16, 0, 'Action/actionlog', 0, '', '行为管理', 0),
(108, '修改密码', 16, 0, 'User/updatePassword', 1, '', '', 0),
(109, '修改昵称', 16, 0, 'User/updateNickname', 1, '', '', 0),
(110, '查看行为日志', 106, 0, 'action/edit', 1, '', '', 0),
(112, '新增数据', 58, 0, 'think/add', 1, '', '', 0),
(113, '编辑数据', 58, 0, 'think/edit', 1, '', '', 0),
(114, '导入', 75, 0, 'Menu/import', 0, '', '', 0),
(115, '生成', 58, 0, 'Model/generate', 0, '', '', 0),
(116, '新增钩子', 57, 0, 'Addons/addHook', 0, '', '', 0),
(117, '编辑钩子', 57, 0, 'Addons/edithook', 0, '', '', 0),
(118, '文档排序', 3, 0, 'Article/sort', 1, '', '', 0),
(119, '排序', 70, 0, 'Config/sort', 1, '', '', 0),
(120, '排序', 75, 0, 'Menu/sort', 1, '', '', 0),
(121, '排序', 76, 0, 'Channel/sort', 1, '', '', 0),
(122, '贴吧', 0, 7, 'Forum/index', 0, '', '', 0),
(123, '微博', 0, 8, 'Weibo/weibo', 0, '', '', 0),
(124, '板块管理', 122, 1, 'Forum/forum', 0, '', '板块', 0),
(125, '帖子管理', 122, 3, 'Forum/post', 0, '', '帖子', 0),
(126, '编辑／发表帖子', 124, 0, 'Forum/editForum', 0, '', '', 0),
(127, 'edit pots', 125, 0, 'Forum/editPost', 0, '', '', 0),
(128, '排序', 124, 0, 'Forum/sortForum', 0, '', '', 0),
(130, '新增、编辑', 132, 0, 'SEO/editRule', 0, '', '', 0),
(131, '排序', 132, 0, 'SEO/sortRule', 0, '', '', 0),
(132, '规则管理', 68, 0, 'SEO/index', 0, '', 'SEO规则', 0),
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
(146, '规则回收站', 68, 0, 'SEO/ruleTrash', 0, '', 'SEO规则', 0),
(147, '头衔列表', 16, 10, 'Rank/index', 0, '', '头衔管理', 0),
(149, '添加头衔', 16, 2, 'Rank/editRank', 0, '', '头衔管理', 0),
(150, '查看用户', 16, 0, 'Rank/userList', 0, '', '头衔管理', 0),
(151, '用户头衔列表', 150, 0, 'Rank/userRankList', 1, '', '', 0),
(152, '关联新头衔', 150, 0, 'Rank/userAddRank', 1, '', '', 0),
(153, '编辑头衔关联', 150, 0, 'Rank/userChangeRank', 1, '', '', 0),
(154, '专辑', 0, 20, 'Issue/issue', 0, '', '', 0),
(155, '编辑专辑', 154, 0, 'Issue/add', 1, '', '专辑', 0),
(156, '专辑管理', 154, 0, 'Issue/issue', 0, '', '专辑', 0),
(157, '专辑回收站', 154, 4, 'Issue/issueTrash', 0, '', '专辑', 0),
(158, '专辑操作', 154, 0, 'Issue/operate', 1, '', '专辑', 0),
(159, '内容审核', 154, 1, 'Issue/verify', 0, '', '内容管理', 0),
(160, '内容回收站', 154, 5, 'Issue/contentTrash', 0, '', '内容管理', 0),
(161, '内容管理', 154, 0, 'Issue/contents', 0, '', '内容管理', 0),
(162, '扩展资料', 16, 0, 'Admin/User/profile', 0, '', '用户管理', 0),
(163, '添加、编辑分组', 162, 0, 'Admin/User/editProfile', 0, '', '', 0),
(164, '分组排序', 162, 0, 'Admin/User/sortProfile', 0, '', '', 0),
(165, '字段列表', 162, 0, 'Admin/User/field', 0, '', '', 0),
(166, '添加、编辑字段', 165, 0, 'Admin/User/editFieldSetting', 0, '', '', 0),
(167, '字段排序', 165, 0, 'Admin/User/sortField', 0, '', '', 0),
(168, '全部补丁', 68, 0, 'Admin/Update/quick', 0, '', '升级补丁', 0),
(169, '新增补丁', 68, 0, 'Admin/Update/addpack', 0, '', '升级补丁', 0),
(170, '用户扩展资料列表', 16, 0, 'Admin/User/expandinfo_select', 0, '', '用户管理', 0),
(171, '扩展资料详情', 170, 0, 'User/expandinfo_details', 0, '', '', 0),
(185, '商城信息记录', 172, 0, 'Shop/shopLog', 0, '', '商城记录', 0),
(184, '待发货交易', 172, 4, 'Shop/verify', 0, '', '交易管理', 0),
(183, '交易成功记录', 172, 5, 'Shop/goodsBuySuccess', 0, '', '交易管理', 0),
(182, '商品分类状态设置', 176, 0, 'Shop/setStatus', 0, '', '', 0),
(181, '商品状态设置', 174, 0, 'Shop/setGoodsStatus', 0, '', '', 0),
(180, '商品回收站', 172, 7, 'Shop/goodsTrash', 0, '', '商品管理', 0),
(179, '商品分类回收站', 172, 3, 'Shop/categoryTrash', 0, '', '商城配置', 0),
(178, '商品分类操作', 176, 0, 'Shop/operate', 0, '', '', 0),
(176, '商品分类配置', 172, 2, 'Shop/shopCategory', 0, '', '商城配置', 0),
(177, '商品分类添加', 176, 0, 'Shop/add', 0, '', '', 0),
(175, '添加、编辑商品', 174, 0, 'Shop/goodsEdit', 0, '', '', 0),
(174, '商品列表', 172, 1, 'Shop/goodsList', 0, '', '商品管理', 0),
(173, '货币配置', 172, 8, 'Shop/toxMoneyConfig', 0, '', '商城配置', 0),
(172, '商城', 0, 8, 'Shop/shopCategory', 0, '', '', 0),
(186, '热销商品阀值配置', 172, 0, 'Shop/hotSellConfig', 0, '', '商城配置', 0),
(187, '设置新品', 174, 0, 'Shop/setNew', 0, '', '', 0),
(188, '活动', 0, 21, 'EventType/index', 0, '', '', 0),
(189, '活动分类管理', 188, 0, 'EventType/index', 0, '', '活动分类管理', 0),
(190, '内容管理', 188, 0, 'Event/event', 0, '', '内容管理', 0),
(191, '活动分类回收站', 188, 0, 'EventType/eventTypeTrash', 0, '', '活动分类管理', 0),
(192, '内容审核', 188, 0, 'Event/verify', 0, '', '内容管理', 0),
(193, '内容回收站', 188, 0, 'Event/contentTrash', 0, '', '内容管理', 0);
/*——————————————————————配置————————————————————*/
REPLACE INTO `thinkox_config` (`id`, `name`, `type`, `title`, `group`, `extra`, `remark`, `create_time`, `update_time`, `status`, `value`, `sort`) VALUES
(56, 'COUNT_CODE', 2, '统计代码', 1, '', '用于统计网站访问量的第三方代码，推荐CNZZ统计', 1403058890, 1403058890, 1, '  <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id=''cnzz_stat_icon_5849549''%3E%3C/span%3E%3Cscript src=''" + cnzz_protocol + "s5.cnzz.com/stat.php%3Fid%3D5849549%26show%3Dpic1'' type=''text/javascript''%3E%3C/script%3E"));</script>\r\n', 0);
INSERT INTO `thinkox_config` (`id`, `name`, `type`, `title`, `group`, `extra`, `remark`, `create_time`, `update_time`, `status`, `value`, `sort`) VALUES
(57, 'SHARE_WEIBO_ID', 0, '分享来源微博ID', 1, '', '来源的微博ID，不配置则隐藏顶部微博分享按钮。', 1403091490, 1403091490, 1, '1971549283', 0);
INSERT INTO `thinkox_config` (`id`, `name`, `type`, `title`, `group`, `extra`, `remark`, `create_time`, `update_time`, `status`, `value`, `sort`) VALUES
(58, 'USER_REG_WEIBO_CONTENT', 1, '用户注册微博提示内容', 3, '', '留空则表示不发新微博，支持face', 1404965285, 1404965445, 1, '', 0);


/*——————————————————————导航菜单——————————————————*/
INSERT INTO `thinkox_channel` (`pid`, `title`, `url`, `sort`, `create_time`, `update_time`, `status`, `target`) VALUES
(0, '商城', 'Shop/Index/index', 5, 1403056971, 1403085891, 1, 0);
INSERT INTO `thinkox_channel` ( `pid`, `title`, `url`, `sort`, `create_time`, `update_time`, `status`, `target`) VALUES
( 0, '活动', 'Event/index/index', 4, 1403682332, 1403682347, 1, 0);

/*——————————————————————钩子————————————————————*/
DROP TABLE IF EXISTS `thinkox_hooks`;
CREATE TABLE IF NOT EXISTS `thinkox_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text NOT NULL COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=26 ;

INSERT INTO `thinkox_hooks` (`id`, `name`, `description`, `type`, `update_time`, `addons`) VALUES
(1, 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', 1, 0, ''),
(2, 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', 1, 0, 'ReturnTop'),
(3, 'documentEditForm', '添加编辑表单的 扩展内容钩子', 1, 0, 'Attachment'),
(4, 'documentDetailAfter', '文档末尾显示', 1, 0, 'Attachment,SocialComment,Avatar,Tianyi'),
(5, 'documentDetailBefore', '页面内容前显示用钩子', 1, 0, ''),
(6, 'documentSaveComplete', '保存文档数据后的扩展钩子', 2, 0, 'Attachment'),
(7, 'documentEditFormContent', '添加编辑表单的内容显示钩子', 1, 0, 'Editor'),
(8, 'adminArticleEdit', '后台内容编辑页编辑器', 1, 1378982734, 'EditorForAdmin'),
(13, 'AdminIndex', '首页小格子个性化显示', 1, 1382596073, 'SiteStat,SystemInfo,DevTeam,SyncLogin'),
(14, 'topicComment', '评论提交方式扩展钩子。', 1, 1380163518, 'Editor'),
(16, 'app_begin', '应用开始', 2, 1384481614, ''),
(17, 'checkin', '签到', 1, 1395371353, 'Checkin'),
(18, 'Rank', '签到排名钩子', 1, 1395387442, 'Rank_checkin'),
(20, 'support', '赞', 1, 1398264759, 'Support'),
(21, 'localComment', '本地评论插件', 1, 1399440321, 'LocalComment'),
(22, 'weiboType', '插入图片', 1, 1402390749, 'InsertImage'),
(23, 'repost', '转发钩子', 1, 1403668286, 'Repost'),
(24, 'syncLogin', '第三方登陆位置', 1, 1403700579, 'SyncLogin'),
(25, 'syncMeta', '第三方登陆meta接口', 1, 1403700633, 'SyncLogin');
