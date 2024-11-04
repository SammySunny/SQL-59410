USE cosmetologia_integral;

-- Datos insertados a tablas -------------------------------------------------------------------------------


INSERT INTO cliente (id_cliente, nombre, apellido)
VALUES
(1,'Sara', 'Collum'),
(2,'Penelope', 'Durdan'),
(3, 'Jeri', 'Haskew'),
(4, 'Ravi', 'Domel'),
(5, 'Ofella', 'Harmon');


INSERT INTO contacto_cliente (numero, email, cliente)
VALUES
('1009931032', 'sgarthshore0@xrea.com',1),
('8362499230', 'pthickin1@feedburner.com',2),
('6312821315', 'jburet2@paginegialle.it',3),
('4413313968', 'rpoole3@storify.com',4),
('9095897354', 'oornils4@delicious.com',5),
('5211518837', 'apratt0@hibu.com', 3),
('4151655557', 'chryniewicz1@pinterest.com', 2),
('2189158834', 'aveeler2@boston.com', 2);

INSERT INTO empleado (id_empleado, dni, nombre, apellido)
VALUES
('386','38658152', 'Jane', 'Schwartz'),
('367','36789654', 'Daiane', 'Muller'),
('359','35989631', 'Sarah', 'Goldenbear');

INSERT INTO contacto_empleado (numero, email, empleado)
VALUES 
('1168964578', 'jschwartz@cosmeticaintegral.com.ar', '386'),
('1165612353', 'dmuller@cosmeticaintegral.com.ar', '367'),
('1112563214', 'sgoldenbear@cosmeticaintegral.com.ar', '359');

INSERT INTO tratamiento (id_tratamiento, nombre_tratamiento, descripcion_tratamiento, precio_tratamiento, tiempo_estimado_duracion_por_sesion, empleado)
VALUES
('10','Láminado de cejas','Tratamiento especialmente indicado para cejas onduladas y/o rebeldes. Consiste en la aplicación de producto específico en toda la extensión de las cejas para alisarlas y peinarlas de forma permanente.','10000','1:30','386'),
('12','Láminado de pestañas','Tratamiento donde se consigue lucir unas pestañas más elevadas, oscuras y gruesas sin necesidad de aplicarse un rizador o rímel.','15000','1:30','367'),
('14','Tratamiento de acné x 4 sesiones','Tratamiento localizado en reducir la producción de acné, mediante uso de herramientas como Espátula Ultrasónica y Ácidos.','45000','2:00','359'),
('16','Tratamiento facial de Radiofrecuencia','Técnica no invasiva e indolora que estimula la producción de colágeno gracias a las ondas electromagnéticas que penetran en la piel.','23000','1:00','386'),
('18','Limpieza facial profunda','Tratamiento que elimina impurezas, puntos negros y células muertas de la piel del rostro. Suele incluir exfoliación, extracción, mascarilla y masaje facial.','13500','2:30','367'),
('20','Tratamiento con ácido hialurónico','Aplicación de productos que contienen ácido hialurónico para hidratar profundamente la piel y reducir líneas de expresión y arrugas.','11500','1:45','359');

INSERT INTO producto (id_producto, nombre_producto, funcion_producto)
VALUES
(100000000001, 'Sérum de ácido hialurónico', 'Hidrata profundamente la piel y reduce líneas de expresión.'),
(100000000002, 'Gel limpiador facial suave', 'Limpia la piel eliminando impurezas sin resecarla, ideal para preparación de tratamientos.'),
(100000000003, 'Tónico calmante', 'Equilibra el pH de la piel tras la limpieza y calma irritaciones.'),
(100000000004, 'Mascarilla purificante de arcilla', 'Absorbe el exceso de grasa y purifica los poros en profundidad.'),
(100000000005, 'Gel conductor para radiofrecuencia', 'Facilita la transmisión de las ondas de radiofrecuencia durante el tratamiento.'),
(100000000006, 'Crema calmante post tratamiento', 'Alivia la piel tras tratamientos intensivos, reduce rojeces e inflamación.'),
(100000000007, 'Solución antiséptica para acné', 'Desinfecta y controla el brote de acné antes de la extracción.'),
(100000000008, 'Laminador de pestañas', 'Producto especializado para el levantamiento y curvado de las pestañas.'),
(100000000009, 'Laminador de cejas', 'Fija y alisa las cejas, dándoles una forma definida y duradera.'),
(100000000010, 'Sérum hidratante post-laminado', 'Nutre y suaviza las pestañas y cejas tras el tratamiento de laminado.');

