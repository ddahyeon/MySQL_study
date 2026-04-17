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

update my_emp
set ename='이순신', sal=100;

rollback;

-- DDL 
Create table IF NOT EXISTS board
( Num int PRIMARY KEY AUTO_INCREMENT,
title varchar(100) NOT NULL,
Author varchar(10) NOT NULL,
Content varchar(500) NOT NULL,
writeday datetime DEFAULT now(),
readcnt int DEFAULT 0  );

insert into board (title, author, content) values ('테스트','홍길동','내용무');
select * from board;

Create table IF NOT EXISTS board2
( Num int PRIMARY KEY AUTO_INCREMENT,
title varchar(100) NOT NULL,
Author varchar(10) NOT NULL,
Content varchar(500) NOT NULL,
writeday datetime DEFAULT now(),
gender char(4) CONSTRAINT CHECK(gender in ('M','F')),
readcnt int DEFAULT 0  );

insert into board2 (title, author, content,gender) values ('테스트','홍길동','내용무','M');
insert into board2 (title, author, content,gender) values ('테스트','홍길동','내용무','F');
select * from board2;

Create table IF NOT EXISTS board3
	( Num int AUTO_INCREMENT,
	title varchar(100) NOT NULL,
	Author varchar(10),
	Content varchar(500) NOT NULL,
	writeday datetime DEFAULT now(),
	gender char(4),
	readcnt int DEFAULT 0,
	CONSTRAINT PRIMARY KEY(num),
	CONSTRAINT CHECK (gender in ('M','F')),
	CONSTRAINT UNIQUE(author) );

insert into board3 (title, author, content,gender) values ('테스트','홍길동','내용무','F');
select * from board3;

create table IF NOT EXISTS board4
		   (
		       num int,
		       title varchar(100),
		       author varchar(10),
		       content varchar(500),
		       writeday datetime DEFAULT now(),
		       gender char(4),
		       readcnt int DEFAULT 0
		    );

alter table board4
add constraint check(gender in ('M','F'));

create table master1
   ( no int PRIMARY KEY,
     name varchar(10) NOT NULL);

   insert into master1 ( no, name ) values (1, 'aa1' );
   insert into master1 ( no, name ) values (2, 'aa2' );
   insert into master1 ( no, name ) values (3, 'aa3' );
   commit;
   
    create table slave1
   (  num int PRIMARY KEY,
      ename VARCHAR(10) NOT NULL,
      no int,
      
      CONSTRAINT FOREIGN KEY(no) REFERENCES master1(no) ON DELETE CASCADE
   );
   
   insert into slave1 (num, ename, no ) values ( 10, 'slave1', 1 );
   insert into slave1 (num, ename, no ) values ( 20, 'slave2', 2 );
   insert into slave1 (num, ename, no ) values ( 30, 'slave3', 3 );   
   insert into slave1 (num, ename, no ) values ( 40, 'slave4', 4 ); // 에러발생
   insert into slave1 (num, ename, no ) values ( 50, 'slave5', null );
   commit;
   
    create table slave2
   (  num int PRIMARY KEY,
      ename VARCHAR(10) NOT NULL,
      no int 
   
   );
   
   create table master2
   ( no int PRIMARY KEY,
     name varchar(10) NOT NULL);

   insert into master2 ( no, name ) values (1, 'aa1' );
   insert into master2 ( no, name ) values (2, 'aa2' );
   insert into master2 ( no, name ) values (3, 'aa3' );
   commit;


   create table slave2
   (  num int PRIMARY KEY,
      ename VARCHAR(10) NOT NULL,
      no int,

       CONSTRAINT FOREIGN KEY(no) REFERENCES master2(no) ON DELETE SET NULL
   
   );
   
   insert into slave2 (num, ename, no ) values ( 10, 'slave1', 1 );
   insert into slave2 (num, ename, no ) values ( 20, 'slave2', 2 );
   insert into slave2 (num, ename, no ) values ( 30, 'slave3', 3 );   
   insert into slave2 (num, ename, no ) values ( 50, 'slave5', null );
   commit;
   
   select * from master2;
   select * from slave2;
   
   delete from master2 where no =1;
   
   -- 테이블 삭제(DDL 떄문에 rollback 불가) 
drop table if exists board;
drop table if exists board2, board3;
   
   create table if not exists my_dept
       ( no int primary key,
         name varchar(10)  
       );
       
          alter table my_dept
       add column address varchar(20);
       
 alter table my_dept
       modify address varchar(50);
       
alter table my_dept
modify address varchar(10);

  alter table my_dept
RENAME COLUMN address TO addr;  

alter table my_dept
drop name; 




