# join 문법 
# 2개 이상의 테이블에 있는 정보 중 사용자가 필요한 집합(정보)에 맞게 가상의 테이블처럼 만들어서 결과를 보여주는 것이다.
-- join의 종류 
-- 1. inner join - 특정 컬럼을 기준으로 정확히 매칭된 집합을 출력
-- 2. outer join - 특정 컬럼을 기준으로 매칭된 집합을 출력하지만 한쪽의 집합은 모두 출력하고 다른 한쪽의 집합은 매칭되는 컬럼의 값 만을 출력.
-- 3. self join - 동일한 테이블끼리의 특정 컬럼을 기준으로 매칭되는 집합을 출력
-- 4. full outer join - inner, left outer right outer join 집합을 모두 출력.
-- 5. cross join - Cartesian Product 라고도 하며 조인되는 두 테이블에서 곱집합을 반환.
-- 6. Natural join - 특정 테이블의 같은 이름을 가진 컬럼간의 조인집합을 출력.

# 실습 준비 - 테이블 생성 
create table basket_a
(
  id int primary key
, fruit varchar (100) not null
);

create table basket_b
(
  id int primary key
, fruit varchar (100) not null
);

insert
	into
	basket_a
(id, fruit)
values
(1,
'Apple'),
(2,
'Orange'),
(3,
'Banana'),
(4,
'Cucumber');

commit;

insert
	into
	basket_b
(id, fruit)
values
(1,
'Orange'),
(2,
'Apple'),
(3,
'Watermelon'),
(4,
'Pear');

commit;

# 참고 
-- 테이블을 생성하고 데이터를 삽입, 갱신, 삭제할 때 쓰는 것들은
-> insert, update, delete 이다.
-- 테이블에 데이터를 넣고 commit, rollback 을 하는데 이러한 것들을 트랜잭션 처리 라고 한다. 

--------------------------------------------------------------------------

# inner join 
# 특정 컬럼을 기준으로 정확히 매칭된 집합을 출력함. -> 교집합의 형성을 띔 

# 실습 1
select
	a.id id_a
	, a.fruit fruit_a
	, b.id id_b
	, b.fruit fruit_b
from
	basket_a a
inner join basket_b b
on
	a.fruit = b.fruit;
-- 고객 여러건의 결제를 할 수있다. 고객1: 결제M -> 1:M 관계 된다.

# 실습 2 - 2개의 테이블 조인 
-- 한 명의 고객은 여러 건의 결제내역을 가질수 있다.
-- 하나의 결제는 반드시 고객을 가져야 한다.

select
	a.customer_id
	, a.first_name
	, a.last_name
 	, a.email
	, b.amount
	, b.payment_date
from
	customer a
inner join payment b 
on
	a.customer_id = b.customer_id ;

# 실습 3 - 해당 조건만 inner join을 사용하여 출력 
select
	a.customer_id
	, a.first_name
	, a.last_name
 	, a.email
	, b.amount
	, b.payment_date
from
	customer a
inner join payment b 
on
	a.customer_id = b.customer_id 
where 
    a.customer_id = 2;
   
# 실습 3 - 3개의 테이블을 조인
-- 한 명의 직원은 여러 건의 결제내역을 처리한다.
-- 하나의 결제는 반드시 처리한 직원이 존재한다.
-- 한 명의 고객은 여러 건의 결제내역을 가질 수 있다.
-- 하나의 결제는 반드시 고객을 가져야 한다.  
select
	a.customer_id
	, a.first_name
	, a.last_name
 	, a.email
	, b.amount
	, b.payment_date
	, c.first_name as s_first_name
	, c.last_name as s_last_name
from
	customer a
inner join payment b 
on
	a.customer_id = b.customer_id 
inner join staff c 
on
	b.staff_id = c.staff_id;
	
-- 고객1 : 결제m : 직원1

--------------------------------------------------------------------------

# outer join 문법
특정 컬럼을 기준으로 매칭된 집합을 출력하지만 한쪽의 집합은 모두 출력하고 다른 한쪽의 집합은 매칭되는 컬럼의 값만 출력함.

# 실습 1 - left outer join
select
	a.id as id_a
	, a.fruit as fruit_a
 	, b.id as id_b
	, b.fruit as fruit_b
from
	basket_a a
left join basket_b b 
on
	a.fruit = b.fruit;

--> basket_a 테이블과 basket_b 테이블을 조인하는데 basket_a를 기준집합으로 조인한다. (a는 다나오되 b는 a와 매칭 되는 결과만 출력 단 매칭안된 데이터는 null로 처리)


