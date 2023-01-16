 /*DROP TABLE CLASS402;
CREATE TABLE CLASS402(
    ID   VARCHAR2(3) PRIMARY KEY,    
    NAME VARCHAR2(9),
    PNUM VARCHAR2(13),
    AGE  NUMBER(2),
    CONSTRAINT UK_CLASS402 UNIQUE(PNUM)
);

INSERT INTO CLASS402 VALUES('GSJ','길선주','123',20);
INSERT INTO CLASS402 VALUES('KGS','김강산','756',21);
INSERT INTO CLASS402 VALUES('KMG','김무건','416',22);
INSERT INTO CLASS402 VALUES('KYS','김연수','789',23);
INSERT INTO CLASS402 VALUES('KTH','김태훈','273',24);

COMMIT;
*/
--LPROD 테이블 생성 (3개의 컬럼, LPROD_GU컬럼이 P.K)
CREATE TABLE lprod (
    lprod_id   NUMBER(5) NOT NULL, --순번
    lprod_gu   CHAR(4) NOT NULL, --상품분류코드
    lprod_nm   VARCHAR2(40) NOT NULL, --상품분류명
    CONSTRAINT pk_lprod PRIMARY KEY ( lprod_gu )
);

--테이블에 설명글 달기

COMMENT ON TABLE lprod IS
    '상품분류';
--컬럼에 설명글 달기

COMMENT ON COLUMN lprod.lprod_id IS
    '순번';

COMMENT ON COLUMN lprod.lprod_gu IS
    '상품분류코드';

COMMENT ON COLUMN lprod.lprod_nm IS
    '상품분류명';

CREATE TABLE buyer (
    buyer_id         CHAR(6) NOT NULL,   --거래처코드
    buyer_name       VARCHAR2(40) NOT NULL,  --거래처명
    buyer_lgu        CHAR(4) NOT NULL,   --취급상품 대분류
    buyer_bank       VARCHAR2(60),   --은행
    buyer_bankno     VARCHAR2(60),   --계좌번호
    buyer_bankname   VARCHAR2(15),    --예금주
    buyer_zip        CHAR(7),    --우편번호
    buyer_add1       VARCHAR2(100),  --주소1
    buyer_add2       VARCHAR2(70),   --주소2
    buyer_comtel     VARCHAR2(14) NOT NULL, --전화번호
    buyer_fax        VARCHAR2(20) NOT NULL   --FAX번호
);

--P.148
/*
ALTER TABLE : 테이블의 구조만 변경, 데이터 내용은 변경안됨

ALTER TABLE  <테이블 명>
  ADD (새로운컬럼명 TYPE  [DEFAULT value] , … ) 
    => 컬럼 추가, 기본 값, 제약조건 추가
  MODIFY (필드명 TYPE  [NOT NULL] [DEFAULT value] , … ) 
    => 컬럼 자료형/크기 변경, NULL을 NOT NULL로, NOT NULL을 NULL로 제약조건 변경
    => 컬럼명을 변경X => RENAME을 써야 함
  DROP COLUMN 필드명  => 기존 컬럼, 제약조건 제거
*/
--BUYER테이블의 구조 변경(컬럼이 추가)
--ADD(추가), MODIFY(변경), DROP(제거)
--NULL은 생략 가능

ALTER TABLE buyer ADD (
    buyer_mail      VARCHAR2(60) NOT NULL,
    buyer_charger   VARCHAR2(20) NULL,
    buyer_telext    VARCHAR2(2)
);

ALTER TABLE buyer MODIFY (
    buyer_name VARCHAR2(60)
);

DESC buyer;
--ADD추가 CONSTRAINT( 제약사항)  CHECK_PHONE(이름)
--CHECK : BUYER_TELEXT 컬럼에 데이터가 입력될 때 벙뮈 설정 
--REGEXP_LIKE : 정규식
--[0-9] : 0~9사이의 정수  
--[0-9][0-9] : 두 자리의 정수

ALTER TABLE buyer
    ADD CONSTRAINT check_phone CHECK ( REGEXP_LIKE ( buyer_telext,
    '[0-9][0-9]' ) );

--INDEX : 책의 목차와 비슷함
--BUYER 테이블의 BUYER_NAME, BUYER_ID를 묶어서 인덱스 생성
-- 검색속도를 빠르게 하려고..

CREATE INDEX idx_buyer ON
    buyer ( buyer_name,
    buyer_id );

--d인덱스 제거

DROP INDEX idx_buyer;

--기본키 조건 : NO DUPLICATE, NOT NULL

ALTER TABLE buyer ADD (
    CONSTRAINT pk_buyer PRIMARY KEY ( buyer_id )
);

ALTER TABLE buyer ADD (
    CONSTRAINT fk_buyer_lprod FOREIGN KEY ( buyer_lgu )
        REFERENCES lprod ( lprod_gu )
);
                        
 --149

CREATE TABLE prod (
    prod_id            VARCHAR2(10) NOT NULL,
    prod_name          VARCHAR2(40) NOT NULL,
    prod_lgu           CHAR(4) NOT NULL,
    prod_buyer         CHAR(6) NOT NULL,
    prod_cost          NUMBER(10) NOT NULL,
    prod_price         NUMBER(10) NOT NULL,
    prod_sale          NUMBER(10) NOT NULL,
    prod_outline       VARCHAR2(100) NOT NULL,
    prod_detail        CLOB,
    prod_img           VARCHAR2(40) NOT NULL,
    prod_totalstock    NUMBER(10) NOT NULL,
    prod_insdate       DATE,
    prod_properstock   NUMBER(10) NOT NULL,
    prod_size          VARCHAR2(20),
    prod_color         VARCHAR2(20),
    prod_delivery      VARCHAR2(255),
    prod_unit          VARCHAR2(6),
    prod_qtyin         NUMBER(10),
    prod_qtysale       NUMBER(10),
    prot_mileage       NUMBER(10),
    CONSTRAINT pk_prod PRIMARY KEY ( prod_id ),
    CONSTRAINT fr_prod_lprod FOREIGN KEY ( prod_lgu )
        REFERENCES lprod ( lprod_gu ),
    CONSTRAINT fr_prod_buyer FOREIGN KEY ( prod_buyer )
        REFERENCES buyer ( buyer_id )
);

CREATE TABLE buyprod (
    buy_date   DATE NOT NULL,
    buy_prod   VARCHAR2(10) NOT NULL,
    buy_gty    NUMBER(10) NOT NULL,
    buy_cost   NUMBER(10) NOT NULL,
    CONSTRAINT pk_buyprod PRIMARY KEY ( buy_date,
    buy_prod ),--복합키
    CONSTRAINT fr_buyprod_prod FOREIGN KEY ( buy_prod )
        REFERENCES prod ( prod_id )
);

CREATE TABLE member (
    mem_id         VARCHAR2(15) NOT NULL,
    mem_pass       VARCHAR2(15) NOT NULL,
    mem_name       VARCHAR2(20) NOT NULL,
    mem_regno1     CHAR(6) NOT NULL,
    mem_regno2     CHAR(7) NOT NULL,
    mem_bir        DATE,
    mem_zip        CHAR(7) NOT NULL,
    mem_add1       VARCHAR2(100) NOT NULL,
    mem_add2       VARCHAR2(80) NOT NULL,
    mem_hometel    VARCHAR2(14) NOT NULL,
    mem_comtel     VARCHAR2(14) NOT NULL,
    mem_hp         VARCHAR2(15),
    mem_mail       VARCHAR2(60) NOT NULL,
    mem_job        VARCHAR2(40),
    mem_like       VARCHAR2(40),
    mem_memorial   VARCHAR2(40),
    mem_mileaga    NUMBER(10),
    mem_delete     VARCHAR2(1),
    CONSTRAINT pk_member PRIMARY KEY ( mem_id )
);

CREATE TABLE cart (
    cart_member   VARCHAR2(15) NOT NULL,
    cart_no       CHAR(13) NOT NULL,
    cart_prod     VARCHAR2(10) NOT NULL,
    cart_qty      NUMBER(8) NOT NULL,
    CONSTRAINT pk_cart PRIMARY KEY ( cart_no,
    cart_prod ),
    CONSTRAINT fr_cart_member FOREIGN KEY ( cart_member )
        REFERENCES member ( mem_id ),
    CONSTRAINT fr_cart_prod FOREIGN KEY ( cart_prod )
        REFERENCES prod ( prod_id )
);

CREATE TABLE ziptb (
    zipcode   CHAR(7) NOT NULL, -- 7Byte 
    sido      VARCHAR2(2 CHAR) NOT NULL, --2 글자
    gugun     VARCHAR2(10 CHAR) NOT NULL, --10글자 
    dong      VARCHAR2(30 CHAR) NOT NULL, -- 30 글자 잘안씀 
    bunji     VARCHAR2(10 CHAR),
    seq       NUMBER(5) NOT NULL
);

CREATE INDEX idx_zipcode ON
    ziptb ( zipcode );

--180P
/*
    INSERT : 테이블에 새로운 행을 추가할 때 실행. 
    - 컬럼명과 입력하는 값의 수가 동일해야 함
    - 컬럼명과 입력하는 값의 데이터타입(자료형)이 동일해야 함
    - 기본키와 필수(N.N) 컬럼은 반드시 입력해야 함 
    - 입력되지 않는 컬럼의 값은 널 값이 저장됨
    - 입력되지 않은 컬럼에 기본 값이 선언된 컬럼은 기본 값이 저장됨 
*/

INSERT INTO lprod (
    lprod_id,
    lprod_gu,
    lprod_nm
) VALUES (
    1,
    'P101',
    '컴퓨터제품'
);

INSERT INTO lprod (
    lprod_id,
    lprod_gu,
    lprod_nm
) VALUES (
    2,
    'P102',
    '전자제품'
);

INSERT INTO lprod (
    lprod_id,
    lprod_gu,
    lprod_nm
) VALUES (
    3,
    'P201',
    '여성캐쥬얼'
);

INSERT INTO lprod (
    lprod_id,
    lprod_gu,
    lprod_nm
) VALUES (
    4,
    'P202',
    '남성캐쥬얼'
);

INSERT INTO lprod (
    lprod_id,
    lprod_gu,
    lprod_nm
) VALUES (
    5,
    'P301',
    '피혁잡화'
);

INSERT INTO lprod (
    lprod_id,
    lprod_gu,
    lprod_nm
) VALUES (
    6,
    'P302',
    '화장품'
);

INSERT INTO lprod (
    lprod_id,
    lprod_gu,
    lprod_nm
) VALUES (
    7,
    'P401',
    '음반/CD'
);

INSERT INTO lprod (
    lprod_id,
    lprod_gu,
    lprod_nm
) VALUES (
    8,
    'P402',
    '도서'
);

INSERT INTO lprod (
    lprod_id,
    lprod_gu,
    lprod_nm
) VALUES (
    9,
    'P403',
    '문구류'
);

DELETE FROM lprod;

COMMIT;

--* : 아스트리크 
-- SELECT : 데이터 검색
-- LPORD 테이블의 모든 열과 행을 검색 

SELECT
    *
FROM
    lprod;

SELECT
    lprod_gu --열
   ,
    lprod_nm
FROM
    lprod
WHERE
    lprod_gu <= 'P102'; --행 
--LPROD 테이블의 데이터를 검색
--단, 상품분류코드가 P201 초과인 정보만 검색, 구분코드와 구분명만 보이자

SELECT
    lprod_gu,
    lprod_nm
FROM
    lprod
WHERE
    lprod_gu > 'P201';

SELECT
    lprod_gu,
    lprod_nm
FROM
    lprod
WHERE
    lprod_nm = '전자제품';

--lprod_id가 3인 row를 select하시오.
--lprod_id, lprod_gu, lprod_nm 컬럼을 모두 출력

SELECT
    lprod_id,
    lprod_gu,
    lprod_nm
FROM
    lprod
WHERE
    lprod_id = 3; -- '3' 문자지만 자동 형변환 때문에 실행 된다. 

DESC lprod; -- 자료형 보여주는 코드

--181P
-- LPROD테이블의 LPROD_GU의 값이 P102인 데이터를 검색하여
-- 해당 행의 LPROD_NM 컬럼의 값을 '향수'로 변경함

SELECT
    *
FROM
    lprod
WHERE
    lprod_gu = '102';

UPDATE lprod
    SET
        lprod_nm = '향수'
WHERE
    lprod_gu = 'P102';

COMMIT;

--lprod 테이블을 lprod2 테이블로 복사
--LPROD 테이블의 모든 정보를 LPROD2테이블을
--생성하면서 복제(단, P.K, F.K는 복제가 완됨)

CREATE TABLE lprod2
    AS
        SELECT
            *
        FROM
            lprod;

SELECT
    *
FROM
    lprod2;

--lprod2 테이블의 lprod_gu가 P202인 lprod_nm을
--남성 케쥬얼에서 도서류로 update 하시오

SELECT
    *    -- SELECT 으로 검색 후 업데이트 하기
FROM
    lprod2
WHERE
    lprod_gu = 'P202';

UPDATE lprod2
    SET
        lprod_nm = '도서류'
WHERE
    lprod_gu = 'P202';

COMMIT; --커밋을 해야 데이터 저장.

--lprod2 테이블에서 lprod_id가 7인
--lprod_gu를 P401에서 P303으로 update 하시오.
--먼저 from 까지만 하고 검색 후 찾은다음 조건 써주기

SELECT
    *
FROM
    lprod2
WHERE
    lprod_id = 7



UPDATE LPROD2
SET LPROD_GU = 'P303'
WHERE LPROD_ID = 7;


/*
Delete문
- 테이블의 행을 삭제함
- 모든 행을 삭제할 수도 있고(WHERE절이 없을 때)
    특정 행을 삭제할 수도 있음(WHERE절이 있음)
*/

--DELETE FROM 테이블명
--WHERE 조건;
--LPROD2 테이블에서 LPROD_NM이 화장품인
--데이터를 삭제하시오.
SELECT *
FROM LPROD2
WHERE LPROD_NM = '화장품';

DELETE FROM LPROD2
WHERE LPROD_NM = '화장품';

-- 고정길이, 가변길이
-- char(6)  'a'   where ?? =  'a     ' , 성능좋고, 저장효율 좋고, 사용은 불편
-- varchar(6) 'a' where ?? =  'a'      , 성능좀 나쁘고, 저장효율 좋고, 사용편함


--182P
-- 테이블의 모든 row와 column을 검색
--SELECT * FROM 테이블명;

--상품 테이블로부터 모든 row와 column을 검색하시오
SELECT * FROM PROD;

--회원 테이블로부터 모든 row와 column을 검색하시오 ?
SELECT * FROM MEMBER;
--아스트리크 == *

--장바구니 테이블로부터 모든 row와 column을 검색하시오? 
SELECT * FROM CART;

--상품 테이블로부터 상품코드와 상품명을 검색하시오
SELECT PROD_ID
  , PROD_NAME
FROM PROD;

--1. buyer테이블을 buyer2 테이블로 복사하시오 
-- (P.K, F>K는 복사가 안됨)
CREATE TABLE BUYER2
AS
SELECT * FROM BUYER;

--2. buyer2 테이블의 buyer_id, buyer_name, buyer_lgu
--컬럼을 모두 select 하시오
SELECT buyer_id, buyer_name, buyer_lgu
FROM BUYER2;

--3. buyer2 테이블의 buyer_id가 P30203인 buyer_name
--   값을 거성으로 update하시오
 SELECT * 
 FROM BUYER2
 WHERE BUYER_ID ='P30203';
 
 UPDATE BUYER2
 SET BUYER_NAME='거성'
 WHERE BUYER_ID ='P30203';

--4. buyer2 테이블의 buyer_name이 
--피리어스인 row를 삭제하시오 

SELECT *
FROM BUYER2
WHERE BUYER_NAME='피리어스';

DELETE FROM BUYER2
WHERE BUYER_NAME='피리어스';

/*
산술연산자
 산술연산자를 사용하여 검색되는 자료값 변경
 산술연산식은 COLUMN명, 상수값, 산술연산자로 구성
 산술연산자는 +, -, *, /, () 로구성
 SELECT  산술연산식  FROM 테이블명
*/
SELECT MEM_ID
  , 1004
  , '내일이 지나면..'
  , MEM_NAME
  , MEM_MILEAGE
  , MEM_MILEAGE / 12 AS "월 평균"
FROM MEMBER;
--장바구니 테이블로부터 주문번호, 상품코드,
--회원 ID, 수량을 검색하시오?
SELECT CART_NO, CART_PROD, CART_MEMBER, CART_QTY
FROM CART;
--183P
-- 산술연산자는 +, -, *, /, ()로 구성
-- 회원 테이블의 마일리지를 12로 나눈 값을 검색하시오
-- ROUND : 반올림함수, (,2 : 소수점 2째자리까지 살리고 반올림)
SELECT MEM_MILEAGE
  , MEM_MILEAGE/12
  , ROUND(MEM_MILEAGE/12,2)
  , MEM_MILEAGE+12
  , MEM_MILEAGE-12
  , MEM_MILEAGE*12
FROM MEMBER;
--상품 테이블(PROD)의 상품코드, 상품명, 판매금액을 
--검색 하시오?
--판매금액은  = 판매단가 * 55 로 계산한다.
--상품코드(PROD_ID), 상품명(PROD_NAME), 
--판매단가(PROD_SALE)
SELECT PROD_ID
  ,PROD_NAME
  ,PROD_SALE * 55
FROM PROD;
183.P
--중복 ROW(행)의 제거
--상품 테이블(PROD)의 상품분류(PROD_LGU)를
--중복되지 않게 검색
SELECT DISTINCT PROD_LGU
FROM PROD; 
--DISTINCT : 중복 제거, 예약어
-- 컬럼목록의 맨 앞에 1회 사용
SELECT
    CART_MEMBER,
    CART_PROD
FROM
    cart
ORDER BY 1, 2;
--상품 테이블의 거래처코드를 중복되지
--않게 검색하시오 ?
--(Alias는 거래처)
--거래처코드 : PROD_BUYER
SELECT DISTINCT PROD_BUYER
FROM PROD;
SELECT PROD_BUYER
FROM PROD;
--P.183
--ROW(행)을 SORT(정렬)하고자 하면 ORDER BY 절을 사용
--ASC(Ascending) : 오름차순,ASC는 생략 가능
--  숫자형은 0부터 9, 영문자는 A부터 Z, 한글은 가나다.. 순으로 정렬
--DESC(Descending) : 내림차순
--  숫자형은 9부터 0, 영문자는 Z부터 A, 한글은 하파타.. 순으로 정렬
SELECT MEM_ID  
       , MEM_NAME 
       , MEM_BIR
       , MEM_MILEAGE
FROM  member
ORDER BY MEM_BI DESC;

-- ALIAS(별칭)
/*
    ALIAS?
    SElECT 절과 FROM 절에 사용되는 별명
    1)  SELECT절에서 사용
    - 컬럼 출력 시 부제목으로 사용
    - ORDER BY 절의 출력 순서를 지정시 사용가능
    -EX_AS"회원ID", "회원ID" 회원 ID
    2) FROM 절에서 사용
    -테이블 명을단순화하기 위해 사용
    -SELECT문의 각 절에서 컬럼며을 구분할 때 사용
*/

SELECT MEM_ID  
       , MEM_NAME 
       , MEM_BIR 
       , MEM_MILEAGE
FROM  Member
ORDER BY MEM_BIR ASC;

SELECT 'a나' COL1 FROM DUAL
UNION ALL
SELECT 'A나' FROM DUAL
UNION ALL
SELECT 'a나' FROM DUAL
UNION ALL
SELECT 'B나' FROM DUAL
UNION ALL
SELECT 'b나' FROM DUAL
UNION ALL
SELECT 'B나' FROM DUAL
ORDER BY 1;
SELECT MEM_ID  회원ID
       , MEM_NAME AS"성명"
       , MEM_BIR "생일"
       , mem_mileage 마일리지
FROM member
order by 성명;
--컬럼번호
SELECT MEM_ID  회원ID --1
       , MEM_NAME AS"성명" --2
       , MEM_BIR "생일" --3
       , MEM_MILEAGE 마일리지
FROM MEMBER
ORDER BY 3;
--다중정렬
SELECT MEM_ID 회원ID
   , MEM_NAME 성명
   , MEM_BIR 생일
   , MEM_MILEAGE 마일리지
FROM MEMBER
ORDER BY MEM_MILEAGE, 1; --1 회원 ID를 한번 더 정렬해라 다중정렬
--회원테이블(MEMBER)에서
--MEM_ID(회원ID), MEM_JOB(직업), 
--MEM_LIKE(취미)를 검색하기
--직업으로 오름차순, 취미로 내림차순, 
--회원ID로 오름차순 정렬
SELECT MEM_ID 회원ID
   , MEM_JOB 직업
   , MEM_LIKE 취미
FROM MEMBER
ORDER BY MEM_JOB, 취미 DESC,1 ASC;
--직업(MEM_JOB)이 회사원인 회원의 
--MEM_MEMORIAL 컬럼의 데이터를 
--NULL로 수정하기
--** MEM_MEMORIAL = NULL
--** 조건검색 시 ''(홀따옴표)를 사용함
SELECT *
FROM  MEMBER
WHERE MEM_JOB ='회사원';

UPDATE MEMBER
SET MEM_MEMORIAL = NULL
WHERE MEM_JOB ='회사원';
COMMIT;

--오름차순(NULL은 마지막에 위치)
SELECT MEM_MEMORIAL, MEM_ID FROM MEMBER
ORDER BY MEM_MEMORIAL ASC;
--내림차순 (NULL은 처음에 위치)
SELECT MEM_MEMORIAL, MEM_ID FROm MEMBER
ORDER BY MEM_MEMORIAL DESC;
--상품테이블(PROD)의 전체 컬럼을 검색하는데
--판매가(PROD_SALE)로 내림차순 후, 
--상품분류코드(PROD_LGU)로 오름차순 후
--상품명(PROD_NAME)으로 오름차순 정렬해보자
SELECT * 
FROM PROD
ORDER BY PROD_SALE DESC, PROD_LGU ASC, PROD_NAME;
--ORDER BY PROD_SALE DESC, PROD_LGU, 2;

--상품 중 판매가가 170,000원인 상품 조회
--ALIAS : 상품명, 판매가
SELECT PROD_NAME 상품명
   ,   PROD_SALE 판매가
FROM PROD
WHERE PROD_SALE = 170000; --WHERE 절에서는 컬럼명만 들어가야 된다. ORDER BY는 한글 숫자 됨
--P.185
--상품 중 매입가(PROD_COST)가 
--200,000원 이하인 상품을 검색하시오
--(ALIAS는 상품코드(PROD_ID), 
--상품명(PROD_NAME), 매입가(PROD_COST))
SELECT PROD_ID
,PROD_NAME  --열검색 조건
,PROD_COST  
FROM PROD --테이블
WHERE PROD_COST <= 200000;

