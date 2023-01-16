CREATE TABLE BOOK(
    BOOK_ID NUMBER NOT NULL,
    TITLE VARCHAR2(600) NOT NULL,
    CATEGORY VARCHAR2(600) NOT NULL,
    PRICE NUMBER,
    INSERT_DATE DATE,
    CONSTRAINT PK_BOOK PRIMARY KEY(BOOK_ID)
    
);

COMMENT ON TABLE BOOK IS '��������';
COMMENT ON COLUMN BOOK.BOOK_ID IS '���� �ڵ�';
COMMENT ON COLUMN BOOK.TITLE IS '����';
COMMENT ON COLUMN BOOK.CATEGORY IS 'ī�װ���';
COMMENT ON COLUMN BOOK.PRICE IS '����';
COMMENT ON COLUMN BOOK.INSERT_DATE IS '�Է�����';

SELECT *
FROM BOOK;




/
create or replace FUNCTION FN_GETCAMEL(COLUMN_NAME IN VARCHAR2)
RETURN VARCHAR2
IS
RSLT VARCHAR2(30);
BEGIN
--ī��ǥ��� ��ȯ(SITE_NUM -> siteNum)
SELECT LOWER(SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),1,1))
|| SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),2) INTO RSLT
FROM DUAL;
--����
RETURN RSLT;
END;
/

--���� ī�ắȯ(https://heavenly-appear.tistory.com/270)
/
SELECT COLUMN_NAME
, DATA_TYPE
, CASE WHEN DATA_TYPE='NUMBER' THEN 'private int ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE IN('VARCHAR2','CHAR') THEN 'private String ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE='DATE' THEN 'private Date ' || FN_GETCAMEL(COLUMN_NAME) || ';'
ELSE 'private String ' || FN_GETCAMEL(COLUMN_NAME) || ';'
END AS CAMEL_CASE
, '' RESULTMAP
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'INSURERE';
/
INSERT INTO BOOK(BOOK_ID, TITLE, CATEGORY, PRICE, INSERT_DATE) VALUES(1, '������ ����', '�Ҽ�', 10000, SYSDATE);
SELECT * FROM BOOK;

SELECT NVL(MAX(BOOK_ID),0)+1 FROM BOOK;



--==================================== PRODUCT =================================================================================
CREATE TABLE PRODUCT(
    BOOK_ID NUMBER NOT NULL,
    TITLE VARCHAR2(600) NOT NULL,
    CATEGORY VARCHAR2(600) NOT NULL,
    PRICE NUMBER,
    INSERT_DATE DATE,
    CONSTRAINT PK_BOOK PRIMARY KEY(BOOK_ID)
    
);

COMMENT ON TABLE BOOK IS '��������';
COMMENT ON COLUMN BOOK.BOOK_ID IS '���� �ڵ�';
COMMENT ON COLUMN BOOK.TITLE IS '����';
COMMENT ON COLUMN BOOK.CATEGORY IS 'ī�װ���';
COMMENT ON COLUMN BOOK.PRICE IS '����';
COMMENT ON COLUMN BOOK.INSERT_DATE IS '�Է�����';

SELECT *
FROM BOOK;

INSERT INTO VALUES();


/
create or replace FUNCTION FN_GETCAMEL(COLUMN_NAME IN VARCHAR2)
RETURN VARCHAR2
IS
RSLT VARCHAR2(30);
BEGIN
--ī��ǥ��� ��ȯ(SITE_NUM -> siteNum)
SELECT LOWER(SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),1,1))
|| SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_'),2) INTO RSLT
FROM DUAL;
--����
RETURN RSLT;
END;
/

--���� ī�ắȯ(https://heavenly-appear.tistory.com/270)
SELECT COLUMN_NAME
, DATA_TYPE
, CASE WHEN DATA_TYPE='NUMBER' THEN 'private int ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE IN('VARCHAR2','CHAR') THEN 'private String ' || FN_GETCAMEL(COLUMN_NAME) || ';'
WHEN DATA_TYPE='DATE' THEN 'private Date ' || FN_GETCAMEL(COLUMN_NAME) || ';'
ELSE 'private String ' || FN_GETCAMEL(COLUMN_NAME) || ';'
END AS CAMEL_CASE
, '' RESULTMAP
FROM ALL_TAB_COLUMNS
WHERE TABLE_NAME = 'CERTIFICATE_ORDER';

INSERT INTO BOOK(BOOK_ID, TITLE, CATEGORY, PRICE, INSERT_DATE) VALUES(1, '������ ����', '�Ҽ�', 10000, SYSDATE);
SELECT * FROM BOOK;

SELECT NVL(MAX(BOOK_ID),0)+1 FROM BOOK;

INSERT INTO PRODUCT(PRODUCT_ID,PNAME,UNIT_PRICE,DESCRIPTION,MANUFACTURER,CATEGORY,UNITS_IN_STOCK,CONDITION) VALUES('1','1','1','1','1','1','1','1')
SELECT * FROM PRODUCT


SELECT BOOK_ID, TITLE, CATEGORY, PRICE, INSERT_DATE
FROM BOOK
ORDER BY INSERT_DATE DESC;

UPDATE BOOK
SET    TITLE='�����̸���', CATEGORY='��Ÿ��', PRICE=12000
WHERE BOOK_ID=1;
commit;
rollback;

DELETE 
FROM BOOK
WHERE BOOK_ID=9;


SELECT PRODUCT_ID,PNAME,UNIT_PRICE,DESCRIPTION,MANUFACTURER,CATEGORY,UNITS_IN_STOCK,CONDITION
FROM PRODUCT
WHERE PRODUCT_ID ='P1235';

UPDATE PRODUCT
SET   PNAME='1',UNIT_PRICE='1',DESCRIPTION='1',MANUFACTURER='1',CATEGORY='1',UNITS_IN_STOCK='1',CONDITION='1'
WHERE product_id ='P1234';
commit;
rollback;

DELETE 
FROM PRODUCT
WHERE PRODUCT_ID='P1235'


DROP TABLE PRODUCT;

SQL>INSERT INTO book
    (SELECT * FROM emp AS OF TIMESTAMP TO_TIMESTAMP('2006-01-21 17:16:51', 'YYYY-MM-DD HH24:MI:SS'));
    
Insert into JSPEXAM.PRODUCT (PRODUCT_ID,PNAME,UNIT_PRICE,DESCRIPTION,MANUFACTURER,CATEGORY,UNITS_IN_STOCK,CONDITION,FILENAME) values ('P1234','iPhone 6s',800000,'4.7-inch, 1334X750 Renina HD display','Smart Phone','Apple',1000,'New','P1234.jpg');
Insert into JSPEXAM.PRODUCT (PRODUCT_ID,PNAME,UNIT_PRICE,DESCRIPTION,MANUFACTURER,CATEGORY,UNITS_IN_STOCK,CONDITION,FILENAME) values ('P1235','LG PC �׷�',1500000,'13.3-inch, IPS LED display','Notebook','LG',1000,'Refurbished','P1235.jpg');
Insert into JSPEXAM.PRODUCT (PRODUCT_ID,PNAME,UNIT_PRICE,DESCRIPTION,MANUFACTURER,CATEGORY,UNITS_IN_STOCK,CONDITION,FILENAME) values ('P1236','Galaxy Tab S',920000,'212.8*125.6*6.6mm, Super AMOLED display','Tablet','Samsung',2000,'Refurbished','P1236.jpg');
Insert into JSPEXAM.PRODUCT (PRODUCT_ID,PNAME,UNIT_PRICE,DESCRIPTION,MANUFACTURER,CATEGORY,UNITS_IN_STOCK,CONDITION,FILENAME) values ('P123456','�����ڵ���',10000,'�����ڵ���','�����ڵ���','�����ڵ���',0,'Old','P1237.jpg');

INSERT INTO CART(CART_ID, NAME, SHIPPING_DATE, COUNTRY, ZIP_CODE, ADDRESS_NAME, ADDRESS_DETAIL, REGIST_DT) VALUES()

CREATE TABLE BOOK_MARKET(
    BOOK_ID   VARCHAR2(20) NOT NULL,
    NAME   VARCHAR2(150) NOT NULL,
    UNIT_PRICE   NUMBER  NOT NULL,
    AUTHOR  VARCHAR2(150),
    DESCRIPTION   VARCHAR2(1000),
    PUBLISHER   VARCHAR2(60),
    CATEGORY   VARCHAR2(90) NOT NULL,
    UNITS_IN_STOCK   NUMBER,
    TOTAL_PAGES  NUMBER,
    RELEASE_DATE VARCHAR2(30),
    CONDITION   VARCHAR2(30),
    FILENAME   VARCHAR2(1000),
    QUANTITY   NUMBER,
    CONSTRAINT PK_BOOK_MARKET PRIMARY KEY(BOOK_ID)
);
    
    
    CONSTRAINT PK_BOOK PRIMARY KEY(BOOK_ID)
    
);

