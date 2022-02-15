/* Métodos de Passagem de Parâmetros */

/* POSICIONAL */
PRC_CONSULTA_EMPREGADO
( 100
, employees_record.first_name
, employees_record.last_name
, employees_record.email
, employees_record.phone_number
, employees_record.hire_date
, employees_record.job_id
, employees_record.salary
, employees_record.commission_pct
, employees_record.manager_id
, employees_record.department_id
);

/* NOMEADO */
/* EXECUTANDO A PROCEDURE PARÂMETRO TIPO OUT COM MÉTODO NOMEADO */

SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE 
    vemployee_id        NUMBER := 100;
    vfirst_name         VARCHAR2(200);
    vlast_name          VARCHAR2(200);
    vemail              VARCHAR2(200);
    vphone_number       VARCHAR2(200);
    vhire_date          DATE;
    vjob_id             VARCHAR2(200);
    vsalary             NUMBER;
    vcommission_pct     NUMBER;
    vmanager_id         NUMBER;
    vdepartment_id      NUMBER;
BEGIN 
    PRC_CONSULTA_EMPREGADO( 
                            pemployee_id         => vemployee_id  	
                          , pfirst_name          => vfirst_name         	
                          , plast_name           => vlast_name          	
                          , pemail               => vemail              	
                          , pphone_number        => vphone_number       	
                          , phire_date           => vhire_date          	
                          , pjob_id              => vjob_id             	
                          , psalary              => vsalary             	
                          , pcommission_pct      => vcommission_pct     	
                          , pmanager_id          => vmanager_id         	
                          , pdepartment_id          => vdepartment_id      	               
                          );
        DBMS_OUTPUT.PUT_LINE('pfirst_name = ' || vfirst_name);
        DBMS_OUTPUT.PUT_LINE('plast_name = ' || vlast_name);
        DBMS_OUTPUT.PUT_LINE('psalary = ' || vsalary);

END;
  /* omitir parâmetro, se ele tiver um valor default */