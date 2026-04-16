use workshop;

-- 문제1. 학과이름과 계열 표시 단, 학과명, 계열로 표시하시오
select DEPARTMENT_NAME as "학과명", CATEGORY as "계열" from tb_department;

-- 문제2. 학과와 학과 정원을 00학과의 정원은 00명입니다. 형태로 출력하시오
 select concat(department_name ,'의 정원은', CAPACITY, ' 명 입니다.') AS "학과별 정원"
from tb_department;

-- 문제3. 국어국문학과에 다니는 여학생 중 현재 휴학중인 여학생은? (국어국문 코드 -> 001) (_ 7개)
select department_no from tb_department where department_name='국어국문학과';
select student_name from tb_student where absence_yn = 'Y' and department_no = 001 and student_ssn like '_______2%';

-- 문제4. 도서관 장기 대출 연체자들의 이름 출력, 대상자 학번 A513079, A513090, A513091, A513119, A513110 
select student_name from tb_student where student_no in('A513079', 'A513090', 'A513091', 'A513119', 'A513110' );