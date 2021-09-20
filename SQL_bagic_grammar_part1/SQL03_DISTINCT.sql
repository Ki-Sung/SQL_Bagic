# 해당 문법부터 이용의 편의성을 위해 대문자가 아닌 소문자를 사용하고자 함.
# select 시 distinct를 사용하면 중복 값을 제외한 결과값이 출력된다. 즉 같은 결과의 행이라면 중복을 제거할 수 있다. 

# select distinct 기본 문법 1 -- column_1의 중복값 제거

# select 
# 	distinct column_1  
# from table_name;

# select distinct 기본 문법 2 -- column_1과 column_2의 중복값 제거

# select 
# 	distinct columns_1, column_2
# from table_name;

# select distinct 기본 문법 3 -- column_1과 column_2의 중복값 제거, 결과를 보기 위해 order by 절 사

# select 
# 	distinct columns_1, column_2
# from table_name
# order by column_1, column_2;

----------------------------------

# 실습을 위해 테이블 생성 
create table T1 (ID SERIAL not null primary key, BCOLOR varchar, FCOLOR varchar);

insert 
into T1 (BCOLOR, FCOLOR)
values 
	('red', 'red')
	,('red', 'red')
	,('red', null)
	,(null, 'red')
	,('red', 'green')
	,('red', 'blue')
	,('green', 'red')
	,('green', 'blue')
	,('green', 'green')
	,('blue', 'red')
	,('blue', 'green')
	,('blue', 'blue')
;

# 테이블 확인 
select 
	*
from 
	T1;

-------------------------------------
# 실습1 --slect distinct 실슴 - distinct 사용 + 컬럼 한 개
select 
	distinct bcolor
from
	t1 
order by
	bcolor;

# 실습2 --slect distinct 실슴 - distinct 사용 + 컬럼 두 개
select 
	distinct bcolor, fcolor 
from
	t1 
order by
	bcolor, fcolor;
	
# 실습3 --slect distinct 실슴 - distinct 사용 + 컬럼 두 개 + on 사용
select 
	distinct on (bcolor) bcolor    -- bcolor 컬럼 값 기준 중복 제거 
	, fcolor                       -- fcolor 컬럼 값은 단 한 개 값 만을 보여줌 
from
	t1 
order by
	bcolor, fcolor;
	
# 실습4 --slect distinct 실슴 - distinct 사용 + 컬럼 두 개 + on 사용 + desc (내림차순) 정렬 
select 
	distinct on (bcolor) bcolor   -- bcolor 컬럼 값 기준 중복 제거 
	, fcolor                      -- fcolor 컬럼 값은 단 한 개 값 만을 보여줌 
from
	t1 
order by
	bcolor, fcolor desc;