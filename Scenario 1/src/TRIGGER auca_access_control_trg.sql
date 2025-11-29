-- TRIGGER THAT BLOCKS INVALID INSERT OR UPDATE ATTEMPTS
-- It checks day + time and rejects the action if not allowed
CREATE OR REPLACE TRIGGER auca_access_control_trg
BEFORE INSERT OR UPDATE ON auca
FOR EACH ROW
DECLARE
    v_day   VARCHAR2(10);
    v_hour  NUMBER;
BEGIN
    -- Determine day name and hour
    v_day  := TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH');
    v_hour := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));

    ------------------------------------------------------------------
    -- RULE 1: Block if it's Saturday or Sunday
    ------------------------------------------------------------------
    IF v_day IN ('SAT', 'SUN') THEN
        log_auca_violation(:NEW.username, 'INSERT/UPDATE',
            'Access denied: Weekend access not allowed');
        RAISE_APPLICATION_ERROR(-20001, 'Access denied: No system use on weekends.');
    END IF;

    ------------------------------------------------------------------
    -- RULE 2: Block if outside 08:00 - 17:00
    ------------------------------------------------------------------
    IF v_hour < 8 OR v_hour >= 17 THEN
        log_auca_violation(:NEW.username, 'INSERT/UPDATE',
            'Access denied: Outside allowed hours (8AM - 5PM)');
        RAISE_APPLICATION_ERROR(-20002, 'Access denied: Allowed time is 8AM to 5PM.');
    END IF;

END;
/
