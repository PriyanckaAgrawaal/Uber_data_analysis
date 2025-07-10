-- SQL Script: Insights from Uber Request Data

-- 1. Total Requests by Status
SELECT status, COUNT(*) AS total_requests
FROM uber_requests
GROUP BY status;

-- 2. Requests by Pickup Point
SELECT pickup_point, COUNT(*) AS total_requests
FROM uber_requests
GROUP BY pickup_point;

-- 3. Requests by Hour and Status
SELECT EXTRACT(HOUR FROM request_timestamp) AS request_hour,
       status,
       COUNT(*) AS total_requests
FROM uber_requests
GROUP BY request_hour, status
ORDER BY request_hour;

-- 4. Cancelled Trips from Each Pickup Point
SELECT pickup_point, COUNT(*) AS cancelled_requests
FROM uber_requests
WHERE status = 'Cancelled'
GROUP BY pickup_point;

-- 5. Requests with No Cars Available
SELECT COUNT(*) AS no_cars_available
FROM uber_requests
WHERE status = 'No Cars Available';

-- 6. Trip Completion Rate
SELECT 
    (SUM(CASE WHEN status = 'Trip Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS completion_rate_percent
FROM uber_requests;

-- 7. Requests without a Driver Assigned
SELECT COUNT(*) AS no_driver_assigned
FROM uber_requests
WHERE driver_id IS NULL;

-- 8. Total Trips Completed by Each Driver
SELECT driver_id, COUNT(*) AS completed_trips
FROM uber_requests
WHERE status = 'Trip Completed'
GROUP BY driver_id
ORDER BY completed_trips DESC;

-- 9. Average Trip Duration (minutes)
SELECT AVG(TIMESTAMPDIFF(MINUTE, request_timestamp, drop_timestamp)) AS avg_trip_duration
FROM uber_requests
WHERE status = 'Trip Completed';

-- 10. Busiest Hours of the Day (All Requests)
SELECT EXTRACT(HOUR FROM request_timestamp) AS request_hour, COUNT(*) AS total_requests
FROM uber_requests
GROUP BY request_hour
ORDER BY total_requests DESC;
