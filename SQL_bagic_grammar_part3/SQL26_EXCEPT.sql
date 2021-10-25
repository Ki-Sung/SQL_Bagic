# except 연산 
-- except 연산자는 맨 위에 select 문의 결과 집합에서 그 아래에 있는 select 문의 결과 집합을 제외한 결과를 리턴한다. 
-- 해당 문법은 실무에서 많이 사용한다. 

## 1. except 연산 문법 

select 
	  column_1_1   -> 두 개의 select 문 간 컬럼의 개수는 동일해야하고 해당 순서의 
	, column_1_2      열에는 서로 호환되는 데이터 유형 이어야 한다.
from 
	table_name_1
except
select 
	  column_2_1   -> 두 개의 select 문 간 컬럼의 개수는 동일해야하고 해당 순서의
	, column_2_2      열에는 서로 호환되는 데이터 유형 이어야 한다.
from 
	table_name_2;

--> order by로 정렬하고자 할 경우 맨 마지막 select 문에 order by 절을 사용한다. 

----------------------------------------------------------------------------------------------

## 2. 실전 예제 1 - except 연산 실습 

# 2-1. 실습 준비 

select
	distinct inventory.film_id 
  , title
from
	inventory
inner join 
	film 
on film.film_id = inventory.film_id 
order by
	title;

--> 필름과 인벤토리는 1:m 관계 -> 두 테이블을 조인하면 영화 하나당 여러개의 재고가 나오기 때문에 중복값을 제거하였다. 
--> 재고가 존재하는 영화의 필름id와 영화 제목을 추출하는 sql 이다. 그렇다면 재고가 존재하지 않는 영화는 어떻게 추출하는가? -> 필름 - 재고 = 재고가 없는 영화 

# 2-2. except 연산 실습 

select 
	  film_id
	, title 
from 
	film 
except 
select 
	distinct inventory.film_id
  ,	title 
from 
	inventory 
inner join 
	film 
on film.film_id = inventory.film_id 
order by 
	title;

--> 이 sql은 재고가 존재하지 않는 영화 id와 제목을 추출한다. -> 전체영화 - 재고가 존재하는 영화 = 재고가 존재하지 않는 영화다 