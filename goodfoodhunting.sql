CREATE DATABASE goodfoodhunting;

CREATE TABLE dishes (
	id SERIAL4 PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	image_url VARCHAR(200) 
);

INSERT INTO dishes (name, image_url) 
VALUES ('momos','http://s3.amazonaws.com/foodspotting-ec2/reviews/1270161/thumb_600.jpg?1327975061?1453075057' );

INSERT INTO dishes (name, image_url) 
VALUES ('papadums','http://s3.amazonaws.com/foodspotting-ec2/reviews/5714185/thumb_600.jpg?1453026187?1453075158' );


CREATE TABLE dish_types (
	id SERIAL4 PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

INSERT INTO dish_types (name) VALUES ('snack');
INSERT INTO dish_types (name) VALUES ('dessert');
INSERT INTO dish_types (name) VALUES ('lunch');
INSERT INTO dish_types (name) VALUES ('dinner');

CREATE TABLE users (
	id SERIAL4 PRIMARY KEY,
	email VARCHAR(200) NOT NULL,
	password_digest VARCHAR(400) NOT NULL
);

CREATE TABLE likes (
	id SERIAL4 PRIMARY KEY,
	user_id INTEGER NOT NULL,
	dish_id INTEGER NOT NULL
);


