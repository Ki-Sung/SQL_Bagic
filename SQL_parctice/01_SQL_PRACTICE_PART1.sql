# 실습 문제 1 
# payment 테이블에서 단일 거래의 amount의 액수가 가장 많은 고객들의 customer_id를 추출하라
# 단, customer_id의 값은 유일해야 한다.

-- 1. 우선 전체 거래 중 amount의 액수가 가장 큰 amount를 구한다.
select
	amount
from
	payment
order by
	amount 
desc
limit 1;

-- 2. 그리고 payment 테이블에서 가장 큰 amount를 가진 customer_id를 구하고 중복을 제거한다. 
select
	distinct 
customer_id
from
	payment
where
	amount = (
	select
		amount
	from
		payment
	order by
		amount desc
	limit 1
);

--------------------------------------------------

# 실습 문제 2
# 고객들에게 단체 이메일을 전송 하고자 한다. customer 테이블에서 고객의 email 주소를 추출하고, 이메일형식에 맞지 않는 이메일 주소를 제외시켜라 
# 단 이메일 형식은 '@'가 존재해야하고 '@'로 시작하지 말아야 하고 '@'로 끝나지 말아야 한다.

select
	email
from
	customer
where
	email like '%@%'
	and email not like '@%'
	and email not like '%@';

# 또는 
select
	email
from
	customer
where
	email not like '@%'
	and email not like '%@'
	and email like '%r%';