
----------------------------------------------------------
-- USUARIO
----------------------------------------------------------
INSERT INTO ACL1.USUARIO (ID,LOGIN,SENHA,NOME,EMAIL,ATIVO) VALUES 
(1,'admin','def26a506aee8f5db865a34f934046dd88e9b2dad6699a18ad7d090764340ce00ca0d33a054727ba','Administrador','admin@ca.com',true),
(2,'consulta','def26a506aee8f5db865a34f934046dd88e9b2dad6699a18ad7d090764340ce00ca0d33a054727ba','Consultar','consulta@ca.com',true);

----------------------------------------------------------
-- PERFIL
----------------------------------------------------------
INSERT INTO ACL1.PERFIL (ID,NOME,DESCRICAO) VALUES 
(1,'admin','Administrador'),
(2,'consulta','Consulta');

----------------------------------------------------------
-- USUARIO PERFIL
----------------------------------------------------------
INSERT INTO ACL1.USUARIO_PERFIL VALUES 
(1,1),
(2,2);

----------------------------------------------------------
-- FUNCIONALIDADE
----------------------------------------------------------
INSERT INTO ACL1.FUNCIONALIDADE (ID,ID_FUNCIONALIDADE,DESCRICAO,ORDEM,ATIVO) VALUES (1, NULL, 'Controle de Acesso', 1, true);
INSERT INTO ACL1.FUNCIONALIDADE (ID,ID_FUNCIONALIDADE,DESCRICAO,ORDEM,ATIVO) VALUES (2, 1, 'Evento', 1, true);
INSERT INTO ACL1.FUNCIONALIDADE (ID,ID_FUNCIONALIDADE,DESCRICAO,ORDEM,ATIVO) VALUES (3, 1, 'Funcionalidade', 2, true);
INSERT INTO ACL1.FUNCIONALIDADE (ID,ID_FUNCIONALIDADE,DESCRICAO,ORDEM,ATIVO) VALUES (4, 1, 'Perfil', 3, true);
INSERT INTO ACL1.FUNCIONALIDADE (ID,ID_FUNCIONALIDADE,DESCRICAO,ORDEM,ATIVO) VALUES (5, 1, 'Permissao', 4, true);
INSERT INTO ACL1.FUNCIONALIDADE (ID,ID_FUNCIONALIDADE,DESCRICAO,ORDEM,ATIVO) VALUES (6, 1, 'Usuario', 5, true);

----------------------------------------------------------
-- EVENTO
----------------------------------------------------------
INSERT INTO ACL1.EVENTO (ID,NOME,DESCRICAO,ATIVO) VALUES (1,'create','Criacao de Dado',true);
INSERT INTO ACL1.EVENTO (ID,NOME,DESCRICAO,ATIVO) VALUES (2,'read','Leitura de Dado',true);
INSERT INTO ACL1.EVENTO (ID,NOME,DESCRICAO,ATIVO) VALUES (3,'update','Atualizacao de Dado',true);
INSERT INTO ACL1.EVENTO (ID,NOME,DESCRICAO,ATIVO) VALUES (4,'delete','Exclusao de Dado',true);
INSERT INTO ACL1.EVENTO (ID,NOME,DESCRICAO,ATIVO) VALUES (5,'save','Salvar de Dado',true);

----------------------------------------------------------
-- FUNCIONALIDADE EVENTO
----------------------------------------------------------
INSERT INTO ACL1.FUNCIONALIDADE_EVENTO (ID_FUNCIONALIDADE, ID_EVENTO)
SELECT F.ID, E.ID 
  FROM ACL1.FUNCIONALIDADE F
 CROSS JOIN ACL1.EVENTO E
 WHERE F.ID BETWEEN 2 AND 6;

