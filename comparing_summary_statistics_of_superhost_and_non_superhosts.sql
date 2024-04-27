SELECT
    CASE
        WHEN host_is_superhost = 't' THEN 'SUPERHOST'
        ELSE 'NOT SUPERHOST'
    END AS is_superhost,
    ROUND(AVG(number_of_reviews)) AS avg_num_reviews,
    ROUND(AVG(365 - availability_365), 2) AS avg_num_days_booked_in_next_year,
    ROUND(AVG(DATEDIFF(NOW(), host_since)) / 365, 2) AS avg_num_yrs_as_host,
    ROUND(AVG(REPLACE(host_response_rate, '%', '')), 2) AS avg_response_rate,
    AVG(CASE
        WHEN host_identity_verified = 't'THEN TRUE
        WHEN host_identity_verified = 'f' THEN FALSE
        ELSE FALSE
    END) AS percent_with_id_verified,
    AVG(CASE
        WHEN host_has_profile_pic = 't' THEN TRUE
        WHEN host_has_profile_pic = 'f' THEN FALSE
        ELSE FALSE
    END) AS percent_with_profile_pic,
    ROUND(AVG(LENGTH(host_verifications) - LENGTH(REPLACE(host_verifications, ',', '')) + 1), 2) AS avg_num_host_verifications,
    ROUND(AVG(host_listings_count), 2) AS avg_num_listings,
    ROUND(AVG(host_total_listings_count), 2) AS avg_total_num_listings,
    ROUND(AVG(beds), 2) AS avg_num_beds,
    ROUND(AVG(REPLACE(price, '$', '')), 2) AS avg_price,
    ROUND(AVG(JSON_LENGTH(JSON_EXTRACT(amenities, '$'))), 2) AS avg_num_amenities
FROM
    rome_listings
WHERE
    host_is_superhost IS NOT NULL
GROUP BY
    host_is_superhost;