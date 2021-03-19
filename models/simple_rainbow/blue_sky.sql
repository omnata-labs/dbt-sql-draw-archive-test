{{ config(materialized='new_layer') }}
/*
    Add a blue sky
*/

select x,y, case
    when {{ circle_filled([150,150],20) }} then 'yellow'
    else '#87ceeb'
    end as colour
from {{ ref('blank_canvas') }}
where y>=100
