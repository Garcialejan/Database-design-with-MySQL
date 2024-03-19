DROP DATABASE IF EXISTS departments;

CREATE DATABASE departments;

USE departments;

CREATE TABLE buildings (
    city VARCHAR(255) NOT NULL,
    number INT UNSIGNED NOT NULL,

    PRIMARY KEY (city, number)
);

CREATE TABLE departments (
    number VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    annual_budget DECIMAL (10, 2) NOT NULL,
    city VARCHAR(255) NOT NULL,
    building_number INT UNSIGNED NOT NULL,

    FOREIGN KEY (city, building_number) 
        REFERENCES buildings(city, number)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE employees (
    number INT UNSIGNED NOT NULL,
    department_number VARCHAR(255) NOT NULL,

     PRIMARY KEY (number, department_number),

     FOREIGN KEY (department_number) REFERENCES departments(number)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

    name VARCHAR(255) NOT NULL,
    manager_number INT UNSIGNED NOT NULL,
    manager_department_number VARCHAR(255) NOT NULL,

    FOREIGN KEY (manager_number, manager_department_number) 
        REFERENCES employees(number, department_number)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);