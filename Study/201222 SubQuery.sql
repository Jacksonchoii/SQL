/*    SubQuery    */

--11000 보다 급여를 많이 받는 사람의 이름과 급여는?
select  first_name,
        salary
from employees
where salary > 11000;

--'Den' 보다 급여를 많은 사람의 이름과 급여는?
--1.'Den'의 급여
select  employee_id,
        first_name,
        salary
from employees
where first_name = 'Den'; --> 11000

--2.'Den'보다 급여 높은 사람
select  first_name,
        salary
from employees
where salary > 11000;

--1개의 질문으로 해결
select  first_name,
        salary
from employees
where salary > (select  salary
                from employees
                where first_name = 'Den');

--[예제]급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
--1.가장 작은 급여 액수  2100
--2.2100을 받는 직원의 이름, 급여, 사원번호는?
--3.질문 조합

--1.가장 작은 급여 액수 2100
select  min(salary)
from employees;

--2.2100을 받는 직원의 이름, 급여, 사원번호는?
select  first_name,
        salary,
        employee_id
from employees
where salary = 2100;

--3.질문 조합
select  first_name,
        salary,
        employee_id
from employees
where salary = (select  min(salary)
                from employees);
                
--[예제]평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
--1.평균 급여 6461
--2.평균보다 작은 사람 리스트
--3.조합

--1.평균급여
select  avg(salary)
from employees;

--2.평균보다 작은 사람 리스트
select  first_name,
        salary
from employees
where salary < 6461.83;

--3.조합               
select  first_name,
        salary
from employees
where salary < (select  avg(salary)
                from employees);


--다중행 SubQuery
--[예제]부서번호가 110인 직원의 급여와 같은 모든 직원의 
--사번, 이름, 급여를 출력하세요
--1. 부서번호 110인 직원이 이름, 급여
select  first_name,
        salary,
        department_id
from employees
where department_id = 110;

--2.전체직원 중 급여가 12008, 8300인 사람
select  employee_id,
        first_name,
        salary
from employees
where salary = 12008 or salary = 8300;

--3.조합
select  employee_id,
        first_name,
        salary,
        department_id
from employees
where salary in (select salary
                 from employees
                 where department_id = 110);

--[예제]각 부서별로 최고급여를 받는 사원을 출력하세요
--1.부서별 최고 급여 얼마인지만 누구인지는? 못구함
select  --employee_id  --못구함 group by 때문
        max(salary),
        department_id
from employees
group by department_id;

--2.전체 사원 테이블에서 부서번호와 급여가 같은 사람을 찾는다
    --1번(부서별 최고급여) 기준으로
select  first_name,
        employee_id,
        salary,
        department_id
from employees
where (department_id, salary) in (select  department_id,
                                          max(salary)
                                from employees
                                group by department_id);


--[예제]부서번호가 110인 직원의 급여 보다 큰 모든 직원의 
--사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)

--1.부서번호 110인 직원의 급여 리스트
select  employee_id,
        first_name,
        salary
from employees
where department_id = 110;  --12008, 8300

--2.부서번호가 110인 직원의 급여보다 큰 모든 직원
select  employee_id,
        first_name,
        salary
from employees
where salary >any (select salary               --any (or)
                  from employees
                  where department_id = 110); --12008, 8300
                  
select  employee_id,
        first_name,
        salary
from employees
where salary >all (select salary               --any (all)
                  from employees
                  where department_id = 110); --12008, 8300


--Sub Query 로 테이블 만들기 --> join으로 사용
--[예제]테이블에서 조인
--각 부서별로 최고급여를 받는 사원을 출력하세요 
--1. 각 부서별로 최고 급여 테이블
select  max(salary),
        department_id
from employees
group by department_id;

--2. 직원테이블 (1)테이블을 join 한다.
select  e.employee_id,
        e.first_name,
        e.salary eSalary,
        e.department_id ed_id,
        s.department_id sd_id,
        s.salary sSalary
from employees e, (select  department_id,
                           max(salary) salary
                     from employees
                     group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary;
                     
                     
                     





