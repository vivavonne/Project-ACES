//GRAB DISTINCT COUNT OF INFREQUENT USERS

select 'INFREQUENT USERS' AS TOTAL_USERS ,(sum((reports))) AS COUNT from

((select count(ExpenseReportHeaderID) as reports
  , h.PersonID
  , concat(max(p.FirstName), ' ', max(p.LastName)) as Name
  , max(h.CustomerID) AS CUSTOMERID
  , max(c.Name) AS CUSTOMERNAME
  , year (h.submitdate) as year
from "BRONZE_CR"."CR_C1_PROD_CHROME_EXPENSE"."TBL_EXPENSEREPORTHEADER" h
join "BRONZE_CR"."CR_C1_PROD_CHROME_EXPENSE"."TBL_PERSON" p on p.PersonID = h.PersonID
join "BRONZE_CR"."CR_C1_PROD_CHROME_EXPENSE"."TBL_CUSTOMER" c on c.CustomerID = h.CustomerID
where h.SubmitDate is not null
and year(h.submitdate) = 2019 and h._FIVETRAN_DELETED = FALSE and p._FIVETRAN_DELETED = FALSE and c._FIVETRAN_DELETED = FALSE
AND P.PERSONSTATUSID = 2
  AND H.STATUSID IN (3,5)
group by h.personid,year
having reports <=4)

UNION ALL

(select count(ExpenseReportHeaderID) as reports
  , h.PersonID
  , concat(max(p.FirstName), ' ', max(p.LastName)) as Name
  , max(h.CustomerID) AS CUSTOMERID
  , max(c.Name) AS CUSTOMERNAME
  , year (h.submitdate) as year
from "BRONZE_CR"."CR_C2_PROD_CHROME_EXPENSE"."TBL_EXPENSEREPORTHEADER" h
join "BRONZE_CR"."CR_C2_PROD_CHROME_EXPENSE"."TBL_PERSON" p on p.PersonID = h.PersonID
join "BRONZE_CR"."CR_C2_PROD_CHROME_EXPENSE"."TBL_CUSTOMER" c on c.CustomerID = h.CustomerID
where h.SubmitDate is not null
and year(h.submitdate) = 2019 and h._FIVETRAN_DELETED = FALSE and p._FIVETRAN_DELETED = FALSE and c._FIVETRAN_DELETED = FALSE
AND P.PERSONSTATUSID = 2
AND H.STATUSID IN (3,5)
group by h.personid,year
having reports <=4)
 
UNION ALL

 (select count(ExpenseReportHeaderID) as reports
  , h.PersonID
  , concat(max(p.FirstName), ' ', max(p.LastName)) as Name
  , max(h.CustomerID) AS CUSTOMERID
  , max(c.Name) AS CUSTOMERNAME
  , year (h.submitdate) as year
from "BRONZE_CR"."CR_C7_PROD_CHROME_EXPENSE"."TBL_EXPENSEREPORTHEADER" h
join "BRONZE_CR"."CR_C7_PROD_CHROME_EXPENSE"."TBL_PERSON" p on p.PersonID = h.PersonID
join "BRONZE_CR"."CR_C7_PROD_CHROME_EXPENSE"."TBL_CUSTOMER" c on c.CustomerID = h.CustomerID
where h.SubmitDate is not null
and year(h.submitdate) = 2019 and h._FIVETRAN_DELETED = FALSE and p._FIVETRAN_DELETED = FALSE and c._FIVETRAN_DELETED = FALSE
AND P.PERSONSTATUSID = 2
AND STATUSID IN (3,5)
group by h.personid,year
having reports <=4))