COMMENT ON TABLE BOOK_MARKET IS '��������';
COMMENT ON COLUMN BOOK_MARKET.BOOK_ID IS '���� �ڵ�';
COMMENT ON COLUMN BOOK_MARKET.NAME IS '������';
COMMENT ON COLUMN BOOK_MARKET.UNIT_PIRCE IS '����';
COMMENT ON COLUMN BOOK_MARKET.AUTHOR IS '����';
COMMENT ON COLUMN BOOK_MARKET.DESCRIPTION IS '����';
COMMENT ON COLUMN BOOK_MARKET.PUBLISHER IS '���ǻ�';
COMMENT ON COLUMN BOOK_MARKET.CATEGORY IS 'ī�װ���';
COMMENT ON COLUMN BOOK_MARKET.UNITS_IN_STOCK IS '��� ��';
COMMENT ON COLUMN BOOK_MARKET.TOTAL_PAGES IS '������ ��';
COMMENT ON COLUMN BOOK_MARKET.RELEASE_DATE IS '������';
COMMENT ON COLUMN BOOK_MARKET.CONDITION IS '����';
COMMENT ON COLUMN BOOK_MARKET.FILENAME IS '���ϸ�';
COMMENT ON COLUMN BOOK_MARKET.QUANTITY IS '����';

CREATE TABLE ITEM(
    ITEM_ID NUMBER,
    ITEM_NAME VARCHAR2(150),
    PRICE NUMBER,
    DESCRIPTION VARCHAR2(300),
    PICTURE_URL VARCHAR2(300),
    CONSTRAINT PK_ITEM PRIMARY KEY(ITEM_ID)
);

CREATE TABLE ITEM2(
    ITEM_ID NUMBER,
    ITEM_NAME VARCHAR2(150),
    PRICE NUMBER,
    DESCRIPTION VARCHAR2(300),
    PICTURE_URL VARCHAR2(300),
    PICTURE_URL2 VARCHAR2(300),
    CONSTRAINT PK_ITEM2 PRIMARY KEY(ITEM_ID)
);
CREATE TABLE ITEM3(
    ITEM_ID NUMBER,
    ITEM_NAME VARCHAR2(150),
    PRICE NUMBER,
    DESCRIPTION VARCHAR2(300),
    CONSTRAINT PK_ITEM3 PRIMARY KEY(ITEM_ID)
);

CREATE TABLE ITEM_ATTACH(
    SEQ NUMBER,
    ITEM_ID NUMBER,
    FULLNAME VARCHAR2(300),
    REGDATE DATE,
    CONSTRAINT PK_ITEM_ATTACH PRIMARY KEY(SEQ)
);

COMMENT ON TABLE ITEM2 IS '��ǰ2';
COMMENT ON COLUMN ITEM2.ITEM_ID IS '��ǰ ���̵�';
COMMENT ON COLUMN ITEM2.ITEM_NAME IS '��ǰ ��';
COMMENT ON COLUMN ITEM2.PRICE IS '����';
COMMENT ON COLUMN ITEM2.DESCRIPTION IS '����';
COMMENT ON COLUMN ITEM2.PICTURE_URL IS '��ǰ �̹���1';
COMMENT ON COLUMN ITEM2.PICTURE_URL2 IS '��ǰ �̹���2';

CREATE TABLE ATTACH(
    SEQ NUMBER,
    TID VARCHAR2(30),
    NAME VARCHAR2(300),
    ATTACH_SIZE NUMBER,
    ATTACH_TYPE VARCHAR2(30),
    REGIST_DATE DATE,
    CONSTRAINT PK_ATTACH PRIMARY KEY(SEQ)
);

INSERT ALL
INTO ATTACH VALUES(1, 'P1238', '1', 2, 'jpeg', sysdate)
INTO ATTACH VALUES(2, 'P1238', '2', 2, 'jpeg', sysdate)
INTO ATTACH VALUES(3, 'P1238', '3', 2, 'jpeg', sysdate)
SELECT * FROM SYS.DUAL;

INSERT INTO BOOK_MARKET(BOOK_ID, NAME, UNIT_PRICE, AUTHOR, DESCRIPTION, PUBLISHER, CATEGORY, UNITS_IN_STOCK, TOTAL_PAGES, RELEASE_DATE, CONDITION, FILENAME, QUANTITY) 
VALUES('B1233'	,'C++',	44850	,'��ȣ��',	'C++�Ѵ޸��� �ϱ� Ư���ϱ�',	'JJAn','C++', 93,399,	'2021-11-11','NEW',	'B1233.png',84);

INSERT INTO BOOK_MARKET(BOOK_ID, NAME, UNIT_PRICE, AUTHOR, DESCRIPTION, PUBLISHER, CATEGORY, UNITS_IN_STOCK, TOTAL_PAGES, RELEASE_DATE, CONDITION, FILENAME, QUANTITY) 
VALUES('B1234'	,'�ȱ��� ��߰�',	24850	,'������',	'�ȱ�� �ְ� �ǰ� ���� ȭ����',	'ohoh','�ȱ�', 65,890,	'2022-11-08','NEW',	'B1234.png',94);

