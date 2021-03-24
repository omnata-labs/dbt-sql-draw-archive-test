{{ config(materialized='new_layer') }}
select x,y, case {{ chessboard(width=50) }} else colour end as colour
from {{ ref('blank_canvas_200_200') }}
