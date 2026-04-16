-- 문제1. 영어영문학과 002 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로 표시하는 문장  
select student_no as '학번', student_name as '이름', ENTRANCE_DATE as '입학년도' from tb_student where DEPARTMENT_NO = 002 order by ENTRANCE_DATE ASC;

-- 문제2. 교수 중 이름이 세글자가 아닌 교수의 이름과 주민번호 출력  
select PROFESSOR_NAME, PROFESSOR_SSN from tb_professor where PROFESSOR_NAME not like '___';

-- 문제3. 남자 교수들의 이름과 나이 출력 (나이가 적은사람 -> 많은 사람 순으로 출력) 
select PROFESSOR_NAME as '교수이름', DATE_FORMAT(NOW(),'%Y') - cast( CONCAT('19' , SUBSTR(PROFESSOR_SSN, 1, 2))  as signed integer ) AS 나이
from tb_professor 
WHERE  SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
ORDER BY 나이 ASC;