INSERT INTO cosmetologia_integral.stock_producto (id_producto, cantidad, fecha_entrada, fecha_vencimiento)
VALUES
(100000000001, 50, '2024-01-10', '2026-01-10'), -- Sérum de ácido hialurónico
(100000000002, 75, '2024-02-15', '2025-02-15'), -- Gel limpiador facial suave
(100000000003, 60, '2024-03-20', '2025-03-20'), -- Tónico calmante
(100000000004, 40, '2024-04-05', '2026-04-05'), -- Mascarilla purificante de arcilla
(100000000005, 30, '2024-05-10', '2025-05-10'), -- Gel conductor para radiofrecuencia
(100000000006, 20, '2024-06-01', '2026-06-01'), -- Crema calmante post tratamiento
(100000000007, 100, '2024-07-15', '2025-07-15'), -- Solución antiséptica para acné
(100000000008, 25, '2024-08-20', '2025-08-20'), -- Laminador de pestañas
(100000000009, 15, '2024-09-10', '2025-09-10'), -- Laminador de cejas
(100000000010, 35, '2024-10-05', '2025-10-05'); -- Sérum hidratante post-laminado

INSERT INTO producto_por_tratamiento (id_producto, id_tratamiento)
VALUES
-- Productos para "Láminado de cejas"
(100000000009, 10),  -- Laminador de cejas
(100000000010, 10),  -- Sérum hidratante post-laminado

-- Productos para "Láminado de pestañas"
(100000000008, 12),  -- Laminador de pestañas
(100000000010, 12),  -- Sérum hidratante post-laminado

-- Productos para "Tratamiento de acné x 4 sesiones"
(100000000007, 14),  -- Solución antiséptica para acné
(100000000004, 14),  -- Mascarilla purificante de arcilla

-- Productos para "Tratamiento facial de Radiofrecuencia"
(100000000005, 16),  -- Gel conductor para radiofrecuencia
(100000000006, 16),  -- Crema calmante post tratamiento

-- Productos para "Limpieza facial profunda"
(100000000002, 18),  -- Gel limpiador facial suave
(100000000003, 18),  -- Tónico calmante
(100000000004, 18),  -- Mascarilla purificante de arcilla

-- Productos para "Tratamiento con ácido hialurónico"
(100000000001, 20),  -- Sérum de ácido hialurónico
(100000000003, 20);  -- Tónico calmante

INSERT INTO cosmetologia_integral.forma_pago_aceptadas (tipo_pago, descripcion)
VALUES
('Efectivo', 'Pago en efectivo al momento del servicio.'),
('Tarjeta de crédito', 'Pago mediante tarjeta de crédito, aceptamos todas las principales marcas.'),
('Tarjeta de débito', 'Pago mediante tarjeta de débito, aceptamos todas las principales marcas.'),
('Transferencia bancaria', 'Transferencia directa a nuestra cuenta bancaria.'),
('Mercado Pago', 'Aceptamos pagos a través de Mercado Pago, una opción rápida y confiable.');

INSERT INTO cita (id_cliente, id_tratamiento, fecha, hora)
VALUES
-- Citas para Sara Collum (id_cliente: 1)
(1, 10, '2024-10-01', '09:00:00'),  -- Láminado de cejas
(1, 20, '2024-11-05', '11:00:00'),  -- Tratamiento con ácido hialurónico

-- Citas para Penelope Durdan (id_cliente: 2)
(2, 12, '2024-12-02', '10:30:00'),  -- Láminado de pestañas
(2, 18, '2024-10-10', '13:00:00'),  -- Limpieza facial profunda

-- Citas para Jeri Haskew (id_cliente: 3)
(3, 14, '2024-11-03', '14:00:00'),  -- Tratamiento de acné x 4 sesiones
(3, 16, '2024-10-12', '16:00:00'),  -- Tratamiento facial de Radiofrecuencia

-- Citas para Ravi Domel (id_cliente: 4)
(4, 18, '2024-10-04', '09:30:00'),  -- Limpieza facial profunda
(4, 16, '2024-10-15', '12:00:00'),  -- Tratamiento facial de Radiofrecuencia

-- Citas para Ofella Harmon (id_cliente: 5)
(5, 10, '2024-10-07', '08:00:00'),  -- Láminado de cejas
(5, 14, '2024-12-17', '14:30:00');  -- Tratamiento de acné x 4 sesiones


INSERT INTO cosmetologia_integral.cita_pago (id_cita, id_forma_pago, monto, metodo_pago, fecha_pago)
VALUES
-- Pagos para Sara Collum (id_cliente: 1)
(1, 1, 80.00, 'Efectivo', '2024-10-01'),  -- Pago en efectivo para Láminado de cejas
(2, 2, 150.00, 'Tarjeta de crédito', '2024-11-05'), -- Pago con tarjeta de crédito para Tratamiento con ácido hialurónico

