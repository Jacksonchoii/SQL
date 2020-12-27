/*    Practice05 혼합SQL    */

/*
문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
*/
select  first_name,
        manager_id,
        commission_pct,
        salary
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;

/*
문제2. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 
급여(salary), 입사일(hire_date), 전화번호(phone_number), 
부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
*/
select  employee_id,
        first_name,
        salary,
        to_char(hire_date, 'YYYY-MM-DD DAY'),
        replace(phone_number,'.','-'),
        department_id
from employees
where (department_id, salary) in (select    department_id,
                                            max(salary)
                                  from employees
                                  group by department_id)
order by salary desc;

/*
문제3
매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 
매니저별최소급여, 매니저별최대급여 입니다.
*/
select  manager_id,
        round(avg(salary), 0) avg,
        min(salary),
        max(salary)
from employees
where hire_date >= '2005/01/01'
group by manager_id
having round(avg(salary), 0) >= 5000
order by avg desc;

--
select  me.mi,
        em.first_name,
        me.avg,
        me.mns,
        me.mxs
from employees em, (select  manager_id mi,
                            round(avg(salary), 0) avg,
                            min(salary) mns,
                            max(salary) mxs
                    from employees
                    where hire_date >= '2005/01/01'
                    group by manager_id
                    having round(avg(salary), 0) >= 5000
                    order by avg desc) me
where em.employee_id = me.mi;

/*
문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 
부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
*/
select  emp.employee_id,
        ema.first_name "사원이름",
        de.department_name,
        emp.first_name "매니저이름"
from employees ema left outer join departments de
on ema.department_id = de.department_id
inner join employees emp
on ema.manager_id = emp.employee_id;

/*
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/
--2005년 이후 입사한 직원
select  em.employee_id,
        em.first_name,
        de.department_name,
        em.hire_date
from employees em, departments de
where hire_date >= '05>01/01'
and em.department_id = de.department_id
order by em.hire_date asc;

--rownum
select  rownum,
        rem.employee_id,
        rem.first_name,
        rem.department_name,
        rem.hire_date
from (select  em.employee_id,
              em.first_name,
              de.department_name,
              em.hire_date
      from employees em, departments de
      where hire_date >= '05>01/01'
      and em.department_id = de.department_id
      order by em.hire_date asc) rem;

--2005년 이후 입사한 직원중 입사일 11~20번째 직원
select  ro.rnm,
        ro.employee_id,
        ro.first_name,
        ro.department_name,
        ro.hire_date
from (select  rownum rnm,
              rem.employee_id,
              rem.first_name,
              rem.department_name,
              rem.hire_date
      from (select  em.employee_id,
                    em.first_name,
                    de.department_name,
                    em.hire_date
            from employees em, departments de
            where hire_date >= '05>01/01'
            and em.department_id = de.department_id
            order by em.hire_date asc) rem) ro
where ro.rnm >= 11 and ro.rnm <= 20;


/*
문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 
연봉(salary)과 근무하는 부서 이름(department_name)은?
*/
--가장 늦은 입사일 -> 08/04/21
select  max(hire_date)
from employees;

--가장 늦게 입사한 직원
select  em.first_name ||' '|| em.last_name,
        em.salary,
        de.department_name,
        em.hire_date
from employees em, departments de
where em.department_id = de.department_id;
and hire_date = (select max(hire_date)
                 from employees);

/*
문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 
이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오
*/




/*
문제8.
평균 급여(salary)가 가장 높은 부서는? 
*/

/*
문제9.
평균 급여(salary)가 가장 높은 지역은? 
*/

/*
문제10.
평균 급여(salary)가 가장 높은 업무는? 
*/