/* Bulk Collect - FOR ALL: melhora a performance */
/* usar apenas quando for feito apenas um comando DML */
SET SERVEROUTPUT ON
SET VERIFY OFF
CREATE OR REPLACE PROCEDURE PRC_UPDATE_SALARY
  (ppercentual IN NUMBER)
AS
  TYPE employee_id_table_type IS TABLE OF employees.employee_id%TYPE 
  INDEX BY BINARY_INTEGER;  -- Type Associative Array
  employee_id_table  employee_id_table_type;
BEGIN
  SELECT DISTINCT employee_id 
    BULK COLLECT INTO employee_id_table  
  FROM employees;
  
  DBMS_OUTPUT.PUT_LINE('Linhas recuperadas: ' || employee_id_table.COUNT);
  
  FOR indice IN 1..employee_id_table.COUNT  LOOP 
    UPDATE employees e
    SET    e.salary = e.salary * (1 + ppercentual / 100)
    WHERE  e.employee_id = employee_id_table(indice);   -- para cada UPDATE dentro do FOR LOOP Ocorrerá troca de contexto (Context Switch) 
	--
    -- outro comandos
    --
  END LOOP;
	
END;

/* Executando PRC_UPDATE_TAX  */

exec PRC_UPDATE_SALARY(10);

/* Bulk Collect - FOR ALL */

SET SERVEROUTPUT ON
SET VERIFY OFF
CREATE OR REPLACE PROCEDURE PRC_UPDATE_SALARY
  (ppercentual IN NUMBER)
AS
  TYPE employee_id_table_type IS TABLE OF employees.employee_id%TYPE 
  INDEX BY BINARY_INTEGER;  -- Type Associative Array
  employee_id_table  employee_id_table_type;
BEGIN

  SELECT DISTINCT employee_id 
    BULK COLLECT INTO employee_id_table  
  FROM employees;
  
  DBMS_OUTPUT.PUT_LINE('Linhas recuperadas: ' || employee_id_table.COUNT);
  
  /* FOR ALL empacota todos os UPDATES e envia o pacote em 1 única troca de contexto (Context Switch) */
  /* o FOR ALL vai ler 1 até o número(count) de ocorrências  da COLLECTION */
  FORALL indice IN 1..employee_id_table.COUNT  
    UPDATE employees e
    SET    e.salary = e.salary * (1 + ppercentual / 100)
    WHERE  e.employee_id = employee_id_table(indice); 
	
END;

--- Executando PRC_UPDATE_TAX 

exec PRC_UPDATE_SALARY(10);