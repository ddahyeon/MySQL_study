use testdb; 

select empno, lower(ename), upper(ename), upper('hello') from emp;

select empno, concat(ename,' ',sal) from emp;

select empno, concat_ws(",",ename,sal,hiredate) from emp;

select ename, length(ename) from emp;

select ename, sal, replace(sal,'0','o') from emp;


select ename, instr(ename,'NES')from emp;

select ename, TRIM(LEADING 'X' FROM 'xxxxhelloxxxx') from emp;

select ename, repeat(ename,2) from emp;

select NOW(), SLEEP(2), NOW();

select empno, ename, job, sal, case WHEN sal>3000 THEN '이사급'
									WHEN sal>2500 THEN '과장급'
									end as 직급
from emp;

-- 조인 실습 
-- cross join
select * from emp cross join dept;

-- natural join
select *
from emp natural join dept;

select empno, ename, sal, dname
from emp natural join dept;

select empno, ename, sal, dname, deptno
from emp natural join dept;

select e.empno, e.ename, e.sal, d.dname, d.deptno from emp e natural join dept d;

select * from emp join dept on emp.deptno = dept.deptno;

select ename, sal, dname, loc from emp join dept on emp.deptno = dept.deptno;

-- outer 조인
use testdb;

select * from emp RIGHT OUTER JOIN dept using (deptno);

-- 실습문제 풀이 (p.100)
select e.empno, e.ename, d.deptno, d.dname from emp e natural join dept d order by ename ASC;

select e.empno, e.ename, e.sal, d.dname from emp e natural join dept d where e.sal > 2000 order by e.sal DESC;

-- 서브쿼리   
-- ex1.  emp테이블에서 사원번호가 7521 의 업무와 동일하고 급여가 7934보다 많은 사원의 정보(사원번호,이름,job,hiredate,sal)출력?
select empno, ename, job, hiredate, sal from emp where job = (select job from emp where empno = 7521) and sal > (select sal from emp where empno = '7934'); 

-- ex2.  emp테이블에서 급여의 평균보다 적은 급여를 받는 사원 정보 출력(사원번호,이름,job,hiredate,sal)?
select empno, ename, job, hiredate, sal from emp where sal < (select avg(sal) from emp); 

-- ex3.  emp테이블에서 20번 부서의 최소급여보다 많은 모든 부서를 출력? (부서명, 최소급여) 
select  deptno, min(sal) from emp  group by deptno having min(sal) > (select min(sal) from emp where deptno=20);

-- 단일행, 복수행 연산자 실습 
-- ex4. emp 테이블에서 업무별로 최소급여를 받는 사원정보 출력(사원번호, 이름, job, hiredate, sal)
-- 업무별 최소급여 (800, 1250,2450,3000,5000)
select empno, ename, job, hiredate, sal from emp where sal IN (select min(sal) from emp group by job);

-- ex5. emp 테이블에서 job이 MANAGER인 사원의 최소급여보다 적은 급여를 받는 사원 정보(사원번호, 이름, job, hiredate, sal)   
select empno, ename, job, hiredate, sal from emp WHERE sal < (SELECT MIN(sal) fROM emp WHERE job = 'MANAGER');

-- ex6. emp 테이블에서 job이 MANAGER인 사원의 최소급여보다 많은 급여를 받는 사원 정보(사원번호, 이름, job, hiredate, sal)  
select empno, ename, job, hiredate, sal from emp WHERE sal > (SELECT MIN(sal) fROM emp WHERE job = 'MANAGER');

-- ex7. emp 테이블에서 job이 MANAGER인 사원의 최대급여보다 적은 급여를 받는 사원 정보(사원번호, 이름, job, hiredate, sal)  
select empno, ename, job, hiredate, sal from emp WHERE sal < (SELECT max(sal) fROM emp WHERE job = 'MANAGER');

-- ex8. emp 테이블에서 job이 MANAGER인 사원의 최대급여보다 많은 급여를 받는 사원 정보(사원번호, 이름, job, hiredate, sal)  
select empno, ename, job, hiredate, sal from emp WHERE sal > (SELECT max(sal) fROM emp WHERE job = 'MANAGER');

-- DML
-- insert into dept(deptno, dname) values (42,'인사과');

-- insert into dept(deptno, dname, loc) values (43,'인사과',null);

-- insert into dept values (44,'인사과',null);

commit;

select * from my_emp;
create table my_emp as select empno, ename, sal from emp where 1=2;
insert into my_emp (empno, ename, sal) select empno, ename, sal from emp;

insert into my_emp(empno,ename,sal) values (10,'홍길동1',500), (20,'홍길동2',500), (30,'홍길동3',500);

commit;








