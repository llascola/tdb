CREATE database llascola_Biblioteca;

USE llascola_Biblioteca;

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
  ISBN        INT            NOT NULL,
  titulo      VARCHAR(64)    NOT NULL,
  precio      FLOAT          NOT NULL,
  editorial   VARCHAR(10)    NOT NULL,
  PRIMARY KEY (ISBN)
);

/*Creacion de tabla de la relacion Escribe entre Autor y Libro*/
CREATE TABLE Escribe (
  id_autor INT NOT NULL,
  id_ISBN  INT NOT NULL,
  ano      INT NOT NULL,
  PRIMARY KEY (id_autor, id_ISBN),
  FOREIGN KEY (id_autor)  REFERENCES Autor(id) 
  ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (id_ISBN) REFERENCES Libros(ISBN) 
  ON DELETE CASCADE ON UPDATE CASCADE
);

/*Ejercicio 2*/
CREATE INDEX IND_titulo   ON Libros  (titulo   ASC)   
CREATE INDEX IND_apellido ON Autores (apellido ASC)   

/*Ejercicio 3*/
INSERT INTO Autor (id, nombre, apellido, nacionalidad, residencia)
  VALUES (DEFAULT, 'Jusepe', 'Di Campo','Bulgaro','Londres'),
         (DEFAULT, 'Ernesto', 'Eldivo', 'Indú', 'Singapur'),
         (DEFAULT, 'Felipo', 'Polife', 'Malvinense', 'Islas Canarias');

INSERT INTO Libros (ISBN, titulo, precio, editorial),
  VALUES ('987-8-9878-9988-7', 'La cascada del eclipse', 23.69,'El Palomar'),
         ('247-5-9441-5988-6', 'Los 30 son los nuevos 20', 45.99, 'Taliban'),
         ('234-8-4191-3199-5', 'El camisón de tu corazón', 145.99, 'Arjona');

INSERT INTO Escrib (id_autor, id_ISBN, ano)
  VALUES (0, '234-8-4191-3199-5', 1679),
         (1, '247-5-9441-5988-6', 428),
         (2, '987-8-9878-9988-7', 1029475629);

