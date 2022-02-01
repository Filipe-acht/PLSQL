/*DELETE COM PLSQL*/
DECLARE 
	vId NUMBER := 3;
BEGIN 
	DELETE FROM <tabela>.plsq_learning l
	WHERE l.id = vId;
END;
