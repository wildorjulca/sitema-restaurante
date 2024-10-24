import mysql from 'mysql2';

export const connection = mysql.createConnection({
  host: 'localhost',       
  user: 'root',             
  password: 'password123',   
  database: 'nombre_base_datos'
});