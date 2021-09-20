# 필터링 - limit 절 
# 특정 집합을 출력 시 출력하는 행의 수를 한전하는 역할을 한다. 부분 범위 처리시 사용된다.(postgreSQL, mySQL 등에서 지원)
# 가장 많이 사용되는 문법이기도 하다. 

# limit 절 문법1 - 출력하는 행의 수 n을 지정한다.
select
	*
from
	table_name
limit n
;

# limit 절 문법2 - 출력하는 행의 수를 지정하면서 시작위치를 지정한다. offset m값의 시작위치는 0이다.
select
	*
from
	table_name
limit n offset m  -- offset으로 시작 limit로 (m ~ n까지)
;
----------------------------------------------------

# 실전 실습1
# film_id로 정렬한다, 정렬한 값 중에서 결과 건수는 5건으로 제한한다. (order by film_id, limit 5) 

select
	film_id
	, title
	, release_year
from
	film
order by
	film_id
limit 5
;

# 실전 실습2 
# film_id로 정렬한다, 정렬한 값 중에서 결과 건수는 4건으로 제한한다. (order by film_id, limit 4)
# film_id로 정렬한 값 중에서 출력행의 시작위치는 3이다. (시작위치 3은 0,1,2,3 즉 4번째 행부터 시작 - offset 3)

select
	film_id
	, title
	, release_year
from
	film
order by film_id
	limit 4
	offset 3;
;

# 실전 실습3 
# rental_rate를 기준으로 내림차순으로 정렬한다.
# 정렬한 값 중에서 최소 10건 만을 출력한다.  

select
	film_id
	, title
	, rental_rate
from
	film
order by rental_rate desc
	limit 10 
;

