/*FOR LOOP*/
DECLARE 
	vInicio integer(3) := 1;
	vFim	integer(3) := :limite;
BEGIN
	FOR i IN vInicio..vFim LOOP --.. de -> até 
	dbms_output.put_line('Numero = '||to_char(i));
END LOOP;
END;