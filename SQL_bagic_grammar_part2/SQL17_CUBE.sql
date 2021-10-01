# cube 절 
-- 지정된 grouping 컬럼의 다차원 소계를 생성하는데 사용된다. 간단ㅇ한 문법으로 다차원 소계를 출력할 수 있다.

## cube 문법 1

select
	c1
  , c2
  , c3
  , 집계함수(c4)
from 
	table_name 
group by 
	cube (c1, c2, c3);    -> cube 절에서 다차원 소계를 할 열을 지정한다. (지정한 그룹의 모든 경우에 수에 대한 
	                         소계와 총계를 구한다.)
	                         
## cube 문법 2 

select
	c1
  , c2
  , c3
  , 집계함수(c4)
from 
	table_name 
group by 
	c1, 
	cube (c2, c3);        -> 특정 컬럼만 분리하여 cube 지정을 할 수 있다. 

-- cube 절 내 인자의 개수가 3개이면 2의 3승의 소계가 발생하게 된다. 즉 8개의 소계가 발생하게 된다. (2의 N승 = 소계의 수)

cube(c1, c2, c3)  => grouping sets(
                     (c1, c2, c3),
                     (c1, c2),
                     (c1, c3),         -> cube(c1, c2, c3)를 groupingsets로 표현하면 총 8개의 소계가 발생
                     (c2, c3),
                     (c1),
                     (c2),
                     (c3),
                     ()
                     )
   
---------------------------------------------------------------------------------------------------
                     
## 실전예제 1 - cube 절 실습 

select 
	brand
  , segment 
  , sum (quantity)
from 
	sales 
group by 
	cube (brand, segment)
order by 
	brand, segment;          -> brand, segment 컬럼 기준으로 cube 한다. 

-- 인자가 2개(컬럼이 2개) 이므로 총 4개의 경우에 수가 합계로 출력되었다.
   -> brand 별 합계 + segment 별 합계 + brand, segment 별 합계 + 전체 합계 (cube = group by 절 합계 + brand 별 + segment 별 + 전체 합계)
	
## 실전예제 2 - cube 절 실습 

select 
	brand 
  , segment 
  , sum (quantity)
from
	sales 
group by 
	brand, 
	cube (segment)
order by 
	brand, segment;

-- segment 컬럼 기준으로 소계 하지 않는다. (부분 cube = group by 별 합계 + 맨 앞에 쓴 컬럼별 합계)
-- 뒤에 쓴 컬럼과 전체 합계는 구하지 않는다. 