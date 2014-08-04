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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;


INSERT INTO `thinkox_hooks` (`id`, `name`, `description`, `type`, `update_time`, `addons`) VALUES
(1, 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', 1, 0, 'ImageSlider'),
(2, 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', 1, 0, 'ReturnTop,SuperLinks'),
(3, 'documentEditForm', '添加编辑表单的 扩展内容钩子', 1, 0, 'Attachment'),
(4, 'documentDetailAfter', '文档末尾显示', 1, 0, 'Attachment,SocialComment,Avatar,Tianyi'),
(5, 'documentDetailBefore', '页面内容前显示用钩子', 1, 0, ''),
(6, 'documentSaveComplete', '保存文档数据后的扩展钩子', 2, 0, 'Attachment'),
(7, 'documentEditFormContent', '添加编辑表单的内容显示钩子', 1, 0, 'Editor'),
(8, 'adminArticleEdit', '后台内容编辑页编辑器', 1, 1378982734, 'EditorForAdmin'),
(13, 'AdminIndex', '首页小格子个性化显示', 1, 1382596073, 'SiteStat,SystemInfo,DevTeam,SyncLogin,Advertising'),
(14, 'topicComment', '评论提交方式扩展钩子。', 1, 1380163518, 'Editor'),
(16, 'app_begin', '应用开始', 2, 1384481614, 'Models'),
(17, 'checkin', '签到', 1, 1395371353, 'Checkin'),
(18, 'Rank', '签到排名钩子', 1, 1395387442, 'Rank_checkin'),
(20, 'support', '赞', 1, 1398264759, 'Support'),
(21, 'localComment', '本地评论插件', 1, 1399440321, 'LocalComment'),
(22, 'weiboType', '插入图片', 1, 1402390749, 'InsertImage'),
(23, 'repost', '转发钩子', 1, 1403668286, 'Repost'),
(24, 'syncLogin', '第三方登陆位置', 1, 1403700579, 'SyncLogin'),
(25, 'syncMeta', '第三方登陆meta接口', 1, 1403700633, 'SyncLogin'),
(26, 'J_China_City', '每个系统都需要的一个中国省市区三级联动插件。', 1, 1403841931, 'ChinaCity'),
(27, 'Advs', '广告位插件', 1, 1406687667, 'Advs'),
(28, 'imageSlider', '图片轮播钩子', 1, 1407144022, 'ImageSlider'),
(29, 'friendLink', '友情链接插件', 1, 1407156413, 'SuperLinks');
