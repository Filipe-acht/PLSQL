/*
	PARÂMETROS IN OUT: recebe um valor de entrada passado pelo programa chamador e devolve o valor(modificado ou não) como saída para o programa chamador.
						** IN: funcionam internamente por referência;
						** OUT e IN OUT: funcionam por cópia.
							*** para utilizar in out e out por referência, basta usar NOCOPY
*/
CREATE OR REPLACE PROCEDURE PRC_CONSULTA_EMPREGADO
    (
        /* parâmetros */
      pemployee_id      IN NUMBER
    , pfirst_name       OUT VARCHAR2
    , plast_name        OUT VARCHAR2
    , pemail            OUT VARCHAR2
    , pphone_number     OUT VARCHAR2
    , phire_date        OUT DATE
    , pjob_id           OUT VARCHAR2
    , psalary           OUT NUMBER
    , pcommission_pct    OUT NUMBER
    , pmanager_id       OUT NUMBER
    , pdepartment_id    OUT NUMBER
    )
IS 
    /* Nenhuma variável declarada */
BEGIN
    SELECT    first_name     
            , last_name      
            , email          
            , phone_number   
            , hire_date      
            , job_id         
            , salary         
            , commission_pct  
            , manager_id     
            , department_id
    INTO  pfirst_name    
        , plast_name     
        , pemail         
        , pphone_number  
        , phire_date     
        , pjob_id        
        , psalary        
        , pcommission_pct 
        , pmanager_id    
        , pdepartment_id
    FROM employees
   WHERE employee_id = pemployee_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Empregado Não Existe: ' ||pemployee_id);
    WHEN OTHERS THEN 
        RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle: ' || SQLCODE || SQLERRM);
END;

    /* USANDO NOCOPY */

CREATE OR REPLACE PROCEDURE PRC_CONSULTA_EMPREGADO
    (
        /* parâmetros */
      pemployee_id      IN NUMBER
    , pfirst_name       OUT NOCOPY VARCHAR2 /* NOCPY  para fazer referência */
    , plast_name        OUT NOCOPY VARCHAR2
    , pemail            OUT NOCOPY VARCHAR2
    , pphone_number     OUT NOCOPY VARCHAR2
    , phire_date        OUT NOCOPY DATE
    , pjob_id           OUT NOCOPY VARCHAR2
    , psalary           OUT NOCOPY NUMBER
    , pcommission_pct   OUT NOCOPY NUMBER
    , pmanager_id       OUT NOCOPY NUMBER
    , pdepartment_id    OUT NOCOPY NUMBER
    )
IS 
    /* Nenhuma variável declarada */
BEGIN
    SELECT    first_name     
            , last_name      
            , email          
            , phone_number   
            , hire_date      
            , job_id         
            , salary         
            , commission_pct  
            , manager_id     
            , department_id
    INTO  pfirst_name    
        , plast_name     
        , pemail         
        , pphone_number  
        , phire_date     
        , pjob_id        
        , psalary        
        , pcommission_pct 
        , pmanager_id    
        , pdepartment_id
    FROM employees
   WHERE employee_id = pemployee_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Empregado Não Existe: ' ||pemployee_id);
    WHEN OTHERS THEN 
        RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle: ' || SQLCODE || SQLERRM);
END;

/* EXECUTANDO A PROCEDURE PARÂMETRO TIPO OUT */

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE 
    employees_record    employees%ROWTYPE;
BEGIN 
    PRC_CONSULTA_EMPREGADO( 100
                          , employees_record.first_name
                          , employees_record.last_name
                          , employees_record.email
                          , employees_record.phone_number
                          , employees_record.hire_date
                          , employees_record.job_id
                          , employees_record.salary
                          , employees_record.commission_pct
                          , employees_record.manager_id
                          , employees_record.department_id
                          );
    DBMS_OUTPUT.PUT_LINE(employees_record.first_name || ' ' ||
                         employees_record.last_name || ' - '  ||
                         employees_record.department_id || ' - '  ||
                         employees_record.job_id || ' - '  ||
                         employees_record.phone_number || ' - '  ||
                         LTRIM(TO_CHAR(employees_record.salary, 'L99G999G999D99')));
END;
    
    
    
    
    