/* referenciando componentes de uma PACKAGE */
BEGIN
    PCK_EMPREGADOS.PRC_INSERE_EMPREGADO
        ('Filipe'
       , 'Costa'
       , 'fcosta'
       , '555.998.6786'
       , SYSDATE
       , 'IT_PROG'
       , 150000
       , NULL
       , 103
       , 60);
    COMMIT;
END;

/* recompilando uma PACKAGE SPECIFICATION */
ALTER PACKAGE PCK_EMPREGADOS COMPILE SPECIFICATION;

/* recompilando uma PACKAGE BODY */
ALTER PACKAGE PCK_EMPREGADOS COMPILE BODY;

/* removendo PACKAGE BODY */
DROP PACKAGE BODY PCK_EMPREGADOS;

/* removendo PACKAGE BODY e SPECIFICATION */
DROP PACKAGE PCK_EMPREGADOS;