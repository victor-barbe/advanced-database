-- ------------------------------------------------------
-- NOTE: DO NOT REMOVE OR ALTER ANY LINE FROM THIS SCRIPT
-- ------------------------------------------------------

select 'Query 00' as '';
-- Show execution context
select current_date(), current_time(), user(), database();
-- Conform to standard group by constructs
set session sql_mode = 'ONLY_FULL_GROUP_BY';

-- Write the SQL queries that return the information below:
-- Ecrire les requêtes SQL retournant les informations ci-dessous:

select 'Query 01' as '';
-- The countries of residence the supplier had to ship products to in 2014
-- Les pays de résidence où le fournisseur a dû envoyer des produits en 2014
SELECT DISTINCT residence FROM customers c NATURAl JOIN orders o WHERE year(o.odate) = 2014  and c.cid = o.cid AND residence IS NOT NULL;

select 'Query 02' as '';
-- For each known country of origin, its name, the number of products from that country, their lowest price, their highest price
-- Pour chaque pays d'orgine connu, son nom, le nombre de produits de ce pays, leur plus bas prix, leur plus haut prix
SELECT origin, COUNT(*) 'number of products', MAX(price) 'max price', MIN(price) 'min price' FROM products GROUP BY origin;


select 'Query 03' as '';
-- The customers who ordered in 2014 all the products (at least) that the customers named 'Smith' ordered in 2013
-- Les clients ayant commandé en 2014 tous les produits (au moins) commandés par les clients nommés 'Smith' en 2013
SELECT DISTINCT
    cname 'Customer name'
FROM
    customers AS c
WHERE
    c.cname != 'Smith' AND(
    SELECT
        COUNT(*)
    FROM
        orders
    NATURAL JOIN customers WHERE cname = 'Smith' AND YEAR(odate) = 2013
) =(
    SELECT
        COUNT(DISTINCT pid)
    FROM
        customers
    NATURAL JOIN orders WHERE c.cid = cid AND YEAR(odate) = 2014 AND pid IN(
        SELECT
            pid
        FROM
            orders
        NATURAL JOIN customers WHERE cname = 'Smith' AND YEAR(odate) = 2013
        GROUP BY
            cid
    )
);

