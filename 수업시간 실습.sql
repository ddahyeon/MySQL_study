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



