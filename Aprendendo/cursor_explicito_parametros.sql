/* CURSOR EXPLICÍTO COM PARÂMETROS */
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE 
    CURSOR employees_cursor (pDepartment_id NUMBER
                           , pJob_id VARCHAR2 )/* declarando os parâmetros */
    IS
    SELECT *
    FROM employees -- Declaração do Cursor
    WHERE 1 =1 
      AND department_id = pDepartment_id
      AND job_id = pJob_id;
BEGIN
    FOR employees_record IN employees_cursor(60, 'IT_PROG')/* valor dos parâmetros */
    LOOP 
        DBMS_OUTPUT.PUT_LINE(employees_record.employee_id       || ' - ' ||
                             employees_record.first_name        || ' - ' ||
                             employees_record.last_name         || ' - ' ||
                             employees_record.department_id     || ' - ' ||
                             employees_record.job_id            || ' - ' ||
                             employees_record.phone_number      || ' - ' ||
                             LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));
    END LOOP;
END;