'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Tasks', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      user_id: {
        type: Sequelize.INTEGER,
        allowNull:false,
        onDelete:'CASCADE',
        onUpdate:'CASCADE',
        references: {
          model: 'users',
          key:'id'
        }
      },
      title: {
        type: Sequelize.STRING,
        allowNull:false
      },
      description: {
        type: Sequelize.STRING(512),
        allowNull:false
      },
      completed: {
        type: Sequelize.BOOLEAN,
        allowNull:false
      },
      dueDate: {
        type: Sequelize.DATE,
        allowNull:false
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Tasks');
  }
};