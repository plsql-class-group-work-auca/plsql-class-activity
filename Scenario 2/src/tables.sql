-- PATIENTS TABLE
CREATE TABLE patients (
    patient_id      NUMBER PRIMARY KEY,
    name            VARCHAR2(100),
    age             NUMBER,
    gender          VARCHAR2(10),
    admitted_status VARCHAR2(10) DEFAULT 'NO'
);

-- DOCTORS TABLE
CREATE TABLE doctors (
    doctor_id   NUMBER PRIMARY KEY,
    name        VARCHAR2(100),
    specialty   VARCHAR2(100)
);
