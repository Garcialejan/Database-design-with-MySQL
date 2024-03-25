INSERT INTO users (name, email, password) VALUES 
    (
        "alejandro",
        "alejandro@gmail.com",
        "123456"
    ),
    (
        "alberto",
        "alberto@gmail.com",
        "1234567"
    ),
    (
        "carlos",
        "carlos@gmail.com",
        "1234568"
    ),
    (
        "ACCJ.SL",
        "accj@gmail.com",
        "456789"
    );

INSERT INTO accounts (user_id, name, description, balance) VALUES
    (
        1,
        "Alejandro_account",
        "Esta es la cuenta personal de Alejandro",
        500
    ),
    (
        2,
        "Alberto_account",
        "Esta es la cuenta personal de Alberto",
        800
    ),
    (
        3,
        "Carlos_account",
        "Esta es la cuenta personal de Carlos",
        300
    ),
    (
        4,
        "ACCJ_account",
        "Esta es la cuenta corporativa de la empresa ACCJ",
        35000
    );

INSERT INTO corporate_accounts (account_id, name, tax_id) VALUES
    (
        4,
        "ACCJ_account",
        "45-4286183"
    );

-- Hacemos una transacción entre las cuentas 1 y 2 de forma manual
START TRANSACTION;
    INSERT INTO transfers (from_account_id, to_account_id, status, amount, date) VALUES
        (
            1,
            2,
            "PAYED",
            "10",
            "2024-01-01"
        );
    UPDATE accounts SET balance = balance - 10 where id = 1;
    UPDATE accounts SET balance = balance + 10 where id = 2; 
COMMIT;

-- Hacemos una transacción entre las cuentas 2 y 3, tomando como referencia el valor de amount indicado en la tabla 
-- Para hacer esto usamos una subquery
START TRANSACTION;
    INSERT INTO transfers (from_account_id, to_account_id, status, amount, date) VALUES
        (
            2,
            3,
            "PAYED",
            40,
            "2024-01-01"
        );
    UPDATE accounts SET balance = balance - (SELECT amount FROM transfers WHERE from_account_id = 2);
    UPDATE accounts SET balance = balance + (SELECT amount FROM transfers WHERE to_account_id = 3); 
COMMIT;