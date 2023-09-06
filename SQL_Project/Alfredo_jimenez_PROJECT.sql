--PROYECTO
/*
***********
    NAME        : Proyecto SQL 
    CREATED BY  : Alfredo Jimenez - 31/12/2022 
    REVIEWED BY : 
    ACTION BY   : 
    RESUME      : Query para proyecto de SQL skillstech Gen #9
-----
    MODS (MOD #00) //se especifica el formato aqui o en algun lado.
        --MOD #02       : 
        --REVIEWED BY   : 
        --CHANGES       : 
***********
*/

--PREGUNTAS DEL ARCHIVO: ej_joins
/*--1. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total)
for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity
exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first.
In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).*/

SELECT DISTINCT regions."name"                  AS nombre_region
                ,accounts."name"                AS nombre_cuenta
                ,orders."total_amt_usd"         AS order_paid_usd
    FROM "public"."orders" AS orders   
    LEFT JOIN "public"."accounts" AS accounts
        ON orders."account_id" = accounts."id"
    LEFT JOIN "public"."sales_reps" AS sales_reps
        ON accounts."sales_rep_id" = sales_reps."id"
    LEFT JOIN "public"."region" as regions
        ON sales_reps."region_id" = regions."id"
    WHERE "standard_qty" > 100 
        AND "poster_qty" > 50
    GROUP BY    regions."name"
                ,accounts."name"
                ,orders."total_amt_usd" 
    ORDER BY order_paid_usd DESC;


/* 2. Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for the Midwest region. Your final table should include three columns: the region name,
the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/

SELECT DISTINCT regions."name"      AS nombre_region
                ,sales_reps."name"  AS nombre_sales_reps
                ,accounts."name"    AS nombre_account
    FROM "public"."accounts" AS accounts
    LEFT JOIN "public"."sales_reps" AS sales_reps
        ON accounts."sales_rep_id" = sales_reps."id"
    LEFT JOIN "public"."region" AS regions
        ON sales_reps."region_id" = regions."id"
    WHERE regions."name" = 'Midwest'
    GROUP BY    regions."name"
                ,sales_reps."name"
                ,accounts."name"
    ORDER BY accounts."name" ASC;


/*3. Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for accounts where the sales rep has a last name starting with K and in the Midwest region.
Your final table should include three columns: the region name, the sales rep name, and the account name.
Sort the accounts alphabetically (A-Z) according to account name.*/

SELECT DISTINCT regions."name"      AS nombre_region
                ,sales_reps."name"  AS nombre_sales_reps
                ,accounts."name"    AS nombre_account
    FROM "public"."accounts" AS accounts
    LEFT JOIN "public"."sales_reps" AS sales_reps
        ON accounts."sales_rep_id" = sales_reps."id"
    LEFT JOIN "public"."region" AS regions
        ON sales_reps."region_id" = regions."id"
/*--NOTA 01: Funcion split_part(sales_reps."name", ' ', 2) Permite tomar el valor despues del espacio
, en este caso, el apellido en name*/
    WHERE split_part(sales_reps."name", ' ', 2) LIKE 'K%'
        AND regions."name" = 'Midwest'
    GROUP BY    regions."name"
                ,sales_reps."name"
                ,accounts."name"
    ORDER BY accounts."name" ASC
 
    
--PREGUNTAS DE EJ AGG
/*4. For each account, determine the average amount of each type of paper they purchased across their orders. 
Your result should have four columns - one for the account name and one for the average quantity purchased for 
each of the paper types for each account.*/

SELECT DISTINCT accounts."name" AS account_name
/*--NOTA 02: El uso de esta funcion CAST(AVG(orders."standard_qty") AS NUMERIC(10,3)) me permite establecer
la cantidad de decimales resultantes al aplicar la funion AVG*/
                ,CAST(AVG(orders."standard_qty") AS NUMERIC(10,3)) AS avg_standard
                ,CAST(AVG(orders."gloss_qty") AS NUMERIC(10,3)) AS avg_gloss
                ,CAST(AVG(orders."poster_qty") AS NUMERIC(10,3)) AS avg_poster
FROM "public"."orders" AS orders
LEFT JOIN "public"."accounts" AS accounts
    ON orders."account_id" = accounts."id"
GROUP BY        accounts."name"


/*5.In which month of which year did Walmart spend the most on gloss paper in terms of dollars?*/

SELECT      accounts."name"
            ,orders."occurred_at"
            ,max(orders."gloss_amt_usd") AS gloss_spend_USD
FROM "public"."orders" AS orders
LEFT JOIN "public"."accounts" AS accounts
    ON orders."account_id" = accounts."id"
WHERE accounts."name" = 'Walmart'
GROUP BY    accounts."name"
            ,orders."occurred_at"
ORDER BY gloss_spend_USD DESC

--El mayor gasto de Walmart en gloos paper se realizo en Enero del 2016 por USD 4831,05