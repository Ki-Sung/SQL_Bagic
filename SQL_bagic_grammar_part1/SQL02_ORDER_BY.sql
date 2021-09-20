# ORDER BY 문
# SELECT문에서 가져온 데이터를 정렬하는데 사용한다. 업무 처리상 매우 중요한 기능이다.
----------------------------
# ORDER BY 문법 
# SELECT
# 	COLUMN_1     -- 추출 대상 컬럼 
#	,COLUMN_2
# FROM
# 	TBL_NAME     -- 추출 대상 테이블명 입 
# ORDER BY COLUMN_1 ASC    - COLUMN_1은 오름차순 정렬(Deault는 ASC)
		 , COLUMN_2 DESC   - COLUMN_2는 내림차순 정렬(Deault는 ASC) 
#;
-----------------------------
# 실습1
SELECT 
	FIRST_NAME
	,LAST_NAME
FROM
	customer 
ORDER BY FIRST_NAME ASC 
;
# SQL의 결과를 출력 시 FIRST_NAME 오름차순으로 정렬한다. 

# 실습2
SELECT 
	FIRST_NAME
	,LAST_NAME
FROM
	customer 
ORDER BY FIRST_NAME DESC 
;

# 실습3 
SELECT 
	FIRST_NAME  --asc --오름차순-- 순차
	,LAST_NAME  --desc --내림차순--역순 
FROM
	customer 
ORDER BY FIRST_NAME ASC  --가독성이 좋음--
        , LAST_NAME DESC
;
-- 또는 --
SELECT 
	FIRST_NAME  --asc --오름차순-- 순차
	,LAST_NAME  --desc --내림차순--역순 
FROM
	customer 
ORDER BY 1 ASC 
        , 2DESC  --간편하지만, 유지보순, 가독성으로 보았을 때 좋지 않음--
;
