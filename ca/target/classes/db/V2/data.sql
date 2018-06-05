
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
INSERT INTO ACL1.FUNCIONALIDADE (ID,ID_FUNCIONALIDADE,DESCRICAO,ORDEM,ATIVO) VALUES (2,    1, 'Evento', 1, true);
INSERT INTO ACL1.FUNCIONALIDADE (ID,ID_FUNCIONALIDADE,DESCRICAO,ORDEM,ATIVO) VALUES (3,    1, 'Funcionalidade', 2, true);
INSERT INTO ACL1.FUNCIONALIDADE (ID,ID_FUNCIONALIDADE,DESCRICAO,ORDEM,ATIVO) VALUES (4,    1, 'Perfil', 3, true);
INSERT INTO ACL1.FUNCIONALIDADE (ID,ID_FUNCIONALIDADE,DESCRICAO,ORDEM,ATIVO) VALUES (5,    1, 'Permissao', 4, true);
INSERT INTO ACL1.FUNCIONALIDADE (ID,ID_FUNCIONALIDADE,DESCRICAO,ORDEM,ATIVO) VALUES (6,    1, 'Usuario', 5, true);
INSERT INTO ACL1.FUNCIONALIDADE (ID,ID_FUNCIONALIDADE,DESCRICAO,ORDEM,ATIVO) VALUES (7,    1, 'Relatorio', 6, true);

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
INSERT INTO ACL1.FUNCIONALIDADE_EVENTO (ID_FUNCIONALIDADE, ID_EVENTO) VALUES
-- EVENTO
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
-- FUNCIONALIDADE
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
-- PERFIL
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
-- PERMISSAO
(5, 2),
(5, 5),
-- USUARIO
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 5),
-- RELATORIO
(7, 2);

----------------------------------------------------------
-- COMPONENTS
----------------------------------------------------------
INSERT INTO ACL1.COMPONENTS (ID,ID_FUNCIONALIDADE,PATH,NAME,ICON,COMPONENT,SIDEBAR,COLLAPSED) VALUES 
(1, 1, '/painel', 'Controle de Acesso', 'ti-panel', '/Dashboard/Layout/DashboardLayout', true, true),
(2, 2, '/evento/index', 'Evento', NULL, '/Dashboard/Views/ControleAcesso/Evento/Index', true, false),
(3, 2, '/evento/list', 'EventoList', NULL, '/Dashboard/Views/ControleAcesso/Evento/List', false, false),
(4, 2, '/evento/merge', 'EventoMerge', NULL, '/Dashboard/Views/ControleAcesso/Evento/Merge', false, false),
(5, 3, '/funcionalidade/index', 'Funcionalidade', NULL, '/Dashboard/Views/ControleAcesso/Funcionalidade/Index', true, false),
(6, 3, '/funcionalidade/list', 'FuncionalidadeList', NULL, '/Dashboard/Views/ControleAcesso/Funcionalidade/List', false, false),
(7, 3, '/funcionalidade/merge', 'FuncionalidadeMerge', NULL, '/Dashboard/Views/ControleAcesso/Funcionalidade/Merge', false, false),
(8, 4, '/perfil/index', 'Perfil', NULL, '/Dashboard/Views/ControleAcesso/Perfil/Index', true, false),
(9, 4, '/perfil/list', 'PerfilList', NULL, '/Dashboard/Views/ControleAcesso/Perfil/List', false, false),
(10,4, '/perfil/merge', 'PerfilMerge', NULL, '/Dashboard/Views/ControleAcesso/Perfil/Merge', false, false),
(11,5, '/permissao/index', 'Permissao', NULL, '/Dashboard/Views/ControleAcesso/Permissao/Index', true, false),
(12,5, '/permissao/list', 'PermissaoList', NULL, '/Dashboard/Views/ControleAcesso/Permissao/List', false, false),
(13,6, '/usuario/index', 'Usuario', NULL, '/Dashboard/Views/ControleAcesso/Usuario/Index', true, false),
(14,6, '/usuario/list', 'UsuarioList', NULL, '/Dashboard/Views/ControleAcesso/Usuario/List', false, false),
(15,6, '/usuario/merge', 'UsuarioMerge', NULL, '/Dashboard/Views/ControleAcesso/Usuario/Merge', false, false),
(16,7, '/relatorio7', 'Relatorio', NULL, '/Dashboard/Views/Relatorio/Relatorio', true, false);

----------------------------------------------------------
-- PERMISSAO
----------------------------------------------------------
-- ADMIN
INSERT INTO ACL1.PERMISSAO (ID_PERFIL, ID_FUNCIONALIDADE, ID_EVENTO) VALUES
-- EVENTO
(1, 2, 1),
(1, 2, 2),
(1, 2, 3),
(1, 2, 4),
(1, 2, 5),
-- FUNCIONALIDADE
(1, 3, 1),
(1, 3, 2),
(1, 3, 3),
(1, 3, 4),
(1, 3, 5),
-- PERFIL
(1, 4, 1),
(1, 4, 2),
(1, 4, 3),
(1, 4, 4),
(1, 4, 5),
-- PERMISSAO
(1, 5, 2),
(1, 5, 5),
-- USUARIO
(1, 6, 1),
(1, 6, 2),
(1, 6, 3),
(1, 6, 4),
(1, 6, 5),
-- RELATORIO
(1, 7, 2);

-- CONSULTA
INSERT INTO ACL1.PERMISSAO (ID_PERFIL, ID_FUNCIONALIDADE, ID_EVENTO) VALUES
-- PERMISSAO
(2, 4, 2),
-- PERMISSAO
(2, 5, 2),
-- USUARIO
(2, 6, 2);

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
(15, 6, 5), -- MERGE

(16, 7, 2); -- RELATORIO
