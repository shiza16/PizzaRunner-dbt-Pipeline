-- models/ingredients_list.sql

WITH exclusions_and_extras AS (
    {{ handle_exclusions_extras('order_id') }}
),
ingredients_list AS (
    SELECT 
        co.order_id, 
        co.pizza_id,
        pn.pizza_name, 
        pt.topping_name, 
        ee.item_type,
        CASE  
            WHEN ee.item_value = npc.topping_id AND ee.item_type = 'Extra' THEN CONCAT('2x', pt.topping_name) 
            WHEN ee.item_value = npc.topping_id AND ee.item_type = 'Exclusion' THEN NULL  -- Exclude this topping
            ELSE pt.topping_name 
        END AS ingredient
    FROM {{ ref('customer_orders_processed') }} co
    LEFT JOIN exclusions_and_extras ee ON co.order_id = ee.order_id
    LEFT JOIN {{source('destination_db', 'pizza_names')}}  pn ON co.pizza_id = pn.pizza_id
    LEFT JOIN {{ ref('pizza_recipes_processed') }} npc ON co.pizza_id = npc.pizza_id
    LEFT JOIN {{source('destination_db','pizza_toppings')}} pt ON npc.topping_id = pt.topping_id
),
final_ingredients_list AS (
    SELECT 
        order_id, 
        pizza_name, 
        STRING_AGG(DISTINCT ingredient, ', ' ORDER BY ingredient) AS ingredient_list 
    FROM ingredients_list
    GROUP BY order_id, pizza_name
)
SELECT 
    order_id, 
    CONCAT(pizza_name, ': ', ingredient_list) AS ingredients_list
FROM final_ingredients_list
