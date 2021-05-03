--TABLE CREATION

CREATE TABLE mechanic(
	mechanic_id SERIAL PRIMARY KEY,
	first_name VARCHAR(20),
	last_name VARCHAR(20)
);

CREATE TABLE part(
	part_id SERIAL PRIMARY KEY,
	brand VARCHAR(20),
	_description VARCHAR(100)
);

CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name  VARCHAR(20),
	last_name  VARCHAR(20),
	_address  VARCHAR(50)
);

CREATE TABLE salesperson(
	salesperson_id SERIAL PRIMARY KEY,
	first_name  VARCHAR(20),
	last_name  VARCHAR(20)
);

CREATE TABLE car(
	VIN SERIAL PRIMARY KEY,
	customer_id INTEGER,
	invoice_id INTEGER,
	salesperson_id INTEGER ,
	make VARCHAR(20), 
	model VARCHAR(20),
	_year NUMERIC (4),
	condition VARCHAR(20)
);

CREATE TABLE invoice(
	invoice_id SERIAL PRIMARY KEY,
	customer_id INTEGER,
	salesperson_id INTEGER,
	VIN INTEGER ,
	service_id INTEGER, 
	amount NUMERIC(6,2),
	invoice_date DATE,
	_description VARCHAR(100)
);

CREATE TABLE service_ticket(
	service_id SERIAL PRIMARY KEY,
	customer_id INTEGER,
	part_id INTEGER ,
	VIN INTEGER,
	_description VARCHAR(100),
	service_date DATE
);

CREATE TABLE service_history(
	service_id INTEGER,
	mechanic_id INTEGER
);

--ADD FOREIGN KEYS 
ALTER TABLE car
ADD 
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id);

ALTER TABLE invoice
ADD
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (service_id) REFERENCES service_ticket(service_id),
FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id),
FOREIGN KEY (VIN) REFERENCES car(VIN);

ALTER TABLE service_ticket
ADD 
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (part_id) REFERENCES part(part_id),
FOREIGN KEY (VIN) REFERENCES car(VIN);

ALTER TABLE service_history
ADD 
FOREIGN KEY (service_id) REFERENCES service_ticket(service_id),
FOREIGN KEY (mechanic_id) REFERENCES mechanic(mechanic_id),


--INSERT TABLE DATA
INSERT INTO mechanic(
	mechanic_id,
	first_name,
	last_name
)VALUES(
	1,
	'Lu',
	'Desa'
),
(	
	2,
	'Ash',
	'Ketchum'
);

INSERT INTO part(
	part_id,
	brand,
	description
)VALUES(
	1,
	'Hitsu',
	'Alternator'
),
(	
	2,
	'Toyo',
	'Oil Filter'
);

INSERT INTO customer (
	customer_id,
	first_name,
	last_name,
	address
)VALUES(
	1,
	'Jonathan',
	'Contreras',
	'2634 W. 22nd Pl.'
),
(	
	2,
	'Mike',
	'Chanis',
	'222 w. Freemont St.'
);

INSERT INTO salesperson (
	salesperson_id,
	first_name,
	last_name
)VALUES(
	1,
	'Ivan',
	'Rakitic'
),
(	
	2,
	'Andre',
	'Deleoufeu'
);

INSERT INTO car(
	VIN,
	customer_id,
	invoice_id,
	salesperson_id ,
	make, 
	model,
	"year",
	condition
)VALUES(
	1,
	1,
	1,
	1,
	'Ford',
	'Escape',
	2002,
	'Used'
),
(	
	2,
	1,
	1,
	2,
	'Nissan',
	'Sentra',
	2016,
	'Used'
);

INSERT INTO invoice(
	invoice_id,
	customer_id,
	salesperson_id,
	VIN,
	service_id,
	amount,
	invoice_date,
	description
)VALUES(
	1,
	1,
	1,
	1,
	1,
	1000,
	'2021-05-02',
	'Used 2002 Ford Escape'
),
(	
	2,
	1,
	2,
	2,
	1,
	1500,
	'2021-05-02',
	'Used 2016 Nissan Sentra'
);

INSERT INTO service_ticket(
 	service_id, 
	customer_id,
	part_id,
	VIN,
	_description
)VALUES(
	1,
	1,
	2,
	1,
	'Oil change'
),
(
	1,
	1,
	2,
	1,
	'Alternator replacement'	
);


CREATE OR REPLACE FUNCTION add_service_history(
	_service_id INTEGER,
	_mechanic_id INTEGER,
)
RETURNS VOID
AS $MAIN$
BEGIN
	INSERT INTO service_history(service_id ,mechanic_id )
	VALUES(_service_id ,_mechanic_id );
END;
$MAIN$
LANGUAGE plpgsql;

Select add_service_history(1,1)

Select add_service_history(1,2)








