/* Agendando tarefas com DBMS_SCHEDULER 
	* Componentes:
					** SCHEDULE: especifica quando e por quanto tempo o jb será executado
					** JOB: especifica o que será executado(program) e em que período(schedule)
	* CREAT_PROGRAM: para criar um programa;
	* Tipos de Programas:
					** plsql_block;
					** stored_procedure;
					** executable.
*/
/* dando privilégio */
GRANT ALL PRIVILEGES TO filipesoares;
GRANT CREATE JOB to filipesoares;

/* criando tabela para prática */

CREATE TABLE AGENDA
(agenda_id    NUMBER,
 agenda_data  DATE);
 
/* sequence para gerar o id da agenda */
CREATE SEQUENCE AGENDA_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOMAXVALUE
NOCYCLE;

/* procedure que é o programa(program) */
CREATE OR REPLACE PROCEDURE PRC_INSERE_DATA_AGENDA
IS
BEGIN
  INSERT INTO filipesoares.agenda
      VALUES (agenda_seq.NEXTVAL, sysdate);
  COMMIT;
END;

-- Criando e Habilitado um Programa

BEGIN
    DBMS_SCHEDULER.create_program(
        program_name => 'filipesoares.PRC_INSERE_AGENDA',
        program_action => 'filipesoares.PRC_INSERE_DATA_AGENDA', /* o que vai ser executado */
        program_type => 'STORED_PROCEDURE',/* o tipo do programa */
        number_of_arguments => 0,/* numero de parametros */
        comments => 'Insere dados na agenda',
        enabled => TRUE); /* default false*/
/*
    DBMS_SCHEDULER.ENABLE(name=>'filipesoares.PRC_INSERE_AGENDA'); -- para habilitar um programa
*/
END;

-- Removendo um Programa

BEGIN
    DBMS_SCHEDULER.drop_program(
        program_name => 'HR.PRC_INSERE_AGENDA',
        force => TRUE);
END;

-- Criando e Habilitado um Programa

BEGIN
    DBMS_SCHEDULER.create_program(
        program_name => 'HR.PRC_INSERE_AGENDA',
        program_action => 'HR.PRC_INSERE_DATA_AGENDA',
        program_type => 'STORED_PROCEDURE',
        number_of_arguments => 0,
        comments => 'Insere dados na agenda',
        enabled => TRUE);

    -- DBMS_SCHEDULER.ENABLE(name=>'HR.PRC_INSERE_AGENDA');    

END;
 
