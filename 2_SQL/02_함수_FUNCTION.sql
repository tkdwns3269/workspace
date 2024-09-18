SELECT EMP_ID, EMP_NAME, SALARY --3
FROM EMPLOYEE                   --1 ���� ����
WHERE DEPT_CODE IS NULL;        --2
-- NULL�� ���� ���� IS NULL �Ǵ� IS NOT NULL�� �ؾ��Ѵ�.

/*
    <ORDER BY��>
    SELECT�� ���� ������ �ٿ� �ۼ�, ������� ���� ���� �������� ����ȴ�.
    
    [ǥ����]
    SELECT ��ȸ�� �÷�...
    FROM ��ȸ�� ���̺�
    WHERE ���ǽ�
    ORDER BY ���ı��� �� �÷� | ��Ī | �÷����� [ASC | DESC] [NULLS FIRST | NULLS LAST]
    
    -ASC : �������� (���� ������ �����ؼ� ���� ���� Ŀ���� ��) ->�⺻��
    -DESC : �������� (ū ������ �����ؼ� ���� ���� �پ��� ��)
    
    -NULL�� �⺻������ ���� ū ������ �з��ؼ� �����Ѵ�.
    -NULLS FIRST : �����ϰ��� �ϴ� �÷� ���� NULL�� ������� �ش� ������ �� �տ� ��ġ(DESC�϶� �⺻��)
    -NULLS LAST : �����ϰ��� �ϴ� �÷� ���� NULL�� ������� �ش� ������ �� �������� ��ġ(ASC�϶� �⺻��)
    
*/

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS; --�⺻���� ��������
--ORDER BY BONUS ASC;
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC; -- NULLS FIRST �⺻��
ORDER BY BONUS DESC, SALARY ASC;
--���� ���ؿ� �÷����� ������ ��� �� ���������� ���ؼ� �������� ������ �� �ִ�.

--�� ����� �����, ����(���ʽ� ����) ��ȸ(�� �� ������ �������� ����)
SELECT EMP_NAME, SALARY * 12 AS "����"
FROM EMPLOYEE
--ORDER BY SALARY * 12 DESC;
--ORDER BY ���� DESC;
ORDER BY 2 DESC; --���� ��밡�� ����Ŭ�� ���� 1���� ����

/*
    <�Լ� FUNCTION>
    ���޵� �÷� ���� �޾Ƽ� �Լ��� ������ ����� ��ȯ
    
    -������ �Լ� : N���� ���� �о�鿩�� N���� ������� ���� (���ึ�� �Լ� ���� ����� ��ȯ)
    -�׷��Լ� : N���� ���� �о�鿩�� 1���� ������� ����(�׷��� ��� �׷캰�� �Լ� ���� ����� ��ȯ)
    
    >>SELECT ���� ������ �Լ��� �׷��Լ��� �Բ� ������� ����
    -> ��� ���� ������ �ٸ��� ����
    
    >>�Լ��� ����� �� �ִ� ��ġ : SELECT�� WHERE�� ORDER BY�� HAVING��
*/

--===========================<������ �Լ�>===============================

/*
    <����ó���Լ�>
    
    *LENGTH(�÷� | '���ڿ�') : �ش� ���ڿ��� ���ڼ��� ��ȯ
    *LENGTHB(�÷� | '���ڿ�') : �ش� ���ڿ��� ����Ʈ ���� ��ȯ
    
    '��' '��' '��' �ѱ��� ���ڴ� 3BYTE
    ������, ����, Ư������ ���ڴ� 1BYTE
    
*/

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL;


SELECT LENGTH('ORACLE') , LENGTHB('ORACLE')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

