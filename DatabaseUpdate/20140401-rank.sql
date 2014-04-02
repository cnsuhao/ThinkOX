--
-- 表的结构 `thinkox_rank`
--
DROP TABLE `thinkox_rank`;

CREATE TABLE IF NOT EXISTS `thinkox_rank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '上传者id',
  `title` varchar(50) NOT NULL,
  `logo` int(11) NOT NULL,
  PRIMARY KEY (`rank_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 表的结构 `thinkox_rank_user`
--
DROP TABLE `thinkox_rank_user`;
CREATE TABLE IF NOT EXISTS `thinkox_rank_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `is_show` tinyint(4) NOT NULL COMMENT '是否显示在昵称右侧（必须有图片才可）',
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


ALTER TABLE  `thinkox_rank` ADD  `create_time` INT NOT NULL AFTER  `logo`;

INSERT INTO `thinkox_menu` ( `title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`) VALUES
('头衔', 0, 10, 'Rank/index', 0, '', '', 0),
('头衔列表', 141, 1, 'Rank/index', 0, '', '头衔管理', 0),
('添加头衔', 141, 2, 'Rank/editRank', 0, '', '头衔管理', 0),
('用户列表', 141, 0, 'Rank/userList', 0, '', '关联头衔', 0),
('用户头衔列表', 144, 0, 'Rank/userRankList', 1, '', '', 0),
('关联新头衔', 144, 0, 'Rank/userAddRank', 1, '', '', 0),
('编辑头衔关联', 144, 0, 'Rank/userChangeRank', 1, '', '', 0);