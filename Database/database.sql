CREATE DATABASE Test;

USE Test;

CREATE TABLE ADMIN
(
	name VARCHAR(10),
	password VARCHAR(10),
);

INSERT INTO ADMIN VALUES('sathya5278','sathya5278');

CREATE TABLE user
( 
	id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        first_name VARCHAR(30) NOT NULL,
        last_name VARCHAR(30) NOT NULL
);

INSERT INTO user (first_name, last_name) VALUES ('ghi', 'jkl');
INSERT INTO user (first_name, last_name) VALUES ('mno', 'pqr');
INSERT INTO user (first_name, last_name) VALUES ('stu', 'vwx');
INSERT INTO user (first_name, last_name) VALUES ('abc', 'def');
