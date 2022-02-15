/* 
	FUNCTIONS: sempre retorna um valor 
			* utilizar uma função ao invés de uma procedure, quando a rotina obrigatoriamente, retornar um único valor.
*/

CREATE OR REPLACE FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO
    ( pEmployee_id IN NUMBER )
    RETURN NUMBER
IS 
    vSalary employees.salary%TYPE;
BEGIN
    SELECT salary
      INTO vSalary
    FROM employees
   WHERE employee_id = pEmployee_id;
 RETURN (vSalary);
 
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        RAISE_APPLICATION_ERROR(-20001, 'Empregado inexistente');
    WHEN OTHERS THEN 
        RAISE_APPLICATION_ERROR(-20002, 'Erro Oracle: ' || SQLCODE || ' - ' || SQLERRM);
END;
        
/* executando a Function num Bloco PL/SQL */

SET SERVEROUTPUT ON 
SET VERIFY OFF
ACCEPT pEmployee_id PROMPT 'Digite o id o empregado: '
DECLARE
    vEmployee_id employees.employee_id%TYPE := &pEmployee_id;
    vSalary employees.salary%TYPE;
BEGIN
    vSalary := FNC_CONSULTA_SALARIO_EMPREGADO(vEmployee_id);
    DBMS_OUTPUT.PUT_LINE('O salario e: '|| vsalary);
END;

/* recompilando uma FUNCTION */
ALTER FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO COMPILE;

/* removendo uma FUNCTION */
DROP FUNCTION FNC_CONSULTA_SALARIO_EMPREGADO;