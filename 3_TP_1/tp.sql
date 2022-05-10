-- URL : https://docs.google.com/document/d/1VbU-wyJoTTEwKE6suBtBQ6DEF11DFqrohmhTnDybbX8/edit

-- Create telephone table
CREATE TABLE telephones(
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    manufacturer VARCHAR(50) NOT NULL,
    price FLOAT(4,2) NOT NULL,
    units_sold INTEGER NOT NULL
);

-- Inserer des enregistrements
INSERT INTO telephones(name,manufacturer,price,units_sold) VALUES
("N1280","Nokia",1991925),
("Iphone 4","Apple",399,9436),
("Galaxy S5","Samsung",299,2359),
("S5620 Monte","Samsung",250,2385),
("N8","Nokia",150,7543),
("Droid","Motorola",150,8395),
("Iphone 13 Pro Max","Apple",1300,12849),
("Galaxy Note 20","Samsung",1100,10353);

-- *=> 1. Ecrire une requête pour liste tous les modèles de téléphones
SELECT manufacturer FROM telephones;
SELECT DISTINCT(manufacturer) FROM telephones;-- Eviter toute duplication

-- *=> 2. Ecrire une requête pour lister tous les telephone(name, manufacturer) de tous les téléphone dont le prix est supérieur à 200€
SELECT * FROM telephones WHERE price>200;

-- *=> 3. Ecrire une requête pour lister tous les telephone(name, manufacturer) de tous les téléphone dont le prix est varie entre 150 et 200€
SELECT * FROM telephones WHERE price>=150 AND price<=200;
SELECT * FROM telephones WHERE price BETWEEN 150 AND 200 ORDER BY price ASC;

-- *=> 4. Lister tous les téléphones de marque samsung et Apple
SELECT * FROM telephones WHERE manufacturer IN("Apple","Samsung");
SELECT * FROM telephones WHERE manufacturer = "Apple" OR manufacturer ="Samsung";

-- *=> 5. Afficher le revenu total pour les téléphones vendues.Pour chaque téléphone, vous avez le prix et la quantité vendu
SELECT name,(price*units_sold) as revenu FROM telephones;
SELECT name,CONCAT(price*units_sold,"€") as revenu  FROM telephones;
CREATE view v_total_revenu AS SELECT name,(price*units_sold) as revenu FROM telephones;
SELECT * FROM v_total_revenu;


-- *=> 6. Afficher le nombre des téléphones Apple qu’il y a dans la table telephones en ajoutant la devise pour la colonne price.Par exemple 1200 € et pour la quantité vendue ajouter la chaîne ventes,exemple : 10353 ventes
SELECT COUNT(*) FROM telephones WHERE manufacturer = "Apple";

-- *=> 7. Afficher toutes les données de la table téléphone en renommant les champs de la manière suivante : name=>modèle, manufacturer => fabricant, price => prix, units_sold => quantité vendue
SELECT name as "modèle", manufacturer as fabricant, price as prix, units_sold as "quantité vendue" FROM telephones;

-- *=> 8. Afficher tous les telephones dont le prix total des ventes est supérieur à 1300000€.
SELECT name,CONCAT(price*units_sold,"€") FROM telephones;

-- *=> Afficher la somme/moyenne/max de toute les vente
SELECT SUM(units_sold) as total_des_ventes FROM telephones;
SELECT AVG(units_sold) as total_des_ventes FROM telephones;
SELECT MAX(units_sold) as total_des_ventes FROM telephones;
SELECT MIN(units_sold) as total_des_ventes FROM telephones;

-- AGGREGATIONS : GROUPING
-- *=> 10. Le prix total de tous les telephones de toutes les marques
SELECT manufacturer, sum(prix) FROM telephones GROUP BY manufacturer;

-- *=> 11. Le total des ventes tous les telephones par marque
SELECT manufacturer, sum(prix*units_sold) FROM telephones GROUP BY manufacturer;

-- *=> 12. Le total des ventes tous les telephones Apple
SELECT manufacturer, sum(price*units_sold) FROM telephones where manufacturer="Apple" GROUP BY manufacturer;







-- Aggregations
-- Calcul de la somme de toutes les valeurs d'une colonne
SELECT SUM(units_sold) FROM telephones;

-- Calcul de la moyenne
SELECT AVG(units_sold) as moyenne_ventes FROM telephones;

-- Affichage du prix du téléphone le plus cher
SELECT MAX(price) FROM telephones;

-- Affichage du prix du téléphone le moins cher
SELECT MIN(price) FROM telephones;



-- Tous toutes les marques dont le CA > 20000000
SELECT manufacturer,CONCAT(SUM(price*units_sold),"€") as chiffre_affaire FROM telephones GROUP BY manufacturer HAVING SUM(price*units_sold)>200000000;

-- Vente par fabricant
SELECT manufacturer,SUM(units_sold) FROM telephones GROUP BY manufacturer;

-- Vente par fabricant avec unité
SELECT manufacturer,CONCAT(SUM(price*units_sold),"€") as chiffre_affaire FROM telephones GROUP BY manufacturer;

-- Téléphones plus chers que la moyenne
SELECT name,manufacturer,price FROM telephones WHERE price > (SELECT AVG(price) FROM telephones);


-- Téléphones moins chers que la moyenne
SELECT name,manufacturer,price FROM telephones WHERE price < (SELECT AVG(price) FROM telephones);

-- ventre par fabricant par ordre décroissant de CA
SELECT manufacturer,sum(price*units_sold) as ca FROM telephones GROUP BY manufacturer ORDER BY ca DESC;

-- =>=> Attention à l'ordre alphabetique des nombres
SELECT manufacturer,CONCAT(sum(price*units_sold),"€") as ca FROM telephones GROUP BY manufacturer ORDER BY ca DESC;


-- Conséquences de na pas utiliser GROUP BY on aura qu'un seul résultat : On a un seul telephone mais avec le CA total :D
SELECT manufacturer,sum(price*units_sold) as ca FROM telephones;

