/*
	ASSOCIATIVE ARRAY de RECORDS: é quando estou declarando um associative array
								  e cada ocorrência dele vai ter toda a estrutura de campos de um tipo RECORD.
	BULK COLLECT: faz alocação dos dados na memória, sem a necessidade de refazer a busca no banco.
*/

SET SERVEROUTPUT  ON
SET VERIFY OFF
DECLARE 
    TYPE EMPLOYEES_TABLE_TYPE IS TABLE OF EMPLOYEES%ROWTYPE
    INDEX BY BINARY_INTEGER; -- TYPE ASSOCIATIVE ARRAY
    EMPLOYEES_TABLE EMPLOYEES_TABLE_TYPE;
BEGIN
    SELECT * 
        BULK COLLECT INTO EMPLOYEES_TABLE -- CARREGANDO TODA UMA TABELA PARA UM ARRAY COM O BULK COLLECT
    FROM EMPLOYEES;
    FOR I IN EMPLOYEES_TABLE.FIRST..EMPLOYEES_TABLE.LAST -- LENDO A COLLECTION: FIRST TRAZ O PRIMEIRO ELEMENTO, LAST O ÚLTIMO
    LOOP
        DBMS_OUTPUT.PUT_LINE(EMPLOYEES_TABLE(I).EMPLOYEE_ID||' - ' ||
                             EMPLOYEES_TABLE(I).LAST_NAME||' - '||
                             EMPLOYEES_TABLE(I).PHONE_NUMBER||' - '||
                             EMPLOYEES_TABLE(I).JOB_ID||' - '||
                             TO_CHAR(EMPLOYEES_TABLE(I).SALARY,'99G999G999D99'));
    END LOOP;
END;