SELECT BOOK_ID, NAME, UNIT_PRICE, AUTHOR, DESCRIPTION, PUBLISHER, CATEGORY, UNITS_IN_STOCK, TOTAL_PAGES, RELEASE_DATE, CONDITION, FILENAME, QUANTITY
FROM BOOK_MARKET;
WHERE 1 = 1
AND   BOOK_ID LIKE '%' || #{keyWord} || '%' 
OR 	  CATEGORY LIKE '%' || #{keyWord} || '%'
ORDER BY INSERT_DATE DESC

--LEFT JOIN
SELECT P.PRODUCT_ID,P.PNAME, P.UNIT_PRICE, P.DESCRIPTION, P.MANUFACTURER, P.CATEGORY, P.UNITS_IN_STOCK, P.CONDITION, P.FILENAME, A.ATTACH_NAME
FROM PRODUCT P, ATTACH A
WHERE P.PRODUCT_ID = A.TID(+)
AND    P.PRODUCT_ID = 'P1237'
AND A.SEQ=1;

-- ��������
SELECT P.PRODUCT_ID,P.PNAME
, P.UNIT_PRICE
, P.DESCRIPTION
, P.MANUFACTURER
, P.CATEGORY
, P.UNITS_IN_STOCK
, P.CONDITION
, (SELECT A.ATTACH_NAME FROM ATTACH A 
    WHERE P.PRODUCT_ID = A.TID
    AND A.SEQ = 1) FILENAME
FROM PRODUCT P
WHERE P.PRODUCT_ID ='P1238';

INSERT INTO MEMBER(USER_ID,PASSWORD,COIN,BIRTH,GENDER,NATIONALITY,MARRIAGED,CARS,HOBBY_LIST)
VALUES('a001','java',100,'2022-11-01','male','korea','false','gm6,volvo','moovie,book');

INSERT INTO ADDRESS(USER_ID, POST_CODE, ADDRESS, ADDRESS_DETAIL)
VALUES('a001','12345','���� �߱� �߾ӷ�12','������ ����');

INSERT INTO CARD(USER_ID, NO, VALID_MONTH) 
VALUES('a001',
(SELECT NVL(MAX(NO),0)+1 FROM CARD WHERE USER_ID='a001'), '2022-11-01');

INSERT INTO CARD(USER_ID, NO, VALID_MONTH) 
VALUES('a001','12346','2022-11-01');

WITH T AS(
SELECT  ROW_NUMBER() OVER (ORDER BY MEM_ID) RNUM,
		MEM_ID,
		MEM_NAME,
		MEM_HP,
		MEM_JOB,
		MEM_LIKE
		FROM
		MEM
        WHERE 1=1
        AND (MEM_ID LIKE '%01%' 
        OR MEM_NAME LIKE '%01%'
        OR MEM_HP   LIKE '%01%'
        OR MEM_JOB  LIKE '%01%'
        OR MEM_LIKE LIKE '%01%')
)
SELECT COUNT(*) FROM MEM
WHERE MEM_ID = 'a001'

SELECT * FROM T
WHERE T.RNUM BETWEEN 1 * 10 -9  AND 1 * 10;
DECLARE
BEGIN
    FOR I IN 101..355 LOOP
    INSERT INTO MEM(MEM_ID, MEM_NAME, MEM_HP, MEM_JOB, MEM_LIKE) 
    VALUES('z'||TRIM(TO_CHAR(I,'000')),	'������'||TRIM(TO_CHAR(I,'000')),'010-621-4615',	'���','���ڱ�');
    END LOOP;
END;
/
SELECT TO_CHAR(2,'100') FROM DUAL;

SELECT COUNT(*) FROM MEM;

CREATE TABLE CHATTING_USER(
    NO NUMBER NOT NULL,
    USER_ID VARCHAR2(600) NOT NULL,
    PASSWORD VARCHAR2(600) NOT NULL,
    NAME VARCHAR2(600) 
);
DROP TABLE CHATTING_USER;

CREATE TABLE BOM(
    ITEM_ID NUMBER,
    PARENT_ID NUMBER,
    ITEM_NAME VARCHAR2(150),
    ITEM_QTY NUMBER,
    CONSTRAINT PK_BOM PRIMARY KEY(ITEM_ID)
);
COMMENT ON TABLE BOM IS '��ǻ�� ���� ����';
COMMENT ON COLUMN BOM.ITEM_ID IS 'ǰ�� �ĺ���';
COMMENT ON COLUMN BOM.PARENT_ID IS '���� ǰ�� �ĺ���';
COMMENT ON COLUMN BOM.ITEM_NAME IS 'ǰ�� �̸�';
COMMENT ON COLUMN BOM.ITEM_QTY IS 'ǰ�� ����';


INSERT INTO BOM VALUES ( 1001, NULL, '��ǻ��', 1);
INSERT INTO BOM VALUES ( 1002, 1001, '��ü', 1);
INSERT INTO BOM VALUES ( 1003, 1001, '�����', 1);
INSERT INTO BOM VALUES ( 1004, 1001, '������', 1);

INSERT INTO BOM VALUES ( 1005, 1002, '���κ���', 1);
INSERT INTO BOM VALUES ( 1006, 1002, '��ī��', 1);
INSERT INTO BOM VALUES ( 1007, 1002, '�Ŀ����ö���', 1);
INSERT INTO BOM VALUES ( 1008, 1005, 'CPU', 1);
INSERT INTO BOM VALUES ( 1009, 1005, 'RAM', 1);
INSERT INTO BOM VALUES ( 1010, 1005, '�׷���ī��', 1);
INSERT INTO BOM VALUES ( 1011, 1005, '��Ÿ',1);

SELECT ITEM_NAME
,       ITEM_ID
,       PARENT_ID
FROM BOM
START WITH PARENT_ID IS NULL
CONNECT BY PRIOR ITEM_ID = PARENT_ID;

CREATE TABLE AMUMAL(
    NO NUMBER,
    TITLE VARCHAR2(90),
    WRITER VARCHAR2(60),
    PNO NUMBER,
    CONSTRAINT PK_AMUMAL PRIMARY KEY (NO)
);

INSERT INTO AMUMAL VALUES(1,'������ ����','ȫ�浿',NULL);   
INSERT INTO AMUMAL VALUES(2,'�¾� ����','��ö��',1);   
INSERT INTO AMUMAL VALUES(3,'�׷��� ��������','ȫ�浿',1);   
INSERT INTO AMUMAL VALUES(4,'���� �׷�','��ȫö',3);   
INSERT INTO AMUMAL VALUES(5,'�׷� ����','����ö',4);   
INSERT INTO AMUMAL VALUES(6,'���峭 ������','��ȫö',4);   
INSERT INTO AMUMAL VALUES(7,'���峭 ������','����ö',4);   
INSERT INTO AMUMAL VALUES(8,'�׷���','������',3);   
INSERT INTO AMUMAL VALUES(9,'������ �Ͷ�','������',3);   
INSERT INTO AMUMAL VALUES(10,'�׷��� ������ ����','�ڸ���',1);   

