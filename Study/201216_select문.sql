--셀렉트 문
select * from employees;

select * from departments;

--원하는 컬럼만 조회하기
select employee_id, first_name, last_name from employees;

select employee_id, 
       first_name, 
       last_name 
from employees;

--[예제]사원의 이름(fisrt_name)과 전화번호 입사일 연봉을 출력하세요
select first_name, 
       phone_number,
       hire_date,
       salary
from employees;

--[예제]사원의 이름(first_name)과 성(last_name) 급여, 전화번호, 이메일, 입사일을 출력하세요
select first_name,  -- 컬럼 순서를 직접 지정할 수 있다
       last_name,   -- last_name을 맨 앞에 두고 싶으면 맨위로 올리면 됨
       salary,
       phone_number,
       email,
       hire_date
from employees;

--출력할 때 컬럼에 별명 사용하기
select employee_id as empNo, --정석 문법
       first_name fname, --as 생략가능 통일 할 것
       salary "E-Salary" -- 대소문자,공백,특수문자는 " " 쌍따옴표로 표기
from employees;

--[예제]사원의 이름(fisrt_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
select first_name "이름",
       phone_number "전화번호",
       hire_date "입사일",
       salary "급여"
from employees;

--[예제]사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시되도록 출력하세요
select employee_id "사원번호",
       first_name "이름",
       last_name "성",
       salary "급여",
       phone_number "전화번호",
       email "이메일",
       hire_date "입사일"
from employees;

/*연결 연산자(Concatenation)로 컬럼들 붙이기*/
select first_name || last_name
from employees;

select first_name || ' ' ||last_name as name --중간에 ''공백 추가하여 구분하기 + as 응용
from employees;

select first_name || ' ''hire date is'' ' || hire_date -- ' ' 내용삽입 ' ''따옴표'' ' 작은 따옴표 넣기
from employees;

/*산술 연산자 사용하기*/
select first_name, salary
from employees;

select first_name,
       salary,
       salary*12
from employees;

select first_name "이름",
       salary "급여", 
       salary*12 "연뵹",
       (salary+300)*12 "상여금 포함 연봉"
from employees;

/*문자열 산술 연산자 사용 불가*/
select job_id*12 --ORA-01722: invalid number 글자에 숫자를 곱할 수 없음 에러
from employees;

--[예제] 전체직원의 정보를 다음과 같이 출력하세요
select first_name || '-' ||last_name as "성명",
       salary "급여",
       salary*12 "연봉",
       salary*12+5000 "연봉2",
       phone_number "전화번호"
from employees;

/*select 문 where절 */
select first_name
from employees
where department_id = 10;

--[예제}연봉이 15000 이상인 사원들의 이름과 급여를 출력하세요
select first_name,
       salary
from employees
where salary >= 15000;

--[예제]07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select first_name,
       hire_date
from employees
where hire_date > '07/01/01'; -- 문자, 날짜는 ''로 감싸줌 

--[예제]이름이 Lex인 직원의 연봉을 출력하세요
select first_name,
       salary*12
from employees
where first_name = 'Lex'; -- 문자, 날짜는 ''로 감싸줌 ''는 대소문자 구별

/*조건이 2개이상 일때 한꺼번에 조회하기*/
select first_name,
       salary
from employees
where salary >= 14000
and salary <= 17000;

--[예제]연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요
select first_name,
       salary
from employees
where salary <=14000
or salary >=17000;

--{예제]입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select first_name,
       hire_date
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';

--연봉이 14000 이상 17000이하인 사원의 이름과 연봉을 구하시오
select first_name,
       salary
from employees
where salary between 14000 and 17000; --작은 값 앞, 큰 값 뒤에 (경계 값 포함시에만 사용)
--같은 표현 between and
select first_name, salary
from employees
where salary >= 14000 
and salary <= 17000;


/*IN 연산자로 여러 조건을 검사하기*/
select first_name,
       last_name,
       salary
from employees
where first_name in ('Neena', 'Lex', 'John');
--IN연산자 같은 표현
select first_name,
       last_name,
       salary
from employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John';

--[예제]연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오
select first_name,
       last_name,
       salary
from employees
where salary in (2100, 3100, 4100, 5100);

/*Like 연산자로 비슷한 것들 모두 찾기*/
select first_name,
       last_name,
       salary
from employees
where first_name like 'L%';

select first_name,
       last_name,
       salary
from employees
where first_name like '%a'; --앞에 글자수, 형태 상관없지만 끝이 a로 끝나는 값

select first_name,
       last_name,
       salary
from employees
where first_name like 'A%'; -- A로 시작하는 이름

select first_name,
       last_name,
       salary
from employees
where first_name like '%am%'; --앞 뒤 상관없이 am포함하는 값 am으로 끝나도 가능

select first_name,
       last_name,
       salary
from employees
where first_name like '_a'; --전체가 두 글자인데 a로 끝나는 값

--[예제]이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
select first_name,
       last_name,
       salary
from employees
where first_name like '%am%';

--[예제]이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
select first_name,
       last_name,
       salary
from employees
where first_name like '_a%';

--[예제]이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select first_name,
       last_name,
from employees
where first_name like '___a%';

--[예제]이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name,
       last_name
from employees
where first_name like '__a_';

/*NULL*/
--직원 테이블에서 급여가 13000에서 15000사이인 직원이름, 급여, 커미션, 급여*커미션 출력하세요
select  first_name,
        salary,
        commission_pct,
        salary*commission_pct
from employees
where salary between 13000 and 15000
and commission_pct is not null;

--[예제]커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select  first_name,
        salary,
        commission_pct
from employees
where commission_pct is not null;

--[예제]담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select first_name
from employees
where manager_id is null
and commission_pct is null;

select email, employee_id
from employees
where employee_id = 110;

/*order by절 */
/*
select 문
    select 절
    form 절
    where 절
    order by 절 --> 정렬
*/

select  first_name,
        salary
from employees
order by salary desc;

select  first_name,
        salary
from employees
where salary >= 9000
order by salary desc; -- 내림차순 desc / 오름차순 asc

select  first_name,
        salary
from employees
where salary >= 9000
order by salary desc;

--[예제]부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select  department_id,
        salary,
        first_name
from employees
order by department_id asc;

--[예제]급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select  first_name,
        salary
from employees
where salary >= 10000
order by salary desc;

--[예제]부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 
--      부서번호 급여 이름을 출력하세요  
select  department_id,
        salary,
        first_name
from employees
order by department_id asc, salary desc;




