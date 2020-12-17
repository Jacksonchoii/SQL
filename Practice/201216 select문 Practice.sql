--201216 select�� practice
--����� �̸�(first_name)�� ��ȭ��ȣ �Ի��� ������ ����ϼ���
select  first_name,
        phone_number,
        hire_date,
        salary
from employees;

--����� �̸�(first_name)�� ��(last_name) �޿�, ��ȭ��ȣ, �̸���, �Ի����� ����ϼ���
select  first_name,
        last_name,
        salary,
        phone_number,
        email,
        hire_date
from employees;

--����� �̸�(fisrt_name)�� ��ȭ��ȣ �Ի��� �޿� �� ǥ�õǵ��� ����ϼ���
select  first_name as �̸�,
        phone_number "��ȭ��ȣ",
        hire_date "�Ի���",
        salary "�޿�"
from employees;

--����� �����ȣ �̸�(first_name) ��(last_name) �޿� ��ȭ��ȣ �̸��� �Ի��Ϸ� ǥ�õǵ��� ����ϼ���
select  employee_id,
        first_name "�̸�",
        last_name "��",
        salary "�޿�",
        phone_number "��ȭ��ȣ",
        email "�̸���",
        hire_date "�Ի���"        
from employees;

--��ü������ ������ ������ ���� ����ϼ���
--����(first_name last_name)
--���� �̸����̿� ? �� ���� ex) William-Gietz�޿�����(�޿�*12)����2�޿�
select  first_name||'-'||last_name "����",
        salary "�޿�",
        salary*12 "����",
        (salary*12+5000) "����2"
from employees;

--������ 15000 �̻��� ������� �̸��� ������ ����ϼ���
select  first_name,
        salary
from employees
where salary >= 15000;

--07/01/01 �� ���Ŀ� �Ի��� ������� �̸��� �Ի����� ����ϼ���
select  first_name,
        hire_date
from employees
where hire_date > '07/01/01';

--�̸��� Lex�� ������ ������ ����ϼ���
select salary
from employees
where first_name = 'Lex';

--������ 14000 �����̰ų� 17000 �̻��� ����� �̸��� ������ ����ϼ���
select  first_name,
        salary
from employees
where salary <= 14000
or salary >= 17000;

--�Ի����� 04/01/01 ���� 05/12/31 ������ ����� �̸��� �Ի����� ���Ͻÿ�
select  first_name,
        hire_date
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';

--������ 14000 �̻� 17000������ ������̸��� ������ ���Ͻÿ�
select  first_name,
        last_name,
        salary
from employees
where salary between 14000 and 17000;

--������ 14000 �̻� 17000������ ������̸��� ������ ���Ͻÿ�
select  first_name,
        last_name,
        salary
from employees
where salary >= 14000
and salary <= 17000;

--������ 2100, 3100, 4100, 5100 �� ����� �̸��� ������ ���Ͻÿ�
select  first_name,
        last_name,
        salary
from employees
where salary in (2100, 3100, 4100, 5100);

--�̸��� am �� ������ ����� �̸��� ������ ����ϼ���
select  first_name,
        last_name,
        salary
from employees
where first_name like '%am%';

--�̸��� �ι�° ���ڰ� a �� ����� �̸��� ������ ����ϼ���
select  first_name,
        last_name,
        salary
from employees
where first_name like '_a%';

--�̸��� �׹�° ���ڰ� a �� ����� �̸��� ����ϼ���
select  first_name,
        last_name
from employees
where first_name like '___a%';

--�̸��� 4������ ����� ������ �ι�° ���ڰ� a�� ����� �̸��� ����ϼ���
select  first_name,
        last_name
from employees
where first_name like '__a_';

--Ŀ�̼Ǻ����� �ִ� ����� �̸��� ���� Ŀ�̼Ǻ����� ����ϼ���
select  first_name,
        last_name,
        salary,
        commission_pct
from employees
where commission_pct is not null;

--���Ŵ����� ���� Ŀ�̼Ǻ����� ���� ������ �̸��� ����ϼ���
select  first_name,
        last_name
from employees
where manager_id is null and commission_pct is null;

--�μ���ȣ�� ������������ �����ϰ� �μ���ȣ, �޿�, �̸��� ����ϼ���
select  department_id,
        salary,
        first_name,
        last_name
from employees
order by department_id asc;

--�޿��� 10000 �̻��� ������ �̸� �޿��� �޿��� ū�������� ����ϼ���
select  first_name,
        last_name,
        salary
from employees
where salary >= 10000
order by salary desc;

--�μ���ȣ�� ������������ �����ϰ� �μ���ȣ�� ������ �޿��� ���� ������� �μ���ȣ �޿� �̸��� ����ϼ���  
select  department_id,
        salary,
        first_name,
        last_name
from employees
order by department_id asc, salary desc;