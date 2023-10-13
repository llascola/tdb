/*
Martı́n Binner B-6364/9
Virginia Bonservizi B-6247/2
Luciano Scola S-5562/1
*/

CREATE DATABASE IF NOT EXISTS Biblioteca;

USE Biblioteca;

/*Ejercicio 1*/
DROP TABLE IF EXISTS Escribe;     
DROP TABLE IF EXISTS Autor;     /* Sirve para crear la table de vuelta automat*/
DROP TABLE IF EXISTS Libro;     /* ticamente */

/*Creacion de tabla de Autor*/
CREATE TABLE Autor (
  id            INT          NOT NULL AUTO_INCREMENT,
  nombre        VARCHAR(30)  NOT NULL, /* Maximo 30 carc*/
  apellido      VARCHAR(30)  NOT NULL,
  nacionalidad  VARCHAR(30)  NOT NULL,
  residencia    VARCHAR(30)  NOT NULL,
  PRIMARY KEY   (id)
);


/*Creacion de tabla de Libros*/
CREATE TABLE Libro (
  ISBN        VARCHAR(17)    NOT NULL,
  titulo      VARCHAR(64)    NOT NULL,
  precio      FLOAT          NOT NULL,
  editorial   VARCHAR(30)    NOT NULL,
  PRIMARY KEY (ISBN)
);

/*Creacion de tabla de la relacion Escribe entre Autor y Libro*/
CREATE TABLE Escribe (
  id_autor  INT         NOT NULL,
  id_libro  VARCHAR(17) NOT NULL,
  ano       INT         NOT NULL,
  PRIMARY KEY (id_autor, id_libro),
  FOREIGN KEY (id_autor) REFERENCES Autor(id) 
  ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (id_libro) REFERENCES Libro(ISBN) 
  ON DELETE CASCADE ON UPDATE CASCADE
);

/*Ejercicio 2*/
CREATE INDEX IND_titulo   ON Libro  (titulo   ASC);
CREATE INDEX IND_apellido ON Autor  (apellido ASC);  

/*Ejercicio 3*/
INSERT INTO Autor (id, nombre, apellido, nacionalidad, residencia)
  VALUES (DEFAULT, 'Jusepe', 'Di Campo','Bulgaro','Londres'),
         (DEFAULT, 'Ernesto', 'Eldivo', 'Indú', 'Singapur'),
         (DEFAULT, 'Felipo', 'Polife', 'Malvinense', 'Islas Canarias'),
         (DEFAULT, 'Abelardo', 'Castillo', 'Argentina', 'San Pedro');

INSERT INTO Libro (ISBN, titulo, precio, editorial)
  VALUES ('987-8-9878-9988-7', 'La cascada del eclipse', 23.69,'El Palomar'),
         ('247-5-9441-5988-6', 'Los 30 son los nuevos 20', 45.99, 'Taliban'),
         ('234-8-4191-3199-5', 'El camisón de tu corazón', 145.99, 'Arjona'),
         ('978-950-731-973-0', 'La casa de ceniza', 250.00, 'Seix Barral');

INSERT INTO Escribe (id_autor, id_libro, ano)
  VALUES ((SELECT id FROM Autor WHERE nombre='Jusepe' AND apellido='Di Campo'), '234-8-4191-3199-5', 1679),
         ((SELECT id FROM Autor WHERE nombre='Ernesto' AND apellido='Eldivo'), '247-5-9441-5988-6', 428),
         ((SELECT id FROM Autor WHERE nombre='Felipo' AND apellido='Polife'), '987-8-9878-9988-7', 1998),
         ((SELECT id FROM Autor WHERE nombre='Abelardo' AND apellido='Castillo'), '978-950-731-973-0', 2019);

/*Ejercicio 4*/
/*a)*/
UPDATE Autor
SET residencia='Buenos Aires'
WHERE nombre='Abelardo' AND apellido='Castillo';

/*b)*/
UPDATE Libro
SET precio = precio * 1.1
WHERE editorial='UNR';

/*c)*/
UPDATE Libro
SET precio = precio * 1.2
WHERE precio <= 200 
  and ISBN IN (
    SELECT id_libro
    FROM Escribe
    WHERE id_autor IN (
      SELECT id
      FROM Autor
      WHERE nacionalidad != 'Argentina'
      )
    );

UPDATE Libro
SET precio = precio * 1.1
WHERE precio > 200 
  and ISBN in (
    SELECT id_libro
    FROM Escribe
    WHERE id_autor in (
      SELECT id
      FROM Autor
      WHERE nacionalidad != 'Argentina'
      )
    );

/*d)*/
DELETE FROM Libro
WHERE ISBN IN (
  SELECT id_libro
  FROM Escribe
  WHERE ano = 1998
);