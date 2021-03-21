{{ config(materialized='new_layer') }}

select x,y, case
    when {{ circle_filled([180,180],20) }} then {{ colour_code("yellow") }}
    {{ rainbow(center=[100,100], height=75,stripe_height=5) }}
    else '#87ceeb'
    end as colour
from {{ ref('blank_canvas_200_200') }}
where y>=100