SELECT NO
     , LPAD('��',2*(LEVEL-1)) || TITLE AS TITLE
     , WRITER
     , PNO 
FROM   AMUMAL
START WITH PNO IS NULL
CONNECT BY PRIOR NO = PNO;

SELECT M.MEM_ID, M.MEM_NAME, M.MEM_HP, M.MEM_JOB, M.MEM_LIKE, A.SEQ, A.TID, A.ATTACH_NAME
FROM MEM M LEFT OUTER JOIN  ATTACH A ON(M.MEM_ID =A.TID)
WHERE M.MEM_ID='a001';

ROLLBACK;

INSERT INTO MEM(USER_NO, USER_ID, USER_PW, USER_NAME, USER_EMAIL, 
                    UPD_DATE)
VALUES();

INSERT ALL ATTACH
INTO ATTACH VALUES(4, 'a001', 'attach01',0,'image/png',SYSDATE)
INTO ATTACH VALUES(5, 'a001', 'attach01',0,'image/png',SYSDATE)
SELECT * FROM DUAL;

SELECT MAX(SEQ+1 FROM ATTACH
WHERE TID='a001';

VALUES()



-- ���� ����+001
SELECT TO_CHAR(SYSDATE, 'YYYYMM') + '001' FROM DUAL;

-- ���� ������ �ش��ϴ� MEM �����Ͱ� �ִ���?
SELECT NVL(MAX(USER_NO), TO_CHAR(SYSDATE, 'YYYYMM"000"')) +1 FROM MEM
WHERE TO_CHAR(SYSDATE, 'YYYYMM') = SUBSTR(USER_NO, 1,6);

CREATE TABLE MEM_BAK
AS
SELECT *
FROM MEM;
DROP TABLE MEM;

CREATE TABLE MEM(
    USER_NO NUMBER,
    USER_ID VARCHAR2(30),
    USER_PW VARCHAR2(150),
    USER_NAME VARCHAR2(150),
    USER_EMAIL VARCHAR2(50),
    COIN NUMBER,
    REG_DATE DATE,
    UPD_DATE DATE,
    ENABLED VARCHAR2(10),
    FILENAME VARCHAR2(500),
    CONSTRAINT PK_MEM PRIMARY KEY(USER_NO)
);

CREATE TABLE ATTACH_BAK
AS
SELECT * FROM ATTACH;

DROP TABLE ATTACH;

CREATE TABLE ATTACH(
    USER_NO NUMBER,
    SEQ NUMBER,
    FILENAME VARCHAR2(100),
    FILESIZE NUMBER,
    REGDATE DATE,
    CONSTRAINT PK_ATTACH PRIMARY KEY(USER_NO, SEQ)
);
SELECT A.USER_NO , A.SEQ, A.FILENAME,
        M.USER_NO, M.USER_ID, M.USER_NAME
FROM MEM M LEFT OUTER JOIN  ATTACH A ON(M.USER_NO = A.USER_NO)
WHERE M.USER_ID='a001';

-- �ڷ����� ũ�Ⱑ ������ �ܷ�Ű ���� ������ �����ϰ� 
-- �ڷ����� ������ ������ ���� 
SELECT M.USER_NO, M.USER_ID, M.USER_PW, M.USER_NAME, M.USER_EMAIL
     , M.COIN, M.REG_DATE, M.UPD_DATE, M.ENABLED
     , A.FILENAME
FROM   MEM M, ATTACH A
WHERE  M.USER_ID = A.USER_NO
AND    M.USER_NO = '202211001';

SELECT M.USER_NO, M.USER_ID, M.USER_NAME, A.SEQ, A.FILENAME
		FROM   MEM M LEFT OUTER JOIN ATTACH A ON(M.USER_ID = A.USER_NO);

SELECT COUNT(*)
FROM MEM
WHERE USER_NO = '202211001' AND USER_PW = '1234';

SELECT M.USER_NO, M.USER_ID, M.USER_PW, M.USER_NAME, M.USER_EMAIL
	     , M.COIN, M.REG_DATE, M.UPD_DATE, M.ENABLED
	     , A.FILENAME
		FROM   MEM M, ATTACH A
		WHERE  M.USER_ID = A.USER_NO
		AND    M.USER_NO ='202211005';

-- ������Ʈ 
UPDATE MEM
SET USER_NAME ='��ö��', USER_EMAIL='test@test.com', UPD_DATE=SYSDATE 
WHERE USER_NO ='202211005';
rollback
commit;

DELETE 
FROM MEM
WHERE USER_NO='202211002';

ALTER TABLE ATTACH 
ADD (ATTACH_NAME VARCHAR2(300),
    ATTACH_SIZE NUMBER, 
    ATTACH_TYPE VARCHAR2(30)
    );
    
CREATE TABLE USERS(
    USERNAME VARCHAR2(150),
    PASSWORD VARCHAR2(150),
    ENABLED VARCHAR2(1),
    CONSTRAINT PK_USERS PRIMARY KEY(USERNAME)
);    
    
COMMENT ON TABLE USERS IS '����� ���� ���̺�';
COMMENT ON COLUMN USERS.USERNAME IS '���̵�';
COMMENT ON COLUMN USERS.PASSWORD IS '��й�ȣ';
COMMENT ON COLUMN USERS.ENABLED IS '��뿩��';

CREATE TABLE AUTHORITIES(
    USERNAME VARCHAR2(150),
    AUTHORITY VARCHAR2(150),
    CONSTRAINT PK_AUTHORITIES PRIMARY KEY(USERNAME),
    CONSTRAINT FK_AUTHORITIES FOREIGN KEY(USERNAME)
            REFERENCES USERS(USERNAME)
);
rollback
COMMENT ON TABLE AUTHORITIES IS '����� ���� ����';
COMMENT ON COLUMN AUTHORITIES.USERNAME IS '���̵�';
COMMENT ON COLUMN AUTHORITIES.AUTHORITY IS '����';

INSERT INTO USERS(USERNAME, PASSWORD) VALUES('user00', '1234');
INSERT INTO USERS(USERNAME, PASSWORD) VALUES('member00', '1234');
INSERT INTO USERS(USERNAME, PASSWORD) VALUES('admin00', '1234');

INSERT INTO AUTHORITIES(USERNAME, AUTHORITY) VALUES('user00', 'ROLE_USER');
INSERT INTO AUTHORITIES(USERNAME, AUTHORITY) VALUES('member00', 'ROLE_MEMBER');
INSERT INTO AUTHORITIES(USERNAME, AUTHORITY) VALUES('admin00', 'ROLE_MEMBER');
INSERT INTO AUTHORITIES(USERNAME, AUTHORITY) VALUES('admin00', 'ROLE_ADMIN');


-- MEMBER ���̺��� ���� MEMBER_BAK ���̺��� �����غ��� 
CREATE TABLE MEMBER_BAK
AS
SELECT * FROM MEMBER;

--MEMBER���̺� DROP 
DROP TABLE MEMBER;
DELT
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'MEMBER';

--�⺻Ű �������
CREATE TABLE MEMBER
AS
SELECT * FROM MEM_BAK;

SELECT MEM_ID ,MEM_PASS, ENABLED FROM MEMBER
WHERE MEM_ID='a001';

--���� 
SELECT * 
FROM MEMBER M, MEMBER_AUTH MA
WHERE M.MEM_ID = MA.MEM_ID
AND M.MEM_ID ='a001';
--
SELECT * 
FROM MEMBER A LEFT OUTER JOIN MEMBER_AUTH AUTH ON(A.MEM_ID = AUTH.MEM_ID)
WHERE A.MEM_ID ='a001';

SELECT A.MEM_ID, 
A.MEM_NAME, 
A.MEM_HP, 
A.MEM_JOB, 
A.MEM_LIKE, 
A.MEM_PASS, 
A.ENABLED
     , AUTH.AUTH
FROM   MEMBER A LEFT OUTER JOIN MEMBER_AUTH AUTH ON(A.MEM_ID = AUTH.MEM_ID)
WHERE  A.MEM_ID = 'a001';

SELECT A.MEM_ID, 
			A.MEM_NAME, 
			A.MEM_HP, 
			A.MEM_JOB, 
			A.MEM_LIKE, 
			A.MEM_PASS, 
			A.ENABLED,
	     	AUTH.AUTH
		FROM   MEMBER A LEFT OUTER JOIN MEMBER_AUTH AUTH ON(A.MEM_ID = AUTH.MEM_ID)
		WHERE  A.MEM_ID = 'a001';
COMMIT;

CREATE TABLE PERSISTENT_LOGINS(
    USERNAME VARCHAR2(150),
    SERIES VARCHAR2(150),
    TOKEN VARCHAR2(150),
    LAST_USED DATE,
    CONSTRAINT PK_PL PRIMARY KEY(SERIES)
);

SELECT BOOK_ID, TITLE, CATEGORY, PRICE, INSERT_DATE 
FROM BOOK
ORDER BY BOOK_ID ASC;

commit;

-- VARCHAR2 : 4000Bytes ����
--CLOB(Character Large Object) : 4GB ����
--BLOB(Binary large Object) :2GB. ���̳ʸ�(�̹���, ������, ����) 
SELECT *                                    ��ȸ�� �÷��� �����Ѵ� (��� �÷� ��ȸ)
  FROM TABLE1  T1                             
  INNER JOIN TABLE2  T2              INNER �� ��������
  ON (T1.KEY = T2.KEY)  
-- BOOK ���̺��� ATTACH���̺��� INNER JOIN 
SELECT A.BOOK_ID, A.TITLE, A.CATEGORY, A.PRICE, A.INSERT_DATE, A.CONTENT, 
        B.USER_NO, B.SEQ, B.FILENAME, B.FILESIZE, B.REGDATE
FROM BOOK A INNER JOIN  ATTACH B ON(A.BOOK_ID = B.USER_NO);

UPDATE  ATTACH
SET     FILENAME = '/2022/11/16/ASDFLDAS_������.JPG'
WHERE USER_NO = 3 AND SEQ = 5;

DELETE 
FROM ATTACH
WHERE SEQ =6;

WITH T AS(
SELECT A.BOOK_ID, A.TITLE, A.CATEGORY, A.PRICE, A.INSERT_DATE, A.CONTENT,
        B.USER_NO, B.SEQ, B.FILENAME, B.FILESIZE, B.REGDATE
FROM BOOK A LEFT OUTER JOIN ATTACH B ON(A.BOOK_ID = B.USER_No)
)
SELECT * FROM T
WHERE 1=1
AND(TITLE LIKE '%��%' OR CATEGORY LIKE '%������%' OR CONTENT LIKE '%��%' );

INSERT ALL
INTO ATTACH(USER_NO, SEQ, FILENAME, FILESIZE, REGDATE) VALUES(15,1,'ASDF.JPG',200,SYSDATE)
INTO ATTACH(USER_NO, SEQ, FILENAME, FILESIZE, REGDATE) VALUES(15,2,'BSDF.JPG',300,SYSDATE)
INTO ATTACH(USER_NO, SEQ, FILENAME, FILESIZE, REGDATE) VALUES(15,3,'CSDF.JPG',100,SYSDATE)
SELECT * FROM DUAL;

SELECT NVL(MAX(SEQ),0)+1 FROM ATTACH WHERE USER_NO = 15;

CREATE TABLE CART_DET_BAK
AS
SELECT *
FROM CART_DET;

DROP TABLE CART;

drop table CART_DET cascade constraints;

--pc������ lprodc ���̺� �����͸� jspexam���� ���������� 

--��ǰ �� �Ǹűݾ��� �հ踦 ���غ���
--alias : prod_name, money(prod_sale * cart_qty)
--��, money ���� 10000000 �̻��� �����͸� �����ͺ���
--1) cart �� cart_det ���̺��� ����ϰ�(���̺���_bak)
--      cart���̺� �� cart_det ���̺��� drop
--2) pc##������ prod �� cart ���̺��� ��������
SELECT PROD_NAME prodName, 
        SUM(PROD_SALE * CART_QTY) MONEY
