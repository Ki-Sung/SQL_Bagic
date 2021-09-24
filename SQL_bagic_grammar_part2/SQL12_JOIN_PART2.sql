# full outer join 
-- inner, left outer, right outer join 집합을 모두 출력하는 조인 방식이다. 즉 두 테이블간 출력이 가능한 모든 데이터를 포함한 집합을 출력한다.
## 1. full outer join 실습 1 - 기본 구조 
select 
	a.id id_a            -> 지정한 컬럼을 조회 
  , a.fruit fruit_a 
  , b.id id_b
  , b.fruit fruit_b
from
	basket_a a           -> basket_a 테이블
full outer join          -> basket_b 테이블
	basket_b b
on
	a.fruit = b.fruit;   -> fruit 컬럼 기준으로 full outer 조인한다. 
	
## 2. full outer join 실습 2 - only outer join

select 
	a.id id_a             -> 지정한 컬럼을 조회 
  , a.fruit fruit_a 
  , b.id id_b
  , b.fruit fruit_b
from
	basket_a a            -> basket_a 테이블 
full outer join          
	basket_b b            -> basket_b 테이블 
on
	a.fruit = b.fruit     -> fruit 컬럼 기준으로 full outer 조인 
where 	
	a.id is null         -> a.id가 null 값 (right outer)
	or b.id is null;     -> 혹은 b.id가 null 값을 추출한다. (left outer)

## 3. full outer join 추가 실습 준비 - 테이블 생성 

# 1) 테이블 준비 (depmartments, employees)
create table
if not exists departments   -> 기존 테이블이 존재하지 않으면 테이블 생성 
(
  department_id serial primary key
, department_name varchar (255) not null
);

create table
if not exists employees    -> 기존 테이블이 존재하지 않으면 테이블 생성 
(
  employee_id serial primary key
, employee_name varchar (255)
, department_id integer
);

# 2) 테이블에 데이터 입력 (depmartments, employees)
insert into departments
(department_name)
values
  ('Sales')
, ('Marketing')
, ('HR')
, ('IT')
, ('Production');

insert into employees(
  employee_name
, department_id
)
values
  ('Bette Nicholson', 1)
, ('Christian Gable', 1)
, ('Joe Swank', 2)
, ('Fred Costner', 3)
, ('Sandra Kilmer', 4)
, ('Julia Mcqueen', null);

# 3) 테이블 확인 
select 
	*
from 
	departments;
	
select 
	*
from 
	employees;
	
## 4. full outer join 실습 3 

select 
	e.employee_name
  , d.department_name
from
	employees e                         -> emplyees 테이블과 
full outer join       
	departments d                       -> departments 테이블을 
on
	d.department_id = e.department_id;  -> full outer 조인 한다.
	
## 5. full outer join 실습 4 - right only 

select 
	e.employee_name
  , d.department_name
from
	employees e                         -> emplyees 테이블과  
full outer join       
	departments d                       -> departments 테이블을   
on
	d.department_id = e.department_id   -> full outer 조인 한다.
where 
	e.employee_name is null;            -> 소속한 직원이 없는 부서만 출력 
	
## 6. full outer join 실습 5 - left only 

select 
	e.employee_name
  , d.department_name
from
	employees e                         -> emplyees 테이블과   
full outer join       
	departments d                       -> departments 테이블을  
on
	d.department_id = e.department_id   -> full outer 조인 한다.
where 
	d.department_name is null;          -> 소속한 부서가 없는 직원만 출력   
	
-------------------------------------------------------------------

# cross join
-- 두개의 테이블의 catesian product 연산의 결과를 출력한다. 데이터 복제에 많이 쓰이는 기법이다. 

# 실습 준비

create table cross_t1
(
 label char(1) primary key
);

create table cross_t2
(
 score int primary key
);

insert into cross_t1 (label)
values 
('A'),
('B');

insert into cross_t2 (score)
values 
(1),
(2),
(3);

# 예제 확인 
select 
	*
from 
	cross_t1;

select 
	*
from 
	cross_t2;

## cross join 실습 

select 
	*
from 
	cross_t1   -> cross_t1과 
cross join 
	cross_t2;  -> cross_t2를 cross 조인한다. 

-- 혹은 아래와 같이 사용해도 된다.
select 
	*
from 	
	cross_t1, cross_t2
order by label;

-- on 절이 없기 때문에 출력 가능한 모든 것들을 뽑아낸다.
-- 위 2개의 SQL문 결과 집합이 동일하면 같은 SQL문 이다. 
-- SQL문 목적이 집합을 출력하는 것이다. 정보가 같다면 SQL문 자체는 다르더라도 동일한 SQL문이라 할 수 있다.

-------------------------------------------------------------------

# natural join 
-- 두개의 테이블에서 같은 이름을 가진 컬럼 간의 inner join 집합 결과를 출력한다. SQL문 자체가 간소해지는 방법이다. 

# 실습 준비 

create table categories
(
  category_id serial primary key 
, category_name varchar (255) not null 
);

create table products
(
  product_id serial primary key
, product_name varchar (255) not null
, category_id int not null
, foreign key (category_id)
  references categories (category_id)
);

insert into categories
(category_name)
values
  ('Smart Phone')
, ('Labtop')
, ('Tablet')
;

insert into products
(product_name, category_id)
values 
  ('iPhone', 1)
, ('Samsung Galaxy', 1)
, ('HP Elite', 2)
, ('Lenovo Thinkpad', 2)
, ('iPad', 3)
, ('Kindle Fire', 3)
;

# 테이블 확인 
select
	*
from 
categories;

select 
	*
from 
	products;
	
## natural join 실습 1 - natural join 사용 

select 
	*
from 
	products a     -> products 테이블과 
natural join 
	categories b;  -> categories 테이블간 natural 조인 한다. 
	                  이런 경우 동일하게 지나고 있는 category_id 컬럼을 기준으로 inner 조인 한다.
	                  
## natural join 실습 2 - natural join과 비교를 위해 inner join 사용 

select 
	a.category_id
  , a.product_id
  , a.product_name
  , b.category_name                   -> 테이블 정
from 
	products a                        -> products 테이블과 
inner join 
	categories b                      -> categories 테이블간 조인 한다.
on (a.category_id = b.category_Id);   -> category_id 컬럼을 기준으로 inner 조인한다.

-> 결론적으로 둘다 결과는 동일하다. 다만 nature join을 사용하게 되면 sql 문을 좀 더 간결하게 사용 가능하다. 

## natural join 실습 3 - 실전 예제 

select 
	* 	
from 
	city a 
natural join 
	country b;

-- 두 테이블 간에는 동일한 이름으로 존재하는 컬럼이 country_id와 last_update 이다.
-- 이련 경우 natural join 시에는 last_update 컬럼까지 inner 조인에 성공해야만 결과값이 나온다. 

select 
	*
from 
	city a 
inner join 
	country b
on 
(a.country_id = b.country_id);

-- inner 조인으로 on절에 조인 컬럼을 명시하였고, 의도한 대로 데이터가 출력 되었다.
-- 이러한 이유로 natural 조인은 실무에 잘 사용되지 않는다. 