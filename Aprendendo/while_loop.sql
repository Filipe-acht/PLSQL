/*WHILE LOOP*/
DECLARE 
	vNumero number(38) := 1;
	vLimite NUMBER(38) := :limite;
BEGIN
--Variaveis inicializadas na seção DECLARE	
	WHILE vNumero <= vLimite LOOP --inicializa a condição
	DBMS_OUTPUT.PUT_LINE('Numero = '||to_char(vNumero));
	vNumero := vNumero + 1;
END loop;
END;