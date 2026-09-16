CREATE TABLE STUDENT (
    student_no NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100)
);
CREATE TABLE INSTRUCTOR (
    instructor_id NUMBER PRIMARY KEY,
    instructor_name VARCHAR2(100)
);
CREATE TABLE MODULE (
    module_code VARCHAR2(10) PRIMARY KEY,
    module_name VARCHAR2(100),
    instructor_id NUMBER,
    CONSTRAINT fk_module_instructor
        FOREIGN KEY (instructor_id)
        REFERENCES INSTRUCTOR(instructor_id)
);
CREATE TABLE REGISTRATION (
    student_no NUMBER,
    module_code VARCHAR2(10),
    CONSTRAINT pk_registration PRIMARY KEY (student_no, module_code),
    CONSTRAINT fk_reg_student FOREIGN KEY (student_no)
        REFERENCES STUDENT(student_no),
    CONSTRAINT fk_reg_module FOREIGN KEY (module_code)
        REFERENCES MODULE(module_code)
);
