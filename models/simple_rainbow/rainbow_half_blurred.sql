{{ config(materialized='new_layer') }}

select x,y, case {{ blur() }} else colour end as colour
from {{ ref('grass') }}
where x between 100 and 200