/*
Com um cursor é possível selecionar um conjunto de linhas e manipular o resultado desta consulta linha a linha,
dentro de um código PL/SQL (Program Language SQL),como:
 * procedures,
 * triggers,
 * blocos de código PL/SQL...
*/

--Criando um bloco anônimo

DECLARE
	--Criando o CURSOR Explicito:
	CURSOR c_func
	IS
	--Vai armazenar essa consulta
		SELECT NOME_FUNC, SALARIO_FUNC
			FROM FUNCIONARIO;
			
BEGIN
	--Fazendo um laço de repetição;
	--Definir uma variável que vai acessar o cursor:
	FOR v_func IN c_func
		LOOP
			--Percorrer o cursor e mostrar os dados
			DBMS_OUTPUT.PUT_LINE(v_func.NOME_FUNC || ' ' || v_func.salario_func);
			
		END LOOP;
	


END;