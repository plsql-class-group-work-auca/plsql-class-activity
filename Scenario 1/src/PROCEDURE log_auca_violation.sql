-- PROCEDURE THAT LOGS VIOLATIONS SAFELY
-- Uses PRAGMA AUTONOMOUS_TRANSACTION so logging succeeds even if main action is blocked
CREATE OR REPLACE PROCEDURE log_auca_violation(
    p_username VARCHAR2,
    p_action   VARCHAR2,
    p_reason   VARCHAR2
) AS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO auca_error_log (username, attempt_time, attempted_action, reason)
    VALUES (p_username, SYSDATE, p_action, p_reason);

    COMMIT;
END;
/
