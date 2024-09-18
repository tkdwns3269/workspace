/*
    <JOIN>
    두개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
    조회 결과는 하나의 결과(RESULT SET)를 반환한다.

    관계형 데이터베이스에서는 최소한의 데이터를 각각의 테이블에 담고 있음
    (무작정 다 조회해 오는게 아니라 각 테이블간 연결고리(외래키)를 통해 데이터를 매칭시켜 조회해야한다)
    
    JOIN은 크게 "오라클 전용구문" "ANSI 구문"
    
    [용어정리]
    
            오라클 전용 구문           |           ANSI 구문
    --------------------------------------------------------------------
                등가조인              |            내부조인
              (EQUAL JOIN)           |   (INNER JOIN) -> JOIN USING/ON
    ---------------------------------------------------------------------
                포괄조인              |          외부조인
              LEFT, RIGHT            |        LEFT, RIGHT, FULL
---------------------------------------------------------------------------
               자체조인               |           JOIN ON
              비증가 조인             |
*/  

--전체 사원들의 사번, 사원명, 부서코드, 부서명
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;


/*
    1.등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
    연결시키는 컬럼의 값이 일치하는 행들만 조회(일치하는 값이 없는 행은 조회 제외
*/
----> ANSI 구문
--FROM절에 기준이되는 테이블 하나 기술
--JOIN절에 같이 조인하고자 하는 테이블 기술 + 매칭시킬 컬럼에 대한 조건
--JOIN USING/ JOIN ON

--1. 연결할 두 컬럼명이 다른경우(EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID
--JOIN ON
--전체 사원들의 사번, 사원명, 부서코드 , 부서명
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--2. 연결한 두 컬럼명이 동일한 경우
 --전체 사원들의 사번, 사원명, 직급코드 ,직급명
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

--JOIN USING(연결하는 컬럼명이 같은 경우만 가능)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB USING (JOB_CODE);

-->오라클 전용 구문
--FROM절에 조회하고자하는 테이블들 나열(, 로 구분)
--WHERE절에 매칭시킬 컬럼에 대한 조건을 제시
--1. 연결할 두 컬럼명이 다른 경우(EMPLOYEE : DEPT_CODE / DEPARTMENT: DEPT_ID)
--전체 사원들의 사번, 사원명, 부서코드, 부서명
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E , JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

--추가적인 조건제시
--직급이 대리인 사원의 사번, 사원명, 직급명, 급여 조회
--오라클
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E , JOB J
WHERE E.JOB_CODE, J.JOB_CODE AND JOB_NAME = '대리';
--ANSI
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';

----------------------------------실습------------------------------------
--1. 부서가 인사관리부인 사원들의 사번, 이름, 보너스 조회
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

--2. DEPARTMENT와 LOCATION 테이블을 참고하여 전체 부서의 부서코드, 부서명, 지역코드, 지역명 조회
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

--3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;
--4. 부서가 총무부가 아닌 사원들의 사원명, 급여 조회
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '총무부';




-----------------------------------------------------------------

/*
    2.포괄조인 / 외부조인(OUTER JOIN)
    두 테이블간의 JOIN시 일치하지 않는 행도 포함시켜 조회 가능
    단, 반드시 LEFT/RIGHT를 지정해야 한다. ( 어떤 테이블이 기준이냐)
*/

------------------------------------------------------------------
--외부조인과 비교할만한 내부조인
-- 사원명, 부서명, 급여, 연봉
-- 부서배치를 받지않은 2명의 사원정보 누락됨

--1) LEFT [OUTER] JOIN : 두 테이블 중 왼편에 기술된 테이블을 기준으로 JOIN
--ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--오라클
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

--2) RIGHT [OUTER] JOIN : 두 테이블 중 오른편에 기술된 테이블들을 기준으로 JOIN
--ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--오라클
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

--FULL [OUTER] JOIN : 두 테이블이 가진 모든 행을 조회할 수 있다.
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

---------------------------------------------------------------------------------------
/*
    3.등가조인(NON EQAUL JOIN)
    매칭시킬 컬럼에 대한 조건 작성시 '=' 를 사용하지 않는 조인문
    ANSI 구문사용시 JOIN ON 만 사용가능
*/

--사원명, 급여, 급여레벨 조회
--ANSI
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY >= MIN_SAL AND SALARY <= MAX_SAL);

--오라클
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-------------------------------------------------------------------

/*
    4. 자체조인
    같은 테이블을 다시한번 조인하는 경우
    
*/

--전체사원의 사원사번, 사원명, 사원부서코드 --> EMPLOYEE E
--          사수사번, 사수명, 사수부서코드 --> EMPLOYEE M

--ANSI
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, 
        M.EMP_ID, M.EMP_NAME, M.DEPT_CODE 
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

--오라클
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, 
        M.EMP_ID, M.EMP_NAME, M.DEPT_CODE 
FROM EMPLOYEE E , EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

-------------------------------------------------------------------

/*
    <다중조인>
    2개 이상의 테이블을 가지고 JOIN할 수 있다.
    
*/

--사번, 사원명, 부서명, 직급명
--ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

--오라클
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE E.DEPT_CODE = DEPT_ID
AND E.JOB_CODE = J.JOB_CODE;

--사번, 사원명, 부서명, 지역명 조회
SELECT * FROM EMPLOYEE; --DEPT_CODE
SELECT * FROM DEPARTMENT; --DEPT_ID     LOCATION_ID
SELECT * FROM LOCATION;              --LOCAL_CODE

--ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

----------------------실습--------------------------
--1. 사번, 사원명, 부서명, 지역명, 국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE);
--2. 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 급여등급 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);



---------------------------------------------------------

--1. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과 주민번호, 부서 명, 직급 조회
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE SUBSTR(EMP_NO, 8, 1) = '2' 
AND SUBSTR(EMP_NO, 1, 2) >=70 
AND SUBSTR(EMP_NO, 1,2)<80
AND EMP_NAME LIKE '전%';
--2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회
--SELECT TO_DATE(SUBSTR(EMP_NO,1 ,2), 'YY')
--FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME,
EXTRACT(YEAR FROM SYSDATE) 
- EXTRACT(YEAR FROM(TO_DATE(SUBSTR(EMP_NO, 1, 2),'RR')) +1) AS "나이",
DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE ;
--3. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회  
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE '%형%';
--4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회
SELECT EMP_NAME , JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_ID IN ('D5','D6');
--5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회
SELECT EMP_NAME, BONUS, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;
--6. 사원 명, 직급 명, 부서 명, 지역 명 조회
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);
--7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('한국','일본');
--8. 한명의 사원과 같은 부서에서 일하는 사원의 이름 조회(자체조인 활용)
SELECT E.EMP_NAME, E.DEPT_CODE, D.EMP_NAME
FROM EMPLOYEE E
JOIN EMPLOYEE D ON (E.DEPT_CODE = D.DEPT_CODE)
WHERE E.EMP_ID != D.EMP_ID
ORDER BY E.EMP_ID;
--9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용)
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE NVL(BONUS, 0) = 0 AND JOB_CODE IN ('J4','J7');
--10. 부서 명과 부서 별 급여 합계 조회
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE= DEPT_ID)
GROUP BY DEPT_TITLE;