/*
    *INSTR
    ���ڿ��κ��� Ư�� ������ ������ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷� | '���ڿ�', 'ã�����ϴ� ����', (['ã�� ��ġ�� ���۰�, ����']) -> ����� NUMBER
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; --���ʿ� �ִ� ù B�� 3��° ��ġ�� �ִ�.
--ã�� ��ġ ���۰�: 1, ���� 1=> �⺻��
SELECT INSTR('AABAACAABBAA', 'B',1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; --�ڿ������� ã�Ƽ� ���� ���� �տ������� �о��ش�.
SELECT INSTR('AABAACAABBAA', 'B',1,2) FROM DUAL; --������ �����Ϸ��� ��ġ�� ���۰��� ǥ���ؾ��Ѵ�.
SELECT INSTR('AABAACAABBAA', 'B',1,3) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_' , 1, 1), INSTR(EMAIL, '@')
FROM EMPLOYEE;

/*
    SUBSTR
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
    
    [ǥ����]
    SUBSTR{STRING, POSITION, (LENGTH)}
    -STRING : ����Ÿ�� �÷� | '���ڿ�'
    -POSITION : ���ڿ� ������ ������ġ ��
    -LENTH :������ ���� ����(�����ϸ� ������)
    
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 7��° ��ġ���� ������ ����
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL; --SHOW ME
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE;

--������� ������鸸 EMP_NO, EMP_NAME ��ȸ
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4'
ORDER BY EMP_NAME;

--�Լ� ��ó��� ����
--�̸����� ���̵�κ� ����
--�����Ͽ��� �����, �̸���, ���̵� ��ȸ
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL , 1, INSTR(EMAIL , '@') -1)
FROM EMPLOYEE;

----------------------------------------------------------------

/*
    *LPAD/RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ��ְ� ��ȸ�ϰ��� �� �� ���
    
    [ǥ����]
    LPAD / RPAD (STRING , ���������� ��ȯ�� ���ڿ��� ����, [�����̰��� �ϴ� ����])
    
    ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� �ٿ��� ���� N���̸�ŭ ���ڿ��� ��ȯ
*/
--20��ŭ�� ���� �� EAMIL�÷����� ���������� �����ϰ� ������ �κ��� �������� ä���.
SELECT EMP_NAME, LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

--������� �����, �ֹε�Ϲ�ȣ ��ȸ("701011-1XXXXXXX")
SELECT EMP_NAME, SUBSTR(EMP_NO, 1,8) || 'XXXXXX'
--SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, 'X')
FROM EMPLOYEE;

----------------------------------------------------------------

/*
    *LTRIM/ RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    
    LTRIM/RTRIM(STRING, [�����ϰ��� �ϴ� ���ڵ�])
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ� ��ȯ
*/

SELECT LTRIM('       K      H    ') FROM DUAL;
SELECT LTRIM('ACBABCAABCKKH', 'ABC') FROM DUAL;
SELECT RTRIM('51354321KH543542' , '0123456789') FROM DUAL;

----------------------------------------------------------------

/*
    *TRIM
    ���ڿ��� ��/��/���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    TRIM([LEADING | TRAILING | BOTH] �����ϰ��� �ϴ� ���ڿ� FROM ���ڿ�)
*/

SELECT TRIM('          K        H          ') FROM DUAL; --���ʿ� �ִ� ���� ����
SELECT TRIM('Z' FROM 'ZZZZZZKHZZZZZZZZZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZZZZZZZZZZKHZZZZZZZZ') FROM DUAL; --LTRIM
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZZZZZZZZZKHZZZZZZZZ') FROM DUAL; --RTRIM

----------------------------------------------------------------
/*
    *LOWER/ UPPER/ INITCAP
    LOWER : �� �ҹ��ڷ� ������ ���ڿ� ��ȯ
    UPPER : �� �빮�ڷ� ������ ���ڿ� ��ȯ
    INITCAP : ���� ���� ù���ڸ��� ����ڷ� ������ ���ڿ� ��ȯ
    
*/

SELECT LOWER('Welcom To my KH') FROM DUAL;
SELECT UPPER('Welcom To my KH') FROM DUAL;
SELECT INITCAP('welcom to my kH') FROM DUAL;

