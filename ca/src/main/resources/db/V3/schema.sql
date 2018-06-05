--------------------------------------
-- SCHEMA
--------------------------------------
DROP SCHEMA IF EXISTS ACL CASCADE;

CREATE SCHEMA IF NOT EXISTS ACL;

--------------------------------------
-- USERS
--------------------------------------
CREATE TABLE IF NOT EXISTS ACL.USERS (
  ID IDENTITY NOT NULL PRIMARY KEY AUTO_INCREMENT,
  USERNAME VARCHAR(50) NOT NULL,
  PASSWORD VARCHAR(50) NOT NULL,
  ENABLED BOOLEAN NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS UK01_USERS
    ON ACL.USERS(USERNAME);

--------------------------------------
-- AUTHORITIES
--------------------------------------
CREATE TABLE IF NOT EXISTS ACL.AUTHORITIES (
  ID IDENTITY NOT NULL PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(50) NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS UK01_AUTHORITIES
    ON ACL.AUTHORITIES(NAME);

--------------------------------------
-- USERS_AUTHORITIES
--------------------------------------
CREATE TABLE IF NOT EXISTS ACL.USERS_AUTHORITIES (
  USERS_ID BIGINT NOT NULL,
  AUTHORITIES_ID BIGINT NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS UK01_USERS_AUTHORITIES 
    ON ACL.USERS_AUTHORITIES(USERS_ID, AUTHORITIES_ID);

ALTER TABLE IF EXISTS ACL.USERS_AUTHORITIES 
  ADD CONSTRAINT FK01_USERS_AUTHORITIES FOREIGN KEY(USERS_ID) REFERENCES ACL.USERS(ID);

ALTER TABLE IF EXISTS ACL.USERS_AUTHORITIES 
  ADD CONSTRAINT FK02_USERS_AUTHORITIES FOREIGN KEY(AUTHORITIES_ID) REFERENCES ACL.AUTHORITIES(ID);

--------------------------------------
-- GROUPS
--------------------------------------  
CREATE TABLE IF NOT EXISTS ACL.GROUPS (
  ID IDENTITY NOT NULL PRIMARY KEY AUTO_INCREMENT,
  NAME VARCHAR(50) NOT NULL
);
 
--------------------------------------
-- GROUP_AUTHORITIES
--------------------------------------  
CREATE TABLE IF NOT EXISTS ACL.GROUPS_AUTHORITIES (
  GROUPS_ID BIGINT NOT NULL,
  AUTHORITIES_ID BIGINT NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS UK01_GROUPS_AUTHORITIES
    ON ACL.GROUPS_AUTHORITIES(GROUPS_ID, AUTHORITIES_ID);

ALTER TABLE IF EXISTS ACL.GROUPS_AUTHORITIES 
  ADD CONSTRAINT FK01_GROUPS_AUTHORITIES FOREIGN KEY(GROUPS_ID) REFERENCES ACL.GROUPS(ID);

ALTER TABLE IF EXISTS ACL.GROUPS_AUTHORITIES 
  ADD CONSTRAINT FK02_GROUPS_AUTHORITIES FOREIGN KEY(AUTHORITIES_ID) REFERENCES ACL.AUTHORITIES(ID);

--------------------------------------
-- GROUPS_MEMBERS
--------------------------------------  
CREATE TABLE IF NOT EXISTS ACL.GROUPS_MEMBERS (
  GROUPS_ID BIGINT NOT NULL,
  USERS_ID BIGINT NOT NULL  
);  

CREATE UNIQUE INDEX IF NOT EXISTS UK01_GROUPS_MEMBERS
    ON ACL.GROUPS_MEMBERS(USERS_ID, GROUPS_ID);

ALTER TABLE IF EXISTS ACL.GROUPS_MEMBERS 
  ADD CONSTRAINT FK01_GROUPS_MEMBERS FOREIGN KEY(GROUPS_ID) REFERENCES ACL.GROUPS(ID);
	
ALTER TABLE IF EXISTS ACL.GROUPS_MEMBERS 
  ADD CONSTRAINT FK02_GROUPS_MEMBERS FOREIGN KEY(USERS_ID) REFERENCES ACL.USERS(ID);
 