FROM PROD,CART 
WHERE PROD_ID = CART_PROD
GROUP BY PROD_NAME
HAVING SUM(PROD_SALE * CART_QTY) >=10000000;

--LPROD ���̺��� LPROD2 ���̺��� �����غ��� 
CREATE TABLE LPROD2
AS
SELECT *
FROM LPROD;
/
SELECT * FROM LPROD2
/
MERGE INTO LPROD2 A --��� ���̺�
USING DUAL
ON(A.LPROD_GU = 'P405') --������(�ַ� �⺻Ű ������)
WHEN MATCHED THEN --�������� �ش��ϴ� �����Ͱ� ������ ����
    UPDATE SET A.LPROD_CNT = A.LPROD_CNT + 1
WHEN NOT MATCHED THEN --�������� �ش��ϴ� �����Ͱ� ������ ����
    INSERT (LPROD_ID, LPROD_GU, LPROD_NM, LPROD_CNT)
    VALUES((SELECT NVL(MAX(LPROD_ID),0)+1 FROM LPROD2)
    ,(SELECT SUBSTR(MAX(LPROD_GU),1,1)
     || TRIM(SUBSTR(MAX(LPROD_GU),2) + 1)
    FROM   LPROD2),'������',0)
;
-- LPROD2 ���̺��� LPROD_ID���� 1 �������� �������ִ� FUNCTION�� ������
-- FUNCTION �� : FN_NEXT_LPROD_ID 
SELECT NVL(MAX(LPROD_ID),0)+1 FROM LPROD2;
/
CREATE OR REPLACE FUNCTION FN_NEXT_LPROD_ID
RETURN NUMBER
IS
    V_ID NUMBER;
BEGIN
    --PL/SQL���� SELECT�� �Բ� �� INTO�� ����
    SELECT NVL(MAX(LPROD_ID),0)+1 INTO V_ID
    FROM LPROD2;
    RETURN V_ID;
