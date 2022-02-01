/* INSERT COM PLSQL*/
DECLARE 
	vChapa <tabela>.plsq_learning.chapa%TYPE := '028139';
	vNome <tabela>.plsq_learning.nome%TYPE   := 'Emily Costa Soares';
	vSalario <tabela>.plsq_learning.salario%TYPE := 15008.97;
BEGIN 
	INSERT INTO <tabela>.plsq_learning(id, nome, chapa, salario) VALUES (<sequence>.seq_plsql_learning.nextval, vNome,vChapa, vSalario);
END;