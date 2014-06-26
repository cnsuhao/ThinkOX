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
INSERT INTO `thinkox_channel` ( `pid`, `title`, `url`, `sort`, `create_time`, `update_time`, `status`, `target`) VALUES
( 0, '活动', 'Event/index/index', 4, 1403682332, 1403682347, 1, 0);

INSERT INTO `thinkox_menu` ( `title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`) VALUES
( '活动', 0, 21, 'EventType/index', 0, '', '', 0),
( '活动分类管理', 10000, 0, 'EventType/index', 0, '', '活动分类管理', 0),
( '内容管理', 10000, 0, 'Event/event', 0, '', '内容管理', 0),
( '活动分类回收站', 10000, 0, 'EventType/eventTypeTrash', 0, '', '活动分类管理', 0),
( '内容审核', 10000, 0, 'Event/verify', 0, '', '内容管理', 0),
( '内容回收站', 10000, 0, 'Event/contentTrash', 0, '', '内容管理', 0);