/*
	Database DML Triggers: são executadas quando ocorre um evento para o qual elas foram declaradas.
		* DML: insert, update ou delete;
		* PRAGMA AUTONOMOUS_TRANSACTION: para uma trigger conseguir fazer controle de transação.
		
		TEMPO:
				* BEFORE;
				* AFTER;
				* INSTEAD OF;
		EVENTO: 
				* INSERT;
				* UPDATE;
				* DELETE.
		TIPO:
				* STATEMENT(nivel de comando);
				* FOR EACH ROW(nivel de linha).
		CORPO:
				* BLOCO PL/SQL. 
			
	
	Trigger Nível de Comando:
			* disparadas antes ou depois da execução de um comando;
			* disparada uma única vez.
*/

/* TRIGGER Nivel de Comando */

CREATE OR REPLACE TRIGGER B_IUD_EMPLOYEES_S_TRG /* BEFORE(B) INSERT(I) UPDATE(U) DELETE(D) EMPLOYEES STATEMENT(S) TRIGGER(TRG) */
BEFORE INSERT OR UPDATE OR DELETE
ON employees
BEGIN 
	IF (TO_CHAR(SYSDATE, 'DAY') IN ('SATURDAY', 'SUNDAY') OR /* se for no fim de semana */
		TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) NOT BETWEEN 8 AND 18) /* ou fora do horario comercial */
		THEN
            CASE 
                WHEN INSERTING THEN 
                    RAISE_APPLICATION_ERROR(-20001, 'O cadastramento de Empregados só é permitido em dias de semana dentro do horario comercial');
                WHEN DELETING THEN
                    RAISE_APPLICATION_ERROR(-20002, 'A deleção de Empregados só é permitido em dias de semana dentro do horario comercial');
                ELSE
                    RAISE_APPLICATION_ERROR(-20003, 'A atualização de Empregados só é permitido em dias de semana dentro do horario comercial');
            END CASE;                           
	END IF;
END;

/* testando validação da TRIGGER usando uma PACKAGE */
BEGIN 
    PCK_EMPREGADOS.PRC_INSERE_EMPREGADO
        ( 'Lily'
        , 'BURREGO'
        , 'BURGLIL'
        , '653.91823.22'
        , SYSDATE
        , 'IT_PROG'
        , 28000
        , NULL
        , 103
        , 60);
COMMIT;
END;

/* 
	TRIGGER Nivel de Linha: disparadas antes ou depois da manipulação da linha, para cada linha afetada pelo comando  
		* :OLD -> é possível referenciar os valores existentes antes da manipulação de dados;
		* :NEW -> valores a serem aplicados.
*/

/* criando tabela */
CREATE TABLE employees_log
(
    employees_log_id NUMBER(11) NOT NULL,
    dt_log           DATE DEFAULT SYSDATE NOT NULL,
    usuario          VARCHAR2(30),
    evento           CHAR(1) NOT NULL,
    employee_id      NUMBER(6) NOT NULL,
    salary_old       NUMBER(8,2),
    salary_new       NUMBER(8,2));

/* criando constraint */
ALTER TABLE employees_log
ADD CONSTRAINT employees_log_pk PRIMARY KEY (employees_log_id);

/* criando sequence */
CREATE SEQUENCE seq_employees_log
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE
NOMAXVALUE;

/* Criando uma Trigger que gera log de Auditoria para a Tabela Employees na coluna Salary */
CREATE OR REPLACE TRIGGER A_IUD_EMPLOYEES_R_TRG /* AFTER(A) INSERT (I) UPDATE(U) DELETE(D) EMPLOYEES ROW(R) TRIGGER(TRG) */
    AFTER INSERT OR UPDATE OF SALARY OR DELETE
    ON EMPLOYEES
    FOR EACH ROW /* definindo Trigger a nivel de linha */
    WHEN (new.job_id <> 'AD_PRES') /* só executa quando o cargo for diferente de presidente */
DECLARE
    vEvento         employees_log.evento%TYPE;
    vEmployee_id    employees_log.employee_id%TYPE;
BEGIN
    /* descobrindo que evento disparou a Trigger */
    CASE
        WHEN INSERTING THEN 
            vEvento         := 'I';
            vEmployee_id    := :NEW.employee_id;
        WHEN UPDATING THEN
            vEvento         := 'U';
            vEmployee_id    := :NEW.employee_id;
        ELSE 
            vEvento         := 'D';
            vEmployee_id    := :OLD.employee_id;
    END CASE;
    /* inserindo */
    INSERT INTO employees_log
        (employees_log_id,
         dt_log,
         usuario,
         evento,
         employee_id,
         salary_old,
         salary_new
         ) 
    VALUES
        (seq_employees_log.nextval,
         SYSDATE,
         USER,
         vEvento,
         vEmployee_id,
         :old.salary,
         :new.salary   
        );
END A_IUD_EMPLOYEES_R_TRG;
        
/* testando a Trigger */
UPDATE employees 
SET salary = salary * 1.5;

/* Desabilitando uma Trigger */
ALTER TRIGGER B_IUD_VLAIDA_HORARIO_EMPLOYEES_S_TRG DISABLE;
ALTER TRIGGER B_IUD_VLAIDA_HORARIO_EMPLOYEES_S_TRG DISABLE ALL TRIGGERS;

/* Habilitando uma Trigger */
ALTER TRIGGER B_IUD_VLAIDA_HORARIO_EMPLOYEES_S_TRG ENABLE;
ALTER TRIGGER B_IUD_VLAIDA_HORARIO_EMPLOYEES_S_TRG ENABLE ALL TRIGGERS;

/* Removendo uma Trigger */
DROP TRIGGER B_IUD_VLAIDA_HORARIO_EMPLOYEES_S_TRG;