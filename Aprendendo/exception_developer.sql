/* Exceções definidas pelo Desenvolvedor: através do comando RAISE */
SET SERVEROUTPUT ON
SET VERIFY OFF -- para não exibir os comandos do bloco após a execução
ACCEPT pEmployee_id PROMPT 'Digite o Id do Empregrado: ' -- pedir pra ser digitado um valor para o parâmetro
DECLARE
    vFirst_name     employees.first_name%TYPE;
    vLast_name      employees.last_name%TYPE;
    vJob_id         employees.job_id%TYPE;
    vEmployee_id    employees.employee_id%TYPE := &pEmployee_id;
    ePresident EXCEPTION; -- Declarando uma exception
BEGIN
    SELECT first_name, last_name, job_id
      INTO vFirst_name, vLast_name, vJob_id
      FROM employees
    WHERE employee_id = vEmployee_id;
    
    /* CONDIÇÃO */
    
    IF vJob_id  = 'AD_PRES'
    THEN
        RAISE ePresident; -- dispare essa exceção
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
        -- para abortar o programa
        RAISE_APPLICATION_ERROR(-20001, 'Empregado não encontrado, id = ' || 
        TO_CHAR(vEmployee_id));
        -- se a execeção for ePresident
    WHEN ePresident
    THEN 
        UPDATE employees
        SET    salary = salary * 1.5 -- dará um aumento salarial
        WHERE employee_id = vEmployee_id;
        COMMIT ;
    WHEN OTHERS
    THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle - ' || SQLCODE || SQLERRM);
END;