--회원 중 76년도 1월 1일 이후에 
--태어난 회원을 검색하시오
--단, 주민등록번호 앞자리로 비교
--(ALIAS는 회원ID(MEM_ID), 
--회원명(MEM_NAME), 
--주민등록번호 앞자리(MEM_REGNO1))
SELECT MEM_ID  
,   MEM_REGNO1 
,   MEM_NAME   
FROM MEMBER
WHERE MEM_REGNO1 > '760101'; -- 숫자형 문자
--185P
--상품 중 삼풍분류가 P201(여성 캐쥬얼)이거나
--판매가가 170,000원인 상품 조회
--거나 / 또는 ->
SELECT PROD_NAME AS 상품
, PROD_LGU AS 상품분류
, PROD_SALE AS 판매가
FROM PROD
WHERE PROD_LGU= 'P201'
OR  PROD_SALE =170000;
--상품 중 상품분류가 P201(여성 캐쥬얼)도 
--아니고 
--판매가가  170,000원도 아닌 상품 조회
--ALIAS : 상품명, 상품분류, 판매가
SELECT PROD_NAME AS 상품
, PROD_LGU AS 상품분류
, PROD_SALE AS 판매가
FROM PROD
WHERE PROD_LGU != 'P201'
and  PROD_SALE !=170000;

--부울대수 식으로 변환
SELECT PROD_NAME AS 상품
, PROD_LGU AS 상품분류
, PROD_SALE AS 판매가
FROM PROD
WHERE NOT PROD_LGU != 'P201'
OR  PROD_SALE !=170000; --and를 or 로 바꾸고 전체 NOT(부정)

--상품 중 판매가가 300,000원 이상, 500,000원 
--이하인 상품을 검색  하시오 ?
--( Alias는 상품코드(PROD_ID), 
--상품명(PROD_NAME), 판매가(PROD_SALE) )
SELECT PROD_LGU AS 상품분류
,   PROD_NAME AS 상품
,   PROD_SALE AS 판매가
FROM PROD
WHERE PROD_SALE >= 300000 
AND  PROD_SALE <= 500000;
--문제 :
--회원(MEMBER) 테이블에서
--직업(MEM_JOB)이 공무원인 인원 중 
--마일리지(MEM_MILEAGE)가 1500 이상인 
--리스트를 검색하시오.
--모든 컬럼을 포함시키기 = *
SELECT *
FROM MEMBER
WHERE MEM_MILEAGE >=1500 AND MEM_JOB='공무원'
ORDER BY MEM_REGNO1;
--상품중 판매가가 150,000원, 170,000원 
-- 330,000원인 상품 조회 
SELECT PROD_NAME
, PROD_SALE
FROM PROD
WhERE PROD_SALE = 150000 
OR PROD_SALE = 170000 
OR PROD_SALE = 330000;
--간단하게
SELECT PROD_NAME
, PROD_SALE
FROM PROD
WHERE PROD_SALE IN(150000,170000,330000);
--회원 테이블에서 ID가 c001, foo1, woo1인 회원만 검색하시오 
--Alias는 회원ID(MEM_ID) 회원명(MEM_NAME)
SELECT MEM_ID
,       MEM_NAME
FROM MEMBER
WHERE MEM_ID IN('c001','f001', 'w001');
--P.186
--상품 분류(LPROD)테이블에서 현재 상품(PROD)테이블에 
--존재하는 분류만 검색(분류코드(LPROD_GU)
--, 분류명(LPROD_NM))
SELECT LPROD_GU 분류코드
   , LPROD_NM 분류명
FROM LPROD
WHERE LPROD_GU NOT IN
    (SELECT DISTINCT  PROD_LGU FROM PROD);

SELECT DISTINCT  PROD_LGU
FROM PROD;
--상품 중 판매가가 100,000원 부터 300,000원
--사이인 상품 조회
--ALIAS : 상품명 판매가
SELECT PROD_SALE AS 상품명
   ,   PROD_NAME AS 판매가
FROM PROD
WHERE PROD_SALE between 100000 AND 300000;

--회원 중 생일이 1975-01-01에서 1976-12-31사이에 
--태어난 회원을 검색하시오 ? 
--( Alias는 회원ID, 회원 명, 생일 )
SELECT MEM_ID 
   , MEM_NAME
   , MEM_BIR
FROM MEMBER
WHERE MEM_BIR BETWEEN '1975-01-01' AND '1976-12-31'; 
--날짜형과 날짜형문자의 비교 시 
--날짜형문자-> 날짜형으로 자동 형변환

-P.186
--상품 중 매입가(PROD_COST)가 300,000~1,500,000이고 
--판매가(PROD_SALE)가  800,000~2,000,000 인 상품을 검색하시오 ?
--( Alias는 상품명(PROD_NAME), 
--매입가(PROD_COST), 판매가(PROD_SALE) )
SELECT PROD_NAME AS 상품명
   ,  PROD_COST AS 매입가
   ,  PROD_SALE AS 판매가 
FROM PROD
WHERE PROD_COST BETWEEN 300000 AND 1500000
AND PROD_SALE BETWEEN 800000 AND 2000000;  
--회원 중 생일이 1975년도 생이 아닌
--회원을 검색하시오 ?
--( Alias는 회원ID, 회원 명, 생일
SELECT  MEM_ID  AS 회원ID
,       MEM_NAME AS 회원명
,        MEM_BIR AS 생일
FROM MEMBER
--WHERE MEM_ID != '1975';
WHERE MEM_ID  NOT BETWEEN  '1975-01-01' AND '1975-12-31';
--P.186
--LIKE 연산자
--LIKE와 함께 쓰이는 %, _ : 와일드카드
--% : 여러글자, _ : 한글자
--삼% : 삼으로 시작하고 뒤에 여러글자가 나옴
SELECT PROD_ID AS 상품코드
,   PROD_NAME   AS 상품명
FROM PROD
WHERE PROD_NAME LIKE '삼%';

SELECT PROD_ID 상품코드
,      PROD_NAME 상품명
FROM PROD
WHERE PROD_NAME LIKE '_성%';

SELECT PROD_ID 상품코드
,      PROD_NAME 상품명
FROM PROD
WHERE PROD_NAME LIKE '%치';

SELECT PROD_ID 상품코드
,      PROD_NAME 상품명
FROM PROD
WHERE PROD_NAME NOT LIKE '%치';

SELECT PROD_ID 상품코드
,      PROD_NAME 상품명
FROM PROD
WHERE PROD_NAME LIKE '%여름%';
--회원 테이블에서 김씨 성을 가진 회원을
--검색하시오?(ALias는 회원 ID(MEM_ID), 성명(MEM_NAME)))
SELECT  MEM_ID 회원ID
,       MEM_NAME 성명
FROM MEMBER
WHERE MEM_NAME LIKE '김%';
--회원테이블의 주민등록번호 앞자리를
--검색하여 1975년생을 제외한
--회원을 검색하시오 ?
--(Alias는 회원ID, 성명, 주민등록번호)
SELECT MEM_ID       회원ID
,      MEM_NAME     성명
,      MEM_REGNO1 || '' || MEM_REGNO2 주민등록번호
FROM MEMBER
WHERE NOT (MEM_REGNO1 LIKE '75%');
--개똥이는 취업기념으로 삼성에서 만든 제품을 구입하고자 한다.
--가격은 100만원 미만이며 가격이 내림차순으로 정렬된 
--리스트를 보고자 한다.
--(ALIAS는 상품ID(PROD_ID), 상품명(PROD_NAME), 
--판매가(PROD_SALE), 제품설명글(PROD_DETAIL))
SELECT PROD_ID 상품ID
,   PROD_NAME   상품명
,   PROD_SALE   판매가
,   PROD_dETAIL 제품설명글
FROM PROD
WHERE PROD_NAME  LIKE '%삼성%'
AND PROD_SALE < 1000000
ORDER BY 3 DESC;

SELECT MEM_ID
,   MEM_NAME
,   MEM_NAME
FROM MEMBER
--193P
--|| : 둘 이상의 문자열을 연결하는 결합연산자
SELECT 'a' || 'bcde' FROM DUAL;
SELECT MEM_ID || 'name is' || MEM_NAME FROM MEMBER;
--CONCAT함수 : 두 문자열을 연결하여 반환
SELECT CONCAT ('My Name is', MEM_NAME) FROM MEMBER;
--CHR: ASCII -> 문자 / ASCII : 문자를 ASCII
SELECT CHR(65) "CHR", ASCII('ABC') 'ASCII' FROM DUAL;
SELECT ASCII(CHR(65)) RESULT FROM DUAL;
SELECT CHR(75) "CHR", ASCII('K') "ASCII" FROM DUAL;
--회원테이블의 회원ID Column의 ASCII 값을 검색하시오?
SELECt MEM_ID
   , ASCII(MEM_ID) AS 회원ASCII
   , CHR(ASCII(MEM_ID)) AS 회원CHR
FROM MEMBER;
--194P
--LOWER : 소문자로 반환
--UPPER : 대문자로 반환
--INITCAP : 첫글자만 대문자로 반환
SELECT LOWER('DATA manipulation Language') AS"LOWER"
       , UPPER('DATA manipulation Language') AS"UPPER"
       , INITCAP('DATA manipulation Language') AS"INITCAP"
FROM DUAL;
--회원 테이블의 회원ID를 대문자로
--변환하여 검색하시오?
-- Alias명은 변환전ID, 변환후ID)
SELECT MEM_ID  AS 변환전ID
       , UPPER(MEM_ID) AS 변환후ID
FROM MEMBER
--194P
SELECT LPAD('Java',10) "LPAD"
SELECT RPAD('Java',10) "RPAD"
FROM DUAL;

SELECT LPAD('Java',10, '*') "LPAD"
SELECT RPAD('Java',10, '') "RPAD"
FROM DUAL;
--P.194
--상품테이블의 소비자가격(PROD_PRICE)과  
--소비자가격을 치환화여 다음과 같이 출력되게 하시오 
--ALIAS : PROD_PRICE  PROD_RESULT(LPAD함수를 통해 처리)
SELECT PROD_PRICE 
   , LPAD(PROD_PRICE, 10, '*') PROD_RESULT
FROM PROD;
--P195
--LTRIM 공백제거 
SELECT    '<' || LTRIM ('          AAA         ') || '>' "LTRIM1"
       , '<' || LTRIM ('Hello World', 'He') || '>' "LTRIM2"
       , '<' || LTRIM ('llo He World', 'He') || '>' "LTRIM3"
       , '<' || LTRIM ('Hello He World', 'He') || '>' "LTRIM4"
       , '<' || LTRIM ('Hello He World      ', 'He') || '>' "LTRIM5"
        --공백이 있으면 못 찾는다. 아래처럼 해야됨
       , '<' || LTRIM (TRIM('      Hello He World'), 'He') || '>' "LTRIM6"
FROM DUAL;
--RTRIM /RTRIM (대상문자열, 찾을문자열)
SELECT    '<' || RTRIM ('          AAA         ') || '>' RTRIM1
       , '<' || RTRIM ('Hello World', 'ld') || '>' RTRIM2
       , '<' || RTRIM ('llo He World', 'He') || '>' RTRIM3
       , '<' || RTRIM ('Hello He World', 'He') || '>' RTRIM4
       , '<' || REPLACE ('Hello He World      ', 'He') || '>' RTRIM5
--SYS.DUAL 가상의 테이블  SYS소유
FROM DUAL;
--TRIM : L+R
SELECT '<' || TRIM ('          AAA         ') || '>' TRIM1
        --LEADING 앞 
       , '<' || TRIM (LEADING 'a' FROM TRIM('    aaAaBaAaa')) || '>' TRIM2
       , '<' || TRIM ('a' FROM 'aaAaBaAaa') || '>' TRIM3
        --BOTH 양방향 BOTH == 생략 
       , '<' || TRIM (BOTH 'a' FROM 'aaAaBaAaa') || '>' TRIM4
        --TRAIL 뒤
       , '<' || TRIM (TRAILING 'a' FROM 'aaAaBaAaa') || '>' TRIM5
FROM SYS.DUAL;
--195
-- SUBSTR 중요 문자열의 일부분을 선택  
--SUBSTR(' ', 1:시작점 ex S,3:문자 ex SQL)
--*****
SELECT SUBSTR('SQL PROJECT',1,3)  AS RESULT1
    , SUBSTR('SQL PROJECT',5)    AS RESULT2
    , SUBSTR('SQL PROJECT',-7,3) AS RESULT3 --M이 음수이면 뒤쪽에서부터 처리
FROM   DUAL;

/
--회원테이블의 성씨 조회
SELECT MEM_ID               AS 회원ID
    , MEM_NAME
    , SUBSTR(MEM_NAME,1,1) AS 성씨
FROM   MEMBER;
--상품테이블의 상품명(PROD_NAME)의 
--4째 자리부터  2글자가
--'칼라' 인 상품의 상품코드(PROD_ID), 
--상품명(PROD_NAME)을 검색하시오 ?
--( Alias명은 상품코드(PROD_ID), 상품명(PROD_NAME) )
SELECT PROD_ID      AS 상품코드
      , PROD_NAME  AS 상품명
FROM  PROD
WHERE SUBSTR(PROD_NAME,4,2)= '칼라'
-- %는 뒤에 여러문자 -는 임의 한글자 
AND PROD_NAME LIKE '___칼라%';

--P.196
--P102000001 : 상품코드
--P102       : 대분류
--000001     : 순번
--상품테이블의 상품코드(PROD_ID)에서 왼쪽4자리, 
--오른쪽6자리를 검색하시오 ?
--(Alias명은 상품코드(PROD_ID),  대분류,  순번)
SELECT PROD_ID
   ,  SUBSTR(PROD_ID,1,4)
   ,  SUBSTR(PROD_ID,-6)
FROM PROD;
-- REPLACE 문자나 문자열 치환 
SELECT  REPLACE ('SQL Project', 'SQL', 'SSQQLL')  AS 문자치환1
      , REPLACE ('Java Flex Via', 'a') AS 문자치환2 
      , RTRIM('Java Flex Vai', 'a')   AS 문자치환3
FROM DUAL;
--거래처 테이블의 거래처명 중 '삼' -> '육으로' 치환
SELECT BUYER_NAME, REPLACE(BUYER_NAME, '삼', '육') 
FROM BUYER;
--회원테이블의 회원성명 중 '이' -> '리'로 치환 검색하시오
SELECT MEM_NAME, REPLACE(MEM_NAME, '이', '리')
FROM MEMBER;
--P.196
--INSTR('hello heidi', 'he',1,2)
--INSTR('대상문자열', '찾을문자열',시작위치, 번째)
-- 1 첫 번째 글자부터 he를 찾음
-- 2 두 번째
SELECT INSTR('I have a hat','ha',1,1) AS RESULT1
   ,  INSTR('I have a hat', 'ha',1,2) AS RESULT2
FROM DUAL;
--문제 : I have a hat that i had have been found 
--      that hat before 2 years ago.
--1. 상위 문장에서 5번째 ha의 위치를 출력
--INSTR(c1 ,c2, [m, [n]]) : m에서 시작해서 n번째의 c2의 위치를 출력
SELECT INSTR('I have a hat that i had have been found that hat before 2 years ago.','ha',1,5)
FROM DUAL;
--문제
--mepch@test.com
--상위 문자에서 @를 기준으로 다음과 같이 출력하기
--아이디 | 도메인
--------------------
--mepch  | test.com
SELECT REPLACE('mepch@test.com','@',' | ')  AS 아이디
SELECT SUBSTR('mepch@test.com',1,5) 아이디
   ,  SUBSTR('mepch@test.com',7) 도메인
    --, INSTR('mepch@test.com', '@')
FROM DUAL;

SELECT MEM_ID       회원ID
,      MEM_NAME     회원명
,      SUBSTR(MEM_MAIL, 1, INSTR(MEM_MAIL, '@')-1) 아이디
,      SUBSTR(MEM_MAIL, INSTR(MEM_MAIL, '@')+1) 도메인
FROM MEMBER;
--197P
-- LENGTH: 글자수, LENGTHB : 글자의 BYTES
-- 영문자/특수기호 : 1BYTE, 한글 : 3BYTES
SELECT LENGTH('SQL 프로젝트') LENGTH
   , LENGTHB('SQL 프로젝트') LENGTHB
FROM DUAL;

SELECT BUYER_ID     AS 거래처코드
,      LENGTH(BUYER_ID) AS 거래처코드길이
,      BUYER_NAME   AS 거래처명
,      LENGTH(BUYER_NAME)   AS 거래처명길이
,      LENGTHB(BUYER_NAME)  AS 거래처명byte수
FROM BUYER;
--P.197
SELECT ABS(-365) FROM DUAL; --365
--SIGN : 양수 (1), 0(0), 음수(-1)
SELECT SIGN(12), SIGN(0), SIGN(-55) FROM DUAL;
--3의2승, 2의 10승
SELECT POWER(3,2), POWER(2, 10) FROM DUAL;
--제곱근
SELECT SQRT(2), SQRT(9) FROM DUAL;

--197P
SELECT GREATEST(10, 20, 30) 가장큰값
,      LEAST(10, 20, 30)    가장작은값
FROM DUAL;

--숫자보다 한글이 큼
--P.197
SELECT GREATEST(10, 20, 30) 가장큰값
    , LEAST(10, 20, 30)    가장작은값
FROM   DUAL;
   
--숫자보다 한글이 큼
SELECT GREATEST('강아지', 256, '송아지') 가장큰값
    , LEAST('강아지', 256, '송아지')    가장작은값
FROM   DUAL;

--P.198
--회원(MEMBER) 테이블에서 회원이름(MEM_NAME),  
--마일리지(MEM_MILEAGE)를 출력하시오
--(단, 마일리지가 1000보다 작은 경우 1000으로 변경) 
SELECT MEM_NAME         AS 회원이름
,     GREATEST(MEM_MILEAGE,1000)      AS 마일리지
FROM MEMBER
--내가 푼 것
--SELECT MEM_NAME         AS 회원이름
--,      MEM_MILEAGE      AS 마일리지
--FROM MEMBER
--WHERE GREATEST(MEM_MILEAGE, 1000,)

--P198
--ROUND : 반올림, TRUNC : 버림
-- 2 : 소수점 둘째자리까지 살리고
-- -2 : 둘째자리에서 반올림
SELECT ROUND(345.123, -2) 결과 FROM DUAL;
SELECT ROUND(345.123, -1) 결과 FROM DUAL;
SELECT ROUND(345.523, 0) 결과 FROM DUAL;
SELECT ROUND(345.123, 2) 결과 FROM DUAL;
--양수면 살리고, 음수면 에서
SELECT TRUNC(345.123, 0) 결과 FROM DUAL;
SELECT TRUNC(345.123, 1) 결과 FROM DUAL;
SELECT TRUNC(345.123, 2) 결과 FROM DUAL;
SELECT  ROUND(345.123, -1) 결과1
   ,   TRUNC(345.123, -1) 결과2
FROM DUAL;
--회원테이블의 마일리지를 12로 나눈 값을 검색 
--소수 2째자리 살리기 반올림, 절삭
SELECT MEM_MILEAGE / 12
,      ROUND(MEM_MILEAGE / 12, 2) 반올림
,      TRUNC(MEM_MILEAGE / 12, 2) 절삭
FROM MEMBER;--P.198
--상품테이블의 상품명, 원가율( 매입가 / 판매가 )을  비율(%)로
--(반올림 없는 것과 소수 첫째자리 살리기 반올림 비교) 검색하시오 ?
--(Alias는 상품명, 원가율1, 원가율2)
SELECT PROD_NAME  상품명
,      ROUND(PROD_COST / PROD_SALE*100, 1) 원가율1
,      PROD_COST / PROD_SALE*100 원가율2
FROM PROD;
--P.198
-- int nameuji = 10 % 3;
SELECT MOD(10, 3) FROM DUAL;
--회원테이블(MEMBER)의 마일리지를 12로 나눈 나머지를 구하시오
--ALIAS는 회원ID(MEM_ID), 회원명(MEM_NAME), 
--마일리지원본(MEM_MILEAGE), 마일리지결과(MEM_MILEAGE)
SELECT MEM_ID 회원
,      MEM_NAME 회원명
,      MEM_MILEAGE 마일리지원본
,      MOD(MEM_MILEAGE,12) 마일리지결과
FROM MEMBER;
--P198
--FLOOR: 내림(마룻바닥)
--CEIL : 올림(천장)
SELECT FLOOR(1332.69), CEIL(1332.69) FROM DUAL;
SELECT FLOOR(-1332.69), CEIL(-1332.69) FROM DUAL;
SELECT FLOOR(2.69), CEIL(2.69) FROM DUAL;
SELECT FLOOR(-2.69), CEIL(-2.69) FROM DUAL;
--문제
--  -3.141592의 내림(FLOOR)과 올림(CEIL)을 구하시오
--ALIAS : 원본, 내림, 올림
SELECT -3.141592        원본
    , FLOOR(-3.141595) 내림
    , CEIL(-3.141595) 올림
FROM DUAL;
--P199
--SYSDATE *****
--시스템날짜의 연-월-일 시:분:초
SELECT SYSDATE FROM DUAL;
--시스템날짜의 연-월-일 시:분:초.1000분의1초
SELECT SYSTIMESTAMP FROM DUAL;
--ㅖ.199
SELECT TO_CHAR(SYSDATE, 'YYY-MM-DD HH:MI : SS') 현재시간
,       SYSDATE - 1 AS "어제 이시간"
,       SYSDATE + 1 AS "내일 이시간"
,       TO_CHAR(SYSDATE + 1/24, 'YYYY-MM-DD HH:MI:SS') 한시간후
,       TO_CHAR(SYSDATE + 1/(24*60), 'YYYY-MM-DD HH:MI:SS') 일분후
FROM DUAL;
--P.199
--회원테이블(MEMBER)의 생일과 
--12000일째 되는 날을 검색하시오 ?
--(Alias는 회원명(MEM_NAME), 
--생일(MEM_BIR), 12000일째)
SELECT MEM_NAME AS 회원명
,       MEM_BIR AS 생일
,       MEM_BIR + 12000 "12000일째"--AS는 문자형이어야 한다. 
,       TO_CHAR(MEM_BIR + 12000, 'YYYY-MM-DD HH:MI:SS AM')
FROM MEMBER;
SELECT TO_DATE('1997-07-13') 내생일 --날짜에서 * / 안됨 + - 됨
,      ROUND(- TO_DATE('1997-07-13'),1) 내인생
FROM DUAL;
--교수님 시간 표시의 경우 오전 오후(AM, PM, A.M., P.M.)가 표시되거나
--24시간 형식(HH24)으로 출력되게는 할 수 없는 걸까요...?

