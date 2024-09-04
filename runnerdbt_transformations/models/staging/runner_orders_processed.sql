select 
	 cast(order_id as integer) as order_id,
	 cast(runner_id as integer) as runner_id,
	 case when pickup_time = '' then null 
	 	  when pickup_time = 'null' then null 
	 else cast(pickup_time as timestamp)
	 end as pickup_time, 
	 case when distance = 'null' then null 
	 else regexp_replace(distance,'[a-z]+','')::float 
	 end as distance,
	 case when duration = 'null' then null 
	 else regexp_replace(duration,'[a-z]+','')::float
	 end as duration,
	 case when cancellation = 'null' then null 
	 	  when cancellation = '' then null 
	else cast(cancellation as varchar(75)) end
from {{source('staging','runner_orders')}}