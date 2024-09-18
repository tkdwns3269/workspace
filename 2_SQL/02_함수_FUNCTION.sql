SELECT EMP_ID, EMP_NAME, SALARY --3
FROM EMPLOYEE                   --1 실행 순서
WHERE DEPT_CODE IS NULL;        --2
-- NULL을 비교할 때는 IS NULL 또는 IS NOT NULL로 해야한다.

/*
    <ORDER BY절>
    SELECT로 가장 마지막 줄에 작성, 실행순서 또한 가장 마지막에 실행된다.
    
    [표현법]
    SELECT 조회할 컬럼...
    FROM 조회할 테이블
    WHERE 조건식
    ORDER BY 정렬기준 될 컬럼 | 별칭 | 컬럼순번 [ASC | DESC] [NULLS FIRST | NULLS LAST]
    
    -ASC : 오름차순 (작은 값으로 시작해서 값이 점점 커지는 것) ->기본값
    -DESC : 내림차순 (큰 값으로 시작해서 값이 점점 줄어드는 것)
    
    -NULL은 기본적으로 가장 큰 값으로 분류해서 정렬한다.
    -NULLS FIRST : 정렬하고자 하는 컬럼 값에 NULL이 있을경우 해당 데이터 맨 앞에 배치(DESC일때 기본값)
    -NULLS LAST : 정렬하고자 하는 컬럼 값에 NULL이 있을경우 해당 데이터 맨 마지막에 배치(ASC일때 기본값)
    
*/

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS; --기본값이 오름차순
--ORDER BY BONUS ASC;
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC; -- NULLS FIRST 기본값
ORDER BY BONUS DESC, SALARY ASC;
--정렬 기준에 컬럼값이 동일할 경우 그 다음차순을 위해서 여러개를 제시할 수 있다.

--전 사원의 사원명, 연봉(보너스 제외) 조회(이 때 연봉별 내림차순 정렬)
SELECT EMP_NAME, SALARY * 12 AS "연봉"
FROM EMPLOYEE
--ORDER BY SALARY * 12 DESC;
--ORDER BY 연봉 DESC;
ORDER BY 2 DESC; --순번 사용가능 오라클은 전부 1부터 시작

/*
    <함수 FUNCTION>
    전달된 컬럼 값을 받아서 함수를 실행한 결과를 반환
    
    -단일행 함수 : N개의 값을 읽어들여서 N개의 결과값을 리턴 (매행마다 함수 실행 결과를 반환)
    -그룹함수 : N개의 값을 읽어들여서 1개의 결과값을 리턴(그룹을 지어서 그룹별로 함수 실행 결과를 반환)
    
    >>SELECT 절에 단일행 함수랑 그룹함수를 함께 사용하지 못함
    -> 결과 행의 갯수가 다르기 때문
    
    >>함수를 사용할 수 있는 위치 : SELECT절 WHERE절 ORDER BY절 HAVING절
*/

--===========================<단일행 함수>===============================

/*
    <문자처리함수>
    
    *LENGTH(컬럼 | '문자열') : 해당 문자열의 글자수를 반환
    *LENGTHB(컬럼 | '문자열') : 해당 문자열의 바이트 수를 반환
    
    '최' '나' 'ㄱ' 한글은 글자당 3BYTE
    영문자, 숫자, 특수문자 글자당 1BYTE
    
*/

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;


SELECT LENGTH('ORACLE') , LENGTHB('ORACLE')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

