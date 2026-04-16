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

-- 문제5. 입학정원이 20명 이상 30명 이하인 학과들과 학과 이름과 계열 출력 
select department_name, category from tb_department where capacity >= 20 and capacity <= 30;

-- 문제6. 총장을 제외하고 모든 교수들은 소속 학과를 가지고 있다, 총장의 이름을 알아낼 수 있는 문장은?
select professor_name from tb_professor where department_no is null;

-- 문제7. 학과가 지정되어있지 않은 학생을 확인하는 문장 
select student_name from tb_student where department_no is null;

-- 문제8. 선수과목 여부를 확인해야할 떄, 선수과목이 존재하는 과목들은 어떤 과목인지 과목번호를 조회 
select PREATTENDING_CLASS_NO from tb_class where PREATTENDING_CLASS_NO is not null;

-- 문제9. 어떤 계열이 있는지 조회  
select category from tb_department group by category;

-- 문제10. 02학번 전주 거주자의 모임을 만들려고 할 때, 휴학한 사람 제외 재학중인 학생들 조회(학번, 이름, 주민번호) 
select student_no, student_name, student_ssn from tb_student where EXTRACT( YEAR from ENTRANCE_DATE ) = 2002
															   and student_address like '%전주%'
															   and absence_yn = 'N';


