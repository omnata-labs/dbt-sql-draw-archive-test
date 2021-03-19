{{ config(materialized='new_layer') }}

select x,y,'#228b22' as colour
from {{ ref('blue_sky') }}
where y<100
