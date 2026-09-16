CREATE OR REPLACE PROCEDURE register_student (
    p_student_no IN NUMBER,
    p_module_code IN VARCHAR2
) AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM REGISTRATION
    WHERE student_no = p_student_no
      AND module_code = p_module_code;

    IF v_count = 0 THEN
        INSERT INTO REGISTRATION VALUES (p_student_no, p_module_code);
    END IF;
END;
/
Output:


EXEC register_student(1, 'CS102');
SELECT * FROM REGISTRATION;
