-- =========================================
-- SMART FACTORY DATABASE
-- TABLE CREATION
-- =========================================

CREATE TABLE Machines (
    machine_id SERIAL PRIMARY KEY,
    machine_name VARCHAR(100) NOT NULL,
    machine_type VARCHAR(50) NOT NULL,
    location VARCHAR(100),
    installation_date DATE,
    status VARCHAR(20) DEFAULT 'Active'
);

CREATE TABLE Sensors (
    sensor_id SERIAL PRIMARY KEY,
    machine_id INT NOT NULL,
    sensor_type VARCHAR(50) NOT NULL,
    unit VARCHAR(20),
    installation_date DATE,

    FOREIGN KEY (machine_id)
        REFERENCES Machines(machine_id)
);

CREATE TABLE Sensor_Readings (
    reading_id SERIAL PRIMARY KEY,
    machine_id INT NOT NULL,
    reading_time TIMESTAMP NOT NULL,
    temperature DECIMAL(5,2),
    vibration DECIMAL(5,2),
    power_consumption DECIMAL(6,2),

    FOREIGN KEY (machine_id)
        REFERENCES Machines(machine_id)
);

CREATE TABLE Production (
    production_id SERIAL PRIMARY KEY,
    machine_id INT NOT NULL,
    production_date DATE NOT NULL,
    shift VARCHAR(20) NOT NULL,
    units_produced INT NOT NULL,
    defective_units INT NOT NULL,

    FOREIGN KEY (machine_id)
        REFERENCES Machines(machine_id)
);

CREATE TABLE Maintenance (
    maintenance_id SERIAL PRIMARY KEY,
    machine_id INT NOT NULL,
    maintenance_date DATE NOT NULL,
    maintenance_type VARCHAR(30) NOT NULL,
    description VARCHAR(200),
    downtime_hours DECIMAL(5,2),
    maintenance_cost DECIMAL(10,2),

    FOREIGN KEY (machine_id)
        REFERENCES Machines(machine_id)
);