END;
/
-- LPROD2 ���̺��� LPROD_GU ���� 1 �������� �������ִ� ���������� ������ 
-- P403 -> 1 ���� -> p405
SELECT SUBSTR(MAX(LPROD_GU),1,1)
     || TRIM(SUBSTR(MAX(LPROD_GU),2) + 1)
FROM   LPROD2;

-- ��������~�������� �Ⱓ �� ��� ��¥(����) ���ϱ�
-- �������� : 2022-12-01
-- �������� : 2022-12-10
SELECT TO_DATE('2022-12-01','YYYY-MM-DD') + LEVEL - 1 AS DATES
FROM DUAL
CONNECT BY LEVEL <= (TO_DATE('2022-12-10','YYYY-MM-DD')- 
                     TO_DATE('2022-12-01','YYYY-MM-DD')+1); 
WITH DATE_RANGE AS(
    SELECT TO_DATE('2022-12-01','YYYY-MM-DD') + LEVEL - 1 AS DATES
    FROM DUAL
    CONNECT BY LEVEL <= (TO_DATE('2022-12-10','YYYY-MM-DD') - 
                         TO_DATE('2022-12-01','YYYY-MM-DD') + 1)
),
ATTENDANCE AS(
SELECT TO_DATE('2022-12-01','YYYY-MM-DD') AS ATTDATE, '���' AS ATTSTAT FROM DUAL
UNION ALL
SELECT TO_DATE('2022-12-03','YYYY-MM-DD') AS ATTDATE, '���' AS ATTSTAT FROM DUAL
UNION ALL
SELECT TO_DATE('2022-12-06','YYYY-MM-DD') AS ATTDATE, '���' AS ATTSTAT FROM DUAL
)
SELECT A.DATES, B.ATTSTAT FROM DATE_RANGE A, ATTENDANCE B
WHERE  A.DATES = B.ATTDATE(+)
ORDER BY A.DATES
;

SELECT LEVEL T_NO
       , LEVEL || '����' T_NAME
       , DECODE(LEVEL,
                1, '9:00',
                2, '10:00',
                3, '11:00',
                4, '12:00',
                5, '13:00',
                6, '14:00',
                7, '15:00',
                8, '16:00') P_SDATE
       , DECODE(LEVEL, 
                1, '9:50',
                2, '10:50',
                3, '11:50',
                4, '12:50',
                5, '13:50',
                6, '14:50',
                7, '15:50',
                8, '16:50') P_EDATE
FROM DUAL
CONNECT BY LEVEL <=8;
SELECT BOOK_ID || TITLE AS BOOK_TITLE, CATEGORY, PRICE, INSERT_DATE, CONTENT
FROM BOOK
DESC PMEMBER

CREATE ON TABLE EMP(


);

/*RECEIPT����  PATIENTȯ��  
�߰��� �� ������ȣ PA_ZIP, �ּ� PA_ADD1, PA_ADD2 ���ּ�, PA_PH ��ȭ��ȣ
*/
/
SELECT   ROWNUM NUM
       , A.PA_NO
       , A.PA_REG
       , A.PA_ZIP
       , A.PA_ADD1
       , A.PA_ADD2
       , A.PA_NAME
       , B.RCP_MEMO
FROM PATIENT A LEFT OUTER JOIN RECEIPT B ON(A.PA_NO = B.PA_NO)
WHERE A.PA_NAME LIKE '%';
/
select 
       B.PA_SEQ, 
       C.DO_NO,
       B.PA_NO,
       B.PA_REG,
       B.PA_NAME,
       A.RCP_MEMO
from  RECEIPT  A LEFT OUTER JOIN PATIENT B ON(A.PA_NO=B.PA_NO)
LEFT OUTER JOIN DOC_OFFICE C ON(A.DO_CODE=C.DO_CODE);
/
SELECT  ROWNUM NUM 
     , A.DOC_NO
     , C.PA_NO
     , C.PA_NAME
     , C.PA_REG
     , C.PA_STATE
     , B.RCP_MEMO
FROM DOC_OFFICE A, Receipt B, Patient C
where A.DOC_CD = B.DOC_CD
AND   B.PA_NO = C.PA_NO
AND A.DOC_NO = '2�����'
ORDER BY DECODE(C.PA_STATE, '������', 1);
/
--������ 
/
SELECT  ROWNUM NUM 
     , A.DOC_NO
     , C.PA_NO
     , C.PA_NAME
     , C.PA_REG
     , B.RCP_MEMO
FROM DOC_OFFICE A, Receipt B, Patient C
where A.DOC_CD = B.DOC_CD
AND   B.PA_NO = C.PA_NO
AND A.DOC_NO='2�����'

/


--1) �����(doc_office)�� insert(����ǹ�ȣ, �α�����������ȣ)
SELECT * FROM DOC_OFFICE;

SELECT SUBSTR(MAX(DOC_CD),1,1) || TRIM(TO_CHAR(SUBSTR(NVL(MAX(DOC_CD),'O000'),2) + 1,'000'))
FROM   DOC_OFFICE;

SELECT DO_NO FROM   DOC_OFFICE WHERE DO_NO='1�����'

INSERT INTO DOC_OFFICE(DOC_NO, EMP_NO) VALUES(
(SELECT DOC_NO FROM DOC_OFFICE WHERE DOC_NO='1�����'),'D10001'
);

/
INSERT INTO DOC_OFFICE(DOC_CD, EMP_NO, DOC_NO) VALUES(
(SELECT SUBSTR(MAX(DOC_CD),1,1) || TRIM(TO_CHAR(SUBSTR(NVL(MAX(DOC_CD),'D000'),2) + 1,'000'))
FROM   DOC_OFFICE),'D10001', '2�����'
);
/
--2) ����(receipt)�� insert(ȯ�ڹ�ȣ, ����޸�)
/
INSERT INTO RECEIPT(PA_NO, DOC_CD, RCP_MEMO, RCP_TM, RCP_NO, RCP_FV) VALUES('2022048','O002','�忰',SYSDATE,(SELECT NVL(MAX(RCP_NO),0) + 1 FROM RECEIPT));
/
SELECT NVL(MAX(RCP_NO),0) + 1 FROM RECEIPT
/
--�ű� ȯ������ 
/
INSERT INTO PATIENT(PA_NO, PA_REG, PA_NAME, PA_SEX, PA_PH, PA_MAIL, PA_ADD1, PA_ADD2, PA_ZIP,PA_ENDT, PA_ENWT)
VALUES ((SELECT NVL(MAX(PA_NO),0) + 1 FROM PATIENT),	'850902-2******',	'����',	'����',	'010-5148-2578','1dasdas@naver.com','����������',	'������402',	23415,SYSDATE,'�����');
/

