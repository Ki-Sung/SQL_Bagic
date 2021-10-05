# 분석 함수 
-- 분석 함수란 특정 집합 내에서 결과 건수의 변화 없이 해당 집합안에서 합계 및 카운트 등을 계산할 수 있는 함수 이다. 
-- 로우의 손실 없이도 그룹별 집계 값을 산출해 낼 수 있다. 분석 함수에서 사용하는 로우별 그룹을 윈도우라고 부른다. 
-- partition by 절: 분석 함수로 계산될 대상 로우의 그룹을 지정한다.
-- order by 절: 파티션 안에서의 순서를 지정한다. 
-- window 절: AVG, SUM MAX, MIN, COUNT, CUM_DIST, DENSE_RANK, PERCENT_RANK, FIRST, LAST, LAG, LEAD, ROW_NUMBER 등이 있다. 

## 분석 함수 실습 준비 
# 1. 테이블 생성 
create table product_group (
 group_id serial primary key,
 group_name varchar (255) not null
);

create table product (
  product_id serial primary key 
, product_name varchar (255) not null
, price decimal (11, 2)
, group_id int not null
, foreign key (group_id)
  references product_group (group_id)
);

# 2. 테이블 정보 입력 
insert into product_group (group_name)
values 
  ('Smartphone')
, ('Laptop')
, ('Tablet');

insert into product (product_name,
group_id, price)
values 
  ('Microsoft Lumia', 1, 200)
, ('HTC One', 1, 400)
, ('Nexus', 1, 500)
, ('iPhone', 1, 900)
, ('HP Elite', 2, 1200)
, ('Lenovo Thinkpad', 2, 700)
, ('Sony VAIO', 2, 700)
, ('Dell Vostro', 2, 800)
, ('iPad', 3, 700)
, ('Kindle Fire', 3, 150)
, ('Samsung Galaxy Tab', 3, 200);

commit;

# 3. 데이터 확인

select 
	* 
from 
	product_group;

select 
	*
from 
	product;
	
# 4. 분석 함수 결과 예시 

select 
	count(*)
from 
	product;
--> 집계 함수는 집계의 결과만을 출력한다. 내용을 보지 못하는 한계가 있다. (product에 건수만 출력)

select 
	count(*) over(), a.*
from 
	product a;
--> 분석 함수는 집계의 결과 및 집합을 함께 출력한다. (이것이 바로 분석 함수의 역할이다.)