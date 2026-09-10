-- Question 1 : Afficher le nom complet de chaque coureur en majuscule et en minuscule.
SELECT 
UPPER(nom_complet) AS nom_complet_maj, 
LOWER(nom_complet) AS nom_complet_min
FROM coureurs;

-- Question 2 : Afficher une colonne qui concatène la ville et le dossard (ex: 'Lyon - A101') pour 
-- chaque coureur.
SELECT 
CONCAT(ville, ' - ', dossard) 
FROM coureurs;

-- Question 3 : Afficher le nom complet et une nouvelle colonne initiale_prenom qui 
-- contient le premier caractère du nom.
SELECT 
	nom_complet, 
	SUBSTRING(nom_complet, 1, 1) AS initiale_prenom
FROM coureurs;
SELECT 
	nom_complet, 
	LEFT(nom_complet, 1) AS initiale_prenom
FROM coureurs;

-- Question 4 : Afficher les coureurs dont le nom complet commence par 'M'. 
-- Trouver deux solutions.
SELECT nom_complet
FROM coureurs
WHERE LEFT(nom_complet, 1) = 'M';

SELECT nom_complet
FROM coureurs 
WHERE nom_complet LIKE 'M%';

SELECT nom_complet
FROM coureurs
WHERE SUBSTRING(nom_complet, 1, 1) = 'M';

-- Question 5 : Afficher le nom complet de chaque coureur avec sa longueur 
-- en nombre de caractères.
SELECT nom_complet, LENGTH(nom_complet)
FROM coureurs;

SELECT 
	nom_complet, 
	LENGTH(REPLACE(nom_complet, ' ', '')) AS nombre_caracteres
FROM coureurs;

-- Question 6 : Afficher le prénom et le nom de famille de chaque coureur dans 
-- des colonnes séparées.
SELECT 
	nom_complet,
	SPLIT_PART(nom_complet, ' ', 1) AS prenom, 
	SPLIT_PART(nom_complet, ' ', 2) AS nom
FROM coureurs;

-- Question 7 : Certains noms de villes ont pu être saisis avec des 
-- espaces en trop. Afficher les noms de villes sans ses espaces en trop.
SELECT ville, TRIM(ville, ' ')
FROM coureurs;

-- Question 8 : Afficher la lettre au début de chaque numéro de dossard dans 
-- une colonne, et le numéro de dossard sans cette lettre dans une autre colonne.
SELECT 
	dossard,
	LEFT(dossard, 1) AS lettre,
	SUBSTRING(dossard, 2) AS numero
FROM coureurs;

SELECT 
	dossard,
	LEFT(dossard, 1) AS lettre,
	RIGHT(dossard, LENGTH(dossard) - 1) AS numero
FROM coureurs;

-- Question 9 : Afficher pour chaque coureur le nom_complet avec la catégorie en 
-- majuscules, concaténée de manière lisible (ex : 'nom_complet : CATEGORIE').
SELECT CONCAT(nom_complet, ' : ', UPPER(categorie)) AS nom_concat
FROM coureurs;

SELECT nom_complet || ' : ' || UPPER(categorie) AS nom_concat
FROM coureurs;

-- Question 10 : Remplacer dans ville toutes les occurrences de 'y' par 'Y'.
SELECT REPLACE(ville, 'y', 'Y') AS ville
FROM coureurs;

-- Question 11 : Afficher le nom complet sans les espaces (on garde le texte collé).
SELECT 
	nom_complet, 
	REPLACE(nom_complet, ' ', '') AS prenom_nom
FROM coureurs;

-- Question 12 : Afficher les coureurs de la ville de Lyon. Attention, 
-- certains noms de villes ont peut-être des espaces en trop.
SELECT * FROM coureurs
WHERE TRIM(ville) = 'Lyon';

-- Question 13 : Créer une colonne status qui affiche 'A terminé' ou 'Abandon' en 
-- fonction de si le coureur a fini la course ou pas.
SELECT 
	nom_complet, 
	CASE
		WHEN a_fini THEN 'A terminé'
		ELSE 'Abandon'
	END AS course_statut
FROM coureurs;

