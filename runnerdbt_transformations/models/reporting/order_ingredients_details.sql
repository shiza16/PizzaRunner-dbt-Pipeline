WITH exclusions_unnested AS (
    SELECT 
        order_id,
        UNNEST(string_to_array(exclusions, ','))::INTEGER AS item_value,
        'Exclusion' AS item_type
    FROM {{ ref('customer_orders_processed') }}
    WHERE exclusions IS NOT NULL
),
extras_unnested AS (
    SELECT 
        order_id,
        UNNEST(string_to_array(extras, ','))::INTEGER AS item_value,
        'Extra' AS item_type
    FROM {{ref('customer_orders_processed')}}
    WHERE extras IS NOT NULL
),
extras_and_exclusions AS (
    SELECT * FROM exclusions_unnested
    UNION ALL
    SELECT * FROM extras_unnested
),
descriptive_order AS (
    SELECT 
        co.order_id, 
        pn.pizza_name, 
        CASE 
            WHEN ee.item_type IS NOT NULL 
            THEN CONCAT(ee.item_type, ' - ', STRING_AGG(DISTINCT pt.topping_name, ', '))
            ELSE NULL 
        END AS ingredient
    FROM {{ref('customer_orders_processed')}} co
    LEFT JOIN extras_and_exclusions ee ON co.order_id = ee.order_id
    LEFT JOIN {{ source('pizza_runner', 'pizza_names')  }} pn ON co.pizza_id = pn.pizza_id 
    LEFT JOIN {{source('pizza_runner','pizza_toppings')}} pt ON ee.item_value = pt.topping_id
    GROUP BY co.order_id, pn.pizza_name, ee.item_type
),
ordered_ingredients AS (
    SELECT 
        order_id,
        pizza_name,
        STRING_AGG(ingredient, ', ') AS ingredient_list
    FROM descriptive_order
    GROUP BY order_id, pizza_name
)
SELECT 
    order_id,
    CASE 
        WHEN ingredient_list IS NOT NULL 
        THEN CONCAT(pizza_name, ' - ', ingredient_list) 
        ELSE pizza_name 
    END AS formatted_order
FROM ordered_ingredients
