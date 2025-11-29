# plsql-class-activity
## Group Members:
- Musoni Nshuti Sam 28857

# Scenario 1: AUCA System Access Policy
This project implements the AUCA System Access Policy using Oracle SQL and PL/SQL triggers.
The goal is to enforce strict rules about when users are allowed to access or modify system data, and to automatically block and log any unauthorized attempts.

### The system includes:
- A main data table auca
- An error logging table auca_error_log
- A policy-enforcing trigger that blocks illegal actions
- A violation-logging mechanism using an autonomous transaction

### The Rules are:
- No access on Sabbath
   - Users are not allowed to access or record data on Saturday or Sunday.
- Limited access hours
   - Users may only access the system from Monday to Friday, between 8:00 AM and 5:00 PM.
- Automatic restrictions
   - Any attempt to access or modify data outside allowed days or hours must be:
      - Blocked immediately
      - Recorded in an audit table for security and monitoring

# How the Problem Was Solved
### 1. Creating the Main Table (auca)
This is the table where normal system data is stored.  
Any insert or update to this table is subject to the AUCA access policy.   
- see [code]()  
- see [screenshot]()
### 2. Creating the Error Logging Table
All policy violations (blocked attempts) are stored in auca_error_log.
It contains:
1. The username
2. The time of the attempted action
3. The type of action (INSERT/UPDATE)
4. The reason why the action was rejected
              
- see [code]()    
- see [screenshot]()
### 3. Logging Procedure (Autonomous Transaction)
A stored procedure was created to handle all logging.
It is marked with PRAGMA AUTONOMOUS_TRANSACTION, which ensures the log entry is committed even if the main operation is blocked.

This allows Oracle to save the violation before the error stops execution.
- see [code]()    
- see [screenshot]()
### 4. Trigger – Access Control
This trigger fires before every insert or update on the auca table.
It checks:
1.  The day of the week
2.  The current hour
3.  If the action is outside allowed days or hours:
    i. The logging procedure is called
    ii. The action is blocked with RAISE_APPLICATION_ERROR

- see [code]()    
- see [screenshot]()
