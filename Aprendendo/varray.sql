/*
	VARRAY:
			* precisa ser inicializado
			* permite que seja de tamanho variável
			* o tamanho máximo dever ser especificado na declaração do tipo
*/

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE 
    TYPE Numero_Table_Type IS VARRAY (10) OF INTEGER (2);
    Numero_Table numero_Table_Type := numero_Table_Type(); -- Obrigatório inicializar
BEGIN
    -- Armazena números de  1 a 10 em um VARRAY
    FOR i IN 1..10
    LOOP
        Numero_Table.EXTEND;
        Numero_Table(i) := i;
    END LOOP;
    -- Lê o array e imprime os números armazenados
    FOR i IN 1..10
    LOOP
        DBMS_OUTPUT.PUT_LINE('Varray: Indice = '|| to_char(i)||', Valor = '|| to_char(Numero_Table(i)));
    END LOOP;
END;