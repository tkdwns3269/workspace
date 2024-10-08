--1.
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1)DEFAULT 'Y'
);

--2.
CREATE TABLE TB_CLASS_TYPE (
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

--3.
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(10) PRIMARY KEY;

--4.
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(10) NOT NULL;

--5.
ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10);
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);

--6.
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;

--7.
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO PK_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN CLASS_TYPE_NO TO PK_CLASS_TYPE_NO;

--8.
INSERT INTO TB_CATEGORY VALUES('공학','Y');
INSERT INTO TB_CATEGORY VALUES('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES('의학','Y');
INSERT INTO TB_CATEGORY VALUES('예체능','Y');
INSERT INTO TB_CATEGORY VALUES('인문사회','Y');
COMMIT;

--9.
ALTER TABLE TB_DEPARTMENT ADD CONSTRAINT FK_DEPARTMENT_CATEGORY 
FOREIGN KEY (CATEGORY) REFERENCES TB_CATEGORY(PK_NAME);

--10.
CREATE VIEW VW_학생일반정보 AS
SELECT STUDENT_NO,
STUDENT_NAME,
STUDENT_ADDRESS
FROM TB_STUDENT;

--11.
CREATE VIEW VW_지도면담 AS
SELECT STUDENT_NAME, DEPARTMENT_NAME, PROFESSOR_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR USING(DEPARTMENT_NO);

--12.
CREATE VIEW VW_학과별학생수 AS(
SELECT DEPARTMENT_NAME, COUNT(STUDENT_NO) AS STUDENT_COUNT
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING(DEPARTMENT_NO)
GROUP BY DEPARTMENT_NAME);

--13.
UPDATE VW_학생일반정보
SET STUDENT_NAME = '박상준' 
WHERE STUDENT_NO = 'A213046';

--14.
CREATE VIEW VW_학생일반정보_READONLY AS
SELECT STUDENT_NO,
STUDENT_NAME,
STUDENT_ADDRESS
FROM TB_STUDENT
WITH READ ONLY;

--15.
SELECT *
FROM(
SELECT CLASS_NO AS 과목번호, CLASS_NAME AS 과목이름, COUNT(DISTINCT STUDENT_NO) AS 누적학생수
FROM TB_CLASS
JOIN TB_STUDENT USING(DEPARTMENT_NO)
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 누적학생수 DESC)
WHERE ROWNUM <=3;








