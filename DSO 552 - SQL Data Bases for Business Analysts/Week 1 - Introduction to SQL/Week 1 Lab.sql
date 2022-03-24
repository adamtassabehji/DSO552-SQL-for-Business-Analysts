-- Quesion 1
select *
from accounts;

select *
from orders;

select * 
from web_events;

select *
from sales_reps;

select * 
from region;

-- Question 2
select name, id
from sales_reps;

-- Question 3
select id, account_id, occurred_at
from orders;

-- Question 4
select *
from orders
limit 10;

-- Question 5
select *
from orders
order by occurred_at desc
limit 10;

-- Question 6
select id, occurred_at, total_amt_usd
from orders
order by occurred_at asc
limit 10;

-- Question 7
select id, total_amt_usd
from orders
order by total_amt_usd desc
limit 5;

-- Question 8
select *
from orders
order by account_id, total_amt_usd desc;

-- Question 9
select id, total, total_amt_usd
from orders
order by total desc, total_amt_usd desc
limit 5;

-- Question 10
select *
from orders
where account_id = 4251;

-- Question 11
select *
from orders
where total_amt_usd <= 500
limit 5;

-- Question 12
select name, website, primary_poc
from accounts 
where name = 'Exxon Mobil';

-- Question 13
select account_id, occurred_at, gloss_qty, 
		poster_qty, gloss_qty + poster_qty as non_standard_qty
from orders;

-- Question 14
select account_id, (standard_qty/total::float)*100 as standard_perc
from orders
where total > 0;

-- Question 15
select *
from accounts
where name like '%Food%';

-- Question 16
select * 
from accounts
where name like '%one%';

-- Question 17
select *
from accounts
where name like 'C%';

-- Question 18
select *
from accounts
where name like '%s';

-- Question 19
select id, name
from accounts
where name = 'Apple' or name = 'Walmart';

-- OR
select id, name 
from accounts
where name in ('Apple', 'Walmart');

-- Question 20
select * 
from web_events
where channel in ('twitter', 'adwords');

-- side note: to get all disctinct channels, we can use the word DISTINCT

select distinct channel
from web_events;

-- Question 21
select *
from accounts
where name not in ('Walmart', 'Target', 'Nordstrom');

-- Question 22
select * 
from web_events
where channel not in ('twitter', 'adwords');

-- Question 23
select *
from accounts
where name not like 'C%'; 

-- OR
select *
from accounts
where name not in ('C%');

-- Note: if yOu want to find the number of obsevations in your query, use count(=)
select count(*)
from accounts
where name not like 'C%';

-- Question 24
select * 
from orders
where occurred_at >= '2016-4-1' and occurred_at < '2016-9-1';

-- OR
select * 
from orders
where occurred_at between '2016-4-1' and '2016-9-2';

-- Question 25
select *
from orders
where standard_qty > 1000 and poster_qty = 0 and gloss_qty = 0;

-- Question 26
select distinct account_id, occurred_at, channel
from web_events
where channel in ('twitter', 'adwords') and 
	occurred_at >= '2016-1-1' and occurred_at < '2017-1-1'
order by occurred_at desc;

-- Question 27
select *
from orders
where standard_qty = 0 or gloss_qty = 0 or poster_qty = 0;

-- Question 28 
select *
from orders
where (standard_qty = 0 or gloss_qty = 0 or poster_qty = 0) and
	occurred_at > '2016-9-1'
order by occurred_at; 

-- Question 29
select *
from orders
where gloss_qty > 4000 or poster_qty > 4000;

-- Question 30
select *
from orders where standard_qty = 0 and 
	(poster_qty >1000 or gloss_qty > 1000);
