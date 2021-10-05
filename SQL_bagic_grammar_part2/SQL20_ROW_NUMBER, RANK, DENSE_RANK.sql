# row_number, rank, dense_rank 함수 
-- 특정 집합 내에서 결과 건수의 변화 없이 해당 집합안에서 특정 컬럼의 순위를 구하는 함수이다. 

## row_number 함수 실습 - 무조건 1, 2, 3, 4, 5, ...

select
	a.product_name 
  , b.group_name 
  , a.price 
  , row_number () over 
    (partition by b.group_name order by a.price)
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);

--> 해당 집합내에서 순위를 구한다. 순위를 구할 때 group_name 컬럼 기준으로 구하고 group_name 기준의 각 순위는 price 컬럼 기준으로 정렬한다. 
--> row_number는 같은 순위가 있어서 무조건 순차적으로 순위를 매긴다. (1, 2, 3, 4, 5,... 순으로 간다.)
--> group_name 별 price가 가장 낮은 순서대로 순위를 매김

# 만약 price가 가장 낮은 순서가 아닌 높은 순으로 바꾸고 싶다면 ?
select
	a.product_name 
  , b.group_name 
  , a.price 
  , row_number () over 
    (partition by b.group_name order by a.price desc)
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);

## rank 함수 실습 - 같은 순위면 같은 순위면서 다음 순위 건너뜀 1, 1, 3, 4, ...

select 
	a.product_name 
  , b.group_name 
  , a.price 
  , rank () over
    (partition by b.group_name order by a.price)
from 
	product a
inner join product_group b 
on (a.group_id = b.group_id);

--> 해당 집합내에서 순위를 구한다. 순위를 구할 때 group_name 컬럼 기준으로 구하고 group_name 기준으로 각 순위는 price 컬럼 기준으로 정렬한다. 
--> rank는 같은 순위가 있으면 동일 순위를 매기고 그 다음 순위로 건너뛴다. (1, 1, 3, 4, ...)

# 만약 price가 가장 낮은 순서가 아닌 높은 순으로 바꾸고 싶다면 ?
select 
	a.product_name 
  , b.group_name 
  , a.price 
  , rank () over
    (partition by b.group_name order by a.price desc)
from 
	product a
inner join product_group b 
on (a.group_id = b.group_id);

## dense_rank 함수 실습 - 같은 순위면 같은 순위면서 다음 순위 건너뛰지 않음 1, 1, 2, 3, ... 

select 
	a.product_name 
  , b.group_name 
  , a.price 
  , dense_rank () over
    (partition by b.group_name order by a.price)
from 
	product a
inner join product_group b 
on (a.group_id = b.group_id);	

--> 해당 집합내에서 순위를 구한다. 순위를 구할 때 group_name 컬럼 기준으로 구하고 group_name 기준으로 각 순위는 price 컬럼 기준으로 정렬한다. 
--> dense_rank는 같은 순위가 있으면 동일 순위로 매기고 그 다음 순위를 건너뛰지 않는다. (1, 1, 2, 3, ... 순이다.)

# 만약 price가 가장 낮은 순서가 아닌 높은 순으로 바꾸고 싶다면 ?
select 
	a.product_name 
  , b.group_name 
  , a.price 
  , dense_rank () over
    (partition by b.group_name order by a.price desc)
from 
	product a
inner join product_group b 
on (a.group_id = b.group_id);