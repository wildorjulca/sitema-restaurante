CREATE TABLE clientes (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(20),
    direccion VARCHAR(255),
    fechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE cargos (
    idCargo INT PRIMARY KEY AUTO_INCREMENT,
    nombreCargo VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE empleados (
    idEmpleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    idCargo INT,
    salario DECIMAL(10, 2) NOT NULL,  -- Salario específico de cada empleado
    fechaContratacion DATE NOT NULL,
    telefono VARCHAR(20),
    tipoTelefono ENUM('Móvil', 'Oficina', 'Casa'),
    email VARCHAR(100) UNIQUE,
    fechaNacimiento DATE,
    estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
    contactoEmergencia VARCHAR(100),
    telefonoEmergencia VARCHAR(20),
    FOREIGN KEY (idCargo) REFERENCES cargos(idCargo)
);

CREATE TABLE mesas (
    idMesa INT PRIMARY KEY AUTO_INCREMENT,
    numeroMesa INT UNIQUE,  -- Número de la mesa
    capacidad INT,          -- Número de personas que puede sentar
    estado ENUM('Disponible', 'Ocupada', 'Reservada') DEFAULT 'Disponible'
);
CREATE TABLE categorias_menu (
    idCategoria INT PRIMARY KEY AUTO_INCREMENT,
    nombreCategoria VARCHAR(100) NOT NULL
);


CREATE TABLE menu (
    idProducto INT PRIMARY KEY AUTO_INCREMENT,
    nombreProducto VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    idCategoria INT,
    FOREIGN KEY (idCategoria) REFERENCES categorias_menu(idCategoria)
);

CREATE TABLE pedidos (
    idPedido INT PRIMARY KEY AUTO_INCREMENT,
    idMesa INT,
    idCliente INT,  -- puede ser NULL si el cliente es anónimo
    fechaPedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2),
    estado ENUM('Pendiente', 'En preparación', 'Servido', 'Pagado') DEFAULT 'Pendiente',
    FOREIGN KEY (idMesa) REFERENCES mesas(idMesa),
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

CREATE TABLE detalles_pedido (
    idDetalle INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT,
    idProducto INT,
    cantidad INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,  -- El precio en el momento de la compra
    FOREIGN KEY (idPedido) REFERENCES pedidos(idPedido),
    FOREIGN KEY (idProducto) REFERENCES menu(idProducto)
);


CREATE TABLE facturas (
    idFactura INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT,
    idCliente INT,
    fechaFactura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totalFactura DECIMAL(10, 2),
    metodoPago ENUM('Efectivo', 'Tarjeta', 'Transferencia'),
    FOREIGN KEY (idPedido) REFERENCES pedidos(idPedido),
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

CREATE TABLE reservas (
    idReserva INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT,
    idMesa INT,
    fechaReserva DATE,
    horaReserva TIME,
    estado ENUM('Pendiente', 'Confirmada', 'Cancelada') DEFAULT 'Pendiente',
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente),
    FOREIGN KEY (idMesa) REFERENCES mesas(idMesa)
);

CREATE TABLE turnos_empleados (
    idTurno INT PRIMARY KEY AUTO_INCREMENT,
    idEmpleado INT,
    fechaTurno DATE,
    horaEntrada TIME,
    horaSalida TIME,
    FOREIGN KEY (idEmpleado) REFERENCES empleados(idEmpleado)
);
Explicación del Modelo
1.	clientes: Contiene los datos personales de los clientes que pueden realizar pedidos o reservas en el restaurante.
2.	empleados: Guarda la información de los empleados, incluidos sus cargos (meseros, cocineros, etc.).
3.	mesas: Representa las mesas del restaurante. Cada mesa tiene un número y una capacidad máxima de personas.
4.	categorias_menu y menu: Estas tablas manejan la estructura del menú del restaurante. Los productos del menú están organizados en categorías (bebidas, comidas, postres, etc.).
5.	pedidos: Registra los pedidos que los clientes hacen en el restaurante, vinculando cada pedido a una mesa y opcionalmente a un cliente.
6.	detalles_pedido: Esta tabla se usa para desglosar qué productos fueron pedidos en cada orden, junto con las cantidades y precios.
7.	facturas: Almacena la información de facturación generada al momento de pagar un pedido.
8.	reservas: Registra las reservas que hacen los clientes para una fecha y hora específica.
9.	turnos_empleados: Registra los turnos de trabajo de los empleados del restaurante.
Consideraciones adicionales
•	Consultas frecuentes:
o	Consultar disponibilidad de mesas: Puedes verificar el estado de las mesas en la tabla mesas o también en la tabla reservas para fechas futuras.
o	Generar facturas: Al completar un pedido, puedes generar una factura basada en el pedido y sus detalles.
o	Reporte de ventas: Sumando los totales de la tabla facturas, puedes generar reportes de ingresos por día o mes.
Con este diseño, tienes una base sólida para desarrollar un sistema de restaurante. ¡Puedes ajustarlo según las necesidades específicas del proyecto!

