/*  Practice04 SuqQuery  */

/*
문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
*/
--1.평균급여
select  avg(salary)
from employees;

--2.평균급여보다 적은 급여를 받는 직원
select  count(salary)
from employees
where salary < 6461.83; -- 평균급여

--3.join
select  count(salary)
from employees
where salary < (select avg(salary)
                from employees);

/*
문제2. 
평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
직원번호(employee_id), 이름(first_name), 급여(salary), 
평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요
*/
--1.평균급여
select  avg(salary)
from employees;

--2.최대급여
select  max(salary)
from employees;

--3.join
select  employee_id,
        first_name,
        salary,
        avg(salary),
        max(salary)
from employees
where salary >= (select avg(salary) --평균급여
                 from employees)
and   salary <= (select max(salary)
                 from employees)
group by employee_id, salary, first_name
order by salary asc;

/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 
있는 곳의 주소를 알아보려고 한다. 도시아이디(location_id), 거리명(street_address), 
우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id) 
를 출력하세요
*/
select  lo.location_id,
        lo.street_address,
        lo.postal_code,
        lo.city,
        lo.state_province,
        lo.country_id
from employees em, departments de, locations lo            --조인
where em.department_id = de.department_id
and de.location_id = lo.location_id
and em.first_name in (select    first_name
                      from      employees
                      where     first_name = 'Steven')    --서브쿼리
and em.last_name  in (select    last_name
                      from      employees
                      where     last_name = 'King');

/*
문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 
급여의 내림차순으로 출력하세요  -ANY연산자 사용
*/
select  *
from employees;

--1.job_id가 'ST_MAN'인 직원의 급여
select  salary,
        first_name,
        employee_id
from employees
where job_id = 'ST_MAN';

--2.join
select  employee_id,
        first_name,
        salary
from employees
where salary <any (select   salary
                   from employees
                   where job_id = 'ST_MAN')
order by salary desc;

/*
문제5. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 
이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
*/
--1. 각 부서별 최고 급여
select  department_id,
        max(salary)
from employees
group by department_id;

--조건절비교
select  em.employee_id,
        em.first_name,
        em.salary,
        em.department_id
from employees em
where (em.department_id, em.salary) in (select    department_id,
                                                  max(salary)
                                        from employees
                                        group by department_id)
order by salary desc;
 
--테이블조인
select  em.employee_id,
        em.first_name,
        em.salary,
        em.department_id
from employees em, (select department_id,
                           max(salary) salary
                    from employees
                    group by department_id) gd
where em.salary = gd.salary
and em.department_id = gd.department_id
order by salary desc;

/*
문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
*/
--각 업무별 연봉 총합
select  em.job_id,
        sum(em.salary)
from employees em
group by em.job_id;

--join
select  jo.job_title,
        em.salary
from employees em, jobs jo, (select emp.job_id,
                                    sum(emp.salary) salary
                             from employees emp
                             group by emp.job_id) ej
where em.job_id = jo.job_id
and em.salary = ej.salary;

--조건절
select  jo.job_title,
        em.salary
from employees em, jobs jo
where (jo.job_id, em.salary) in (select emp.job_id,
                                        sum(emp.salary)
                                 from employees emp
                                 group by emp.job_id);
                                

/*
문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 
직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
*/
--부서 평균 급여
select  department_id,
        avg(salary) avg
from employees
group by department_id;


select  em.employee_id,
        em.first_name,
        em.salary
from employees em, (select emp.department_id,
                           avg(salary) avg
                    from employees emp
                    group by department_id) ed
where em.department_id = ed.department_id
and em.salary > ed.avg;

/*
문제8.
직원 입사일이 11번째에서 15번째의 직원의 
사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
*/
--직원 입사일
select  employee_id,
        first_name,
        salary,
        hire_date
from employees
order by hire_date asc;

--2
select  rownum,
        em.employee_id,
        em.first_name,
        em.salary,
        em.hire_date
from (select  employee_id,
              first_name,
              salary,
              hire_date
      from employees
      order by hire_date asc) em;

--3
select  rem.ro,
        rem.employee_id,
        rem.first_name,
        rem.salary,
        rem.hire_date
from (select  rownum ro,
              em.employee_id,
              em.first_name,
              em.salary,
              em.hire_date
      from (select  employee_id,
                    first_name,
                    salary,
                    hire_date
            from employees
            order by hire_date asc) em) rem
where rem.ro >= 11 and rem.ro <=15;