-- Question 14 : Afficher une colonne tranche_temps selon le temps. 
-- Si le temps commence par 01: -> 'Moins de 2h', 
-- s'il commence par 02: -> 'Entre 2h et 3h', sinon -> 'Plus de 3h'.
SELECT 
	nom_complet,
	temps,
	CASE 
		WHEN LEFT(temps, 2) = '01' THEN 'Moins de 2h'
		WHEN LEFT(temps, 2) = '02' THEN 'Entre 2h et 3h'
		ELSE 'Plus de 3h'
	END AS tranche_temps
FROM coureurs;

SELECT 
	nom_complet,
	temps,
	CASE LEFT(temps, 2)
		WHEN '01' THEN 'Moins de 2h'
		WHEN '02' THEN 'Entre 2h et 3h'
		ELSE 'Plus de 3h'
	END AS tranche_temps
FROM coureurs;

-- Question 15 : Afficher une colonne ville_maj qui met la ville en 
-- majuscules uniquement si elle contient exactement 4 caractères, 
-- sinon garder la valeur d'origine.
SELECT
	CASE LENGTH(TRIM(ville))
		WHEN 4 THEN UPPER(TRIM(ville))
		ELSE ville
	END AS ville_maj
FROM coureurs;

-- Question 16 : Créer une colonne 'niveau'. Si le coureur a terminé et a 
-- un classement <= 5 alors afficher 'Elite', sinon afficher 'Terminé' ou 'Non fini'.
SELECT 
	CASE 
		WHEN a_fini = TRUE AND classement <= 5 THEN 'Elite'
		WHEN a_fini = TRUE THEN 'Terminé'
		ELSE 'Non fini'
	END AS niveau
FROM coureurs;

-- Question 17 : Afficher le nom_complet et le classement, mais remplace 
-- les NULL de classement par le texte 'Non classé'.
SELECT 
	nom_complet,
	classement,
	CASE
		WHEN classement IS NULL THEN 'Non classé'
		ELSE classement::VARCHAR(20)
	END AS classement
FROM coureurs;

SELECT 
	nom_complet,
	classement,
	CASE
		WHEN classement IS NULL THEN 'Non classé'
		ELSE CAST(classement AS VARCHAR(20))
	END AS classement
FROM coureurs;

-- Question 18 : Afficher les initiales 
-- (1er caractère du prénom + 1er caractère du nom) pour chaque coureur.
SELECT
	nom_complet,
	CONCAT(
		SUBSTRING(nom_complet, 1, 1),
		SUBSTRING(SPLIT_PART(nom_complet, ' ', 2), 1, 1)
	) AS initiales_prenom
FROM coureurs;

SELECT
	nom_complet,
	CONCAT(
		LEFT(nom_complet, 1),
		LEFT(SPLIT_PART(nom_complet, ' ', 2), 1)
	) AS initiales_prenom
FROM coureurs;

-- Question 19 : Créer un acronyme du nom de chaque ville en ne prenant que 
-- les trois premières lettres et les mettant en majuscule, et donner le nombre 
-- de coureurs pour chaque ville. Ne montrer que les villes qui ont au moins 
-- deux coureurs, et les mettre dans l'ordre décroissant de nombre de coureurs.
SELECT
	UPPER(LEFT(TRIM(ville), 3)) AS acronyme_ville,
	COUNT(*) AS nb_coureurs
FROM coureurs
GROUP BY ville
HAVING COUNT(*) >= 2
ORDER BY nb_coureurs DESC;

-- Question 20 : Créer trois colonnes booléennes qui disent si un coureur est 
-- Junior, Senior ou Veteran. Faire la requête de deux manières différentes.
SELECT
	categorie,
	CASE
		WHEN categorie LIKE 'Junior%' THEN TRUE
		ELSE FALSE
	END AS junior,
	CASE
		WHEN categorie LIKE 'Senior%' THEN TRUE
		ELSE FALSE
	END AS senior,
	CASE
		WHEN categorie LIKE 'Veteran%' THEN TRUE
		ELSE FALSE
	END AS veteran
FROM coureurs;

SELECT 
	categorie,
	categorie LIKE 'Junior%' AS junior,
	categorie LIKE 'Senior%' AS senior,
	categorie LIKE 'Veteran%' AS veteran
FROM coureurs;

-- Question 21 : Donner le total d'inscrits pour chaque catégorie
-- d'âge (Junior, Senior ou Veteran).
SELECT
	SPLIT_PART(categorie, ' ', 1) AS categorie_age,
	COUNT(*)
FROM coureurs
GROUP BY SPLIT_PART(categorie, ' ', 1);





