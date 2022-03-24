--7.

select o.id, a.name, o.total as total_quanity
from orders as o
join accounts as a
on o.account_id = a.id
where a.name = 'Walmart';


--8.

select distinct a.name, w.channel
from accounts as a
join web_events as w
on a.id = w.account_id
where w.account_id = 1001;

--9.
select o.occurred_at, a.name, o.total, o.total_amt_usd
from orders as o
join accounts as a
on a.id=o.account_id
where o.occurred_at between '2015-01-01' and '2016-01-01'
order by occurred_at

--10.
select r.name region_name,
		s.name sales_rep_name,
		a.name account_name
from accounts as a
join sales_reps as s
on a.sales_rep_id = s.id
join region as r
on r.id = s.region_id
where r.name = 'Midwest'

--11
select s.region_id as region_id,
		s.name as sales_rep_name,
		a.name as account_name
from sales_reps as s
join accounts as a

--12.
select w.occurred_at, a.primary_poc
from web_events w
join accounts a
on w.account_id = a.id
order by occurred_at
limit 1;

--13
select r.name region_name,
		a.name account_name,
		round(o.total_amt_usd/(o.total+0.0001),2) as unit_price
from orders as o
join accounts as a
on o.account_id = a.id
join sales_reps s
on a.sales_rep_id = s.id
join region r
on r.id = s.region_id

--14.
select count(*)
from accounts

--15.
select sum(poster_qty) as total_poster_qty
from orders

--16.
select min(poster_qty), max(poster_qty)
from orders

--17.
select min(occurred_at)
from orders

--18.
select avg(standard_amt_usd) as avg_standard_amt_usd
		avg(poster_amt_usd) as avg_poster_amt_usd
		avg(gloss_amt_usd) as gloss_amt_usd
from orders

--19.

select percentile_cont(.50) within group (order by total_amt_usd)
from orders

-- 20.
select sum(o.total_amt_usd), a.name
from orders o
join accounts a
on o.account_id = a.id
group by(a.name)

--21.

select count(*), channel
from web_events
group by(channel)

--22.

select min(o.total_amt_usd) min_order, a.name
from orders o
join accounts a
on o.account_id = a.id
group by(a.name)
order by min_order

--23.

select count(*), r.name region_name
from region r
join sales_reps s
on r.id = s.region_id
group by (r.name)

--24.

select round(avg(o.standard_qty),2) avg_std_qty,
		round(avg(o.poster_qty),2) avg_poster_qty,
		round(avg(o.gloss_qty),2) avg_gloss_qty,
		a.name
from accounts a
join orders o
on a.id = o.account_id
group by(a.name)
