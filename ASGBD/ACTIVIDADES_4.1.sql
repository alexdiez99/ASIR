-- ACTIVIDADES 4.1

-- Sobre la base de pruebas test crea un procedimiento para mostrar el año actual.
USE ebanca;
DELIMITER $$
DROP PROCEDURE IF EXISTS ano_actual$$
CREATE PROCEDURE ano_actual()
BEGIN
    SELECT YEAR(NOW()) AS Año_actual;
END;$$
DELIMITER ;

CALL ano_actual();

-- Crea y muestra una variable de usuario con SET. ¿Debe ser de sesión o puede ser global?
USE ebanca;
DELIMITER $$
DROP PROCEDURE IF EXISTS variable_usuario$$
CREATE PROCEDURE variable_usuario()
BEGIN
DECLARE mivariable integer;
SET mivariable = 12345;
SELECT mivariable AS Variable;
END;$$
DELIMITER ;

CALL variable_usuario;

-- Usa un procedimiento que sume uno a la variable anterior cada vez que se ejecute. En este caso la variable es de entrada salida ya que necesitamos su valor para incrementarlo y además necesitamos usarlo después de la función para comprobarlo.
USE ebanca;
DELIMITER $$
DROP PROCEDURE IF EXISTS sumaruno$$
CREATE PROCEDURE sumaruno(INOUT contar integer)
BEGIN
IF contar THEN
SET contar = contar + 1;
END IF;
SELECT contar as Variable_Sumar;
END;$$
SET @c = 1;$$
DELIMITER ;

CALL sumaruno(@c);

-- Crea un procedimiento que muestre las tres primeras letras de una cadena pasada como parámetro en mayúsculas.
USE ebanca;
DELIMITER $$
DROP PROCEDURE IF EXISTS tres_mayusculas$$
CREATE PROCEDURE tres_mayusculas(IN texto varchar(255))
BEGIN
IF LENGTH(texto) > 0 THEN
SELECT UPPER(LEFT(texto,3)) AS Cadena_de_texto;
ELSE
SELECT 'Debes esribir el parametro' AS Error;
END IF;
END;$$
DELIMITER ;

CALL tres_mayusculas('chicago');

-- Crea un procedimiento que muestre dos cadenas pasadas como parámetros concatenados y en mayúscula.
USE ebanca;
DELIMITER $$
DROP PROCEDURE IF EXISTS ejercicio5$$
CREATE PROCEDURE ejercicio5(IN texto1 varchar(255), IN texto2 varchar(255))
BEGIN
IF LENGTH(texto1) > 0 and LENGTH(texto2) > 0 THEN
SELECT UPPER(CONCAT(texto1,texto2)) as Resultado;
ELSE
SELECT 'Debes escribir dos parametros' AS Error;
END IF;
END;$$
DELIMITER ;

CALL ejercicio5('chicago','bulls');

-- Crea una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados.
USE ebanca;
DELIMITER $$
DROP FUNCTION IF EXISTS ejercicio6$$
CREATE FUNCTION ejercicio6(lado1 integer, lado2 integer)
RETURNS varchar(100)
DETERMINISTIC
BEGIN
DECLARE hipotenusa varchar(100);
IF lado1 > 0 AND lado2 > 0 THEN
SET hipotenusa = ROUND(SQRT((lado1 * lado1) + (lado2 * lado2)), 0);
ELSE
SET hipotenusa = 'Debese escribir parametros mayores que 0';
END IF;
RETURN(hipotenusa);
END;$$
DELIMITER ;

SELECT ejercicio6(2,7);
