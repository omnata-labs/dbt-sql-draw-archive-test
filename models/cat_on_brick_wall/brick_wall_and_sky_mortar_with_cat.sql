{{ config(materialized='new_layer') }}

select x,y, 
    case
        when {{ oval_filled(center=[70,120], diameter=200, ratio_x=1,ratio_y=0.5) }} then '#D2691E' -- body
        when {{ oval_filled(center=[45,138], diameter=3, ratio_x=0.5,ratio_y=1) }} then '#000000' -- ear 1
        when {{ oval_filled(center=[55,138], diameter=3, ratio_x=0.5,ratio_y=1) }} then '#000000' -- ear 1
        when {{ circle_filled([45,138],4) }} then '#C1B04F' -- eye 1
        when {{ circle_filled([55,138],4) }} then '#C1B04F' -- eye 1
        
        when {{ rectangle(top_left=[45,100], bottom_right=[50,120])}} then '#D2691E' -- leg 1
        when {{ rectangle(top_left=[55,100], bottom_right=[60,120])}} then '#D2691E' -- leg 2
        when {{ rectangle(top_left=[80,100], bottom_right=[85,120])}} then '#D2691E' -- leg 3
        when {{ rectangle(top_left=[90,100], bottom_right=[95,120])}} then '#D2691E' -- leg 4
        when {{ circle_filled([50,135],15) }} then '#D2691E' -- head
        when {{ oval_filled(center=[60,150], diameter=20, ratio_x=0.5,ratio_y=1) }} then '#D2691E' -- ear 1
        when {{ oval_filled(center=[40,150], diameter=20, ratio_x=0.5,ratio_y=1) }} then '#D2691E' -- ear 2

        when x between 216-y and 220-y and x between 95 and 115 then '#D2691E' -- tail
    else colour
    end as colour
from {{ ref('brick_wall_and_sky_mortar') }}
