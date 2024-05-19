select 
wildfire_number,
forest_area
from {{ ref('stage-of-control') }}