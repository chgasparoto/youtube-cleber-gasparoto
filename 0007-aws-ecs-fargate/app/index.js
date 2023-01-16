const express = require('express');
const axios = require('axios');

const db = require('./db');

const app = express();
const port = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const indexPage = `
    <h3>Hello from a Node.js Application running on AWS ECS Fargate</h3>
    <p>What would you like to see?</p>
    <ul>
        <li>Random dogs? <a href="/dogs">Click here</a></li>
        <li>Random cats? <a href="/cats">Click here</a></li>
        <li>Create tables on AWS RDS <a href="/create-tables">Click here</a></li>
        <li>Check my todo list <a href="/todos">Click here</a></li>
    </ul>
`;

app.get('/', (req, res) => res.send(indexPage));
app.get('/healthcheck', (req, res) => {
  try {
    res.sendStatus(204);
  } catch (error) {
    res.sendStatus(500);
  }
});

app.get('/dogs', async (req, res) => {
  try {
    const response = await axios.get('https://dog.ceo/api/breeds/image/random');

    console.log(JSON.stringify(response.data));

    const { message: dogImage } = response.data;
    res.send(
      `<img src="${dogImage}" alt="random dog" style="max-width: 500px" />`
    );
  } catch (error) {
    console.error(JSON.stringify(error));
    res.status(500);
    res.send(error.message);
  }
});

app.get('/cats', async (req, res) => {
  try {
    const response = await axios.get('https://aws.random.cat/meow');

    console.log(JSON.stringify(response.data));

    const { file: catImage } = response.data;
    res.send(
      `<img src="${catImage}" alt="random cat" style="max-width: 500px" />`
    );
  } catch (error) {
    console.error(JSON.stringify(error));
    res.status(500);
    res.send(error.message);
  }
});

app.get('/create-tables', async (req, res) => {
  const createTableSql = `
  CREATE EXTENSION IF NOT EXISTS "pgcrypto";
  
  CREATE TABLE IF NOT EXISTS todos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    todo VARCHAR (255) NOT NULL,
    done BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
  );`

  try {
    await db.query(createTableSql);
    res.send('Todo table has been created');
  } catch (error) {
    console.error(JSON.stringify(error));
    res.status(500);
    res.send(error.message);
  }
});

app.get('/todos', async(req, res) => {
  try {
    const result = await db.query('SELECT * FROM todos');

    console.log({ result });

    res.send(result.rows);
  } catch (error) {
    console.error(JSON.stringify(error));
    res.status(500);
    res.send(error.message);
  }
});

app.post('/todos', async(req, res) => {
  try {
    const params = req.body;

    console.log({ params });

    const result = await db.query('INSERT INTO todos(todo) VALUES($1) RETURNING *', [params.todo]);
    res.send(result.rows[0]);
  } catch (error) {
    console.error(JSON.stringify(error));
    res.status(500);
    res.send(error.message);
  }
});

app.listen(port, () => {
  console.log(`App running on port ${port}`);
});
