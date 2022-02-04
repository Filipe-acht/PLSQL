/*
	Tratamento de Exceções: são eventos(erros) que podem ser tratados designando ações a serem tomadas quando uma exceção ocorre.
	Exceções Pré-definidas Oracle:
									* COLLECTION_IS_NULL	(ORA-06531) - aplicar métodos para uma collection não inicializada;
									* CURSOR_ALREADY_OPEN	(ORA-06511) - abrir um cursor que já está aberto;
									* DUP_VAL_ON_INDEX		(ORA-00001) -  inserir valor duplicado em um indice único;
									* INVALID_CURSOR		(ORA-01001) - operação ilegal em um cursor;
									* INVALID_NUMBER		(ORA-01722) - falha na conversão de string para numerico;
									* LOGIN_DENIED			(ORA-01017) - usuário/senha invalidos;
									* NO_DATA_FOUND			(ORA-01403) - select não retornou nenhuma linha;
									* NO_LOGGED_ON			(ORA-01012) - chamada ao BD sem estar conectado ao Oracle;
									* TIMEOUT_ON_RESOURCE	(ORA-00051) - timeout enquanto o oracle estava aguardando por um recurso;
									* TOO_MANY_ROWS			(ORA-01422) - select retornou mais de uma linha;
									* VALUE_ERROR			(ORA-06502) - erro de aritmética, conversão ou truncamento;
									* ZERO_DIVIDE			(ORA-01476) - tentativa de divisão por zero;
	RAISE_APPLICATION_ERROR: procedure para interromper a execução de um programa PL/SQL, o programa vai ser encerrado com a mensagem e código de erro.
		* Possui 3 parâmetros:
								** Um número: codigo de erro no intervalo de [-20000, -20999];
								** String: texto da mensagem de erro;
								** Boolean: opcional.
	SQLCODE(função): retorna o código de erro Oracle que disparou a Exceção
	SQLERRM(função): retorna a mensagem do erro Oracle que disparou a exceção.
*/
SET SERVEROUTPUT ON
SET VERIFY OFF -- para não exibir os comandos do bloco após a execução
ACCEPT pEmployee_id PROMPT 'Digite o Id do Empregrado: ' -- pedir pra ser digitado um valor para o parâmetro
DECLARE
    vFirst_name     employees.first_name%TYPE;
    vLast_name      employees.last_name%TYPE;
    vEmployee_id    employees.employee_id%TYPE := &pEmployee_id;
BEGIN
    SELECT first_name, last_name
      INTO vFirst_name, vLast_name
      FROM employees
    WHERE employee_id = vEmployee_id;
    
    DBMS_OUTPUT.PUT_LINE('Empregado: ' || vfirst_name || ' ' || vlast_name);
    
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        -- para abortar o programa
        RAISE_APPLICATION_ERROR(-20001, 'Empregado não encontrado, id = ' || 
        TO_CHAR(vEmployee_id));
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle - ' || SQLCODE || SQLERRM);
END;