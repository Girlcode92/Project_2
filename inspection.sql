#food_inspection_db 
CREATE TABLE inspection (
    inspection_id INT PRIMARY KEY,
    business_name VARCHAR(150) NOT NULL,
    aka_name VARCHAR(150) Default ' ',
    license_id INT NOT NULL,
	facility_type VARCHAR(100),
	risk_rank INT,
	risk_category VARCHAR(20),
    address VARCHAR(150),
    city VARCHAR(50),
    state_id VARCHAR(2) Default ' ',
    zip INT,
    inspection_date DATE,
    inspection_type VARCHAR(150),
    results VARCHAR(50)
);