PROC IMPORT DATAFILE = '/home/u62429465/codes/SampleData.xlsx'
	DBMS = xlsx REPLACE
	OUT = DATA;
	SHEET = "SalesOrders";
	GETNAMES = YES;
RUN;

/* IF 이용 그룹 지정 */
DATA D;
SET DATA;
LENGTH total_group $20.;
IF Total < 500 then
	total_group = "low";
ELSE IF 500 <= Total <1000 then
	total_group = "mid";
ELSE 
	total_group = "high";
RUN;

/* SQL 이용 그룹 지정 */
PROC SQL;
	SELECT OrderDate, Item,
		CASE
			WHEN Total < 500 then "LOW"
			WHEN 500 <= total < 1000 then "MID"
			ELSE "HIGH"
		END as GROUP
	FROM DATA;
RUN;

/* WHERE 이용 레코드 조건 지정 */

DATA STR;
SET DATA;
WHERE Region in ('Central', 'East');
RUN;

/* IF 이용 레코드 삭제 */
DATA F;
SET DATA;
IF Total < 1000 then DELETE;
RUN;
