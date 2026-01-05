select
    property_name,
    property_type,
    city,
    state,
    country,
    purchase_price,
    purchase_date,
    is_active
from {{ source("Property", "property") }}