--문제 : 나는 몇 일을 살았는가? TO_DATE('2015-04-10')함수 이용
--단, 밥은 하루에 3번을 먹음.
--      소수점 2째자리까지 반올림하여 처리하시오.
--ALIAS : 내생일, 산일수, 밥먹은수, 
--밥먹은비용(한끼에 3000원으로 처리)
SELECT TO_DATE('1997-07-13') 내생일 
, ROUND(SYSDATE - TO_DATE('1997-07-13'),1) 내인생
, ROUND(SYSDATE-TO_DATE('1997-07-13'))*3  밥먹은수
, ROUND(SYSDATE-TO_DATE('1997-07-13'))*3*3000  밥먹은비용
FROM DUAL;
--P.199
--월을 더한 날짜
--오늘부터 5월후의 날짜
SELECT ADD_MONTHS(SYSDATE, 5) FROM DuAL;
--NEXT_DAY() : 가장 빠른 요일의 날짜
--LAST_DAY() : 월의 마지막날짜
SELECT NEXT_DAY(SYSDATE, '월요일')
, NEXT_DAY(SYSDATE, '금요일')
, LAST_DAY(SYSDATE)
FROM DUAL;
--이번달이 며칠이 남았는지 검색하시오 
--ALIAS : 오늘날짜, 이달마지막날짜, 이번달에남은 날짜
SELECT SYSDATE      오늘날짜
, LAST_DAY(SYSDATE)   이달마지막날짜       
, LAST_DAY(SYSDATE) -  SYSDATE 이번달남은날짜
FROM DUAL;

--P200
--날짜 ROUND / TRUNC
--FMT(FORMAT : 형식) : YEAR(연도) MONTH(월), DAY(요일), DD(일)
SELECT ROUND(SYSDATE, 'MM') -- 이번달 50%를 넘엇으므로 7월1일
   ,   TRUNC(SYSDATE, 'MM') -- 이번달 50%를 넘었지만 버려서 6월 1일
FROM DUAL;

SELECT ROUND(SYSDATE, 'YEAR')
   ,   TRUNC(SYSDATE, 'YEAR')
FROM DUAL;
--P200
--MONTHS_BETWEEN : 두 날짜 사이의 달수를 숫자로 리턴
SELECT MONTHS_BETWEEN(SYSDATE, '1996-05-29')
,      MONTHS_BETWEEN(SYSDATE, '1977-04-09')
FROM DUAL;
--p 200
--EXTRACT : 날짜에서필요한 부분만 추출
--(FMT : YEAR(년), MONTH(월), DAY(일), HOUR(시), MINUTE(분), SECOND(초)
SELECT EXTRACT(YEAR FROM SYSDATE) 년도
,      EXTRACT(MONTH FROM SYSDATE) 월
,      EXTRACT(DAY FROM SYSDATE) 일
,      EXTRACT(HOUR FROM SYSTIMESTAMP)-3 시
,      EXTRACT(MINUTE FROM SYSTIMESTAMP) 분
,      EXTRACT(SECOND FROM SYSTIMESTAMP) 초
FROM DUAL;
--연-월-일 시:분:초,밀리세컨드
SELECT TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH:MI:SS.FF3')
FROM DUAL;
--생일이 3월인 회원을 검색하시오
--(ALIAS : 회원ID(MEM_ID), 
-- 회원명(MEM_NAME), 생일(MEM_BIR))
SELECT MEM_ID  회원ID
,      MEM_NAME 회원명
,      MEM_BIR 생일
,      EXTRACT(MONTH FROM MEM_BIR)
FROM MEMBER
--숫자
WHERE EXTRACT(MONTH FROM MEM_BIR) =3;
--문자
AND MEM_BIR LIKE '%/03/%'
--문자
AND SUBSTR(MEM_BIR, 4, 2) = '03';
--문제
--입고상품(BUYPROD) 중에 3월 에 입고된 내역을 검색하시오
--ALIAS : 상품코드(BUY_PROD), 입고일자(BUY_DATE)
--, 매입수량(BUY_QTY), 매입단가(BUY_COST)
--EXTRACT 사용하기, SUBSTR 사용하기, LIKE 사용하기
SELECT BUY_PROD  상품코드
,      BUY_DATE  입고일자
,      BUY_QTY   매입수량
,      BUY_COST  매입단가
FROM  BUYPROD
WHERE EXTRACT(MONTH FROM BUY_DATE) =3
AND SUBSTR(BUY_DATE, 4,2)='03'
AND BUY_DATE LIKE '%/03/%';
--P201
--CAST : 명시적 형 변환 
SELECT '[' || 'HELLO' || ']' "형변환"
   ,   '[' || CAST('Hello' AS CHAR(30)) || ']' 고정길이문자형변환
   ,   '[' || CAST('Hello' AS VARCHAR2(30)) || ']' 가변길이문자형변환
FROM DUAL;
--***
--TO_DATE() 문자를 날짜형으로 형변환
--CAST() 날짜형 문자를 지정된 형으로 형변환
--2022/05/17 +1 : 날짜형문자 + 숫자 시 => 날짜형 문자가 숫자로 자동형변환
SELECT '2022/05/17'
,       to_date('2022/05/17') + 1
,       CAST('2022/05/17' AS DATE) + 1
FROM DUAL;
--P.201
-- TO_CHAR() : 숫자/날짜를 지정한 형식의 문자열로 반환
-- 오늘 날짜를 이러한 형식의 문자열로 반환
SELECT TO_CHAR(SYSDATE, 'AD YYYY, CC"세기"')
FROM DUAL;
--오류 발생
SELECT TO_CHAR('2008-12-25', 'YYYY.MM.DD HH24:MI:SS')
FROM DUAL;
--******
-- TO_DATE :  2008-12-25는 연월일 형식인 날짜형 문자라고 라클이에게 알려줌
SELECT TO_CHAR(TO_DATE('2008-12-25'), 'YYYY.MM.DD HH24:MI:SS')
FROM DUAL;

SELECT TO_CHAR(CAST('2008-12-25' AS DATE), 'YYYY.MM.DD HH24:MI:SS')
FROM DUAL;
--P.202
--상품테이블에서 상품입고일을 '2008-09-28 12:00:00' 
--형식으로 나오게 검색하시오.
--(Alias 상품명(PROD_NAME), 상품판매가(PROD_SALE)
--, 입고일(PROD_INSDATE))
SELECT PROD_NAME  상품명
,      PROD_SALE  상품판매가
,      PROD_INSDATE  입고일
,      TO_CHAR(PROD_INSDATE, 'YYYY-MM-DD HH:MI:SS') 상품입고일
FROM PROD;
--어려운문제
--장바구니 테이블을 사용하여 다음처럼 출력해보자
--ALIAS : 장바구니 번호, 구매일시,
--구매일시는 '2005-04-03 12:00:00:' 형식으로 출력
SELECT CART_NO 장바구니번호
   , TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8),'YYYYMMDD'), 'YYYY-MM-DD HH:MI:SS') 구매일시
FROM CART;
--쉬운문제
--회원 테이블을 사용하여 다음처럼 출력해보자 
--ALIAS : 회원ID(MEM_ID), 회원명(MEM_NAME), 회원생일(MEM_BIR)
--회원생일은 '1985-03-02 12:00:00' 형식으로 출력
SELECT MEM_ID  회원ID
,      MEM_NAME  회원명
,      MEM_BIR   회원생일
,      TO_CHAR(MEM_BIR, 'YYYY-MM-DD HH:MI:SS AM') 회원생일날짜
FROM MEMBER;
--YY: 2자리연도, HH 24시간형식

--P 202
-- TO CHAR 함수 중 숫자를 문자로 형변환
SELECT 1234.6+0.4 FROM DUAL;

SELECT TO_CHAR(1234.6, 'L9,999.00')
FROM DUAL;
SELECT TO_CHAR(-1234.6, 'L9999.00PR')
     , TO_CHAR(-1234.6, 'L9999.00MI')
FROM DUAL;

SELECT TO_CHAR(255, 'xxx')FROM DUAL;
SELECT * FROM PROD;
--문제
--상품 판매가를 다음과 같은 형식으로 출력하시오
--￦230,000
--ALIAS : 상품ID(PROD_ID), 상품명(PROD_NAME)
--, 판매가(PROD_SALE)
SELECT  PROD_ID     상품ID
,       PROD_NAME   상품명
,       TRIM(TO_CHAR(PROD_SALE, 'L999,999,999'))   판매가
FROM PROD;
--P.203
--상품테이블에서 상품코드, 상품명, 매입가격, 
-- 소비자가격, 판매가격을 출력하시오. 
-- (단, 가격은 천단위 구분 및 원화표시)
SELECT PROD_ID      상품코드
,      PROD_NAME    상품명
,      TRIM(TO_CHAR(PROD_SALE, 'L999,999,999')) 매입가격
,      TRIM(TO_CHAR(PROD_PRICE, 'L999,999,999'))   소비자가격
,      TRIM(TO_CHAR(PROD_COST, 'L999,999,999'))    판매가
FROM PROD;
--문제
--매입테이블(BUYPROD)의 매입가의 평균
--AVG(BUY_COST)을 다음 형식으로 출력
--소수점 2번째 자리까지 살리고 살리고~ 반올림처리
--￦210,000.350
--원표시 : ㄹ + 한자키
SELECT TO_CHAR(ROUND(AVG(BUY_COST),2), 'L999,999,999')
FROM BUYPROD;
--203
--TO_NUMBER : 숫자형식의 문자열 -> 숫자로 반환

--숫자형 문자 o -> 숫자형변환
SELECT '3.1415' + 1 FROM DUAL;
-- 문자 X -> 숫자형 변환 X
SELECT TO_NUMBER('3.1415') FROM DUAL;
-- 문자 X -> 숫자형 변환 X
SELECT TO_NUMBER('￦1,200') + 1 FROM DUAL;
-- 정답 형식으로 오라클에게 알려주는 것 
SELECT TO_NUMBER('￦1,200', 'L999,999') + 1 FROM DUAL;
--이런 형식으로 출력
SELECT TO_CHAR('1200', 'L999,999') FROM DUAL;

SELECT TO_NUMBER('개똥이') + 1 FROM DUAL;
--P.203
--회원테이블(MEMBER)에서 이쁜이회원(MEM_NAME='이쁜이')의
--회원Id 2~4 문자열을 숫자형으로 치환한 후 
--10을 더하여 새로운 회원ID로 조합하시오 ?
--(Alias는 회원ID(MEM_ID), 조합회원ID)
SELECT MEM_ID 회원ID
,      SUBSTR(MEM_ID,1,1)
||      TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MEM_ID,2)) + 10, '000'))
FROM MEMBER
WHERE MEM_NAME='이쁜이';
--상품테이블(PROD)에서
--상품코드(PROD_ID)가 'P101000001'인 데이터를
--다음과같이 1 증가시켜보자. 
--P101000002
--ALIAS : 상품코드, 다음상품코드
--문자와 숫자가 만나면 숫자로 자동 형변환 된다.
SELECT PROD_ID 상품코드
,      SUBSTR(PROD_ID,1,4)
||      TRIM(TO_CHAR(SUBSTR(PROD_ID,5) + 1, '000000')) 다음상품코드
FROM PROD;
--P.203
--TO_DATE : 날짜형식의 문자열을 DATE형으로 반환
--문자라 첫 번째는 안된다.
SELECT '2009-03-05' + 3 FROM DUAL;
SELECT TO_DATE('2009-03-05') + 3 FROM DUAL;
SELECT TO_DATE('2009-03-05', 'YYYY--MM--DD') + 3 FROM DUAL;

--문(TO_CHAR)날(대상)날(형식) O
--문문날 X
--문숫날 X
--X
SELECT TO_CHAR('200803101234', 'YYYY-MM-DD HH24:MI')
FROM DUAL;
-- O
SELECT TO_DATE('2008-03-10') + 3 FROM DUAL;
-- X
SELECT TO_DATE('200803101234') + 3 FROm DUAL;
-- 라클이한테 알려줌
SELECT TO_CHAR(TO_DATE('200803101234', 'YYYYMMDDHHMI') + 3, 'YYYY-MM-DD HH24:MI')
FROM DUAL;
-- O
SELECT TO_CHAR(TO_DATE('200803101234', 'YYYY-MM-DD HH:MI'), 'YYYYMMDDHH24MI')
FROM DUAL;

--(O)
SELECT TO_DATE('20220621') FROM DUAL;
--(X)
SELECT TO_DATE('202206211619') FROM DUAL;
--(O)
SELECT TO_DATE('2022-06-21') FROM DUAL;
--(X)
SELECT TO_DATE('2022-06-21 16:19') FROM DUAL;
--(O)
SELECT TO_DATE('2022-06-21 16:19','YYYY-MM-DD HH24:MI') FROM DUAL;

--(O) : 날짜형문자이므로.(년.월.일 / 년/월/일 / 년-월-일)
SELECT TO_DATE('2021.12.25') FROM DUAL;
--(X) : 11:10 때문에 인식 안됨
SELECT TO_DATE('2021.12.25 11:10') FROM DUAL;
--(O) : 이럴 땐 라클이에게 알려줘야 함
SELECT TO_DATE('2021.12.25 11:10','YYYY.MM.DD HH:MI') FROM DUAL;
--(O) : 날짜형문자이므로.(년.월.일 / 년/월/일 / 년-월-일)
SELECT TO_DATE('2021/12/25') FROM DUAL;
--(X) : '2021/12/25'는 날짜형문자이므로
SELECT TO_CHAR(' 2021/12/25','YYYY/MM/DD') FROM DUAL;
--(O) : TO_DATE('2021/12/25')는 날짜형이므로 
--날짜형문자 '2021/12/25' 날짜형 2002/02/15
SELECT TO_CHAR(TO_DATE('2021/12/25'),'YYYY/MM/DD') FROM DUAL;
--SELECT TO_CHAR(동그라미, 'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(TO_DATE('2021.12.25 11:10','YYYY.MM.DD HH:MI'),'YYYY/MM/DD') FROM DUAL;

--P.204
--회원테이블(MEMBER)에서 주민등록번호1(MEM_REGNO1)을
--날짜로 치환한 후 검색하시오
--(Alias는 회원명(MEM_NAME), 주민등록번호1, 
--치환날짜(MEM_REGNO1 활용)

SELECT MEM_NAME     회원명
,      MEM_REGNO1   주민등록번호
,      TO_CHAR(TO_DATE(MEM_REGNO1), 'YYYY-MM-DD') 주민등록번호
FROM MEMBER;

--2022.06.22
--장바구니 테이블(CART)에서 장바구니번호(CART_NO)를
--날짜로 치환한 후 다음과 같이 출력하기
--2005년 3월 14일
--ALIAS : 장바구니번호, 상품코드, 판매일, 판매수
SELECT  CART_NO 장바구니번호
,       CART_PROD 상품코드
,       TRIM(TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8),'YYYYMMDD'), 'YYYY-MM-DD')) 상품날짜
,       CART_QTY 판매수
FROM CART;

SELECT CART_NO 장바구니번호
    , CART_PROD 상품코드
    , TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8),'YYYYMMDD'),'YYYY"년 "MONDD"일"') 판매일
    , CART_QTY 판매수
FROM   CART;
--P.205
--거래처테이블에서 거래처명, 담당자 조회
SELECT BUYER_NAME 거래처명
,      BUYER_CHARGER 담당자
FROM    BUYER;
--***NULL 중요***
--거래처 담당자 성씨가 '김'이면 NULL로 갱신
SELECT BUYER_NAME 거래처명
,      BUYER_CHARGER 담당자
FROM BUYER
WHERE BUYER_CHARGER LIKE '김%';

UPDATE BUYER 
SET BUYER_CHARGER = NULL
WHERE BUYER_CHARGER LIKE '김%'; --와일드카드 
--거래처 담당자 성씨가 '성'이면 White Space로 갱신
--White Space : '' = null
SELECT BUYER_NAME 거래처명
,      BUYER_CHARGER 담당자
FROM BUYER
WHERE BUYER_CHARGER LIKE '성%';

UPDATE BUYER
SET BUYER_CHARGER = ''
WHERE BUYER_CHARGER LIKE '성%';
--담당자가 NULL인 데이터를 검색 
SELECT BUYER_NAME 거래처
, BUYER_CHARGER 담당자
FROM BUYER
WHERE BUYER_CHARGER IS NULL;
--담당자가 NULL이 아닌 데이터를 검색
SELECT BUYER_NAME 거래처
, BUYER_CHARGER 담당자
FROM BUYER
WHERE BUYER_CHARGER IS NOT NULL;
--해당 컬럼이 NULL일 경우에 대신할 문자나 숫자 치환
--1) NULL이 존재하는 상태로 조회
SELECT BUYER_NAME 거래처명
,      BUYER_CHARGER 담당자
FROM BUYER;
--***NVL 중요*** 
--2) NVL을 이용 NULL값일 경우만 없다로 치환
SELECT BUYER_NAME 거래처명
,      NVL(BUYER_CHARGER, '없다') 담당자 
FROM BUYER;

--P.206
--전체회원 마일리지에 100을 더한 수치를 검색
--ALIAS : 성명, 마일리지, 변경마일리지
SELECT MEM_NAME 성명
,      MEM_MILEAGE  마일리지
,      MEM_MILEAGE + 100    변경마일리지
FROM MEMBER;
--회원 성씨가 ㅂ 을 포함하면 NULL로 갱신
SELECT MEM_NAME 성명
,      MEM_MILEAGE 마일리지
FROM MEMBER
WHERE MEM_NAME >= '바' AND MEM_NAME <= '빟';

UPDATE member 
SET mem_mileage = NULL
WHERE MEM_NAME >= '바' AND MEM_NAME <= '빟';
--회원 마일리지에 100을 더한 수치를 검색하시오 
--NVL 사용 AILAS 성명 마일리지 변경 마일리지
SELECT MEM_NAME 성명
,      MEM_MILEAGE  마일리지
,      NVL(MEM_MILEAGE, 0)+100 변경마일리지
FROM MEMBER
--회원 마일리지가 있으면 '정상회원', NULL이면 '비정상회원' 으로 검색하시오?
SELECT MEM_NAME 성명
,      MEM_MILEAGE  마일리지
,      NVL2(MEM_MILEAGE, '정상회원','비정상회원')    회원상태
FROM MEMBER
--207
SELECT NULLIF(123, 123)     AS "같을 경우 NULL반환"
,      NULLIF(123, 1234)     AS "다른경우 앞인수반환"
,      NULLIF('A', 'B')     AS "다른경우 앞인수반환"
FROM DUAL;

--코어ㄹ즈 : 파라미터 중 NULL이 아닌 첫 번째 파라미터 반환
SELECT COALESCE(Null, Null, 'Hello', Null, 'World')
FROM DUAL;
--3 비교대상
-- 'D' : ELSE 
SELECT DECODE(3
           , 10, 'A'
           , 9, 'B'
           , 8, 'C'
           , 'D')
FROM DUAL;

SELECT PROD_LGU 상품분류코드 
,      SUBSTR(prod_lgu, 1, 2)  
,      DECODE(SUBSTR(prod_lgu, 1, 2)
            , 'P1', '컴퓨터/전자 제품' 
            , 'P2', '의류'
            , 'P3', '잡화'
            , '기타') 
FROM PROD;
--P.208
--상품 분류(PROD_LGU) 중  앞의 두 글자가  'P1' 이면 
--판매가(PROD_SALE)를 10%인상하고
--'P2' 이면 판매가를 15%인상하고,  
--나머지는 동일 판매가로 
--검색하시오 ? 
--(DECODE 함수 사용, 
--Alias는 상품명(PROD_NAME), 판매가(PROD_SALE), 변경판매가 )
--중요
SELECT PROD_NAME   상품명
,      PROD_SALE   판매가
,      SUBSTR(PROD_lgu, 1 ,2)   
,      DECODE(SUBSTR(PROD_lgu,1,2)
           ,'P1', PROD_SALE * 1.1
           ,'P2', PROD_SALE * 1.15
           ,PROD_SALE)    변경판매가
FROM PROD;
--대전측기사에서는 3월에 생일인(MEM_BIR) 회원을
--대상으로 마일리지를 10% 인상해주는 이벤트를
--시행하고자 한다. 생일이 3월이 아닌 회원은
--짝수인 경우만 5% 인상 처리한다.
--이를 위한 SQL을 작성하시오.
--ALIAS : 회원ID, 회원명, 마일리지, 변경마일리지
SELECT  MEM_ID  회원ID
,       MEM_NAME    회원명
,       MEM_MILEAGE 마일리지
,       EXTRACT(MONTH FROM MEM_BIR)
,       DECODE(EXTRACT(MONTH FROM MEM_BIR)
       ,3, MEM_MILEAGE * 1.1
       ,DECODE(MOD(EXTRACT(MONTH FROM MEM_BIR),2)
       ,0, MEM_MILEAGE * 1.05
       ,MEM_MILEAGE)
    )변경마일리지
FROM MEMBER;
MOD(10, 3)
EXTRACT(MONTH FROM MEM_BIR)=3
--P208
SELECT CASE WHEN '나' = '나' THEN '맞다'
        ELSE '아니다'
        END AS "RESULT"
FROM DUAL;
SELECT PROD_NAME 상품, PROD_LGU 분류,
    CASE WHEN PROD_LGU = 'P101' THEN '컴퓨터제품'
         WHEN PROD_LGU = 'P102' THEN '전자제품'
         WHEN PROD_LGU = 'P201' THEN '여성캐쥬얼'
         WHEN PROD_LGU = 'P202' THEN '남성캐쥬얼'
         WHEN PROD_LGU = 'P301' THEN '피혁잡화'
         WHEN PROD_LGU = 'P302' THEN '화장품'
         WHEN PROD_LGU = 'P401' THEN '음반/CD'
         WHEN PROD_LGU = 'P402' THEN '도서'
         WHEN PROD_LGU = 'P403' THEN '문구류'
         ELSE '미등록분류'
        END 상품분류
FROM PROD;
--10만원 초과 상품 판매가 가격대를 검색하시오
SELECT PROD_NAME AS 상품
,      PROD_PRICE AS 판매가
,      CASE WHEN(100000 - PROD_PRICE) >= 0 THEN '10만원 미만'
           WHEN(200000 - PROD_PRICE) >= 0 THEN '10만원대'
           WHEN(300000 - PROD_PRICE) >= 0 THEN '20만원대'
           WHEN(400000 - PROD_PRICE) >= 0 THEN '30만원대'
           WHEN(500000 - PROD_PRICE) >= 0 THEN '40만원대'
           WHEN(600000 - PROD_PRICE) >= 0 THEN '50만원대'
           WHEN(700000 - PROD_PRICE) >= 0 THEN '60만원대'
           WHEN(800000 - PROD_PRICE) >= 0 THEN '70만원대'
           WHEN(900000 - PROD_PRICE) >= 0 THEN '80만원대'
           WHEN(1000000 - PROD_PRICE) >= 0 THEN '90만원대'
            ELSE '100만원이상'
        END "가격대"
        FROM PROD
        WHERE PROD_PRICE > 100000;
            
--회원정보테이블의 주민등록 뒷자리(7자리 중 첫째자리)에서 성별 구분을 검색하시오 
SELECT MEM_NAME 회원명
,      MEM_REGNO2 주민등록번호
,  CASE WHEN(SUBSTR(MEM_REGNO2,1,1)) = 1 THEN '남자'
       WHEN(SUBSTR(MEM_REGNO2,1,1)) > 1 THEN '여자'
    END "성별"
