-- Week 5 Lab

-- 1.
select round(avg(total_overall_amt),2)
from(
	select a.name, sum(total_amt_usd) total_overall_amt
	from orders o
	join accounts a
	on o.account_id = a.id
	group by a.name
	order by 2 desc
	limit 10) tbl1;

-- Another way using WITH Statement

with tbl1 as
	(select a.name, sum(total_amt_usd) total_overall_amt
	from orders o
	join accounts a
	on o.account_id = a.id
	group by a.name
	order by 2 desc
	limit 10
)
select round(avg(total_overall_amt),2)
from tbl1

-- 2.

select tble1.account_name, w.channel, count(*) events
from
	(select a.name as account_name, a.id, sum(total_amt_usd) total_overall_amt
	from orders o
	join accounts a
	on o.account_id = a.id
	group by a.name, a.id
	order by total_overall_amt desc
	limit 1) tble1
join web_events w
on tble1.id = w.account_id
group by w.channel, tble1.account_name
order by 2 desc;

--Another way using WITH Statement
with tbl1 as
	(select a.name as account_name, a.id, sum(total_amt_usd) total_overall_amt
	from orders o
	join accounts a
	on o.account_id = a.id
	group by a.name, a.id
	order by total_overall_amt desc
	limit 1
)
select tbl1.account_name, w.channel, count(*)
from web_events w
join tbl1
on w.account_id = tbl1.id
group by tbl1.account_name, w.channel;

-- Another way using VIEWS (Not recommended)

create view v1 as
	select a.name as account_name, a.id, sum(total_amt_usd) total_overall_amt
	from orders o
	join accounts a
	on o.account_id = a.id
	group by a.name, a.id
	order by total_overall_amt desc
	limit 1

select v1.account_name, w.channel, count(*)
from web_events w
join v1
on w.account_id = v1.id
group by v1.account_name, w.channel

-- Views are permanent. Once created, they become a part of your
-- database. They're not recommended because companies are not going
-- to assign us priveleges to create extra tables in their databases.
-- Unless you can get permission from the database administrator.

--3.
with tbl1 as(
	select a.name, w.channel, count(*) total
	from accounts a
	join web_events w
	on a.id = w.account_id
	group by a.name, w.channel
	order by name),

tbl2 as (
	select name, max(total) max_total
	from tbl1
	group by name)
select tbl1.name, tbl1.channel, tbl2.max_total
from tbl1
join tbl2
on tbl1.name = tbl2.name and tbl1.total = tbl2.max_total;

--Fajar's query
with tbl1 as(
	select a.name, w.channel, count(*) total
	from accounts a
	join web_events w
	on a.id = w.account_id
	group by a.name, w.channel
	order by name)


	select channel, count(name)
	from tbl1
	group by 1
	order by 2 desc

--4.

with tbl1 as(
	select s.name sales_rep_name, r.name region_name, sum(o.total_amt_usd) total
	from region r
	join sales_reps s
	on s.region_id = r.id
	join accounts a
	on s.id = a.sales_rep_id
	join orders o
	on o.account_id = a.id
	group by s.name, r.name),
tbl2 as(
	select region_name, max(total) max_overall_total
	from tbl1
	group by region_name
)
select tbl1.region_name, tbl1.sales_rep_name, tbl2.max_overall_total
from tbl1
join tbl2
on tbl1.region_name = tbl2.region_name
and tbl1.total = tbl2.max_overall_total



--5.


with tbl1 as(
	select a.name, sum(total_amt_usd) total_spent
	from accounts a
	join orders o
	on a.id = o.account_id
	group by a.name
	order by total_spent desc
	limit 10
)
select avg(total_spent)
from tbl1


--6.

with tbl1 as (
	select a.name, sum(total_amt_usd) total_spent
	from orders o
	join accounts a
	on o.account_id = a.id
	group by a.name
	order by total_spent desc
	limit 1)
select a.name, w.channel, count(*) num_events
from web_events w
join accounts a
on a.id = w.account_id and a.name = (select name from tbl1)
group by a.name, w.channel
order by num_events desc

-- 7

with tbl1 as(
	select s.name sales_person, r.name region_name, sum(total_amt_usd) total_spent
	from region r
	join sales_reps s
	on s.region_id = r.id
	join accounts a
	on a.sales_rep_id = s.id
	join orders o
	on o.account_id = a.id
	group by s.name, r.name
	order by r.name, total_spent desc
	),
tbl2 as(
	select region_name, max(total_spent) max_total_spent
	from tbl1
	group by region_name
	)
select tbl1.region_name, max_total_spent
from tbl1
join tbl2
	on tbl1.region_name = tbl2.region_name and tbl1.total_spent = tbl2.max_total_spent
order by max_total_spent desc