----------------------------------------------------------------
/*
    *CONCAT
    ���ڿ� �ΰ� ���޹޾� �ϳ��� ��ģ �� ��ȯ
    CONCAT(STRING1, STRING2)
    
*/

SELECT CONCAT('������', 'ABC') FROM DUAL;
SELECT '������' || 'ABC' FROM DUAL;

----------------------------------------------------------------
/*
    *REPLACE
    Ư�� ���ڿ����� Ư���κ��� �ٸ� �κ����� ��ü
    REPLACE(���ڿ�, ã�� ���ڿ�, ������ ���ڿ�)
    
*/
SELECT EMAIL, REPLACE(EMAIL, 'KH.or.kr', 'gmail.com')
FROM EMPLOYEE;

----------------------------------------------------------------
/*
    <���� ó���Լ�>
    
    *ABS
    ������ ���밪�� �����ִ� �Լ�

*/

SELECT ABS(-10), ABS(-6.3) FROM DUAL;

----------------------------------------------------------------

/*
    *MOD
    �� ���� ���� ���������� ��ȯ
    MOD(NUMBER,NUMBER)
*/

SELECT MOD(10,3) FROM DUAL;
SELECT MOD(10.9,3) FROM DUAL;

----------------------------------------------------------------

/*
    *ROUND
    �ݿø��� ����� ��ȯ
    ROUND(NUMBER, [��ġ])
*/

SELECT ROUND(123.456) FROM DUAL; --�⺻������ �Ҽ��� ù��° �ڸ����� �ݿø�
SELECT ROUND(123.456, 1) FROM DUAL; -- ����� �����Ҽ��� �Ҽ��� �ڷ� ��ĭ�� �̵�
SELECT ROUND(123.456, -1) FROM DUAL; --������ �����Ҽ��� �Ҽ��� ���ڸ��� �̵�

----------------------------------------------------------------

/*
    *CEIL
    �ø�ó���� ���� �Լ�
    CEIL(NUMBER)
*/

SELECT CEIL(123.456) FROM DUAL;

----------------------------------------------------------------

/*
    TRUNC
    ����ó�� �Լ�
    
    TRUNC(NUMBER,[��ġ])
*/

SELECT TRUNC(123.952) FROM DUAL;
SELECT TRUNC(123.952,1) FROM DUAL;
SELECT TRUNC(123.952, -1) FROM DUAL;

------------------------------����----------------------------------
--�˻��ϰ��� �ϴ� ����
--JOB_CODE�� J7�̰ų� J6�̸鼭 SALARY���� 200���� �̻��̰�
--BONUS�� �ְ� ������ ����� �̸�, �ֹι�ȣ, �����ڵ�, �޿�, ���ʽ��� ��ȸ�ϰ� �ʹ�.

SELECT EMP_NAME AS �̸� , EMP_NO AS �ֹι�ȣ , SALARY AS �޿� , BONUS AS ���ʽ�, JOB_CODE AS �����ڵ�
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000 
AND BONUS IS NOT NULL AND (SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4');

-----------------------------------------------------------------------

/*
    <��¥ ó���Լ�>
    
*/

-- *SYSDATE: �ý����� ���� ��¥ �� �ð��� ��ȯ
SELECT SYSDATE FROM DUAL;

-- *MONTHS_BETWEEN: �� ��¥ ������ ���� ��
-- ������� �����, �Ի���, �ٹ� �ϼ�, �ٹ� ������ ��ȸ
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE),
        CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM EMPLOYEE;

--------------------------------------------------------

--*ADD_MONTHS : Ư�� ��°�� NUMBER �������� ���ؼ� ��ȯ
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL;

--�ٷ��� ���̺��� �����, �Ի���, �Ի��� 3������ ��¥ ��ȸ
SELECT EMP_NAME AS ����� , HIRE_DATE AS �Ի���, ADD_MONTHS(HIRE_DATE, 3) AS "�Ի��� 3����"
FROM EMPLOYEE;

