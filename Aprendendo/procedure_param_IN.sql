/* parâmetros IN */
CREATE OR REPLACE PROCEDURE PRC_AUMENTA_SALARIO_EMPREGADO
    (
        /* parâmetros de entrada */
      pemployee_id      IN NUMBER
    , ppercentual       IN NUMBER
    )
IS 
    /* Nenhuma variável declarada */
BEGIN
    /* bloco de update */
    UPDATE employees
    SET salary = salary * (1 + ppercentual / 100)
    WHERE employee_id = pemployee_id;
/* não faz commit, pois deixa a cargo do programa chamador */
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro Oracle: ' || SQLCODE || SQLERRM);
END;


/* executando a procedure */
BEGIN 
    PRC_AUMENTA_SALARIO_EMPREGADO(109, 10);
    COMMIT;
END;