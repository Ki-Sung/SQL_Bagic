# in 연산자 
# 특정 집합 (컬럼 혹은 리스트)에서 특정 집합 혹은 리스트가 존재하는지 판단하는 연산자이다. 

# in 연산자 문법 1 
# column_name이 가지고 있는 집합에서 value1, value2 등의 값이 존재하는지 확인

select
	*
from
	table_name
where
	column_name in (value1, value2, ...)
;

# in 연산자 문법 2
# column_name이 가지고 있는 집합에서 table_name2 테이블의 column_name2의 집합이 존재하는지 확인 

select
	*
from
	table_name
where column_name in 
(select column_name2 from table_name2)
;

-----------------------------------------------

# 실전예제 1 - rental 데이터, in의 사용 
# customer_id가 1 혹은 2인 행을 출력한다. (or와 특성이 같음)
# 그 결과를 return_date 컬럼 내림차순으로 출력한다. 

select
	customer_id
	, rental_id 
	, return_date
from
	rental
where
	customer_id in (1, 2)
order by
	return_date desc ;


# 실전예제 2 - rental 데이터, or의 사용 (비교) 
# customer_id가 1 혹은 2인 행을 출력한다.
# 그 결과를 return_date 컬럼 내림차순으로 출력한다. 

select
	customer_id
	, rental_id 
	, return_date
from
	rental
where
	customer_id = 1
	or customer_id  = 2
order by
	return_date desc ;

-- 그래서 or 보다 in을 사용하는 이유는
-- 1) 가독성, 알아보기가 쉽다.
-- 2) (DBMS 최적화기, SQL최적) 옵티마이저의 특성상 in조건 성능 유리할떄가 많다.

# 실전예제 3 - rental 데이터, notin의 사용 
# customer_id가 1도 아니고 2도 아닌 행를 출력한다. - 1과 2를 제외한 나머지 값 전부 출력 
# 그 결과를 return_date 컬럼 내림차순으로 출력한다. 

select
	customer_id
	, rental_id 
	, return_date
from
	rental
where
	customer_id not in (1, 2) 
order by
	return_date desc ;

# 실전예제 4 - rental 데이터, and의 사용 (not in 연산자와 비교)
# customer_id가 1도 아니고 2도 아닌 행를 출력한다. - 1과 2를 제외한 나머지 값 전부 출력 
# 그 결과를 return_date 컬럼 내림차순으로 출력한다. 

select
	customer_id
	, rental_id 
	, return_date
from
	rental
where
	customer_id <> 1
and customer_id <> 2 
order by
	return_date desc ;
	

# 실전예제 5 - 서브 쿼리 
# return_date가 2005년 5월 27일인 customer_id를 출력한다.

select
	customer_id
from
	rental
where
	cast (return_date as date) = '2005-05-27';  -- return_date를 date 타입으로 항변한 다음에 2005-05-27 일자 customer_id를 뽑아라 
	
# 실전예제 6 - 서브 쿼리 - 메인쿼리의 도움을 주기위함 
# 목적: 2005년 5월 27일에 렌탈한 고객들의 명단을 출력하고자 함. 
# return_date가 2005년 5월 27일인 customer_id의 first_date, last_date를 출력한다.
# return_date가 2005년 5월 27일인 customer_id를 출력한다.

select
	first_name
	,last_name
from
	customer
where
	customer_id in (
	select
		customer_id
	from
		rental
	where
		cast (return_date as date) = '2005-05-27');
