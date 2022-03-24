-- Week 4

-- Q1.

select a.name, sum(o.total_amt_usd) as total_sales
from orders o
join accounts a
on o.account_id = a.id
group by a.name
order by total_sales desc;

--Q2.

select distinct channel
from web_events;

select channel, count(*) total
from web_events
group by channel
order by total desc;

--Q3.

select a.name, max(o.total_amt_usd) max_amt
from orders o
join accounts a
on o.account_id = a.id
group by a.name
order by max_amt desc;

--Q4.

select r.name, count(*) num_of_reps
from sales_reps s
join region r
on s.region_id = r.id
group by r.name
order by 2

--Q5.

select a.name, round(avg(standard_amt_usd),2) avg_std_amt_usd ,
				round(avg (poster_amt_usd),2) avg_poster_amt_usd,
				round(avg (gloss_amt_usd),2) avg_gloss_amt_usd
from accounts a
join orders o
on a.id = o.account_id
group by a.name;

--Q6.

select s.name, w.channel, count(*) num_events
from web_events w
join accounts a
on w.account_id = a.id
join sales_reps s
on s.id = a.sales_rep_id
group by s.name, w.channel
order by num_events desc;

--Q7.

select count(*)
from (
	select s.name, count(*) num_of_accounts
	from sales_reps s
	join accounts a
	on a.sales_rep_id = s.id
	group by s.name -- assuming that names are unique otherwise use id
	having count(*) > 5
	order by 2
) table1;



--Q8.

select count(*)
from(
	select account_id, count(*) total_orders
	from orders
	group by account_id
	having count(*) > 20
	) table1;

--Q9.

select a.name, count(*) total_orders
from orders o
join accounts a
on a.id = o.account_id
group by a.name
order by 2 desc
limit 1

--Q.10

select count(*)
from(
	select a.name, sum(o.total_amt_usd) total_spent
	from accounts a
	join orders o
	on a.id = o.account_id
	group by a.name
	having sum(o.total_amt_usd)> 30000
)table1;

--Q11.

select a.name, sum(o.total_amt_usd) total_spent
from orders o
join accounts a
on a.id = o.account_id
group by a.name
order by total_spent desc
limit 1;

--Q12.

select a.name, w.channel, count(*)
from web_events w
join accounts a
on w.account_id = a.id
where w.channel = 'facebook'
group by a.name, w.channel
order by 3 desc
limit 1

--Q13.

select a.name, w.channel, count(*)
from web_events w
join accounts a
on w.account_id = a.id
where w.channel = 'facebook'
group by a.name, w.channel
having count(*) > 6
order by 3 desc

--Q14.

select a.name, w.channel, count(*)
from web_events w
join accounts a
on w.account_id = a.id
group by a.name, w.channel
order by 3 desc;

--Q15.

select date_part('year', occurred_at) order_year, sum(total_amt_usd) total_spent
from orders o
group by order_year
order by 1;

--Q16.

select date_part('month', occurred_at) order_month, sum(total_amt_usd) total_spent
from orders o
where date_part('year', occurred_at) = 2016
group by order_month
order by 2 desc
limit 1;

--Q17.

select date_trunc('month', o.occurred_at) order_date,
		sum(o.gloss_amt_usd) total_spent
from orders o
join accounts a
on a.id=o.account_id
where a.name = 'Walmart'
group by order_date
order by 2 desc
limit 1;

--Q18.

select a.name, sum(o.total_amt_usd) total_spent,
	case when sum(o.total_amt_usd) > 200000 THEN 'Top'
		when sum(o.total_amt_usd) > 100000 THEN 'Medium'
		else 'Low'
		end account_level
from orders o
join accounts a
on a.id = o.account_id
group by a.name

-- Q19.

select a.name, sum(o.total_amt_usd) total_spent,
	case when sum(o.total_amt_usd) > 200000 THEN 'Top'
		when sum(o.total_amt_usd) > 100000 THEN 'Medium'
		else 'Low'
		end account_level
from orders o
join accounts a
on a.id = o.account_id
where date_part('year', o.occurred_at) in (2016,2017)
group by a.name;

-- Q20.
select s.name, count(*) num_orders,
		case when count(*) > 200 THEN 'Top'
		else 'Not'
		end sales_rep_level
from sales_reps s
join accounts a
on s.id = a.sales_rep_id
join orders o
on a.id = o.account_id
group by s.name
order by 2 desc;

-- Q21.
select s.name, count(*) num_orders, sum(total_amt_usd) total_spent,
		case when count(*) > 200 or sum(total_amt_usd) > 750000 then 'Top'
			 when count(*) > 150 or sum(total_amt_usd) > 500000 then 'Middle'
			 else 'low'
		end sales_rep_level
from sales_reps s
join accounts a
on s.id = a.sales_rep_id
join orders o
on a.id = o.account_id
group by s.name
order by 3 desc;
