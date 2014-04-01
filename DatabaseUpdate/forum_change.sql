ALTER TABLE  `thinkox_forum` ADD  `logo` INT NOT NULL;



INSERT INTO `onethink_action` ( `name`, `title`, `remark`, `rule`, `log`, `type`, `status`, `update_time`) VALUES
( 'add_weibo', '发微博', '积分+2，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+2|cycle:24|max:5', '', 1, 1, 1396342914),
( 'add_weibo_comment', '微博评论', '积分+1，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+1|cycle:24|max:5', '', 1, 1, 1396342907),
( 'add_post', '发帖子', '积分+3，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+3|cycle:24|max:5', '', 1, 1, 1396342951),
( 'add_post_reply', '发帖子回复', '积分+1，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+1|cycle:24|max:5', '', 1, 1, 1396342956);
