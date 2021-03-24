{{ config(materialized='new_layer') }}

select x,y, 
    case
        when POWER(x-130,2) + POWER(y-160,2) < 300 then '#ffffff'
        when POWER(x-110,2) + POWER(y-165,2) < 250 then '#ffffff'
        when POWER(x-140,2) + POWER(y-155,2) < 300 then '#ffffff'
        when POWER(x-140,2) + POWER(y-175,2) < 300 then '#ffffff'
    else colour
    end as colour
from {{ ref('brick_wall_and_sky_mortar_with_cat') }}
