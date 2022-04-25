SET VAR_START_DATE = '01-JAN-2019';
SET VAR_END_DATE = GETDATE();

SELECT CLUSTER_LOCATION,AVG(DATE_DIFF) AS AVG_DATE_DIFF FROM 
((select 
'C1' AS CLUSTER_LOCATION
, R.EXPRPT_PK
, R.EXPRPT_CREATEDATE AS SUBMITDATE
, A.PROCESSEDEXPRPTAPPR_APPROVALDATE AS APPROVAL_DATE
, (DATEDIFF(DAY,R.EXPRPT_CREATEDATE,A.PROCESSEDEXPRPTAPPR_APPROVALDATE)+1) AS DATE_DIFF

from "BRONZE_CE"."CE_PROD_01_DBO"."EXPRPT" R
, "SILVER_CE"."CE_PROD_01_DBO"."PROCESSEDEXPRPTAPPR" A

where R.EXPRPT_PK = A.PROCESSEDEXPRPTAPPR_EXPRPTFK 
AND R.EXPRPT_CREATEDATE>= $var_start_date and R.EXPRPT_CREATEDATE<= $var_end_date
AND R.EXPRPT_DERIVED_LAST_APPRSTATUSFK ='3'
AND R._FIVETRAN_DELETED = FALSE)
 
UNION 

(select 
'C2' AS CLUSTER_LOCATION
, R.EXPRPT_PK
, R.EXPRPT_CREATEDATE AS SUBMITDATE
, A.PROCESSEDEXPRPTAPPR_APPROVALDATE AS APPROVAL_DATE
, (DATEDIFF(DAY,R.EXPRPT_CREATEDATE,A.PROCESSEDEXPRPTAPPR_APPROVALDATE)+1) AS DATE_DIFF

from "BRONZE_CE"."CE_PROD_02_DBO"."EXPRPT" R
, "SILVER_CE"."CE_PROD_02_DBO"."PROCESSEDEXPRPTAPPR" A

where R.EXPRPT_PK = A.PROCESSEDEXPRPTAPPR_EXPRPTFK 
AND R.EXPRPT_CREATEDATE>= $var_start_date and R.EXPRPT_CREATEDATE<= $var_end_date
AND R.EXPRPT_DERIVED_LAST_APPRSTATUSFK ='3'
AND R._FIVETRAN_DELETED = FALSE)

UNION 
 
(select 
'C3' AS CLUSTER_LOCATION
, R.EXPRPT_PK
, R.EXPRPT_CREATEDATE AS SUBMITDATE
, A.PROCESSEDEXPRPTAPPR_APPROVALDATE AS APPROVAL_DATE
, (DATEDIFF(DAY,R.EXPRPT_CREATEDATE,A.PROCESSEDEXPRPTAPPR_APPROVALDATE)+1) AS DATE_DIFF

from "BRONZE_CE"."CE_PROD_03_DBO"."EXPRPT" R
, "SILVER_CE"."CE_PROD_03_DBO"."PROCESSEDEXPRPTAPPR" A

where R.EXPRPT_PK = A.PROCESSEDEXPRPTAPPR_EXPRPTFK 
AND R.EXPRPT_CREATEDATE>= $var_start_date and R.EXPRPT_CREATEDATE<= $var_end_date
AND R.EXPRPT_DERIVED_LAST_APPRSTATUSFK ='3'
AND R._FIVETRAN_DELETED = FALSE)
 
UNION 
 
(select 
'C4' AS CLUSTER_LOCATION
, R.EXPRPT_PK
, R.EXPRPT_CREATEDATE AS SUBMITDATE
, A.PROCESSEDEXPRPTAPPR_APPROVALDATE AS APPROVAL_DATE
, (DATEDIFF(DAY,R.EXPRPT_CREATEDATE,A.PROCESSEDEXPRPTAPPR_APPROVALDATE)+1) AS DATE_DIFF

from "BRONZE_CE"."CE_PROD_04_DBO"."EXPRPT" R
, "SILVER_CE"."CE_PROD_04_DBO"."PROCESSEDEXPRPTAPPR" A

where R.EXPRPT_PK = A.PROCESSEDEXPRPTAPPR_EXPRPTFK 
AND R.EXPRPT_CREATEDATE>= $var_start_date and R.EXPRPT_CREATEDATE<= $var_end_date
AND R.EXPRPT_DERIVED_LAST_APPRSTATUSFK ='3'
AND R._FIVETRAN_DELETED = FALSE))
 
GROUP BY CLUSTER_LOCATION ORDER BY CLUSTER_LOCATION