with cte_customer_orders as(
 SELECT
	order_id,
	customer_id, 
	pizza_id, 
	case when exclusions = '' then NULL
		when exclusions = 'null' then NULL
	else exclusions
	end AS exclusions,
	case
		when extras = '' then null
		when extras = 'null' then null
	else extras
	end AS extras,
	order_time ,
	row_number() over (partition by order_id, customer_id, pizza_id, order_time order by exclusions asc, extras asc) as rn
  FROM {{source('staging','customer_orders')}}
  )
 select 
        cast(order_id as integer) as order_id, 
        cast(customer_id as integer) as customer_id, 
        cast(pizza_id as integer) as pizza_id, 
        exclusions, 
        extras, 
        cast(order_time as timestamp) as order_time
 from cte_customer_orders where rn = 1