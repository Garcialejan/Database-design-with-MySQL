# Consultas básicas
- ¿Cuáles son los seguros con un precio superior a 400€?
```sql 
        SELECT * FROM insurances WHERE annual_cost > 400;
```

- ¿Qué seguros cubren el 30% o más?
```sql 
        SELECT * FROM insurances WHERE percentage_covered >= 30; 
```

- ¿Qué seguros han sido contratados antes del año 2021?
```sql 
        SELECT * FROM insurances WHERE start_date < "2021-01-1";
        SELECT * FROM insurances WHERE EXTRACT(YEAR FROM start_date) < 2021;
```

- ¿Cuáles son los seguros que han sido contradados entre el año 2019 y 2021?
```sql 
        SELECT * FROM insurances WHERE start_date >= "2019-01-1" AND start_date <= "2021-12-31";
        SELECT * FROM insurances WHERE EXTRACT(YEAR FROM start_date) >= 2019 AND EXTRACT(YEAR FROM start_date) <= 2021;
        SELECT * FROM insurances WHERE EXTRACT(YEAR FROM start_date) BETWEEN 2019 AND 2021;
```


- Queremos saber cuáles son los seguros con un valor superior a 400€ o que hayan sido contratados en el año 2019 para ofrecer un descuento a sus dueños.
```sql 
        SELECT * FROM insurances WHERE annual_cost > 400 OR (start_date >= "2019-01-1" AND start_date <= "2019-12-31");
        SELECT * FROM insurances WHERE annual_cost > 400 OR EXTRACT(YEAR FROM start_date) = 2019;
```


# Consultas con JOIN
```sql 
        SELECT clients.name, insurances.type, insurances.annual_cost FROM clients JOIN insurances ON insurances.client_id = clients.id
        SELECT name, type, annual_cost FROM clients JOIN insurances ON insurances.client_id = clients.id
        -- Si solo aparecen en una tabla, no hace falta especificar de que tabla provienen por lo que puedes ahorrar código
```

- Queremos saber el número de matrícula, precio y coste anual del seguro de todos los vehículos que tenemos almacenados.
```sql 
        SELECT 
                vehicles.plate_number, 
                vehicles.price, 
                insurances.annual_cost 
        FROM insurances 
        JOIN vehicles ON insurances.id = vehicles.insurance_id 
        WHERE insurances.type = "VEHICLE";

        -- Con el WHERE final nos aseguramos de que efectivamente solo estamos tteniendo en cuenta datos de seguros de vehículos. Es una capa más de seguridad, aunque el backend ya 
        debería lidiar con este tipo de problemas.
```

        

- De cada cliente que tiene propiedades aseguradas queremos saber su nombre, los metros cuadrados de la propiedad, la ciudad donde se ubica dicha propiedad y el coste anual del seguro.
```sql 
        SELECT
                clients.name,
                properties.area,
                properties.city,
                insurances.annual_cost
        FROM clients
        JOIN insurances ON insruances.client_id = clients.id
        JOIN properties ON properties.insurance_id = insurances.id
        WHERE insurances.type = "PROPERTY";
```

# Agrupaciones

- ¿Cuánto dinero hemos ingresado con todos los seguros vendidos hasta la fecha?
```sql 
        SELECT SUM(annual_cost) AS facturacion_total FROM insurances;
```

- ¿Cuánto cuesta el seguro más caro? ¿Y el más barato?
```sql 
        SELECT MAX(annual_cost) FROM insurances;
        SELECT MIN(annual_cost) FROM insurances;
```

- ¿Cuál es el seguro más caro? ¿Y el más barato?
```sql 
        SELECT * FROM insurances
        WHERE annual_cost = (SELECT MAX(annual_cost) FROM insurances);

        SELECT * FROM insurances 
        WHERE annual_cost = (SELECT MIN(annual_cost) FROM insurances);
```

- ¿Quién ha contratado el seguro más caro?
```sql 
        SELECT 
                clients.name,
                clients.id
        FROM insurances 
        JOIN clients ON insurances.client_id = clients.id
        WHERE insurances.annual_cost = (SELECT MAX(annual_cost) FROM insurances);
```


- ¿Cuánto dinero hemos ingresado con los seguros contratados en 2021?
```sql 
        SELECT SUM(annual_cost) FROM insurances 
        WHERE EXTRACT(YEAR FROM start_date) = 2021;
```

- ¿Cuál es el precio promedio de los vehículos que hemos asegurado?
```sql 
        SELECT AVG(price) FROM vehicles;
```

- ¿Cuántos seguros de propiedad hemos vendido?
```sql 
        SELECT COUNT(insurance_id) FROM properties;
        SELECT COUNT(*) FROM insurances WHERE type = "PROPERTY";
```

- ¿Cuánto hemos ingresado en total con cada tipo de seguro?

```sql 
        SELECT type, SUM(annual_cost) FROM insurances GROUP BY (type);
```

- ¿Cuánto nos ha pagado en total cada cliente?
```sql 
        SELECT client_id, SUM(annual_cost) FROM insurances GROUP BY(client_id);
        --Si queremos que aparezca también el nombre del cliente podemos hacer
        SELECT 
                clients.id,
                lients.name,
        SUM(annual_cost)
        FROM clients 
        JOIN insurances ON clients.id = insurances.client_id
        GROUP BY clients.id;
```


- ¿Cuánto nos ha pagado en total cada cliente por cada tipo de seguro?
```sql 
        SELECT client_id, id, type, SUM(annual_cost) FROM insurances GROUP BY client_id, type;
```

- ¿Cuánto seguros de coche y de propiedad tiene cada cliente?
```sql 
        SELECT client_id, id, type, COUNT(type) FROM insurances GROUP BY client_id, type;
```
