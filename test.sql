/*
select top 10 * 
    from developers
        where expir <= 1 
        and age != 'starche' 
        and pipka <> 30  
        and >=
        and `NAME` in ('Bohdan', 'Alex', 'Vova') -- включает в себя
        OR `NAME` not in ('Busha', 'Grishu')-- не включает в себя
/*/


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- клиенты  работа сентябрь 
drop table if exists you_shema.reyting_St; -- удалить если создала в своей схеме
commit;

select  idclient,
        Ldap,
        datechange, -- дата когда взяли в работу
        timework, -- время в работе
        contract_type, -- тип дока
        result, -- результат отработки (1, 0) 
        dateCalc -- дата внесения записи
--into you_shema.reyting_St -- создавать в своей схеме (постоянная табла ) 
into #reyting_St -- создать временную таблицу
            from hren_tabla -- таблица = твоя витрина 
                where date(datechange) '2020-09-01' and '2020-09-30' ;
commit;

-----------------------------------------------------------------------------------
-- арг данные для рейтинга

select LDAP,
       count(distinct datechange) as cnt_DTchange, -- кол-во заявок в работе на сотрудника всего
       count(distinct case when result = 0 then datechange end) as otkaz, -- заявки с отказом
       count(distinct case when timework > 60 then datechange end) as longWork,
       round((datechange/cnt_DTchange*100),2) as dolia_otkaz,
       round((longWork/cnt_DTchange*100),2) as dolia_longWork
            from #reyting_St







