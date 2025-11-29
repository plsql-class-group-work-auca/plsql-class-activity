CREATE OR REPLACE PACKAGE hospital_mgmt_pkg AS

    -- Collection type for loading multiple patients
    TYPE patient_rec IS RECORD (
        patient_id      NUMBER,
        name            VARCHAR2(100),
        age             NUMBER,
        gender          VARCHAR2(10),
        admitted_status VARCHAR2(10)
    );

    TYPE patient_table IS TABLE OF patient_rec;

    -- Bulk insertion
    PROCEDURE bulk_load_patients(pat_list IN patient_table);

    -- Return all patients as cursor
    FUNCTION show_all_patients RETURN SYS_REFCURSOR;

    -- Count admitted patients
    FUNCTION count_admitted RETURN NUMBER;

    -- Admit a patient
    PROCEDURE admit_patient(p_id IN NUMBER);

END hospital_mgmt_pkg;
/
