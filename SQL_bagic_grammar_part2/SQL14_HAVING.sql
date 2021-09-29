# having 절 
-- group by 절과 함께 having 절을 사용하여 group by의 결과를 특정 조건으로 필터링 하는 기능을 한다. 

# having 절 기본 문법 

select 
	column_1             -> group by 컬럼 기재 
	, 집계함수 (column_2)  -> 집계함수 사용 
from 
	table_name 
group by 
	column_1             -> group by 절 기재, N개의 컬럼을 group by 하는 경우 ','(콤마)로 구분 
having 	
	조건식;                -> group by 절은 from 또는 where 절 바로 뒤에 나타나야 함. 
-- having 절은 group by 절에 의해 생성된 그룹행의 조건을 설정한다.
-- 반면에 where 절은 group by 절에 적용되기 전에 개별 행의 조건을 설정한다. 

-------------------------------------------------------------------------------------
	
## 실전예제 1 - group by 결과 출력 (앞에 group by 절 예제와 동일 / payment 테이블)

select 
	customer_id           -> group by 컬럼인 customer_id를 출력한다.
from 
	payment               -> payment 테이블을 조회한다.
group by 
	customer_id;          -> customer_id 기준으로 group by 한다.

## 실전예제 2 - group by + having 사용 

select 
	customer_id                   -> group by 컬럼인 customer_id를 출력한다.
	, sum(amount) as amount_sum   -> customer_id 기준 amount의 합계를 출력한다.
from 
	payment                       -> payment 테이블을 조회한다.
group by 
	customer_id                   -> customer_id 기준으로 group by 한다.
having 
	sum(amount) > 200 ;           -> group by의 결과 값 중에서 sum(amount)가 200을 초과하는 행을 출력한다. 
-- having 절은 group by를 한 결과 중에서 뽑을 정보만 뽑는다.  
	
## 실전예제 3 - group by + having 사용  (customer_id, email, amount 합계 정보 추출)

select 
	a.customer_id
	, b.email
	, sum(a.amount) as amount_sum   
from 
	payment a, customer b  
where 
	a.customer_id = b.customer_id 
group by 
	a.customer_id, b.email                    
having 
	sum(amount) > 200 ;          
	
## 실전예제 4 - group by 결과 출력 (customer 테이블)
select 
	store_id                        -> group by 컬럼인 store_id를 출력한다.
	, count(customer_id) as count   -> store_id 기준 customer_id의 카운트를 출력한다.
from 
	customer                        -> customer 테이블을 조회한다.
group by 
	store_id;                       -> store_id 기준으로 group by 한다.

## 실전예제 5 - group by + having 절 결과 출력 
select 
	store_id                        -> group by 컬럼인 store_id를 출력한다.
	, count(customer_id) as count   -> store_id 기준 customer_id의 카운트를 출력한다.
from 
	customer                        -> customer 테이블을 조회한다.
group by 
	store_id                        -> store_id 기준으로 group by 한다.
having 
	count(customer_id) > 300;       -> group by 결과에서 count(customer_id)의 결과가 300을 초과하는 집합을 리턴한다. 
	
