const express = require('express');
const path = require('path');
const mongoose = require('mongoose');
const dbConfig = require('./config/db'); // Configuración de la base de datos

// Crear la aplicación Express
const app = express();
const port = process.env.PORT || 3000;

// Conectar a la base de datos
mongoose.connect(dbConfig.url, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => console.log('Conectado a la base de datos'))
    .catch(err => console.error('Error al conectar a la base de datos', err));


// Configuración de middleware
app.use(express.json()); // Para analizar JSON en las solicitudes
app.use(express.urlencoded({ extended: true })); // Para analizar datos de formularios

// Rutas de la API
const authRoutes = require('./rutas/authRutas');
const clientsRoutes = require('./rutas/clientesRutas');
const suppliersRoutes = require('./rutas/empleadosRutas');
const productsRoutes = require('./rutas/pedidosRutas');
const employeesRoutes = require('./rutas/productosRutas');
const branchesRoutes = require('./rutas/proveedoresRutas');
const ordersRoutes = require('./rutas/sucursalesRutas');
const salesRoutes = require('./rutas/ventasRutas');

app.use('/api/auth', authRoutes);
app.use('/api/clients', clientsRoutes);
app.use('/api/suppliers', suppliersRoutes);
app.use('/api/products', productsRoutes);
app.use('/api/employees', employeesRoutes);
app.use('/api/branches', branchesRoutes);
app.use('/api/orders', ordersRoutes);
app.use('/api/sales', salesRoutes);

// Configuración de rutas estáticas para los archivos del front-end
app.use(express.static(path.join(__dirname, 'public')));

// Ruta para servir archivos HTML
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'html', 'index.html'));
});
app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, 'html', 'login.html'));
});
app.get('/clientes', (req, res) => {
    res.sendFile(path.join(__dirname, 'html', 'clientes.html'));
});
app.get('/proveedores', (req, res) => {
    res.sendFile(path.join(__dirname, 'html', 'proveedores.html'));
});
app.get('/productos', (req, res) => {
    res.sendFile(path.join(__dirname, 'html', 'productos.html'));
});
app.get('/empleados', (req, res) => {
    res.sendFile(path.join(__dirname, 'html', 'empleados.html'));
});
app.get('/sucursales', (req, res) => {
    res.sendFile(path.join(__dirname, 'html', 'sucursales.html'));
});
app.get('/pedidos', (req, res) => {
    res.sendFile(path.join(__dirname, 'html', 'pedidos.html'));
});
app.get('/ventas', (req, res) => {
    res.sendFile(path.join(__dirname, 'html', 'ventas.html'));
});

// Manejo de errores 404
app.use((req, res) => {
    res.status(404).send('Página no encontrada');
});

// Iniciar el servidor
app.listen(port, () => {
    console.log(`Servidor escuchando en http://localhost:${port}`);
});