/*
    *INSTR
    문자열로부터 특정 문자의 시작위치를 찾아서 반환
    
    INSTR(컬럼 | '문자열', '찾고자하는 문자', (['찾을 위치의 시작값, 순번']) -> 결과는 NUMBER
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; --앞쪽에 있는 첫 B는 3번째 위치해 있다.
--찾을 위치 시작값: 1, 순번 1=> 기본값
SELECT INSTR('AABAACAABBAA', 'B',1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; --뒤에서부터 찾아서 읽을 때는 앞에서부터 읽어준다.
SELECT INSTR('AABAACAABBAA', 'B',1,2) FROM DUAL; --순번을 제시하려면 위치의 시작값을 표시해야한다.
SELECT INSTR('AABAACAABBAA', 'B',1,3) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_' , 1, 1), INSTR(EMAIL, '@')
FROM EMPLOYEE;

/*
    SUBSTR
    문자열에서 특정 문자열을 추출해서 반환
    
    [표현법]
    SUBSTR{STRING, POSITION, (LENGTH)}
    -STRING : 문자타입 컬럼 | '문자열'
    -POSITION : 문자열 추출할 시작위치 값
    -LENTH :추출할 문자 갯수(생략하면 끝까지)
    
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 7번째 위치부터 끝까지 추출
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL; --SHOW ME
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "성별"
FROM EMPLOYEE;

--사원들중 여사원들만 EMP_NO, EMP_NAME 조회
SELECT EMP_NAME, EMP_NO
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4'
ORDER BY EMP_NAME;

--함수 중처사용 가능
--이메일의 아이디부분 추출
--사원목록에서 사원명, 이메일, 아이디 조회
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL , 1, INSTR(EMAIL , '@') -1)
FROM EMPLOYEE;

----------------------------------------------------------------

/*
    *LPAD/RPAD
    문자열을 조회할 때 통일감있게 조회하고자 할 때 사용
    
    [표현법]
    LPAD / RPAD (STRING , 최종적으로 반환할 문자열의 길이, [덧붙이고자 하는 문자])
    
    문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 붙여서 최종 N길이만큼 문자열을 반환
*/
--20만큼의 길이 중 EAMIL컬럼값은 오른쪽으로 정렬하고 나머지 부분은 공백으로 채운다.
SELECT EMP_NAME, LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

--사원들의 사원명, 주민등록번호 조회("701011-1XXXXXXX")
SELECT EMP_NAME, SUBSTR(EMP_NO, 1,8) || 'XXXXXX'
--SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, 'X')
FROM EMPLOYEE;

----------------------------------------------------------------

/*
    *LTRIM/ RTRIM
    문자열에서 특정 문자를 제거한 나머지를 반환
    
    LTRIM/RTRIM(STRING, [제거하고자 하는 문자들])
    
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거한 나머지 문자열 반환
*/

SELECT LTRIM('       K      H    ') FROM DUAL;
SELECT LTRIM('ACBABCAABCKKH', 'ABC') FROM DUAL;
SELECT RTRIM('51354321KH543542' , '0123456789') FROM DUAL;

----------------------------------------------------------------

/*
    *TRIM
    문자열의 앞/뒤/양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    TRIM([LEADING | TRAILING | BOTH] 제거하고자 하는 문자열 FROM 문자열)
*/

SELECT TRIM('          K        H          ') FROM DUAL; --양쪽에 있는 공백 제거
SELECT TRIM('Z' FROM 'ZZZZZZKHZZZZZZZZZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZZZZZZZZZZKHZZZZZZZZ') FROM DUAL; --LTRIM
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZZZZZZZZZKHZZZZZZZZ') FROM DUAL; --RTRIM

----------------------------------------------------------------
/*
    *LOWER/ UPPER/ INITCAP
    LOWER : 다 소문자로 변경한 문자열 반환
    UPPER : 다 대문자로 변경한 문자열 반환
    INITCAP : 띄어쓰기 기준 첫글자마다 대분자로 변경한 문자열 반환
    
*/

SELECT LOWER('Welcom To my KH') FROM DUAL;
SELECT UPPER('Welcom To my KH') FROM DUAL;
SELECT INITCAP('welcom to my kH') FROM DUAL;

----------------------------------------------------------------
/*
    *CONCAT
    문자열 두개 전달받아 하나로 합친 후 반환
    CONCAT(STRING1, STRING2)
    
*/

SELECT CONCAT('가나다', 'ABC') FROM DUAL;
SELECT '가나다' || 'ABC' FROM DUAL;

----------------------------------------------------------------
/*
    *REPLACE
    특정 문자열에서 특정부분을 다른 부분으로 교체
    REPLACE(문자열, 찾을 문자열, 변경할 문자열)
    
*/
SELECT EMAIL, REPLACE(EMAIL, 'KH.or.kr', 'gmail.com')
FROM EMPLOYEE;

----------------------------------------------------------------
/*
    <숫자 처리함수>
    
    *ABS
    숫자의 절대값을 구해주는 함수

*/

SELECT ABS(-10), ABS(-6.3) FROM DUAL;

----------------------------------------------------------------

/*
    *MOD
    두 수를 나눈 나머지값을 반환
    MOD(NUMBER,NUMBER)
*/

SELECT MOD(10,3) FROM DUAL;
SELECT MOD(10.9,3) FROM DUAL;

----------------------------------------------------------------

/*
    *ROUND
    반올림한 결과를 반환
    ROUND(NUMBER, [위치])
*/

