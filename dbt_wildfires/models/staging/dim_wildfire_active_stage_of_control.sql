select 
stage,
description
from {{ ref('stage-of-control') }}