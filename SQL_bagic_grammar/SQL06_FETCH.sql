# 필터링 - fetch 절 
# 특정 집합을 출력 시 출력하는 행위 수를 한정하는 역할을 한다. 부분 범위 처리시 사용된다.
# 앞서 배운 limit 절과 동일한 역할을 한다. 하지만 fetch 절은 오라클 SQL에서 사용하므로 익혀놓으면 좋다.

# fetch 절 문법 1
# 출력하는 행의 수를 지정한다. 
# N을 입력하지 않고 row only 만 입력하면 단 한 건만 출력한다. 

select
	*
from
	table_name 
fetch first [n] row only
;

# fetch 절 문법 2
# 출력하는 행의 수를 지정하면서 시작위치를 지정한다.
# offset n 값의 시작위치는 0이다.

select
	*
from
	table_name 
offset n rows
fetch first [n] row only
;
--------------------------------------------------

# 실습 예제 1
# title로 정렬한 집합 중에서 최초의 단 한건의 행을 리턴한다. 
select
	film_id
	,title
from
	film
order by
	title 
fetch first row only 
;

# 실습 예제 2
# title로 정렬한 집합 중에서 최초의 단 한건의 행을 리턴한다. 
# 숫자지정하면 지정한 숫자 만큼 결과가 나온다. 

select
	film_id
	,title
from
	film
order by
	title 
fetch first 1 row only 
;

# 실습 예제 3
# title로 정렬한 집합 중에서 6번째 행부터 5건의 행을 리턴한다.

select
	film_id
	,title
from
	film
order by title 
	offset 5 rows 
	fetch first 5 row only
;