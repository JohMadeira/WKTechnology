CREATE DATABASE WKTECHNOLOGY;

USE WKTECHNOLOGY;

CREATE TABLE CLIENTES(
	CODIGO INTEGER PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL,
    CIDADE VARCHAR (50) NOT NULL,
    UF CHAR(2) NOT NULL
);

INSERT INTO CLIENTES VALUES
(1, 'Ana Silva', 'São Paulo', 'SP'),
(2, 'Bruno Costa', 'Rio de Janeiro', 'RJ'),
(3, 'Carla Souza', 'Belo Horizonte', 'MG'),
(4, 'Daniel Oliveira', 'Porto Alegre', 'RS'),
(5, 'Eduardo Lima', 'Curitiba', 'PR'),
(6, 'Fernanda Alves', 'Salvador', 'BA'),
(7, 'Gabriel Pereira', 'Fortaleza', 'CE'),
(8, 'Helena Rocha', 'Brasília', 'DF'),
(9, 'Igor Mendes', 'Manaus', 'AM'),
(10, 'Juliana Santos', 'Recife', 'PE'),
(11, 'Lucas Ferreira', 'Belém', 'PA'),
(12, 'Mariana Gomes', 'Goiânia', 'GO'),
(13, 'Nicolas Ribeiro', 'Florianópolis', 'SC'),
(14, 'Olivia Martins', 'Vitória', 'ES'),
(15, 'Pedro Almeida', 'Campo Grande', 'MS'),
(16, 'Quintino Barbosa', 'São Luís', 'MA'),
(17, 'Rafaela Cardoso', 'Maceió', 'AL'),
(18, 'Samuel Teixeira', 'Natal', 'RN'),
(19, 'Tatiana Fernandes', 'João Pessoa', 'PB'),
(20, 'Vinícius Araújo', 'Aracaju', 'SE');

CREATE TABLE PRODUTOS(
	CODIGO INTEGER PRIMARY KEY,
    DESCRICAO VARCHAR (50) NOT NULL,    
    PRECO FLOAT NOT NULL
);

INSERT INTO PRODUTOS VALUES
(1, 'Caneta Esferográfica', 1.50),
(2, 'Lápis', 0.80),
(3, 'Borracha', 0.60),
(4, 'Apontador', 1.20),
(5, 'Caderno', 10.00),
(6, 'Bloco de Notas', 5.00),
(7, 'Marcador de Texto', 3.50),
(8, 'Grampeador', 15.00),
(9, 'Caixa de Grampos', 2.50),
(10, 'Tesoura', 7.00),
(11, 'Régua', 2.00),
(12, 'Cola Branca', 3.00),
(13, 'Fita Adesiva', 4.00),
(14, 'Papel Sulfite', 20.00),
(15, 'Pasta Plástica', 2.50),
(16, 'Envelope', 1.00),
(17, 'Clips de Papel', 1.50),
(18, 'Prendedor de Papel', 2.00),
(19, 'Calculadora', 25.00),
(20, 'Agenda', 12.00),
(21, 'Carimbo', 8.00),
(22, 'Tinta para Carimbo', 5.00),
(23, 'Papel Cartão', 3.00),
(24, 'Papel Crepom', 2.00),
(25, 'Papel Contact', 6.00),
(26, 'Papel Vegetal', 4.00),
(27, 'Papel A4', 15.00),
(28, 'Papel A3', 25.00),
(29, 'Papel A5', 10.00),
(30, 'Pasta Suspensa', 3.00),
(31, 'Porta Lápis', 5.00),
(32, 'Porta Canetas', 4.00),
(33, 'Porta Clips', 3.00),
(34, 'Porta Documentos', 8.00),
(35, 'Porta Cartões', 6.00),
(36, 'Porta Recados', 4.00),
(37, 'Porta Etiquetas', 5.00),
(38, 'Porta CDs', 7.00),
(39, 'Porta DVDs', 8.00),
(40, 'Porta Revistas', 10.00);

CREATE TABLE VENDAS(
	NUMERO_PEDIDO INTEGER PRIMARY KEY,
    DATA_EMISSAO DATETIME NOT NULL,
    CODIGO_CLIENTE INTEGER NOT NULL,
    VALOR_TOTAL FLOAT NOT NULL,
    FOREIGN KEY (CODIGO_CLIENTE) REFERENCES CLIENTES(CODIGO)    
);

CREATE TABLE VENDAS_PRODUTOS(
	CODIGO INTEGER PRIMARY KEY AUTO_INCREMENT,
    NUMERO_PEDIDO INTEGER,
    CODIGO_PRODUTO INTEGER,
    QUANTIDADE INTEGER,
    VALOR_UNITARIO FLOAT,
    VALOR_TOTAL FLOAT,
    FOREIGN KEY (NUMERO_PEDIDO) REFERENCES VENDAS(NUMERO_PEDIDO),
    FOREIGN KEY (CODIGO_PRODUTO) REFERENCES PRODUTOS(CODIGO)
);
GRANT ALL PRIVILEGES ON wktechnology.* TO 'root'@'localhost';
FLUSH PRIVILEGES;