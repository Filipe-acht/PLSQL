/* Criando um Job: é a vinculação do programa com a agenda(scheduler) 

    Visões dos Jobs:
            * USER_SCHEDULER_JOB_ARGS        -> argumentos configurados para todos os jobs;
            * USER_SCHEDULER_JOB_LOG         -> informações de log de todos os jobs;
            * USER_SCHEDULER_JOB_RUN_DETAILS -> detalhes das execuções dos jobs;
            * USER_SCHEDULER_JOBS            -> lista dos jobs agendados;
            * USER_SCHEDULER_PROGRAM_ARGS    -> argumentos de todos os programas agendados;
            * USER_SCHEDULER_PROGRAMS        -> lista dos programas agendados;
            * USER_SCHEDULER_SCHEDULES       -> agendamentos pertecentes ao usuário.
*/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"FILIPESOARES"."JOB_INSERE_DATA_AGENDA"', /* nome do job */
            program_name => '"FILIPESOARES"."PRC_INSERE_AGENDA"', /* nome do programa */
            schedule_name => '"FILIPESOARES"."SCH_A_CADA_10_SEGUNDOS"', /* nome do schedule */
            enabled => TRUE,
            auto_drop => FALSE, /* se falhar, remove job ao final da execução */
            comments => 'Job Insere Data na Agenda',             
            job_style => 'REGULAR'); /* job padrão */
/*
    DBMS_SCHEDULER.enable(
             name => '"HR"."JOB_INSERE_DATA_AGENDA"'); --habilitar o job
*/
END;

-- Consultando a tabela AGENDA

SELECT agenda_id AS ID ,
       TO_CHAR(agenda_data,'dd/mm/yyyy hh24:mi:ss') AS AGENDA_DATA
FROM   filipesoares.agenda
ORDER BY agenda_id;

-- Conectar como SYS

/* Stop(remover) job */ 
BEGIN
	DBMS_SCHEDULER.DROP_JOB (
	     job_name => '"HR"."JOB_INSERE_DATA_AGENDA"',
	     force => TRUE);
END;

