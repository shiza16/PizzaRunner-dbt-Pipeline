WITH pizza_price AS (
    SELECT 
        co.order_id,
        co.customer_id,
        ro.runner_id,
        distance::float,
        SUM({{ calculate_pizza_price('co.pizza_id') }}) AS pizza_price
    FROM {{ ref('customer_orders_processed') }} AS co
    LEFT JOIN {{ ref('runner_orders_processed') }} AS ro ON co.order_id = ro.order_id  
    WHERE ro.cancellation IS NULL
    GROUP BY co.order_id, co.customer_id, ro.runner_id, distance
),
profit_per_pizza AS (
    SELECT 
        order_id,
        customer_id,
        runner_id,
        pizza_price,
        distance,
        distance * 0.30 AS runner_payment,
        pizza_price - (distance * 0.30) AS profit_per_order
    FROM pizza_price
)
SELECT 
    *
FROM profit_per_pizza