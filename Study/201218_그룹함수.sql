/*   그룹함수   */
-----------------------------------

--평균 구하기
select  avg(salary),
        first_name --오류 // 평균은 하나의 값(row)만 표현해야하는데 이름은 107개이기 때문
from employees;

--그룹함수 avg()
select  avg(salary)
from employees;

--그룹함수 count()
select  count(*) -- * 컬럼 상관없다 null포함
from employees;

select  count(commission_pct) -- 이 컬럼의 카운트 0은 계산됨, null은 제외
from employees;

select  count(*)    --조건절 추가
from employees
where salary > 16000;

--그룹함수 sum()
select  sum(salary), count(salary)
from employees;

--그룹함수 --avg() null일 때 0으로 변환
select  count(*),
        sum(salary),
        avg(nvl(salary, 0))
from employees;

--그룹함수 - max(), min()
select  max(salary)
from employees;

select  min(salary)
from employees;

--정렬이 필요한 경우 많은 연산을 수행해야 한다.
select  max(salary),
        min(salary),
        count(*)
from employees;

/*   GROUP BY절   */
--group by절
select  department_id,
        avg(salary)          --오류 department_id 가 107개 이기 때문
from employees
order by department_id asc;

select  department_id,
        avg(salary)
from employees
group by department_id        --그룹을 지어줘서 가능
order by department_id asc;

--GROUP BY절 자주하는 오류
select  department_id,
        count(*),
        sum(salary)
from employees
group by department_id;

select  department_id,
        count(*),
        sum(salary),
        job_id      --기준이 없기 때문에 오류
from employees
group by department_id;

select  department_id,
        count(*),
        job_id,
        sum(salary)
from employees
group by department_id, job_id
order by department_id, job_id;

--[예제]연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요
select  department_id,
        count(*),
        sum(salary)
from employees
where sum(salary) >= 20000   -- 그룹함수는 where절에 쓰지 못한다.
group by department_id;

/*   HAVING절   */
select  department_id,
        count(*),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and department_id = 100;

--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY 순으로 진행!!

/*    case ~ end 문    */
----------------------------------------
select  employee_id,
        salary,
        job_id,
        case -- 부등호 자유롭게 사용가능
            when job_id = 'AC_ACCOUNT' then salary*0.1
            when job_id = 'SA_REP' then salary*0.2
            when job_id = 'ST_CLERK' then salary*0.3
            else salary*0
        end bonus
from employees;



select  employee_id,
        salary,
        job_id,
        decode( -- 부등호 사용불가 무조건 ==(같으면)일때만 사용 가능
                job_id, 'AC_ACCOUNT', salary*0.1, 
                        'SA_REP', salary*0.2, 
                        'ST_CLERK', salary*0.3, 
                        salary*0
              ) as bonus    
from employees;


--[예제]직원의 이름, 부서, 팀을 출력하세요팀은 코드로 결정하며 
--부서코드가 10~50 이면 ‘A-TEAM’60~100이면 ‘B-TEAM’  110~150이면 
--‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요.
select  first_name,
        last_name,
        department_id,
        job_id,
        case
            when department_id >= 1 and department_id <= 50 then 'A-TEAM'
            when department_id >= 60 and department_id <=100 then 'B-TEAM'
            when department_id >= 110 and department_id <=150 then 'C-TEAM'
            else '팀없음'
        end
from employees;


