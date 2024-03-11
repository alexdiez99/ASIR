-- ACTIVIDADES 4.2

-- Crea una función que devuelva 1 ó 0 si un número es o no divisible por otro.
USE ebanca;
DELIMITER $$
DROP FUNCTION IF EXISTS ejercicio1$$
CREATE FUNCTION ejercicio1(numero1 varchar(100), numero2 varchar(100))
RETURNS varchar(100)
DETERMINISTIC
BEGIN
DECLARE divisible varchar(100);
IF numero1 > 0 AND numero2 > 0 THEN
IF MOD(numero1,numero2) THEN
SET divisible = 1;
ELSE
SET divisible = 0;
END IF;
ELSE
SET divisible = 'Debes escribir dos parametros y que sean mayores que 0';
END IF;
RETURN(divisible);
END;$$
DELIMITER ;

SELECT ejercicio1(15,5);

-- Usa las estructuras condicionales para mostrar el día de la semana según un valor de entrada numérico, 1 para domingo, 2 lunes, etc.
USE ebanca;
DELIMITER $$
DROP FUNCTION IF EXISTS ejercicio2$$
CREATE FUNCTION ejercicio2(numero integer)
RETURNS varchar(100)
DETERMINISTIC
BEGIN
DECLARE dia varchar(100);
IF numero = 1 THEN
SET dia = 'Domingo';
ELSEIF numero = 2 THEN
SET dia = 'Lunes';
ELSEIF numero = 3 THEN
SET dia = 'Martes';
ELSEIF numero = 4 THEN
SET dia = 'Miercoles';
ELSEIF numero = 5 THEN
SET dia = 'Jueves';
ELSEIF numero = 6 THEN
SET dia = 'Viernes';
ELSEIF numero = 7 THEN
SET dia = 'Sabado';
ELSE
SET dia = 'Debemos introducir un numero entre 1 y 7';
END IF;
RETURN(dia);
END;$$
DELIMITER ;

SELECT ejercicio2(5);

    -- MANERA MÁS ÚTIL:

USE ebanca;
DELIMITER $$
DROP FUNCTION IF EXISTS ejercicio2$$
CREATE FUNCTION ejercicio2(numero integer)
RETURNS varchar(100)
DETERMINISTIC
BEGIN
DECLARE dia varchar(100);
IF numero >= 0 AND numero < 8 THEN
CASE
WHEN 0 THEN
SET dia = 'Domingo';
WHEN 1 THEN
SET dia = 'Lunes';
WHEN 2 THEN
SET dia = 'Martes';
WHEN 3 THEN
SET dia = 'Miercoles';
WHEN 4 THEN
SET dia = 'Jueves';
WHEN 5 THEN
SET dia = 'Viernes';
WHEN 6 THEN
SET dia = 'Sabado';
END CASE;
ELSE
SET dia = 'Debemos introducir un numero entre 1 y 7';
END IF;
RETURN(dia);
END;$$
DELIMITER ;

SELECT ejercicio2(3);

-- Crea una función que devuelva el mayor de tres números pasados como parámetros.
USE ebanca;
DELIMITER $$
DROP FUNCTION IF EXISTS ejercicio3$$
CREATE FUNCTION ejercicio3(numero1 integer, numero2 integer, numero3 integer)
RETURNS varchar(100)
DETERMINISTIC
BEGIN
DECLARE numeromayor varchar(100);
IF numero1 > numero2 AND numero1 > numero3 THEN
SET numeromayor = numero1;
ELSEIF numero2 > numero1 AND numero2 > numero3 THEN
SET numeromayor = numero2;
ELSE
SET numeromayor = numero3;
END IF;
RETURN(numeromayor);
END;$$
DELIMITER ;

SELECT ejercicio3(1,5,3);

-- Sobre la base de datos liga crea una función que devuelva 1 si ganó el visitante y 0 en caso contrario. El parámetro de entrada es el resultado con el formato ‘xxx-xxx’.
-- NADA

-- Crea un procedimiento que diga si una palabra, pasada como parámetro, es palíndroma.
USE ebanca;
DELIMITER $$
DROP PROCEDURE IF EXISTS ejercicio5$$
CREATE PROCEDURE ejercicio5(IN palabra varchar(100))
DETERMINISTIC
BEGIN
DECLARE palabraReversa varchar(100);
SET palabraReversa = REVERSE(palabra);
IF palabra = palabraReversa THEN
SELECT CONCAT('La palabra ', palabra, ' es palindroma') AS Resultado;
ELSE
SELECT CONCAT('La palabra ', palabra, ' no es palindroma') AS Resultado;
END IF;
END;$$
DELIMITER ;

CALL ejercicio5('radar');
