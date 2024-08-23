--SUPER MERCADO--
CREATE TABLE FIDE_SUPER_DEPARTAMENTO_TB(
    COD_DEPARTAMENTO NUMBER (10) PRIMARY KEY, 
    NOMBRE_DEPARTAMENTO VARCHAR2 (20),
    DESCRIPCION VARCHAR2 (30),
    TELEFONO_DEPARTAMENTO NUMBER (15)
);

CREATE TABLE FIDE_SUPER_GENERO_TB(
    COD_GENERO NUMBER (10) PRIMARY KEY,
    DESCRIPCION VARCHAR2 (10)
);

CREATE TABLE FIDE_SUPER_PUESTOS_TB(
    COD_PUESTO NUMBER (10) PRIMARY KEY,
    DESCRIPCION VARCHAR2 (25),
    COD_DEPARTAMENTO NUMBER (10),
    
    CONSTRAINT FK_DEPARTAMENTO FOREIGN KEY (COD_DEPARTAMENTO) 
    REFERENCES FIDE_SUPER_DEPARTAMENTO_TB(COD_DEPARTAMENTO)
);

CREATE TABLE FIDE_SUPER_EMPLEADO_TB (
    COD_EMPLEADO NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    APELLIDO_1 VARCHAR2(25),
    APELLIDO_2 VARCHAR2 (25),
    CORREO VARCHAR2 (40),
    TELEFONO NUMBER (15),
    COD_GENERO NUMBER (10),
    SALARIO NUMBER (20),
    COD_PUESTO NUMBER (10),
    
    CONSTRAINT FK_GENERO FOREIGN KEY (COD_GENERO) 
    REFERENCES FIDE_SUPER_GENERO_TB(COD_GENERO),
    
    CONSTRAINT FK_PUESTO FOREIGN KEY (COD_PUESTO) 
    REFERENCES FIDE_SUPER_PUESTOS_TB(COD_PUESTO)
);

CREATE TABLE FIDE_SUPER_SUCURSAL_TB (
    COD_SUCURSAL NUMBER (15) PRIMARY KEY, 
    NOMBRE_SUCURSAL VARCHAR2 (30) NOT NULL,
    DIRECCION_SUCURSAL VARCHAR2 (30),
    TELEFONO NUMBER (15),
    COD_GERENTE NUMBER (15), -- ID EMPLEADO
    HORARIO VARCHAR2 (25),
    FECHA_APERTURA DATE, -- '2024-07-25' FORMATO Y,M,D
    ESTADO VARCHAR2 (25),
    
    CONSTRAINT FK_GERENTE FOREIGN KEY (COD_GERENTE) 
    REFERENCES FIDE_SUPER_EMPLEADO_TB(COD_EMPLEADO)
);

CREATE TABLE FIDE_SUPER_INCIDENTES_CLIENTES_TB(
    COD_INCIDENTE NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    INCIDENTE VARCHAR2 (50)
);

CREATE TABLE FIDE_SUPER_TELEFONOS_CLIENTES_TB(
    COD_TELEFONO NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    TELEFONO_CLIENTE NUMBER (15)
);

CREATE TABLE FIDE_SUPER_CLIENTE_TB (
    COD_CLIENTE NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    APELLIDO_1 VARCHAR2 (25) NOT NULL,
    APELLIDO_2 VARCHAR2 (25),
    CORREO_CLIENTE VARCHAR2 (35),
    MONTO_ULTIMA_COMPRA NUMBER (35),
    FECHA_ULTIMA_COMPRA DATE,
    COD_INCIDENTE NUMBER (10),
    COD_TELEFONO NUMBER (10),
    
    CONSTRAINT FK_INCIDENTE FOREIGN KEY (COD_INCIDENTE) 
    REFERENCES FIDE_SUPER_INCIDENTES_CLIENTES_TB(COD_INCIDENTE),
    
    CONSTRAINT FK_TELEFONO_CLI FOREIGN KEY (COD_TELEFONO) 
    REFERENCES FIDE_SUPER_TELEFONOS_CLIENTES_TB(COD_TELEFONO)
);

CREATE TABLE FIDE_SUPER_PRODUCTOS_TB(
    COD_PRODUCTO NUMBER (25) PRIMARY KEY,
    NOMBRE_PRODUCTO VARCHAR2 (25),
    TIPO_PRODUCTO VARCHAR2 (25),
    CANTIDAD NUMBER (25),
    PRECIO NUMBER (25)
);

