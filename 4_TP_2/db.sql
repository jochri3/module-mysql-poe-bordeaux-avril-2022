



-- *=> Ecrire une requête pour créer ces 2 tables en prenant en compte la jointure

-- *=> Remplissez la base de données au travers des insertions
INSERT INTO `clients` (`companyName`, `firstName`, `lastName`, `email`, `phone`, `address`, `zipCode`, `city`, `country`, `state`) VALUES ('Capgemini', 'Fabrice', 'Martin', 'martin@mail.com\r\n', '0656858433', "Head Office - Capgemini Service - Place de l'Étoile - 11 rue de Tilsitt - 75017 Paris", '75017', 'Paris', 'France', '1'), ('M2I Formation', 'Julien', 'Lamard\r\n', 'lamard@mail.com', '0611223344', '17 r Chaillot, 75116 Paris\r\n', '75116', 'Paris', 'France', '0');

INSERT INTO `orders` (`clientId`, `typePresta`, `designation`, `nbDays`, `unitPrice`, `state`) VALUES 
(2,"Formation","Angular Initiation",3,1200,0),
(2,"Formation","React.js avancé",3,1000,2),
(1,"Coaching","React Techlead",20,900,2),
(2,"Coaching","Nest.js Techlead",50,800,1),
(3,"Coaching","React Techlead",30,1100,2),
(3,"Coaching","Jakarta EE",57,1200,2),
(2,"Coaching","Angular Techlead",25,1000,1);

-- *=> Afficher toutes les formations sollicités par le client M2i formation
SELECT * FROM clients INNER JOIN orders ON clients.id=orders.clientId WHERE typePresta="Formation" AND clientId=2;


-- *=> Afficher les noms et contacts de tous les contacts des clients qui ont sollicité un coaching
SELECT CONCAT(clients.firstName," ",clients.lastName),phone,companyName FROM clients INNER JOIN orders ON clients.id=orders.clientId WHERE typePresta="Coaching";

-- *=> Afficher les noms et contacts de tous les contacts des clients qui ont sollicité un coaching pour les accompagnements React.js
SELECT CONCAT(clients.firstName," ",clients.lastName),phone,companyName FROM clients INNER JOIN orders ON clients.id=orders.clientId WHERE typePresta="Coaching" AND designation LIKE "React%";

-- *=> Pour chacune des demandes de formation, afficher le prix UHT et prix TTC en se basant sur le unité Price(TJM) et le nombre de jours de prestation tout en sachant que la TVA est de 20%.
CREATE view presta_ttc AS SELECT orders.typePresta,orders.designation,orders.nbDays,orders.unitPrice,(orders.unitPrice*orders.nbDays) as prix_ht,(orders.unitPrice*orders.nbDays+orders.unitPrice*orders.nbDays*0.20) as prix_ttc FROM orders;

SELECT * FROM `presta_ttc`;

-- *=> Lister toutes les prestations qui sont confirmés et qui vont rapporter plus 30.000€
SELECT orders.typePresta,orders.designation,orders.nbDays,orders.unitPrice,(orders.unitPrice*orders.nbDays) as prix_ht,(orders.unitPrice*orders.nbDays+orders.unitPrice*orders.nbDays*0.20) as prix_ttc FROM orders WHERE (orders.unitPrice*orders.nbDays)>30000;

-- *=>
DELIMITER $$
create function calculPrixHT(nbDays INTEGER,unitPrice FLOAT)
   returns FLOAT
   BEGIN
   return nbDays*unitPrice;
   END$$
DELIMITER 

SELECT orders.typePresta,orders.designation,orders.nbDays,orders.unitPrice,(orders.unitPrice*orders.nbDays) as prix_ht,(orders.unitPrice*orders.nbDays+orders.unitPrice*orders.nbDays*0.20) as prix_ttc FROM orders WHERE (orders.unitPrice*orders.nbDays)>30000;

-- => ALTER

ALTER TABLE orders
ADD COLUMN totalExcludeTaxe
 FLOAT GENERATED ALWAYS AS ((nbDays*unitPrice)) STORED;


ALTER TABLE orders
ADD COLUMN totalWithTaxe FLOAT GENERATED ALWAYS AS ((nbDays*unitPrice*1.2)) STORED;