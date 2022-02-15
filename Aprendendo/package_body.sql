/* cria-se o PACKAGE BODY após criar o PACKAGE SPECIFICATION */
CREATE OR REPLACE PACKAGE BODY PCK_EMPREGADOS
IS 
    /* tem que ser exatamente igual a assinatura da PROCEDURE */
    /* corpo das PROCEDURES */
    PROCEDURE PRC_INSERE_EMPREGADO 
    (
        pfirst_name       IN VARCHAR2,
        plast_name        IN VARCHAR2,
        pemail            IN VARCHAR2,
        pphone_number     IN VARCHAR2,
        phire_date        IN DATE DEFAULT SYSDATE,
        pjob_id           IN VARCHAR2,
        psalary           IN NUMBER,
        pcommission_pct   IN NUMBER,
        pmanager_id       IN NUMBER,
        pdepartment_id    IN NUMBER
    )
    IS 
    /* nenhuma variável delcarada */
    BEGIN
        IF pSalary < PCK_EMPREGADOS.gMinSalary
            THEN 
                RAISE_APPLICATION_ERROR(-20002, 'Salario não pode ser inferior ao menor salario dos empregados!');
        END IF;
        
        INSERT INTO employees (
            employee_id,
            first_name,
            last_name,
            email,
            phone_number,
            hire_date,
            job_id,
            salary,
            commission_pct,
            manager_id,
            department_id)
        VALUES (
            employees_seq.nextval,
            pfirst_name,
            plast_name,
            pemail,
            pphone_number,
            phire_date,
            pjob_id,
            psalary,
            pcommission_pct,
            pmanager_id,
            pdepartment_id);            
        EXCEPTION 
            WHEN OTHERS THEN 
                RAISE_APPLICATION_ERROR(-20001, 'Erro Oracle: ' || SQLCODE || SQLERRM);
        END;                       
    PROCEDURE PRC_AUMENTA_SALARIO_EMPREGADO
    (
        pemployee_id IN NUMBER,
        ppercentual  IN NUMBER
    )
    IS
        /* nenhuma variável delcarada */
    BEGIN
        UPDATE employees
        SET salary = salary * ( 1 + ppercentual / 100)
      WHERE employee_id = pemployee_id;      
    EXCEPTION
        WHEN OTHERS
        THEN
            RAISE_APPLICATION_ERROR(-20001, 'Erro Oracle: ' || SQLCODE || SQLERRM);
    END;
     /* declarando uma FUNCTION publica */
    /* corpo da FUNCTION */
    FUNCTION PRC_AUMENTA_SALARIO_EMPREGADO
    ( pemployee_id IN NUMBER )
        RETURN NUMBER
    IS
        vSalary employees.salary%TYPE;
    BEGIN
        SELECT salary
          INTO vSalary
        FROM employees
       WHERE employee_id = pemployee_id;
     RETURN (vSalary);
     
     EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            RAISE_APPLICATION_ERROR(-20001, 'Empregado Inexistente');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle: ' || SQLCODE || SQLERRM);
    END;
/* procedimento de uma única execução na seção */
BEGIN 
    SELECT MIN(salary)
      INTO PCK_EMPREGADOS.gMinSalary
      FROM employees;
END  PCK_EMPREGADOS;
     