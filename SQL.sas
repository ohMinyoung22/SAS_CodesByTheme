PROC IMPORT DATAFILE = '/home/u62429465/codes/SampleData.xlsx'
	DBMS = xlsx REPLACE
	OUT = DATA;
	GETNAMES = YES;
	DATAROW = 10;
	SHEET = "SalesOrders";
RUN;

PROC SQL;
	SELECT * 
	FROM DATA
	ORDER BY Total DESC;
QUIT;

/* 조건문 이용 사용자 생성 변수 */

PROC SQL;
	SELECT Item, 
		CASE 
			WHEN Total < 200 THEN "LOW"
			WHEN 200 <= Total <= 400 THEN "MOD"
			WHEN 600 <= Total <= 800 THEN "HIGH"
			ELSE "OVERLOAD"
		END as Total_Group
	FROM DATA
	ORDER BY Total_Group;
QUIT;

PROC SQL;
	SELECT Item, 
		CASE 
			WHEN Total IN (63.68, 57.71) THEN "MOD"
			ELSE "OVERLOAD"
		END as Total_Group
	FROM DATA
	ORDER BY Total_Group;
QUIT;

PROC SQL;
	SELECT Item, 
		CASE Region
			WHEN "West" THEN "USA"
			WHEN "Central" THEN "CHINA"
			WHEN "East" THEN "KOREA"
		END as Region
	FROM DATA;
QUIT;

/* 사용자 생성 변수 */
PROC SQL;
	SELECT SQRT(Total) as sqrt, Item, (calculated sqrt - Total) as sqrt_minus
	FROM DATA;
QUIT;
	
/* 결측치 처리, Column 이름 공백 처리 */
DATA EXAMPLE;
INPUT Name & $24. Age TicketCode$;
CARDS;
PI kachu  13 DW
PK ddd  . DW
;
RUN;

PROC PRINT DATA = EXAMPLE;
RUN;

PROC SQL;
	SELECT Name LABEL = "$", COALESCE(Age, 10) as Age
	FROM EXAMPLE;
QUIT;







