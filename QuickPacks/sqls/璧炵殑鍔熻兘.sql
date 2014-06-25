ALTER TABLE  `thinkox_weibo` ADD  `repost_count` INT NOT NULL;
INSERT INTO `thinkox_hooks` (`id`, `name`, `description`, `type`, `update_time`, `addons`) VALUES
(23, 'repost', '转发钩子', 1, 1403668286, 'Repost');
