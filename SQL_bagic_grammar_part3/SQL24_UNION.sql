# union 연산 
-- 두 개 이상의 select 문들의 결과 집합을 단일 결과 집합으로 결합하며 결합시 중복된 데이터는 제거된다.
--> select 문과 select 문끼리연결을 해주는 방식이다. (집합과 집합의 연결)

## union 연산의 기본 문법 
select 
	  column_1_1
	, coulum_1_2
from 
	table_name_1
union 
select 
	  column_2_1
	, coulum_2_2
from 
	table_name_2;
--> 두개의 select 문에서 중복되는 데이터 값이 있다면 중복은 제거 된다.
--> order by로 정렬하고자 할 경우 맨 마지막 select 문에 order by 절을 사용한다. 
  
## 실습 준비 1

# 1) 테이블 생성 
create table sales2007_1
(
   name varchar(50) 
 , amount numeric(15,2)
);

# 2) 데이터 삽입 
insert into sales2007_1
values
  ('Mike', 150000.25)
, ('Jon', 132000.75)
, ('Mary', 100000)
;

commit;

# 3) 데이터 확인 
select 
	*
from 
	sales2007_1;

## 실습 준비 2

# 1) 테이블 생성 
create table sales2007_2
(
   name varchar(50) 
 , amount numeric(15,2)
);

# 2) 데이터 삽입 
insert into sales2007_2
values
  ('Mike', 120000.25)
, ('Jon', 142000.75)
, ('Mary', 100000)
;

commit;

# 3) 데이터 확인 
select 
	*
from 
	sales2007_2;

-----------------------------------------------------------------------------------

## 실습 예제 1 - union 함수 기본 

# 실습 1 - 모든 데이터 합치기 

select 
	*
from 
	sales2007_1
union 
select 
	*
from 
	sales2007_2
;
--> 'Mary', '100000' 중복으로 제거됨

# 실습 2 - name  데이터 합치기 

select 
	name 
from 
	sales2007_1
union 
select 
	name
from 
	sales2007_2
;
--> 'Mike, Jon, Mary' 중복 제거됨 

# 실습 3 - amount 데이터 합치기 

select 
	amount
from 
	sales2007_1
union 
select 
	amount
from 
	sales2007_2
;
--> '100000' 중복 제거됨
--> 문자열 중복된 값을 제거할 때 대소문자 구분을 한다. 

## 실습 예제 2 - union 함수 order by 활용 

select 
	*
from 
	sales2007_1
union 
select 
	*
from 
	sales2007_2
order by 
	amount desc;
	
--> union 함수 사용시 order by를 사용하고자 할 때 꼭 맨 마지막 select 문에 기재해야 한다. 