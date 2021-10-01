# grouping set 절 
-- grouping set 절을 사용하여 여러 개의 union all(조회한 다수의 select 문을 중복제거 하지않고 모두 합쳐서 보여주는 연산자)을 이용한 SQL과 같은 결과를 도출할 수 있다.

## 실습 준비 - 테이블 생성  
# 1. 테이블 생성 
create table sales 
(
brand varchar not null,
segment varchar not null,
quantity int not null,
primary key (brand, segment)
);

# 2. 테이블에 데이터 넣기 
insert into sales (brand, segment, quantity)
values 
  ('ABC', 'Premium', 100)
, ('ABC', 'Basic', 200)
, ('XYZ', 'Premium', 100)
, ('XYZ', 'Basic', 300);

commit;

# 3. 데이터 확인 
select 
	*
from 
	sales;

## grouping set 절 학습 전 준비 1 - 2개 컬럼 group by 절        

select 
	brand
  , segment 
  , sum (quantity)        -> group by 후 quantity 컬럼의 합계를 구한다.
from
	sales                 -> sales 테이블 조회 
group by    
	brand, segment;       -> brand와 segment 컬럼 기준으로 group by 한다.

## grouping set 절 학습 전 준비 2 - 1개 컬럼 group by 절 
             
select 
	brand
  , sum (quantity)       -> group by 후 quantity 컬럼의 합계를 구한다.
from 
	sales                -> sales 테이블 조회 
group by 
	brand;               -> brand 컬럼 기준으로 group by 한다.
	
## grouping set 절 학습 전 준비 3 - 1개 컬럼 group by 절 

select 
	segment
  , sum (quantity)       -> group by 후 quantity 컬럼의 합계를 구한다.
from 
	sales                -> sales 테이블 조회 
group by 
	segment;             -> segment 컬럼 기준으로 group by 한다.
	
## grouping set 절 학습 전 준비 4 - 전체 합계 구하기 

select 
	sum (quantity)       -> quantity 컬럼의 합계를 구한다. 
from 
	sales;               -> sales 테이블을 조회한다.

## grouping set 절 학습 전 준비 5 - union all의 활용

select 
	brand
  , segment
  , sum (quantity)      -> brand, segment 기준 quantity 컬럼의 합계를 구한다.
from 
	sales
group by 
	brand, segment      -> brand, segment 컬럼 기준으로 group by 한다.
	
union all               -> 중복값 제거하지 않고 테이블 합치기  

select 
	brand
  , null 
  , sum (quantity)     -> brand 컬럼 기준 quantity 컬럼 합계를 구한다.
from
	sales
group by 
	brand              -> brand 컬럼 기준으로 group by 한다.
	
union all              -> 중복값 제거하지 않고 테이블 합치기 

select 
	null 
  , segment 
  , sum (quantity)     -> segment 컬럼 기준 quantity 컬럼 합계를 구한다. 
from 
	sales 
group by 
	segment            -> segment 컬럼 기준으로 group by 한다. 
	
union all              -> 중복값 제거하지 않고 테이블 합치기 

select 
	null 
  , null 
  , sum (quantity)     
from
	sales;             -> quantity 컬럼의 전체 합계를 구한다. 

-- 동일한 테이블 4번씩이나 읽고 있다. -> 성능저하 일어난다.
-- union all  절을 사용할 수 있지만 문법의 길이가 길어진다. -> 유지보수가 용이하지 않다. 
-- 이런 것을 방지하기 위해 grouping set 절을 사용한다.
	
##  grouping set 절 문법  

select 
	c1
  , c2
  , 집계함수(c3)
from 
	table_name 
group by 
grouping sets  -> grouping set 절을 이용하면 한번에 다양한 기준의 컬럼 조합으로 집계를 구할 수 있다.
(
  (c1, c2)
, (c1)
, (c2)
, ()
);

----------------------------------------------------------------------------------------------------

## 실습예제 1 - grouping set 절 실습 

select
	brand
  , segment
  , sum (quantity)
from
	sales
group by 
grouping sets 
(
  (brand, segment)   -> brand, segment 컬럼 기준으로 합계를 구한다.
, (brand)            -> brand 컬럼 기준으로 합계를 구한다.
, (segment)          -> segment 컬럼 기준으로 합계를 구한다.
, ()                 -> 테이블 전체를 기준으로 합계를 구한다 
);

-- group set 절을 이용하여 brand, segment 기준, brand 기준, segment 기준, 전체 기준으로 quantity 합계의 값을 구할 수 있다.

## 실습예제 2  grouping 함수 활용 

select 
	grouping(brand) grouping_brand
  , grouping(segment) grouping_segment   -> 해당 컬럼이 집계에 사용되었으면 0, 그렇지 않으면 1을 리턴 한다.
  , brand 
  , segment 
  , sum(quantity)
from 
	sales
group by 
grouping sets 
(
  (brand, segment)
, (brand)
, (segment)
, ()
)
order by 
	brand, segment;

## 혹은 좀더 직관적으로 보고 싶으면 아래와 같이 사용해도 된다. (select grouping의 활용 예제)

select 
	case when grouping(brand) = 0 and grouping(segment) = 0 then '브랜드별+등급별'
		 when grouping(brand) = 0 and grouping(segment) = 1 then '브랜드별'
		 when grouping(brand) = 1 and grouping(segment) = 0 then '등급별'
		 when grouping(brand) = 1 and grouping(segment) = 1 then '전체합계'
		 else ' '
		 end as "집계기준"
  , brand 
  , segment 
  , sum(quantity)
from 
	sales
group by 
grouping sets 
(
  (brand, segment)
, (brand)
, (segment)
, ()
)
order by 
	brand, segment;