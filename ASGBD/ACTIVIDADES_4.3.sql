-- ACTIVIDADES 4.3

-- Sobre la base test crea un procedimiento que muestre la suma de los primeros n números enteros, siendo n un parámetro de entrada.
USE ebanca;
DELIMITER $$
DROP PROCEDURE IF EXISTS ejercicio1$$
CREATE PROCEDURE ejercicio1(IN n INT)
BEGIN
DECLARE suma INT DEFAULT 0;
DECLARE contador INT DEFAULT 1;
WHILE contador <= n DO
SET suma = suma + contador;
SET contador = contador + 1;
END WHILE;
SELECT CONCAT('La suma de los primeros ', n, ' números enteros es: ', suma) AS Resultado;
END;$$
DELIMITER ;

CALL ejercicio1(5);

-- Haz un procedimiento que muestre la suma de los términos 1/ n con n entre 1 y m. es decir 1/2+1/3+…1/m siendo m el parámetro de entrada. Ten en cuenta que m no puede ser cero.
USE ebanca;
DELIMITER $$
DROP FUNCTION IF EXISTS ejercicio2$$
CREATE FUNCTION ejercicio2(n INT)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE divisor INT;
SET divisor = 2;
IF n <= 1 THEN
RETURN 0;
END IF;
WHILE divisor * divisor <= n DO
IF n % divisor = 0 THEN
 RETURN 0;
END IF;
SET divisor = divisor + 1;
END WHILE;
RETURN 1;
END;$$
DELIMITER ;

SELECT ejercicio2(10);

-- Crea una función que determine si un número es primo devolviendo 0 ó 1.
USE ebanca;
DELIMITER $$
DROP FUNCTION IF EXISTS ejercicio3$$
CREATE FUNCTION ejercicio3(numero INT)
RETURNS varchar(100)
DETERMINISTIC
BEGIN
DECLARE divisor varchar(100);
SET divisor = 2;
IF numero <= 1 THEN
RETURN 0; -- Los números menores o iguales a 1 no son primos
END IF;
WHILE divisor * divisor <= numero DO
IF numero % divisor = 0 THEN
RETURN 0; -- El número es divisible por divisor, no es primo
END IF;
SET divisor = divisor + 1;
END WHILE;
RETURN 1; -- El número es primo
END;$$
DELIMITER ;

SELECT ejercicio3(7);

-- Usando la función anterior crea otra que calcule la suma de los primeros m números primos empezando en el 1.
USE ebanca;
DELIMITER $$
DROP FUNCTION IF EXISTS ejercicio4$$
CREATE FUNCTION ejercicio4(m INT)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE suma INT DEFAULT 0;
DECLARE numero INT DEFAULT 1;
WHILE m > 0 DO
IF ejercicio3(numero) = 1 THEN
SET suma = suma + numero;
SET m = m - 1;
END IF;
SET numero = numero + 1;
END WHILE;
RETURN suma;
END;$$
DELIMITER ;

SELECT ejercicio4(5);

-- Crea un procedimiento para generar y almacenar en la tabla primos (primos(id, numero)) de la base test los primeros números primos comprendidos entre 1 y m (parámetro de entrada). Modifica el procedimiento para almacenar en la variable de salida @np el número de primos almacenado.
USE ebanca;
CREATE TABLE IF NOT EXISTS primos (
id INT AUTO_INCREMENT PRIMARY KEY,
numero INT );
DELIMITER $$
DROP PROCEDURE IF EXISTS ejercicio5$$
CREATE PROCEDURE ejercicio5(IN m INT, OUT np INT)
DETERMINISTIC
BEGIN
DECLARE numero INT DEFAULT 2;
DECLARE esPrimo INT;
WHILE numero <= m DO
SET esPrimo = ejercicio3(numero);
IF esPrimo = 1 THEN
INSERT INTO primos(numero) VALUES (numero);
SET np = np + 1;
END IF;
SET numero = numero + 1;
END WHILE;
END;$$
DELIMITER ;

CALL ejercicio5(20, @np);
SELECT @np AS NumeroDePrimos;

-- Crea un procedimiento que genere n registros aleatorios en la tabla movimientos de la base ebanca. Cada registro deberá contener datos de clientes y cuentas existentes. La cantidad deberá estar entre 1 y 100000 y la fecha será la actual.
USE ebanca;
DELIMITER $$
DROP PROCEDURE IF EXISTS ejercicio6$$
CREATE PROCEDURE ejercicio6(IN n INT)
BEGIN
DECLARE i INT DEFAULT 1;
-- Verificar que n esté entre 1 y 100000
IF n < 1 OR n > 100000 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'La cantidad de registros debe estar entre 1 y 100000';
END IF;
-- Generar n registros aleatorios
WHILE i <= n DO
-- Seleccionar un cliente y una cuenta aleatoria existente
SET @cliente_dni := (SELECT dni FROM clientes ORDER BY RAND() LIMIT 1);
SET @cuenta_id := (SELECT cod_cuenta FROM cuentas ORDER BY RAND() LIMIT 1);
-- Generar un monto aleatorio
SET @cantidad := ROUND(RAND() * 1000, 2);
-- Insertar el registro en la tabla movimientos
INSERT INTO movimientos (dni, cod_cuenta, cantidad, fechahora)
VALUES (@cliente_dni, @cuenta_id, @cantidad, CURRENT_DATE);
SET i = i + 1;
END WHILE;
END;$$
DELIMITER ;

CALL ejercicio6(100);
