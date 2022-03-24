-- Lab 6

--1.

select right(website, 3) ext, count(*)
from accounts
group by ext;

-- 2.

select left(name,1), count(*)
from accounts
group by 1
order by 1;

-- There are two E's (one small and one capital), in order to consider them as one.

select upper(left(name,1)), count(*)
from accounts
group by 1
order by 1;

--Q3

with t1 as (
select left(name,1) letter,
	case when lower(left(name, 1)) in ('a', 'e', 'i','u','o') then 'vowel' else 'consonant'
	end as letter_type
from accounts
)
select letter_type, count(*)
from t1
group by letter_type;

-- Without a subquery
select
	case when lower(left(name, 1)) in ('a', 'e', 'i','u','o') then 'vowel' else 'consonant'
	end as letter_type, count(*)
from accounts
group by letter_type


--Q4

select primary_poc, position(' ' in primary_poc), length(primary_poc)
from accounts

-- Continued

select primary_poc, position(' ' in primary_poc), length(primary_poc),
	left(primary_poc, position(' ' in primary_poc)-1) first_name,
	right(primary_poc, length(primary_poc)- position(' ' in primary_poc)) lastname
from accounts

--CONCAT
-- 5.

--Example of Concat
select concat(name, ' ', website)
from accounts

with t1 as (
select primary_poc, name,
    left(primary_poc, position(' ' in primary_poc)-1) first_name,
	right(primary_poc, length(primary_poc)- position(' ' in primary_poc)) lastname
from accounts
)
select primary_poc,
	concat(first_name, '.', lastname, '@', name, '.com')
from t1

--6.

select lower(concat(left(primary_poc, position(' ' in primary_poc) - 1), '.' ,
 right(primary_poc, length(primary_poc) - position(' ' in primary_poc)),
 '@', replace(name, ' ',''),'.','com'))
from accounts

--OR

with t1 as (
select primary_poc, name,
    left(primary_poc, position(' ' in primary_poc)-1) first_name,
	right(primary_poc, length(primary_poc)- position(' ' in primary_poc)) lastname
from accounts
)
select primary_poc,
	concat(first_name, '.', lastname, '@',replace(name, ' ', ''), '.com')
from t1

--7

select substr(name, 4, 2)
from accounts

with t1 as (
select primary_poc, replace(name, ' ', '') as company, sales_rep_id,
	lower(left(primary_poc, position(' ' in primary_poc)-1)) first_name,
	lower(right(primary_poc, length(primary_poc) - position(' ' in primary_poc))) lastname
from accounts
)
select primary_poc,
		concat(left(first_name,1),
		right(first_name,1),
		upper(left(lastname, 1)),
		upper(right(lastname,1)),
		length(first_name),
		length(lastname),
		company,
		substr(sales_rep_id::text,4,2))
from t1

--8

select *, sum(total_amt_usd) over() as overall_total
from orders

--9.

select account_id, total_amt_usd,
	sum(total_amt_usd) over(partition by account_id) as overall_total_byaccount,
	count(*) over(partition by account_id) as count_byaccount
from orders

--10

select occurred_at, standard_amt_usd,
	sum(standard_amt_usd) over(order by occurred_at) as running_total
from orders

--11

select occurred_at, standard_amt_usd, date_trunc('month', occurred_at),
	sum(standard_amt_usd) over(partition by date_trunc('month', occurred_at) order by occurred_at) as running_total_month
from orders

-- 12
select occurred_at, standard_qty, date_trunc('year', occurred_at),
	sum(standard_qty) over(partition by date_trunc('year', occurred_at) order by occurred_at) as running_total_month
from orders

-- 13

select standard_qty,
	row_number() over(order by standard_qty),
	rank() over(order by standard_qty),
	dense_rank() over(order by standard_qty)
from orders
where account_id = 1001

--14

select account_id, standard_qty,
	row_number() over(partition by account_id order by standard_qty),
	rank() over(partition by account_id order by standard_qty),
	dense_rank() over(partition by account_id order by standard_qty)
from orders

--15

select id, account_id, standard_qty,
	dense_rank() over(partition by account_id order by standard_qty) d_rank,
	sum(standard_qty) over (partition by account_id order by standard_qty) sum_std_qty,
	avg (standard_qty) over (partition by account_id order by standard_qty) avg_std_qty,
	min (standard_qty) over (partition by account_id order by standard_qty) min_std_qty,
	max (standard_qty) over (partition by account_id order by standard_qty) max_std_qty
from orders

--16

select id, account_id, standard_qty,
	dense_rank() over(partition by account_id order by standard_qty) d_rank,
	sum (standard_qty) over account_window sum_std_qty,
	avg (standard_qty) over account_window avg_std_qty,
	min (standard_qty) over account_window min_std_qty,
	max (standard_qty) over account_window max_std_qty
from orders
window account_window as (partition by account_id order by standard_qty)

-- 17

select account_id, occurred_at, standard_qty,
	ntile(4) over(partition by account_id order by standard_qty) as standard_qty_quartile
from orders

--18
select account_id, occurred_at, standard_qty,
	ntile(2) over(partition by account_id order by gloss_qty) as standard_qty_quartile
from orders
