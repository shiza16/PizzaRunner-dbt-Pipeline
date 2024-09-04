{% macro calculate_pizza_price(pizza_id) %}
    CASE 
        WHEN {{ pizza_id }} = 1 THEN 12 
        WHEN {{ pizza_id }} = 2 THEN 10 
        ELSE 0 
    END
{% endmacro %}