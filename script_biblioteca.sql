--creacion de tablas
CREATE TABLE USUARIO (
DNI INTEGER PRIMARY KEY NOT NULL,
nombre VARCHAR(50),
apellido VARCHAR(50),
email VARCHAR(100),
direccion VARCHAR(100)
);
CREATE TABLE LIBRO (
ISBN VARCHAR(20) PRIMARY KEY NOT NULL,
titulo VARCHAR(100),
autor VARCHAR(100),
fecha_edicion DATE,
stock INTEGER
);
CREATE TABLE PRESTAMO (
id_prestamo INTEGER PRIMARY KEY NOT NULL,
fecha_gen DATE,
dni_usuario INTEGER,
FOREIGN KEY (dni_usuario) REFERENCES USUARIO(DNI)
);
CREATE TABLE DETALLE_PRESTAMO (
id_prestamo INTEGER NOT NULL,
ISBN VARCHAR(20) NOT NULL,
devuelto VARCHAR(2),
fecha_dev DATE,
PRIMARY KEY (id_prestamo, ISBN),
FOREIGN KEY (id_prestamo) REFERENCES PRESTAMO(id_prestamo),
FOREIGN KEY (ISBN) REFERENCES LIBRO(ISBN)
);

3- insertar contenido aleatorio en las tablas para practicar consultas
-- CARGA DE DATOS
INSERT INTO USUARIO VALUES (101, 'Juan', 'Pérez', 'juanp@mail.com', 'Calle Falsa 123'), (102, 'María', 'García', 'mariag@mail.com', 'Av. Siempre Viva 742'), (103, 'Carlos', 'Sosa', 'csosa@mail.com', 'Rivadavia 100'), (104, 'Ana', 'López', 'alopez@mail.com', 'San Martín 500'), (105, 'Luis', 'Gómez', 'lgomez@mail.com', 'Belgrano 250'), (106, 'Lucía', 'Díaz', 'lucyad@mail.com', 'Mitre 12'), (107, 'Pedro', 'Ruiz', 'pruiz@mail.com', 'Corrientes 99'), (108, 'Elena', 'Paz', 'epaz@mail.com', '9 de Julio 88'), (109, 'Roberto', 'Sánchez', 'rsanchez@mail.com', 'Maipú 44'), (110, 'Sofía', 'Martínez', 'smartinez@mail.com', 'Colón 33');
INSERT INTO LIBRO VALUES ('97801', 'Cien años de soledad', 'García Márquez', '1967-05-30', 5), ('97802', '1984', 'George Orwell', '1949-06-08', 2), ('97803', 'El Aleph', 'Jorge Luis Borges', '1949-01-01', 3), ('97804', 'Rayuela', 'Julio Cortázar', '1963-06-28', 1), ('97805', 'Don Quijote', 'Miguel de Cervantes', '1605-01-16', 0), ('97806', 'El Túnel', 'Ernesto Sabato', '1948-01-01', 4), ('97807', 'El código Da Vinci', 'Dan Brown', '2003-03-18', 10), ('97808', 'Fahrenheit 451', 'Ray Bradbury', '1953-10-19', 2), ('97809', 'La ciudad y los perros', 'Vargas Llosa', '1963-01-01', 3), ('97810', 'Sobre héroes y tumbas', 'Ernesto Sabato', '1961-01-01', 1);
INSERT INTO PRESTAMO VALUES (1, '2024-03-01', 101), (2, '2024-03-05', 102), (3, '2024-03-10', 103), (4, '2024-03-12', 101), (5, '2024-03-15', 104), (6, '2024-03-20', 105), (7, '2024-03-22', 106), (8, '2024-03-25', 107), (9, '2024-03-28', 102), (10, '2024-03-30', 108);
INSERT INTO DETALLE_PRESTAMO VALUES (1, '97801', 'SI', '2024-03-10'), (1, '97802', 'SI', '2024-03-10'), (2, '97803', 'NO', NULL), (3, '97804', 'SI', '2024-03-20'), (3, '97805', 'SI', '2024-03-22'), (4, '97806', 'NO', NULL), (5, '97807', 'SI', '2024-03-25'), (6, '97808', 'NO', NULL), (7, '97809', 'SI', '2024-04-01'), (8, '97810', 'NO', NULL);




4- corroboración de contenido en tablas
-- corroborar contenido de las 4 tablas
SELECT * FROM USUARIO;
SELECT * FROM LIBRO;
SELECT * FROM PRESTAMO;
SELECT * FROM DETALLE_PRESTAMO;

5- generación de consultas.
  

--CONSULTA 1; libros escritos por Ernesto Sabato
SELECT autor, titulo, fecha_edicion
FROM LIBRO
WHERE autor = "Ernesto Sabato"

--CONSULTA 2; Nombre, aprellido, email, ISBN, titulo (del libro) de quienes NO HAN DEVUELTO LOS LIBROS
SELECT USUARIO.nombre, USUARIO.apellido, USUARIO.email, LIBRO.ISBN, LIBRO.titulo
FROM DETALLE_PRESTAMO
JOIN PRESTAMO ON DETALLE_PRESTAMO.id_prestamo = PRESTAMO.id_prestamo
JOIN USUARIO ON PRESTAMO.dni_usuario = USUARIO.DNI
JOIN LIBRO ON DETALLE_PRESTAMO.ISBN = LIBRO.ISBN
WHERE DETALLE_PRESTAMO.devuelto = 'NO';


--CONSULTA 3; Libros con poco stock, menor o igual a 3
SELECT titulo, stock
FROM LIBRO
WHERE stock<=3;
Cuarta consulta: Autores mas llevados
--CONSULTA 4; Autores favortios, cuantas veces aparecen los autores en la tabla detalle_prestamo
SELECT LIBRO.autor, COUNT(*) AS cantidad_elegido
FROM LIBRO
JOIN DETALLE_PRESTAMO ON LIBRO.ISBN = DETALLE_PRESTAMO.ISBN
GROUP BY LIBRO.autor
ORDER BY cantidad_elegido DESC

--CONSULTA 5; Actividad por fecha: libos llevados y por quienes la primer quincena de marzo 2024.
SELECT USUARIO.nombre, USUARIO.apellido, LIBRO.titulo, PRESTAMO.fecha_gen
FROM USUARIO
JOIN PRESTAMO ON USUARIO.DNI = PRESTAMO.dni_usuario
JOIN DETALLE_PRESTAMO ON PRESTAMO.id_prestamo = DETALLE_PRESTAMO.id_prestamo
JOIN LIBRO ON DETALLE_PRESTAMO.ISBN = LIBRO.ISBN
WHERE PRESTAMO.fecha_gen > '2024-03-01' and PRESTAMO.fecha_gen <= '2024-03-15'