FROM MEMBER;
--P.210
--트랜잭션(Transaction)
--데이터베이스를 변경하기 위해 수행되어야 할
--논리적인 단위. 여러개의 SQL로 구성되어 있음.
--원자성(Atomicity) : All or Nothing. 전체 실행 또는 전체 실행 안됨.
--일관성(Consistency) : 데이터베이스에 실행전에 문제가 없다면 실행후에도 문제가 없다.
--고립성(Isolation) : 실행 중 타 트랜잭션에 영향으로 결과에 문제가 발생해서는 안 됨
--지속성(Durability) : 성공하면 결과는 지속됨
CREATE TABLE TEST1(
    DEPTNO NUMBER ,
    DNAME  VARCHAR2(30),
    LOC    VARCHAR2(30),
    CONSTRAINT PK_TEST1 PRIMARY KEY(DEPTNO)
);
INSERT INTO TEST1(DEPTNO, DNAME, LOC) VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO TEST1(DEPTNO, DNAME, LOC) VALUES(20,'RESEARCH','DALLAS');
INSERT INTO TEST1(DEPTNO, DNAME, LOC) VALUES(30,'SALES','CHICAGO');
INSERT INTO TEST1(DEPTNO, DNAME, LOC) VALUES(40,'OPERATIONS','BOSTON');
COMMIT;

SELECT * FROM TEST1;

SELECT * FROM USER_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'PK_TEST1'
--기본키는 중복이 되면 안된다. 중복으로 20으로 할려고 하니까 오류가 생긴다
UPDATE TEST1
SET DEPTNO = 20;

UPDATE TEST1
SET LOC = 'SEOUL'
WHERE DNAME ='SALES';
--등푸른생선
DELETE FROM TEST1
WHERE DNAME = 'OPERATIONS';
--DDL을 수행하여 자동 COMMIT이 됨
--오류가 나도 자동 COMMIT 됨 회사에서 조심해야된다.
--테스트 할 때 쓰면 안된다. 
CREATE TABLE TEST2
AS
SELECT * FROM TEST11;
COMMIT;
ROLLBACK;

--LPROD 테이블 복제 -> LPORD2 테이블 생성
--1 스키마 : 컬럼 자료형 크기 NN제약사항 데이터
--2 P.K F.K는 복제가 안됨
CREATE TABLE LPROD2
AS
SELECT * FROM LPROD;
SELECT * FROM LPROD2;

UPDATE LPROD2
SET LPROD_ID = 7;
COMMIT;
UPDATE LPROD2
SET LPROD_NM = '미샤'
WHERE LPROD_GU = 'P302';
CREATE TABLE LPROD3
AS
SELECT * FROM LPROC;
DELETE FROM LPROD2
WHERE LPROD_GU = 'P403';
--SAVEPOINT : 트랜잭션 중간저장
--COMMIT : 변경사항을 데이터베이스에 반영
-- 트랜잭션이 종료됨과 동시에
-- 새로운 트랜잭션이 시작됨
SELECT * FROM TEST1;
UPDATE TEST1
SET DEPTNO = 20
SAVEPOINT A1; --A1
UPDATE TEST1
SET LOC= 'SEOUL'
WHERE DNAME = 'SALES';
SAVEPOINT A2;
DELETE FROM TEST1
WHERE DNAME = 'OPERATIONS';
SAVEPOINT A3;
SELECT * FROM TEST1;
ROLLBACK TO A2;
ROLLBACK TO A3;
ROLLBACK TO A1;
ROLLBACK;
--P.222
--메타데이터? 데이터(눈에보이는 데이터)를 위한 데이터(테이블에 스키마구조 컬럼,자료형,크기,제약사항,N.N)
--데이터 사전? 메타데이터를 정보를 관리 [읽기전용]
--Dictionaryt 뷰(가상의 테이블, 논리적)에서 'ALL_'로 시작하는 모든 테이블 조회  
SELECT TABLE_NAME
,      COMMENTS
FROM   DICTIONARY
WHERE  TABLE_NAME LIKE 'ALL_%';
SELECT * FROM ALL_CONSTRAINTS;
SELECT * FROM ALL_USERS;
--현재 로그인한 사용자가 만든 모든 객체 정보를 출력
SELECT OBJECT_NAME
,      OBJECT_TYPE
,      CREATED
FROM ALL_OBJECTS
WHERE OWNER = 'PC08'
ORDER BY OBJECT_TYPE ASC;
--각 테이블 전체 레코드 개수를 출력, 
SELECT TABLE_NAME
,      NUM_ROWS  
FROM USER_TABLES;
--P.241
--USER_CONSTRAINTS,
--USER_CONS_COLUMNS의 컬럼 상세를 확인하고
--상품 테이블의 제약조건을 출력하시오?
--컬럼명, 제약명, 타입, 제약내용
SELECT B.COLUMN_NAME 컬럼명 
,      A.CONSTRAINT_NAME 제약명
,      A.CONSTRAINT_TYPE 타입
,      A.SEARCH_CONDITION 제약내용
FROM USER_CONSTRAINTS A, USER_CONS_COLUMNS B
WHERE A.TABLE_NAME = B.TABLE_NAME
AND   A.TABLE_NAME='LPORD2';
------------------------------
--테이블목록 쿼리
SELECT S1.TABLE_NAME AS 물리테이블명,
         COMMENTS AS 논리테이블명,
         TABLESPACE_NAME AS 테이블스페이스명,
         NUM_ROWS AS ROW수,     --- analize 를 해야 정확한 Row수를 얻는다.
         LAST_ANALYZED AS  최종분석일자,
         PARTITIONED AS 파티션여부
FROM USER_TABLES S1,
        USER_TAB_COMMENTS S2
