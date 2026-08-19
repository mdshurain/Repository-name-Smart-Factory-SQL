-- =========================================
-- SMART FACTORY
-- SENSOR ANALYSIS
-- =========================================

-- 1. View all sensor readings

SELECT *
FROM Sensor_Readings;


-- 2. Average temperature for each machine

SELECT
    machine_id,
    ROUND(AVG(temperature), 2) AS average_temperature
FROM Sensor_Readings
GROUP BY machine_id
ORDER BY average_temperature DESC;


-- 3. Average vibration for each machine

SELECT
    machine_id,
    ROUND(AVG(vibration), 2) AS average_vibration
FROM Sensor_Readings
GROUP BY machine_id
ORDER BY average_vibration DESC;


-- 4. Average power consumption for each machine

SELECT
    machine_id,
    ROUND(AVG(power_consumption), 2) AS average_power
FROM Sensor_Readings
GROUP BY machine_id
ORDER BY average_power DESC;


-- 5. Machines with high average vibration

SELECT
    machine_id,
    ROUND(AVG(vibration), 2) AS average_vibration
FROM Sensor_Readings
GROUP BY machine_id
HAVING AVG(vibration) > 3.5
ORDER BY average_vibration DESC;


-- 6. Machines with high average temperature

SELECT
    machine_id,
    ROUND(AVG(temperature), 2) AS average_temperature
FROM Sensor_Readings
GROUP BY machine_id
HAVING AVG(temperature) > 65
ORDER BY average_temperature DESC;