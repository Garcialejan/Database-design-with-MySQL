DROP DATABASE IF EXISTS todos;

CREATE DATABASE todos;

USE todos;

CREATE TABLE users(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL, 
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    PRIMARY KEY(id),
    UNIQUE (email)

    INDEX(name)
);

CREATE TABLE tasks(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    user_id INT UNSIGNED NOT NULL,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(512) NOT NULL,
    completed BOOLEAN NOT NULL,
    due_date DATETIME NOT NULL,
-- Colocamos el id  sin signo para incrementar la cantidad de id que puede haber (evitamos los valores negativos)
-- status ENUM("COMPLETED", "NOT COMPLETED", "WORK IN PROGRESS") NOT NULL. ENUM solo permite insertar los valores que aparecen entre paréntesis
   
   FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);