# between 연산자
# 특성 집합에서 어떠한 컬럼의 값이 특정 범위안에 들어가는 집하을 출력하는 연산자이다.

# between 연산자 문법 1 - column_name 컬럼의 값이 value_A와 value_B 사이에 있는 집합을 출력한다.
# select 
#      *
# from 
     table_name
# where 
     column_name
# between 
#    value_A and value_B;
# (column_name >= value_A and column_name <= value_B) -- 즉 column_name은 value_A 보다 크거가 같고 value_B 보다 작거나 같다.

# between 연산자 문법 2: not between - column_name 컬럼의 값이 value_A와 value_B 사이에 있지 않은 집합을 출력한다.
# select 
#      *
# from 
     table_name
# where 
     column_name
# not between 
#    value_A and value_B;
# (column_name < value_A and column_name > value_B) -- 즉 column_name은 value_A와 value_B 사이에 있지 않은 집합들을 출력 한다. 

----------------------------------------------------

# 실전예제 1 - between a and b
select
	customer_id
   , payment_id
   , amount
from
	payment
where
	amount 
between 
8 and 9;

# 설젠예제 2 - not between a and b 
select
	customer_id
   , payment_id
   , amount
from
	payment
where
	amount 
not between 
8 and 9;

# 실전예제 3 - 일자 비교 
select
	customer_id
   ,payment_id
   ,amount
   ,payment_date
from
	payment
where
	cast(payment_date as date)
between '2007-02-07' and '2007-02-15';

# 또는 to_char 함수를 이용할 수도 있다. - 보다 싶이 가독성이 좋지 않음. 
select
	customer_id
   ,payment_id
   ,amount
   , to_char(payment_date, 'yyyy-mm-dd')
   , cast(payment_date as date)
from
	payment
where
    to_char(payment_date, 'yyyy-mm-dd')
between '2007-02-07' and '2007-02-15';