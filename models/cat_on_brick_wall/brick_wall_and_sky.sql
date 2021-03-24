{{ config(materialized='new_layer') }}

select x,y, 
    case
        when y>=100 then '#87ceeb' -- blue sky
        {{ random_colour_from_mix(colour_mix=[['#68170C',0.6],['#5F0D07',0.2],['#660D07',0.1],['#6A130C',0.1]]) }}
    else '#ffffff'
    end as colour
from {{ ref('blank_canvas_200_200') }}