UPDATE PATIENT
SET   PA_PH='1',PA_ADD1='1',PA_ADD2='1',PA_ZIP=1,PA_UPWT='1'
WHERE PA_NAME ='������';
/
UPDATE DOC_OFFICE
SET DOC_STATE='������'
WHERE DOC_CD='O003' 
/
    --�ֹ����� ����Ʈ 
	SELECT D.DROR_CD,D.DROR_PRICE,D.DROR_QTY,D.DROR_GUBUN,D.DROR_ORDT,D.IDT_REQ_NUR,D.DR_CD,D.DROR_SEQ,
        S.DSD_NAME,S.DSD_COM, E.EMP_NAME
	    FROM DRUG_ORDER D,DRUG_STOCK_DETAIL S, EMP E
	    WHERE D.DR_CD = S.DR_CD
        AND D.IDT_REQ_NUR = E.EMP_NO
	    ORDER BY DROR_CD ASC
/
		SELECT  ROWNUM NUM
               , D.DROR_CD
               ,D.DROR_PRICE
               ,D.DROR_QTY
               ,D.DROR_GUBUN
               ,D.DROR_ORDT
               ,D.IDT_REQ_NUR
               ,D.DR_CD
               ,D.DROR_SEQ
               ,S.DSD_NAME
               ,S.DSD_COM
               ,E.EMP_NAME
               ,D.DROR_ORDT
   		FROM DRUG_ORDER D,DRUG_STOCK_DETAIL S,EMP E
	    WHERE D.DR_CD = S.DR_CD
	    AND  D.IDT_REQ_NUR = E.EMP_NO
	    order by dror_cd asc
/
--���� �� ���� 
SELECT 
        ROWNUM NUM
        , A.DI_DT AS ��������
        , C.EMP_NAME AS �����
        , D.DSD_COM  AS ������ü 
        , D.DSD_NAME AS ��ǰ��
        , C.EMP_PH  AS �������ȭ��ȣ
FROM DRUG_INDENT A, DRUG_ORDER B , EMP C , DRUG_STOCK_DETAIL D
WHERE  
AND A.IDT_APL_AST = C.EMP_NO;
/

SELECT    A.DI_CD
        , A.DI_DT
        , B.EMP_NAME
        , B.EMP_PH
FROM DRUG_INDENT A , EMP B 
WHERE A.IDT_APL_AST = B.EMP_NO 
--  ���� ��� 
/
INSERT
INTO DRUG_INDENT(DI_CD, DI_DT,  IDT_APL_AST )
VALUES((SELECT SUBSTR(MAX(DI_CD),1,1) || TRIM(TO_CHAR(SUBSTR(NVL(MAX(DI_CD),'Z000'),2) + 1,'000'))FROM DRUG_INDENT) 
        ,SYSDATE
        ,'A10001' );
/
-- ���ֻ� ��� 
INSERT INTO DRUG_DETAIL(DI_CD, DD_NO, DD_QTY, DR_CD)
VALUES((SELECT MAX(DI_CD)FROM DRUG_INDENT), (SELECT NVL(MAX(DD_NO),0) + 1 FROM DRUG_DETAIL), 5, 'MBLONA8');
/
SELECT    A.DD_QTY
        , A.DR_CD
        , B.DI_DT
        , B.DI_CD
        , C.DSD_NAME
        , D.EMP_NAME
        , C.DSD_COM
FROM DRUG_DETAIL A, DRUG_INDENT B, DRUG_STOCK_DETAIL C, EMP D
WHERE A.DI_CD = B.DI_CD
AND A.DR_CD=C.DR_CD
AND  B.IDT_APL_AST = D.EMP_NO 
AND B.DI_CD = 'Z002'
/
--��ǰ�ֹ� ����
DELETE 
FROM DRUG_ORDER
WHERE DR_CD='MBENZ1'
/
SELECT   B.PA_NO
        ,A.RCP_TM
        ,B.PA_NAME 
        ,A.RCP_MEMO
        ,B.PA_REG
FROM RECEIPT A, PATIENT B
WHERE A.PA_NO =  B.PA_NO
AND A.RCP_TM = '2022-12-08'
/
--������ ��û
INSERT INTO CERTIFICATE_ORDER(CTF_NO, PR_CD, CTF_GUBUN,  CTF_ENDT, CTF_PAST, CTF_STATE, PA_NAME, EMP_NAME)
VALUES(
        (SELECT NVL(MAX(CTF_NO),0)+1 FROM CERTIFICATE_ORDER)
        ,(SELECT MAX(PR_CD)FROM PRE_RECORD)
        , '��    �߼�'
        , SYSDATE
        , '���� ���� ������ ���ܼ� ����ϴ� ȯ���Դϴ�'
        , '���'
        , '������'
        , '������'
)
/   
--������ ���� 
SELECT   
          CTF_GUBUN
        , CTF_NAME
        , CTF_ENDT
        , EMP_NAME
        , CTF_STATE
        , PA_NO
FROM CERTIFICATE_ORDER
 WHERE CTF_ENDT BETWEEN TO_DATE('2022-12-01', 'YYYY-MM-DD') 
                   AND TO_DATE(SYSDATE+1)   
AND CTF_GUBUN LIKE '%pres%'
/
SELECT  ROWNUM NUM 
		     , A.DOC_NO
		     , C.PA_NO
		     , C.PA_NAME
		     , C.PA_REG
		     , C.PA_STATE
		     , B.RCP_MEMO
             , B.RCP_TM
		FROM DOC_OFFICE A, Receipt B, Patient C
		where A.DOC_CD = B.DOC_CD
		AND   B.PA_NO = C.PA_NO
		AND A.DOC_NO = '2�����'
ORDER BY DECODE(C.PA_STATE, '������', 1)
, B.RCP_TM ASC

/
--1) ���ܼ�  
SELECT   A.DIS_CD    AS ����
        ,A.DIA_DT    AS �ߺ���
        ,A.DIA_ENDT  AS ������
        ,A.DIA_USE   AS �뵵
        ,A.DIA_CONT  AS ġ���ǰ�   
        ,A.CH_DOCNM
        ,B.PA_ADD1
        ,B.PA_SEX
        ,B.PA_NAME 
        ,B.PA_REG
        
FROM DIAGNOSIS A , PATIENT B 
WHERE A.PA_NO = B.PA_NO
AND A.PA_NO = 2022003
AND A.DOCU_CD = 'diag'
/
-- 2) ó���� 

SELECT   A.PRE_SHOT  
        ,A.PRE_CNT 
        ,A.PRE_DAYS 
        ,A.DR_CD  
        ,C.DR_NAME 
        ,B.PA_NAME 
        ,B.PA_REG        
FROM PRESCRIPTION A , PATIENT B , DRUG_API C
WHERE A.PA_NO = B.PA_NO
AND A.DR_CD = C.DR_CD
AND A.PA_NO = 2022045
AND A.DOCU_CD = 'pres'; 

/
--3) �Ұ߼� 
SELECT   A.NT_USE 
        ,A.FILE_ATCH_NO 
        ,A.NT_VIEW
        ,A.NT_DT   
        ,B.PA_ADD1
        ,B.PA_SEX
        ,B.PA_NAME 
        ,B.PA_REG
