/* Criando uma Agenda 

	A clásula frequência(repeat_interval: entre 1 e 99) é composta pelos seguintes elementos:
			* FREQ:
				** YEARLY 	- anualmente;
				** MONTHLY	- mensalmente;
				** WEEKLY	- semanalmente;
				** DAILY		- diariamente;
				** HOURLY    - a cada hora;
				** MINUTELY  - a cada minuto;
				** SECONDLY 	- a cada segundo.
				
			* INTERVAL:
				** BYMONYTH 	- por mês;
				** BYWEEKNO  	- por semana;
				** BYYEARDAY 	- tal dia do ano;
				** BYMONTH		- tal dia do mês;
				** BYDAY		- por dia;
				** BYHOUR 		- por hora;
				** BYMINUTE		- por minuto;
				** BYSECOND		- por segundo.
*/

/* Criando um Schedule (a cada 10 segundos) */
BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE (
        schedule_name  => 'SCH_A_CADA_10_SEGUNDOS',/* nome do schedule */
        start_date     => SYSTIMESTAMP,/* data a partir de qual começara o agendamento */
        --start_date => TO_TIMESTAMP_TZ('2020-03-17 15:17:36.000000000 AMERICA/SAO_PAULO','YYYY-MM-DD HH24:MI:SS.FF TZR'),
        repeat_interval  => 'FREQ=SECONDLY;INTERVAL=10',/* critério de repetição */
        end_date => TO_TIMESTAMP_TZ('2020-07-23 23:00:00.000000000 AMERICA/SAO_PAULO','YYYY-MM-DD HH24:MI:SS.FF TZR'),/* data de encerramento do schedule */
        comments => 'A cada 10 segundos' /* descrição */
        );
END;
 
--Removendo um Schedule 
 
BEGIN
    DBMS_SCHEDULER.DROP_SCHEDULE (
        schedule_name  => 'SCH_A_CADA_10_SEGUNDOS',
        force    => FALSE
        );
END;

-- Criando um Schedule (a cada 10 segundos)
 
BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE (
        schedule_name  => 'SCH_A_CADA_10_SEGUNDOS',
        start_date     => SYSTIMESTAMP,
        -- start_date => TO_TIMESTAMP_TZ('2020-03-17 15:17:36.000000000 AMERICA/SAO_PAULO','YYYY-MM-DD HH24:MI:SS.FF TZR'),
        repeat_interval  => 'FREQ=SECONDLY;INTERVAL=10',
        end_date => TO_TIMESTAMP_TZ('2020-07-23 23:00:00.000000000 AMERICA/SAO_PAULO','YYYY-MM-DD HH24:MI:SS.FF TZR'),
        comments => 'A cada 10 segundos'
        );
END;



