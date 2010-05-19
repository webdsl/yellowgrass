CREATE TABLE IF NOT EXISTS `_Event` ( 
	`DISCRIMINATOR` VARCHAR(255) character set utf8 collate utf8_bin default NULL,
	`id` VARCHAR(32) character set utf8 collate utf8_bin default NULL,
	`version_opt_lock` integer,
	`_moment` datetime,
	PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
ALTER IGNORE TABLE _Event
ADD COLUMN `_submitted` datetime;
ALTER IGNORE TABLE _Event
ADD COLUMN `_text` longtext character set utf8 collate utf8_bin;
ALTER IGNORE TABLE _Event
ADD COLUMN `Comment_author` VARCHAR(32) character set utf8 collate utf8_bin default NULL;
INSERT INTO _Event (id,DISCRIMINATOR,version_opt_lock,_submitted,_text,Comment_author)
SELECT id,DISCRIMINATOR,version_opt_lock,_submitted,_text,Comment_author FROM _Comment;
DROP TABLE _Comment;
RENAME TABLE Issue_comments_Comment TO Issue_comments_Event;
ALTER TABLE Issue_comments_Event 
RENAME Issue_log_Event;
ALTER TABLE Issue_log_Event 
CHANGE COLUMN _comments_id _log_id varchar(32);
ALTER IGNORE TABLE _Event
ADD COLUMN `IssueClose_actor` VARCHAR(32) character set utf8 collate utf8_bin default NULL;
ALTER IGNORE TABLE _Event
ADD COLUMN `IssueReopen_actor` VARCHAR(32) character set utf8 collate utf8_bin default NULL;
UPDATE _Event SET _moment=_submitted;
