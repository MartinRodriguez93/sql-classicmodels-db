#Avg payment per country compared with payment per customer:
select c.customerNumber,
	   c.country,
       format(sum(p.amount),0) as payment_amount,
       avg(sum(p.amount)) over (partition by c.country) as avg_country_payment,
       case when sum(p.amount) > (avg(sum(p.amount)) over (partition by c.country)) then "Above average"
			else "Below Average"
            end as avg_compare
from customers c
inner join payments p on c.customerNumber=p.customerNumber
group by p.customerNumber, c.country
order by country;
