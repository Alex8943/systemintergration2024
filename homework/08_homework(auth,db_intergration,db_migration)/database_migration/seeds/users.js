/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> } 
 */
exports.seed = async function(knex) {
  // Deletes ALL existing entries
  await knex('users').del()
  await knex('users').insert([
    {id: 1, name: 'Admin', lastname: "adminUser"},
    {id: 2, name: 'Alice', lastname: "Alicon"},
    {id: 3, name: 'Bob', lastname: "Bobson"},
  ]);
  
};