-- *NEXT_DAY(DATE, ����(���� | ����)) : Ư����¥ ���� ���� ����� ������ ��¥�� ��ȯ
SELECT NEXT_DAY(SYSDATE, '�����') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;

-- 1:��, ~7: ��
SELECT NEXT_DAY(SYSDATE, 7) FROM DUAL;

--��� ����
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

-- *LAST_DAY(DATE) : �ش���� ������ ��¥ ���ؼ� ��ȯ
SELECT LAST_DAY(SYSDATE) FROM DUAL;

/*
    *EXTRACT : Ư�� ��¥�κ��� ��|��|�� ���� �����ؼ� ��ȯ�ϴ� �Լ�
    
    [ǥ����]
    EXTRACT(YEAR FROM DATE) : ������ ����
    EXTRACT(MONTH FROM DATE) : �� �� ����
    EXTRACT(DAY FROM DATE) : �� �� ����
*/

-- ����� �����, �Ի�⵵, �Ի��, �Ի����� ��ȸ
SELECT EMP_NAME,
        EXTRACT(YEAR FROM HIRE_DATE) AS �Ի�⵵,
        EXTRACT(MONTH FROM HIRE_DATE) AS �Ի��,
        EXTRACT(DAY FROM HIRE_DATE) AS �Ի���
FROM EMPLOYEE
ORDER BY 2, 3, 4;

/*
    [����ȯ �Լ�]
    *TO_CHAR : ����Ÿ�� �Ǵ� ��¥Ÿ���� ���� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    [ǥ����]
    TO_CHAR(����|����, {����})
*/

--���� ->����
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(12,'999999') FROM DUAL; -- 9�� �ڸ�����ŭ ���� Ȯ��, ������ ����
SELECT TO_CHAR(12,'000000') FROM DUAL; -- 0�� �ڸ�����ŭ ���� Ȯ��, ��ĭ�� 0���� ä��
SELECT TO_CHAR(2000000, 'L9999999') FROM DUAL; -- ���� ������ ������ ���� ȭ����� ��Ÿ��

SELECT TO_CHAR(3500000, 'L9,999,999') FROM DUAL;

--��¥Ÿ�� -> ����Ÿ��
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- AM, PM � ���� ����ϰ� ������ �����ִ� ���̱⿡ �����ϰ� ��Ÿ��
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" HH:MI:SS') FROM DUAL;

--������� �̸�, �Ի糯¥(0000�� 00�� 00��) ��ȸ
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') 
FROM EMPLOYEE;

--�⵵�� ���õ� ����
SELECT TO_CHAR (SYSDATE, 'YYYY'),
        TO_CHAR (SYSDATE, 'YY'),
        TO_CHAR (SYSDATE, 'RRRR'), --RR���� ���� �����Ѵ� -> 50�� �̻��� +100EX)1954
        TO_CHAR (SYSDATE, 'YEAR')
FROM DUAL;

SELECT HIRE_DATE, TO_CHAR(HIRE_DATE, 'YY'), TO_CHAR(HIRE_DATE, 'RR') FROM EMPLOYEE;

--���� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
        TO_CHAR(SYSDATE, 'MON'),
        TO_CHAR(SYSDATE, 'MONTH')
FROM DUAL;

--�Ͽ� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'DDD'), --������ �̹��⵵�� ���° �ϼ�
        TO_CHAR(SYSDATE, 'DD'), --���� ����
        TO_CHAR(SYSDATE, 'D') --���� -> ����
FROM DUAL;

--������ ��Ÿ���� ����
SELECT TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

------------------------------------------------------------------

/*
    TO_DATE :����Ÿ�� �Ǵ� ����Ÿ���� ��¥Ÿ������ �����ϴ� �Լ�
    
    TO_DATE(���� | ���� , {����}) -> DATE
    
*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(240807) FROM DUAL; --50�� �̸��� �ڵ����� 20XX���� ���� 50�� �̻��� 19XX���� �����ȴ�.

SELECT TO_DATE(020505) FROM DUAL; --���ڴ� 0���� ������ �� ����.
SELECT TO_DATE('020505') FROM DUAL;

SELECT TO_DATE('020505 120500') FROM DUAL;
SELECT TO_DATE('020505 120500','YYMMDD HH24MISS') FROM DUAL;

/*
    TO_NUMBER :����Ÿ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    [ǥ����]
    TO_NUMBER(����,{����})
*/

