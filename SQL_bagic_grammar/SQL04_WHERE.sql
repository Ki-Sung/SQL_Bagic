# 필터링 - where 절 
# 집합을 가져올 때 어떤 집합을 가져올 것인이지에 대한 ㅇ조건을 설정하는 절이다.

# wherer 절 문법 - 어떤 집합을가져올지에 대한 조건을준다.
select 
	column_1    --3
	, column_2
from
	table_name  --1
where 
	<조건>    --2
;

# 연산자
= -- 같음
> -- ~보다 큰 
< -- ~보다 작은
>= -- ~보다 크거나 같은
<= -- ~보다 작거나 같은 
<>, != -- ~가 아닌 
and -- 그리고
or -- 혹은

-----------------------------------------
# 실전 예제1 - 조건 1개: first_name이 'Jamie'인 행을 출력

select 
	last_name 
	, first_name
from 
	customer
where 
	first_name = 'Jamie'
;

# 실전 예제2 - 조건 2개: first_name이 'Jamie'와 'Rice'인 행을 출력

select 
	last_name 
  , first_name
from 
	customer
where 
	first_name = 'Jamie'
	and last_name = 'Rice'
;

# 실전 예제3 - 조건 2개: payment 테이블에서 amount가 1이하 이거나 8이상인 행 출력 

select 
	customer_id 
  , amount 
  , payment_date 
from 
	payment 
where 
	amount <= 1
	or amount >= 8
;
