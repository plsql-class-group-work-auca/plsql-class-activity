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
