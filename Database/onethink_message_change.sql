/*调整消息的应用名称和类型*/

ALTER TABLE  `onethink_message` ADD  `appname` VARCHAR( 30 ) NOT NULL;
ALTER TABLE  `onethink_message` ADD  `apptype` VARCHAR( 30 ) NOT NULL;