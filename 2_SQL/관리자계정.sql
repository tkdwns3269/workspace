/* SELECT * FROM ALL USERS */
-- 한줄 주석
/*

    계정 생성 방법
    CREATE USER 계정이름 IDENTIFIED BY 비밀번호
    
    GRANT 권한 TO 계정명;
    
*/

CREATE USER KH IDENTIFIED BY KH;

GRANT CONNECT, RESOURCE TO KH;

CREATE USER HW IDENTIFIED BY HW;

GRANT CONNECT, RESOURCE TO HW;

GRANT CREATE VIEW TO HW;

CREATE USER PJ IDENTIFIED BY PJ;

GRANT CONNECT, RESOURCE TO PJ;

CREATE USER MYBATIS IDENTIFIED BY MYBATIS;

GRANT CONNECT, RESOURCE TO MYBATIS;

CREATE USER spring IDENTIFIED BY spring;

GRANT CONNECT, RESOURCE TO spring;