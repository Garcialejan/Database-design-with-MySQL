const { Sequelize, Op } = require('sequelize');

const { User, Task } = require ('./models');

const sequelize = new Sequelize('todos_sequelize', 'root', '', {
    host: 'localhost',
    dialect: 'mysql',
  });

const knex = require('knex')({
client: "mysql2",
connection: {
    host: "localhost",
    port: 3306,
    user: "root",
    password: null,
    database: "todos_sequelize"
}
})

const connect = async () =>{
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');

        // ! Inserción de datos en la BB.DD 
        // * Raw query
        // await sequelize.query(`
        //     INSERT INTO users (name, email, password, createdAt, updatedAt)
        //     VALUES ("Antonio", "antonio@gmail.com", "1234", NOW(), NOW())
        // `)

        // * Query builder
        // await knex('users').insert({
        //     name: "Luis",
        //     email: "luis@gmail.com",
        //     password: "123456",
        //     createdAt: new Date(),
        //     updatedAt: new Date()
        // })

        // * ORM
        // User.create({
        //     name: "Manolo",
        //     email: "manolo@gmail.com",
        //     password: "123456",
        // })

        // TODO Queries básicas sobre la BB.DD
        // Raw query
        // const [results, metadata] = await sequelize.query(
        //     "SELECT * FROM users WHERE name = 'Antonio'"
        //     );
        // console.log(results[0].email) // Del primer resultado obtenemos su correo

        //Query builder
        // const results = await knex('users').where('name', 'Manolo').select()
        //     console.log(results) //Obtenemos los datos de Manolo

        //ORM
        // const user = await User.findOne({ where: { name: 'Manolo' } })

        //     console.log(user)
        
        // * Insertamos algunas tareas para hacer Queries más complicadas 

        // sequelize.query(`
        //     INSERT INTO tasks (user_id, title, description, dueDate, completed, createdAt, updatedAt)
        //     VALUES (4, "Tarea 1", "Descripción de la tarea 1", "2024-04-05", false, NOW(), NOW())
        //     `);
        // ORM
        // await Task.create({
        //     user_id: 3,
        //     title: "Tarea 1",
        //     description: "Descripción de la tarea 1",
        //     dueDate: "2024-04-8",
        //     completed: true,
        //     createdAt: new Date(),
        //     updatedAt: new Date()
        // })

         // ! Queries con agrupaciones y JOIN
         // * Raw query
        // const [results, metadata] = 
        // await sequelize.query("SELECT * FROM users JOIN tasks ON tasks.users_id = users.id")
        // console.log(results)

        // * ORM
        // const users = await User.findAll({ include: Task })
        // console.log(JSON.stringify(users, NULL, 4)) // El JSON.stringify es para leerlo bien
        
        // * NUEVA QUERY
        // Raw query
        // const[results, metadata] = await sequelize.query(`
        //     SELECT * FROM users
        //     JOIN tasks ON tasks.users_id = users.id
        //     WHERE task.completed = FALSE
        //     AND YEAR(tasks.dueDate) = 2024
        //     AND MONTH(tasks.dueDate) < 6
        // `)
        // console.log(results)

        // TODO ORM
        const users = await User.findAll({
            include: {
                model: Task,
                where: {
                    [Op.and]: [
                        {completed: false},
                        {dueDate: { [Op.lt]: new Date("2024-06-01") } }
                    ]

                }
            }
        })

        console.log(JSON.stringify(users, null, 4))

      } catch (error) {
        console.error('Unable to connect to the database:', error);
      }
}
connect();