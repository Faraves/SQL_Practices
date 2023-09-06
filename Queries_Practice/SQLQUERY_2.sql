-- como obtengo insight de vendedores por zonas
SELECT * FROM "public"."accounts"

SELECT "sales_rep_id","name" FROM "public"."accounts"
WHERE "name" = 'Walmart'

--ver nombres asignados a un salesrep
SELECT "sales_rep_id","name" FROM "public"."accounts"
WHERE "sales_rep_id" = '321500'

--conteo de cuantas cuentas llevan los sales rep sin que esten repetidas, where es validar si un caracter es x o una suma operacion logica, having cuando toca hacer condiciones pero con una funcion de agregacion como sacar un promedio, maximo, minimo  
SELECT DISTINCT "sales_rep_id"
    , COUNT ("name") AS "CONTEO_salesid"
    FROM "public"."accounts"
    GROUP BY "sales_rep_id"
    HAVING COUNT ("name") > 1
    ORDER BY "CONTEO_salesid" DESC;

--conteo de top 5 vendedores
SELECT DISTINCT "sales_rep_id"
    , COUNT ("name") AS "CONTEO_salesid"
    FROM "public"."accounts"
    GROUP BY "sales_rep_id"
    HAVING COUNT ("name") > 1
    ORDER BY "CONTEO_salesid" DESC
    LIMIT 5;

--como saber los nombres de los sales_rep_id, usando otra tabla segun las FK, unir accounts con salesrep
SELECT * FROM "public"."sales_reps"

SELECT accounts."sales_rep_id"
        --,salesreps."id"
        ,salesreps."name"
    , count (accounts."name") AS conteo
    FROM "public"."accounts" AS accounts
    LEFT JOIN "public"."sales_reps" AS salesreps
    ON accounts."sales_rep_id" = salesreps."id"
    GROUP BY accounts."sales_rep_id"
        --,salesreps."id"
        ,salesreps."name" 
    ORDER BY conteo DESC
    LIMIT 5