/*   그룹함수 JOIN     */

--기본개념 equi join
select  *
from employees em, departments de  --테이블에 별명 붙이기. 컬럼 이름이 겹치기 때문 여기엔 as붙이지 않음
where em.department_id = de.department_id; 
--employees 테이블의 FK값과 departents 테이블의 PK값이 같은 것 만 출력됨 
--where 조건절을 넣지 않으면 employees 107 * departments 27 == 2889의 결과가 나타남
-- = where 조건절을 부여한다 -> Cartesian Product 카티젼 프로덕트


--[예제]모든 직원이름, 부서이름, 업무명 을 출력하세요
select  em.first_name,
        de.department_name,
        jo.job_title,
        em.job_id,      --같은 값이 맞는지 확인해보기
        jo.job_id,      -- -> 테이블간 값이 잘 매칭되었는지
        em.department_id,
        de.department_id
from employees em, departments de, jobs jo
where em.job_id = jo.job_id 
and em.department_id = de.department_id;

-- left join
select  em.department_id,
        em.first_name,
        de.department_name
from employees em left outer join departments de
on em.department_id = de.department_id;

-- right join
select  em.department_id,
        em.first_name,
        de.department_name
from employees em right outer join departments de
on em.department_id = de.department_id;

-- right join --> left join 
select  em.department_id,
        em.first_name,
        de.department_name
from departments de left outer join employees em -- 테이블의 위치만 바꿔줌
on de.department_id = em.department_id;

-- full outer join
select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id -- 확인용
from employees em full outer join departments de
on em.department_id = de.department_id;

select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id; -- 양쪽 (+) 사용 불가

--alias (테이블 별명)
select  em.department_id, --< 테이블에 별명을 지어주면 무조건 별명으로 써야한다
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id
order by em.department_id desc;


-- join 실행순서 체크
select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id
--group by, having 
order by em.department_id desc;


-- self join
select  emp.employee_id,
        emp.first_name,
        emp.manager_id,
        man.first_name manger
from employees emp, employees man
where emp.manager_id = man.employee_id;

-- 잘못된 사용예
select  *
from employees em, locations lo
where em.salary = lo.location_id; -- 급여가 3100이고 지역번호도 3100이라 의미가 없지만 숫자가 같아서 조인됨
