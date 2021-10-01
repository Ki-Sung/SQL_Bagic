# roll up 절 
-- 지정된 grouping 컬럼의 소계를 생성하는데 사용된다. 간단한 문법으로 다양한 소계를 출력할 수 있다. 

## rollup 절 문법 1

select 
	c1
  , c2
  , c3
  , 집계함수(c4)
from 
	table_name
group by
	rollup (c1, c2, c3);  -> 소계를 생성할 컬럼을 지정한다. 컬럼 지정 순서에 따라 결과값이 
	                         달라질 수 있다. (제일 앞에 놓인 것에 소계를 구함)

## rollup 절 문법 2

select 
	c1
  , c2
  , c3
  , 집계함수(c4)
from 
	table_name
group by 
	c1,
	rollup (c2, c3);     -> 특정 컬럼을 제외한 부분적인 rollup도 가능하다. 

-------------------------------------------------------------------------------------
	
## 실전 예제 1 - rollup 절 실습 

select
	brand 
  , segment
  , sum (quantity)
from 
	sales 
group by 
	rollup (brand, segment)   -> brand, segment 컬럼 기준으로 rollup 한다.  
order by 
	brand, segment;

-- group by 별 합계 + rollup 절에 맨 앞에 쓴 컬럼 기준의 합계 + 전체 합계 모두 자동으로 계산해서 출력 -> 효율적이다. 
	
## 실전 예제 2 - rollup 절 실습 

select
	segment
  ,	brand
  , sum (quantity)
from 
	sales 
group by 
	segment,
	rollup (brand)  
order by 
	segment, brand;
	
-- 부분 rollup 시 전체 합계는 구하지 않는다. -> group by 별 합계 + rollup 절에 맨 앞에 쓴 컬럼 기준의 합계 까지만 출력한다. 