-- NESTED TABLE
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE 
    TYPE Numero_Table_Type IS TABLE OF INTEGER(2); -- Apenas número positivos
    Numero_table Numero_table_type := numero_table_type(); -- É obrigatório inicializar
BEGIN
    -- Armazena números de 1 a 10 
    FOR i IN 1..10
    LOOP 
        Numero_table.EXTEND; -- Extend é necessário para alocar uma ocorrência
        Numero_table(i) := i;
    END LOOP;
    -- Lê o NESTED TABLE e imprime os números armazenados
    FOR i IN 1..10
    LOOP
        DBMS_OUTPUT.PUT_LINE('Nested Table: Indice = '|| to_char(i) ||', Valor = '|| to_char(Numero_Table(i)));
    END LOOP;
END;