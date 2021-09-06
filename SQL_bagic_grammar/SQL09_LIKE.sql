# like 연산자 
# 특정 집합에서 어떠한 컬럼의 값이 특정 값과 유사한 패턴을 갖는 집합을 출력하는 연산자 이다.

# like 기본문법 1 - like: column_name에서 컬럼의 값이 특정 패턴과 유사한 집합을 출력한다.
# slect 
#     *
# from 
#     table_name
# where 
#     column_name
# like 
#     특정패턴
 
# like 기본문법 2 - not like: column_name에서 컬럼의 값이 특정 패턴과 유사하지 않 집합을 출력한다.
# slect 
#     *
# from 
#     table_name
# where 
#     column_name
# not like 
#     특정패턴
 -- 특정 패턴에서 '%'는 어떤 문자 혹은 문자열이 매칭 되었다고 판단한다.
 -- 특정 패턴에서 '_'는 한 개의 문자가 어떤 문자이든지 매칭 되었다고 판단한다. 

# lik 연산자 결과 값들 
# select
#     'foo' like 'foo' -- 결과값: true -> 'foo'는 'foo'이므로 참이다.
    , 'foo' like 'f%' -- 결과값: ture -> 'f%'는 'f'로 시작하면 모두 참이다. 
    , 'foo' like '_o_' -- 결과값: ture -> '_o_'는 3자리 문자열이고 가운데 문자가 'o'라면 모두 참이다.
    , 'bar' like 'b_' -- 결과값: false -> 'b_'는 2자리 문자열이고 'b'로 시작하기만 하면 두번째 문자는 무엇이든 간에 참이다. 
                                      -- 하지만 'bar'이 'b'로 시작하긴 했지만 3자리이므로 거짓이다. 

--------------------------------------------------------------

# 실전 예제1 - like 연산자 - first_name이 'Jen'으로 시작하는 집합을 출력한다, 즉 'Jen'이후의 문자 혹은 문자열은 모두 매칭된다.  
select
	first_name
   , last_name
from
	customer
where
	first_name like 'Jen%';
	
# 실전 예제2 - first_name에 'er'이 존재하는 모든 집합을 출력한다.
select
	first_name
   , last_name
from
	customer
where
	first_name like '%er%';

# 실전 예제 3 - 첫 번째 문자가 어떠한 문자로 시작 가능, 하지만 그 다음이 'her'이어야 하고 그다음에는 어떤 문자 혹은 문자열이 이어도 상관없는 집합 출력 
select
	first_name
   , last_name
from
	customer
where
	first_name like '_her%';

# 실전 예제 4 - first_name이 'Jen'으로 시작하지 않은 집합을 출력 
select
	first_name
   , last_name
from
	customer
where
	first_name not like 'Jen%';