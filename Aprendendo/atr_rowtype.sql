/*%ROWTYPE*/
DECLARE 
	pessoa_record <tabela>.plsq_learning%ROWTYPE;
	vPessoaId  <tabela>.plsq_learning.id%TYPE := 2;
BEGIN
	SELECT * INTO pessoa_record
	  FROM <tabela>.plsq_learning WHERE id =  vPessoaId;
	dbms_output.put_line(pessoa_record.id || ' - ' || pessoa_record.nome || ' - '||pessoa_record.salario);
END;