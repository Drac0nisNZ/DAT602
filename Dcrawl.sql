
DROP DATABASE if exists dcrawl ;
CREATE DATABASE dcrawl;
USE dcrawl;

DROP USER if exists 'draco'@'localhost';

CREATE USER 'draco'@'localhost' IDENTIFIED BY '53211';
GRANT ALL ON dcrawl.* TO 'draco'@'localhost';

CREATE TABLE Player (
	PlayerID INT,
	PlayerName VARCHAR(50) NOT NULL UNIQUE,
	email VARCHAR(50) NOT NULL UNIQUE,
	`Password` VARCHAR(50) NOT NULL DEFAULT 12345,
	LoginAttemps INT DEFAULT 0,
	LockedOut BOOL DEFAULT FALSE, 
    GameID INT,
	DungeonID INT,
	Health INT,
	X INT DEFAULT 1,
    Y INT DEFAULT 5
);

CREATE TABLE Treasure (
	TreasureID INT,
	ItemName VARCHAR(22),
	`Description` TEXT,
	Effect VARCHAR(80),
	Price INT
);

CREATE TABLE CharInventory (
	TreasureID INT,
	PlayerID INT,
	Quantity INT
);

CREATE TABLE Skill (
	SkillID INT,
	skill_category VARCHAR(9)
);

CREATE TABLE CharSkills (
	PlayerID INT,
	SkillID INT,
	SkillLevel INT
);

CREATE TABLE Game (
	GameID INT,
	GameName VARCHAR(50),
	Duration VARCHAR(50),
	PlayerCount INT
);

CREATE TABLE Score (
	GameID INT,
	PlayerID INT,
	Score INT
);

CREATE TABLE Tile (
	TileID INT,
	Content TEXT,
	Effect TEXT,
	Image VARCHAR(50)
);

CREATE TABLE Map (
	MapID INT,
	GameID INT
);

CREATE TABLE Dungeon (
	DungeonID INT,
	MapID INT,
	TileID INT
);

CREATE TABLE Goblin (
	GobID INT,
	DungeonID INT,
	MapID INT,
	Health INT,
	Image VARCHAR(50)
);

CREATE TABLE GoblinInventory (
	GobID INT,
    TreasureID INT,
	Quantity INT
);

INSERT INTO Player (PlayerID, PlayerName, email, GameID, DungeonID, Health, X, Y) 
VALUES 	(1, 'Witty', 'wsharvell0@stumbleupon.com', 4, 6, 3, 7, 8),
		(2, 'Pascal', 'prubens1@nasa.gov', 3, 5, 10, 8, 1),
		(3, 'Collete', 'crodenborch2@freewebs.com', 10, 4, 3, 5, 2),
		(4, 'Arlina', 'aconeybeer3@acquirethisname.com', 6, 4, 2, 6, 4),
		(5, 'Amery', 'alouisot4@taobao.com', 9, 3, 3, 8, 9),
		(6, 'Jemima', 'jcalyton5@wp.com', 1, 8, 2, 4, 4),
		(7, 'Brendin', 'bwogden6@mozilla.org', 1, 9, 8, 4, 9),
		(8, 'Tiebout', 'tedgworth7@lulu.com', 4, 7, 2, 5, 6),
		(9, 'Laurie', 'lhiggoe8@ibm.com', 6, 4, 2, 10, 10),
		(10, 'Alisha', 'asprowle9@mashable.com', 1, 10, 10, 2, 1),
		(11, 'Darrelle', 'dtewkesburya@wisc.edu', 8, 1, 1, 8, 5),
		(12, 'Agneta', 'adenyerb@bbc.co.uk', 4, 8, 2, 7, 1),
		(13, 'Skip', 'scruddacec@si.edu', 10, 8, 6, 7, 10),
		(14, 'Alisun', 'arawed@google.com.au', 6, 4, 4, 3, 7),
		(15, 'Viviene', 'vdingleye@xing.com', 8, 6, 10, 6, 8),
		(16, 'Esta', 'elinneyf@pbs.org', 9, 4, 10, 8, 5),
		(17, 'Christyna', 'cfinckeng@hostgator.com', 3, 9, 9, 5, 7),
		(18, 'Raine', 'rbonafacinoh@tinyurl.com', 7, 7, 7, 3, 2),
		(19, 'Wilbert', 'woherlihyi@smugmug.com', 8, 9, 4, 3, 2),
		(20, 'Roby', 'rrowettj@de.vu', 3, 5, 7, 8, 5),
		(21, 'Bess', 'bcescotik@google.it', 8, 3, 9, 3, 2),
		(22, 'Margarete', 'mstubbeleyl@friendfeed.com', 7, 3, 6, 7, 9),
		(23, 'Idalia', 'iautiem@topsy.com', 8, 9, 6, 1, 10),
		(24, 'Bernarr', 'bocanavann@newyorker.com', 5, 1, 2, 9, 4),
		(25, 'Yoko', 'ysaunto@house.gov', 10, 2, 7, 8, 9),
		(26, 'Coleman', 'ccowplandp@soup.io', 6, 2, 3, 9, 9),
		(27, 'Hogan', 'hvasilchenkoq@example.com', 6, 7, 6, 9, 3),
		(28, 'Roddie', 'rfattorer@ow.ly', 6, 6, 5, 4, 10),
		(29, 'Roxanne', 'rblakeslees@google.ca', 8, 2, 10, 7, 9),
		(30, 'Melania', 'mcolebrookt@mozilla.com', 8, 1, 9, 8, 5);
       
