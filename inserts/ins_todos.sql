INSERT INTO users (name, email, password) VALUES 
    (
        "Ale",
        "alejandro@gmail.com",
        "1234"
    ),
    (
        "Alberto",
        "alberto@gmail.com",
        "123456"
    );

INSERT INTO tasks (user_id, title, description, completed, due_date) VALUES 
    (
        1,
        "Aprender BB.DD",
        "Aprendemos diseño y manipulación de BB.DD en Mastermind",
        false,
        "2024-03-21"
    ),
    (
        1,
        "Aprender Fronted",
        "Aprendemos HTML5 en Mastermind",
        false,
        "2024-03-14"
    ),
    (
        2,
        "Aprender Backend",
        "Aprendemos Laravel en Mastermind",
        false,
        "2024-03-14"
    );