select 'Query 04' as '';
-- For each customer and each product, the customer's name, the product's name, the total amount ordered by the customer for that product,
-- sorted by customer name (alphabetical order), then by total amount ordered (highest value first), then by product id (ascending order)
-- Par client et par produit, le nom du client, le nom du produit, le montant total de ce produit commandé par le client, 
-- trié par nom de client (ordre alphabétique), puis par montant total commandé (plus grance valeur d'abord), puis par id de produit (croissant)
SELECT DISTINCT
    c.cname,
    p.pname,
    (o.quantity * p.price) 'total'
FROM
    customers c
NATURAL JOIN products p,
    orders o
WHERE
    c.cid = o.cid AND o.pid = p.pid
ORDER BY
    c.cname,
    p.pname,
    total;

select 'Query 05' as '';
-- The customers who only ordered products originating from their country
-- Les clients n'ayant commandé que des produits provenant de leur pays
SELECT DISTINCT customers.cname FROM customers WHERE cid NOT IN( SELECT cid FROM customers NATURAL JOIN products NATURAL JOIN orders WHERE residence != origin OR residence IS NULL) AND cid IN(SELECT cid FROM orders);

select 'Query 06' as '';
-- The customers who ordered only products originating from foreign countries 
-- Les clients n'ayant commandé que des produits provenant de pays étrangers
SELECT DISTINCT customers.cname FROM customers WHERE cid NOT IN( select cid from customers NATURAL JOIN products NATURAL JOIN orders WHERE residence = origin) AND cid IN(SELECT cid FROM orders);

select 'Query 07' as '';
-- The difference between 'USA' residents' per-order average quantity and 'France' residents' (USA - France)
-- La différence entre quantité moyenne par commande des clients résidant aux 'USA' et celle des clients résidant en 'France' (USA - France)
SELECT AVG(orders.quantity) - (SELECT AVG(orders.quantity) FROM orders NATURAL JOIN customers WHERE customers.residence = 'France' GROUP BY orders.cid ) FROM orders NATURAL JOIN customers WHERE customers.residence = 'USA' GROUP BY orders.cid;

select 'Query 08' as '';
-- The products ordered throughout 2014, i.e. ordered each month of that year
-- Les produits commandés tout au long de 2014, i.e. commandés chaque mois de cette année
SELECT pname 'products ordered throughout a year' FROM products p WHERE (SELECT count(DISTINCT month(odate)) FROM orders o WHERE o.pid = p.pid) = 12;


select 'Query 09' as '';
-- The customers who ordered all the products that cost less than $5
-- Les clients ayant commandé tous les produits de moins de $5
SELECT DISTINCT
    cname 'Customer name'
FROM
    customers AS c
WHERE
(SELECT
        COUNT(*)
    FROM
    products p WHERE p.price <= 5
) =(
    SELECT
        COUNT(DISTINCT pid)
    FROM
        orders o
        NATURAL JOIN products q WHERE c.cid = o.cid AND o.pid = q.pid AND o.cid = c.cid AND q.pid IN(
        SELECT
            pid
        FROM
            products
            WHERE price <= 5
        GROUP BY
            pid
    )
);

select 'Query 10' as '';
-- The customers who ordered the greatest number of common products. Display 3 columns: cname1, cname2, number of common products, with cname1 < cname2
-- Les clients ayant commandé le grand nombre de produits commums. Afficher 3 colonnes : cname1, cname2, nombre de produits communs, avec cname1 < cname2


select 'Query 11' as '';
-- The customers who ordered the largest number of products
-- Les clients ayant commandé le plus grand nombre de produits
SELECT customers.cname FROM customers NATURAL JOIN orders GROUP BY customers.cid ORDER BY SUM(orders.quantity) DESC LIMIT 1;

select 'Query 12' as '';
-- The products ordered by all the customers living in 'France'
-- Les produits commandés par tous les clients vivant en 'France'
SELECT DISTINCT
    pname 'Product name'
FROM
    products AS p
WHERE
(SELECT
        COUNT(*)
    FROM
	customers WHERE residence = 'France'
) =(
    SELECT
        COUNT(DISTINCT pid)
    FROM
        products
    NATURAL JOIN orders WHERE p.pid = pid AND pid IN(
        SELECT
            pid
        FROM
            orders
        NATURAL JOIN customers WHERE residence = 'France' 
        GROUP BY
            pid
    )
);

select 'Query 13' as '';
-- The customers who live in the same country customers named 'Smith' live in (customers 'Smith' not shown in the result)
-- Les clients résidant dans les mêmes pays que les clients nommés 'Smith' (en excluant les Smith de la liste affichée)
select DISTINCT c.cname 'customers from same country as smith' FROM customers c,customers s WHERE s.cname = 'Smith' AND c.cname != 'Smith' AND c.residence = s.residence;


select 'Query 14' as '';
-- The customers who ordered the largest total amount in 2014
-- Les clients ayant commandé pour le plus grand montant total sur 2014 
SELECT customers.cname FROM customers NATURAL JOIN orders WHERE YEAR(orders.odate) = 2014 GROUP BY customers.cid ORDER BY SUM(orders.quantity) DESC LIMIT 1;

select 'Query 15' as '';
-- The products with the largest per-order average amount 
-- Les produits dont le montant moyen par commande est le plus élevé
SELECT products.pname FROM products NATURAL JOIN orders GROUP BY orders.pid ORDER BY AVG(orders.quantity) DESC LIMIT 1;

select 'Query 16' as '';
-- The products ordered by the customers living in 'USA'
-- Les produits commandés par les clients résidant aux 'USA'
SELECT DISTINCT products.pname FROM products WHERE pid IN( SELECT pid FROM orders NATURAL JOIN products NATURAL JOIN customers WHERE residence = 'USA') AND pid IN(SELECT pid FROM orders);

select 'Query 17' as '';
-- The pairs of customers who ordered the same product en 2014, and that product. Display 3 columns: cname1, cname2, pname, with cname1 < cname2
-- Les paires de client ayant commandé le même produit en 2014, et ce produit. Afficher 3 colonnes : cname1, cname2, pname, avec cname1 < cname2
SELECT DISTINCT c.cname 'Customer 1', s.cname 'Customer 2', p.pname FROM customers c,customers s, orders o, orders q, products p WHERE YEAR(o.odate) = 2014 AND YEAR(q.odate) = 2014 AND c.cname != s.cname AND c.cid = o.cid AND s.cid = q.cid AND o.pid = q.pid AND p.pid = o.pid;

select 'Query 18' as '';
-- The products whose price is greater than all products from 'India'
-- Les produits plus chers que tous les produits d'origine 'India'
SELECT DISTINCT products.pname FROM products WHERE products.price > (SELECT MAX(products.price) FROM products WHERE products.origin = 'India') AND products.pname != 'India';

select 'Query 19' as '';
-- The products ordered by the smallest number of customers (products never ordered are excluded)
-- Les produits commandés par le plus petit nombre de clients (les produits jamais commandés sont exclus)
SELECT
    pname 'Product ordered by the smallest number of customers'
FROM
    products
WHERE
    pid IN(
    SELECT
        pid
    FROM
        (
        SELECT
            pid,
            COUNT(DISTINCT cid) mini
        FROM
            orders
        GROUP BY
            pid
    ) A
WHERE
    mini =(
    SELECT
        MIN(mini)
    FROM
        (
        SELECT
            pid,
            COUNT(DISTINCT cid) mini
        FROM
            orders
        GROUP BY
            pid
    ) B
)
);

select 'Query 20' as '';
-- For all countries listed in tables products or customers, including unknown countries: the name of the country, the number of customers living in this country, the number of products originating from that country
-- Pour chaque pays listé dans les tables products ou customers, y compris les pays inconnus : le nom du pays, le nombre de clients résidant dans ce pays, le nombre de produits provenant de ce pays 


