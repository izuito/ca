--------------------------------------
-- SCHEMA
--------------------------------------
DROP SCHEMA IF EXISTS ACL CASCADE;

CREATE SCHEMA IF NOT EXISTS ACL;

--------------------------------------
-- USUARIO
--------------------------------------
CREATE TABLE IF NOT EXISTS ACL.USUARIO (
  ID IDENTITY NOT NULL PRIMARY KEY AUTO_INCREMENT,
  NOME VARCHAR(50) NOT NULL,
  SENHA VARCHAR(50) NOT NULL,
  ATIVO BOOLEAN NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS UK01_USUARIO
    ON ACL.USUARIO(NOME);

--------------------------------------
-- PERFIL
--------------------------------------
CREATE TABLE IF NOT EXISTS ACL.PERFIL (
  ID IDENTITY NOT NULL PRIMARY KEY AUTO_INCREMENT,
  NOME VARCHAR(50) NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS UK01_PERFIL
    ON ACL.PERFIL(NOME);

--------------------------------------
-- USUARIO_PERFIL
--------------------------------------
CREATE TABLE IF NOT EXISTS ACL.USUARIO_PERFIL (
  ID_USUARIO BIGINT NOT NULL,
  ID_PERFIL BIGINT NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS UK01_USUARIO_PERFIL 
    ON ACL.USUARIO_PERFIL(ID_USUARIO, ID_PERFIL);

ALTER TABLE IF EXISTS ACL.USUARIO_PERFIL 
  ADD CONSTRAINT FK01_USUARIO_PERFIL FOREIGN KEY(ID_USUARIO) REFERENCES ACL.USUARIO(ID);

ALTER TABLE IF EXISTS ACL.USUARIO_PERFIL 
  ADD CONSTRAINT FK02_USUARIO_PERFIL FOREIGN KEY(ID_PERFIL) REFERENCES ACL.PERFIL(ID);

--------------------------------------
-- FUNCIONALIDADE
--------------------------------------
CREATE TABLE IF NOT EXISTS ACL.FUNCIONALIDADE (
    ID IDENTITY PRIMARY KEY AUTO_INCREMENT,
    ID_FUNCIONALIDADE BIGINT NULL,
    DESCRICAO VARCHAR(254),
    ORDEM INT    
);

ALTER TABLE IF EXISTS ACL.FUNCIONALIDADE 
  ADD CONSTRAINT FK01_FUNCIONALIDADE FOREIGN KEY(ID_FUNCIONALIDADE) REFERENCES ACL.FUNCIONALIDADE(ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE;   

--------------------------------------
-- EVENTO
--------------------------------------
CREATE TABLE IF NOT EXISTS ACL.EVENTO (
    ID IDENTITY PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(50) NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS UK01_EVENTO 
    ON ACL.EVENTO(NOME);

--------------------------------------
-- FUNCIONALIDADE_EVENTO
--------------------------------------
CREATE TABLE IF NOT EXISTS ACL.FUNCIONALIDADE_EVENTO (
    ID_FUNCIONALIDADE BIGINT NOT NULL,
    ID_EVENTO BIGINT NOT NULL
);

ALTER TABLE IF EXISTS ACL.FUNCIONALIDADE_EVENTO 
  ADD CONSTRAINT PK_FUNCIONALIDADE_EVENTO PRIMARY KEY(ID_FUNCIONALIDADE, ID_EVENTO);

ALTER TABLE IF EXISTS ACL.FUNCIONALIDADE_EVENTO 
  ADD CONSTRAINT FK01_FUNCIONALIDADE_EVENTO FOREIGN KEY(ID_FUNCIONALIDADE) REFERENCES ACL.FUNCIONALIDADE(ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE;   

ALTER TABLE IF EXISTS ACL.FUNCIONALIDADE_EVENTO 
  ADD CONSTRAINT FK02_FUNCIONALIDADE_EVENTO FOREIGN KEY(ID_EVENTO) REFERENCES ACL.EVENTO(ID);

--------------------------------------
-- COMPONENTS
--------------------------------------
CREATE TABLE IF NOT EXISTS ACL.COMPONENTS (
    ID IDENTITY PRIMARY KEY AUTO_INCREMENT,
    ID_FUNCIONALIDADE BIGINT NOT NULL,
    PATH VARCHAR(254),
    NAME VARCHAR(100),
    COMPONENT VARCHAR(100),
    ICON VARCHAR(50),
    SIDEBAR BOOLEAN,
    COLLAPSED BOOLEAN
);

ALTER TABLE IF EXISTS ACL.COMPONENTS 
  ADD CONSTRAINT FK01_COMPONENTS FOREIGN KEY(ID_FUNCIONALIDADE) REFERENCES ACL.FUNCIONALIDADE(ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE;    

--------------------------------------
-- PERMISSAO
--------------------------------------
CREATE TABLE IF NOT EXISTS ACL.PERMISSAO (
    ID_PERFIL BIGINT NOT NULL,
    ID_FUNCIONALIDADE BIGINT NOT NULL,
    ID_EVENTO BIGINT NOT NULL
);

ALTER TABLE IF EXISTS ACL.PERMISSAO 
  ADD CONSTRAINT PK_PERMISSAO PRIMARY KEY(ID_PERFIL, ID_FUNCIONALIDADE, ID_EVENTO);

ALTER TABLE IF EXISTS ACL.PERMISSAO 
  ADD CONSTRAINT FK01_PERMISSAO FOREIGN KEY(ID_PERFIL) REFERENCES ACL.PERFIL(ID);

ALTER TABLE IF EXISTS ACL.PERMISSAO 
  ADD CONSTRAINT FK02_PERMISSAO FOREIGN KEY(ID_FUNCIONALIDADE, ID_EVENTO) REFERENCES ACL.FUNCIONALIDADE_EVENTO(ID_FUNCIONALIDADE, ID_EVENTO);

--------------------------------------
-- COMPONENTS_FUNCIONALIDADE_EVENTO
--------------------------------------
CREATE TABLE IF NOT EXISTS ACL.COMPONENTS_FUNCIONALIDADE_EVENTO (
    ID_COMPONENTS BIGINT NOT NULL,
    ID_FUNCIONALIDADE BIGINT NOT NULL,
    ID_EVENTO BIGINT NOT NULL
);

ALTER TABLE IF EXISTS ACL.COMPONENTS_FUNCIONALIDADE_EVENTO 
  ADD CONSTRAINT PK_COMPONENTS_FUNCIONALIDADE_EVENTO PRIMARY KEY(ID_COMPONENTS, ID_FUNCIONALIDADE, ID_EVENTO);

ALTER TABLE IF EXISTS ACL.COMPONENTS_FUNCIONALIDADE_EVENTO 
  ADD CONSTRAINT FK01_COMPONENTS_FUNCIONALIDADE_EVENTO FOREIGN KEY(ID_COMPONENTS) REFERENCES ACL.COMPONENTS(ID);

ALTER TABLE IF EXISTS ACL.COMPONENTS_FUNCIONALIDADE_EVENTO 
  ADD CONSTRAINT FK02_COMPONENTS_FUNCIONALIDADE_EVENTO FOREIGN KEY(ID_FUNCIONALIDADE, ID_EVENTO) REFERENCES ACL.FUNCIONALIDADE_EVENTO(ID_FUNCIONALIDADE, ID_EVENTO)
   ON DELETE CASCADE
   ON UPDATE CASCADE;   

--------------------------------------
-- GRUPO
--------------------------------------  
CREATE TABLE IF NOT EXISTS ACL.GRUPO (
  ID IDENTITY NOT NULL PRIMARY KEY AUTO_INCREMENT,
  NOME VARCHAR(50) NOT NULL
);
 
--------------------------------------
-- GROUP_PERFIL
--------------------------------------  
CREATE TABLE IF NOT EXISTS ACL.GRUPO_PERFIL (
  ID_GRUPO BIGINT NOT NULL,
  ID_PERFIL BIGINT NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS UK01_GRUPO_PERFIL
    ON ACL.GRUPO_PERFIL(ID_GRUPO, ID_PERFIL);

ALTER TABLE IF EXISTS ACL.GRUPO_PERFIL 
  ADD CONSTRAINT FK01_GRUPO_PERFIL FOREIGN KEY(ID_GRUPO) REFERENCES ACL.GRUPO(ID);

ALTER TABLE IF EXISTS ACL.GRUPO_PERFIL 
  ADD CONSTRAINT FK02_GRUPO_PERFIL FOREIGN KEY(ID_PERFIL) REFERENCES ACL.PERFIL(ID);

--------------------------------------
-- GRUPO_USUARIO
--------------------------------------  
CREATE TABLE IF NOT EXISTS ACL.GRUPO_USUARIO (
  ID_GRUPO BIGINT NOT NULL,
  ID_USUARIO BIGINT NOT NULL  
);  

CREATE UNIQUE INDEX IF NOT EXISTS UK01_GRUPO_USUARIO
    ON ACL.GRUPO_USUARIO(ID_USUARIO, ID_GRUPO);

ALTER TABLE IF EXISTS ACL.GRUPO_USUARIO 
  ADD CONSTRAINT FK01_GRUPO_USUARIO FOREIGN KEY(ID_GRUPO) REFERENCES ACL.GRUPO(ID);
	
ALTER TABLE IF EXISTS ACL.GRUPO_USUARIO 
  ADD CONSTRAINT FK02_GRUPO_USUARIO FOREIGN KEY(ID_USUARIO) REFERENCES ACL.USUARIO(ID);
 