SELECT ROUND(123.456) FROM DUAL; --기본지수는 소수점 첫번째 자리에서 반올림
SELECT ROUND(123.456, 1) FROM DUAL; -- 양수로 증가할수록 소수점 뒤로 한칸씩 이동
SELECT ROUND(123.456, -1) FROM DUAL; --음수로 감소할수록 소수점 앞자리로 이동

----------------------------------------------------------------

/*
    *CEIL
    올림처리를 위한 함수
    CEIL(NUMBER)
*/

SELECT CEIL(123.456) FROM DUAL;

----------------------------------------------------------------

/*
    TRUNC
    버림처리 함수
    
    TRUNC(NUMBER,[위치])
*/

SELECT TRUNC(123.952) FROM DUAL;
SELECT TRUNC(123.952,1) FROM DUAL;
SELECT TRUNC(123.952, -1) FROM DUAL;

------------------------------문제----------------------------------
--검색하고자 하는 내용
--JOB_CODE가 J7이거나 J6이면서 SALARY값이 200만원 이상이고
--BONUS가 있고 여자인 사원의 이름, 주민번호, 직급코드, 급여, 보너스를 조회하고 싶다.

SELECT EMP_NAME AS 이름 , EMP_NO AS 주민번호 , SALARY AS 급여 , BONUS AS 보너스, JOB_CODE AS 직급코드
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000 
AND BONUS IS NOT NULL AND (SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4');

-----------------------------------------------------------------------

/*
    <날짜 처리함수>
    
*/

-- *SYSDATE: 시스템의 현재 날짜 및 시간을 반환
SELECT SYSDATE FROM DUAL;

-- *MONTHS_BETWEEN: 두 날짜 사이의 개월 수
-- 사원들의 사원명, 입사일, 근무 일수, 근무 개월수 조회
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE),
        CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM EMPLOYEE;

--------------------------------------------------------

--*ADD_MONTHS : 특정 날째에 NUMBER 개월수를 더해서 반환
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL;

--근로자 테이블에서 사원명, 입사일, 입사후 3개월의 날짜 조회
SELECT EMP_NAME AS 사원명 , HIRE_DATE AS 입사일, ADD_MONTHS(HIRE_DATE, 3) AS "입사후 3개월"
FROM EMPLOYEE;

-- *NEXT_DAY(DATE, 요일(문자 | 숫지)) : 특정날짜 이후 가장 가까운 요일의 날짜를 반환
SELECT NEXT_DAY(SYSDATE, '토요일') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '토') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;

-- 1:일, ~7: 토
SELECT NEXT_DAY(SYSDATE, 7) FROM DUAL;

--언어 변경
ALTER SESSION SET NLS_LANGUAGE = KOREAN;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

-- *LAST_DAY(DATE) : 해당월의 마지막 날짜 구해서 반환
SELECT LAST_DAY(SYSDATE) FROM DUAL;

/*
    *EXTRACT : 특정 날짜로부터 년|월|일 값을 추출해서 반환하는 함수
    
    [표현법]
    EXTRACT(YEAR FROM DATE) : 연도만 추출
    EXTRACT(MONTH FROM DATE) : 월 만 추출
    EXTRACT(DAY FROM DATE) : 일 만 추출
*/

-- 사원의 사원명, 입사년도, 입사월, 입사일을 조회
SELECT EMP_NAME,
        EXTRACT(YEAR FROM HIRE_DATE) AS 입사년도,
        EXTRACT(MONTH FROM HIRE_DATE) AS 입사월,
        EXTRACT(DAY FROM HIRE_DATE) AS 입사일
FROM EMPLOYEE
ORDER BY 2, 3, 4;

/*
    [형변환 함수]
    *TO_CHAR : 숫자타입 또는 날짜타입의 값을 문자타입으로 변환시켜주는 함수
    
    [표현법]
    TO_CHAR(숫자|문자, {포멧})
*/

--숫자 ->문자
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(12,'999999') FROM DUAL; -- 9의 자리수만큼 공간 확보, 오른쪽 정렬
SELECT TO_CHAR(12,'000000') FROM DUAL; -- 0의 자리수만큼 공간 확보, 빈칸을 0으로 채움
SELECT TO_CHAR(2000000, 'L9999999') FROM DUAL; -- 현재 설전된 나라의 로컬 화폐단위 나타냄

SELECT TO_CHAR(3500000, 'L9,999,999') FROM DUAL;