SELECT TO_NUMBER('05123456789') FROM DUAL;

SELECT '100000' + '55000' FROM DUAL;
SELECT '100,000' + '55,000' FROM DUAL;
SELECT TO_NUMBER('100,000', '999,999') + TO_NUMBER('55,000','99,000') FROM DUAL;

/*
    [NULLó�� �Լ�]
*/

--*NVL (�÷�, �ش��÷��� NULL�� ��� ������ ��)
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

--�� ����� �̸�, ���ʽ� ���� ���� ��ȸ
SELECT EMP_NAME, (SALARY + (SALARY * NVL(BONUS,0))) *12
FROM EMPLOYEE;

--*NVL2(�÷�, ��ȯ�� 1, ��ȯ�� 2)
--��ȯ��1 : �ش��÷��� ������ ��� ������ ��
--��ȯ��2 : �ش��÷��� NULL�ϰ�� ������ ��
SELECT EMP_NAME, BONUS, NVL2(BONUS, 'o', 'x')
FROM EMPLOYEE;

--*NULLIF(�񱳴��1, �񱳴��2)
-- �� ���� ��ġ�ϸ� NULL ��ġ���� ������ �񱳴��1 ��ȯ
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;

-------------------------------------------------
/*
    [�����Լ�]
    *DECODE(���ϰ����ϴ� ���(�÷�, �����, �Լ���), �񱳰�1, �����1, �񱳰�2, �����2...)
    
*/

--���, �����, �ֹι�ȣ, ����
SELECT EMP_ID, EMP_NAME, EMP_NO, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2','��', '3','��','4','��', '�ܰ���') AS "����"
FROM EMPLOYEE;

--������ ����, �����޿�, �λ�� �޿� ��ȸ * �� ���޺��� �λ��ؼ� ��ȸ
--J7�� ����� �޿��� 10%�λ� (SALARY * 1.1)
--J6�� ����� �޿��� 15%�λ� (SALARY * 1.15) 
--J5�� ����� �޿��� 20%�λ� (SALARY * 1.2)
--�׿� ������� �޿��� 5%�λ� (SALARY * 1.05)

SELECT EMP_NAME, SALARY AS "�λ���",
        DECODE(JOB_CODE, 
        'J7', SALARY * 1.1,
        'J6', SALARY * 1.15,
        'J5', SALARY * 1.2,
         SALARY * 1.05) AS "�λ���"      
FROM EMPLOYEE;

/*
    *CASE WHEN THEN
    
    CASE
        WHEN ���ǽ� 1 THEN ����� 1
        WHEN ���ǽ� 2 THEN ����� 2
        ...
        ELSE �����
    END
*/

SELECT EMP_NAME, SALARY,
        CASE 
            WHEN SALARY >=5000000 THEN '���'
            WHEN SALARY >=3500000 THEN '�߱�'
            ELSE '�ʱ�'
        END
FROM EMPLOYEE;


------------------------------------------------------

--1. SUM(����Ÿ���÷�) : �ش�Ŀ�� ������ �� �հ踦 ������ ��ȯ���ִ� �Լ�

--�ٷ������̺��� ������� �� �޿��� ���ض�
SELECT SUM(SALARY)
FROM EMPLOYEE;

--���ڻ������ �� �޿��� ���ض�
SELECT SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN('1','3');

