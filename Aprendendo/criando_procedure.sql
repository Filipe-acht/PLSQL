/* PROCEDURE: é um bloco de comandos ou instruções SQL organizados para executar uma ou mais tarefas. */

CREATE OR REPLACE PROCEDURE PRC_INSERE_EMPREGADO
    (
        /* parâmetros de entrada */
        pfirst_name     IN VARCHAR2
    ,   plast_name      IN VARCHAR2
    ,   pemail          IN VARCHAR2
    ,   pphone_number   IN VARCHAR2
    ,   phire_date      IN DATE DEFAULT SYSDATE
    ,   pjob_id         IN VARCHAR2
    ,   psalary         IN NUMBER
    ,   pCOMMISSION_PCT IN NUMBER
    ,   pmanager_id     IN NUMBER
    ,   pdepartment_id  IN NUMBER
    )
IS 
    /* Nenhuma variável declarada */
BEGIN
    /* bloco de insert */
    INSERT INTO employees(
      employee_id
    , first_name
    , last_name
    , email
    , phone_number
    , hire_date
    , job_id
    , salary
    , COMMISSION_PCT
    , manager_id
    , department_id
    )
    VALUES(
      employees_seq.nextval
    , pfirst_name
    , plast_name
    , pemail
    , pphone_number
    , phire_date
    , pjob_id
    , psalary
    , pCOMMISSION_PCT
    , pmanager_id
    , pdepartment_id
    );
/* não faz commit, pois deixa a cargo do programa chamador */
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro Oracle ' || SQLCODE || SQLERRM);
END;

/* chamando a procedure */
BEGIN 
    PRC_INSERE_EMPREGADO('David'
                       , 'Bowie'
                       , 'dbowie'
                       , '515.127.4861'
                       , SYSDATE
                       , 'IT_PROG'
                       , 15000
                       , NULL
                       , 103
                       , 60);
COMMIT;
END;