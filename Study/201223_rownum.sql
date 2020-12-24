/*  201223 rownum   */

--[예제]급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.

--rownum이 order by 보다 먼저 생겨서 번호가 섞인다
select  rownum,
        employee_id,
        first_name,
        salary
from employees
order by salary desc;


--정렬하고 rownum을 사용
select  rownum,
        o.employee_id,  --()안의 컬럼명을 꼭 맞춰주어야한다.
        o.first_name,
        o.salary
from (select  emp.employee_id,
              emp.first_name,
              emp.salary
      from employees emp
      order by salary desc) o     -- salary 로 정렬되어 있는 테이블 사용
where rownum >=1 -- where절 조건이 2부터 값이 없음 == 1이 아니면 안된다
and rownum < 6;


--rownum (일련번호)주고 바로 조건절(where)을 판단해서 생기는 문제
--e.g) rownum 1을 주고 where절에서 i >= 2면 조건에 맞지 않으므로 탈락 지워짐
--    다음 데이터의 rownum은 2였으나 앞의 1이 사라졌으므로 1부터 다시 rownum이 결정됨
-- -> 결국 rownum2가 rownum1의 빈자리를 채워 1이 되므로 i >= 2 조건 충족 X -> 값 안나옴

-- 일련번호주고 바로 조건을 판단해서
select  ro.rnum,
        ro.employee_id,
        ro.first_name,
        ro.salary
from (select  rownum rnum,
              o.employee_id,  --()안의 컬럼명을 꼭 맞춰주어야한다.
              o.first_name,
              o.salary
      from (select  emp.employee_id,
                    emp.first_name,
                    emp.salary
            from employees emp
            order by salary desc) o) ro
where rnum >=1
and rnum <=5;


--[예제]07년에 입사한 직원증 급여가 많은 직원중 
--     3에서 7등의 이름 급여 입사일은?

select  first_name,
        salary,
        hire_date
from employees
where hire_date >= '07/01/01' and hire_date <= '07/12/31'
order by salary desc;


select  rownum,
        o.first_name,
        o.salary,
        o.hire_date
from (select  emp.first_name,
              emp.salary,
              emp.hire_date
      from employees emp
      where hire_date >= '07/01/01' 
      and hire_date <= '07/12/31'
      order by salary desc) o
where rownum >= 2 
and rownum <=5;


select  ro.rnum,
        ro.first_name,
        ro.salary,
        ro.hire_date
from (select  rownum rnum,
              o.first_name,
              o.salary,
              o.hire_date
      from (select  emp.first_name,
                    emp.salary,
                    emp.hire_date
            from employees emp
            where hire_date >= '07/01/01' 
            and hire_date <= '07/12/31'
            order by salary desc) o) ro
where ro.rnum >=3
and ro.rnum <=7;