WHERE S1.TABLE_NAME = S2.TABLE_NAME       
  AND S2.TABLE_TYPE  = 'TABLE'    -- VIEW (뷰, 테이블 따로 SELECT 
  AND TABLESPACE_NAME IS NOT NULL --PLAN TABLE 등을 빼기 위해
ORDER BY  S1.TABLE_NAME;

--테이블, 컬럼 목록 추출
SELECT A.TABLE_NAME AS TABLE_NAME,
   A.TAB_CMT AS 테이블설명,
         A.COLUMN_NAME AS 컬럼명,
         B.POS AS PK,
         A.COL_CMT AS 컬럼설명,
         A.DATA_TYPE AS 데이터유형,
         A.데이터길이,
         A.NULLABLE AS NULL여부,
         A.COLUMN_ID AS 컬럼순서,
         A.DATA_DEFAULT AS 기본값
FROM
(SELECT S1.TABLE_NAME,
   S3.COMMENTS AS TAB_CMT,
         S1.COLUMN_NAME,
         S2.COMMENTS AS COL_CMT,
         S1.DATA_TYPE,
         CASE WHEN S1.DATA_PRECISION IS NOT NULL THEN DATA_PRECISION||','||DATA_SCALE
         ELSE TO_CHAR(S1.DATA_LENGTH)
         END  AS 데이터길이,
         NULLABLE,
         COLUMN_ID,
         DATA_DEFAULT
FROM  USER_TAB_COLUMNS S1,
         USER_COL_COMMENTS S2,
         USER_TAB_COMMENTS S3
WHERE S1.TABLE_NAME = S2.TABLE_NAME
   AND S1.COLUMN_NAME = S2.COLUMN_NAME
   AND S2.TABLE_NAME = S3.TABLE_NAME ) A,        
(SELECT T1.TABLE_NAME, T2.COLUMN_NAME, 'PK'||POSITION AS POS
   FROM (SELECT TABLE_NAME, CONSTRAINT_NAME  
              FROM USER_CONSTRAINTS
                  WHERE  CONSTRAINT_TYPE = 'P' )T1,
                  (SELECT TABLE_NAME, CONSTRAINT_NAME,  COLUMN_NAME, POSITION
                 FROM USER_CONS_COLUMNS ) T2
          WHERE T1.TABLE_NAME = T2.TABLE_NAME
             AND T1.CONSTRAINT_NAME = T2.CONSTRAINT_NAME  ) B
WHERE A.TABLE_NAME = B.TABLE_NAME(+)
   AND A.COLUMN_NAME = B.COLUMN_NAME(+)    
ORDER BY A.TABLE_NAME,  A.COLUMN_ID;
--P224
--회원 아이디가 조건절에 자주 사용되어 Index를 사용
--ROWID : 행의 고유 번호
SELECT ROWID
,       MEM_ID
,       MEM_NAME
,       MEM_JOB
,       MEM_BIR
FROM MEMBER
WHERE MEM_ID = 'a001';
--회원 생일이 조건절에 자주 사용되어
--Index를 생성 -> 검색속도 개선(B-TREE INDEX)
CREATE INDEX IDX_MEMBER_BIR
ON MEMBER(MEM_BIR);

SELECT ROWID
,      MEM_ID
,      MEM_NAME
,      MEM_JOB
,      MEM_BIR
FROM   MEMBER
WHERE  MEM_BIR LIKE '75%';
--회원생일에서 년도만 분리하여
--인덱스를 생성(Function-based Index)
CREATE INDEX IDX_MEMBER_BIR_YEAR
ON MEMBER(TO_CHAR(MEM_BIR, 'YYYY'));

SELECT MEM_ID
,      MEM_NAME
,      MEM_JOB
,      MEM_BIR
FROM   MEMBER
WHERE TO_CHAR(MEM_BIR, 'YYYY')='1975';
DROP INDEX IDX_MEMBER_BIR_YEAR;
--dix_member_bir_year 인덱스는 rebuild 하시오?
ALTER INDEX IDX_MEMBER_BIR_YEAR REBUILD;
--P230
--INDEX KEY COLUMN에 변형을 막는 Query문 사용권장
SELECT BUY_DATE
,      BUY_PROD
,      BUY_QTY
FROM   BUYPROD
WHERE  BUY_DATE - 10 = '2005-02-20';

--재구성
SELECT BUY_DATE
,      BUY_PROD
,      BUY_QTY
FROM   BUYPROD
WHERE  BUY_DATE = TO_DATE('2005-02-20') + 10;
--243P
--상품테이블에서 상품코드, 상품명, 분류명을 조회

--조인 기초 쿼리 
--LPROD, PROD 조인
SELECT PROD_ID AS PROD1
,      PROD_NAME   AS PROD2
,      LPROD_GU    AS LPROD1
,      PROD_LGU    AS PROD3
,      PROD_SALE   AS PROD4
,      LPROD_NM    AS LPROD2
FROM LPROD, PROD;

--조인 시 단계
--1) 두 테이블 사이에 P.K, F.K 관계를 찾자
--2) 관계가 있따면 FROM절에 두 테이블명을 적음
-- 자료형과 크기가 같음. 같은 데이터가 있음
--3) P.K데이터와 F.K데이터가 같은 경우에만 
--  결과에 포함
--4) 컬럼을 구성. FROM 절의 테이블에 ALIAS
SELECT L. LPROD_GU
,      L. LPROD_NM
,      P. PROD_LGU
,      P. PROD_ID
,      P. PROD_NAME
FROM LPROD L, PROD   P
WHERE L.LPROD_GU = P.PROD_LGU;
--카티전 
SELECT L.LPROD_GU
,      L.LPROD_NM
,      B.BUYER_ID
,      B.BUYER_NAME
,      B.BUYER_LGU
FROM    LPROD L, BUYER B
--연결고리(같은 데이터타입과 자료면 정확한 값이 나온다.
WHERE L.LPROD_GU = B.BUYER_LGU;
--조인조건이 없는 조인? 카티젼 프로덕트
--조인조건이 있으면? EQUI JOIN, 동등조인, 내부조인
SELECT M.MEM_ID
,      M.MEM_NAME
,      C.CART_NO
,      C.CART_PROD
,      C.CART_MEMBER
,      C.CART_QTY
FROM MEMBER M INNER JOIN CART C
ON (MEM_ID = CART_MEMBER);
---
SELECT P.PROD_ID
,      P.PROD_NAME
,      B.BUY_DATE
,      B.BUY_PROD
,      B.BUY_QTY
,      B.BUY_COST
FROM PROD P, BUYPROD B
WHERE PROD_ID = BUY_PROD;
--
SELECT P.PROD_ID
,      P.PROD_NAME
,      C.CART_NO
,      C.CART_PROD
,      C.CART_MEMBER
,      C.CART_QTY
FROM PROD P, CART C
WHERE PROD_ID= CART_PROD;
--ANSI 표준
SELECT C.CART_NO
,      C.CART_PROD
,      C.CART_QTY
,      C.CART_MEMBER
,      P.PROD_NAME
,      M.MEM_NAME
FROM PROD P INNER JOIN CART C ON(P.PROD_ID = C.CART_PROD)
        INNER JOIN MEMBER M ON(C.CART_MEMBER = MEM_ID);
WHERE 
AND C.CART_MEMBER = M.MEM_ID;

SELECT P.PROD_ID
,      P.PROD_NAME
,      P.PROD_LGU
,      P.PROD_BUYER
,      B.BUYER_ID
,      B.BUYER_LGU
,      L.LPROD_GU
,      L.LPROD_NM
FROM    PROD P, BUYER B, LPROD L
--테이블 -1이 조인조건에 갯수
WHERE   P.PROD_BUYER = B.BUYER_ID
AND L.LPROD_GU  =P.PROD_LGU;
SELECT C.CART_NO, C.CART_PROD, C.CART_MEMBER
,      P.PROD_NAME
,      B.BUYER_NAME
,      L.LPROD_NM
,      M.MEM_NAME
FROM CART C, MEMBER M, PROD P, BUYER B, LPROD L
WHERE P.PROD_ID = C.CART_PROD
AND M.MEM_ID=C.CART_MEMBER
AND B.BUYER_ID = P.PROD_BUYER
AND B.BUYER_ID= P.PROD_BUYER
AND L.LPROD_GU = P.PROD_LGU;
--ANSI표준
SELECT L. LPROD_GU
,      L. LPROD_NM
,      P. PROD_LGU
,      P. PROD_ID
,      P. PROD_NAME
FROM LPROD L INNER JOIN PROD P
ON(L.LPROD_GU = P.PROD_LGU);

SELECT P.PROD_ID
,      P.PROD_NAME
,      P.PROD_LGU
,      P.PROD_BUYER
,      B.BUYER_ID
,      B.BUYER_LGU
,      L.LPROD_GU
,      L.LPROD_NM
FROM    PROD P RIGHT JOIN BUYER B ON(P.PROD_BUYER = B.BUYER_ID)
            RIGHT JOIN LPROD L ON(L.LPROD_GU  =P.PROD_LGU);
--ANSI 표준
SELECT C.CART_NO, C.CART_PROD, C.CART_MEMBER
,      P.PROD_NAME
,      B.BUYER_NAME
,      L.LPROD_NM
,      M.MEM_NAME
FROM CART C INNER JOIN MEMBER M ON(M.MEM_ID=C.CART_MEMBER)
         INNER JOIN PROD P ON(P.PROD_ID = C.CART_PROD)
         INNER JOIN BUYER B ON(B.BUYER_ID = P.PROD_BUYER)
         INNER JOIN LPROD L ON(L.LPROD_GU = P.PROD_LGU);

--P.243 
--상품테이블에서 거래처가 '상품전자' 인 자료의 
-- 상품코드, 상품명, 거래처명을 조회
--EQUI JOIN
SELECT P.PROD_ID 상품코드
,      P.PROD_NAME 상품명
,      B.BUYER_NAME 거래처명
FROM BUYER B, PROD P 
WHERE BUYER_ID = PROD_BUYER
AND B.BUYER_NAME LIKE '삼성전자';
--ANSI 표준 
SELECT P.PROD_ID 상품코드
,      P.PROD_NAME 상품명
,      B.BUYER_NAME 거래처명
FROM BUYER B INNER JOIN PROD P ON(B.BUYER_ID = P.PROD_BUYER)
WHERE B.BUYER_NAME LIKE '삼성전자';
--P244
--상품 분류가 전자제품(P102)인 상품의 상품코드, 상품명,
--분류명 거래처명을 조회
SELECT P.PROD_ID    
,      P.PROD_NAME
,      L.LPROD_NM
,      B.BUYER_NAME
FROM PROD P, BUYER B, LPROD L
WHERE B.BUYER_ID = P.PROD_BUYER
AND P.PROD_LGU = L.LPROD_GU
AND L.LPROD_NM = '전자제품';

SELECT P.PROD_ID    
,      P.PROD_NAME
,      L.LPROD_NM
,      B.BUYER_NAME
FROM PROD P INNER JOIN BUYER B ON(B.BUYER_ID = P.PROD_BUYER)
            INNER JOIN LPROD L ON(P.PROD_LGU = L.LPROD_GU)
WHERE L.LPROD_NM = '전자제품';
--P.282
--AVG(컬럼)
SELECT AVG( DISTINCT PROD_COST) 중복된값은제외
,      AVG(All PROD_COST) DEFALT모든값
,      AVG(PROD_COST)   매입가평균
FROM PROD;
--상품테이블의 상품분류별 매입가격 평균 값 
SELECT PROD_LGU
,      ROUND(AVG(NVL(PROD_COST,0)),2) 매입가격평균값
FROM PROD
GROUP BY PROD_LGU;
--상품테이블의 총 판매가격 평균 값을 구하시오 ?
SELECT AVG(NVL(PROD_SALE,0))    총판매가격평균값
FROM PROD;
--상품테이블의 상품분류별 판매가격 평균 값을 구하시오 ?
SELECT PROD_LGU 상품분류
,      ROUND(AVG(NVL(PROD_SALE,0)),2)   상품분류별판매가평균
FROM PROD
GROUP BY PROD_LGU;
--P.282
--COUNT : 자료수
SELECT PROD_COST FROM PROD
ORDER BY PROD_COST ASC;

SELECT COUNT(DISTINCT PROD_COST)
,      COUNT(All PROD_COST)
,      COUNT(PROD_COST)
,      COUNT(*)
FROM PROD;
--거래처테이블의 담당자(BUYER_CHARGER)를 컬럼으로 하여 COUNT집계하시오>?
--(Alias는 자료수(DISTINCT), 자료수, 자료수(*))
SELECT COUNT(DISTINCT BUYER_CHARGER) "자료수(DISTINCT)" --COUNT NULL 제외
,      COUNT(All BUYER_CHARGER) "자료수"
,      COUNT(*)     "자료수(*)" --기본키 포함
FROM BUYER;
--회원테이블의 취미종류수를 COUNT 집계 하시오?
SELECT COUNT(DISTINCT MEM_LIKE) AS "취미종류수"
FROM MEMBER;
--회원테이블(MEMBER)의 취미(MEM_LIKE)별 
--COUNT 집계 하시오?
--Alias는 취미, 자료수, 자료수(*)
SELECT  MEM_LIKE 취미
,       COUNT(MEM_ID)   자료수  
,       COUNT(*) "자료수(*)"
FROM MEMBER
GROUP BY MEM_LIKE;
--회원테이블의 직업종류수를 COUNT 집계하시오
SELECT COUNT(DISTINCT MEM_JOB)
FROM MEMBER;
--회원테이블의 직업별 COUNT 집계하시오?
SELECT MEM_JOB  직업명
,      COUNT(MEM_ID)  인원수
FROM MEMBER;
--장바구니테이블 회원(CART_MEMBER)별 COUNT 집계 하시오
--장바구니테이블(CART)의 
--회원(CART_MEMBER)별 구매회수를 COUNT집계 하시오?
--(Alias는 회원ID(CART_MEMBER))
--구매회수(DISTINCT), 구매회수, 구매회수(*)
SELECT CART_MEMBER  회원ID
,      COUNT(DISTINCT CART_PROD) 구매회수
,      COUNT(CART_PROD) 구매회수
,      COUNT(*) "구매회수(*)"
FROM CART
GROUP BY CART_MEMBER;

SELECT MAX(DISTINCT PROD_COST)
       , MAX(PROD_COST)
       , MIN(DISTINCT PROD_COST)
       , MIN(PROD_COST)
FROM PROD;
--상품중 최고판매가격과 최저판매가격
SELECT MAX(PROD_SALE) AS "최고판매가"
,   MIN(PROD_SALE) AS "최저판매가"
FROM PROD;

--상품 중 거래처별 최고매입가격과 최저매입가격
--SELECT절에서 집계함수 이외의 컬럼들은
--GROUP BY 절에 기술한다.
SELECT PROD_BUYER AS 거래처
,      MAX(PROD_COST) AS 최고매입가
,      MIN(PROD_COST) AS 최저매입가
FROM PROD
GROUP BY PROD_BUYER
ORDER BY PROD_BUYER;
--장바구니테이블의 회원별 최대구매수량을 검색하시오?
SELECT CART_MEMBER  AS 회원ID
,      MAX(DISTINCT CART_QTY) AS "최대수량(DISTINCT)"
,      MIN(DISTINCT CART_QTY) AS "최소수량(DISTINCT)"
FROM CART
GROUP BY CART_MEMBER;
--오늘이 2005년도 7월 11일이라 가정하고 장바구니 테이블에 발생될 추가 주문번호를 검색 하시오?
-- Alias는 최고치주문번호, 추가주문번호
SELECT max(CART_NO) 최고치주문번호
,       MAX(CART_NO)+1 추가주문
FROM CART 
where cart_no like'20050711%';

SELECT PROD_LGU 상품분류
,       SUM(PROD_SALE) 판매가
FROM PROD
GROUP BY PROD_LGU
ORDER BY PROD_LGU;
--P284
--상품입고테이블의 상품별 입고수량의 합계
--ALIAS : 상품코드 판매수량합계
SELECT BUY_PROD
,      SUM(BUY_QTY) 
FROM   BUYPROD
GROUP BY BUY_PROD
ORDER BY BUY_PROD;
--회원테이블의 회원전체 마일리지 평균, 마일리지 합계, 최고 마일리지, 최소마일리지 
--인원수를 검색하시오? Alias는 마일리지평균, 마일리지합계, 최고마일리지, 최소 마일리지 인원수
SELECT   ROUND(AVG(NVL(MEM_MILEAGE,0)),2) 마일리지평균
,        SUM(MEM_MILEAGE)   마일리지합계
,        MAX(MEM_MILEAGE)   최고마일리지
,        MIN(MEM_MILEAGE)   최소마일리지
,        COUNT(*) 인원수
FROM MEMBER;
--상품테이블에서 판매가전체의 평균, 합계, 최고값, 최저값,자료 수를 검색하시오?
--ALIAS : 평균, 합계, 최고값, 최저값, 자료수 
SELECT ROUND(AVG(NVL(PROD_SALE,0)),2) 평균
,      SUM(PROD_SALE) 합계
,      MAX(PROD_SALE) 최고값   
,      MIN(PROD_SALE) 최저값
,      COUNT(*) 자료수 
FROM PROD;
--상품테이블에서 거래처, 상품분류별로 최고판매가, 최소판매가, 자료수를 검색하시오 ?
SELECT PROD_BUYER        거래처
,      SUBSTR(PROD_ID,1,4) 상품분류
,      MAX(PROD_COST)    최고판매가
,      MIN(PROD_COST)    최소판매가
,      COUNT(*)    자료수
FROM PROD
GROUP BY PROD_BUYER, SUBSTR(PROD_ID,1,4)
ORDER BY 1,2;
--장바구니테이블에서 회원, 상품분류별로 구매수량평균, 구매수량평균, 구매수량합계, 자료수를 검색하시오?
--ALIAS 회원ID, 상품분류, 구매수량평균, 구매수량합계, 자료수 (회원ID 상품분류 순으로 SORT하시오
SELECT CART_MEMBER  회원ID      
,      SUBSTR(CART_PROD,1,4) 상품분류
,      ROUND(AVG(NVL(CART_QTY,0)),2)     구매수량평균
,      SUM(CART_QTY)     구매수량합계
,      COUNT(*)     자료수
FROM CART
GROUP BY CART_MEMBER, SUBSTR(CART_PROD,1,4)
ORDER BY CART_MEMBER, SUBSTR(CART_PROD,1,4);
--회원테이블에서 지역(주소1의 2자리), 생일년도 별로 마일리지평균, 마일리지합계, 최고 마일리지,
--최소마일리지, 자료수를 검색하시오?
--Alias는 지역, 생일연도, 마일리지평균, 마일리지합계, 최고마일리지, 최소마일리지, 자료수 
SELECT SUBSTR(MEM_ADD1,1,2) 지역
,      EXTRACT(YEAR FROM MEM_BIR)      생일연도
,      AVG(NVL(MEM_MILEAGE,0))  마일리지평균
,      SUM(MEM_MILEAGE)  마일리지합계
,      MAX(MEM_MILEAGE)  최고마일리지
,      MIN(MEM_MILEAGE)  최소마일리지
,      COUNT(MEM_ID)       자료수
FROM MEMBER
GROUP BY SUBSTR(MEM_ADD1, 1, 2)
,       EXTRACT(YEAR FROM MEM_BIR)
ORDER  BY 1,2;
--2005년 1월에 입고된 상품(BUY_PROD)의
--상품분류별 입고수량(BUY_QTY)의 합,
--입고단가(BUY_COST)의 합을 구한 후
--최종입고가격을 검색하시오.
--최종입고가격은 입고단가 X 입고수량이고,
--최종입고가격을 내림차순으로 정렬
--(ALIAS : 구입년월, 상품분류코드, 
--입고수량합계, 입고단가합계
--최종입고가격합계)
SELECT SUBSTR(BUY_DATE,1,5) 구입년월
,      SUBSTR(BUY_PROD,1,4) 상품분류코드
,      sum(BUY_QTY)      입고수량합계
,      sum(BUY_COST)     입고단가합계
,      sum(BUY_COST * BUY_QTY) 최종입고가격
FROM BUYPROD
WHERE BUY_DATE LIKE '05/01%'
GROUP BY SUBSTR(BUY_DATE,1,5),SUBSTR(BUY_PROD,1,4)
ORDER BY 1,2;
--P.285
--집계함수 문제1
--CART테이블을 활용하여
--2005년도 2분기(4월~6월)의
--김은대(a001), 이쁜이(b001), 육평회(q001)회원 별
--상품분류 별(P101, P102 ...)
--상품구매개수의 합계를 구하기.
--상품구매개수로 역순정렬하기
--alias : 회원ID, 년월, 상품분류, 구매개수 
SELECT CART_MEMBER 회원ID
,      SUBSTR(CART_NO,1,6)      년월
,      SUBSTR(CART_PROD,1,4)    상품분류
,      SUM(CART_QTY)     구매개수
FROM CART
WHERE SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200506'
AND CART_MEMBER IN('a001','b001','q001')
GROUP BY CART_MEMBER,SUBSTR(CART_NO,1,6),SUBSTR(CART_PROD,1,4)
ORDER BY 4 DESC;
--집계함수 문제2
--회원테이블(MEMBER)을 활용하여
--지역 별, 취미 별 인원수를 출력하기
--단, 주민등록번호 상의 연도(MEM_REGNO1)와 
--생일 상의 연도(MEM_BIR)가 다른 경우 
--잘못된 데이터로 여겨 결과에서 제외함
--인원수로 역순정렬하기.
--ALIAS : 지역, 취미, 인원수
SELECT SUBSTR(MEM_ADD1,1,2) 지역
,      MEM_LIKE 취미
,      COUNT(*) 인원수
FROM MEMBER
WHERE SUBSTR(MEM_BIR,1,2) = SUBSTR(MEM_REGNO1,1,2)
GROUP BY SUBSTR(MEM_ADD1,1,2), MEM_LIKE-- <- 소그룹 
ORDER BY 3 DESC;
--상품입고테이블(BUYPROD)의 2005년도 1월의 
--거래처별(거래처코드(BUYER_ID), 거래처명(BUYER_NAME)) 
--매입금액을 검색 하시오 ? 
--( 매입금액 = 매입수량(BUY_QTY) * 매입단가(BUY_COST) )
--( Alias는 거래처코드, 거래처명, 매입금액 )
--조인조건 두 개 있어야 됨 그룹바이도 
SELECT B.BUYER_ID 거래처코드
,     B.BUYER_NAME   거래처명
,    SUM(BUY_COST * BUY_QTY) 매입금액
FROM BUYER B, PROD P, BUYPROD BP
WHERE B.BUYER_ID = P.PROD_BUYER
AND   P.PROD_ID = BP.BUY_PROD
AND   BP.BUY_DATE LIKE '05/01%'
GROUP BY B.BUYER_ID, B.BUYER_NAME
ORDER BY B.BUYER_ID, B.BUYER_NAME;
--SG_SCORES 테이블을 활용하여
--학생별 과목별 점수의 합계를 구해보자 
--ALIAS : 학생아이디, 과목아이디, 점수합계
SELECT A.STUDENT_ID  학생아이디
,      B.NAME 학생명
,      A.COURSE_ID   과목아이디
,      SUM(A.SCORE)  점수합계
FROM SG_SCORES A, STUDENT B
WHERE B.STUDENT_ID = B.STUDENT_ID
GROUP BY A.STUDENT_ID, B.NAME, A.COURSE_ID
ORDER BY 1,2;
--학생정보 
--학과 별 학생의 인원수는 몇명인가 
--ALIAS : 학과코드 학생수, 과사무실전화번호
SELECT D.DEPT_ID 학과코드
,      D.DEPT_NAME 학과명
,      D.DEPT_TEL 과사무실전화번호
,      COUNT(*) 학생수
FROM STUDENT S, DEPARTMENT D
WHERE S.DEPT_ID = D.DEPT_ID
GROUP BY D.DEPT_ID, D.DEPT_NAME, D.DEPT_TEL;

--교수
SELECT * FROM PROFESSOR;
--강의
SELECT * FROM COURSE;
--강의 별 강의수 및 수강비의 평균을 구해보자
--ALIAS : 교수아이디, 교수명, 메일주소, 강의수, 수강비평균
SELECT P.PROFESSOR_ID   교수아이디
,      P.NAME           교수명
,      P.EMAIL          메일주소
,      COUNT(*)         강의수
,      AVG(NVL(C.COURSE_FEES,0))    수강비평균
FROM PROFESSOR P, COURSE C
WHERE P.PROFESSOR_ID  = C.PROFESSOR_ID 
GROUP BY P.PROFESSOR_ID, P.NAME, P.EMAIL
ORDER BY 5 DESC;
--SG_SCORES(학생별 시험성적)
--2017년도 과목별 성적의평균을 구해보자 
--ALIAS : 과목코드, 과목명!, 성적평균
SELECT SUBSTR(S.SCORE_ASSIGNED,1,2)  "2017년도"
,      S.COURSE_ID             과목코드
,      C.TITLE                 과목명
,      AVG(NVL(S.SCORE,0))     성적평균      
FROM    SG_SCORES S, COURSE C
WHERE   S.COURSE_ID = C.COURSE_ID
AND     SUBSTR(S.SCORE_ASSIGNED,1,2) LIKE '17'
GROUP BY   SUBSTR(SCORE_ASSIGNED,1,2), S.COURSE_ID, C.TITLE;
SELECT * FROM SG_SCORES;
SELECT * FROM COURSE;
--R테이블 S테이블을 통해 OUTER JOIN 연습 
--1. s테이블 생성 후 기본키는 c
CREATE TABLE S(
    C VARCHAR2(10),
    D VARCHAR2(10),
    E VARCHAR2(10),
    CONSTRAINT PK_S PRIMARY KEY(C)
);
--2. R테이블 생성 후 기본키는 A,
-- 컬럼 : A, B, C
CREATE TABLE R(
    A VARCHAR2(10),
    B VARCHAR2(10),
    C VARCHAR2(10),
    CONSTRAINT PK_R PRIMARY KEY(A)
);
--R 테이블에 a1, b1, c1과 a2, b2, c2 데이터 입력
INSERT INTO R(A,B,C) VALUES('a1','b1','c1');
INSERT INTO R(A,B,C) VALUES('a2','b2','c3');
COMMIT;
--EQUI JOIN , SIMPLE JOIN, 등가조인, 동등조인
--왼쪽
SELECT R.A, R.B, R.C
,       S.C,S.D,S.E
FROM    R, S
WHERE S.C = R.C(+);

--ANSI표준(INNER JOIN)
SELECT R.A, R.B, R.C
,       S.C,S.D,S.E
FROM R LEFT OUTER JOIN S ON(S.C = R.C);
--RIGHT OUTER JOIN
SELECT R.A, R.B, R.C
,       S.C,S.D,S.E
FROM    R, S
WHERE R.C(+) = S.C;
--ANSI표준 RIGHT
SELECT R.A, R.B, R.C
,       S.C,S.D,S.E
FROM    R RIGHT OUTER JOIN S ON(R.C(+) = S.C);
--FULL OUTER JOIN
SELECT R.A, R.B, R.C
,      S.C, S.D, S.E
FROM R,S
WHERE R.C(+)=S.C
UNION
SELECT
--ANSI표준 (FULL OUTER JOIN)
SELECT R.A, R.B, R.C
,       S.C,S.D,S.E
FROM    R FULL OUTER JOIN S ON(R.C(+) = S.C);
--OUTER JOIN 연습문제 
--DEPART테이블 STUDENT테이블을 통해 OUTER JOIN 연습
--컬럼의 크기는 학생이 결정해보자 
--1. DEPART테이블 생성 후 기본키는 DEP_CODE
--컬럼 : DEP_CODE, DEP_NAME
CREATE TABLE DEPART(
    DEP_CODE VARCHAR2(10),
    DEP_NAME VARCHAR2(10),
    CONSTRAINT DEPART PRIMARY KEY(DEP_CODE)
);
--2. STUDENT테이블 생성 후 기본키는 STUD_NO,
--외래키는 STUD_DEP(DEPART테이블의 DEP_CODE컬럼 참조)
-- 컬럼: STUD_NO, STUD_NAME, STUD_DEP
DROP TABLE STUDENT;

CREATE TABLE STUDENT(
    STUD_NO VARCHAR2(10),
    STUD_NAME VARCHAR2(90),
    STUD_DEP VARCHAR2(10),
    CONSTRAINT PK_STUDENT PRIMARY KEY(STUD_NO),
    CONSTRAINT FK_STUDENT FOREIGN KEY(STUD_DEP) REFERENCES DEPART(DEP_CODE)
);
INSERT INTO DEPART(DEP_CODE, DEP_NAME) VALUES('401','7월반');
INSERT INTO DEPART(DEP_CODE, DEP_NAME) VALUES('402','6월반');
INSERT INTO DEPART(DEP_CODE, DEP_NAME) VALUES('403','4월반');
INSERT INTO DEPART(DEP_CODE, DEP_NAME) VALUES('404','10월반');
INSERT INTO DEPART(DEP_CODE, DEP_NAME) VALUES('405','12월반');
INSERT INTO DEPART(DEP_CODE, DEP_NAME) VALUES('406','3월반');
INSERT INTO DEPART(DEP_CODE, DEP_NAME) VALUES('307','11월반');
--
INSERT INTO STUDENT(STUD_NO,STUD_NAME,STUD_DEP) 
VALUES('2022060001','허지현','406');
INSERT INTO STUDENT(STUD_NO,STUD_NAME,STUD_DEP) 
VALUES('2022060002','이준혁','406');
INSERT INTO STUDENT(STUD_NO,STUD_NAME,STUD_DEP) 
VALUES('2022060003','김강산','405');
INSERT INTO STUDENT(STUD_NO,STUD_NAME,STUD_DEP) 
VALUES('2022060004','윤다영','401');
INSERT INTO STUDENT(STUD_NO,STUD_NAME,STUD_DEP) 
VALUES('2022060005','성민정','402');
--5. DEPART테이블과 STUDENT테이블을EQUAL JOIN
--: 반코드, 반명, 학번, 학생명 
--EQUI JOIN 처리
SELECT D.DEP_CODE 반코드
,      D.DEP_NAME 반명
,      S.STUD_NO  학번
,      S.STUD_NAME 학생명
FROM DEPART D, STUDENT S
WHERE D.DEP_CODE=S.STUD_DEP;
--ANSI INNER JOIN
SELECT D.DEP_CODE 반코드
,      D.DEP_NAME 반명
,      S.STUD_NO  학번
,      S.STUD_NAME 학생명
FROM DEPART D INNER JOIN STUDENT S ON(D.DEP_CODE=S.STUD_DEP);
--6. DEPART테이블과 SUTDENT 테이블을 
--왼쪽 외부조인 Alias : 반코드, 반명, 학번, 학생명,
--(+)
SELECT D.DEP_CODE 반코드
,      D.DEP_NAME 반명
,      S.STUD_NO  학번
,      S.STUD_NAME 학생명
FROM DEPART D, STUDENT S
WHERE D.DEP_CODE=S.STUD_DEP(+);
--ANSI LEFT OUTER JOIN
SELECT D.DEP_CODE 반코드
,      D.DEP_NAME 반명
,      S.STUD_NO  학번
,      S.STUD_NAME 학생명
FROM DEPART D LEFT OUTER JOIN STUDENT S ON(D.DEP_CODE=S.STUD_DEP);
-- 7. DEPART테이블과 STUDENT테이블을 오른쪽 외부조인 
--(+)RIGHT OUTER JOIN
SELECT D.DEP_CODE 반코드
,      D.DEP_NAME 반명
,      S.STUD_NO 학번
,      S.STUD_NAME 학생명
FROM DEPART D, STUDENT S
WHERE D.DEP_CODE(+)=S.STUD_DEP;
--ANSI RIGHT OUTER JOIN 
SELECT D.DEP_CODE 반코드
,      D.DEP_NAME 반명
,      S.STUD_NO 학번
,      S.STUD_NAME 학생명
FROM DEPART D RIGHT OUTER JOIN STUDENT S ON(D.DEP_CODE(+)=S.STUD_DEP);
--8. DEPART테이블과 STUDENT테이블을 
--완전 외부 조인 
--UNION
SELECT DEP_CODE 반코드
,      DEP_NAME 반명
,      STUD_NO 학번
,      STUD_NAME 학생명
FROM DEPART , STUDENT 
WHERE D.DEP_CODE(+)=S.STUD_DEP
UNION 
SELECT DEP_CODE 반코드
,      DEP_NAME 반명
,      STUD_NO 학번
,      STUD_NAME 학생명
FROM DEPART , STUDENT 
WHERE D.DEP_CODE=S.STUD_DEP(+);
--ANSI FULL OUTER JOIN
SELECT D.DEP_CODE 반코드
,      D.DEP_NAME 반명
,      S.STUD_NO 학번
,      S.STUD_NAME 학생명
FROM DEPART D FULL OUTER JOIN STUDENT S ON(D.DEP_CODE(+)=S.STUD_DEP)
--OUTER JOIN 문제
--1. 대학정보테이블(COLLEAGE)
--대학코드
--대학명
CREATE TABLE COLLEAGE(
    COLL_CODE VARCHAR2(40),
    COLL_NAME VARCHAR2(40),
    CONSTRAINT COLLEAGE PRIMARY KEY(COLL_CODE)
);
--2. 학과정보테이블(HAKGWA)
--학과코드
--학과명
--대학코드
CREATE TABLE HAKGWA(
    HAK_NO VARCHAR2(50),
    HAK_NAME VARCHAR2(50),
    HAK_CODE VARCHAR2(40),
    CONSTRAINT PK_HAKGWA PRIMARY KEY(HAK_NO),
    CONSTRAINT FK_HAKGWA FOREIGN KEY(HAK_CODE) REFERENCES COLLEAGE(COLL_CODE)
);
--3. 대학정보테이블의 대학코드를 기본키로 설정
--4. 학과정보테이블의 학과코드를 기본키로 설정
--   학과정보테이블의 대학코드가 대학정보테이블의 대학코드를 참조하는
--   외래키로 설정
--5. 대학정보테이블에 다음 데이터를 INSERT 하기
--W01 솔아시아매니지먼트
--W02 외식조리
--W03 철도물류
--W04 디지털미디어
--W05 보건복지
INSERT INTO COLLEAGE(COLL_CODE, COLL_NAME) VALUES('W01','솔아시아매니지먼트');
INSERT INTO COLLEAGE(COLL_CODE, COLL_NAME) VALUES('W02', '외식조리');
INSERT INTO COLLEAGE(COLL_CODE, COLL_NAME) VALUES('W03', '철도물류');
INSERT INTO COLLEAGE(COLL_CODE, COLL_NAME) VALUES('W04', '디지털미디어');
INSERT INTO COLLEAGE(COLL_CODE, COLL_NAME) VALUES('W05', '보건복지');
--6. 학과정보테이블에 다음 데이터를 INSERT 하기
--H001 외식조리학과 W02
--H002 호텔관광경영학과 W02
--H003 철도경영학과 W03
--H004 간호학과 W05
INSERT INTO HAKGWA(HAK_NO, HAK_NAME, HAK_CODE) VALUES('H001', '외식조리학과','W02');
INSERT INTO HAKGWA(HAK_NO, HAK_NAME, HAK_CODE) VALUES('H002', '호텔관광경영학과','W02');
INSERT INTO HAKGWA(HAK_NO, HAK_NAME, HAK_CODE) VALUES('H003', '철도경영학과','W03');
INSERT INTO HAKGWA(HAK_NO, HAK_NAME, HAK_CODE) VALUES('H004', '간호학과','W05');
--7. 대학정보테이블과 학과정보테이블을 내부조인하여 SELECT
SELECT * FROM COLLEAGE, HAKGWA;
SELECT C.COLL_CODE 대학코드
,      C.COLL_NAME 대학명 
,      H.HAK_NO 학과코드 
,      H.HAK_NAME 학과명  
FROM  COLLEAGE C, HAKGWA H
WHERE C.COLL_CODE = H.HAK_CODE;
--ANSI
SELECT C.COLL_CODE 대학코드
,      C.COLL_NAME 대학명 
,      H.HAK_NO 학과코드 
,      H.HAK_NAME 학과명 
FROM COLLEAGE C INNER JOIN HAKGWA H ON(C.COLL_CODE = H.HAK_CODE);
--8. 대학정보테이블의 모든 데이터를 출력하도록 
--  학과정보테이블과 외부조인 SELECT
SELECT C.COLL_CODE  대학코드
,      C.COL_NAME 대학명
,      COUNT(H.HAK_CODE) 학과개수
FROM COLLEAGE C, HAKGWA H
WHERE C>COLL_CODE = H.HAK_CODE(+)
GROUP BY C.COL_CODE, C>COL_NAME
ORDER BY 1;
--P246
--전체 상품의 2005년 1월 입고수량을 검색 조회
--( Alias는 상품코드, 상품명, 입고수량 )
--EQUI JOIN
SELECT BP.BUY_PROD 상품코드
    , P.PROD_NAME 상품명
    , SUM(BP.BUY_QTY) 입고수량
FROM   PROD P, BUYPROD BP
WHERE  P.PROD_ID = BP.BUY_PROD(+)
AND    BP.BUY_DATE(+) LIKE '05/01%'
GROUP BY BP.BUY_PROD, P.PROD_NAME;
--ANSI표준
--LEFT OUTER JOIN
SELECT BP.BUY_PROD 상품코드
    , P.PROD_NAME 상품명
    , SUM(BP.BUY_QTY) 입고수량
FROM   PROD P LEFT OUTER JOIN BUYPROD BP
ON(P.PROD_ID = BP.BUY_PROD AND BP.BUY_DATE LIKE '05/01%')
GROUP BY BP.BUY_PROD, P.PROD_NAME;
SELECT PROD_ID, PROD_NAME FROM PROD;
--P.247
--전체 회원(MEMBER)의 2005년도 4월의 구매현황 조회
--ALIAS : 회원ID, 성명, 구매수량의합(CART_QTY)
SELECT M.MEM_ID   회원ID
,      M.MEM_NAME 성명
,      NVL(SUM(CART_QTY),0) 구매수량의합
FROM MEMBER M, CART C
WHERE M.MEM_ID =C.CART_MEMBER(+) 
AND C.CART_NO(+) LIKE '200504%'
GROUP BY M.MEM_ID, M.MEM_NAME
ORDER BY  M.MEM_ID, M.MEM_NAME;
SELECT * FROM MEMBER, CART;
--ANSI 표준
SELECT M.MEM_ID   회원ID
,      M.MEM_NAME 성명
,      NVL(SUM(CART_QTY),0) 구매수량의합
FROM MEMBER M LEFT OUTER JOIN CART C
ON( M.MEM_ID =C.CART_MEMBER AND C.CART_NO LIKE '200504%') 
GROUP BY M.MEM_ID, M.MEM_NAME
ORDER BY  M.MEM_ID, M.MEM_NAME;
--INNER 조인은 빼도 되지만 OUTER 는 안됨  
--P248 
--전체 상품의 2005년도 5월5일의 입고.출고현황 조회
--상품코드 상품명 입고수량의합 판매수량의합
SELECT P.PROD_ID 상품코드
,      P.PROD_NAME 상품명
,      NVL(SUM(BP.BUY_QTY),0) 입고수량의합
,      NVL(SUM(C.CART_QTY),0) 판매수량의합
FROM PROD P, BUYPROD BP, CART C
WHERE P.PROD_ID= BP.BUY_PROD(+)  --where AND에다가 +를 부족한쪽에 써준다 
AND P.PROD_ID=C.CART_PROD(+)
AND BP.BUY_DATE(+) = '05/05/05'
AND C.CART_NO(+) LIKE '20050505%'
GROUP BY P.PROD_ID, P.PROD_NAME
ORDER BY P.PROD_ID, P.PROD_NAME;
--ANSI
SELECT P.PROD_ID 상품코드
,      P.PROD_NAME 상품명
,      NVL(SUM(BP.BUY_QTY),0) 입고수량의합
,      NVL(SUM(C.CART_QTY),0) 판매수량의합
FROM PROD P LEFT OUTER JOIN BUYPROD BP ON (P.PROD_ID= BP.BUY_PROD AND BP.BUY_DATE ='05/05/05')
        LEFT OUTER JOIN CART C ON(P.PROD_ID=C.CART_PROD AND C.CART_NO LIKE '20050505%')
GROUP BY P.PROD_ID, P.PROD_NAME    -- +는 오라클에서만 쓴다 ANSI에서는 쓰지 않는다.
ORDER BY P.PROD_ID, P.PROD_NAME;
--P249
--SELF JOIN : TALBE ALIAS를 사용하여 마치 2개의 
--TABLE 처럼 자신의 TABLE과 자신의 TABLE을 조인하여 검색
--이해를 도와주는 동요 : 내동생

--회원ID가 'h001라준호'인 고객의 마일리지 점수보다
--이상인 회원만 검색 조회
--Alias는 회원ID 성명 마일리지
SELECT A.MEM_ID 회원ID
,      A.MEM_NAME 성명
,       A.MEM_MILEAGE 마일리지
FROm MEMBER A, MEMBER B
WHERE B.MEM_ID = 'h001'
AND A.MEM_MILEAGE >= B.MEM_MILEAGE
ORDER BY 3,1;

SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
FROM MEMBER 
WHERE MEM_ID ='h001';
--P249
--거래처코드가 'P30203(참존)'과 동일지역에 속한 거래처만
--검색 조회 ALIAS는 거래처코드, 거래처, 주소 
SELECT A.BUYER_ID 거래처코드
,      A.BUYER_NAME   거래처 
,      SUBSTR(A.BUYER_ADD1,1,2)   주소
,      B.BUYER_ID
,      B.BUYER_NAME
,      SUBSTR(B.BUYER_ADD1,1,2)
FROM BUYER A, BUYER B
WHERE B.BUYER_ID = 'P30203'
AND SUBSTR(A.BUYER_ADD1,1,2)
    =   SUBSTR(B.BUYER_ADD1,1,2);

SELECT SUBSTR(BUYER_ADD1,1,2) FROM BUYER
WHERE BUYER_ID = 'P30203';
--SELF JOIN 연습문제
--라준호 회원의 직업과 동일한 직업을 가진
--회원의 리스트를 출력해보세요
--(회원ID, 회원명, 직업)
SELECT A.MEM_ID   회원ID
,      A.MEM_NAME 회원명
,      SUBSTR(A.MEM_JOB,1,3)  직업
FROM MEMBER A, MEMBER B
WHERE B.MEM_NAME = '라준호'
AND SUBSTR(A.MEM_JOB,1,3)
=   SUBSTR(B.MEM_JOB,1,3);
 --문제
--f001회원이 2005년 4월 10일에 8개 주문한
--상품을 동일하게 구입한 회원의 정보를 구하시오
--(ALIAS : 회원ID(CART_MEMBER), 카트번호(CART_NO),
--상품ID(CART_PROD), 구입개수(CART_QTY)
SELECT A.CART_MEMBER  회원ID    
,      A.CART_NO      카트번호
,      A.CART_PROD    상품ID
,      A.CART_QTY     구입개수
FROM CART A, CART B
WHERE B.CART_MEMBER = 'f001'
AND B.CART_NO LIKE '20050410%'
AND B.CART_QTY =8
AND A.CART_PROD = B.CART_PROD;
--문제
--w001 회원과 같은 취미(MEM_LIKE)를 가진
--회원 정보를 검색하시오 
--ALIAS : 회원ID(MEM_ID), 회원명(MEM_NAME) 취미(MEM_LIKE)
SELECT A.MEM_ID   회원ID
,      A.MEM_NAME 회원명
,      A.MEM_LIKE 취미
FROM MEMBER A, MEMBER B
WHERE B.MEM_ID = 'w001'
AND A.MEM_LIKE = B.MEM_LIKE;
--P.
--HAVING : 
--집계가 끝나고 난 뒤 결과 집계함수에 조건걸 때
--GROUP BY 절 뒤에 씀
--SELECT절에 쓰인 구문이라면 HAVING절에 조건으로 사용 가능!
-- 2005년도 월별 매입 현황을 검색하시오 ?
--(Alias는 매입월, 매입수량, 매입금액(매입수량*매입테이블의 매입가))
--단, 매입금액이 2000000 이상인 데이터만 출력해보자
SELECT EXTRACT (MONTH FROM BUY_DATE) 매입월
,      SUM(BUY_QTY) 매입수량
,      SUm(BUY_COST * BUY_QTY) 매입금액
FROM BUYPROD
WHERE EXTRACT (YEAR FROM BUY_DATE) =2005
GROUP BY EXTRACT (MONTH FROM BUY_DATE)
HAVING   SUM(BUY_COST * BUY_QTY) >= 50000000
ORDER BY 1,1;
--2005년도 판매된 상품 중에 5회 이상의 판매회수가 있는 
--상품 조회    ( 상품코드, 상품명, 판매횟수 )
SELECT C.CART_PROD    상품코드
,      P.PROD_NAME    상품명
,      SUM(C.CART_QTY)     판매횟수
FROM CART C, PROD P
WHERE P.PROD_ID=C.CART_PROD
AND C.CART_NO LIKE '2005%'
GROUP BY C.CART_PROD, P.PROD_NAME --중복되는 것들을 묶는다.
HAVING SUm(C.CART_QTY) >=5;
--상품분류가  컴퓨터제품('P101')인 상품의 2005년도 일자별
--판매 조회( 판매일, 판매금액(5,000,000초과의 경우만), 판매수량 )
SELECT SUBSTR(C.CART_NO,1,8)   판매일
,      SUM(P.PROD_COST * C.CART_QTY) 판매금액
,      SUM(C.CART_QTY) 판매수량
FROM PROD P, CART C
WHERE P.PROD_ID = C.CART_PROD
AND P.PROD_LGU = 'P101'
AND C.CART_NO LIKE '2005%'
GROUP BY SUBSTR(C.CART_NO,1,8)  
HAVING SUM(P.PROD_COST * C.CART_QTY) < 5000000;
-- 2005년도 판매일자(CART_NO를 조작), 
-- 판매총액(CART_QTY * PROD_SALE),
-- 판매수량(CART_QTY), 판매회수(COUNT(CART_NO))
-- 를 조회하시오.
-- 단, 판매회수가 8개 이상인 경우
--     판매총액이 5,000,000초과의 경우
--     판매수량이 50초과의 경우
--ALIAS : 판매일, 판매금액, 판매수량, 판매회수
SELECT SUBSTR(C.CART_NO,1,8)    판매일
,      SUM(C.CART_QTY * P.PROD_SALE) 판매금액
,      SUM(CART_QTY)   판매수량
,      COUNT(CART_NO)   판매회수
FROM PROD P,CART C
WHERE P.PROD_ID=C.CART_PROD
AND C.CART_NO LIKE '2005%'
GROUP BY SUBSTR(C.CART_NO,1,8)
HAVING SUM(C.CART_QTY) > 50
AND COUNT(C.CART_NO) >= 8
AND SUM(C.CART_QTY * P.PROD_SALE) > 5000000 ;
--실전!!---
-- 2005년도  회원(MEMBER) 직업 별 
--판매금액(판매가(PROD_SALE) * 판매개수(CART_QTY))을 조회하시오
-- ALIAS : 직업, 연도, 지역, 판매금액
-- 단, 지역은 대전으로 한정.
-- 판매금액은 20,000,000 이상인 데이터로 한정
SELECT  M.MEM_JOB   직업
,       EXTRACT(YEAR FROM M.MEM_BIR)    연도
,       SUBSTR(M.MEM_ADD1,1,2)      지역
,       SUM(P.PROD_SALE * C.CART_QTY)   판매금액
FROM MEMBER M, PROD P, CART C
WHERE M.MEM_ID = C.CART_MEMBER 
AND P.PROD_ID = C.CART_PROD
AND C.CART_NO LIKE '2005%'
AND SUBSTR(M.MEM_ADD1,1,2) = '대전'
GROUP BY M.MEM_JOB
,       EXTRACT(YEAR FROM M.MEM_BIR)
,       SUBSTR(M.MEM_ADD1,1,2)
HAVING SUM(P.PROD_SALE * C.CART_QTY) >= 20000000;
--P.254
--상품코드 상품명 거래처코드 거래처명 
--단 서브쿼리 이용
--SCALAR 서브쿼리
SELECT P.PROD_ID    상품코드
,      P.PROD_NAME  상품명
,      P.PROD_BUYER 거래처코드
,      (SELECT BUYER_NAME FROM BUYER WHERE BUYER_ID = 'P10101')  거래처명
FROM PROD P;
--회원ID(CART_MEMBER), 회원명, 주문번호(CART_NO)
-- 상품코드(CART_PROD), 수량(CART_QTY)
-- 단, 서브쿼리 이용
SELECT CART_MEMBER    회원ID
,      (SELECT MEM_NAME FROM MEMBER WHERE MEM_ID = CART_MEMBER) 회원명
,      CART_NO        주문번호
,      CART_PROD      상품코드
,      CART_QTY       수량
FROM CART;
--SCALAR 서브쿼리1
-- 입고일자(BUY_DATE), 상품코드(BUY_PROD)
--,상품명, 매입수량(BUY_QTY), 매입단가(BUY_COST)
-- 단, 서브쿼리 이용
SELECT BUY_DATE 입고일자
,      BUY_PROD 상품코드
,      (SELECT PROD_NAME FROM PROD WHERE PROD_ID = BUY_PROD) 상품명
,      BUY_QTY  매입수량
,      BUY_COST 매입단가
FROM BUYPROD
ORDER BY 5,1;
--SCALAR 서브쿼리2
-- 거래처코드(BUYER_ID), 거래처명(BUYER_NAME)
--,상품분류코드(BUYER_LGU), 상품분류명
-- 단, 서브쿼리 이용
SELECT BUYER_ID 거래처코드
,      BUYER_NAME   거래처명
,      BUYER_LGU   상품분류코드
,     (SELECT LPROD_NM FROM LPROD WHERE LPROD_GU= BUYER_LGU) 상품분류명
FROM BUYER;
--SCALAR 서브쿼리3(BUYPROD)
-- 입고일자, 상품코드, 상품명
-- 매입수량, 매입단가
-- 단, 서브쿼리 이용
SELECT BUY_DATE 입고일자
,       BUY_PROD 상품코드
,       (SELECT PROD_NAME FROM PROD WHERE PROD_ID =BUY_PROD)   상품명
,       BUY_QTY 매입수량
,       BUY_COST  매입단가
FROM BUYPROD;
--NESTED 서브쿼리1
--NESTED 서브쿼리 : WHERE 절에 사용된 서브쿼리
--상품분류가 컴퓨터제품인 상품의 리스트를 출력하기
--ALIAS :  상품코드, 상품명, 상품분류코드
SELECT PROD_ID
,      PROD_NAME
,      PROD_LGU
FROM PROD
WHERE PROD_LGU=(SELECT LPROD_GU FROM LPROD WHERE LPROD_NM = '컴퓨터제품');
SELECT * FROM LPROD;
--NESTED 서브쿼리2
--NESTED 서브쿼리 : WHERE절에 사용된 서브쿼리
--상품분류가 컴퓨터제품인 거래처 리스트를 출력하기
--ALIAS : 거래처코드, 거래처명, 상품분류코드
--단일행 / 단일컬럼 서브쿼리
SELECT BUYER_ID     거래처코드
,      BUYER_NAME   거래처명
,      BUYER_LGU    상품분류코드
FROM BUYER
WHERE BUYER_LGU=(SELECT LPROD_GU FROM LPROD WHERE LPROD_NM='컴퓨터제품');
SELECT LPROD_GU FROM LPROD WHERE LPROD_NM;
--NESTED 서브쿼리3
--NESTED 서브쿼리 : WHERE절에 사용된 서브쿼리
--상품분류가 전자제품인 상품매입 현황 리스트를 출력하기
--ALIAS : 입고일자, 상품코드, 매입수량, 매입단가
--힌트 : 상품코드에 상품분류코드가 있음.
SELECT BUY_DATE 입고일자
,      BUY_PROD 상품코드
,      BUY_QTY  매입수량
,      BUY_COST 매입단가
FROM BUYPROD
WHERE SUBSTR(BUY_PROD,1,4)=(SELECT LPROD_GU FROM LPROD WHERE LPROD_NM = '전자제품');
SELECT * FROM LPROD;
SELECT * FROM BUYPROD
--NESTED 서브쿼리5
--NESTED 서브쿼리 : WHERE절에 사용된 서브쿼리
--장바구니테이블에서 정은실 회원의 구매 현황을 출력
--ALIAS : 주문번호, 상품코드, 회원ID, 수량
SELECT  CART_NO     주문번호
,       CART_PROD     상품코드
,       CART_MEMBER   회원ID
,       CART_QTY    수량
FROM CART
WHERE CART_MEMBER=(SELECT MEM_ID FROM MEMBER WHERE MEM_NAME='정은실');
SELECT * FROM MEMBER WHERE MEM_NAME='정은실';
SELECT * FROM CART;
--[피리어스] 업체로부터 들여온 상품의 리스트를 출력
--상품ID, 상품명, 업체코드
--서브쿼리를 사용하기.
SELECT PROD_ID  상품ID
,      PROD_NAME    상품명
,      PROD_BUYER   업체코드
FROM PROD
WHERE PROD_BUYER=(SELECT BUYER_ID FROM BUYER WHERE BUYER_NAME LIKE '피리어스');
SELECT * FROM BUYER;
--P254
--상품Table에서 판매가가 상품평균판매가 보다 큰 상품을
--검색하시오
--(AlIAS: 상품명, 판매가, 평균판매가)
SELECT P.PROD_NAME    상품명
,      P.PROD_SALE    판매가
,      A.AVG_SALE   평균판매가 --SCALAR
FROM PROD P,  (SELECT AVG(PROD_SALE) AVG_SALE FROM PROD ) A --INLINE VIEW(FROM절에 쓰인 서브쿼리)
WHERE P.PROD_SALE > A.AVG_SALE; --NETED
--P255
--회원테이블에서 마일리지가 평균마일리지 보다 큰 회원을
--검색하시오? (Alias는 회원명, 마일리지, 평균마일리지)
SELECT M.MEM_NAME
,   M.MEM_MILEAGE 
,   A.AVG_MILEAGE 평균마일리지
FROM MEMBER M, (SELECT AVG(MEM_MILEAGE) AVG_MILEAGE FROM MEMBER) A
WHERE M.MEM_MILEAGE >  A.AVG_MILEAGE;
--문제) 
--장바구니Table에서 판매수가 평균판매수 보다 큰 데이터를 
--검색하시오 ?  
--(Alias는 회원ID, 장바구니번호, 상품코드, 판매수, 평균판매수)
SELECT C.CART_MEMBER  회원ID
,       C.CART_NO     장바구니번호
,       C.CART_PROD   상품코드
,       C.CART_QTY     판매수   
,       A.AVG_QTY    평균판매수
FROM CART C, (SELECT AVG(CART_QTY) AVG_QTY FROM CART)  A
WHERE CART_QTY > A.AVG_QTY;
--문제) 
--회원Table에서 나이가 평균나이 보다 많은 회원을 
--검색하시오 ?  
--(Alias는 회원ID, 성명, 주민번호앞자리, 나이, 평균나이)
SELECT M.MEM_ID 회원ID
    , M.MEM_NAME 성명
    , M.MEM_REGNO1 주민번호앞자리
    , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM M.MEM_BIR) 나이
    , ROUND(A.AVG_AGE,2) 평균나이
