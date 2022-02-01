/*LOOP BÁSICO*/
DECLARE 
	vNumero number(38) := 1;
	vLimite number(37) := 1000;
BEGIN
	--imprimindo numeros de 1 até 1000
	LOOP
	dbms_output.put_line('Numero = '||to_char(vNumero));
	EXIT WHEN vNumero = vLimite;
	vNumero := vNumero + 1;
	END LOOP;
END;