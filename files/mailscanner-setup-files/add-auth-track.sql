CREATE TABLE IF NOT EXISTS mailscanner.`maillog_auth` (
  `mail_id` varchar(200) NOT NULL,
  `auth_type` varchar(50) NOT NULL,
  `clientauth` varchar(250) NOT NULL,
  UNIQUE KEY `mail_id` (`mail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
COMMIT;

ALTER TABLE mailscanner.`maillog` ADD `central_done` TINYINT NOT NULL DEFAULT '0' AFTER `last_update`, ADD INDEX (`central_done`);
ALTER TABLE mailscanner.`maillog_auth` ADD `central_done` TINYINT NOT NULL DEFAULT '0' AFTER `clientauth`, ADD INDEX (`central_done`);
ALTER TABLE mailscanner.`mtalog_ids` ADD `central_done` TINYINT NOT NULL DEFAULT '0' AFTER `smtp_id`, ADD INDEX (`central_done`);
ALTER TABLE mailscanner.`mtalog` ADD `central_done` TINYINT NOT NULL DEFAULT '0' AFTER `delay`, ADD INDEX (`central_done`);