FROM MEMBER M, (SELECT AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)) AVG_AGE FROM MEMBER) A
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) > ROUND(A.AVG_AGE,2)
;
--P.256
--모든) 거래처의 2005년도 거래처별 매입금액 합계
--alias : 거래처코드, 거래처명, 매입금액합계
--LEFT OUTER JOIN 
SELECT B.BUYER_ID   거래처코드
,      B.BUYER_NAME 거래처명
,      SUM(BP.BUY_COST * BP.BUY_QTY) 매입금액합계
FROM BUYER B LEFT OUTER JOIN PROD P ON(B.BUYER_ID = P.PROD_BUYER)
            LEFT OUTER JOIN BUYER BP
                    ON(P.PROD_ID=BP.BUY_PROD AND EXTRACT(YEAR FROM BP.BUY_DATE)=2005)
GROUP BY B.BUYER_ID, B.BUYER_NAME;
--LEFT OUTER JOIN
SELECT B.BUYER_ID 거래처코드
    , B.BUYER_NAME 거래처명
    , SUM(BP.BUY_COST * BP.BUY_QTY) 매입금액합계
FROM   BUYER B, PROD P, BUYPROD BP
WHERE  B.BUYER_ID = P.PROD_BUYER(+)
AND    P.PROD_ID = BP.BUY_PROD(+)
AND    EXTRACT(YEAR FROM BP.BUY_DATE(+))=2005
GROUP BY B.BUYER_ID, B.BUYER_NAME;

--ANSI 표준
--LEFT OUTER JOIN
SELECT B.BUYER_ID 거래처코드
    , B.BUYER_NAME 거래처명
    , NVL(SUM(BP.BUY_COST * BP.BUY_QTY),0) 매입금액합계
FROM   BUYER B LEFT OUTER JOIN PROD P     ON(B.BUYER_ID = P.PROD_BUYER)
               LEFT OUTER JOIN BUYPROD BP
                    ON(P.PROD_ID = BP.BUY_PROD AND EXTRACT(YEAR FROM BP.BUY_DATE)=2005)
GROUP BY B.BUYER_ID, B.BUYER_NAME
ORDER BY B.BUYER_ID, B.BUYER_NAME;
-------
SELECT B.BUYER_ID   거래처코드
,      B.BUYER_NAME 거래처명
,      SUM(BP.BUY_COST * BP.BUY_QTY) 매입금액합계
FROM BUYER B,PROD P,BUYPROD BP
WHERE B.BUYER_ID = P.PROD_BUYER(+)
AND P.PROD_ID=BP.BUY_PROD(+)
AND EXTRACT(YEAR FROM BP.BUY_DATE(+))=2005
GROUP BY B.BUYER_ID, B.BUYER_NAME;
--ANSI
SELECT T.BUYER_ID, T.BUYER_NAME
   ,  NVL(U.SUM_QTY,0) SUM_QTY
FROM (
    SELECT BUYER_ID
   ,   BUYER_NAME  
    FROM BUYER
)T,
(
    SELECT B.BUYER_ID
   ,      B.BUYER_NAME
   ,      SUM(BP.BUY_COST * BP.BUY_QTY) SUM_QTY
    FROM BUYER B, PROD P, BUYPROD BP
    WHERE B.BUYER_ID = P.PROD_BUYER
    AND P.PROD_ID = BP.BUY_PROD
    AND EXTRACT(YEAR FROM BP.BUY_DATE)=2005
    GROUP BY B.BUYER_ID, B.BUYER_NAME
)U
WHERE T.BUYER_ID = U.BUYER_ID(+);
--P.256 
--모든 거래처의 2005년도 거래처별 매출금액(PROD_SALE * CART_QTY) 합계
--alias : 거래처코드, 거래처명, 매출금액(PROD_SALE * CART_QTY) 합계
SELECT B.BUYER_ID   거래처코드
,      B.BUYER_NAME 거래처명
,      SUM(P.PROD_SALE * C.CART_QTY) 매출금액
FROM BUYER B,PROD P,CART C
WHERE B.BUYER_ID = P.PROD_BUYER
AND P.PROD_ID = C.CART_PROD
AND  C.CART_NO LIKE '2005%'
GROUP BY B.BUYER_ID, B.BUYER_NAME;
--서브쿼리
SELECT T.BUYER_ID, T.BUYER_NAME
   ,  NVL(U.SUM_QTY,0) SUM_QTY
FROM (SELECT BUYER_ID, BUYER_NAME  
FROM BUYER)T,
(SELECT B.BUYER_ID   
,     B.BUYER_NAME 
,     SUM(P.PROD_SALE * C.CART_QTY) SUM_QTY
FROM BUYER B,PROD P,CART C
WHERE B.BUYER_ID = P.PROD_BUYER
AND P.PROD_ID = C.CART_PROD
AND  C.CART_NO LIKE '2005%'
GROUP BY B.BUYER_ID, B.BUYER_NAME)U
WHERE T.BUYER_ID = U.BUYER_ID(+);
--P259-- INLINE
SELECT T.BUYER_ID, T.BUYER_NAME
    , U.IN_QTY, V.OUT_QTY
FROM
(SELECT BUYER_ID
    , BUYER_NAME
FROM   BUYER) T,
(SELECT B.BUYER_ID 
        , B.BUYER_NAME 
        , SUM(BP.BUY_COST * BP.BUY_QTY) IN_QTY
    FROM   BUYER B, PROD P, BUYPROD BP
    WHERE  B.BUYER_ID = P.PROD_BUYER
    AND    P.PROD_ID = BP.BUY_PROD
    AND    EXTRACT(YEAR FROM BP.BUY_DATE)=2005
    GROUP BY B.BUYER_ID, B.BUYER_NAME) U,
