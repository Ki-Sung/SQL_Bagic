# group by 절 
-- group by 절은 select 문에서 반환된 행을 그룹으로 나눈다. 각 그룹에 대한 합계, 평균, 카운트 등을 계산할 수 있다.
# 기본 문법 

select  
	column_1             -> group by 컬럼 기재
	, 집계함수 (column_2)  -> 집계함수 사용 
from 
	table_name 
group by 
	column_1;            -> group by 절 기재, N개의 컬럼을 group by 하는 경우 ','(콤마)로 구분 
	                        group by 절은 from 또는 where 절 바로 뒤에 나타나야 함 

--------------------------------------------------------------------------------------

## 실전예제 1 - 단순 group by 

select 
	customer_id          -> group by 컬럼인 customer_id를 출력한다.
from 
	payment              -> payment 테이블을 조회한다.
group by 
	customer_id;         -> customer_id 기준으로 group by 한다.
-- 중복 값이 제거된 customer_id를 구할 수 있다. 
	
## 실전예제 2 - 합계 구하기 + 정렬

-- 거래액이 가장 많으 고객순으로 출력 
select 	
	customer_id                   -> group by 컬럼인 customer_id를 출력한다.
	, sum(amount) as amount_sum   -> customer_id 기준 amount의 합계를 출력한다.
from
	payment                       -> payment 테이블을 조회한다.
group by 
	customer_id                   -> customer_id 기준으로 group by 한다.
order by 
	sum(amount) desc;             -> amount 합계 기준으로 내림차순 정렬한다. 

-- 위 예제(실전예제 2)와 동일한 SQL 문 
# 1)
select 
	customer_id
	, sum(amount) as amount_sum 
from 
	payment 
group by 
	customer_id 
order by 
	amount_sum desc; 

# 2)
select 
	customer_id
	, sum(amount) as amount_sum 
from 
	payment 
group by 
	customer_id 
order by 
	2 desc; 
	
## 실전예제 3 - 카운트 구하기 

select 
	staff_id                        -> group by 컬럼인 customer_id를 출력한다.
	, count(payment_id) as count    -> staff_id 기분 payment_id의 카운트를 출력한다.
from 
	payment                         -> payment 테이블을 조회한다.
group by 
	staff_id;                       -> staff_id 기준으로 group by 한다. 

# 실전예제 4 - payment 건수를 진행한 staff 정보 (staff 이름, ID, 건수) 추출 

select 
	a.staff_id
	, b.staff_id
	, b.first_name
	, b.last_name
	, count(a.payment_id) as count 
from 
	payment a, staff b
where 
	a.staff_id = b.staff_id 
group by 
	a.staff_id 
	, b.staff_id
	, b.first_name
	, b.last_name;
-- 직원 1번, 2번 -> 1번은 이름이 하나, 2번도 이름이 하나, staff_id + first_name + last_name => 2건 	