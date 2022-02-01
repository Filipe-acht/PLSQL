/*LOOPS ANINHADOS*/
DECLARE 
	vTotal number(38) := 1;
BEGIN
<<LOOP1>>--label
FOR i IN 1..8 loop	
	DBMS_OUTPUT.PUT_LINE('I = '||to_char(i));
	<<LOOP2>>
	FOR j IN 1..8 LOOP
	DBMS_OUTPUT.PUT_LINE('J = '||to_char(j));
	vTotal := vTotal * 2;
	DBMS_OUTPUT.PUT_LINE('Total = '||to_char(vTotal,'99G999G999G999G999G99G999G999D99'));
	END LOOP;
END loop;
DBMS_OUTPUT.PUT_LINE('Total Final = '||to_char(vTotal,'99G999G999G999G999G99G999G999D99'));	
END;