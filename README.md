# 💳 Base de Datos - Banco_Johan

## 📌 Descripción

Este proyecto consiste en el diseño e implementación de una base de datos en MySQL que simula el funcionamiento de un sistema bancario.

Incluye la gestión de:

- Clientes
- Cuentas
- Transacciones
- Tarjetas
- Préstamos
- Inversiones
- Transferencias

Además, se desarrollaron 25 consultas SQL para analizar la información y obtener resultados útiles.

---

## 🧱 Estructura de la Base de Datos

Las tablas principales son:

- **clientes** → Información personal
- **cuentas** → Cuentas bancarias
- **transacciones** → Movimientos de dinero
- **tarjetas** → Tarjetas de crédito/débito
- **prestamos** → Créditos otorgados
- **inversiones** → Dinero invertido
- **transferencias** → Envío de dinero entre cuentas

---

## ⚙️ Tecnologías utilizadas

- MySQL
- SQL
- GitHub
- Visual Studio Code

---

## 📊 Consultas realizadas

Se desarrollaron 25 consultas SQL:

- Clientes con al menos una cuenta
- Saldo total por cliente
- Transacciones de un cliente específico
- Cuentas con saldo mayor a 10,000
- Clientes con tarjetas
- Número de cuentas por cliente
- Préstamos activos
- Total transferido por cuenta
- Transacciones del último mes
- Clientes con inversiones mayores a 5000
- Cliente + cuenta + saldo
- Total de transacciones por cuenta
- Clientes sin cuentas
- Cliente con más cuentas
- Total de préstamos por cliente
- Total invertido por cliente
- Cuentas sin transacciones
- Promedio de transacciones
- Top 5 clientes con más saldo
- Clientes con cuentas y préstamos
- Cliente más activo
- Transferencias sospechosas
- Clientes endeudados
- Ranking de clientes por inversión
- Crecimiento de inversiones

---

## 🧠 Desarrollo de las consultas

A continuación se explica cómo se desarrollaron las 25 consultas SQL:

- **Consulta 1:** Se utilizó `SELECT DISTINCT` junto con `JOIN` para listar los clientes que tienen al menos una cuenta, evitando duplicados.

- **Consulta 2:** Se aplicó la función `SUM` para calcular el saldo total de cada cliente y `GROUP BY` para agrupar los resultados.

- **Consulta 3:** Se usaron `JOIN` entre clientes, cuentas y transacciones, y `WHERE` para filtrar las transacciones de un cliente específico.

- **Consulta 4:** Se realizó un `JOIN` entre clientes y cuentas, aplicando `WHERE` para mostrar cuentas con saldo mayor a 10,000.

- **Consulta 5:** Se utilizó `JOIN` entre clientes y tarjetas, junto con `DISTINCT` para evitar repetir clientes.

- **Consulta 6:** Se aplicó `COUNT` para contar el número de cuentas por cliente y `GROUP BY` para agrupar.

- **Consulta 7:** Se usó `JOIN` entre clientes y préstamos, filtrando con `WHERE` los préstamos activos.

- **Consulta 8:** Se realizó un `JOIN` entre clientes, cuentas y transferencias, y se aplicó `SUM` para calcular el total transferido.

- **Consulta 9:** Se utilizó `JOIN` entre clientes, cuentas y transacciones, filtrando con `DATE_SUB` para obtener datos del último mes.

- **Consulta 10:** Se usó `JOIN` entre clientes e inversiones, filtrando con `WHERE` inversiones mayores a 5000.

- **Consulta 11:** Se realizó un `JOIN` entre clientes y cuentas para mostrar nombre, número de cuenta y saldo.

- **Consulta 12:** Se aplicó `COUNT` para obtener el total de transacciones por cliente, agrupando con `GROUP BY`.

- **Consulta 13:** Se utilizó una subconsulta con `NOT IN` para encontrar clientes sin cuentas.

- **Consulta 14:** Se aplicó `COUNT` y `GROUP BY`, luego `ORDER BY` y `LIMIT` para encontrar el cliente con más cuentas.

- **Consulta 15:** Se utilizó `SUM` para calcular el total de préstamos por cliente.

- **Consulta 16:** Se aplicó `SUM` para obtener el total invertido por cliente.

- **Consulta 17:** Se utilizó `NOT IN` para identificar cuentas que no tienen transacciones.

- **Consulta 18:** Se aplicó `AVG` para calcular el promedio de los montos de transacciones.

- **Consulta 19:** Se utilizó `SUM` y `ORDER BY` para mostrar los clientes con mayor saldo, limitando a 5.

- **Consulta 20:** Se realizaron múltiples `JOIN` para listar clientes con cuentas y préstamos.

- **Consulta 21:** Se utilizó `COUNT` y `ORDER BY` para identificar el cliente con mayor número de transacciones.

- **Consulta 22:** Se aplicó `GROUP BY` y `HAVING` para detectar cuentas con más de 3 transferencias en un día.

- **Consulta 23:** Se utilizó `SUM` y `HAVING` para identificar clientes cuyo saldo es menor que sus préstamos.

- **Consulta 24:** Se utilizó `RANK()` para generar un ranking de clientes según sus inversiones.

- **Consulta 25:** Se calculó el crecimiento de inversiones restando el monto inicial del valor actual.

---

## 🚀 Cómo ejecutar el proyecto

1. Abrir MySQL Workbench
2. Ejecutar el archivo `Primera tarea.sql`
3. Crear la base de datos
4. Insertar los datos
5. Ejecutar las consultas

---

## 🎯 Objetivo

Aplicar conocimientos de bases de datos relacionales para analizar información bancaria mediante consultas SQL.

---

## 👩‍💻 Autor

**Johan Mendoza**

---

## 📌 Notas

Proyecto académico con fines educativos.
