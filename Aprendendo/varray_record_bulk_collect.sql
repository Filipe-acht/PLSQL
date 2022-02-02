-- VARRAY OF RECORD - BULK COLLECT
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE 
    TYPE employees_table_type IS VARRAY (200) 
    OF employees%rowtype;
    employees_table employees_table_type := employees_table_type(); -- Obrigatório inicializar
BEGIN
    SELECT * 
        BULK COLLECT INTO employees_table
    FROM employees;
    FOR i IN employees_table.first..employees_table.last
    LOOP 
        DBMS_OUTPUT.PUT_LINE(employees_table(I).EMPLOYEE_ID||' - ' ||
                             employees_table(I).LAST_NAME||' - '||
                             employees_table(I).PHONE_NUMBER||' - '||
                             employees_table(I).JOB_ID||' - '||
                             TO_CHAR(employees_table(I).SALARY,'99G999G999D99'));
    END LOOP;
END;