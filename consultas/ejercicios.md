# Consultas básicas
- ¿Cuáles son los seguros con un precio superior a 400€?
        SELECT * FROM insurances WHERE annual_cost > 400;

- ¿Qué seguros cubren el 30% o más?
        SELECT * FROM insurances WHERE percentage_covered >= 30; 

- ¿Qué seguros han sido contratados antes del año 2021?
        SELECT * FROM insurances WHERE start_date < "2021-01-1";
        SELECT * FROM insurances WHERE EXTRACT(YEAR FROM start_date) < 2021;

- ¿Cuáles son los seguros que han sido contradados entre el año 2019 y 2021?
        SELECT * FROM insurances WHERE start_date >= "2019-01-1" AND start_date <= "2021-12-31";
        SELECT * FROM insurances WHERE EXTRACT(YEAR FROM start_date) >= 2019 AND EXTRACT(YEAR FROM start_date) <= 2021;
        SELECT * FROM insurances WHERE EXTRACT(YEAR FROM start_date) BETWEEN 2019 AND 2021;


- Queremos saber cuáles son los seguros con un valor superior a 400€ o que hayan sido contratados en el año 2019 para ofrecer un descuento a sus dueños.
        SELECT * FROM insurances WHERE annual_cost > 400 OR (start_date >= "2019-01-1" AND start_date <= "2019-12-31");
        SELECT * FROM insurances WHERE annual_cost > 400 OR EXTRACT(YEAR FROM start_date) = 2019;


# Consultas con JOIN
- Queremos ver los nombres de los clientes, los tipos de seguro que tienen
contratados y el coste anual de estos.
- Queremos saber el número de matrícula, precio y coste anual del seguro de todos los vehículos que tenemos almacenados.
- De cada cliente que tiene propiedades aseguradas queremos saber su nombre, los metros cuadrados de la propiedad, la ciudad donde se ubica dicha propiedad y
el coste anual del seguro.

# Agrupaciones

- ¿Cuánto dinero hemos ingresado con todos los seguros vendidos hasta la fecha?
- ¿Cuánto cuesta el seguro más caro? ¿Y el más barato?
- ¿Cuál es el seguro más caro? ¿Y el más barato?
- ¿Quién ha contratado el seguro más caro?
- ¿Cuánto dinero hemos ingresado con los seguros contratados en 2021?
- ¿Cuál es el precio promedio de los vehículos que hemos asegurado?
- ¿Cuántos seguros de propiedad hemos vendido?
- ¿Cuánto hemos ingresado en total con cada tipo de seguro?
- ¿Cuánto nos ha pagado en total cada cliente?
- ¿Cuánto nos ha pagado en total cada cliente por cada tipo de seguro?
- ¿Cuánto seguros de coche y de propiedad tiene cada cliente?