-- macros/handle_exclusions_extras.sql

{% macro handle_exclusions_extras(order_id) %}

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
        UNNEST(string_to_array(extras,','))::INTEGER AS item_value,
        'Extra' AS item_type
    FROM {{ ref('customer_orders_processed') }}
    WHERE extras IS NOT NULL
),
extras_and_exclusions AS (
    SELECT * FROM exclusions_unnested
    UNION ALL
    SELECT * FROM extras_unnested
)

SELECT
    order_id,
    item_value,
    item_type
FROM extras_and_exclusions
WHERE order_id = {{ order_id }}

{% endmacro %}
