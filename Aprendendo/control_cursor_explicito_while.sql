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
    
     FETCH employees_cursor
        INTO employees_record; -- FETCH  do cursor
    /* LOOP */
    -- executar até dar notfound
    WHILE employees_cursor%found LOOP -- quando encontrar uma linha    
        DBMS_OUTPUT.PUT_LINE(employees_record.employee_id       || ' - ' ||
                             employees_record.first_name        || ' - ' ||
                             employees_record.last_name         || ' - ' ||
                             employees_record.department_id     || ' - ' ||
                             employees_record.job_id            || ' - ' ||
                             employees_record.phone_number      || ' - ' ||
                             LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));
        FETCH employees_cursor -- fetch da próxima linha
            INTO employees_record;
    END LOOP;
    
    CLOSE employees_cursor; -- fechando o cursor
    
END;