----------------------------------------------------------
-- COMPONENTS
----------------------------------------------------------
INSERT INTO ACL1.COMPONENTS (ID_FUNCIONALIDADE,PATH,NAME,ICON,COMPONENT,SIDEBAR,COLLAPSED) VALUES 
(1, '/painel', 'Controle de Acesso', 'ti-panel', '/Dashboard/Layout/DashboardLayout', true, true),
(2, '/evento/index', 'Evento', NULL, '/Dashboard/Views/ControleAcesso/Evento/Index', true, false),
(2, '/evento/list', 'EventoList', NULL, '/Dashboard/Views/ControleAcesso/Evento/List', false, false),
(2, '/evento/merge', 'EventoMerge', NULL, '/Dashboard/Views/ControleAcesso/Evento/Merge', false, false),
(3, '/funcionalidade/index', 'Funcionalidade', NULL, '/Dashboard/Views/ControleAcesso/Funcionalidade/Index', true, false),
(3, '/funcionalidade/list', 'FuncionalidadeList', NULL, '/Dashboard/Views/ControleAcesso/Funcionalidade/List', false, false),
(3, '/funcionalidade/merge', 'FuncionalidadeMerge', NULL, '/Dashboard/Views/ControleAcesso/Funcionalidade/Merge', false, false),
(4, '/perfil/index', 'Perfil', NULL, '/Dashboard/Views/ControleAcesso/Perfil/Index', true, false),
(4, '/perfil/list', 'PerfilList', NULL, '/Dashboard/Views/ControleAcesso/Perfil/List', false, false),
(4, '/perfil/merge', 'PerfilMerge', NULL, '/Dashboard/Views/ControleAcesso/Perfil/Merge', false, false),
(5, '/permissao/index', 'Permissao', NULL, '/Dashboard/Views/ControleAcesso/Permissao/Index', true, false),
(5, '/permissao/list', 'PermissaoList', NULL, '/Dashboard/Views/ControleAcesso/Permissao/List', false, false),
(6, '/usuario/index', 'Usuario', NULL, '/Dashboard/Views/ControleAcesso/Usuario/Index', true, false),
(6, '/usuario/list', 'UsuarioList', NULL, '/Dashboard/Views/ControleAcesso/Usuario/List', false, false),
(6, '/usuario/merge', 'UsuarioMerge', NULL, '/Dashboard/Views/ControleAcesso/Usuario/Merge', false, false);

----------------------------------------------------------
-- COMPONENTS FUNCIONALIDADE EVENTO
----------------------------------------------------------
INSERT INTO ACL1.COMPONENTS_FUNCIONALIDADE_EVENTO (ID_COMPONENTS, ID_FUNCIONALIDADE, ID_EVENTO) VALUES
(2, 2, 1), -- INDEX
(2, 2, 2), -- INDEX
(3, 2, 3), -- LIST
(3, 2, 4), -- LIST
(4, 2, 5), -- MERGE

(5, 3, 1), -- INDEX
(5, 3, 2), -- INDEX
(6, 3, 3), -- LIST
(6, 3, 4), -- LIST
(7, 3, 5), -- MERGE

(8, 4, 1), -- INDEX
(8, 4, 2), -- INDEX
(9, 4, 3), -- LIST
(9, 4, 4), -- LIST
(10, 4, 5), -- MERGE

(11, 5, 2), -- INDEX
(12, 5, 5), -- LIST

(13, 6, 1), -- INDEX
(13, 6, 2), -- INDEX
(14, 6, 3), -- LIST
(14, 6, 4), -- LIST
(15, 6, 5); -- MERGE

----------------------------------------------------------
-- PERMISSAO
----------------------------------------------------------
INSERT INTO ACL1.PERMISSAO (ID_PERFIL, ID_FUNCIONALIDADE, ID_EVENTO)
SELECT P.ID AS ID_PERFIL, FE.ID_FUNCIONALIDADE, FE.ID_EVENTO  
  FROM ACL1.PERFIL P
 CROSS JOIN ACL1.FUNCIONALIDADE_EVENTO FE
 WHERE P.ID = 1;

INSERT INTO ACL1.PERMISSAO (ID_PERFIL, ID_FUNCIONALIDADE, ID_EVENTO) VALUES
(2, 4, 2),
(2, 5, 2),
(2, 6, 2);

