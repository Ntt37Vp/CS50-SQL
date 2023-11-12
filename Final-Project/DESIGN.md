# Design Document

By Kevin Jamito

Video overview: <https://youtu.be/3QlSjvK-1pg>

## Scope
My project is a simple representation of a medical (billing) claims tracking in a typical US healthcare provider's office.

* The purpose of this database is to track the medical claims submitted by the medical providers.
* The medical claims represented on this database are claim forms submitted by professional (HCFA1500)
* The database uses ICD-10-CM and CPT Level 1 which primarily used in the US. 

## Functional Requirements

Here are the functional requirements of the project

* The database is using SQLite3 as the DBMS
* Authorized users such as the medical practice owner (doctors), billing manager or the accounts receivable claims analyst can query information about the Claims
* It also includes the current diagnosis (ICD-10-CM) and procedure (CPT Level 1) codes obtained from CMS.gov
* The center of this database is the Claims table. It's where most tables are joined. 


## Representation

### Entities

Here are the entities that are represented in my database

1. Providers
    * The attributes are `id`, `first_name`, `last_name`, `npi`, and `specialty`
    * `id` is the primary key to distinguish doctors from one another
    * `first_name`, `last_name` are set to NOT NULL and is using TEXT data type
    * `npi` can be NULL and is set to UNIQUE, INTEGER
    * `specialty`can be NULL and is using TEXT data type

2. Patients
    * The attributes are `id`, `first_name`, `last_name` and `date_birth`
    * These are the basic attributes in describing a patient
    * All fields are required thus set to NOT NULL

3. Claims
    * The attributes are `id`, `patient_id`, `provider_id` and `date_service`, `amount_billed`, `procedure_codes` and `diagnosis_codes`
    * The Foreign Keys on Claims table are `patient_id`, `provider_id`, `procedure_codes` and `diagnosis_codes`
    * Why did you choose the constraints you did?

4. Procedures
    * The attributes are `id`, `description` and `cpt_code`
    * These are the basic representation of procedure
    * In the future versions or improvement, one can expand this table to include more information such as pricing or administrative information

5. Diagnosis
    * The attributes are `id`, `description` and `icd10_code`
    * These are the basic representation of diagnosis
    * Same with the Procedures, one can expand this table to include more information such as clinical or administrative information

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

![MyOffice Medical Billing DB ER](er_diag_billing_new.png)



## Optimizations

* Only 1 Index was made for now for demonstration: "inj" index
* This indexes the Procedure with "inj" or injections procedure since the sample medical practice uses multiple injection procedures in the queries
* Only 1 View was created for this project: "arthritis" view
* This view shows all the Diagnosis with the word "arthritis" on it

## Limitations

* This database may not fully represent the entire Revenue Cycle Management in the area of Accounts Receivable Management.
* This project is limited to simple attributes of the entities listed on Entities section. 
* The scope of this simple database is limited to minimum and necessary information needed to describe a Claim encounter. 