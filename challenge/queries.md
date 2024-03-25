# Consultas básicas
- ¿Qué cuentas tienen un saldo superior a 400€?
        USE app
        SELECT * FROM accounts WHERE balance > 400;

- ¿Qué cuentas tienen un saldo superior a 300€ e inferior a 1000€?
        USE app
        SELECT * FROM accounts WHERE balance BETWEEN 300 AND 1000;

- ¿Qué transferencias se han realizado en el año 2024?
        USE app
        SELECT * FROM transfers WHERE date >= "2024-01-01";
        SELECT * FROM transfers WHERE EXTRACT(YEAR FROM date) = 2024;

- ¿Cuántas transferencias se han realizado en el año 2024?
        USE app
        SELECT COUNT(date) FROM transfers WHERE date >= "2024-01-01";
        SELECT COUNT(date) FROM transfers WHERE EXTRACT(YEAR FROM date) = 2024;


# Agrupaciones

- ¿Cuál es la cuenta que tiene más saldo?
        USE app
        SELECT MAX(balance) AS saldo_máximo FROM accounts;

- ¿Cual es el saldo total de todos los usuarios de la app?
        USE app
        SELECT SUM(balance) AS saldo_total FROM accounts;

 ¿Cuánto dinero han movido las transacciones realizadas en 2024?
        USE app
        SELECT SUM(amount) FROM transfers 
        WHERE EXTRACT(YEAR FROM date) = 2024;

- ¿Cual es el usuario que posee la cuenta con el mayor saldo?¿Y el de la menor?
        SELECT 
                users.email,
                users.name,
                accounts.balance
        FROM users 
        JOIN accounts ON user.id = accounts.users_id
        WHERE accounts.balance = (SELECT MAX(balance) FROM accounts);

        SELECT 
                users.email,
                users.name,
                accounts.balance
        FROM users 
        JOIN accounts ON user.id = accounts.users_id
        WHERE accounts.balance = (SELECT MIN(balance) FROM accounts);
