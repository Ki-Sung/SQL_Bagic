# AVG 함수 
-- 분석함수 AVG() 부터 본격적으로 분석함수를 학습한다. 그전에 분석함수의 문법에 대해서 간략히 알고 넘어간다. 

## 분석 함수 문법 
select 
	c1 
  , 분석함수(c2,c3, ...) over 
	(partition by c4 order by c5)   -> 사용하고자 하는 분석함수를 쓰고 대상 컬럼을 기재 후
from	                               partition by 에서 값을 구하는 기준 컬럼을 쓰고 
	table_name;                        order by 에서 정렬 컬럼을 기재한다.
	
-- partition by 절: 분석 함수로 계산될 대상 로우의 그룹을 지정한다.
-- order by 절: 파티션 안에서의 순서를 지정한다. 

---------------------------------------------------------------------------------------

## 실습 1 - 전체 평균 구하기 

select
	avg (price)   -> price 컬럼의 평균값을 구한다.
from 
	product;

--> 집계 함수는 집계의 결과만을 출력한다. 

## 실습 2 - group by + avg 구하기 

select 
	b.group_name                  -> group_name 컬럼을 기준으로 price컬럼의 평균값을 구한다. 
  , avg (price)
from 
	product a 
inner join product_group b 
	on (a.group_id = b.group_id)
group by 
	b.group_name;
	
## 실습 3 - 분석함수 사용 (보여줄 정보를 모두 출력하면서 group_name별 평균가격을 출력하고자한다.) 

select 
	a.product_name 
  , a.price 
  , b.group_name 
  , avg (a.price) over (partition by b.group_name)
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);

--> 분석함수를 사용하여 결과집합을 그대로 출력하면서 group_name 기준의 평균을 출력하였다.

## 실습 4 - 분석함수 사용 (보여줄 정보를 모두 출력하면서 group_name별 평균가격을 출력하고 group_name 기준으로 오름차순 정렬)

select 
	a.product_name 
  , a.price 
  , b.group_name 
  , avg (a.price) over (partition by b.group_name order by b.group_name)
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);

## 실습 5 - 누적 집계 합계 평균 출력 

select 
	a.product_name 
  , a.price 
  , b.group_name 
  , avg (a.price) over (partition by b.group_name order by a.price) --> 누적 집계 합계 평균 
from 
	product a 
inner join product_group b 
on (a.group_id = b.group_id);

--> 각 그룹 마지막은 해당 그룹의 평균을 의미 한다. 