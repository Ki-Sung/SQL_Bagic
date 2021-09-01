# SELECT 문 - 일반적으로 테이블에 저장된 데이터를 가져오는데 쓰이며 SQL에서 가장 많이 쓰이는 문장이다.
# 기본문법
# select  -- 3
#     COLUMN_1  - 추출 대상 컬    -- 4
#    ,COLUMN_2    만약 테이블의 모든 컬럼을 다 보고 싶다면 "*"
# FROM   - 추출 대상 테이블명  -- 1
# TABEL_NAME              -- 2
# ;    - 항상 끝에 세미콜론으로 끝

# 실습1 - 전체 컬럼 조회
SELECT
	* 
FROM
	CUSTOMER
;
--------------------
# 실습2 - 지정한 컬럼 조회
SELECT
	FIRST_NAME
	,LAST_NAME
	,EMAIL
FROM
	CUSTOMER
;
---------------------
# ALIAS(별칭) - 코드의 가독성을 위해 사용하며, SQL의 성능을 위해서 사용한다.
SELECT
	A.FIRST_NAME
	,A.LAST_NAME
	,A.EMAIL
FROM
	CUSTOMER A
;
# DBMS -> 옵티마이저 -> 최적화하기 -> sql -> 가장빠르게, 가장 저비용, 실행
