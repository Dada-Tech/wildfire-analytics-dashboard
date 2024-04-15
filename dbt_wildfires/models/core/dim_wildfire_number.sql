select 
wildfire_number,
forest_area
from {{ ref('wildfire_number_forest_area') }}