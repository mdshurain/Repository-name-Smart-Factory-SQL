-- =========================================
-- SMART FACTORY
-- PRODUCTION ANALYSIS
-- =========================================

-- 1. View all production records

SELECT *
FROM Production;


-- 2. Total units produced by each machine

SELECT
    machine_id,
    SUM(units_produced) AS total_units
FROM Production
GROUP BY machine_id
ORDER BY total_units DESC;


-- 3. Total defective units by each machine

SELECT
    machine_id,
    SUM(defective_units) AS total_defects
FROM Production
GROUP BY machine_id
ORDER BY total_defects DESC;


-- 4. Calculate defect rate for each machine

SELECT
    machine_id,
    SUM(units_produced) AS total_units,
    SUM(defective_units) AS total_defects,
    ROUND(
        SUM(defective_units) * 100.0 /
        SUM(units_produced),
        2
    ) AS defect_rate
FROM Production
GROUP BY machine_id
ORDER BY defect_rate DESC;


-- 5. Machines with defect rate above 5%

SELECT
    machine_id,
    SUM(units_produced) AS total_units,
    SUM(defective_units) AS total_defects,
    ROUND(
        SUM(defective_units) * 100.0 /
        SUM(units_produced),
        2
    ) AS defect_rate
FROM Production
GROUP BY machine_id
HAVING
    SUM(defective_units) * 100.0 /
    SUM(units_produced) > 5
ORDER BY defect_rate DESC;


-- 6. Machine names with their production performance

SELECT
    Machines.machine_id,
    Machines.machine_name,
    SUM(Production.units_produced) AS total_units,
    SUM(Production.defective_units) AS total_defects,
    ROUND(
        SUM(Production.defective_units) * 100.0 /
        SUM(Production.units_produced),
        2
    ) AS defect_rate
FROM Machines
INNER JOIN Production
    ON Machines.machine_id = Production.machine_id
GROUP BY
    Machines.machine_id,
    Machines.machine_name
ORDER BY defect_rate DESC;


-- 7. Machine with the highest production

SELECT
    Machines.machine_name,
    SUM(Production.units_produced) AS total_units
FROM Machines
INNER JOIN Production
    ON Machines.machine_id = Production.machine_id
GROUP BY Machines.machine_name
ORDER BY total_units DESC
LIMIT 1;


-- 8. Machine with the highest defect rate

SELECT
    Machines.machine_name,
    ROUND(
        SUM(Production.defective_units) * 100.0 /
        SUM(Production.units_produced),
        2
    ) AS defect_rate
FROM Machines
INNER JOIN Production
    ON Machines.machine_id = Production.machine_id
GROUP BY Machines.machine_name
ORDER BY defect_rate DESC
LIMIT 1;