# 실습 2 - left outer join - left only
select
	a.id as id_a
	, a.fruit as fruit_a
 	, b.id as id_b
	, b.fruit as fruit_b
from
	basket_a a
left join basket_b b 
on
	a.fruit = b.fruit
where
	b.id is null;

--> basket_a 테이블과 basket_b 테이블을 조인하는데 basket_a를 기준집합으로 조인하고 b 테이블이 null인 것만 출력한다. (a에만 존재하는 데이터만 출력 - a,b 둘다 있는 것 제외)

# 실습 3 - right outer join
select
	a.id as id_a
	, a.fruit as fruit_a
 	, b.id as id_b
	, b.fruit as fruit_b
from
	basket_a a
right join basket_b b 
on
	a.fruit = b.fruit;
	
--> basket_a 테이블과 basket_b 테이블을 조인하는데 basket_b를 기준집합으로 조인한다. (b는 다나오되 a는 b와 매칭 되는 결과만 출력 단 매칭안된 데이터는 null로 처리)

# 실습 4 - right outer join - right only
select
	a.id as id_a
	, a.fruit as fruit_a
 	, b.id as id_b
	, b.fruit as fruit_b
from
	basket_a a
right join basket_b b 
on
	a.fruit = b.fruit
where
	a.id is null;

--> basket_b 테이블과 basket_a 테이블을 조인하는데 basket_b를 기준집합으로 조인하고 a 테이블이 null인 것만 출력한다. (b에만 존재하는 데이터만 출력 - a,b 둘다 있는 것 제외)

-- outer join을 주로 사용하는 이유
-- 기준집합 -> 보고자하는 -> 기준집합 출력할 때 -> 고객은 다보고 싶다 -> 계약했던 안했던 우리 고객을 보고픔 -> 하지만 계약을 보여주면 좋음.
-- 한마디로 모든 고객을 보고프지만 계약한 고객과 안했던 고객을 모두 보고 비교하고자 할 때 사용하기 때문이다.

----------------------------------------------------------------------------

# self join 
같은 테이블끼리 특정 컬럼을 기준으로 매칭되는 컬럼을 출력하는 조인이다. 즉 같은 테이블의 데이터를 각각의 집합으로 분류한 후 조인한다.

# 실습 준비 - 새로운 테이블 생성: employee
create table employee
(
employee_id int primary key
, first_name varchar (255) not null
, last_name varchar (255) not null
, manager_id int
, foreign key (manager_id)
references employee (employee_id)
on
delete
	cascade
);

insert into employee(
employee_id
, first_name
, last_name
, manager_id
)
values 
(1, 'Windy', 'Hays', null),
(2, 'Ava', 'Christensen', 1),
(3, 'Hassan', 'Conner', 1),
(4, 'Anna', 'Reeves', 2),
(5, 'Sau', 'Norman', 2),
(6, 'Kelsie', 'Hays', 3),
(7, 'Tory', 'Goff', 3),
(8, 'Salley', 'Lester', 3);

commit;

# 확인 
select 
*
from 
employee;

-- 해당 데이터는 조직도이다 예를들면 제일 첫 번째가 ceo(그래서 매니저 아이디가 없), 2번이 매니저 이러한 구조를 가지고 있음. 

# 실습 1
select
	e.first_name || ' ' || e.last_name employee
	, m.first_name || ' ' || m.last_name manager
from
	employee e 
inner join
    employee m
on
	m.employee_id = e.manager_id
order by
	manager;
	
--> 각 직원의 담당 매니저가 누구인지 출력하는 결과

# 실습 2 
select
	e.first_name || ' ' || e.last_name employee
	, m.first_name || ' ' || m.last_name manager
from
	employee e 
left join
    employee m
on
	m.employee_id = e.manager_id
order by
	manager;
	
--> 각 직원의 상위 관리자를 출력하면서 모든 직원을 출력함 

# 실습 3 - 부정형 조건 - 상영 시간이 동일 영화들 추출
select
	f1.title
	, f2.title
	, f1.length
from
	film f1
inner join film f2 
on
	f1.film_id <> f2.film_id
	and f1.length = f2.length;
--> 필름 테이블과 필름 테이블을 셀프 조인하고 영화의 상영시간은 동일하면서 서로 다른 영화 집합을 출력 

--slef join의 프로세
동일한 테이블 -> 각각의 다른 집합으로 구성 -> 셀프조인 -> 그안에 자신이 원하는 정보 추출

