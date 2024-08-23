const express = require('express');
const path = require('path');
const { getConnection } = require('./db');

const app = express();
const port = 3000;

// Configura Express para servir archivos estáticos desde el directorio public
app.use(express.static(path.join(__dirname, '../public')));

app.get('/data', async (req, res) => {
  let connection;
  try {
    connection = await getConnection();
    const result = await connection.execute('SELECT * FROM TU_TABLA'); // Ajusta la consulta según tu esquema
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error al conectar a la base de datos');
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.error(err);
      }
    }
  }
});

// Maneja la ruta raíz para servir index.html
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../public/html/index.html'));
});

app.listen(port, () => {
  console.log(`Servidor escuchando en http://localhost:${port}`);
});
