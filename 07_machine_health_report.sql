-- =========================================
-- SMART FACTORY
-- FINAL MACHINE HEALTH REPORT
-- =========================================

WITH sensor_summary AS (

    SELECT
        machine_id,
        ROUND(AVG(temperature), 2) AS avg_temperature,
        ROUND(AVG(vibration), 2) AS avg_vibration
    FROM Sensor_Readings
    GROUP BY machine_id

),

production_summary AS (

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

),

maintenance_summary AS (

    SELECT
        machine_id,
        SUM(maintenance_cost) AS total_maintenance_cost,
        SUM(downtime_hours) AS total_downtime
    FROM Maintenance
    GROUP BY machine_id

)

SELECT

    m.machine_id,
    m.machine_name,
    m.machine_type,
    m.status,

    s.avg_temperature,
    s.avg_vibration,

    p.total_units,
    p.total_defects,
    p.defect_rate,

    ms.total_maintenance_cost,
    ms.total_downtime,

    CASE

        WHEN s.avg_temperature > 65
             AND s.avg_vibration > 3.5
             AND p.defect_rate > 5
        THEN 'Critical'

        WHEN s.avg_temperature > 62
             OR s.avg_vibration > 3
             OR p.defect_rate > 3
        THEN 'Warning'

        ELSE 'Healthy'

    END AS machine_health

FROM Machines m

INNER JOIN sensor_summary s
    ON m.machine_id = s.machine_id

INNER JOIN production_summary p
    ON m.machine_id = p.machine_id

INNER JOIN maintenance_summary ms
    ON m.machine_id = ms.machine_id

ORDER BY
    p.defect_rate DESC;