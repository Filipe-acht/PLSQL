/* Criando o PACKAGE SPECIFICATION */
CREATE OR REPLACE PACKAGE PCK_EMPREGADOS
IS
    gMinSalary employees.salary%TYPE; /* variável global */
    /* publica permite referenciar fora da package */
    /* declarando a procedure publica  */
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
    );
    
    PROCEDURE PRC_AUMENTA_SALARIO_EMPREGADO
    (
        pemployee_id IN NUMBER,
        ppercentual  IN NUMBER
    );
    
    /* declarando uma FUNCTION publica */
    FUNCTION PRC_AUMENTA_SALARIO_EMPREGADO
    ( pemployee_id IN NUMBER )
        RETURN NUMBER;
END PCK_EMPREGADOS;
        
                