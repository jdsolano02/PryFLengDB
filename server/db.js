const oracledb = require('oracledb');

const dbConfig = {
  user: 'UsuarioSUPER_Admin',
  password: 'useradminpassword',
  connectString: 'localhost/orcl' // Ajusta según tu configuración
};

async function getConnection() {
  try {
    return await oracledb.getConnection(dbConfig);
  } catch (err) {
    console.error('Error al conectar a la base de datos:', err);
  }
}

module.exports = { getConnection };
