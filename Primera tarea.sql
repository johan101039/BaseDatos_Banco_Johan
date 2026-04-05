-- Crear base de datos
CREATE DATABASE banco_johan;
USE banco_johan;

-- =========================
-- TABLA: clientes
-- =========================
CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombres VARCHAR(255),
    apellidos VARCHAR(255),
    telefono VARCHAR(255),
    direccion VARCHAR(255)
);

-- =========================
-- TABLA: cuentas
-- =========================
CREATE TABLE cuentas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    tipo ENUM('ahorro', 'corriente'),
    numero BIGINT,
    saldo FLOAT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- =========================
-- TABLA: transacciones
-- =========================
CREATE TABLE transacciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cuenta_id INT,
    fecha DATETIME,
    tipo ENUM('deposito', 'retiro', 'transferencia'),
    monto FLOAT,
    FOREIGN KEY (cuenta_id) REFERENCES cuentas(id)
);

-- =========================
-- TABLA: tarjetas
-- =========================
CREATE TABLE tarjetas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM('credito', 'debito'),
    cliente_id INT,
    numero BIGINT,
    limite FLOAT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- =========================
-- TABLA: prestamos
-- =========================
CREATE TABLE prestamos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    monto FLOAT,
    tasa FLOAT,
    plazo DATE,
    estado ENUM('activo', 'pagado', 'pendiente'),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- =========================
-- TABLA: inversiones
-- =========================
CREATE TABLE inversiones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    tipo ENUM('acciones', 'bonos', 'fondos'),
    monto FLOAT,
    fecha DATE,
    valor_actual FLOAT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- =========================
-- TABLA: transferencias
-- =========================
CREATE TABLE transferencias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    origen INT,
    destino INT,
    fecha DATETIME,
    monto FLOAT,
    FOREIGN KEY (origen) REFERENCES cuentas(id),
    FOREIGN KEY (destino) REFERENCES cuentas(id)
);




-- =========================
-- CLIENTES
-- =========================
INSERT INTO clientes (id, nombres, apellidos, telefono, direccion) VALUES
(1, 'johan', 'Perez', '987456123', 'andahuasi'),
(2, 'juninho', 'Lopez', '963258741', 'santa rosa'),
(3, 'juan', 'Gomez', '951478632', 'sayan'),
(4, 'Ana', 'Torres', '963741258', 'san jeronimo'),
(5, 'Luis', 'Ramirez', '999654785', 'la merced');

-- =========================
-- CUENTAS
-- =========================
INSERT INTO cuentas (id, cliente_id, tipo, numero, saldo) VALUES
(1, 1, 'ahorro', 1001, 5000),
(2, 1, 'corriente', 1002, 8000),
(3, 2, 'ahorro', 1003, 12000),
(4, 3, 'corriente', 1004, 3000),
(5, 4, 'ahorro', 1005, 15000);

-- =========================
-- TRANSACCIONES
-- =========================
INSERT INTO transacciones (cuenta_id, fecha, tipo, monto) VALUES
(1, NOW(), 'deposito', 1000),
(1, NOW(), 'retiro', 500),
(2, NOW(), 'transferencia', 2000),
(3, NOW(), 'deposito', 3000),
(3, NOW(), 'retiro', 1000),
(5, NOW(), 'deposito', 5000);

-- =========================
-- TARJETAS
-- =========================
INSERT INTO tarjetas (tipo, cliente_id, numero, limite) VALUES
('credito', 1, 1111, 5000),
('debito', 2, 2222, 0),
('credito', 3, 3333, 7000);

-- =========================
-- PRESTAMOS
-- =========================
INSERT INTO prestamos (cliente_id, monto, tasa, plazo, estado) VALUES
(1, 10000, 5.5, '2026-12-31', 'activo'),
(2, 8000, 4.5, '2025-10-10', 'pagado'),
(3, 15000, 6.0, '2027-01-01', 'activo');

-- =========================
-- INVERSIONES
-- =========================
INSERT INTO inversiones (cliente_id, tipo, monto, fecha, valor_actual) VALUES
(1, 'acciones', 5000, '2024-01-01', 6500),
(2, 'bonos', 3000, '2024-02-01', 3200),
(3, 'fondos', 7000, '2024-03-01', 9000),
(4, 'acciones', 10000, '2024-01-10', 12000);

-- =========================
-- TRANSFERENCIAS
-- =========================
INSERT INTO transferencias (origen, destino, fecha, monto) VALUES
(1, 2, NOW(), 500),
(1, 3, NOW(), 700),
(1, 4, NOW(), 300),
(1, 5, NOW(), 200),
(2, 1, NOW(), 1000);




-- 1. Listar todos los clientes con al menos una cuenta
SELECT DISTINCT c.*
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id;


-- 2. Mostrar el saldo total por cliente
SELECT c.id, c.nombres, SUM(cu.saldo) AS saldo_total
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
GROUP BY c.id, c.nombres;


-- 3. Obtener todas las transacciones de un cliente específico
SELECT c.id, c.nombres, t.*
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
JOIN transacciones t ON cu.id = t.cuenta_id
WHERE c.id = 1;


