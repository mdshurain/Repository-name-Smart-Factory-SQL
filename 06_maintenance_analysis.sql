-- =========================================
-- SMART FACTORY
-- MAINTENANCE ANALYSIS
-- =========================================

-- 1. View all maintenance records

SELECT *
FROM Maintenance;


-- 2. Total maintenance cost for each machine

SELECT
    machine_id,
    SUM(maintenance_cost) AS total_maintenance_cost
FROM Maintenance
GROUP BY machine_id
ORDER BY total_maintenance_cost DESC;


-- 3. Total downtime for each machine

SELECT
    machine_id,
    SUM(downtime_hours) AS total_downtime
FROM Maintenance
GROUP BY machine_id
ORDER BY total_downtime DESC;


-- 4. Maintenance cost with machine names

SELECT
    Machines.machine_id,
    Machines.machine_name,
    SUM(Maintenance.maintenance_cost) AS total_maintenance_cost
FROM Machines
INNER JOIN Maintenance
    ON Machines.machine_id = Maintenance.machine_id
GROUP BY
    Machines.machine_id,
    Machines.machine_name
ORDER BY total_maintenance_cost DESC;


-- 5. Downtime with machine names

SELECT
    Machines.machine_id,
    Machines.machine_name,
    SUM(Maintenance.downtime_hours) AS total_downtime
FROM Machines
INNER JOIN Maintenance
    ON Machines.machine_id = Maintenance.machine_id
GROUP BY
    Machines.machine_id,
    Machines.machine_name
ORDER BY total_downtime DESC;


-- 6. Machine with the highest maintenance cost

SELECT
    Machines.machine_name,
    SUM(Maintenance.maintenance_cost) AS total_maintenance_cost
FROM Machines
INNER JOIN Maintenance
    ON Machines.machine_id = Maintenance.machine_id
GROUP BY Machines.machine_name
ORDER BY total_maintenance_cost DESC
LIMIT 1;


-- 7. Machine with the highest downtime

SELECT
    Machines.machine_name,
    SUM(Maintenance.downtime_hours) AS total_downtime
FROM Machines
INNER JOIN Maintenance
    ON Machines.machine_id = Maintenance.machine_id
GROUP BY Machines.machine_name
ORDER BY total_downtime DESC
LIMIT 1;