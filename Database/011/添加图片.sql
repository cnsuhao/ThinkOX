ALTER TABLE  `thinkox_weibo` ADD  `type` VARCHAR( 255 ) NOT NULL ,
ADD  `data` TEXT NOT NULL;


INSERT INTO `thinkox_seo_rule` ( `title`, `app`, `controller`, `action`, `status`, `seo_keywords`, `seo_description`, `seo_title`, `sort`) VALUES
( '微博详情页SEO', 'Weibo', 'Index', 'weiboDetail', 1, '{$weibo.title|op_t},Thinkox,ox,微博', '{$weibo.content|op_t}', '{$weibo.content|op_t}——ThinkOX微博', 0),
( '用户中心', 'Usercenter', 'Index', 'index', 1, '{$user.username|op_t},Thinkox', '{$user.username|op_t}的个人主页', '{$user.username|op_t}的个人主页', 0);
