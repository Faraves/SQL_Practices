--Script de Clase:

-- having pára funciones de agregacion como count 
 select "sales_rep_id" 
 , count("name") 
 FROM "public"."accounts" 
 group by "sales_rep_id" 
 having count("name") > 1
order by count("name") ASC 
 LIMIT 5 

 select "sales_rep_id"
, count("name") 
 FROM "public"."accounts" 
 group by "sales_rep_id"
having count("name") > 1 
 order by count("name") DESC
 LIMIT 5

select "sales_rep_id"
, count("name") 

--script de insights en clase del 06/12/22
SELECT "account_id", AVG("total") as Prom_total_qty
    FROM "public"."orders"
    GROUP BY "account_id"
    HAVING "account_id" = 1001

--join con acounts para relacionar orders con salesrep

SELECT DISTINCT sales_reps."region_id" 
    ,regions."name" AS nombre_region 
    ,accounts."name" AS nombre_cliente
    ,accounts."sales_rep_id"
    ,sales_reps."name" nombre_vendedor
    ,orders."account_id"
    , SUM(orders."total") as acum_total_qty
    , SUM(orders."total_amt_usd") as acum_total_usd
    FROM "public"."orders" as orders
    LEFT JOIN "public"."accounts" as accounts
        ON orders."account_id" = accounts."id"
    LEFT JOIN "public"."sales_reps" as sales_reps
        ON accounts."sales_rep_id" = sales_reps."id"
    LEFT JOIN "public"."region" as regions
        ON sales_reps."region_id" = regions."id"
    GROUP BY sales_reps."region_id" 
    , regions."name"
    ,accounts."name"
    ,accounts."sales_rep_id"
    ,sales_reps."name"
    ,orders."account_id";

SELECT 
    accounts."id"
    ,accounts."name"
    ,accounts."sales_rep_id"
    FROM "public"."accounts"        AS accounts

SELECT 
    sales_reps."id"
    ,sales_reps."name"
    ,sales_reps."region_id"
    FROM "public"."sales_reps"      AS sales_reps

SELECT 
    regions."id"
    ,regions."name"
    FROM "public"."region"      AS regions
    
