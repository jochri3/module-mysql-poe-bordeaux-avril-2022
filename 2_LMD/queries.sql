-- Lister tous les clients
SELECT * FROM clients;

-- Liste tous les client par nom et prenom
SELECT nom,prenom FROM clients;

-- Lister tous les client avec un Numero de téléphone de la belgique
SELECT * FROM clients WHERE telephone LIKE "+32%";

-- Lister tous les client avec un Numero de téléphone de la France
SELECT * FROM clients WHERE telephone LIKE "+33%";

-- Lister tous les client avec une adresse email de Orange France
SELECT * FROM clients WHERE telephone LIKE "%@orange.fr";

-- Lister tous les client avec une adresse email de Orange
SELECT * FROM clients WHERE telephone LIKE "%@orange%";


-- Mettre à jour le numéro de téléphone et l'adresse email du client avec l'id = 1
UPDATE clients SET email="jean@gmail.com",telephone="+33787878787" WHERE id=1;

