-- 문제1. 부서테이블과 사원테이블에서 사번, 사원명, 부서코드, 부서명 검색 ( 사원명 오름차순 정렬)
SELECT e.EMPNO, e.ENAME , d.DEPTNO, d.DNAME FROM dept d JOIN emp e ON d.DEPTNO = e.DEPTNO
ORDER BY e.ENAME;

-- 문제2. 부서테이블과 사원테이블에서 사번, 사원명, 급여, 부서명 검색 (단, 급여가 2000 이상인 사원에 대하여 급여 기준으로 내림차순) 
SELECT e.empno, e.ename, e.sal, d.deptno from dept d join emp e on d.deptno = e.deptno
where e.sal > 2000 
order by e.sal DESC;

-- 문제3. 부서 테이블과 사원 테이블에서 사번, 사원명, 업무, 급여, 부서명을 검색( 단, 업무가 manager, 급여가 2500이상인 사원에 대하여 사번 기준으로 오름차순)
select e.empno, e.ename, e.job, e.sal,d.deptno from dept d join emp e on d.deptno=e.deptno
where job = 'manager' and sal > 2500
order by e.empno ASC;

-- 문제4. 사원 테이블과 급여 등급 테이블에서 사번, 사원명, 급여, 등급을 검색(단, 등급은 급여가 하한값과 상한값 범위에 포함되고 등급이 4이며 급여 기준으로 내림차순) 
select e.empno, e.ename, e.sal, s.grade from emp e join salgrade s on e.sal between s.losal and s.hisal
where s.grade = 4 
order by e.sal DESC;   

-- 문제5. 부서 테이블, 사원테이블, 급여등급 테이블에서 사번, 사원명, 부서명, 급여, 등급을 검색 (단, 등급은 급여가 하한값과 상한값 범위에 포함되며 등급 기준으로 내림차순) 
select e.empno, e.ename, e.deptno , e.sal , s.grade from emp e join  dept d on e.deptno = d.deptno
join salgrade s on e.SAL between s.losal and hisal
order by s.grade DESC;

-- 문제6. 사원 테이블에서 사원명과 해당 사원의 관리자명을 검색하시오 
select e.ename as 사원 , m.ename 관리자 from emp e join emp m on e.mgr = m.empno;

-- 문제7. 사원 테이블에서 사원명, 해당 사원의 관리자명, 해당 사원의 관리자의 관리자명을 검색 
select e.ename as 사원, m1.ename as 관리자1, m2.ename as 관리자2 from emp e join emp m1 on e.mgr = m1.empno
join emp m2 on m1.mgr = m2.empno;

-- 문제8. 7번 결과에서 상위 관리자가 없는 모든 사원의 이름도 사원명에 출력되도록 수정하시오 
select e.ename as 사원, m1.ename as 관리자1, m2.ename as 관리자2 from emp e left outer join emp m1 on e.mgr=m1.empno
left outer join emp m2 on m1.mgr = m2.empno;

-- 문제9. 20번 부서의 이름과 그 부서에 근무하는 사원의 이름을 출력하시오 
select e.ename, d.dname, d.deptno from emp e join dept d using (deptno) 
where d.deptno = 20;

-- 문제10. 커미션을 받은 사원의 이름, 커미션, 부서이름을 출력하시오 
select e.ename, e.comm, d.dname from emp e join dept d on e.deptno=d.deptno
where e.comm is not null and e.comm !=0;

-- 문제11. 이름에 'A'가 들어가는 사원들의 이름과 부서명을 출력하시오 
select e.ename, d.dname from emp e join dept d on e.deptno=d.deptno
where e.ename like '%A%';

-- 문제12. DALLAS에 근무하는 사원 중 급여 1500 이상인 사원의 이름, 급여, 입사일, 위치를 출력하시오 
select e.ename, e.sal, e.hiredate, d.loc from emp e join dept d on e.deptno=d.deptno
where d.loc = 'DALLAS' and e.sal > 1500;

-- 문제13. 자신의 관리자보다 연봉을 많이 받는 사원의 이름, 관리자 이름과 연봉을 출력하시오 
select e.ename as 사원, m.ename as 관리자, e.sal from emp e join emp m on e.mgr = m.empno
where e.sal > m.sal;

-- 문제14. 각 부서별로 1982년 이전에 입사한 직원들의 부서명, 인원수를 출력하시오 
select d.dname as 부서명, count(e.empno) as 인원수 from dept d join emp e on d.deptno=e.deptno
where date_format(e.hiredate, '%Y') <= 1982
group by d.dname;

-- 문제15. 직원 중 현재시간(2024년) 기준으로 근무년수가 40년보다 적은 사람의 이름, 급여, 입사일, 부서명을 출력하시오 
select e.ename, e.sal, e.hiredate, d.dname, timestampdiff(month, e.hiredate, curdate())/12 
from emp e join dept d on e.deptno=d.deptno
where timestampdiff(month,e.hiredate,curdate())/12 < 40;

-- 서브쿼리 문제1. 사원테이블에서 BLAKE보다 급여가 많은 사원들의 사번, 이름, 급여를 검색
SELECT EMPNO, ENAME, SAL FROM EMP
WHERE SAL > ( SELECT SAL FROM EMP WHERE ENAME = 'BLAKE');

-- 서브쿼리 문제2. 사원 테이블에서 MILLER 보다 늦게 입사한 사원의 사번, 이름, 입사일을 검색 
SELECT EMPNO, ENAME, HIREDATE FROM EMP 
WHERE HIREDATE > ( SELECT HIREDATE FROM EMP WHERE ENAME = 'MILLER');

-- 서브쿼리 문제3. 사원 테이블에서 사원 전체 평균 급여보다 급여가 많은 사원들의 사번, 이름, 급여를 검색
SELECT EMPNO, ENAME, SAL FROM EMP
WHERE SAL > ( SELECT AVG(SAL) FROM EMP);

-- 서브쿼리 문제4. 사원 테이블에서 부서별 최대 급여를 받는 사원들의 사번, 이름, 부서코드, 급여 검색
 SELECT EMPNO, ENAME, DEPTNO ,SAL FROM EMP
 WHERE SAL IN ( SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);
 
 -- 서브쿼리 문제5. salgrade가 2등급인 사원들의 평균 급여보다 적게 받는 사원 정보를 검색 
 select * from emp
where sal <= ( select avg(sal) from emp e join salgrade s on e.sal between s.losal and s.hisal
               where s.grade = 2 );










