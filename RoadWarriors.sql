//GRAB DISTINCT COUNT OF ROAD WARRIORS

//grabs for any one month of the year where user has submitted 2 or more reports per month with at least a total of 8 reports for the year


SELECT 'road warriors' AS TOTAL_USERS , SUM(PERSONCOUNT) FROM 
(SELECT 'road warriors' AS TOTAL_USERS ,(count(Distinct(PersonID))) AS PERSONCOUNT
-- SUM(REPORTS) AS REPORTCOUNT 
 FROM 
 ((select count(H.ExpenseReportHeaderID) as reports, Monthname(h.SubmitDate) as month, Year(h.SubmitDate) as year, h.PersonID, concat(max(p.FirstName), ' ', max(p.LastName)) as Name, max(h.CustomerID), max(c.Name)
from "BRONZE_CR"."CR_C1_PROD_CHROME_EXPENSE"."TBL_EXPENSEREPORTHEADER" h
join "BRONZE_CR"."CR_C1_PROD_CHROME_EXPENSE"."TBL_PERSON" p on p.PersonID = h.PersonID
join "BRONZE_CR"."CR_C1_PROD_CHROME_EXPENSE"."TBL_CUSTOMER" c on c.CustomerID = h.CustomerID
where h.SubmitDate is not null
and year = 2019 and h._FIVETRAN_DELETED = FALSE and p._FIVETRAN_DELETED = FALSE and c._FIVETRAN_DELETED = FALSE
AND P.PERSONSTATUSID = 2
AND H.STATUSID IN (3,5)
group by h.PersonID, month, year
--HAVING reports >=2
) 

UNION ALL

(select count(H.ExpenseReportHeaderID) as reports, Monthname(h.SubmitDate) as month, Year(h.SubmitDate) as year, h.PersonID, concat(max(p.FirstName), ' ', max(p.LastName)) as Name, max(h.CustomerID), max(c.Name)
from "BRONZE_CR"."CR_C2_PROD_CHROME_EXPENSE"."TBL_EXPENSEREPORTHEADER" h
join "BRONZE_CR"."CR_C2_PROD_CHROME_EXPENSE"."TBL_PERSON" p on p.PersonID = h.PersonID
join "BRONZE_CR"."CR_C2_PROD_CHROME_EXPENSE"."TBL_CUSTOMER" c on c.CustomerID = h.CustomerID
where h.SubmitDate is not null
and year = 2019 and h._FIVETRAN_DELETED = FALSE and p._FIVETRAN_DELETED = FALSE and c._FIVETRAN_DELETED = FALSE
AND P.PERSONSTATUSID = 2
 AND H.STATUSID IN (3,5)
group by h.PersonID, month, year
--having reports >=2
)

UNION ALL

(select count(ExpenseReportHeaderID) as reports, Monthname(h.SubmitDate) as month, Year(h.SubmitDate) as year, h.PersonID, concat(max(p.FirstName), ' ', max(p.LastName)) as Name, max(h.CustomerID), max(c.Name)
from "BRONZE_CR"."CR_C7_PROD_CHROME_EXPENSE"."TBL_EXPENSEREPORTHEADER" h
join "BRONZE_CR"."CR_C7_PROD_CHROME_EXPENSE"."TBL_PERSON" p on p.PersonID = h.PersonID
join "BRONZE_CR"."CR_C7_PROD_CHROME_EXPENSE"."TBL_CUSTOMER" c on c.CustomerID = h.CustomerID
where h.SubmitDate is not null
and year = 2019 and h._FIVETRAN_DELETED = FALSE and p._FIVETRAN_DELETED = FALSE and c._FIVETRAN_DELETED = FALSE
AND P.PERSONSTATUSID = 2
AND H.STATUSID IN (3,5)
group by h.PersonID, month, year
--having reports >=2
))
where reports >=2
GROUP BY PERSONID,REPORTS, YEAR
having sum(reports)>=8)
