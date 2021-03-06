use classicmodels_db;

#PAYMENTS TABLE:

#Avg payments amount: '32431.645531'
select avg(`amount`)
from `payments`;

#Avg payments amount per customerNumber classified:
select `customerNumber`,
        avg(`amount`) as avg_payment,
        case when avg(`amount`)>(select avg(`amount`) from `payments`) then "Above avg"
             else "Below avg"
             end as `AvgClassification` 
from `payments`
group by `customerNumber`
order by avg(`amount`) desc;

#Monthly number of payments per year: 2005 only six months
select YEAR(`paymentDate`) as paymentYear,
	   MONTH(`paymentDate`) as paymentMonth,
	   COUNT(`paymentDate`) as paymentCount,
       format(sum(`amount`),0) as paymentTotals,
       format((sum(`amount`)/COUNT(`paymentDate`)),0) as avg_paymentAmount
from `payments`
GROUP BY YEAR(`paymentDate`), MONTH(`paymentDate`) 
ORDER BY YEAR(`paymentDate`);
