/* PRAGMA EXCEPTION_INIT: declarar um identificador do tipo EXCEPTION e associar ao Erro Oracle */
SET SERVEROUTPUT ON
SET VERIFY OFF -- para não exibir os comandos do bloco após a execução
DECLARE
    vFirst_name     employees.first_name%TYPE       := 'Robert';
    vLast_name      employees.last_name%TYPE        := 'Ford';
    vJob_id         employees.job_id%TYPE           := 'XX_YYYY';
    vPhone_number   employees.phone_number%TYPE     := '650.511.9844';
    vEmail          employees.email%TYPE            := 'RFORD';
    eFk_inexistente EXCEPTION; -- Declarando uma exception
    PRAGMA EXCEPTION_INIT(efk_inexistente, -2291); -- Vinculando a EXCEPTION ao erro Oracle (-2291): violçao de CONSTRAINT de FOREIGN KEY
    
BEGIN
    INSERT INTO employees (employee_id, first_name, last_name, phone_number, email, hire_date, job_id)
                VALUES(employees_seq.nextval,vFirst_name, vLast_name, vPhone_number, vEmail, sysdate, vJob_id);
    COMMIT;    
EXCEPTION
    WHEN efk_inexistente
    THEN
        -- para abortar o programa
        RAISE_APPLICATION_ERROR(-20003, 'Job inexistente!');
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle - ' || SQLCODE || SQLERRM);
END;