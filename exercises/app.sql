DROP DATABASE IF EXISTS app;

CREATE DATABASE app;

USE app;

CREATE TABLE users(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE accounts(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    user_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(512) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL,
    type ENUM("PERSONAL", "CORPORATE"),

    FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE personal_accounts(
    account_id INT UNSIGNED PRIMARY KEY,

    FOREIGN KEY (account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE corporate_accounts(
    account_id INT UNSIGNED PRIMARY KEY,
    tax_id VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,

    FOREIGN KEY (account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE transfers(
    origin_account_id INT UNSIGNED NOT NULL,
    to_account_id INT UNSIGNED NOT NULL,
    amount DECIMAL(6, 2) NOT NULL,
    status ENUM("PAYED", "REFUNDED") NOT NULL, 
    date DATETIME NOT NULL,

    FOREIGN KEY (origin_account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (to_account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE bank_accounts(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    number VARCHAR(255) UNIQUE NOT NULL,

    FOREIGN KEY (id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


CREATE TABLE bank_transactions(
    account_id INT UNSIGNED NOT NULL,
    bank_account_id INT UNSIGNED NOT NULL,
    direction BOOLEAN NOT NULL,
    amount DECIMAL(8, 2) NOT NULL,
    status ENUM("IN PROCESS", "COMPLETED", "CANCELED") NOT NULL, 
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,

    FOREIGN KEY (account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (bank_account_id) REFERENCES bank_accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);