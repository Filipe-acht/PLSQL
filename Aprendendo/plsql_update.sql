/*UPDATE COM PLSQL*/
DECLARE 
	vChapa <tabela>.plsq_learning.chapa%TYPE := '028140';
	vNome <tabela>.plsq_learning.nome%TYPE   := 'Emily Soares Costa';
	vSalario <tabela>.plsq_learning.salario%TYPE := 15008.00;
BEGIN 
	UPDATE <tabela>.plsq_learning l
	SET l.nome 	  = vNome
	  , l.chapa   = vChapa
	  , l.salario = vSalario
	WHERE l.id = 3;
END;