(SELECT B.BUYER_ID
    , B.BUYER_NAME
    , SUM(P.PROD_SALE * C.CART_QTY) OUT_QTY
FROM   BUYER B, PROD P, CART C
WHERE  B.BUYER_ID = P.PROD_BUYER
AND    P.PROD_ID = C.CART_PROD
AND    C.CART_NO LIKE '2005%'
GROUP BY B.BUYER_ID, B.BUYER_NAME) V
WHERE T.BUYER_ID = U.BUYER_ID(+)
AND   T.BUYER_ID = V.BUYER_ID(+)
ORDER BY T.BUYER_ID;
-- 장바구니 Table에서 회원별 최고의 구매수량을 가진 자료의 회원,
--주문번호, 상품, 수량에 대해 모두 검색하시오 ?
--ALIAS 는 ,회원 ,주문번호 ,상품, 수량
--고급기술 상관관계서브쿼리 MAIN의 특정 컬럼이
-- SUB의 조건으로 사용되고 , SUB의 결과가 다시 MAIN의 조건으로 사용됨 
SELECT  A.CART_MEMBER  회원
,       A.CART_NO     주문번호
,       A.CART_PROD   상품    
,       A.CART_QTY    수량
FROM CART A
WHERE A.CART_QTY = (
    SELECT MAX(B.CART_QTY)
    FROM CART B
    WHERE B.CART_MEMBER  = A.CART_MEMBER 
);
--입고테이블 BUYPROD에서 상품별
--최고 매입수량을 가진 자료의
--입고일자 상품코드 매입수량 매입단가를 검색하기
SELECT A.BUY_DATE 입고일자
,      A.BUY_PROD 상품코드
,      A.BUY_QTY  매입수량
,      A.BUY_COST 매입단가
FROM BUYPROD A
WHERE A.BUY_QTY = (
    SELECT MAX(B.BUY_QTY)
    FROM BUYPROD B
    WHERE B.BUY_PROD = A.BUY_PROD
);
--상관관계서브쿼리 예제3)
-- 장바구니Table에서 일자별 최고의 구매수량을 가진 자료의 회원, 
--주문번호, 상품, 수량에 대해 모두 검색하시오 ?
--(Alias는 회원, 일자, 상품, 수량)
SELECT C.CART_MEMBER  회원
,      SUBSTR(C.CART_NO,1,8)     일자
,      C.CART_PROD     상품
,      C.CART_QTY       수량
FROM CART C
WHERE C.CART_QTY=(
    SELECT MAX(CART_QTY)
    FROM CART D
    WHERE SUBSTR(D.CART_NO,1,8) = SUBSTR(C.CART_NO,1,8)
);
--P260 
--단일행 서브쿼리, 단일컬럼 서브쿼리
-- =, !=, <>, <, >, <=, >=
SELECT LPROD_NM
FROM LPROD
WHERE LPROD_GU = 'P101';
--다중행 서브쿼리 
--IN, ANY, ALL, EXISTS 연산자 사용
SELECT LPROD_NM
FROM LPROD
WHERE LPROD_GU LIKE 'P1%';
--다중컬럼 서브쿼리에 사용가능
SELECT LPROD_ID, LPROD_GU, LPROD_NM
FROM LPROD
WHERE LPROD_GU = 'P101';
--P260
--직업이 공무원인 사람들의 마일리지를 검색하여 
--최소한 그들 중 어느 한사람보다는 마일리지가 큰 사람들을 출력하시오
--단 직업이 공무원인 사람을 제외하고 검색하시오
--ALIAS는 회원명, 직업, 마일리지
--ANY : OR
SELECT A.MEM_NAME, A.MEM_JOB, A.MEM_MILEAGE 
FROM MEMBER A
WHERE A.MEM_MILEAGE > ANY(
SELECT B.MEM_MILEAGE 
FROM MEMBER B 
WHERE B.MEM_JOB = '공무원'
);
-- ALL : AND
SELECT A.MEM_NAME, A.MEM_JOB, A.MEM_MILEAGE 
FROM MEMBER A
WHERE A.MEM_MILEAGE > ALL(
SELECT B.MEM_MILEAGE 
FROM MEMBER B 
WHERE B.MEM_JOB = '공무원'
);
--문제
--a001 회원의 구입수량을 검색하여
--최소한 a001 회원 보다는 구입수량이(AND의 개념)
--큰 주문내역을 출력하시오.
--단, a001 회원은 제외하고 검색하시오.
--(ALIAS는 주문번호, 상품코드, 회원명!!!, 구입수량)
SELECT A.CART_NO  주문번호
,       A.CART_PROD   상품코드
,       A.CART_MEMBER   회원명
,       A.CART_QTY    구입수량
FROM CART A 
WHERE A.CART_QTY > ALL(
SELECT B.CART_QTY
FROM CART B 
WHERE B.CART_MEMBER = 'a001');
--2
SELECT A.CART_NO  주문번호
,       A.CART_PROD   상품코드
,       A.CART_MEMBER   회원명
,       A.CART_QTY    구입수량
FROM CART A 
WHERE A.CART_MEMBER <> 'a001'
AND A.CART_QTY > ANY(
    SELECT DISTINCT B.CART_QTY FROM CART B WHERE B.CART_MEMBER = 'a001'
);
--집합은 세로로 묶는다.
--중복은 한번 출력 
--P261
--A집합
SELECT MEM_NAME
,      MEM_JOB
,      MEM_MILEAGE
FROM MEMBER
WHERE MEM_MILEAGE > 4000
--합집합, 중복1회. 자동정렬 **** 
UNION
--UNION ALL : 합집합, 중복모두, 자동정렬안됨
--INTERSECT : 교집합. 자동정렬안됨
--A MINUS B: 차집합 자동정렬안됨
--B집합 
SELECT MEM_NAME
,   MEM_JOB
,       MEM_MILEAGE
FROM MEMBER
WHERE MEM_JOB = '자영업'; 
--P.264
--SET(집합)을 사용할 수 있는 조건 
--1. 컬럼의 수가 동일해야된다.  2. 대응되는 자료형이 동일
--A) 2005년도 4월에 판매된 상품
SELECT DISTINCT A.CART_PROD 판매상품
,       P.PROD_NAME 상품명
FROM CART A , PROD P
WHERE A.CART_PROD = P.PROD_ID
AND SUBSTR(A.CART_NO,1,8) BETWEEN '20050401' AND '20050430'
--INTERSECT
AND EXISTS(
--B  2005년도 6월
SELECT DISTINCT C.CART_PROD 판매상품
,       P.PROD_NAME 상품명
FROM CART C , PROD P
WHERE C.CART_PROD = P.PROD_ID
AND C.CART_NO LIKE '200506%'
AND C.CART_PROD = A.CART_PROD
)
;
--EXISTS쉬운문제
--A
SELECT A.MEM_ID
,      A.MEM_NAME
,      A.MEM_MILEAGE
FROM MEMBER A
WHERE A.MEM_MILEAGE > 1000
--B
AND EXISTS(
SELECT B.MEM_ID
,      B.MEM_NAME
FROM MEMBER B
WHERE B.MEM_JOB ='학생'
AND A.MEM_ID = B.MEM_ID
);
--P.265
--2005년도 구매금액 2천만 이상 우수고객으로 지정하여 
--검색하시오 ?
--(Alias는 회원ID, 회원명, '우수고객’)
--(구매금액 : SUM(CART.CART_QTY * PROD.PROD_SALE))
--A테이블
SELECT A.MEM_ID 회원ID
    , A.MEM_NAME 회원명
    , '우수고객' 우수고객
FROM   MEMBER A
--B
--FROM 다음에 AND가 못온다 WHERE로 써줘야됨
WHERE EXISTS(
SELECT 1
FROM MEMBER M, CART C, PROD P
WHERE M.MEM_ID = C.CART_MEMBER
AND C.CART_PROD = P.PROD_ID
AND C.CART_NO LIKE '2005%'
AND A.MEM_ID = M.MEM_ID
GROUP BY M.MEM_ID
HAVING SUM(P.PROD_SALE * C.CART_QTY) >= 20000000
);
--2005년도 매입금액 1천만원 이상 거래처
SELECT A.BUYER_ID
,       A. BUYER_NAME
,       '우수거래처'
FROM BUYER A  
WHERE EXISTS(
SELECT P.PROD_BUYER
,      SUM(BP.BUY_QTY * BP.BUY_COST)
FROM  PROD P, BUYPROD BP
WHERE P.PROD_ID = BP.BUY_PROD
AND BP.BUY_DATE LIKE '05%'
AND A.BUYER_ID = P.PROD_BUYER
GROUP BY P.PROD_BUYER
HAVING SUM(BP.BUY_QTY * BP.BUY_COST) >= 10000000);
--2005년도 상품의 매입.매출현황을 조회(UNION문 사용)
-- *상단 하단의 필드개수/이름/데이터 유형이 동일해야함 
-- -일자, 상품명 순
SELECT TO_CHAR(BUY_DATE,'YYYY/MM/DD') 일자
,      P.PROD_NAME   상품명
,      B.BUY_QTY       수량
,      '매입'         구분
FROM BUYPROD B, PROD P
WHERE BUY_PROD = PROD_ID
AND BUY_DATE BETWEEN '2005-01-01' AND '2005-12-31'

UNION
SELECT TO_CHAR(TO_DATE(SUBSTR(CART_NO,1,8), 'YYYYMMDD'), 'YYYY/MM/DD') AS 일자
,       PROD_NAME
,       CART_QTY
,       '매출'
FROM CART, PROD
WHERE CART_PROD = PROD_ID
AND CART_NO LIKE '2005%'
ORDER BY 1, 상품명;
--P267
--집계용 문법
--RANK() 슌유ㅏ 츌룍 험슈
--DENSE_RANK() :
--  서열 출력 함수(대상과 동일값을 하나로 설정하여 순위 부여)
SELECT RANK('c001')
        WITHIN GROUP (ORDER BY CART_MEMBER) AS "RANK"
   ,   DENSE_RANK('c001')
        WITHIN GROUP(ORDER BY CART_MEMBER) AS "DENSE_RANK"
FROM CART;
SELECT CART_MEMBER 
FROM CART
--분석용 문법
--장바구니(CART)테이블에서 회원들의 회원아이디와 
--구매수, 구매수순위를 출력
SELECT CART_MEMBER
,      CART_QTY
,      RANK() OVER(ORDER BY CART_QTY desc) AS RANK
,      DENSE_RANK() OVER(ORDER BY CART_QTY desc) AS RANK_DESC
FROM CART;
--분석용 문법
--CART 테이블에서 아이디기 'a001'인 회원의
--회원아이디, 상품코드, 구매수. 구매순위를 출력
--집계용문법 사용 불가 -> 분석용문법으로 풀기
SELECT * FROM CART ORDER BY 1, 1;
SELECT  CART_MEMBER 회원아이디
,       CART_PROD   상품코드
,       CART_QTY    구매수
,       RANK() OVER(ORDER BY CART_QTY DESC) AS 구매순위 
FROM CART 
WHERE CART_MEMBER = 'a001';
--CART 테이블을 사용하여 회원 아이디, 구매수
-- 회원별 구매순위를 출력
SELECT CART_MEMBER 회원아이디
,       CART_QTY 구매수
,       RANK() OVER (PARTITION BY CART_MEMBER ORDER BY CART_QTY DESC) 회원별구매수순위
FROM CART;
--P.268
--ROWNUm : 오라클 내부적으로 처리하기 위한
--         각레코드에 대한 일련번호
SELECT ROWNUM
,      L.LPROD_ID
,      L.LPROD_GU
,      L.LPROD_NM
FROM LPROD L;
-- **** 중요 ***
SELECT T.*
FROM(
    --INLINE VIEW :프롬절에쓰인 쿼리
    SELECT ROWNUM RNUM
   ,      L.LPROD_ID
   ,      L.LPROD_GU
   ,      L.LPROD_NM
    FROM LPROD L
) T
WHERE T.RNUM BETWEEN 1 AND 5;
--P269
--ROWID 테이블의 특정 레코드로 랜덤하게 접그한기 위한 
--    논리적인 주소값 데이터베이스 내에서 유일한 값
SELECT LPROD_GU
,   LPROD_NM
,   ROWID
FROM LPROD
ORDER BY 3 ASC;
--P.270
--RATIO_TO_REPORT : 전체대비 해당 ROW의 값이
--차지하는 비율을 구해줌
SELECT T1.VAL
,       RATIO_TO_REPORT(T1.VAL) OVER() * 100 || '%'
FROM(
    --UNION : 중복1회, 자동정렬O / UNION ALL : 중복모두. 자동정렬 X
    SELECT 10 VAL FROM DUAL
    UNION ALL
    SELECT 20 VAL FROM DUAL
    UNION ALL
    SELECT 30 VAL FROM DUAL 
    UNION ALL
    SELECT 40 VAL FROM DUAL 
)T1;
--a001회원이 구입한 상품의 내역을 활용하여
--구매개수(CART_QTY) 대비 해당 구매개수 값이
--차지하는 비율을 구하기 
--ALIAS : 회원ID, 상품코드, 구매수, 차지비율 
SELECT CART_MEMBER  회원ID
,      CART_PROD    상품코드
,      CART_QTY     구매수
,      ROUND(RATIO_TO_REPORT(CART_QTY) OVER() * 100,2) 차지비율
FROM CART
WHERE CART_MEMBER = 'a001';
--P.270
--ROLLUP 
--상품분류별, 거래처별 입고수와 입고가격의 합을 구해보자
--ALIAS : PROD_LGU, PROD_BUYER, IN_AMT, SUM_COST
SELECT P.PROD_LGU
,      P.PROD_BUYER
,      COUNT(*) IN_AMT
,      SUM(BP.BUY_COST)   SUM_COST
FROM PROD P , BUYPROD BP
WHERE P.PROD_ID = BP.BUY_PROD
GROUP BY ROLLUP (P.PROD_LGU, P.PROD_BUYER);
--ROLLUP 소계
SELECT P.PROD_LGU
,      P.PROD_BUYER
,      COUNT(BP.BUY_PROD) IN_AMT
,      SUM(BP.BUY_COST)   SUM_COST
FROM PROD P , BUYPROD BP
WHERE P.PROD_ID = BP.BUY_PROD
GROUP BY P.PROD_LGU, P.PROD_BUYER;
--ROLLUP을 UNION ALL로 바꾸자
SELECT P.PROD_LGU
,      P.PROD_BUYER
,      COUNT(BP.BUY_PROD) IN_AMT
,      SUM(BP.BUY_COST)   SUM_COST
FROM PROD P , BUYPROD BP
WHERE P.PROD_ID = BP.BUY_PROD
GROUP BY P.PROD_LGU, P.PROD_BUYER;
------노란색
UNION ALL
SELECT P.PROD_LGU
,      NULL
,      COUNT(BP.BUY_PROD) IN_AMT
,      SUM(BP.BUY_COST)   SUM_COST
FROM PROD P , BUYPROD BP
WHERE P.PROD_ID = BP.BUY_PROD
GROUP BY P.PROD_LGU;
--파란색
SELECT NULL
,      NULL
,      COUNT(BP.BUY_PROD) IN_AMT
,      SUM(BP.BUY_COST)   SUM_COST
FROM PROD P , BUYPROD BP
WHERE P.PROD_ID = BP.BUY_PROD;
--CUBE : 모든 소계
SELECT P.PROD_LGU
,      P.PROD_BUYER
,      COUNT(*) IN_AMT
,      SUM(BP.BUY_COST)   SUM_COST
FROM PROD P , BUYPROD BP
WHERE P.PROD_ID = BP.BUY_PROD
GROUP BY CUBE(P.PROD_LGU, P.PROD_BUYER);
--CUBE -> UNION ALL로 변환
--ROLLUP을 UNION ALL로 바꾸자
SELECT P.PROD_LGU
,      P.PROD_BUYER
,      COUNT(BP.BUY_PROD) IN_AMT
,      SUM(BP.BUY_COST)   SUM_COST
FROM PROD P , BUYPROD BP
WHERE P.PROD_ID = BP.BUY_PROD
GROUP BY P.PROD_LGU, P.PROD_BUYER

UNION ALL
SELECT P.PROD_LGU
,      NULL
,      COUNT(*) IN_AMT
,      SUM(BP.BUY_COST)   SUM_COST
FROM PROD P , BUYPROD BP
WHERE P.PROD_ID = BP.BUY_PROD
GROUP BY P.PROD_LGU

UNION ALL
SELECT NULL
,      P.PROD_BUYER
,      COUNT(*) IN_AMT
,      SUM(BUY_COST) SUM_COST
FROM PROD P, BUYPROD BP
WHERE P.PROD_ID = BP.BUY_PROD
GROUp BY P.PROD_BUYER

UNION ALL
SELECT NULL
,      NULL
,      COUNT(*) IN_AMT
,      SUM(BP.BUY_COST)   SUM_COST
FROM PROD P , BUYPROD BP
WHERE P.PROD_ID = BP.BUY_PROD;
--P.273
--GROUPING SET 함수
-- : 그루핑 조건이 여러 개일 경우 사용
SELECT MEM_JOB
,      NULL
,      COUNT(*)
FROM MEMBER
GROUP BY MEM_JOB
UNION
SELECT NULL
,      MEM_LIKE
,      COUNT(*)
FROM MEMBER
GROUP BY MEM_LIKE;
--GROUPING SET
SELECT MEM_JOB
,      MEM_LIKE
,      COUNT(*)
FROM MEMBER
GROUP BY GROUPING SETS(MEM_JOB, MEM_LIKE);
--277P
SELECT LPROD_GU
,      LPROD_NM
,      LAG(LPROD_GU) OVER(ORDER BY LPROD_GU ASC) 이전행정보
,      LEAD (LPROD_GU) OVER(ORDER BY LPROD_GU ASC) 이전행정보
FROM LPROD;
--P295
/
SET SERVEROUTPUT ON;
/
DECLARE
    v_i NUMBER(9,2) := 123456.78;
    v_str  VARCHAR2(20) := '홍길동';
    c_pi CONSTANT NUMBER(8,6) := 3.141592;
    v_flag  BOOLEAN NOT NULL := TRUE;
    v_date VARCHAR2(10) := TO_CHAR(SYSDATE, 'YYYY-MM-DD');
BEGIN
    DBMS_OUTPUT.PUT_LINE('v_i:'||v_i);
    --SYSTEM.OUT.PRINTLN('v_i:'||v_i);
END;
/
DECLARE
    v_i  NUMBER(9,2) := 0;
    v_name VARCHAR2(20);
    c_pi CONSTANT NUMBER(8,6) := 3.141592;
    v_flag BOOLEAN NOT NULL := true;
    v_date VARCHAR2(10)  := TO_CHAR(SYSDATE, 'YYYY-MM-DD');
BEGIN
    v_name := '홍길동';
    -- DBMS_OUTPUT>ENABLE;
    DBMS_OUTPUT.PUT_LINE('v_i:' || v_i);
    DBMS_OUTPUT.PUT_LINE('v_name:' || v_name);
    DBMS_OUTPUT.PUT_LINE('c_pi:' || c_pi);
    DBMS_OUTPUT.PUT_LINE('v_date:' || v_date);
END;
/
--p252
--조건이 true이면 이하 문장을 실행하고,
--조건이 false이면 관련된 문장을 통과한다.
--ELSIF절은 여러 개가 가능하나, ELSE절은 한 개만 가능하다.
DECLARE
    --이항연산자
    V_NUM NUMBER := 37;
BEGIN
    --DBMS_OUTPUT.ENABLE;
    IF MOD(V_NUM,2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE(V_NUM || '는 짝수');
    ELSE
        DBMS_OUTPUT.PUT_LINE(V_NUM || '는 홀수');
    END IF;
END;
/
--P253
--조건에 따른  다중 ELSIF
DECLARE 
    V_NUM NUMBER := 77;
BEGIN 
    IF V_NUM > 90 THEN
        DBMS_OUTPUT.PUT_LINE('수');
    ELSIF V_NUM > 80 THEN 
        DBMS_OUTPUT.PUT_LINE('우');
    ELSIF V_NUM > 70 THEN 
        DBMS_OUTPUT.PUT_LINE('미');
    ELSE
        DBMS_OUTPUT.PUT_LINE('분발합시다');
    END IF;
END;
/
--297
DECLARE
    --변수의 종류 : SCALAR(일반), REFERENCE(참조), COMPOSITE(배열), BIND(바인드 IN/OUT) 
    V_AVG_SALE PROD.PROD_SALE%TYPE; --NUMBER(10) --(REFERENCES 변수)
    V_SALE NUMBER := 500000;    --(SCLAR 변수)
BEGIN
    --269574.32
    SELECT AVG(PROD_SALE) INTO V_AVG_SALE
    FROM PROD;
    IF V_SALE < V_AVG_SALE THEN
        DBMS_OUTPUT.PUT_LINE('평균 단가가 500000 초과입니다.');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('평균 단가가 500000 이하입니다.');
    END IF;
END;
/
--P.297
--회원테이블에서 아이디가 'e001' 인 회원의  
--마일리지가 5000을 넘으면 'VIP 회원' 
--그렇지 않다면 '일반회원'으로 
--출력하시오. (회원이름, 마일리지 포함)  
DECLARE
    --SCALAR변수
    V_MILEAGE NUMBER;    
BEGIN
    SELECT MEM_MILEAGE INTO V_MILEAGE
    FROM MEMBER WHERE MEM_ID = 'e001';
    IF V_MILEAGE > 5000 THEN
        DBMS_OUTPUT.PUT_LINE('VIP회원');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('일반회원');
    END IF;
END;
--P.297
--CASE문 : SQL 사용하는 CASE문과 동일함
--차이점은 END CASE로 끝난다.
DECLARE 
    V_NUM NUMBER := 77;
BEGIN
    V_NUM := TRUNC(V_NUM / 10);
    CASE V_NUM
        WHEN 10 THEN
            DBMS_OUTPUT.PUT_LINE('수'|| '(' || V_NUM || ')');
        WHEN 9 THEN
            DBMS_OUTPUT.PUT_LINE('수'|| '(' || V_NUM || ')');
        WHEN 8 THEN
            DBMS_OUTPUT.PUT_LINE('우'|| '(' || V_NUM || ')');
        WHEN 7 THEN
            DBMS_OUTPUT.PUT_LINE('미'|| '(' || V_NUM || ')');    
        ELSE
            DBMS_OUTPUT.PUT_LINE('분발합시다.');
    END CASE;
END;
/
--상품분류가 화장품인 상품의 평균판매가를
--구한 후 평균판매가가 3,000원 미만이면 
--싸다, 3,000원 이상 ~ 6,000원 미만이면 보통,
--6,000원 이상 ~ 9,000원 미만이면 비싸다,
--9,000원 이상이면 너무비싸다를 출력하기
--단, CASE(SEARCHED CASE EXPRESSION)문 사용하여 처리하기
--출력형식 : 화장품의 평균판매가는 5000원이고 보통이다.
DECLARE 
       V_AVG_SALE NUMBER;
BEGIN
    SELECT ROUND(AVG(NVL(PROD_SALE,0)),2) INTO V_AVG_SALE
    FROM  PROD
    WHERE PROD_LGU = (SELECT LPROD_GU FROM LPROD WHERE LPROD_NM = '화장품');
    DBMS_OUTPUT.PUT_LINE('V_AVG_SALE:' || V_AVG_SALE);
    CASE WHEN V_AVG_SALE < 3000 THEN
        DBMS_OUTPUT.PUT_LINE('화장품의 평균판매가는' || V_AVG_SALE || '이고 싸다');
        WHEN V_AVG_SALE >= 3000 AND V_AVG_SALE < 60000 THEN
        DBMS_OUTPUT.PUT_LINE('화장품의 평균판매가는' || V_AVG_SALE || '이고 보통');
        WHEN V_AVG_SALE >= 000 AND V_AVG_SALE < 90000 THEN
        DBMS_OUTPUT.PUT_LINE('화장품의 평균판매가는' || V_AVG_SALE || '이고 비싸다');
        WHEN V_AVG_SALE >= 9000 THEN
        DBMS_OUTPUT.PUT_LINE('화장품의 평균판매가는' || V_AVG_SALE || '이고 너무 비싸다');
        ELSE
        DBMS_OUTPUT.PUT_LINE('화장품의 평균판매가는' || V_AVG_SALE || '이고 기타');
    END CASE;
END;
/
--가파치 업체의 지역을 검색하여
--다음과 같이 출력하기
--대구, 부산 : 경남
--대전 : 충청
--서울, 인천 : 수도권
--기타 : 기타
--단, CASE문 사용하기
DECLARE
    V_ADD VARCHAR2(60);
BEGIN
    SELECT SUBSTR(BUYER_ADD1, 0, 2) INTO V_ADD
    FROM BUYER
    WHERE BUYER_NAME LIKE '가파치';

    CASE WHEN V_ADD LIKE '대구' OR V_ADD = '부산' THEN
        DBMS_OUTPUT.PUT_LINE('경남');
        WHEN V_ADD LIKE '대전' THEN
        DBMS_OUTPUT.PUT_LINE('충청');
        WHEN V_ADD LIKE '서울' OR V_ADD = '인천' THEN
        DBMS_OUTPUT.PUT_LINE('수도권');        
    ELSE
        DBMS_OUTPUT.PUT_LINE('기타');
    END CASE;
END;
/
-------Example
/
DECLARE
    V_ADD1 VARCHAR2(60);
BEGIN
    --대구
    SELECT SUBSTR(BUYER_ADD1,1,2) INTO V_ADD1
    FROM   BUYER WHERE BUYER_NAME = '가파치';
    
    --대구, 부산 : 경남
    CASE WHEN V_ADD1 IN('대구','부산') THEN
            DBMS_OUTPUT.PUT_LINE('대구, 부산 : 경남');
    --대전 : 충청
         WHEN V_ADD1 IN('대전') THEN
            DBMS_OUTPUT.PUT_LINE('대전 : 충청');
    --서울, 인천 : 수도권  
         WHEN V_ADD1 IN('서울','인천') THEN
            DBMS_OUTPUT.PUT_LINE('서울, 인천 : 수도권');
    --기타 : 기타
         ELSE
            DBMS_OUTPUT.PUT_LINE('기타');
    END CASE;
END;
/
--CASE 문제
--장바구니 테이블에서 2005년도 a001회원의 구매금액의 합을 구해서 
--1000만원 미만은 '동메달', 1000만원 이상 2000만원 미만은 '은메달'
--2000만원 이상 3000천만원 미만은 금메달 그 이상은  에메랄드로 
--출력해보자
/
DECLARE
    V_MEMBER VARCHAR2(60);
    V_SUM NUMBER;

BEGIN
    SELECT C.CART_MEMBER
        , SUM(P.PROD_SALE * C.CART_QTY)  INTO V_MEMBER, V_SUM
    FROM CART C , PROD P 
    WHERE C.CART_MEMBER = 'a001'
    GROUP BY C.CART_MEMBER;

CASE
    WHEN V_SUM > 1000 THEN
    DBMS_OUTPUT.PUT_LINE('브론즈');
    WHEN V_SUM >= 1000 AND V_SUM < 2000 THEN
    DBMS_OUTPUT.PUT_LINE('실버');
    WHEN V_SUM >= 2000 AND V_SUM < 3000 THEN
    DBMS_OUTPUT.PUT_LINE('골드');
    WHEN V_SUM >= 3000 AND V_SUM < 4000 THEN
    DBMS_OUTPUT.PUT_LINE('플래티넘');
    ELSE
    DBMS_OUTPUT.PUT_LINE('다이아');
    
END CASE;
END;
/
--Package 패키지
--User function 사용자의 함수
--Stored Procedure 저장 프로시저
--Trigger 트리거
--Anonymous Block : 익명 블록

--CASE 문제 더 풀어보기
--회원테이블에서 지역이 대전인 회원을 검색하여
--회원수가 3명 미만이면  소모임 
--3명 이상 6명 미만이면 '써클'
--6명 이상 9명 미만이면 동아리
--그 이상이면 집회로 결과를 출력해보자
/
DECLARE
    V_NAME NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_NAME
    FROM MEMBER WHERE MEM_ADD1 LIKE '대전%';
CASE
    WHEN V_NAME < 3 THEN
    DBMS_OUTPUT.PUT_LINE('소모임');
    WHEN V_NAME >= 3 AND V_NAME < 6 THEN
    DBMS_OUTPUT.PUT_LINE('써클');
    WHEN V_NAME >= 6 AND V_NAME < 9 THEN
    DBMS_OUTPUT.PUT_LINE('동아리');
    ELSE
    DBMS_OUTPUT.PUT_LINE('집회');
END CASE;
END;
/
--P298
--WHILE : 반복될 때마다 조건을 확인
--1~10까지 더하기
/
DECLARE 
    V_SUM NUMBER := 0;
    V_VAR NUMBER := 1;
BEGIN
    WHILE V_VAR <= 10 LOOP
        V_SUM := V_SUM + V_VAR;
        V_VAR := V_VAR + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('1부터 10까지의 합=' || V_SUM);
END;
/
--P.298
--다중 WHILE문을 사용하여 구구단 만들기
/
DECLARE 
    V_VALUE NUMBER := 2;
    V_SUM NUMBER := 1;
BEGIN 
    WHILE V_VALUE < 10 LOOP
        DBMS_OUTPUT.PUT_LINE('---------'||V_VALUE || '단----------');
    WHILE V_SUM < 10 LOOP
        DBMS_OUTPUT.PUT_LINE(V_Value ||'*'|| V_SUM || '='|| V_VALUE * V_SUM);       
        V_SUM := V_SUM +1;
    END LOOP;         
         V_VALUE := V_VALUE + 1;
         V_SUM := 1;
    END LOOP;
END;
/
SELECT * 
FROM CART
WHERE CART_PROD = ?,?,?,?;

--CURSOR
--2005년도 상품별 매입수량의 합계
DECLARE
    V_PROD VARCHAR2(20);
    V_QTY NUMBER;
    --커서 선언
    CURSOR GAEDDONGI IS
        SELECT BUY_PROD, SUM(BUY_QTY) FROM BUYPROD
        WHERE EXTRACT(YEAR FROM BUY_DATE) = 2005
        GROUP BY BUY_PROD ORDER BY BUY_PROD ASC;
BEGIN
    --데이터를 메모리로 BIND(올림)
    OPEN GAEDDONGI;
    --작업 수행
    --다음 행을 가리킴. 페따출
    FETCH GAEDDONGI INTO V_PROD, V_QTY;
    --FETCH 했더니 데이터가 있니?
    WHILE GAEDDONGI%FOUND LOOP
    --있으면 출력
    DBMS_OUTPUT.PUT_LINE(V_PROD || ',' || V_QTY);
    FETCH GAEDDONIG INTO V_PROD, V_QTY;
    END LOOP;
    --데이터를 메모리에서 삭제
    CLOSE GAEDDONGI;
END;
/
--직업을 변수로 받아 이름 회원명과 마일리지를 출력하는 커서
ACCEPT V_JOB PROMPT '직업을 입력해주세요 :'
DECLARE
    V_NAME VARCHAR2(60);
    V_MILEAGE NUMBER;
    --SELECT 결과 집합에 CUR라는 이름을 붙임
    CURSOR CUR IS
        SELECT MEM_NAME
            , MEM_MILEAGE
        FROM   MEMBER
        WHERE  MEM_JOB = '&V_JOB';
BEGIN
    --집합을 메모리로 바인딩
    OPEN CUR;
    
    --페따출
    FETCH CUR INTO V_NAME, V_MILEAGE;
    --페치했더니 데이터가 있니?
    WHILE CUR%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(V_NAME || 
            ', ' || V_MILEAGE);
        FETCH CUR INTO V_NAME, V_MILEAGE;    
    END LOOP;
    
    --메모리에서 제거
    CLOSE CUR;
END;
/
---------------
--직업을 변수로 받아 이름 회원명과 마일리지를 출력하는 커서
ACCEPT V_JOB PROMPT '직업을 입력해주세요 :'
BEGIN
    FOR R IN ( SELECT MEM_NAME
            , MEM_MILEAGE
        FROM   MEMBER
        WHERE  MEM_JOB = '&V_JOB') LOOP 
     DBMS_OUTPUT.PUT_LINE(R.MEM_NAME||
     ',' || R.MEM_MILEAGE);
    END LOOP;
END;
/
--CURSOR문제
--회원별 매입금액 합 SUM(PROD_SALE * CART_QTY)
--이 2000000을 초과하는 회원을 출력해보자 
--ALIAS : 회원ID, 회원명, 매출금액합
DECLARE
    V_ID VARCHAR2(60);    
    V_NAME VARCHAR2(60);   
    V_SUM NUMBER;
    CURSOR CUR IS
        SELECT M.MEM_ID       회원ID
            , M.MEM_NAME     회원명
            ,SUM(P.PROD_SALE * C.CART_QTY)  매출금액합
        FROM   MEMBER M, CART C , PROD P 
        WHERE  M.MEM_ID = C.CART_MEMBER
        AND P.PROD_ID = C.CART_PROD
        GROUP BY M.MEM_ID , M.MEM_NAME
        HAVING SUM(P.PROD_SALE * C.CART_QTY) > 20000000;
BEGIN
    OPEN CUR;
    FETCH CUR INTO V_ID, V_NAME, V_SUM;
    WHILE CUR%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(V_ID || 
            ', ' || V_NAME || ',' ||V_SUM);
        FETCH CUR INTO V_ID, V_NAME, V_SUM;    
    END LOOP;
    CLOSE CUR;
END;
/
----반복문
BEGIN
    FOR R IN (SELECT M.MEM_ID, M.MEM_NAME
            , SUM(P.PROD_SALE * C.CART_QTY) SUM_QTY
        FROM   PROD P, CART C, MEMBER M
        WHERE  P.PROD_ID = C.CART_PROD
        AND    C.CART_MEMBER = M.MEM_ID
        GROUP BY M.MEM_ID, M.MEM_NAME
        HAVING SUM(P.PROD_SALE * C.CART_QTY)
        > 20000000) LOOP
        DBMS_OUTPUT.PUT_LINE(R.MEM_ID || ',' || R.MEM_NAME || ',' || R.SUM_QTY);
    END LOOP;    
END;
/
-- 
SELECT PROD_ID
,      PROD_TOTALSTOCK
FROM PROD
WHERE PROD_ID = 'P102000006';

UPDATE  PROD
SET PROD_TOTALSTOCK = PROD_TOTALSTOCK + 10
WHERE PROD_ID = 'P102000006';
--프로시저 생성
--BIND변수 : 매개변수(파라미터 인수)를 처리)
CREATE OR REPLACE PROCEDURE USP_UPDATE(
V_ID IN VARCHAR2,
V_TOTALSTOCK IN NUMBER)

IS
BEGIN
    UPDATE  PROD
    SET PROD_TOTALSTOCK = PROD_TOTALSTOCK + V_TOTALSTOCK
    WHERE PROD_ID = 'P102000006';
    
    EXCEPTIOn
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('오류발생 :'|| SQLERRM);
END;
/
EXEC USP_UPDATE('P102000006',50);
/
--프로시저 연습문제1
CREATE TABLE PROCTEST(
  PROC_SEQ NUMBER,
  PROC_CONTENT VARCHAR2(30),
  CONSTRAINT PK_PROCTEST PRIMARY KEY(PROC_SEQ)
);
SELECT * FROM PROCTEST;
--1-1) 프로시저 PROC_TEST1을 생성.
--실행하면 PROCTEST 테이블에 
--1, '개똥이' 데이터가 추가되도록 처리
CREATE OR REPLACE PROCEDURE PROC_TEST1(V_SEQ IN NUMBER)
IS
BEGIN
    INSERT INTO PROCTEST(PROC_SEQ, PROC_CONTENT) VALUES(V_SEQ,'개똥이1'||V_SEQ);
