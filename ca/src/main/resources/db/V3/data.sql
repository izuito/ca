----------------------------------------------------------
-- USERS
----------------------------------------------------------
INSERT INTO ACL.USERS (ID, USERNAME, PASSWORD, ENABLED) VALUES 
(1, 'admin', '123', true);

----------------------------------------------------------
-- AUTHORITIES
----------------------------------------------------------
INSERT INTO ACL.AUTHORITIES (ID, NAME) VALUES 
(1, 'admin');

----------------------------------------------------------
-- USERS_AUTHORITIES
----------------------------------------------------------
INSERT INTO ACL.USERS_AUTHORITIES (USERS_ID, AUTHORITIES_ID) VALUES 
(1, 1);

----------------------------------------------------------
-- GROUPS
----------------------------------------------------------
INSERT INTO ACL.GROUPS (ID, NAME) VALUES 
(1, 'GROUPS_ADMIN');

----------------------------------------------------------
-- GROUPS_AUTHORITIES
----------------------------------------------------------
INSERT INTO ACL.GROUPS_AUTHORITIES (GROUPS_ID, AUTHORITIES_ID) VALUES 
(1, 1);

----------------------------------------------------------
-- GROUPS_MEMBERS
----------------------------------------------------------
INSERT INTO ACL.GROUPS_MEMBERS (GROUPS_ID, USERS_ID) VALUES
(1, 1);
