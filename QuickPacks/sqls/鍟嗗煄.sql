DROP TABLE IF EXISTS `thinkox_shop`;
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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='商品信息' AUTO_INCREMENT=11 ;


DROP TABLE IF EXISTS `thinkox_shop_buy`;
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='购买商品信息表' AUTO_INCREMENT=53 ;

DROP TABLE IF EXISTS `thinkox_shop_config`;
CREATE TABLE IF NOT EXISTS `thinkox_shop_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ename` varchar(25) NOT NULL COMMENT '英文名称（固定:tox_money）',
  `cname` varchar(25) NOT NULL COMMENT '中文名称',
  `changetime` int(11) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='商店配置' AUTO_INCREMENT=1 ;

INSERT INTO `thinkox_shop_config` ( `ename`, `cname`, `changetime`) VALUES ( 'tox_money', '金币', 1402756941);

DROP TABLE IF EXISTS `thinkox_shop_category`;
CREATE TABLE IF NOT EXISTS `thinkox_shop_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


DROP TABLE IF EXISTS `thinkox_shop_log`;
CREATE TABLE IF NOT EXISTS `thinkox_shop_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `message` varchar(500) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;

DROP TABLE IF EXISTS `thinkox_shop_address`;
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED AUTO_INCREMENT=2 ;


REPLACE INTO `thinkox_menu` (`id`, `title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`) VALUES
(172, '商城', 0, 8, 'Shop/shopCategory', 0, '', '', 0),
(173, '货币配置', 172, 8, 'Shop/toxMoneyConfig', 0, '', '商城配置', 0),
(174, '商品列表', 172, 1, 'Shop/goodsList', 0, '', '商品管理', 0),
(175, '添加、编辑商品', 174, 0, 'Shop/goodsEdit', 0, '', '', 0),
(176, '商品分类配置', 172, 2, 'Shop/shopCategory', 0, '', '商城配置', 0),
(177, '商品分类添加', 176, 0, 'Shop/add', 0, '', '', 0),
(178, '商品分类操作', 176, 0, 'Shop/operate', 0, '', '', 0),
(179, '商品分类回收站', 172, 3, 'Shop/categoryTrash', 0, '', '商城配置', 0),
(180, '商品回收站', 172, 7, 'Shop/goodsTrash', 0, '', '商品管理', 0),
(181, '商品状态设置', 174, 0, 'Shop/setGoodsStatus', 0, '', '', 0),
(182, '商品分类状态设置', 176, 0, 'Shop/setStatus', 0, '', '', 0),
(183, '交易成功记录', 172, 5, 'Shop/goodsBuySuccess', 0, '', '交易管理', 0),
(184, '待发货交易', 172, 4, 'Shop/verify', 0, '', '交易管理', 0),
(185, '商城信息记录', 172, 0, 'Shop/shopLog', 0, '', '商城记录', 0);