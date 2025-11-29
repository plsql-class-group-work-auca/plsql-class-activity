CREATE OR REPLACE PACKAGE BODY hospital_mgmt_pkg AS

    --------------------------------------------------------------------
    -- Bulk insert multiple patients using FORALL
    --------------------------------------------------------------------
    PROCEDURE bulk_load_patients(pat_list IN patient_table) IS
    BEGIN
        FORALL i IN 1..pat_list.COUNT
            INSERT INTO patients (patient_id, name, age, gender, admitted_status)
            VALUES (
                pat_list(i).patient_id,
                pat_list(i).name,
                pat_list(i).age,
                pat_list(i).gender,
                pat_list(i).admitted_status
            );

        COMMIT;
    END bulk_load_patients;

    --------------------------------------------------------------------
    -- Return all patients as a ref cursor
    --------------------------------------------------------------------
    FUNCTION show_all_patients RETURN SYS_REFCURSOR IS
        rc SYS_REFCURSOR;
    BEGIN
        OPEN rc FOR
            SELECT * FROM patients ORDER BY patient_id;
        RETURN rc;
    END show_all_patients;

    --------------------------------------------------------------------
    -- Count admitted patients
    --------------------------------------------------------------------
    FUNCTION count_admitted RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM patients
        WHERE admitted_status = 'YES';

        RETURN v_count;
    END count_admitted;

    --------------------------------------------------------------------
    -- Admit a patient by updating their status
    --------------------------------------------------------------------
    PROCEDURE admit_patient(p_id IN NUMBER) IS
    BEGIN
        UPDATE patients
        SET admitted_status = 'YES'
        WHERE patient_id = p_id;

        COMMIT;
    END admit_patient;

END hospital_mgmt_pkg;
/
