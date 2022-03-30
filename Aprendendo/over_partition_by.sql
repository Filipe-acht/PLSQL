CREATE TABLE LIVRO (
	ID 		NUMBER(2) 		PRIMARY KEY,
	TITULO 	VARCHAR2(30) 	NOT NULL,
	GENERO 	VARCHAR2(20) 	NOT NULL,
	PRECO 	NUMBER(5,2) 	NOT NULL
);

/*
INSERT INTO LIVRO VALUES (1,'A Revolução dos Bichos', 'Ficção', 15);
INSERT INTO LIVRO VALUES (2,'Na Pior em Paris e Londres', 'Não-Ficção', 60);
INSERT INTO LIVROLIVRO VALUES (3,'Lutando na Espanha', 'Não-Ficção', 45);
INSERT INTO LIVRO VALUES (4,'A Flor da Inglaterra', 'Ficção', 45);
INSERT INTO LIVRO VALUES (5,'1984', 'Ficção', 40);*/

SELECT id, titulo, genero,
COUNT(*) OVER (PARTITION BY genero) qtd_genero
FROM LIVRO;



SELECT id, titulo, genero, preco,
avg(preco) OVER (PARTITION BY genero) media_preco,
max(preco) OVER (PARTITION BY genero) maior_preco,
min(preco) OVER (PARTITION BY genero) menor_preco
FROM LIVRO;