FROM NOTE A , PATIENT B
WHERE A.PA_NO = B.PA_NO
AND A.PA_NO = 2022046
AND A.DOCU_CD = 'note'
/
 SELECT   A.NT_USE 
			   ,A.NT_VIEW
		       ,A.FILE_ATCH_NO         
		       ,B.PA_ADD1
		       ,B.PA_SEX
		       ,B.PA_NAME 
		       ,B.PA_REG
		       ,B.PA_NO
               ,C.EXAM_CD
               ,D.FILE_NAME
		FROM NOTE A , PATIENT B, EXAMINATION C , ATTACH_FILE D
		WHERE A.PA_NO = B.PA_NO
        AND A.PA_NO = C.PA_NO
        AND C.EXAM_CD = D.ANY_CD
		AND A.PA_NO = 	2022016
		AND A.DOCU_CD = 'note'
/
SELECT   A.DIS_CD   
        ,A.DIA_DT   
        ,A.DIA_ENDT 
        ,A.DIA_USE  
        ,A.DIA_CONT 
        ,A.PA_NO
        ,A.DOCU_CD
        ,B.PA_ADD1
        ,B.PA_SEX
        ,B.PA_NAME 
        ,B.PA_REG
FROM DIAGNOSIS A , PATIENT B
WHERE A.PA_NO = B.PA_NO
AND A.PA_NO = 	'2022004' 
AND A.DOCU_CD = 'diag';

SELECT * FROM USER_CONSTRAINTS WHERE CONSTRAINT_NAME='R_33';
/
UPDATE  PATIENT
SET PA_STATE = '�����'
WHERE PA_NO =2022052;
/
SELECT    PA_NO
		 ,PA_NAME 
		 ,PA_REG
         ,PA_STATE
         ,PA_RES
         ,PA_ADD1
FROM PATIENT 
WHERE PA_STATE = '����'
AND TO_CHAR(PA_RES, 'YYYY-MM-DD') = '2022-12-30'
/
SELECT  PA_NO PA_NO
		      , PA_REG
		      , PA_NAME
		      , PA_SEX
		      , PA_PH
		      , PA_MAIL
		      , PA_ADD1
		      , PA_ADD2
		      , PA_ZIP
		      , PA_ENDT
		      , PA_ENWT
		      , PA_UPDT
		      , PA_UPWT
		      , PA_TRMR
		      , PA_FIVI_DT
		      , PA_STATE
		      , PA_EXAM_STATE
		FROM PATIENT
        ORDER BY PA_UPDT ASC
/
SELECT PROD_NAME prodName, 
		       SUM(PROD_SALE * CART_QTY) MONEY
		FROM PROD,CART 
		WHERE PROD_ID = CART_PROD
		GROUP BY PROD_NAME
		HAVING SUM(PROD_SALE * CART_QTY) >=10000000
/
SELECT SUM(REC_TOTAL) AS �����ѱݾ� 
FROM RECEIPTION 
WHERE TO_CHAR(REC_DT, 'YYYY-MM') = '2022-12'
/
SELECT EXTRACT (MONTH FROM REC_DT) 
,      SUM(REC_TOTAL) 
FROM RECEIPTION
WHERE EXTRACT (YEAR FROM REC_DT) =2022 
GROUP BY EXTRACT (MONTH FROM REC_DT)
ORDER BY EXTRACT (MONTH FROM REC_DT) ASC;
/
--���� ȯ�� 
SELECT EXTRACT (MONTH FROM PD_TM) 
,      COUNT(PD_NUM) 
FROM PADUMMY
WHERE EXTRACT (YEAR FROM PD_TM) =2022 
GROUP BY EXTRACT (MONTH FROM PD_TM)
ORDER BY EXTRACT (MONTH FROM PD_TM) ASC;
/
SELECT * FROM T
WHERE T.RNUM BETWEEN 1 * 10 -9  AND 1 * 10;
DECLARE
BEGIN
    FOR I IN 54001..5600 LOOP
    INSERT INTO PADUMMY(PD_NUM, PD_TM, PD_NAME) 
    VALUES(I, '2022-12-06','ó��');
    END LOOP;
END;
/

SELECT  ROWNUM NUM 
     , A.DOC_NO
     , C.PA_NO
     , C.PA_NAME
     , C.PA_REG
     , C.PA_STATE
     , B.RCP_MEMO
FROM DOC_OFFICE A, Receipt B, Patient C
where A.DOC_CD = B.DOC_CD
AND   B.PA_NO = C.PA_NO
AND A.DOC_NO = '2�����'
/
SELECT A.PA_NO
,      A.PA_REG
,      A.PA_NAME
,      A.PA_ADD1
,      A.PA_STATE
FROM PATIENT A
WHERE NOT EXISTS(
                    SELECT PA_NO
                    FROM Receipt B
                    WHERE B.PA_NO =A.PA_NO
                )
AND A.PA_STATE = '�����'
ORDER BY PA_UPDT ASC
/
SELECT   A.NT_USE 
			   ,A.NT_VIEW
		       ,A.FILE_ATCH_NO         
		       ,B.PA_ADD1
		       ,B.PA_SEX
		       ,B.PA_NAME 
		       ,B.PA_REG
		       ,B.PA_NO
               ,C.EXAM_CD
               ,D.FILE_NAME
		FROM NOTE A , PATIENT B, EXAMINATION C , ATTACH_FILE D
		WHERE A.PA_NO = B.PA_NO
        AND A.PA_NO = C.PA_NO
        AND C.EXAM_CD = D.ANY_CD
		AND A.PA_NO = 	2022001   
		AND A.DOCU_CD = 'note'  
/
SELECT A.EXAM_CD, A.EXAM_FEE, A.EXAM_DT, A.EXAM_NAME, A.EXAM_BODPT, B.Pa_No  
FROM EXAMINATION A, TEST_ORDER B
WHERE A.TO_OR_NO = B.TO_OR_NO
AND B.PA_NO = 2022058
ORDER BY A.EXAM_DT DESC
/
SELECT (SELECT COUNT(PA_NAME) FROM PATIENT WHERE PA_TRMR = 'Y')
,       (SELECT COUNT(PA_NAME) FROM PATIENT WHERE PA_TRMR = 'N')
FROM DUAL; 
/
SELECT MAX(RCP_FV)
,      MAX (RCP_ME)
FROM RECEIPT

/
SELECT MAX(RCP_ME)+1
FROM RECEIPT
/
INSERT INTO RECEIPT(PA_NO, DOC_CD, RCP_MEMO, RCP_TM, RCP_NO, RCP_FV) VALUES('2022062','O017','�忰',SYSDATE,(SELECT NVL(MAX(RCP_NO),0) + 1 FROM RECEIPT)
,(SELECT MAX(RCP_ME)+1 FROM RECEIPT)
);
/
SELECT  IN_NAME
,       IN_REG
FROM INSURERE
WHERE IN_REG  LIKE '97071%'
/

SELECT   CASE WHEN PA_NAME  IS NULL THEN '�γγ�'
FROM PATIENT

/
SELECT 
NVL(PA_NAME,'�迭��')
FROM PATIENT
WHERE PA_NAME= 'KR';           
            