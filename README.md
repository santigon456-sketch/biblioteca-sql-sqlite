
# 📚 Sistema de Gestión de Biblioteca (SQL)

Este proyecto consiste en el diseño e implementación de una base de datos para una biblioteca, pasando por las etapas de modelo conceptual, lógico y físico.

## 🛠️ Tecnologías utilizadas
* **Motor de Base de Datos:** SQLite
* **Herramienta de gestión:** SQLite Studio
* **Diseño:** Diagrams.net

## 🧠 Lógica del Diseño
El sistema permite gestionar usuarios, libros y préstamos. La principal mejora aplicada fue la creación de una **tabla intermedia (DETALLE_PRESTAMO)** para resolver la relación muchos a muchos ($N:M$) entre libros y préstamos, permitiendo devoluciones parciales y un seguimiento individualizado de cada ejemplar.

## 📊 Consultas Implementadas
El proyecto incluye scripts para reportes de gestión como:
1. **Control de Stock:** Identificación de libros con pocas unidades.
2. **Morosidad:** Listado de usuarios con libros pendientes de devolución.
3. **Ranking de Popularidad:** Autores más solicitados por los lectores.
4. **Reporte de Actividad:** Movimientos por rango de fechas.

## 🚀 Cómo utilizar
Puedes encontrar el código completo en el archivo `script_biblioteca.sql`.
