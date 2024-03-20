-- --Ejercicio 1
-- SELECT
--     clients.id AS client_id, (opcional)
--     insurances.id AS insurance_id, (opcional)
--     clients.name,
--     insurances.type,
--     insurances.annual_cost 
-- FROM clients 
-- JOIN insurances ON insurances.client_id = clients.id

--Ejercicio 2
-- SELECT
--     vehicles.plate_number,
--     vehicles.price,
--     insurances.annual_cost
-- FROM insurances
-- JOIN vehicles ON insurances.id = vehicles.insurance_id
-- WHERE insurances.type = "VEHICLE";

--Ejercicio 3
SELECT
    clients.name,
    properties.area,
    properties.city,
    insurances.annual_cost
FROM clients
JOIN insurances ON insruances.client_id = clients.id
JOIN properties ON properties.insurance_id = insurances.id
WHERE insurances.type = "PROPERTY";