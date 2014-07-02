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