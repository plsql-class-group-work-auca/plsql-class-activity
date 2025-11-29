-- A. Bulk Load Multiple Patients
DECLARE
    p_list hospital_mgmt_pkg.patient_table := hospital_mgmt_pkg.patient_table();
BEGIN
    -- Add records
    p_list.EXTEND(3);

    p_list(1).patient_id := 1;
    p_list(1).name := 'Alice';
    p_list(1).age := 25;
    p_list(1).gender := 'F';
    p_list(1).admitted_status := 'NO';

    p_list(2).patient_id := 2;
    p_list(2).name := 'Bob';
    p_list(2).age := 30;
    p_list(2).gender := 'M';
    p_list(2).admitted_status := 'NO';

    p_list(3).patient_id := 3;
    p_list(3).name := 'John';
    p_list(3).age := 40;
    p_list(3).gender := 'M';
    p_list(3).admitted_status := 'NO';

    -- Call bulk insert procedure
    hospital_mgmt_pkg.bulk_load_patients(p_list);
END;
/

  
-- B. Show All Patients
SET SERVEROUTPUT ON;

DECLARE
    rc SYS_REFCURSOR;
    id NUMBER;
    nm VARCHAR2(100);
    ag NUMBER;
    gd VARCHAR2(10);
    st VARCHAR2(10);
BEGIN
    rc := hospital_mgmt_pkg.show_all_patients;

    LOOP
        FETCH rc INTO id, nm, ag, gd, st;
        EXIT WHEN rc%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(id || ' | ' || nm || ' | ' || ag || ' | ' || gd || ' | ' || st);
    END LOOP;
END;
/


-- C. Admit Patient + Check Count 
  
-- Admit patient with ID 2
BEGIN
    hospital_mgmt_pkg.admit_patient(2);
END;
/

-- Count admitted
DECLARE 
    c NUMBER;
BEGIN
    c := hospital_mgmt_pkg.count_admitted;
    DBMS_OUTPUT.PUT_LINE('Admitted patients: ' || c);
END;
/
