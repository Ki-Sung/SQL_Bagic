## 실습 문제 1 
-- rental 테이블을 이용하여 연, 연월, 연월일 전체 각각의 기준으로 rental_id 기준 렌탈이 일어난 횟수를 출력하라. (전체 데이터 기준으로 모든 행을 출력)

# 순서 1 - 우선 집계 데이터로 출력 

select 
	count(*)
from 
	rental;

# 순서 2 - 연도별 집계 데이터 출력 

select 
	  to_char(rental_date, 'yyyy')
	, count(*)
from 
	rental
group by 
	to_char(rental_date, 'yyyy');

# 순서 3 - 연, 월, 일별로 집계 

select 
	  to_char(rental_date, 'yyyy/mm/dd')
	, count(*)
from 
	rental
group by 
	to_char(rental_date, 'yyyy/mm/dd')
order by 
	to_char(rental_date, 'yyyy/mm/dd');

# 순서 4 - 연별, 월별, 일별로 rollup을 사용하기 

select 
	  to_char(rental_date, 'yyyy') y
	, to_char(rental_date, 'mm') m
	, to_char(rental_date, 'dd') d
	, count (rental_id)
from 
	rental
group by 
rollup 
(
  to_char(rental_date, 'yyyy') 
, to_char(rental_date, 'mm') 
, to_char(rental_date, 'dd') 
);
	
--> to_char 함수: 날짜, 숫자 등의 값을 문자열로 변환하는 함수 
--> 문제에서 말함 연, 연월, 연월일로 변경 하려면 아래와 같다 
--> 연: to_char(rental_date, 'yyyy')  -> 2005
--> 월: to_char(rental_date, 'mm') --> 05 
--> 일: to_char(rental_date, 'dd') --> 24 
--> 년, 월, 일 기준으로 rollup 한다. 이렇게 하면 연 기준, 연월 기준, 연월일 기준, 전체 기준으로 집계한다. 

## 실습 문제 2
-- rental과 customer 테이블을 이용하여 현재까지 가장 많이 rental을 한 고객의 고객ID, 렌탈순위, 누적렌탈횟수, 이름을 출력하라. 

# 순서 1 - 가장 먼저 rental 순위를 구한다. 

select 
	  a.customer_id 
	, row_number () over (order by count(a.rental_id) desc) as rental_rank
	, count(a.rental_id) rental_count 
from 
	rental a 
group by 
	a.customer_id;

--> customer_id 기준으로 group by 했으며 그로 인해 row_number에서 partition by가 생략되었다.
--> 누적렌탈횟수는 집계함수 count로 구했다. 
	
# 순서 2 - 그리고 가장 많이 rental을 한 1명의 고객만 구하도록 order by + limit 절을 이용한다.

select 
	  a.customer_id 
	, row_number () over (order by count(a.rental_id) desc) as rental_rank
	, count(a.rental_id) rental_count
from 
	rental a
group by 
	a.customer_id
order by
	rental_rank
limit 1;

# 순서 3 - 마지막으로 고객의 이름을 출력하기 위해 customer 테이블과 조인한다. 

select 
	  a.customer_id 
	, row_number () over (order by count(a.rental_id) desc) as rental_rank
	, count(a.rental_id) rental_count
	, max(b.first_name) as first_name
	, max(b.last_name) as last_name 
from 
	  rental a 
	, customer b
where 
	a.customer_id  = b.customer_id 
group by 
	a.customer_id
order by
	rental_rank
limit 1;

--> customer_id 기준으로 group by 되어 있으므로 frist_name, last_name에 max 함수를 사용해서 출력한다. 
--> 어차피 데이터는 한 건이므로 결과 집합에는 이상이 없다.  

# max 함수를 사용하지 않고 출력 하는 방법 - 서브쿼리 이용 

select 
	  a.customer_id 
	, a.rental_rank
	, a.rental_count
	, b.first_name 
	, b.last_name 
from 
	(
	select
		  a.customer_id
		, row_number () over (order by count(a.rental_id) desc) as rental_rank
		, count(a.rental_id) rental_count
	from 
		rental a 
	group by 
		a.customer_id
	order by
		rental_rank
	limit 1
	) a, customer b 
where 
	a.customer_id = b.customer_id;