--�μ� �ڵ尡 D5�� ������� �� ����(�޿� * 12)
SELECT SUM(SALARY*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--2. AVG(NUMBER) : �ش� �÷������� ����� ������ ��ȯ
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

--3. MIN(��� Ÿ�԰���) : �ش� �÷��� �� ���� ���� ���� ���ؼ� ��ȯ
SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

--4. MAX(��� Ÿ�� ����) : �ش� �÷����� �� ���� ū ���� ���ؼ� ��ȯ
SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

--5. COUNT(* | �÷� | DISTINCT �÷�) : �ش� ���ǿ� �´� ���� ������ ���� ��ȯ
--COUNT(*) : ��ȸ�� ����� ��� ���� ������ ���� ��ȯ
--COUNT(�÷�) : ������ �ش� �÷����� NULL�� �ƴ� �͸� ���� ���� ���� ��ȯ
--COUNT(DISRINCT �÷�) : �ش� �÷��� �ߺ��� ������ �� ���� ������ ���� ��ȯ

--��ü ��� ��
SELECT COUNT(*) FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

--���ʽ��� �޴� ��� ��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

SELECT COUNT(BONUS)
FROM EMPLOYEE;

--���� ������� �� ��� �μ��� �����Ǿ� �ִ����� ���ض�
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

--��������

--1.1. JOB ���̺��� ��� ���� ��ȸ
SELECT *
FROM JOB;

--2. JOB ���̺��� ���� �̸� ��ȸ
SELECT JOB_NAME
FROM JOB;

--3. DEPARTMENT ���̺��� ��� ���� ��ȸ
SELECT *
FROM DEPARTMENT;

--4. EMPLOYEE���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

--5. EMPLOYEE���̺��� �Ի���, ��� �̸�, ���� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

--6. EMPLOYEE���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ� - (����*���� 3%)) ��ȸ
SELECT EMP_NAME, SALARY * 12 AS ����, (SALARY+ (SALARY * NVL(BONUS,0))) * 12 AS �Ѽ��ɾ�,
(SALARY+ (SALARY * NVL(BONUS,0))) * 12 - ((SALARY + (SALARY * NVL(BONUS,0))) * 12 * 0.03) AS �Ǽ��ɾ�
FROM EMPLOYEE;

--7. EMPLOYEE���̺��� SAL_LEVEL�� S1(������ 600��~1000��)�� ����� �̸�, ����, �����, ����ó ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SALARY BETWEEN 6000000 AND 10000000;

--8. EMPLOYEE���̺��� �Ǽ��ɾ�(6�� ����)�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
SELECT EMP_NAME, SALARY, (SALARY+ (SALARY * NVL(BONUS,0))) * 12 
- ((SALARY + (SALARY * NVL(BONUS,0))) * 12 * 0.03) AS "�Ǽ��ɾ�", HIRE_DATE
FROM EMPLOYEE
WHERE (SALARY+ (SALARY * NVL(BONUS,0))) * 12 
- ((SALARY + (SALARY * NVL(BONUS,0))) * 12 * 0.03) >=50000000;

--9. EMPLOYEE���̺� ������ 4000,000�̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY > 4000000 AND JOB_CODE = 'J2';

--10. EMPLOYEE���̺� DEPT_CODE�� D9�̰ų� D5�� ��� ��
-- ������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE ='D9' OR DEPT_CODE ='D5') AND HIRE_DATE < '02/01/01';

--11. EMPLOYEE���̺� ������� 90/01/01 ~ 01/01/01�� ����� ��ü ������ ��ȸ
SELECT * 
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

--12. EMPLOYEE���̺��� �̸� ���� '��'���� ������ ����� �̸� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

--13. EMPLOYEE���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--14. EMPLOYEE���̺��� �����ּ� '_'�� ���� 4���̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰�
-- ������� 90/01/01 ~ 00/12/01�̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____$_%' ESCAPE '$'  
AND (DEPT_CODE = 'D9' OR DEPT_CODE ='D6')
AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
AND SALARY >= 2700000;

--15. EMPLOYEE���̺��� ��� ��� ������ �ֹι�ȣ�� �̿��Ͽ� ����, ����, ���� ��ȸ
SELECT EMP_NAME,
        SUBSTR(EMP_NO,1,2) AS ����,
        SUBSTR(EMP_NO,3,2) AS ����,
        SUBSTR(EMP_NO,5,2) AS ����
