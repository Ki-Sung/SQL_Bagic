# intersect 연산 
-- intersect 연산자는 두 개 이상의 select 문들의 결과 집합을 하나의 결과 집합으로 결합한다.

## 1. intersect 연산 문법 

select 
	  column_1_1   -> 두 개의 select 문 간 컬럼의 개수는 동일해야하고 해당 순서의 
	, column_1_2      열에는 서로 호환되는 데이터 유형 이어야 한다.
from 
	table_name_1
intersect
select 
	  column_2_1   -> 두 개의 select 문 간 컬럼의 개수는 동일해야하고 해당 순서의
	, column_2_2      열에는 서로 호환되는 데이터 유형 이어야 한다.
from 
	table_name_2;

--> order by로 정렬하고자 할 경우 맨 마지막 select 문에 order by 절을 사용한다. 

## 2. 실습 준비 1 - emplyeess 테이

# 2-1. 테이블 생성

create table employeess 
(
  employee_id serial primary key 
, employee_name varchar (255) not null 
);

# 2-2. 데이터 삽입 

insert into employeess (employee_name)
values 
  ('Joyce Edwards'),
  ('Diane Collins'),
  ('Alice Stewart'),
  ('Julie Sachez'),
  ('Heather Morris'),
  ('Teresa Rogers'),
  ('Doris Read'),
  ('Gloria Cook'),
  ('Evelyn Morgan'),
  ('Jean Bell');
  
 commit;
 
# 2-3. 데이터 확인 

select 
	*
from 
	employeess;
	
## 3. 실습 준비 2 - keys 테이블 

# 3-1. 테이블 생성 

create table keys 
(
  employee_id int primary key, 
  effective_date date not null,
  foreign key (employee_id)
  references employeess (employee_id)
);

# 3-2. 데이터 삽입 

insert into keys 
values
  (1, '2000-02-01'),
  (2, '2001-06-01'),
  (5, '2002-01-01'),
  (7, '2005-06-01');
 
commit;
  
# 3-3. 데이터 확인 

select 
	*
from 
	keys;
	
## 4. 실습 준비 3 - hipos

# 4-1.테이블 생성 

create table hipos 
(
  employee_id int primary key, 
  effective_date date not null,
  foreign key (employee_id)
  references employeess (employee_id)
);

# 4-2. 데이터 삽입 

insert into hipos 
values
  (9, '2000-01-01'),
  (2, '2002-06-01'),
  (5, '2006-06-01'),
  (10, '2005-06-01');
 
commit;

# 4-3. 데이터 확인 

select 
	*
from 
	hipos;

---------------------------------------------------------------------------------

## 5. 실습 예제 1 - intersect 연산 실습 

select 
	employee_id 
from 
	keys
intersect 
select 
	employee_id
from 
	hipos;
	
--> employee_id 기준으로 동일한 id를 하나의 결과 집합으로 출력함. 

# 위와 동일한 sql 문 1 -> 집합 연산자가 아닌 where 절을 이용한 일반 sql 문법

select 
	a.employee_id 
from 
	keys a, hipos b 
where 
	a.employee_id = b.employee_id;

# 위와 동일한 sql 문 2 -> 집합 연산자가 아닌 inner join을 이용한 일반 sql 문법

select 
	a.employee_id 
from 
	keys a
inner join 
	hipos b 
on (a.employee_id = b.employee_id);

--> 참고로 실전에서는 intersect 연산자를 잘 사용하지 않는다. 그 이유는 위에서 보듯이 inner join을 더 많이 사용하기 때문이다. 
	
## 6. 실습 예제 2 - intersect 연산 실습 order by 사용 

select 
	employee_id 
from 
	keys
intersect 
select 
	employee_id
from 
	hipos
order by 
	employee_id desc;
	
--> 앞에 union 연산자와 동일하게 마지막 select 문 뒤에 order by 절을 사용한다. 

# 위와 동일한 sql 문 1 -> 집합 연산자가 아닌 where 절을 이용한 일반 sql 문법

select 
	a.employee_id 
from 
	keys a, hipos b 
where 
	a.employee_id = b.employee_id
order by 
	a.employee_id desc;
	
# 위와 동일한 sql 문 2 -> 집합 연산자가 아닌 inner join을 이용한 일반 sql 문법

select 
	a.employee_id 
from 
	keys a
inner join 
	hipos b 
on (a.employee_id = b.employee_id)
order by 
	a.employee_id desc;