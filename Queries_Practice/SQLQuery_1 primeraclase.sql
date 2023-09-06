--hola
/*

qleeeee

*/
-- select para todos los campos
SELECT * FROM "public"."accounts";

SELECT * FROM "public"."orders";

SELECT * FROM "public"."region";

SELECT * FROM "public"."sales_reps";

SELECT * FROM "public"."web_events";

--select para campos especificos
SELECT "id"
,"gloss_qty"
,"gloss_amt_usd"
FROM "public"."orders";

-- uso de distinct
SELECT DISTINCT "region_id" FROM "public"."sales_reps";

-- conocer la tabla web events
select * from "public"."web_events";

    -- Order by
    SELECT DISTINCT "account_id"
    from "public"."web_events"
    ORDER BY "account_id" asc; --min 1001

    SELECT DISTINCT "account_id"
    from "public"."web_events"
    ORDER BY "account_id" desc; --max 4501

    -- group by / funciones
    --funcion maximo
    select max("account_id")
    from "public"."web_events"

    --funcion minimo
    select min("account_id")
    from "public"."web_events"

    --count por id, ordenado
    SELECT "id"
    ,count("account_id")
    from "public"."web_events"
    GROUP BY "id"
    ORDER BY "id" ASC;

    -- count por id, filtrando por id especifico
    SELECT "id"
    ,count("account_id")
    from "public"."web_events"
    WHERE "id" = 2465
    GROUP BY "id";

 -- count por id, filtrando por id
    SELECT "id"
    ,count("account_id")
    from "public"."web_events"
    WHERE "occurred_at" = '2016-01-02T00:55:03'
    GROUP BY "id";
 
 -- WHERE CON COMANDO OR
   SELECT "id"
   ,count ("account_id")
   FROM "public"."web_events"
   WHERE "id" = 1
      OR "id" = 100
      OR "id" = 1000
      OR "id" = 4000
   GROUP BY "id"

-- WHERE CON COMANDO AND
   SELECT "id"
   ,count ("account_id")
   FROM "public"."web_events"
   WHERE "id" = 1
      AND "id" = 100
      AND "id" = 1000
      AND "id" = 4000
   GROUP BY "id"
-- WHERE CON IN ()
   SELECT "id"
   ,count ("account_id")
   FROM "public"."web_events"
   WHERE "id" in (1,100,1000,4000)
   GROUP BY "id"

-- WHERE CON BETWEEN ()
   SELECT "id"
   ,count ("account_id")
   FROM "public"."web_events"
   WHERE "id" BETWEEN 100 AND 4000
   GROUP BY "id"

-- VER CUANTAS ENTRADAS TENGO POR MES
   SELECT MONTH("occurred_at")
   ,"id"
   FROM "public"."web_events"

-- VER CANALES DIFERENTES Y CUANTAS ENTRADAS TENGO POR CANAL, ASIGNAR NOMBRE A COLUMNA DE FUNCION Y ORDENAR MI CONTEO
   SELECT DISTINCT "channel"
   ,count ("id") AS "Conteo_total"
   FROM "public"."web_events"
   GROUP BY "channel"
   ORDER BY "Conteo_total" DESC ;

-- VER CUANTAS ENTRADAS TENGO POR CANAL QUE SEA IGUAL QUE DIRECT Y QUE EMPIECEN POR 'T'
   SELECT DISTINCT "channel" as "CHANNEL"
   ,count ("id") AS "Conteo_total" --ALIAS
   FROM "public"."web_events"
   WHERE "channel" = 'direct'
      OR "channel" like '%r'
   GROUP BY "channel"
   ORDER BY "Conteo_total" DESC ;

--ver entradas por mes
SELECT EXTRACT(YEAR FROM "occurred_at")
from "public"."web_events";

-- extract year
SELECT date_part('year', "occurred_at") 
FROM "public"."web_events"
WHERE date_part('year', "occurred_at") = 2015

-- Registros que tengo por anio
SELECT DISTINCT date_part('year', "occurred_at") as "Year"
, count("id")
from "public"."web_events"
--WHERE date_part('year', "occurred_at") = 2015
GROUP BY "Year"

-- registros con dias y meses
SELECT DISTINCT date_part('year', "occurred_at") as "Year"
, date_part('month', "occurred_at") as "Month"
, date_part('day', "occurred_at") as "Day"
,"channel"
,count("id")
from "public"."web_events"
WHERE date_part('year', "occurred_at") = 2015
GROUP BY "Year"
,"Month"
,"Day"
,"channel"

--tipo de channel guardado en tabla canal_fecha
SELECT DISTINCT date_part('year', "occurred_at") as "Year"
, date_part('month', "occurred_at") as "Month"
, date_part('day', "occurred_at") as "Day"
,"channel"
,count("id")
--into Canal_Fecha INTO genera una tabla nueva
from "public"."web_events"
--WHERE date_part('year', "occurred_at") = 2015
GROUP BY "Year"
,"Month"
,"Day"
,"channel"

--agrupar por anio (fecha) para comparar usuario, total (qty) / total_amt_usd

SELECT DISTINCT date_part('year', "occurred_at") as "Year"
,"account_id" as "Users"
,"total" as "Total Qty"
,"total_amt_usd"
,"total_amt_usd"*17.64 as "Total_bss"
from "public"."orders"

select  orders."id"
,orders."account_id"
,accounts."id"
,accounts."name"
from "public"."orders" orders --tabla izq / tabla 1
inner join "public"."accounts" accounts --tabla der / tabla 2
on  orders."account_id" = accounts."id" 

--Nombre real de los atributos
/*
select "public"."accounts"."id"
,"public"."accounts"."name"
from "public"."accounts"

select "public"."orders"."id"
,"public"."orders"."account_id"
 from "public"."orders"  */

table name exch_rate
atributos:  M origen = 'MXN'
            M destino = 'USD'
            timestamp() = 2022/12/22 00:00:00:0000
            ValorCambio = 17.64



SELECT   factable.Local_amt --MXN
         ,factable.frg_amt --USD
         ,exch_rate.ValorCambio / factable.Local_amt
FROM factable
LEFT JOIN exch_rate
      on factable.timestamp()> exch_rate. timestamp()
      and factable.local_amt = 'USD'