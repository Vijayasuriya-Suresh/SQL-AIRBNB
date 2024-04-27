SELECT
    name,
    availability_30 AS num_days_available_within_month,
    ROUND(6371 * acos(
		cos(radians(41.86399717721101))
		* cos(radians(latitude))
		* cos(radians(longitude) - radians(12.490918994897651))
		+ sin(radians(41.86399717721101))
		* sin(radians(latitude))
	), 2) AS km_to_fountain,
    REPLACE(price, '$', '') AS price_numeric,
    CASE
        WHEN host_response_time = 'within an hour' THEN 1  # hours till response
        WHEN host_response_time = 'within a few hours' THEN 12
        WHEN host_response_time = 'within a day' THEN 24
        WHEN host_response_time = 'a few days or more' THEN 72
        WHEN host_response_time IS NULL THEN NULL
	END AS hours_till_host_response,
    room_type,
    description,
    listing_url
FROM
    rome_listings
WHERE
    availability_30 > 0 AND
    beds = 1 AND
    host_is_superhost = 't' AND
    room_type = 'Entire home/apt' AND
    minimum_nights <= 3 AND maximum_nights >= 5
HAVING
    km_to_fountain <= 1 AND
    price_numeric <= 300 AND
    hours_till_host_response <= 24
ORDER BY
    availability_30 DESC;