FROM EMPLOYEE;

--16. EMPLOYEE���̺��� �����, �ֹι�ȣ ��ȸ (��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ�, '-'���� ���� '*'�� �ٲٱ�)
--SELECT EMP_NAME, SUBSTR(EMP_NO,1,7) || '*******'
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*')
FROM EMPLOYEE;

--17. EMPLOYEE���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
 --(��, �� ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ǵ��� �ϰ� ��� ����(����), ����� �ǵ��� ó��)
SELECT EMP_NAME, FLOOR(ABS(HIRE_DATE-SYSDATE)) AS �ٹ��ϼ�1 ,
                  FLOOR(ABS(SYSDATE - HIRE_DATE)) AS �ٹ��ϼ�2
FROM EMPLOYEE;

--18. EMPLOYEE���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID ,2) = 1; --�ڵ�����ȯ ����
--WHERE MOD(TO_NUMBER(EMP_ID) ,2) = 1;

--19. EMPLOYEE���̺��� �ٹ� ����� 20�� �̻��� ���� ���� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 240;
WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE;

--20. EMPLOYEE ���̺��� �����, �޿� ��ȸ (��, �޿��� '\9,000,000' �������� ǥ��)
SELECT EMP_NAME, TO_CHAR(SALARY, 'L9,999,999')
FROM EMPLOYEE;

--21. EMPLOYEE���̺��� ���� ��, �μ��ڵ�, �������, ����(��) ��ȸ
-- (��, ��������� �ֹι�ȣ���� �����ؼ� 00�� 00�� 00�Ϸ� ��µǰ� �ϸ�
-- ���̴� �ֹι�ȣ���� ����ؼ� ��¥�����ͷ� ��ȯ�� ���� ���)
SELECT EMP_NAME, DEPT_CODE,
    SUBSTR(EMP_NO,1,2) || '��' || SUBSTR(EMP_NO,1,2) || '��' || SUBSTR(EMP_NO,1,2) || '��' AS ����,
    ABS(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'YY')))
    FROM EMPLOYEE;
--22. EMPLOYEE���̺��� �μ��ڵ尡 D5, D6, D9�� ����� ��ȸ�ϵ� D5�� �ѹ���, D6�� ��ȹ��, D9�� �����η� ó��
-- (��, �μ��ڵ� ������������ ����)
SELECT EMP_ID, EMP_NAME, DEPT_CODE,
        DECODE(DEPT_CODE, 'D5', '�ѹ���', 'D6', '��ȹ��', 'D9', '������')
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D9')
ORDER BY DEPT_CODE;

---23. EMPLOYEE���̺��� ����� 201���� �����, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ�, 
-- �ֹι�ȣ ���ڸ��� ���ڸ��� �� ��ȸ
SELECT EMP_NAME,
        SUBSTR(EMP_NO,1,6) AS ���ڸ�,
        SUBSTR(EMP_NO, 8) AS ���ڸ�,
        SUBSTR(EMP_NO,1,6) + SUBSTR(EMP_NO, 8)
FROM EMPLOYEE
WHERE EMP_ID = 201;
--24. EMPLOYEE���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ���� �� ��ȸ
SELECT SUM((SALARY + (SALARY * NVL(BONUS,0))) *12)
FROM EMPLOYEE
WHERE DEPT_CODE= 'D5';
--25. EMPLOYEE���̺��� �������� �Ի��Ϸκ��� �⵵�� ������ �� �⵵�� �Ի� �ο��� ��ȸ
-- ��ü ���� ��, 2001��, 2002��, 2003��, 2004��
SELECT COUNT(*) AS ��ü������,
        COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), 2001, 1, NULL)) AS "2001��",
        COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), 2002, 1, NULL)) AS "2002��",
        COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), 2003, 1, NULL)) AS "2003��",
        COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), 2004, 1, NULL)) AS "2004��"
FROM EMPLOYEE;