INSERT INTO Treasure (TreasureID, ItemName, `Description`, Effect, Price) 
VALUES 	(1, 'Potion of Healing', 'Heal 3 health on use.', 'Health +3', 59),
		(2, 'Emerald Dagger', 'Stops goblin from taking items.', 'Cancels goblin item theft', 29),
		(3, 'Torch', 'Extends sight range by 1.', 'Sight +1, 5 min Duration', 5),
		(4, 'Lantern', 'Extends sight range by 2.', 'Sight +2 10 min duration', 14),
		(5, 'Bullseye Lantern', 'Extends sight range by 3 in direction of last move 2 in other directions', 'Sight +3 in last moved direction +2 other directions 10 min duration', 52),
		(6, 'Spear', 'Can attack at range 1 or throw to siight range if sight is 2+.', 'range = sight, 1 damage per hit', 5),
		(7, 'Cloak of Shadows', 'Morbi vel lectus in quam fringilla rhoncus.', 'US', 32),
		(8, 'Treasure Map', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.', 'US', 14),
		(9, 'Jade Figurine', 'Pellentesque at nulla.', 'AU', 19),
		(10, 'Pearl Earrings', 'Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 'US', 56);

INSERT INTO CharInventory (TreasureID, PlayerID, Quantity) 
VALUES 	(1, 1, 8),
		(2, 2, 7),
		(3, 3, 1),
		(4, 4, 9),
		(5, 5, 8),
		(6, 6, 10),
		(7, 7, 7),
		(8, 8, 2),
		(9, 9, 8),
		(10, 10, 6),
		(11, 11, 2),
		(12, 12, 4),
		(13, 13, 6),
		(14, 14, 9),
		(15, 15, 8),
		(16, 16, 10),
		(17, 17, 6),
		(18, 18, 4),
		(19, 19, 2),
		(20, 20, 1),
		(21, 21, 9),
		(22, 22, 3),
		(23, 23, 9),
		(24, 24, 8),
		(25, 25, 6),
		(26, 26, 3),
		(27, 27, 5),
		(28, 28, 6),
		(29, 29, 4),
		(30, 30, 8);
	
INSERT INTO Skill (SkillID, skill_category) 
VALUES 	(1, 'Gathering'),
		(2, 'Combat'),
		(3, 'Magic');
        
INSERT INTO CharSkills (PlayerID, SkillID, SkillLevel) 
VALUES 	(1, 2, 4),
		(2, 3, 4),
		(3, 3, 2),
		(4, 1, 3),
		(5, 3, 1),
		(6, 3, 5),
		(7, 2, 4),
		(8, 2, 4),
		(9, 2, 2),
		(10, 1, 5),
		(11, 1, 4),
		(12, 1, 1),
		(13, 3, 5),
		(14, 3, 5),
		(15, 2, 5),
		(16, 2, 1),
		(17, 2, 3),
		(18, 3, 3),
		(19, 1, 4),
		(20, 2, 2),
		(21, 1, 4),
		(22, 2, 4),
		(23, 3, 4),
		(24, 1, 4),
		(25, 1, 2),
		(26, 2, 2),
		(27, 3, 5),
		(28, 2, 2),
		(29, 2, 5),
		(30, 2, 4);

INSERT INTO Game (GameID, GameName, Duration, PlayerCount) 
VALUES 	(1, 'Ethyl', '2:58 PM', 2),
		(2, 'Rhiamon', '6:49 PM', 2),
		(3, 'Nowell', '1:05 PM', 3),
		(4, 'Emili', '10:56 AM', 3),
		(5, 'Dianna', '2:21 PM', 1),
		(6, 'Sharyl', '12:33 PM', 1),
		(7, 'Eli', '5:08 AM', 2),
		(8, 'Trey', '3:34 AM', 1),
		(9, 'Colas', '11:12 PM', 4),
		(10, 'Royce', '1:18 PM', 1);

INSERT INTO Score (GameID, PlayerID, Score) 
VALUES 	(1, 1, 6),
		(1, 2, 2),
		(2, 3, 3),
		(2, 4, 1),
		(3, 5, 1),
		(3, 6, 5),
		(3, 7, 8),
		(4, 8, 9),
		(4, 9, 10),
		(4, 10, 6),
		(5, 11, 5),
		(6, 12, 8),
		(7, 13, 3),
		(7, 14, 4),
		(8, 15, 5),
		(9, 16, 1),
		(9, 17, 3),
		(9, 18, 9),
		(9, 19, 8),
		(10, 20, 10);

INSERT INTO Tile (TileID, Content, Effect, Image) 
VALUES 	(1, 'Wall', 'Impassible', 'http://dummyimage.com/172x100.png/cc0000/ffffff'),
		(2, 'Pit Trap', '1 damage, 30 seconds stun', 'http://dummyimage.com/190x100.png/5fa2dd/ffffff'),
		(3, 'Spear Trap', '2 damage, character can pick up 1 spear', 'http://dummyimage.com/177x100.png/dddddd/000000'),
		(4, 'Path', 'Empty hallway', 'http://dummyimage.com/196x100.png/5fa2dd/ffffff'),
		(5, 'Treasure', 'Random item from treasure table.', 'http://dummyimage.com/140x100.png/5fa2dd/ffffff'),
		(6, 'Entrance', 'Entry and exit from dungeon.', 'http://dummyimage.com/140x100.png/dddddd/ffffff');
        
INSERT INTO Map (MapID, GameID) 
VALUES 	(1, 1),
		(2, 2),
		(3, 3),
		(4, 4),
		(5, 5),
		(6, 6),
		(7, 7),
		(8, 8),
		(9, 9),
		(10, 10);

INSERT INTO Dungeon (DungeonID, MapID, TileID)
values 	(1, 1, 1),
		(2, 2, 2),
		(3, 3, 3),
		(4, 4, 4),
		(5, 5, 5),
		(6, 6, 1),
		(7, 7, 2),
		(8, 8, 3),
		(9, 9, 4),
		(10, 10, 5);

INSERT INTO goblin (GobID, DungeonID, MapID, Health, Image) 
VALUES 	(1, 1, 1, 2, 'http://dummyimage.com/195x100.png/ff4444/ffffff'),
		(2, 2, 2, 1, 'http://dummyimage.com/195x100.png/ff4444/ffffff'),
		(3, 3, 3, 1, 'http://dummyimage.com/195x100.png/ff4444/ffffff'),
		(4, 4, 4, 1, 'http://dummyimage.com/195x100.png/ff4444/ffffff'),
		(5, 5, 5, 3, 'http://dummyimage.com/195x100.png/ff4444/ffffff'),
		(6, 6, 6, 2, 'http://dummyimage.com/195x100.png/ff4444/ffffff'),
		(7, 7, 7, 1, 'http://dummyimage.com/195x100.png/ff4444/ffffff'),
		(8, 8, 8, 3, 'http://dummyimage.com/195x100.png/ff4444/ffffff'),
		(9, 9, 9, 3, 'http://dummyimage.com/195x100.png/ff4444/ffffff'),
		(10, 10, 10, 2, 'http://dummyimage.com/195x100.png/ff4444/ffffff');
        
insert into GoblinInventory (GobID, TreasureID, Quantity) 
values 	(1, 1, 1),
		(2, 2, 1),
		(3, 3, 1),
		(4, 4, 2),
		(5, 5, 1),
		(6, 6, 2),
		(7, 7, 3),
		(8, 8, 1),
		(9, 9, 2),
		(10, 10, 2),
		(1, 10, 1),
		(2, 9, 2),
		(3, 8, 1),
		(4, 7, 2),
		(5, 6, 3),
		(6, 5, 3),
		(7, 4, 2),
		(8, 3, 1),
		(9, 2, 3),
		(10, 1, 1);


DROP PROCEDURE IF EXISTS Login;

DELIMITER $$

CREATE PROCEDURE Login( IN pUserName VARCHAR(50), IN pPassword  VARCHAR(50))
COMMENT 'Check login'
BEGIN
    DECLARE numAttempts INT DEFAULT 0;
    DECLARE lockedOut BOOL DEFAULT false;
	
    
    SELECT LockedOut
    INTO lockedOut 
    FROM Player
    WHERE 
        email = pUsername and `Password` = pPassword;
        
	-- 'Check for valid login', 
    -- if valid then select message "Logged in" and reset Attempts to 0, 
    IF EXISTS ( SELECT * 
                FROM Player
                WHERE 
                 ( email = pUserName AND
                  `Password` = pPassword ) AND NOT LOCKED_OUT
                  ) 
	THEN
		UPDATE Player 
        SET Attempts = 0
        WHERE
           email = pUserName;
           
		SELECT 'Logged In' as Message;
    
    ELSE 
    -- else add to Attempts ,
        IF EXISTS(SELECT * FROM Player WHERE email = pUserName AND NOT LOCKED_OUT) THEN 
        
			SELECT Attempts 
			INTO numAttempts 
			FROM Player
			WHERE 
			   email = pUserName;
			
			SET numAttempts = numAttempts + 1;
			
			IF numAttempts > 5 THEN 
			-- if Attempts > 5 then set lockout  to true and select message 'locked out' 
				UPDATE Player 
				SET LockedOut = True
				WHERE 
					 email = pUserName ;
					 
				 SELECT 'Locked Out' AS Message;
				 
			ELSE
			-- else select message 'Bad  password'
                 UPDATE Player
                 SET Attempts = numAttempts
                 WHERE 
                    email = pUserName;
                    
				 SELECT 'Invalid user name and password' as Message;
			END IF;
      ELSE 
        IF LockedOut THEN
			SELECT 'LOCKED OUT' as Message;
		ELSE
			SELECT 'Invalid user name and password' as Message;
		END IF; 
      END IF;

    
    END IF;
                  
END $$
DELIMITER ;


SELECT email, LoginAttemps 
FROM Player;


DROP PROCEDURE IF EXISTS AddUserName;
/*DELIMITER $$
CREATE PROCEDURE AddUserName(IN pUserName VARCHAR(50), IN pPassword VARCHAR(50), pemail VARCHAR(50))
BEGIN
  IF EXISTS (SELECT * 
     FROM Player
     WHERE PlayerName = pUserName) THEN
  BEGIN
     SELECT 'NAME EXISTS' AS MESSAGE;
  END;
  ELSE 
     INSERT INTO Player(PlayerName,Password,email)
     VALUE (pUserName, pPassword, email); 
     SELECT 'ADDED USER NAME' AS MESSAGE;
  END IF;
  
END $$
DELIMITER ;
-- Test AddUserName
call AddUserName('Zorro','zoom', 'zorro@gmail.com');
call AddUserName('Zorro','zoom', 'zorro@gmail.com');




DROP PROCEDURE IF EXISTS AddUserName;
DELIMITER $$
CREATE PROCEDURE AddUserName(IN pUserName VARCHAR(50))
BEGIN
  IF EXISTS (SELECT * 
     FROM Player
     WHERE PlayerName = pUserName) THEN
  BEGIN
     SELECT 'NAME EXISTS' AS MESSAGE;
  END;
  ELSE 
     INSERT INTO Player(PlayerName,X,Y)
     VALUE (pUserName, 100,100); -- Need to check the X,Y location
     SELECT 'ADDED USER NAME' AS MESSAGE;
  END IF;
  
END $$
DELIMITER ;
/*
DROP PROCEDURE IF EXISTS PlayerQuit;
DELIMITER $$
CREATE PROCEDURE PlayerQuit(pUserName VARCHAR(50))
BEGIN
	IF EXISTS ( SELECT * FROM tblClickTarget WHERE UserName = pUserName) THEN
     DELETE FROM tblClickTarget WHERE UserName = pUserName;
     SELECT 'QUIT' AS MESSAGE;
	ELSE
     SELECT 'PLAYER DOES NOT EXIST' AS MESSAGE;
	END IF;
END$$ -- PlayerQuit
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS HitFrom$$
CREATE PROCEDURE HitFrom(pUserName varchar (50), pX integer, pY integer)
BEGIN
   IF EXISTS (SELECT * FROM Player WHERE PlayerName = pUserName) THEN
   BEGIN
      -- Target area is within 10 of the click at (X,Y)
      SELECT count(*) 
      FROM Player
      WHERE 
        (pX >=  X - 10 AND pX <= X + 10 ) AND
        (pY >= Y - 10 AND pY <= Y + 10) AND 
        PlayerName <> pUserName
	  INTO @HitCount;
      
      UPDATE Player
      SET Health = Health + @HitCount
      WHERE 
            (NOT @HitCount IS NULL AND @HitCount <> 0 ) AND
            PlayerName = pUsername;
            
	  UPDATE Player
      Set Health = Health -1
      WHERE
        (pX >=  X - 10 AND pX <= X + 10 ) AND
        (pY >= Y - 10 AND pY <= Y + 10) AND 
        PlayerName <> pUserName;
      
      DELETE FROM Player
      WHERE Health <= 0;
      
      SELECT 'PLAYED ' AS MESSAGE;
   END;
   ELSE
    SELECT 'PLAYER GONE' AS MESSAGE;
   END IF;
END$$
DELIMITER ;

/*
DROP PROCEDURE IF EXISTS GetAllPlayers$$
CREATE PROCEDURE GetAllPlayers()
BEGIN
	SELECT PlayerName, Health, X, Y
    FROM Player ;
END$$
*/
DELIMITER $$
DROP FUNCTION IF EXISTS targetMove$$
CREATE FUNCTION targetMove()
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN ROUND(RAND() * 20) - 10;
END$$
DELIMITER ; 
SELECT targetMove() as X;

DELIMITER $$
DROP PROCEDURE IF EXISTS Move$$
CREATE PROCEDURE Move(pMaxX INT, pMaxY INT)
BEGIN
  -- MOVES +/- 10 pixels, this might be boring, 
  -- also it does not check it the target
  -- moves out of bounds, presumes MinX and MinY are 0.
  SET @newX = ROUND(RAND() * 20) - 10;
  SET @newY = ROUND(RAND() * 20) - 10;
  
 SELECT count(*)
 FROM Player 
 WHERE
      ((X + targetMove()) >= 0 AND (X + targetMove()) <= pMaxX) AND
      ((Y + targetMove()) >= 0 AND (Y + targetMove()) <= pMaxY)
 INTO @Count;
  
  UPDATE Player
  SET 
      X =  X + targetMove() , 
      Y =  Y +  targetMove() 
  WHERE
     ((X + targetMove()) >= 0 AND (X + targetMove()) <= pMaxX) AND
	((Y + targetMove()) >= 0 AND (Y + targetMove()) <= pMaxY);
     
  SELECT 'Moved' as Message; 
END$$
DELIMITER $$
CALL Move(1024,1024);

SELECT * from Player;

/*
--
-- TESTING AREA

-- This procedure is "work in progress" 
DROP PROCEDURE IF EXISTS TestPlay$$
CREATE PROCEDURE TestPlay(pNumberOfPlayers INT)
BEGIN
      DECLARE counter INT DEFAULT 0;
       REPEAT
		 SET @NewName = CONCAT('Asterix', counter);
         CALL AddUserName(@NewName);
         SET counter = counter + 1;
       UNTIL counter > pNumberOfPlayers
       END REPEAT ;
END$$

DELIMITER ;
-- Call TestPlay(100);

Call AddUserName('Asterix');
Call AddUserName('Obelix');
Call AddUserName('Obelix');
Call HitFrom('Asterix',95,110);
Call HitFrom('Asterix',1,1);
Call HitFrom('Obelix',95,110);
Call HitFrom('Obelix',95,100);

Call GetAllPlayers();
CALL Move(1024,1024);

-- SELECT * 
-- FROM Player;
Call GetAllPlayers();

-- Call PlayerQuit('Asterix');
*/