-- 4. Listar cuentas con saldo mayor a 10,000
SELECT c.id, c.nombres, cu.*
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
WHERE cu.saldo > 10000;


-- 5. Mostrar los clientes que tienen tarjetas
SELECT DISTINCT c.id, c.nombres
FROM clientes c
JOIN tarjetas t ON c.id = t.cliente_id;


-- 6. Obtener el número de cuentas por cliente
SELECT c.id, c.nombres, COUNT(cu.id) AS total_cuentas
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
GROUP BY c.id, c.nombres;


-- 7. Listar los préstamos activos
SELECT c.id, c.nombres, p.*
FROM clientes c
JOIN prestamos p ON c.id = p.cliente_id
WHERE p.estado = 'activo';


-- 8. Mostrar el monto total transferido desde cada cuenta
SELECT c.id, c.nombres, SUM(t.monto) AS total_transferido
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
JOIN transferencias t ON cu.id = t.origen
GROUP BY c.id, c.nombres;


-- 9. Obtener las transacciones del último mes
SELECT c.id, c.nombres, t.*
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
JOIN transacciones t ON cu.id = t.cuenta_id
WHERE t.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);


-- 10. Mostrar clientes con inversiones mayores a 5,000
SELECT DISTINCT c.id, c.nombres
FROM clientes c
JOIN inversiones i ON c.id = i.cliente_id
WHERE i.monto > 5000;


-- 11. Mostrar nombre del cliente + número de cuenta + saldo
SELECT c.id, c.nombres, cu.numero, cu.saldo
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id;


-- 12. Obtener el total de transacciones por cuenta
SELECT c.id, c.nombres, COUNT(t.id) AS total_transacciones
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
JOIN transacciones t ON cu.id = t.cuenta_id
GROUP BY c.id, c.nombres;


-- 13. Listar clientes sin cuentas
SELECT c.id, c.nombres
FROM clientes c
WHERE c.id NOT IN (SELECT cliente_id FROM cuentas);


-- 14. Mostrar el cliente con más cuentas
SELECT c.id, c.nombres, COUNT(cu.id) AS total_cuentas
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
GROUP BY c.id, c.nombres
ORDER BY total_cuentas DESC
LIMIT 1;


-- 15. Obtener el total de préstamos por cliente
SELECT c.id, c.nombres, SUM(p.monto) AS total_prestamos
FROM clientes c
JOIN prestamos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombres;


-- 16. Mostrar el total invertido por cliente
SELECT c.id, c.nombres, SUM(i.monto) AS total_invertido
FROM clientes c
JOIN inversiones i ON c.id = i.cliente_id
GROUP BY c.id, c.nombres;


-- 17. Listar cuentas que nunca han tenido transacciones
SELECT c.id, c.nombres, cu.*
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
WHERE cu.id NOT IN (SELECT cuenta_id FROM transacciones);


-- 18. Obtener el promedio de monto por transacción
SELECT c.id, c.nombres, AVG(t.monto) AS promedio
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
JOIN transacciones t ON cu.id = t.cuenta_id
GROUP BY c.id, c.nombres;


-- 19. Mostrar los 5 clientes con mayor saldo total
SELECT c.id, c.nombres, SUM(cu.saldo) AS saldo_total
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
GROUP BY c.id, c.nombres
ORDER BY saldo_total DESC
LIMIT 5;


-- 20. Listar clientes que tienen cuentas y préstamos
SELECT DISTINCT c.id, c.nombres
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
JOIN prestamos p ON c.id = p.cliente_id;


-- 21. Obtener el cliente con mayor actividad (más transacciones)
SELECT c.id, c.nombres, COUNT(t.id) AS total_transacciones
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
JOIN transacciones t ON cu.id = t.cuenta_id
GROUP BY c.id, c.nombres
ORDER BY total_transacciones DESC
LIMIT 1;


-- 22. Detectar cuentas con más de 3 transferencias en un día
SELECT c.id, c.nombres, COUNT(*) AS total_transferencias
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
JOIN transferencias t ON cu.id = t.origen
GROUP BY c.id, c.nombres, DATE(t.fecha)
HAVING COUNT(*) > 3;


-- 23. Listar clientes cuyo saldo total es menor a sus préstamos
SELECT c.id, c.nombres
FROM clientes c
JOIN cuentas cu ON c.id = cu.cliente_id
JOIN prestamos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombres
HAVING SUM(cu.saldo) < SUM(p.monto);


-- 24. Ranking de clientes por inversiones
SELECT c.id, c.nombres,
RANK() OVER (ORDER BY SUM(i.monto) DESC) AS ranking
FROM clientes c
JOIN inversiones i ON c.id = i.cliente_id
GROUP BY c.id, c.nombres;


-- 25. Crecimiento de inversiones por cliente
SELECT c.id, c.nombres,
SUM(i.valor_actual) - SUM(i.monto) AS crecimiento
FROM clientes c
JOIN inversiones i ON c.id = i.cliente_id
GROUP BY c.id, c.nombres;
