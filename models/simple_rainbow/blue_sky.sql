{{ config(materialized='new_layer') }}
/*
    Add a blue sky
*/

select x,y,'#87ceeb' as colour
from {{ ref('blank_canvas') }}
where y>=100
