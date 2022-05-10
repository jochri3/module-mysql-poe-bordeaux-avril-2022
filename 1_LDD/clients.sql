-- 1. Liste toutes les bases de données
SHOW databases;

-- 2. Créer une base de données : CREATE DATABASE <nom_base_de_donnees>
CREATE DATABASE poe_cmr;

-- 3. Se positionner ou utiliser une base de données : USE <nom_base_de_donnees>
USE poe_crm;

-- 4. Créer une table
CREATE TABLE clients(
  id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  postnom VARCHAR(50),
  email VARCHAR(50) NOT NULL ,
  telephone VARCHAR(12) NOT NULL UNIQUE, -- Format +33xxxxxxxxx
);

-- 5. Lister toutes les tables d'une base de données
SHOW tables;

-- 5. Voir la description d'une table : DESC <nom_table>
DESC clients



-- Suppression de la requete
ALTER TABLE clients DROP COLUMN telephone;

-- Ajouter colonne
ALTER TABLE clients ADD COLUMN postnom VARCHAR(40);

-- Modifier un champ
ALTER TABLE clients CHANGE  email adresse_mail VARCHAR(50) NOT NULL;

--  Créer une table téléphone avec une clé étrangère
CREATE TABLE telephones(
 id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
 numero VARCHAR(15) NOT NULL,
 id_client INTEGER NOT NULL,
 FOREIGN KEY(id_client) REFERENCES clients(id) ON DELETE CASCADE
);



INSERT INTO telephones(numero,id_client) VALUES
("+33757575757",1),
("+33464746473",1),
("+32757572257",2),
("+33400746473",2),
("+33400936473",2),
("+33444236473",3),
("+33400945173",4),
("+32400945173",7);


-- Tous les numeros de tous les clients
SELECT clients.prenom,clients.nom,telephones.numero FROM clients JOIN telephones ON clients.id=telephones.id_client;


-- Tous les numeros du client avec ID = 1
SELECT clients.nom,clients.prenom,telephones.numero FROM clients JOIN telephones ON clients.id=telephones.id_client WHERE id=1;