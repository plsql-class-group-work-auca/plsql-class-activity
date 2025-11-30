# plsql-class-activity
## *Group Members:*
- Musoni Nshuti Sam 28857
- Divine Ukwishatse 28204
- Impundu Gatera Brazia 29057
- Doris Akimana 26675
- Emmanuel Niyitugenera 27013
> All group members are in Thursday Group D

# Scenario 1: AUCA System Access Policy
This project implements the AUCA System Access Policy using Oracle SQL and PL/SQL triggers.
The goal is to enforce strict rules about when users are allowed to access or modify system data, and to automatically block and log any unauthorized attempts.

### The system includes:
- A main data table `auca`
- An error logging table `auca_error_log`
- A policy-enforcing trigger that blocks illegal actions
- A violation-logging mechanism using an autonomous transaction

### The Rules are:
- No access on Sabbath
     Users are not allowed to access or record data on Saturday or Sunday.
- Limited access hours
     Users may only access the system from Monday to Friday, between 8:00 AM and 5:00 PM.
- Automatic restrictions
     Any attempt to access or modify data outside allowed days or hours must be:
      - Blocked immediately
      - Recorded in an audit table for security and monitoring

# How the Problem Was Solved
### 1. Creating the Main Table (auca)
This is the table where normal system data is stored.  
Any insert or update to this table is subject to the AUCA access policy.   
- see [code](<Scenario 1/src/auca.sql>)  
- see [screenshot](<Scenario 1/screenshots/01-auca>)
### 2. Creating the Error Logging Table
All policy violations (blocked attempts) are stored in auca_error_log.
It contains:
1. The username
2. The time of the attempted action
3. The type of action (INSERT/UPDATE)
4. The reason why the action was rejected
              
- see [code](<Scenario 1/src/auca-error-log.sql>)    
- see [screenshot](<Scenario 1/screenshots/02-auca-error-log.sql>)

### 3. Logging Procedure (Autonomous Transaction)
A stored procedure was created to handle all logging.
It is marked with PRAGMA AUTONOMOUS_TRANSACTION, which ensures the log entry is committed even if the main operation is blocked.

This allows Oracle to save the violation before the error stops execution.
- see [code](<Scenario 1/src/PROCEDURE log_auca_violation.sql>)    
- see [screenshot](<Scenario 1/screenshots/03-procedure.png>)

### 4. Trigger – Access Control
This trigger fires before every insert or update on the auca table.
It checks:
1.  The day of the week
2.  The current hour
3.  If the action is outside allowed days or hours:  
       -The logging procedure is called         
       -The action is blocked with RAISE_APPLICATION_ERROR

- see [code](<Scenario 1/src/TRIGGER auca_access_control_trg.sql>)    
- see [screenshot](<Scenario 1/screenshots/04-trigger.png>)
> NB: The question suggested we use 2 triggers to implement the logic however one is enough.
### 5. Testing 
To test this we are using a simple insert statement on table `auca` outside allowed hours.   
`INSERT INTO auca (username, data_value) VALUES ('sam', 'Test Data');`            
 `SELECT * FROM auca_error_log;`
- see [screenshot](<Scenario 1/screenshots/05-test.png>)

# Scenario 2: Hospital Management Package
The goal of here is to design a PL/SQL package that manages hospital patient information efficiently. The system needed to handle bulk patient loading, admission updates, and display of stored records, while keeping the logic modular and easy to maintain.
      
The solution was implemented using Oracle PL/SQL features such as packages, collections, ref cursors, and FORALL bulk operations.

## Problem Requirements

The original scenario required implementing:

### **1. Database Tables** 

- A patients table for storing details like ID, name, age, gender, and admission status.    
- A doctors table storing doctor ID, name, and specialty.

### **2. Package Specification** 

- A collection type to hold multiple patient records.   
- A procedure for bulk loading of patients.    
- A function to display all patients via a returned cursor.        
- A function to count admitted patients.       
- A procedure to admit/update a patient's status.        

### **3. Package Body**

- Efficient insertion using bulk processing and FORALL.      
- Use of commits for data consistency.        
- Complete implementation of all required functions and procedures.         

### **4. Testing**

- Inserting multiple patients at once.    
- Displaying patient data from the function.    
- Admitting selected patients.     
- Verifying updated admission counts.           

# How the Solution Was Structured

### **1. Designing the Tables**
To meet the project requirements, two relational tables were created.
    
- see [code](<Scenario 2/src/tables.sql>)    
- see [screenshot](<Scenario 2/screenshots/01-tables.png>)

### **2. Building the Package Specification**

The specification defined the “what” of the package:       
1. A record type representing a single patient structure.       
2. A collection type, allowing PL/SQL to store multiple patient records at once.        
3. Four essential operations exposed as public procedures/functions:                
  `bulk_load_patients` 
  `show_all_patients` 
  `count_admitted` 
  `admit_patient` 
           
- see [code](<Scenario 2/src/pkg_spec.sql>)    
- see [screenshot](<Scenario 2/screenshots/02-pkg.png>)

### **3. Implementing the Package Body**

The package body focused on the “how”:

**Bulk Loading**:
A FORALL construct was used to insert many patient records in a single optimized SQL operation.
This dramatically improves performance compared to inserting row by row.

**Returning All Patients**:
A ref cursor function was implemented to return the full patient list so external scripts could fetch and display results easily.

**Counting Admitted Patients**:
A simple aggregate function was implemented to count records with the “YES” admission status.

**Admitting a Patient**:
A procedure was added to update a specific patient’s status from “NO” to “YES”.

**Transaction Management**:
COMMIT statements were strategically placed to safeguard consistency after bulk insertions and updates.

- see [code](<Scenario 2/src/pkg_body.sql>)    
- see [screenshot](<Scenario 2/screenshots/02-pkg.png>)

### **4. Testing** 

To verify the package works correctly, a series of test scripts were written:        
   
1. A test that prepares several patient entries using the collection type and passes them into the bulk-loading procedure.        
2. A test that calls the function returning all patients and loops through the cursor to display them.             
3. Tests that admit specific patients and then confirm the change using the count function.                
                    
- see [code](<Scenario 2/src/testing_scripts.sql>)    
- see [screenshot 1](<Scenario 2/screenshots/03-bulk_insert.png>)
- see [screenshot 2](<Scenario 2/screenshots/04-show all patients.png>)
- see [screenshot 3](<Scenario 2/screenshots/05- admit patient and check count.png>)

# Comments By Each Member
- **Musoni Nshuti Sam:** Created Organization, helped develop plsql scripts and take screenshots, guided other members.
- **Divine Ukwishatse:** helped develop plsql scripts
- **Impundu Gatera Brazia:** helped develop plsql scripts
- **Doris Akimana 26675:** helped develop plsql scripts
- **Emmanuel Niyitugenera:** helped develop plsql scripts
