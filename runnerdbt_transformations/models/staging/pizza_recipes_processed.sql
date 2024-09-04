with cte_pizza_recipes as(
SELECT
    pizza_id,
    toppings
FROM
    {{source('staging','pizza_recipes')}}
)
SELECT
    pizza_id::int as pizza_id,
    unnest(string_to_array(toppings, ',')::int[]) AS topping_id
FROM
    cte_pizza_recipes