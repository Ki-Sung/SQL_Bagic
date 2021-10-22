## union all 연산 
-- 두 개 이상의 select 문들의 결과 집합을 단일 결과 집합으로 결합하며 결함 시 중복된 데이터도 모두 출력한다. 
-- 실전에서는 union 연산 보다 union all 연산을 많이 이용한다. -> SQL 사용자들은 중복된 사항도 모두 보고 싶어하기 때문이다.

## 실습 예제 1 - union all 함수 기본 

# 실습 1

select 
	*
from 
	sales2007_1
union all
select 
	*
from 
	sales2007_2
;
--> 'Mary', '100000' 중복 데이터 출력함 

# 실습 2 

select 
	name 
from 
	sales2007_1
union all
select 
	name
from 
	sales2007_2
;
--> 'Mike, Jon, Mary' 중복 데이터 출력

# 실습 3

select 
	amount
from 
	sales2007_1
union all
select 
	amount
from 
	sales2007_2
;
--> '100000' 중복 데이터 출력 

## 실습 예제 2 - union all 함수 order by 활용 

select 
	*
from 
	sales2007_1
union all 
select 
	*
from 
	sales2007_2
order by 
	amount desc;
--> union 연산과 마찬가지 order by는 맨 마지막 select 문에 기재한다. 