--날짜타입 -> 문자타입
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- AM, PM 어떤 것을 사용하건 형식을 정해주는 것이기에 동일하게 나타남
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" HH:MI:SS') FROM DUAL;

--사원들의 이름, 입사날짜(0000년 00월 00일) 조회
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') 
FROM EMPLOYEE;

--년도와 관련된 포멧
SELECT TO_CHAR (SYSDATE, 'YYYY'),
        TO_CHAR (SYSDATE, 'YY'),
        TO_CHAR (SYSDATE, 'RRRR'), --RR룰이 따로 존재한다 -> 50년 이상값이 +100EX)1954
        TO_CHAR (SYSDATE, 'YEAR')
FROM DUAL;

SELECT HIRE_DATE, TO_CHAR(HIRE_DATE, 'YY'), TO_CHAR(HIRE_DATE, 'RR') FROM EMPLOYEE;

--월과 관련된 포멧
SELECT TO_CHAR(SYSDATE, 'MM'),
        TO_CHAR(SYSDATE, 'MON'),
        TO_CHAR(SYSDATE, 'MONTH')
FROM DUAL;

--일에 관련된 포멧
SELECT TO_CHAR(SYSDATE, 'DDD'), --오늘이 이번년도에 몇번째 일수
        TO_CHAR(SYSDATE, 'DD'), --오늘 일자
        TO_CHAR(SYSDATE, 'D') --요일 -> 숫자
FROM DUAL;

--요일을 나타내는 포멧
SELECT TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

------------------------------------------------------------------

/*
    TO_DATE :숫자타입 또는 문자타입을 날짜타입으로 변경하는 함수
    
    TO_DATE(숫자 | 문자 , {포멧}) -> DATE
    
*/

SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(240807) FROM DUAL; --50년 미만은 자동으로 20XX으로 설정 50년 이상은 19XX으로 설정된다.

SELECT TO_DATE(020505) FROM DUAL; --숫자는 0으로 시작할 수 없다.
SELECT TO_DATE('020505') FROM DUAL;

SELECT TO_DATE('020505 120500') FROM DUAL;
SELECT TO_DATE('020505 120500','YYMMDD HH24MISS') FROM DUAL;

/*
    TO_NUMBER :문자타입의 데이터를 숫자타입으로 변환시켜주는 함수
    
    [표현법]
    TO_NUMBER(문자,{포멧})
*/

SELECT TO_NUMBER('05123456789') FROM DUAL;

SELECT '100000' + '55000' FROM DUAL;
SELECT '100,000' + '55,000' FROM DUAL;
SELECT TO_NUMBER('100,000', '999,999') + TO_NUMBER('55,000','99,000') FROM DUAL;

/*
    [NULL처리 함수]
*/

--*NVL (컬럼, 해당컬럼이 NULL일 경우 보여줄 값)
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

--전 사원의 이름, 보너스 포함 연봉 조회
SELECT EMP_NAME, (SALARY + (SALARY * NVL(BONUS,0))) *12
FROM EMPLOYEE;

--*NVL2(컬럼, 반환값 1, 반환값 2)
--반환값1 : 해당컬럼이 존재할 경우 보여줄 값
--반환값2 : 해당컬럼이 NULL일경우 보여줄 값
SELECT EMP_NAME, BONUS, NVL2(BONUS, 'o', 'x')
FROM EMPLOYEE;

--*NULLIF(비교대상1, 비교대상2)
-- 두 값이 일치하면 NULL 일치하지 않으면 비교대상1 반환
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;

-------------------------------------------------
/*
    [선택함수]
    *DECODE(비교하고자하는 대상(컬럼, 연산식, 함수식), 비교값1, 결과값1, 비교값2, 결과값2...)
    
*/

--사번, 사원명, 주민번호, 성별
SELECT EMP_ID, EMP_NAME, EMP_NO, 
        DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2','여', '3','남','4','여', '외계인') AS "성별"
FROM EMPLOYEE;

--직원의 성명, 기존급여, 인상된 급여 조회 * 각 직급별로 인상해서 조회
--J7인 사원은 급여를 10%인상 (SALARY * 1.1)
--J6인 사원은 급여를 15%인상 (SALARY * 1.15) 
--J5인 사원은 급여를 20%인상 (SALARY * 1.2)
--그외 사원들은 급여를 5%인상 (SALARY * 1.05)

SELECT EMP_NAME, SALARY AS "인상전",
        DECODE(JOB_CODE, 
        'J7', SALARY * 1.1,
        'J6', SALARY * 1.15,
        'J5', SALARY * 1.2,
         SALARY * 1.05) AS "인상후"      