-- Pagos para Penelope Durdan (id_cliente: 2)
(3, 5, 120.00, 'Mercado Pago', '2024-12-02'), -- Pago por Mercado Pago para Láminado de pestañas
(4, 3, 100.00, 'Tarjeta de débito', '2024-10-10'), -- Pago con tarjeta de débito para Limpieza facial profunda

-- Pagos para Jeri Haskew (id_cliente: 3)
(5, 4, 300.00, 'Transferencia bancaria', '2024-11-03'), -- Pago por transferencia para Tratamiento de acné x 4 sesiones
(6, 1, 150.00, 'Efectivo', '2024-10-12'), -- Pago en efectivo para Tratamiento facial de Radiofrecuencia

-- Pagos para Ravi Domel (id_cliente: 4)
(7, 1, 90.00, 'Efectivo', '2024-10-04'), -- Pago en efectivo para Limpieza facial profunda
(8, 2, 250.00, 'Tarjeta de crédito', '2024-10-15'), -- Pago con tarjeta de crédito para Tratamiento facial de Radiofrecuencia

-- Pagos para Ofella Harmon (id_cliente: 5)
(9, 5, 70.00, 'Mercado Pago', '2024-10-07'),  -- Pago por Mercado Pago para Láminado de cejas
(10, 4, 300.00, 'Transferencia bancaria', '2024-12-17'); -- Pago por transferencia para Tratamiento de acné x 4 sesiones

INSERT INTO cosmetologia_integral.citas_canceladas (id_cita, fecha_cancelacion, motivo)
VALUES
-- Cancelaciones para Sara Collum (id_cliente: 1)
(1, '2024-09-29', 'Cambio de planes'),  -- Láminado de cejas
(2, '2024-10-30', 'No disponible'),     -- Tratamiento con ácido hialurónico

-- Cancelaciones para Penelope Durdan (id_cliente: 2)
(3, '2024-11-28', 'Motivo personal'),   -- Láminado de pestañas
(4, '2024-10-08', 'Enfermedad'),        -- Limpieza facial profunda

-- Cancelaciones para Jeri Haskew (id_cliente: 3)
(5, '2024-10-31', 'Imprevisto'),        -- Tratamiento de acné x 4 sesiones
(6, '2024-10-10', 'Problemas de transporte'),  -- Tratamiento facial de Radiofrecuencia

-- Cancelaciones para Ravi Domel (id_cliente: 4)
(7, '2024-10-03', 'No puede asistir'),  -- Limpieza facial profunda
(8, '2024-10-14', 'Cambio de planes'),  -- Tratamiento facial de Radiofrecuencia

-- Cancelaciones para Ofella Harmon (id_cliente: 5)
(9, '2024-10-05', 'Motivo personal'),   -- Láminado de cejas
(10, '2024-12-15', 'Problemas de salud'); -- Tratamiento de acné x 4 sesiones

INSERT INTO cosmetologia_integral.tratamiento_cliente (id_cita, id_empleado, fecha_tratamiento, duracion)
VALUES
-- Tratamientos para Sara Collum
(1, 386, '2024-10-01', '01:00:00'),  -- Láminado de cejas realizado por Jane
(2, 367, '2024-11-05', '01:30:00'),  -- Tratamiento con ácido hialurónico realizado por Daiane

-- Tratamientos para Penelope Durdan
(3, 386, '2024-12-02', '00:45:00'),  -- Láminado de pestañas realizado por Jane
(4, 367, '2024-10-10', '01:15:00'),  -- Limpieza facial profunda realizada por Daiane

-- Tratamientos para Jeri Haskew
(5, 386, '2024-11-03', '02:00:00'),  -- Tratamiento de acné (4 sesiones) realizado por Jane
(6, 359, '2024-10-12', '01:30:00'),  -- Tratamiento facial de Radiofrecuencia realizado por Sarah

-- Tratamientos para Ravi Domel
(7, 367, '2024-10-04', '01:00:00'),  -- Limpieza facial profunda realizada por Daiane
(8, 359, '2024-10-15', '01:45:00'),  -- Tratamiento facial de Radiofrecuencia realizado por Sarah

-- Tratamientos para Ofella Harmon
(9, 386, '2024-10-07', '01:10:00'),  -- Láminado de cejas realizado por Jane
(10, 367, '2024-12-17', '01:20:00'); -- Tratamiento de acné (4 sesiones) realizado por Daiane

-- ----------------------------------------------------------------------------------------------------------