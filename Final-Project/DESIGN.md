# Design Document

By Kevin Jamito

Video overview: <URL>

## Scope

My project is a mock representation of a simple medical billing claims tracking for a healthcare provider's office.

* The purpose of this database is to represent a medical billing software tracking claims for patients
* Which people, places, things, etc. are you including in the scope of your database?
* Which people, places, things, etc. are *outside* the scope of your database?

## Functional Requirements

Here are the functional requirements of the project

* Authorized users such as the medical practice owner(doctor), medical billing manager or the accounts receivable claims analyst can query information about claims
* What's beyond the scope of what a user should be able to do with your database?

## Representation

### Entities

Here are the entities that are represented in my database

1. Providers -
    * The attributes are `id`, `first_name`, `last_name`, `npi`, and `specialty`
    * Why did you choose the types you did?
    * Why did you choose the constraints you did?

2. Patients -
    * The attributes are `id`, `first_name`, `last_name` and `date_birth`
    * Why did you choose the types you did?
    * Why did you choose the constraints you did?

3. Claims -
    * The attributes are `id`, `patient_id`, `provider_id` and `date_service`, `amount_billed`, `procedure_codes` and `diagnosis_codes`
    * Why did you choose the types you did?
    * Why did you choose the constraints you did?

4. Procedures -
    * The attributes are `id`, `description` and `cpt_code`
    * Why did you choose the types you did?
    * Why did you choose the constraints you did?

5. Diagnosis -
    * The attributes are `id`, `description` and `icd10_code`
    * Why did you choose the types you did?
    * Why did you choose the constraints you did?

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

![MyOffice Medical Billing DB ER](er_diag_billing_new.png)



## Optimizations

* Which optimizations (e.g., indexes, views) did you create? Why?

## Limitations

* This project is limited to simple attributes of the 5 entities listed on Entities section. 

* This database may not fully represent the entire Revenue Cycle Management in the area of Accounts Receivable Management.
