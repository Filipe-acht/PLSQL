--Criando um bloco anônimo

DECLARE
	--Criando o CURSOR Explicito:
	CURSOR c_func
	IS
	--Vai armazenar essa consulta
		SELECT NOME_FUNC, SALARIO_FUNC
			FROM FUNCIONARIO;
--Uso de variável que vai herdar todos os dados extraidos pelo cursor 			
--ROWTYPE faz com que a variável c_func tenha acesso as duas colunas passadas no SELECT
v_func c_func%ROWTYPE;
			
BEGIN
	--Abrir o cursor
	OPEN c_func;
		LOOP
			-- Com fetch(pego) tudo que estiver dentro do meu cursor;
			-- Com into(introduzo) tudo na variável.
			FETCH c_func INTO v_func;
			-- Sair do laço quando o cursor não encontrar nada
			EXIT WHEN c_func%NOTFOUND; 
		--Percorrer o cursor e mostrar os dados
		DBMS_OUTPUT.PUT_LINE(v_func.NOME_FUNC || ' ' || v_func.salario_func);
			
		END LOOP;
	--Fechar o Cursor
	CLOSE c_func;
END;
	
	