-- =========================================
-- SMART FACTORY DATABASE
-- DATA INSERTION
-- =========================================

-- =========================
-- 1. MACHINES
-- =========================

INSERT INTO Machines
(machine_name, machine_type, location, installation_date, status)
VALUES
('CNC Machine 01', 'CNC', 'Production Hall A', '2022-01-10', 'Active'),
('CNC Machine 02', 'CNC', 'Production Hall A', '2022-03-15', 'Active'),
('Welding Robot 01', 'Robotic Welding', 'Production Hall B', '2021-06-20', 'Active'),
('Assembly Robot 02', 'Assembly Robot', 'Production Hall B', '2022-08-05', 'Active'),
('Welding Robot 02', 'Robotic Welding', 'Production Hall B', '2021-11-12', 'Active'),
('Welding Robot 01', 'Robotic Welding', 'Production Hall C', '2023-01-18', 'Active'),
('Lathe Machine 01', 'Lathe', 'Production Hall A', '2021-09-25', 'Active'),
('Assembly Robot 01', 'Assembly Robot', 'Production Hall C', '2022-04-14', 'Active'),
('Injection Molder 02', 'Injection Molding', 'Production Hall C', '2023-02-10', 'Active'),
('Injection Molder 01', 'Injection Molding', 'Production Hall C', '2022-05-30', 'Active');


-- =========================
-- 2. SENSORS
-- =========================

INSERT INTO Sensors
(machine_id, sensor_type, unit, installation_date)
SELECT
    m.machine_id,
    s.sensor_type,
    s.unit,
    m.installation_date
FROM Machines m
CROSS JOIN (
    VALUES
        ('Temperature', '°C'),
        ('Vibration', 'mm/s'),
        ('Power', 'kW')
) AS s(sensor_type, unit);


-- =========================
-- 3. SENSOR READINGS
-- 720 readings per machine
-- 10 machines = 7200 readings
-- =========================

INSERT INTO Sensor_Readings
(machine_id, reading_time, temperature, vibration, power_consumption)

SELECT
    m.machine_id,

    TIMESTAMP '2026-01-01 00:00:00'
        + (g * INTERVAL '1 hour'),

    ROUND(
        (
            55
            + RANDOM() * 15
            + CASE
                WHEN m.machine_id IN (2, 7)
                     AND g > 300
                THEN RANDOM() * 20
                ELSE 0
              END
        )::numeric,
        2
    ),

    ROUND(
        (
            2
            + RANDOM() * 2
            + CASE
                WHEN m.machine_id IN (2, 7)
                     AND g > 300
                THEN RANDOM() * 4
                ELSE 0
              END
        )::numeric,
        2
    ),

    ROUND(
        (5 + RANDOM() * 5)::numeric,
        2
    )

FROM Machines m
CROSS JOIN generate_series(0, 719) AS g;


-- =========================
-- 4. PRODUCTION
-- 90 days × 10 machines
-- =========================

INSERT INTO Production
(machine_id, production_date, shift, units_produced, defective_units)

SELECT
    m.machine_id,
    d.production_date,

    CASE
        WHEN EXTRACT(DOW FROM d.production_date) % 3 = 0
            THEN 'Morning'
        WHEN EXTRACT(DOW FROM d.production_date) % 3 = 1
            THEN 'Evening'
        ELSE 'Night'
    END,

    CASE
        WHEN m.machine_id IN (2, 7)
             AND d.production_date >= '2026-01-14'
        THEN 70 + FLOOR(RANDOM() * 20)::INT

        ELSE 90 + FLOOR(RANDOM() * 30)::INT
    END,

    CASE
        WHEN m.machine_id IN (2, 7)
             AND d.production_date >= '2026-01-14'
        THEN 8 + FLOOR(RANDOM() * 6)::INT

        ELSE 1 + FLOOR(RANDOM() * 4)::INT
    END

FROM Machines m
CROSS JOIN generate_series(
    DATE '2026-01-01',
    DATE '2026-03-31',
    INTERVAL '1 day'
) AS d(production_date);


-- =========================
-- 5. MAINTENANCE
-- =========================

INSERT INTO Maintenance
(machine_id, maintenance_date, maintenance_type,
 description, downtime_hours, maintenance_cost)

VALUES

(1, '2026-01-10', 'Preventive',
 'Routine inspection and lubrication',
 2.0, 3500),

(1, '2026-02-15', 'Preventive',
 'Scheduled maintenance',
 1.5, 2200),

(2, '2026-01-15', 'Corrective',
 'High vibration detected',
 5.0, 7500),

(2, '2026-01-22', 'Emergency',
 'Overheating and vibration issue',
 8.0, 12500),

(3, '2026-01-12', 'Preventive',
 'Routine inspection',
 2.5, 5000),

(3, '2026-02-20', 'Preventive',
 'Lubrication and inspection',
 2.0, 6250),

(4, '2026-01-18', 'Corrective',
 'Assembly mechanism adjustment',
 3.0, 7500),

(4, '2026-02-10', 'Preventive',
 'Scheduled maintenance',
 2.0, 5000),

(5, '2026-01-20', 'Preventive',
 'Welding system inspection',
 2.0, 3500),

(5, '2026-02-18', 'Preventive',
 'Routine maintenance',
 2.0, 3000),

(6, '2026-01-25', 'Preventive',
 'Robot arm inspection',
 2.0, 3500),

(6, '2026-02-25', 'Preventive',
 'Scheduled maintenance',
 2.0, 3500),

(7, '2026-01-14', 'Corrective',
 'Abnormal vibration detected',
 5.5, 8000),

(7, '2026-01-20', 'Emergency',
 'Overheating and excessive vibration',
 9.0, 15000),

(7, '2026-01-27', 'Corrective',
 'Bearing replacement',
 7.0, 11000),

(7, '2026-02-05', 'Preventive',
 'Post-repair inspection',
 2.0, 3500),

(8, '2026-01-16', 'Preventive',
 'Assembly system inspection',
 2.0, 4000),

(8, '2026-02-12', 'Preventive',
 'Routine maintenance',
 2.0, 3000),

(9, '2026-01-30', 'Preventive',
 'Mold inspection',
 2.5, 5000),

(10, '2026-02-02', 'Preventive',
 'Injection system inspection',
 2.0, 3500);