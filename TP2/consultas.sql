/*
Martı́n Binner B-6364/9
Virginia Bonservizi B-6247/2
Luciano Scola S-5562/1
*/

USE `Inmobiliaria`;

/*Ejercicio 5*/

/*a)*/

SELECT nombre
FROM Persona
WHERE codigo IN (
    SELECT codigo
    FROM Propietario
);

/* Resultado:
+---------+
| nombre  |
+---------+
| Rogelio |
| Juan    |
| Juana   |
| Luis    |
| Maria   |
+---------+
*/

/*b)*/

SELECT codigo
FROM Inmueble
WHERE precio >= 600000 AND precio <= 700000; 

/* Resultado:
+---------+
| codigo  |
+---------+
| Cas0001 |
| Cas0002 |
| Ros0003 |
| Ros0006 |
| Ros0009 |
| Ros0010 |
| Ros0011 |
| Stf0001 |
| Stf0004 |
+---------+
*/

/*c)*/

SELECT nombre
FROM Persona
WHERE codigo IN (
    SELECT codigo_cliente
    FROM PrefiereZona
    WHERE nombre_poblacion = 'Santa Fe' AND nombre_zona = 'Norte'
);

/* Resultado:
+---------+
| nombre  |
+---------+
| Emilio  |
| Facundo |
+---------+
*/

/*d)*/

SELECT nombre
FROM Persona
WHERE codigo IN (
    SELECT vendedor
    FROM Cliente
    WHERE codigo IN (
        SELECT codigo_cliente
        FROM PrefiereZona
        WHERE nombre_poblacion = 'Rosario' AND nombre_zona = 'Centro'
    )
);

/* Resultado:
+--------+
| nombre |
+--------+
| Juana  |
| Laura  |
+--------+
*/

/*e)*/

SELECT nombre_zona 'Zona', count(*) 'Número de inmuebles', avg(precio) 'Promedio del valor'
FROM Inmueble
WHERE nombre_poblacion = 'Rosario'
GROUP BY nombre_poblacion, nombre_zona;

/* Resultado:
+--------+----------------------+--------------------+
| Zona   | Número de inmuebles  | Promedio del valor |
+--------+----------------------+--------------------+
| Centro |                    3 |       1266666.6667 |
| Norte  |                    2 |        825000.0000 |
| Oeste  |                    3 |        650000.0000 |
| Sur    |                    3 |        570000.0000 |
+--------+----------------------+--------------------+
*/

/*f)*/

SELECT nombre
FROM Persona
WHERE NOT EXISTS (
    SELECT *
    FROM Zona
    WHERE nombre_poblacion = 'Santa Fe'
      AND NOT EXISTS (
        SELECT *
        FROM PrefiereZona
        WHERE Zona.nombre_zona = PrefiereZona.nombre_zona
          AND Persona.codigo = PrefiereZona.codigo_cliente
          AND PrefiereZona.nombre_poblacion = 'Santa Fe'
    )
);

/* Resultado:
+--------+
| nombre |
+--------+
| Emilio |
+--------+
*/