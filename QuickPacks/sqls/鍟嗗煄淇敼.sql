ALTER TABLE  `thinkox_shop` ADD  `is_new` TINYINT( 4 ) NOT NULL DEFAULT  '0' COMMENT  '是否为新品';
ALTER TABLE  `thinkox_shop` ADD  `sell_num` INT( 11 ) NOT NULL DEFAULT  '0' COMMENT  '已出售量';
ALTER TABLE  `thinkox_shop_config` CHANGE  `ename`  `ename` VARCHAR( 25 ) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT  '标识';
INSERT INTO  `thinkox_shop_config` (`id` ,`ename` ,`cname` ,`changetime`)VALUES ('2' ,  'min_sell_num',  '10',  '1403489181');

INSERT INTO `thinkox_menu` (`title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`) VALUES
('热销商品阀值配置', 172, 0, 'Shop/hotSellConfig', 0, '', '商城配置', 0),
('设置新品', 174, 0, 'Shop/setNew', 0, '', '', 0);


--
-- 表的结构 `thinkox_shop_see`
--

DROP TABLE IF EXISTS `thinkox_shop_see`;
CREATE TABLE IF NOT EXISTS `thinkox_shop_see` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`goods_id` int(11) NOT NULL,
`uid` int(11) NOT NULL,
`create_time` int(11) NOT NULL,
`update_time` int(11) NOT NULL,
PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
