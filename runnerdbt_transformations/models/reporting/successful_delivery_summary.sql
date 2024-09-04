{{ config(
    materialized='table'
) }}

WITH delivery_info AS (
    SELECT 
        co.customer_id, 
        co.order_id, 
        ro.runner_id, 
        rr.rating, 
        co.order_time, 
        ro.pickup_time,
        (EXTRACT(epoch FROM ro.pickup_time) - EXTRACT(epoch FROM co.order_time)) / 60 AS time_between_order_and_pickup,
        ro.duration, 
        ((ro.distance::float * 60) / ro.duration::float)::NUMERIC AS average_speed -- Average speed: distance (km) per minute
    FROM {{ ref('customer_orders_processed') }} co
    JOIN {{ ref('runner_orders_processed') }} ro ON co.order_id = ro.order_id  
    JOIN {{ source('pizza_runner','runner_ratings') }} rr ON co.order_id = rr.order_id 
    WHERE ro.cancellation IS NULL
),
pizza_count AS (
    SELECT 
        co.order_id,
        COUNT(co.pizza_id) AS total_pizzas
    FROM {{ ref('customer_orders_processed') }} co
    GROUP BY co.order_id
)
SELECT 
    di.customer_id, 
    di.order_id, 
    di.runner_id, 
    di.rating, 
    di.order_time, 
    di.pickup_time, 
    di.time_between_order_and_pickup, 
    di.duration, 
    di.average_speed, 
    pc.total_pizzas
FROM delivery_info di
LEFT JOIN pizza_count pc ON di.order_id = pc.order_id