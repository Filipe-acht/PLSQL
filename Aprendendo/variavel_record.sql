/*VARIAVEL RECORD*/
DECLARE 
TYPE pessoa_record_type IS RECORD
		(
		id <tabela>.plsq_learning.id%TYPE,
		nome <tabela>.plsq_learning.nome%type
		);
pessoa_record pessoa_record_type;
BEGIN
	SELECT id, nome INTO pessoa_record 
	  FROM <tabela>.plsq_learning WHERE id =  1;
	dbms_output.put_line(pessoa_record.id || ' - ' || pessoa_record.nome);
END;
/*
   
DECLARE 
TYPE pessoa_record_type IS RECORD
		(
		id <tabela>.plsq_learning.id%TYPE,
		nome <tabela>.plsq_learning.nome%type
		);
pessoa_record pessoa_record_type;
BEGIN
	SELECT id, nome INTO pessoa_record 
	  FROM <tabela>.plsq_learning WHERE id =  1;
	dbms_output.put_line(pessoa_record.id || ' - ' || pessoa_record.nome);
END;
*/
