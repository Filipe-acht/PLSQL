-- CURSOR EXPLICÍTO  com SELECT FOR UPDATE: ele vai fazer lock nas linhas até que o cursor seja fechado, cuidado! isso pode degradar a peformance.
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE 
    CURSOR employees_cursor (pJob_id VARCHAR2 )/* declarando os parâmetros */
    IS
    SELECT *
    FROM employees -- Declaração do Cursor
    WHERE 1 =1 
      AND job_id = pJob_id
    FOR UPDATE; -- vai fazer lock nas linhas do SELECT
BEGIN
    FOR employees_record IN employees_cursor('IT_PROG')/* valor do parâmetro */
    LOOP 
        UPDATE employees
        SET salary = salary * (1 + 10 / 100) -- aumentando salário em 10%
        WHERE  CURRENT OF employees_cursor; /* vai atualizar a linha corrente do cursor */
        /*DBMS_OUTPUT.PUT_LINE(employees_record.employee_id       || ' - ' ||
                             employees_record.first_name        || ' - ' ||
                             employees_record.last_name         || ' - ' ||
                             employees_record.department_id     || ' - ' ||
                             employees_record.job_id            || ' - ' ||
                             employees_record.phone_number      || ' - ' ||
                             LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));*/
    END LOOP;
    -- COMMIT;
END;
