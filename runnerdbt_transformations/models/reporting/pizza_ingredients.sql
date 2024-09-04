-- models/pizza_ingredients.sql
select 
    pn.pizza_name, 
    string_agg(pt.topping_name, ', ') as standard_ingredients
from 
    {{ source('pizza_runner', 'pizza_names')  }} pn
join 
    {{ ref('pizza_recipes_processed') }} npr 
    on pn.pizza_id = npr.pizza_id 
join 
    {{ source('pizza_runner', 'pizza_toppings')  }} pt 
    on npr.topping_id = pt.topping_id
group by 
    pn.pizza_name
