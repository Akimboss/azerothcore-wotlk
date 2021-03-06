-- DB update 2019_07_18_00 -> 2019_07_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_18_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_18_00 2019_07_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1562252728718185214'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1562252728718185214');

-- Fix Dragonflayer Strategist throwing a throwing knife instead of a blue/white checkered cube when casting "Hurl Dagger"
UPDATE `creature_equip_template` SET `ItemID3` = 29010 WHERE `CreatureID` = 23956;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