FROM EMPLOYEE;

/*
    *CASE WHEN THEN
    
    CASE
        WHEN 조건식 1 THEN 결과값 1
        WHEN 조건식 2 THEN 결과값 2
        ...
        ELSE 결과값
    END
*/

SELECT EMP_NAME, SALARY,
        CASE 
            WHEN SALARY >=5000000 THEN '고급'
            WHEN SALARY >=3500000 THEN '중급'
            ELSE '초급'
        END
FROM EMPLOYEE;


------------------------------------------------------

--1. SUM(숫자타입컬럼) : 해당커럼 값들의 총 합계를 구래서 반환해주는 함수

--근로자테이블의 전사원의 총 급여를 구해라
SELECT SUM(SALARY)
FROM EMPLOYEE;

--남자사원들의 총 급여를 구해라
SELECT SALARY
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN('1','3');

--부서 코드가 D5인 사원들의 총 연봉(급여 * 12)
SELECT SUM(SALARY*12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--2. AVG(NUMBER) : 해당 컬럼값들의 평균을 구래서 반환
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

--3. MIN(모든 타입가능) : 해당 컬럼값 중 가장 작은 값을 구해서 반환
SELECT MIN(EMP_NAME), MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

--4. MAX(모든 타입 가능) : 해당 컬럼값들 중 가장 큰 값을 구해서 반환
SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

--5. COUNT(* | 컬럼 | DISTINCT 컬럼) : 해당 조건에 맞는 행의 갯수를 세서 반환
--COUNT(*) : 조회된 결과에 모든 행의 갯수를 세서 반환
--COUNT(컬럼) : 제시한 해당 컬럼값이 NULL이 아닌 것만 행의 수를 세서 반환
--COUNT(DISRINCT 컬럼) : 해당 컬럼값 중복을 제거한 후 행의 갯수를 세서 반환

--전체 사원 수
SELECT COUNT(*) FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2';

--보너스를 받는 사원 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

SELECT COUNT(BONUS)
FROM EMPLOYEE;

--현재 사원들이 총 몇개의 부서에 분포되어 있는지를 구해라
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

--연습문제

--1.1. JOB 테이블의 모든 정보 조회
SELECT *
FROM JOB;

--2. JOB 테이블의 직급 이름 조회
SELECT JOB_NAME
FROM JOB;

--3. DEPARTMENT 테이블의 모든 정보 조회
SELECT *
FROM DEPARTMENT;

--4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

--5. EMPLOYEE테이블의 입사일, 사원 이름, 월급 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

--6. EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
SELECT EMP_NAME, SALARY * 12 AS 연봉, (SALARY+ (SALARY * NVL(BONUS,0))) * 12 AS 총수령액,
(SALARY+ (SALARY * NVL(BONUS,0))) * 12 - ((SALARY + (SALARY * NVL(BONUS,0))) * 12 * 0.03) AS 실수령액
FROM EMPLOYEE;

--7. EMPLOYEE테이블에서 SAL_LEVEL이 S1(월급이 600만~1000만)인 사원의 이름, 월급, 고용일, 연락처 조회
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SALARY BETWEEN 6000000 AND 10000000;

--8. EMPLOYEE테이블에서 실수령액(6번 참고)이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
SELECT EMP_NAME, SALARY, (SALARY+ (SALARY * NVL(BONUS,0))) * 12 
- ((SALARY + (SALARY * NVL(BONUS,0))) * 12 * 0.03) AS "실수령액", HIRE_DATE
FROM EMPLOYEE
WHERE (SALARY+ (SALARY * NVL(BONUS,0))) * 12 
- ((SALARY + (SALARY * NVL(BONUS,0))) * 12 * 0.03) >=50000000;

--9. EMPLOYEE테이블에 월급이 4000,000이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY > 4000000 AND JOB_CODE = 'J2';

--10. EMPLOYEE테이블에 DEPT_CODE가 D9이거나 D5인 사원 중
-- 고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE ='D9' OR DEPT_CODE ='D5') AND HIRE_DATE < '02/01/01';

--11. EMPLOYEE테이블에 고용일이 90/01/01 ~ 01/01/01인 사원의 전체 내용을 조회
SELECT * 
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

--12. EMPLOYEE테이블에서 이름 끝이 '연'으로 끝나는 사원의 이름 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

