# lag, lead 함수 
-- 특정 집합 내에서 결과 건수의 변화 없이 해당 집합안에서 특정 컬럼의 이전 행의 값 혹은 다음 행의 값을 구한다. 

## lag 함수 실습 - 이전 행의 값을 찾는다. 

select 
	a.product_name
  , b.group_name 
  , a.price 
  , lag (a.price, 1) over                          -> price의 이전 행의 값을 구한다.
    (partition by b.group_name order by a.price)   -> group_name 컬럼 기준으로 price 컬럼으로 정렬한 값 중에서 
    as prev_price 
  , a.price - lag (price, 1) over                  -> 현재행의 price에서 이전행의 price를 뺀다.
    (partition by group_name order by a.price)     -> group_name 컬럼 기준으로 price 컬럼으로 정렬한 값 중에서
    as cur_prev_diff
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);

# 두단계 기준으로 보고 싶다면? 
select 
	a.product_name
  , b.group_name 
  , a.price 
  , lag (a.price, 2) over                          
    (partition by b.group_name order by a.price)   
    as prev_price 
  , a.price - lag (price, 2) over                  
    (partition by group_name order by a.price)     
    as cur_prev_diff
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);
--> 평소 실전에서도 많이 쓰이는 SQL 문중 하나이다. 

## lead 함수 실습 - 다음행의 값을 찾는다. 

select 
	a.product_name
  , b.group_name 
  , a.price 
  , lead (a.price, 1) over                         -> price의 다음 행의 값을 구한다.     
    (partition by b.group_name order by a.price)   -> group_name 컬럼 기준으로 price 컬럼으로 정렬한 값 중에서  
    as next_price 
  , a.price - lead (price, 1) over                 -> 현재행의 price에서 다음행의 price를 뺀다.
    (partition by group_name order by a.price)     -> group_name 컬럼 기준으로 price 컬럼으로 정렬한 값 중에서 
    as cur_next_diff
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);

# 두단계 기준으로 보고 싶다면? 
select 
	a.product_name
  , b.group_name 
  , a.price 
  , lead (a.price, 2) over                             
    (partition by b.group_name order by a.price)   
    as next_price 
  , a.price - lead (price, 2) over                 
    (partition by group_name order by a.price)     
    as cur_next_diff
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);

--> 해당 함수도 실전에 많이쓰는 함수 중 하나이니 꼭 숙지! 