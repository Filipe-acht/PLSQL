SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE 
    CURSOR employees_cursor IS
    SELECT *
    FROM employees; -- Declaração do Cursor
BEGIN
    FOR employees_record IN employees_cursor -- declarando variável record
    LOOP 
        DBMS_OUTPUT.PUT_LINE(employees_record.employee_id       || ' - ' ||
                             employees_record.first_name        || ' - ' ||
                             employees_record.last_name         || ' - ' ||
                             employees_record.department_id     || ' - ' ||
                             employees_record.job_id            || ' - ' ||
                             employees_record.phone_number      || ' - ' ||
                             LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));
    END LOOP;-- quando der notfound, automaticamente sai do loop e o cursor será fechado 
END;

-- Outra forma
/*
SET SERVEROUTPUT ON
SET VERIFY OFF
BEGIN
    FOR employees_record IN ( SELECT * FROM employees)
    LOOP 
        DBMS_OUTPUT.PUT_LINE(employees_record.employee_id       || ' - ' ||
                             employees_record.first_name        || ' - ' ||
                             employees_record.last_name         || ' - ' ||
                             employees_record.department_id     || ' - ' ||
                             employees_record.job_id            || ' - ' ||
                             employees_record.phone_number      || ' - ' ||
                             LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));
    END LOOP;-- quando der notfound, automaticamente sai do loop e o cursor será fechado 
END;
*/