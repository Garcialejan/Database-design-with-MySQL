# Proyecto final: App de pagos

Queremos hacer una apliación similar a PayPal donde los usuarios dispongan de
cuentas con saldo y puedan hacer transferencias a otros usuarios. Los
usuarios se registrarán mediante correo y contraseña, aunque almacenaremos
también su nombre completo.

Cada usuario podrá crear varias cuentas, que pueden ser normales o de empresa.
Para cada cuenta, almacenarmos su saldo actual en €, su nombre y una descripción
proporcionada por el usuario.

Si la cuenta es normal, no almacenarmos más información asociada a ella. Sin
embargo, si la cuenta es de empresa, almacenaremos el nombre de la empresa y
su número de identificación fiscal o *tax ID*.

De cada transferencia que ocurre entre las cuentas de los usuarios nos interesa
almacenar la cantidad transferida, la fecha incluyendo hora y minuto y el estado
de la transferencia, que puede ser "pagado" o "reembolsado".

Del mismo modo, los usuarios podrán transferir dinero desde sus cuentas de
la apliación a sus cuenta bancarias, o recibir dinero desde su banco
para aumentar el saldo en la app. Por lo tanto, el usuario podrá asociar
varias cuentas bancarias a cada cuenta creada en la aplicación. De las cuentas
bancarias queremos almacenar su número de cuenta.

Para cada transferencia que ocurre entre un banco y nuestra app queremos saber
la dirección en la que se ha transferido el dinero (si se ha hecho desde la app
al banco o viceversa). Además, como las transferencia bancarias pueden tardar
varios días queremos saber su estado ("procesando", "completada", "cancelada"),
así como la fecha de emisión de la transferencia y la fecha de finalización
(cuando se ha completado o cancelado).

<details>
<summary>Diseño conceptual</summary>
<br>
<img style="width: 100%;" src="./challenge/svg/RETO_diseño_conceptual.svg">
</details>

<details>
<summary>Diseño lógico</summary>
<br>
<img style="width: 100%;" src="./challenge/svg/RETO_diseño_logico.svg"> 
</details>

<details>
<summary>Diseño físico</summary>

```sql
CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255)
);

CREATE TABLE accounts (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(512) NOT NULL,
    balance DECIMAL(12, 2) NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE corporate_accounts (
    account_id INT UNSIGNED PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    tax_id VARCHAR(255) NOT NULL UNIQUE,

    FOREIGN KEY (account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE transfers (
    from_account_id INT UNSIGNED NOT NULL,
    to_account_id INT UNSIGNED NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    date DATETIME NOT NULL,
    status ENUM("PAYED", "REFUNDED") NOT NULL,

    FOREIGN KEY (from_account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

   FOREIGN KEY (to_account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE bank_accounts (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    number VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE bank_associations (
    bank_account_id INT UNSIGNED NOT NULL,
    account_id INT UNSIGNED NOT NULL,

    PRIMARY KEY (bank_account_id, account_id),

    FOREIGN KEY (account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (bank_account_id) REFERENCES bank_accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE bank_transfers (
    bank_account_id INT UNSIGNED NOT NULL,
    account_id INT UNSIGNED NOT NULL,
    direction ENUM("INCOMING", "OUTGOING") NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    status ENUM("PROCESSING", "COMPLETED", "CANCELED"),
    amount DECIMAL(12, 2),

    FOREIGN KEY (account_id) REFERENCES accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (bank_account_id) REFERENCES bank_accounts(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
```
</details>