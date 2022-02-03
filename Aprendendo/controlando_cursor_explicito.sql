/*
	CURSOR EXPLICÍTO - ATRIBUTOS:
									* %ISOPEN: retorna TRUE se o cursor estiver aberto;
									* %NOTFOUND: retorna TRUE se o último FETCH não retornou uma linha;
									* %FOUND: retorna TRUE se o último FETCH retornou uma linha;
									* %ROWCOUNT: retorna o número de linhas recuperadas por FETCH até o momento.
*/

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE 
    CURSOR employees_cursor IS
    SELECT *
    FROM employees; -- Declaração do Cursor
    
    employees_record employees_cursor%rowtype; -- Declarando uma variável RECORD
BEGIN
    /* Inicializa */
    
    OPEN employees_cursor; -- o Oracle executa o select do cursor e colocar nas linhas da memória
    
    /* LOOP */
    
    LOOP -- Loop básico
        FETCH employees_cursor
        INTO employees_record; -- FETCH  do cursor
    EXIT WHEN employees_cursor%notfound; -- Testando se deu NOTFOUND
    
    /*Caso Não */
    
    DBMS_OUTPUT.PUT_LINE(employees_record.employee_id       || ' - ' ||
                         employees_record.first_name        || ' - ' ||
                         employees_record.last_name         || ' - ' ||
                         employees_record.department_id     || ' - ' ||
                         employees_record.job_id            || ' - ' ||
                         employees_record.phone_number      || ' - ' ||
                         LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));            
    END LOOP;
    
    CLOSE employees_cursor; -- fechando o cursor
    
END;