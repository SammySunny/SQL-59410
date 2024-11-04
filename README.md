# Base de Datos: cosmetologia_integral

Este repositorio contiene la estructura de la base de datos para el Centro de Estética "Cosmetología Integral". La base de datos está diseñada para gestionar información sobre empleados, tratamientos, productos, clientes y citas.

## Contenidos del repositorio

- **Readme_PDF**: Un conjunto de diapositivas que explica el proyecto y su estructura general.
- **diagrama_entidad_relacion.png**: Imagen del diagrama de entidad-relación.
- **diagrama_esquematico.png**: Imagen del diagrama esquemático.

## Orden de visualización de archivos .SQL

Para facilitar la implementación y comprensión de la base de datos, se recomienda seguir el siguiente orden:

1. **1_estructura.sql**: Archivo para la creación de las tablas y estructura básica de la base de datos.
2. **2_population.sql**: Archivo que contiene los scripts para insertar datos iniciales en las tablas.
3. **3_objetos**: Carpeta con diferentes objetos utilizados en la base de datos. Cada uno de estos archivos es independiente, aunque se ordenaron según el orden de presentación en clase:
   - **3.1_vistas.sql**: Contiene la creación de las vistas.
   - **3.2_funciones.sql**: Contiene la definición de funciones.
   - **3.3_procedimientos_almacenados.sql**: Contiene la creación de procedimientos almacenados.
   - **3.4_triggers.sql**: Contiene la definición de triggers.
4. **4_testeos_consultas**: Carpeta con scripts para realizar pruebas y consultas sobre los diferentes objetos de la base de datos:
   - **4.1_consultas_vistas.sql**: Consultas para probar las vistas.
   - **4.2_consultas_funciones.sql**: Consultas para probar las funciones.
   - **4.3_consultas_procedimientos_almacenados.sql**: Consultas para probar los procedimientos almacenados.
   - **4.4_testeos_triggers.sql**: Pruebas para validar los triggers.

## Descripción del proyecto

Esta base de datos fue creada para centralizar y gestionar información del Centro de Estética "Cosmetología Integral", permitiendo un control eficiente sobre los empleados, sus tratamientos, citas de clientes y productos utilizados.

### Tecnologías utilizadas
- **MySQL Workbench**
- **MySQL Server**
- **Excalidraw**
- **Canva**
- **Microsoft Excel**

---

Sigue el orden recomendado de ejecución para evitar errores de dependencias entre objetos y pruebas de consultas.
