# first_value, last_value 함수 
-- 특정 집합 내에서 결과 건수의 변화 없이 해당 집합안에서 특정 컬럼의 첫 번째 값 혹은 마지막 값을 구하는 함수이다. 

## first_value 함수 실습 

select 
	a.product_name 
  , b.group_name
  , a.price 
  , first_value (a.price) over 
    (partition by b.group_name order by a.price)
    as lowest_price_per_group 
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);

--> group_name 컬럼 기준으로 price 컬럼으로 정렬한 값 중에서 가장 첫 번째에 나오는 price 값을 출력한다.
--> group_name 기준 price가 가장 적은 값이 출력되었음을 알 수 있다.

# 만약 가장 비싼 값을 보고 싶다면?
select 
	a.product_name 
  , b.group_name
  , a.price 
  , first_value (a.price) over 
    (partition by b.group_name order by a.price desc)
    as lowest_price_per_group 
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);

## last_value 함수 실습 - 꼭 범위를 지정해야 함!

select 
	a.product_name 
  , b.group_name
  , a.price 
  , last_value (a.price) over 
    (partition by b.group_name order by a.price
    range between unbounded preceding
    and unbounded following)
    as highest_price_per_group 
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);

--> group_name 컬럼 기준으로 price 컬럼으로 정렬한 값 중에서 파티션의 첫 번째 로우부터 파티션 마지막 로우까지 가장 마지막에 나오는 price 값을 출력한다. 
--> group_name 기준 price가 가장 큰 값이 출력되었다. 
--> 참고로 'range between unbounded preceding and unbounded following'의 의미는
--> row: 부분집합인 윈도우 크기를 물리적인 단위로 행 집합을 지정 
--> unbounded preceding: 윈도우의 시작 위치가 첫 번째 row (최종 출력될 값이 맨 처음 row의 값)
--> unbounded following: 윈도우의 마지막 위치가 마지막 row 	(최종 출력될 값이 맨 마지막 row의 값)
--> 기본값은 'range between unbounded preceding and current row'이다. (current row는 현재의 로우값을 의미한다.)

# 만약 range between unbounded preceding and unbounded following을 제외한다면? 

select 
	a.product_name 
  , b.group_name
  , a.price 
  , last_value (a.price) over 
    (partition by b.group_name order by a.price
    )
    as highest_price_per_group 
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);

--> range between unbounded preceding and unbounded을 제외하게 되면 현재 가격이 출력된다. 
--> 이유는 기본값이 'range between unbounded preceding and current row' 즉 현재의 로우값이기 때문이다. 