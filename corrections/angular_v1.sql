CREATE TABLE clients(
	id integer not null AUTO_INCREMENT PRIMARY key,
	companyName varchar(100) NOT null,
	firstName varchar(100) NOT null,
	lastName varchar(100) NOT null,
	email varchar(100) NOT null,
	phone varchar(15) NOT null,
	address Text NOT null,
	zipCode varchar(15) NOT null,
	city varchar(15) NOT null,
	country varchar(15) NOT null,
	state BOOLEAN DEFAULT 0);-- (ACTIVE, INACTIVE))


create table orders( 
	id integer not null primary key,
    clientId integer not null,
	typePresta varchar(100) not null,
    designation varchar(100) not null,
	nbDays integer not null,
	unitPrice float not null,
	--totalExcludeTaxe float not null,
	-- totalWithTaxe float not null,
	state BOOLEAN NOT NULL,  
    FOREIGN key(clientId) REFERENCES clients(id) on DELETE CASCADE on UPDATE CASCADE
    );