END;
/
EXEC PROC_TEST1(1);
/
--P305
--회원아이디를 입력받아 IN바인드변수 이름과 취미를 OUT 매개변수 OUT바인드변수로 처리
/
CREATE OR REPLACE PROCEDURE USP_MEMBERID(V_ID IN VARCHAR2,
V_NAME OUT VARCHAR2,
V_LIKE OUT VARCHAR2)
IS
BEGIN
SELECT MEM_NAME , MEM_LIKE INTO V_NAME, V_LIKE
FROM MEMBER
WHERE MEM_ID = 'a001';
END;
/
VAR V_NAME VARCHAR2(60)
VAR V_LIKE VARCHAR2(60)
EXEC  USP_MEMBERID('a001', :V_NAME , : V_LIKE)
PRINT V_NAME 
PRINT V_LIKE;
/
--회원아이디(MEM_ID) 및 점수를 입력받아 마일리지 점수(MEM_MILEAGE)를
--업데이트 하는 프로시저(usp_member_update)를 생성하기
--EXECUTE를 통해 김은대(a001)회원의 마일리지 값을 
--100씩 추가하여 5회에 걸쳐 500으로 올리기
CREATE OR REPLACE PROCEDURE USP_MEMBER_UPDATE(
V_ID IN VARCHAR2,
V_MILEAGE IN NUMBER)
IS
BEGIN
    UPDATE  MEMBER
    SET MEM_MILEAGE = MEM_MILEAGE + V_MILEAGE
    WHERE MEM_ID = V_ID;
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('오류발생 :'|| SQLERRM);
END;
/
EXEC USP_UPDATE('a001',100);
/
select MEM_ID
,      MEM_MILEAGE
FROM MEMBER
WHERE MEM_ID = 'a001';
--회원 아이디를 받으면 해당 이름을 리턴하는 함수 만들기
CREATE OR REPLACE FUNCTION FN_GETNAME(P_ID IN VARCHAR2)
--프로시저와 달리 함수에는 RETURN타입이 있음
    RETURN VARCHAR2
IS
    V_NAME VARCHAR2(60);
BEGIN
    SELECT MEM_NAME INTO V_NAME
    FROM MEMBER
    WHERE MEM_ID = P_ID;
    --프로시저와 달리 함수에는 RETURN타입이 있음
    RETURN V_NAME;
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('오류 발생 :'|| SQLERRM);
END;
/
SELECT FN_GETNAME('a001') FROM DUAL;
-------
SELECT PROD_ID  상품코드
,      PROD_NAME    상품명
,      PROD_LGU 대분류명
,      FN_GET_LPROD_NM(PROD_LGU) 대분류명
FROM PROD;
/
CREATE OR REPLACE FUNCTION FN_GET_LPROD_NM(P_GU IN VARCHAR2)
    RETURN VARCHAR2;
IS
    V_NM VARCHAR2(60);
BEGIN
    SELECT LPROD_NM INTO V_NM
    FROM LPROD WHERE LPROD_GU = P_GU;
    RETURN V_NM;
END;
/
---P308~ P.309
--년도 및 상품코드를 입력 받으면 해당년도의 평균 판매 횟수를 반환
CREATE OR REPLACE FUNCTION fn_prodAvgQty
(p_year In NUMBER DEFAULT (EXTRACT(YEAR FROM SYSDATE)),
p_prod_id IN VARCHAR2)
RETURN NUMBER
IS 
    r_qty NUMBER(10);
    v_year VARCHAR2(5) := TO_CHAR(p_year) || '%';
BEGIN 
    SELECT NVL(AVG(cart_qty),0) INTO r_qty FROM CART
        WHERE cart_prod = p_prod_id AND cart_no like v_year;
    RETURN r_qty;
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('예외발생:'|| SQLERRM);
            RETURN 0;
END;
/
VAR qty NUMBER
EXEC :qty := fn_prodAvgQty(2005, 'P101000002');
PRINT qty

SELECT prod_id
,      prod_name
,       fn_prodAvgQty(2004, prod_id) "2004년 평균 판매횟수"
,        fn_prodAvgQty(2005, prod_id) "2005년 평균 판매횟수"
FROM prod;
--트리거
CREATE OR REPLACE TRIGGER TG_LPROD_IN
AFTER INSERT 
ON LPROD
BEGIN
    DBMS_OUTPUT.PUT_LINE('상품분류가 추가되었습니다.');
END;
/
--만들어진 트리거 확인
SELECT TRIGGER_NAME FROM USER_TRIGGERS;
/
SET SERVEROUTPUT ON;
/
INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) VALUES(
            (SELECT MAX(LPROD_ID)+ 1 FROM LPROD),
                (SELECT 'P' || (SUBSTR(MAX(LPROD_GU),2)+1)FROM LPROD),
                '트리거추가값1');
/
SELECT * FROM LPROD;
DROP TRIGGER TG_LPORD_IN;
----트리거--

CREATE TABLE LPROD_BANK
AS
SELECT * FROM LPROD;
/
SELECT * FROM LPROD_BANK;
/
CREATE OR REPLACE TRIGGER TG_LPROD_IN
--LPROD 테이블에 데이터가 INSERT된 후에 BEGIN을 처리하자
AFTER INSERT
ON LPROD
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('상품분류가 추가되었습니다.');
    --NEW : 방금 INSERT된 새로운 그 행        
    INSERT INTO LPROD_BANK(LPROD_ID, LPROD_GU, LPROD_NM)
    VALUES(:NEW.LPROD_ID, :NEW.LPROD_GU, :NEW.LPROD_NM);
END;
/
--급여 정보를 자동 추가하는 트리거 작성하기 
--직원을 저장할 테이블 생성
CREATE TABLE EMP01(
     EMPNO NUMBER(4) PRIMARY KEY
,    EMPNAME VARCHAR2(45)
,    EMPJOB VARCHAR2(60)
);
--급여를 저장할 테이블 생성
CREATE TABLE SAL01(
    SALNO NUMBER(4) PRIMARY KEY,
    SAL NUMBER(7,2),
    EMPNO NUMBER(4) REFERENCES EMP01(EMPNO)
);
--급여번호를 자동 생성하는 시퀀스를 정의하고
--이 시퀀스로부터 일련번호를 얻어 급여번호에 부여 
CREATE SEQUENCE SAL01_SALNO_SEQ
START WITH 1
INCREMENT BY 1;
/
CREATE OR REPLACE TRIGGER TRG_02
--타이밍 : AFTER(~후에), 이벤트 : INSERT(입력)
AFTER INSERT
ON EMP01
FOR EACH ROW
BEGIN
    --NEW : EMP01테이블에 데이터를 입력한 그 행 
    INSERT INTO SAL01 VALUES(
    SAL01_SALNO_SEQ.NEXTVAL, 200, :NEW.EMPNO);
END;
/
INSERT INTO EMP01 VALUES(2201, '오재경', '프로그래머'); 
INSERT INTO EMP01 VALUES(2002, '김현석', '하얼빈흑룡파');
INSERT INTO EMP01 VALUES(2003, '박관우', '슈퍼맨');
/
SELECT * FROM EMP01;
SELECT * FROM SAL01;
SELECT * FROM EMP01 A, SAL01 B WHERE A.EMPNO = B.EMPNO;
/
--사원이 삭제되면 그 사원의 급여 정보도 자동삭제되는 트리거를 작성해 보도록 합시다
DELETE FROM EMP01 WHERE EMPNO=2003;
/*
사원번호 3을 급여 테이블에서 참조하고 있기 때문에 삭제가 불가능하다.
사원이 삭제되려면 그 사원의 급여 정보도 급여 테이블에서 삭제되어야 합니다.
사원의 정보가 제거 될 때 그 사원의 급여 정보도 함께 삭제하는 내용을 
트리거로 작성하도록 합시다.
*/
CREATE OR REPLACE TRIGGER TGR_03
--이벤트 : DELETE, 타이밍 : AFTER => EMP01 테이블의 데이터가 삭제된 후 BEGIN 실행
AFTER DELETE
ON EMP01
FOR EACH ROW
BEGIN 
    --OLD : 마지막행 삭제 
    DELETE FROM SAL01 
    WHERE EMPNO = :OLD.EMPNO;
END;
/
--패키지
CREATE OR REPLACE PACKAGE PROD_MGR
IS
--선언부
    --참조변수
    P_PROD_LGU  PROD.PROD_LGU%TYPE;  
    --프로시저
    PROCEDURE PROD_LIST;
    PROCEDURE PROD_LIST (P_PROD_LGU  IN  PROD.PROD_LGU%TYPE);
    --함수
    FUNCTION PROD_COUNT RETURN NUMBER;
    --예외형변수
    EXP_NO_PROD_LGU EXCEPTION;
END;

CREATE OR REPLACE PACKAGE BODY PROD_MGR 
  IS
    CURSOR PROD_CUR (V_LGU VARCHAR2) IS
     SELECT PROD_ID, PROD_NAME, TO_CHAR(PROD_SALE,'L999,999,999') PROD_SALE
     FROM PROD
     WHERE PROD_LGU = V_LGU;  
         
   PROCEDURE  PROD_LIST    IS     
    BEGIN
      IF P_PROD_LGU IS NULL THEN 
           RAISE EXP_NO_PROD_LGU;  
      END IF;
      FOR PROD_REC  IN PROD_CUR (P_PROD_LGU)  LOOP
          DBMS_OUTPUT.PUT_LINE(  PROD_REC.PROD_ID || ', '
                             || PROD_REC.PROD_NAME || ', ' || PROD_REC.PROD_SALE );
      END LOOP;
     EXCEPTION
        WHEN EXP_NO_PROD_LGU THEN
              DBMS_OUTPUT.PUT_LINE ( '상품 분류가 없습니다.'); 
        WHEN  OTHERS  THEN  
             DBMS_OUTPUT.PUT_LINE ( '기타 에러 :' || SQLERRM  ); 
   END PROD_LIST; 
PROCEDURE  PROD_LIST (P_PROD_LGU IN PROD.PROD_LGU%TYPE)
     IS     
   BEGIN
      FOR PROD_REC  IN PROD_CUR (P_PROD_LGU)  LOOP
          DBMS_OUTPUT.PUT_LINE(  PROD_REC.PROD_ID || ', '
                             || PROD_REC.PROD_NAME || ', ' || PROD_REC.PROD_SALE );
      END LOOP;
   EXCEPTION
     WHEN  OTHERS  THEN  
        DBMS_OUTPUT.PUT_LINE ( '기타 에러 :' || SQLERRM  ); 
  END PROD_LIST;  

   FUNCTION PROD_COUNT   
      RETURN NUMBER    
     IS  
       V_CNT NUMBER;
     BEGIN
        SELECT COUNT(*) INTO V_CNT FROM PROD WHERE PROD_LGU = P_PROD_LGU;
        RETURN V_CNT;
   END PROD_COUNT;  
END PROD_MGR;
/
---------------------패키지 쉬운 예제 -------------------
CREATE OR REPLACE PACKAGE PKG_EASY
IS
    V_NAME VARCHAR2(60);
    --회원의 아이디 및 숫자를 받아 마일리지 부여
    PROCEDURE PROC_MILEAGE_UP(P_ID IN VARCHAR2, P_MILEAGE IN NUMBER);
    --회원의 아이디를 받아 이름을 리턴
    FUNCTION  FN_GET_NAME(P_ID IN VARCHAR2)
        RETURN VARCHAR2;
END PKG_EASY;
/
CREATE OR REPLACE PACKAGE BODY PKG_EASY
IS
    --회원의 아이디 및 숫자를 받아 마일리지 부여->상세내용
    PROCEDURE PROC_MILEAGE_UP(P_ID IN VARCHAR2, P_MILEAGE IN NUMBER)
    IS
    BEGIN
        UPDATE MEMBER
        SET    MEM_MILEAGE = MEM_MILEAGE + P_MILEAGE
        WHERE  MEM_ID = P_ID;
    END PROC_MILEAGE_UP;
    
    --회원의 아이디를 받아 이름을 리턴->상세내용
    FUNCTION  FN_GET_NAME(P_ID IN VARCHAR2)
        RETURN VARCHAR2
    IS
    BEGIN
        SELECT MEM_NAME INTO V_NAME FROM MEMBER WHERE MEM_ID = P_ID;
        RETURN V_NAME;
    END FN_GET_NAME;
END PKG_EASY;
/
--여기까지 컴파일을 함
EXEC PKG_EASY.PROC_MILEAGE_UP('a001',500);
/
SELECT MEM_ID, MEM_MILEAGE FROM MEMBER WHERE MEM_ID = 'a001';
/

create table mymember(
    mem_id varchar2(8) not null,  -- 회원ID
    mem_name varchar2(100) not null, -- 이름
    mem_tel varchar2(50) not null, -- 전화번호
    mem_addr varchar2(128),    -- 주소
    reg_dt DATE DEFAULT sysdate, -- 등록일
    CONSTRAINT MYMEMBER_PK PRIMARY KEY (mem_id)
);

delete from atch_file_detail
where atch_file_id=27;

SELECT *
FROM SAPO
WHERE SAPO_BRNM LIKE '버%';


ALTER TABLE ADDRESS
ADD (CONSTRAINT R_293 FOREIGN KEY (USER_ID) REFERENCES MEMBER(USER_ID));