--13. EMPLOYEE테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--14. EMPLOYEE테이블에서 메일주소 '_'의 앞이 4자이면서 DEPT_CODE가 D9 또는 D6이고
-- 고용일이 90/01/01 ~ 00/12/01이고, 급여가 270만 이상인 사원의 전체를 조회
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____$_%' ESCAPE '$'  
AND (DEPT_CODE = 'D9' OR DEPT_CODE ='D6')
AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
AND SALARY >= 2700000;

--15. EMPLOYEE테이블에서 사원 명과 직원의 주민번호를 이용하여 생년, 생월, 생일 조회
SELECT EMP_NAME,
        SUBSTR(EMP_NO,1,2) AS 생년,
        SUBSTR(EMP_NO,3,2) AS 생월,
        SUBSTR(EMP_NO,5,2) AS 생일
FROM EMPLOYEE;

--16. EMPLOYEE테이블에서 사원명, 주민번호 조회 (단, 주민번호는 생년월일만 보이게 하고, '-'다음 값은 '*'로 바꾸기)
--SELECT EMP_NAME, SUBSTR(EMP_NO,1,7) || '*******'
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*')
FROM EMPLOYEE;

--17. EMPLOYEE테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
 --(단, 각 별칭은 근무일수1, 근무일수2가 되도록 하고 모두 정수(내림), 양수가 되도록 처리)
SELECT EMP_NAME, FLOOR(ABS(HIRE_DATE-SYSDATE)) AS 근무일수1 ,
                  FLOOR(ABS(SYSDATE - HIRE_DATE)) AS 근무일수2
FROM EMPLOYEE;

--18. EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID ,2) = 1; --자동형변환 해줌
--WHERE MOD(TO_NUMBER(EMP_ID) ,2) = 1;

--19. EMPLOYEE테이블에서 근무 년수가 20년 이상인 직원 정보 조회
SELECT *
FROM EMPLOYEE
--WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 240;
WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE;

--20. EMPLOYEE 테이블에서 사원명, 급여 조회 (단, 급여는 '\9,000,000' 형식으로 표시)
SELECT EMP_NAME, TO_CHAR(SALARY, 'L9,999,999')
FROM EMPLOYEE;

--21. EMPLOYEE테이블에서 직원 명, 부서코드, 생년월일, 나이(만) 조회
-- (단, 생년월일은 주민번호에서 추출해서 00년 00월 00일로 출력되게 하며
-- 나이는 주민번호에서 출력해서 날짜데이터로 변환한 다음 계산)
SELECT EMP_NAME, DEPT_CODE,
    SUBSTR(EMP_NO,1,2) || '년' || SUBSTR(EMP_NO,1,2) || '월' || SUBSTR(EMP_NO,1,2) || '일' AS 생일,
    ABS(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'YY')))
    FROM EMPLOYEE;
--22. EMPLOYEE테이블에서 부서코드가 D5, D6, D9인 사원만 조회하되 D5면 총무부, D6면 기획부, D9면 영업부로 처리
-- (단, 부서코드 오름차순으로 정렬)
SELECT EMP_ID, EMP_NAME, DEPT_CODE,
        DECODE(DEPT_CODE, 'D5', '총무부', 'D6', '기획부', 'D9', '영업부')
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D9')
ORDER BY DEPT_CODE;

---23. EMPLOYEE테이블에서 사번이 201번인 사원명, 주민번호 앞자리, 주민번호 뒷자리, 
-- 주민번호 앞자리와 뒷자리의 합 조회
SELECT EMP_NAME,
        SUBSTR(EMP_NO,1,6) AS 앞자리,
        SUBSTR(EMP_NO, 8) AS 뒷자리,
        SUBSTR(EMP_NO,1,6) + SUBSTR(EMP_NO, 8)
FROM EMPLOYEE
WHERE EMP_ID = 201;
--24. EMPLOYEE테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉 합 조회
SELECT SUM((SALARY + (SALARY * NVL(BONUS,0))) *12)
FROM EMPLOYEE
WHERE DEPT_CODE= 'D5';
--25. EMPLOYEE테이블에서 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수 조회
-- 전체 직원 수, 2001년, 2002년, 2003년, 2004년
SELECT COUNT(*) AS 전체직원수,
        COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), 2001, 1, NULL)) AS "2001년",
        COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), 2002, 1, NULL)) AS "2002년",
        COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), 2003, 1, NULL)) AS "2003년",
        COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), 2004, 1, NULL)) AS "2004년"
FROM EMPLOYEE;