CREATE TABLE FIDE_SUPER_PROVEEDORES_TB(
    COD_PROVEEDOR NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    NOMBRE_PROVEEDOR VARCHAR2 (35),
    CORREO_PROVEEDOR VARCHAR2 (35),
    TELEFONO_PROVEEDOR NUMBER (15)
);

CREATE TABLE FIDE_SUPER_HISTORIAL_PROVEEDORES_TB(
    COD_HISTORIAL NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    COD_PROVEEDOR NUMBER (25),
    COD_PRODUCTO NUMBER (25),
    FECHA DATE,
    DESCRIPCION VARCHAR2 (55),
    CANTIDAD NUMBER (25),
    PAGO NUMBER (25),
    
    CONSTRAINT FK_PROVEEDOR FOREIGN KEY (COD_PROVEEDOR) 
    REFERENCES FIDE_SUPER_PROVEEDORES_TB(COD_PROVEEDOR),
    
    CONSTRAINT FK_PRODUCTO FOREIGN KEY (COD_PRODUCTO) 
    REFERENCES FIDE_SUPER_PRODUCTOS_TB(COD_PRODUCTO)
);

--TABLA MONEDA
CREATE TABLE FIDE_SUPER_MONEDA_TB(
    COD_MONEDA NUMBER PRIMARY KEY,
    NOMBRE_MONEDA VARCHAR2 (25),
    VALOR_MONEDA NUMBER
);


--TABLA PEDIDO
CREATE TABLE FIDE_SUPER_PEDIDO_TB(
    COD_PEDIDO NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    COD_PRODUCTO NUMBER,
    TIPO_MONEDA NUMBER,
    CANTIDAD_PRODUCTO NUMBER,
    ESTADO_PEDIDO NUMBER,
    
    CONSTRAINT FK_PRODUCTO_PEDIDO FOREIGN KEY (COD_PRODUCTO) 
    REFERENCES FIDE_SUPER_PRODUCTOS_TB(COD_PRODUCTO),
    
    CONSTRAINT FK_MONEDA_PEDIDO FOREIGN KEY (TIPO_MONEDA) 
    REFERENCES FIDE_SUPER_MONEDA_TB(COD_MONEDA)  
);

--PEDIDO CLIENTE
CREATE TABLE FIDE_SUPER_PEDIDO_CLIENTE_TB(
    COD_PEDIDO NUMBER(25) PRIMARY KEY, --PFK
    COD_CLIENTE NUMBER,--FK
    COD_EMPLEADO NUMBER,--FK

    TOTAL_PEDIDO NUMBER(30),
    NOTAS_PEDIDO VARCHAR2(50),
    DESCUENTO NUMBER,
    
    CONSTRAINT FK_PEDIDO_PEDIDO_CLIENTE FOREIGN KEY (COD_PEDIDO) 
    REFERENCES FIDE_SUPER_PEDIDO_TB(COD_PEDIDO),
    
    CONSTRAINT FK_CLIENTE_PEDIDO_CLIENTE FOREIGN KEY (COD_CLIENTE) 
    REFERENCES FIDE_SUPER_CLIENTE_TB(COD_CLIENTE),
    
    CONSTRAINT FK_EMPLEADO_PEDIDO FOREIGN KEY (COD_EMPLEADO) 
    REFERENCES FIDE_SUPER_EMPLEADO_TB(COD_EMPLEADO)
);

--PROVEDORES PRODUCTO
CREATE TABLE FIDE_SUPER_PROVEDORES_PRODUCTOS_TB(
    COD_PROVEDOR NUMBER (25) PRIMARY KEY,
    COD_PRODUCTO NUMBER (25),
    
    CONSTRAINT FK_PROVEDOR_PEDIDO_CLI FOREIGN KEY (COD_PROVEDOR) 
    REFERENCES FIDE_SUPER_PROVEEDORES_TB (COD_PROVEEDOR),
    
    CONSTRAINT FK_PRODUCTO_PEDIDO_CLI FOREIGN KEY (COD_PRODUCTO) 
    REFERENCES FIDE_SUPER_PRODUCTOS_TB (COD_PRODUCTO)

);
--------------------- FIN DE LA CREACION DE LAS TABLAS