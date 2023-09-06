 Tipo de documentacion (ejemplo en una query no funcional):
/*
***********
    NAME        : Ejemplo_Documentacion
    CREATED BY  : VA 12/01/2022  // o empresa
    REVIEWED BY : VA 12/05/2022
    ACTION BY   : sp_Ejemplo_Documentacion (si hay automatizacion)
    RESUME      : Query que crea tabla Ejemplo_Documentacion //resumen breve del porque
-----
    MODS (MOD #00) //se especifica el formato aqui o en algun lado.
        --MOD #02       : VA 12/06/2022
        --REVIEWED BY   : VA 12/07/2022
        --CHANGES       : Renombramiento de campos en tabla Ejemplo_Documentacion  //ser lo mas especifico posible
***********
*/

    --Join de  "public"."orders" con "public"."accounts
    SELECT   orders."id"            as order_header_id
            ,orders."account_id"    as order_header_account_id
--MOD #02        registrar modificacion y fecha
            ,accounts."id"          as order_header_item --MOD #02
            ,accounts."id"          as order_header_id
            ,accounts."name"        as order_header_name
            ,accounts."type"        as order_header_type_cd
            ,CASE   WHEN accounts."type"  = 1 THEN "Activo"
                    WHEN accounts."type"  = 2 THEN "Inactivo"
                    WHEN accounts."type"  = 3 THEN "WIP"
             END                    as order_header_type_desc
    FROM "public"."orders" as orders
    LEFT JOIN "public"."accounts" as accounts
        ON  orders."account_id" = accounts."account_id"
    WHERE date_part('year',"occurred_at")  = '2015'
        OR date_part('year',"occurred_at") = '2016'
        OR date_part('year',"occurred_at") = '2017'
    GROUP BY    orders."id"             as order_header_id
                ,orders."account_id"    as order_header_account_id
                ,accounts."id"          as order_header_id
                ,accounts."name"        as order_header_name
                ,CASE   WHEN accounts."type"  = 1 THEN "Activo"
                        WHEN accounts."type"  = 2 THEN "Inactivo"
                        WHEN accounts."type"  = 3 THEN "WIP"
                 END                    as order_header_type_desc;


--****    END SCRIPT / QUERY //Especificar objeto  ******