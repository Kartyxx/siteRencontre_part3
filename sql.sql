-- Création de la base de données
CREATE DATABASE site_rencontre;
USE site_rencontre;

-- Table des utilisateurs
CREATE TABLE utilisateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    pseudo VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    genre ENUM('Homme', 'Femme', 'Autre') NOT NULL,
    preference ENUM('Homme', 'Femme', 'Autre', 'Tous') NOT NULL,
    bio TEXT,
    localisation VARCHAR(100),
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des correspondances (matchs)
CREATE TABLE correspondances (
    id INT AUTO_INCREMENT PRIMARY KEY,
    utilisateur_id1 INT NOT NULL,
    utilisateur_id2 INT NOT NULL,
    date_match TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (utilisateur_id1) REFERENCES utilisateurs(id),
    FOREIGN KEY (utilisateur_id2) REFERENCES utilisateurs(id),
    UNIQUE (utilisateur_id1, utilisateur_id2)
);

-- Table des messages
CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    expediteur_id INT NOT NULL,
    destinataire_id INT NOT NULL,
    contenu TEXT NOT NULL,
    date_envoi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (expediteur_id) REFERENCES utilisateurs(id),
    FOREIGN KEY (destinataire_id) REFERENCES utilisateurs(id)
);

-- Jeu d'essai pour 30 utilisateurs
/*INSERT INTO utilisateurs (nom, prenom, pseudo, email, mot_de_passe, age, genre, preference, bio, localisation) VALUES
('Dupont', 'Jean', 'jean_01', 'jean01@example.com', 'mdp1', 25, 'Homme', 'Femme', 'Aime le cinéma et les randonnées', 'Paris'),
('Durand', 'Marie', 'marie_02', 'marie02@example.com', 'mdp2', 28, 'Femme', 'Homme', 'Fan de musique et de voyages', 'Lyon'),
('Lemoine', 'Paul', 'paul_03', 'paul03@example.com', 'mdp3', 22, 'Homme', 'Femme', 'Joueur de foot amateur', 'Marseille'),
('Martin', 'Julie', 'julie_04', 'julie04@example.com', 'mdp4', 26, 'Femme', 'Homme', 'Passionnée de lecture', 'Bordeaux'),
('Bernard', 'Luc', 'luc_05', 'luc05@example.com', 'mdp5', 30, 'Homme', 'Femme', 'Amateur de cuisine', 'Toulouse'),
('Simon', 'Alice', 'alice_06', 'alice06@example.com', 'mdp6', 24, 'Femme', 'Homme', 'Sportive et aimant la nature', 'Nice'),
('Petit', 'Maxime', 'max_07', 'max07@example.com', 'mdp7', 27, 'Homme', 'Tous', 'Curieux et ouvert d’esprit', 'Nantes'),
('Girard', 'Clara', 'clara_08', 'clara08@example.com', 'mdp8', 29, 'Femme', 'Homme', 'Fan de théâtre et de danse', 'Lille'),
('Moreau', 'Hugo', 'hugo_09', 'hugo09@example.com', 'mdp9', 31, 'Homme', 'Femme', 'Geek et joueur de jeux vidéo', 'Strasbourg'),
('Roux', 'Sophie', 'sophie_10', 'sophie10@example.com', 'mdp10', 23, 'Femme', 'Homme', 'Photographe amatrice', 'Rennes'),
('Leclerc', 'Élise', 'elise_11', 'elise11@example.com', 'mdp11', 32, 'Femme', 'Homme', 'Voyageuse invétérée', 'Nice'),
('Perrin', 'Antoine', 'antoine_12', 'antoine12@example.com', 'mdp12', 29, 'Homme', 'Femme', 'Cinéphile passionné', 'Paris'),
('Blanc', 'Lucas', 'lucas_13', 'lucas13@example.com', 'mdp13', 24, 'Homme', 'Tous', 'Amoureux de la nature et des randonnées', 'Grenoble'),
('Gautier', 'Emma', 'emma_14', 'emma14@example.com', 'mdp14', 27, 'Femme', 'Homme', 'Collectionneuse d’art', 'Lyon'),
('Masson', 'Léo', 'leo_15', 'leo15@example.com', 'mdp15', 25, 'Homme', 'Femme', 'Musicien amateur', 'Toulon'),
('Fabre', 'Chloé', 'chloe_16', 'chloe16@example.com', 'mdp16', 26, 'Femme', 'Homme', 'Gourmande et cuisinière', 'Dijon'),
('Olivier', 'Nathan', 'nathan_17', 'nathan17@example.com', 'mdp17', 30, 'Homme', 'Femme', 'Photographe', 'Montpellier'),
('Martinez', 'Lucie', 'lucie_18', 'lucie18@example.com', 'mdp18', 22, 'Femme', 'Homme', 'Yoga et méditation', 'Lille'),
('Perez', 'Thomas', 'thomas_19', 'thomas19@example.com', 'mdp19', 28, 'Homme', 'Tous', 'Globe-trotter', 'Brest'),
('Giraud', 'Sarah', 'sarah_20', 'sarah20@example.com', 'mdp20', 23, 'Femme', 'Homme', 'Fashionista', 'Tours'),
('Renard', 'Victor', 'victor_21', 'victor21@example.com', 'mdp21', 24, 'Homme', 'Femme', 'DJ amateur', 'Nice'),
('Morel', 'Anaïs', 'anais_22', 'anais22@example.com', 'mdp22', 29, 'Femme', 'Homme', 'Sportive, aime le vélo', 'Marseille'),
('Leroux', 'Mathieu', 'mathieu_23', 'mathieu23@example.com', 'mdp23', 26, 'Homme', 'Femme', 'Passionné d’automobile', 'Nantes'),
('Dupuis', 'Camille', 'camille_24', 'camille24@example.com', 'mdp24', 31, 'Femme', 'Homme', 'Voyageuse et photographe', 'Strasbourg'),
('Chevalier', 'Damien', 'damien_25', 'damien25@example.com', 'mdp25', 28, 'Homme', 'Femme', 'Artiste', 'Paris'),
('Adam', 'Florence', 'florence_26', 'florence26@example.com', 'mdp26', 27, 'Femme', 'Homme', 'Écrivain amateur', 'Bordeaux'),
('Schmidt', 'Benoît', 'benoit_27', 'benoit27@example.com', 'mdp27', 30, 'Homme', 'Femme', 'Passionné de nouvelles technologies', 'Lyon'),
('Lemoine', 'Inès', 'ines_28', 'ines28@example.com', 'mdp28', 25, 'Femme', 'Homme', 'Musicienne', 'Lille'),
('Carpentier', 'Julien', 'julien_29', 'julien29@example.com', 'mdp29', 24, 'Homme', 'Femme', 'Cinéphile', 'Paris'),
('Legrand', 'Élodie', 'elodie_30', 'elodie30@example.com', 'mdp30', 26, 'Femme', 'Homme', 'Danseuse amatrice', 'Nice');
*/

INSERT INTO `utilisateurs` (`id`, `nom`, `prenom`, `pseudo`, `email`, `mot_de_passe`, `date_naissance`, `genre`, `preference`, `bio`, `localisation`, `date_inscription`) VALUES
(1, 'Dupont', 'Jean', 'jean_01', 'jean01@example.com', '$2y$10$c58a9PiPYWWSaZy8YWpqR.8FaGJOaasap0VPeNdx8MpZvJ2uBFvfa', '1999-01-01', 'Homme', 'Femme', 'Aime le cinéma et les randonnées', 'Paris', '2024-10-14 09:12:49'),
(2, 'Durand', 'Marie', 'marie_02', 'marie02@example.com', '$2y$10$Yx2X0VhF2KABJxE7qwJ1aORozR1c.cNb731xwGJbMmvTCazvA/JCu', '1996-01-01', 'Femme', 'Homme', 'Fan de musique et de voyages', 'Lyon', '2024-10-14 09:12:49'),
(3, 'Lemoine', 'Paul', 'paul_03', 'paul03@example.com', '$2y$10$dCLKBKwrb8LvmDP6S9k...ghoMx7DTOOexBAyMYVByiSQECv71mwi', '2002-01-01', 'Homme', 'Femme', 'Joueur de foot amateur', 'Marseille', '2024-10-14 09:12:49'),
(4, 'Martin', 'Julie', 'julie_04', 'julie04@example.com', '$2y$10$02AWF1LMHJdJcW6A9VkymO4hLW4RO3.F3AMj7IPMZg3L1amAHECQG', '1998-01-01', 'Femme', 'Homme', 'Passionnée de lecture', 'Bordeaux', '2024-10-14 09:12:49'),
(5, 'Bernard', 'Luc', 'luc_05', 'luc05@example.com', '$2y$10$pph21jpYsjr3W7IzQQ.QSODaC90TP1CWSMzbZSRYOgo4djHLhDVIC', '1994-01-01', 'Homme', 'Femme', 'Amateur de cuisine', 'Toulouse', '2024-10-14 09:12:49'),
(6, 'Simon', 'Alice', 'alice_06', 'alice06@example.com', '$2y$10$AYdjlIayjKgagAXDrBUluOA21/5kZIYqRhZMcgDa.o4YoiPOr3wY2', '2000-01-01', 'Femme', 'Homme', 'Sportive et aimant la nature', 'Nice', '2024-10-14 09:12:49'),
(7, 'Petit', 'Maxime', 'max_07', 'max07@example.com', '$2y$10$pLpN6sLtn8crMLAEy7OLx.1NtX7jX5SkZUBbvkPVeHVUSCQxAWJ8q', '1997-01-01', 'Homme', 'Tous', 'Curieux et ouvert d’esprit', 'Nantes', '2024-10-14 09:12:49'),
(8, 'Girard', 'Clara', 'clara_08', 'clara08@example.com', '$2y$10$AaHQN/tHIVXnw4jFSmlsEOmgwmeKrgh66ZSKMd7EcrFtRKtX8LlLC', '1995-01-01', 'Femme', 'Homme', 'Fan de théâtre et de danse', 'Lille', '2024-10-14 09:12:49'),
(9, 'Moreau', 'Hugo', 'hugo_09', 'hugo09@example.com', '$2y$10$GaScBkF4whnsBcC7GqeIoe1bXyJRz32.h1AliXFTMQYF/i0LCPkoW', '1993-01-01', 'Homme', 'Femme', 'Geek et joueur de jeux vidéo', 'Strasbourg', '2024-10-14 09:12:49'),
(10, 'Roux', 'Sophie', 'sophie_10', 'sophie10@example.com', '$2y$10$.yX9fYAJQtfeddwrlY1XR.TAg.tPIwQSGR7I3ire3jsm64ZO5mD5e', '2001-01-01', 'Femme', 'Homme', 'Photographe amatrice', 'Rennes', '2024-10-14 09:12:49'),
(11, 'Leclerc', 'Élise', 'elise_11', 'elise11@example.com', '$2y$10$Pgi92Vocv9bgkEVKee0NI.D3w1tgGHiUjjiDZ21WLBho5jsy98p0u', '1992-01-01', 'Femme', 'Homme', 'Voyageuse invétérée', 'Nice', '2024-10-14 09:12:49'),
(12, 'Perrin', 'Antoine', 'antoine_12', 'antoine12@example.com', '$2y$10$RbgufoOIlsNeu1nUhSfNF.rQx8OI9pb9IH6qLKe1oFhmBlg9oJTmq', '1995-01-01', 'Homme', 'Femme', 'Cinéphile passionné', 'Paris', '2024-10-14 09:12:49'),
(13, 'Blanc', 'Lucas', 'lucas_13', 'lucas13@example.com', '$2y$10$uZL1Y13ytLeDjE4TEf51MessuJvRCumCt9W/WvPnpkR/zJI3xK2sy', '2000-01-01', 'Homme', 'Tous', 'Amoureux de la nature et des randonnées', 'Grenoble', '2024-10-14 09:12:49'),
(14, 'Gautier', 'Emma', 'emma_14', 'emma14@example.com', '$2y$10$y09jZPfncct6wAB9A85jRee.LEwsFEBqNcSQPZy1NAQhJnRZdkrfy', '1997-01-01', 'Femme', 'Homme', 'Collectionneuse d’art', 'Lyon', '2024-10-14 09:12:49'),
(15, 'Masson', 'Léo', 'leo_15', 'leo15@example.com', '$2y$10$NYIcE8M5IEM64.WcYUgYcudUJUDymxik9ajaVNyz7b.LX16Sb.3vu', '1999-01-01', 'Homme', 'Femme', 'Musicien amateur', 'Toulon', '2024-10-14 09:12:49'),
(16, 'Fabre', 'Chloé', 'chloe_16', 'chloe16@example.com', '$2y$10$au9vWQR3pUwCjO66ZM.dxexIIN9eTb2WrAlRQ03A3QrDYpAv2rYLW', '1998-01-01', 'Femme', 'Homme', 'Gourmande et cuisinière', 'Dijon', '2024-10-14 09:12:49'),
(17, 'Olivier', 'Nathan', 'nathan_17', 'nathan17@example.com', '$2y$10$vgnwBnXmVrxgKKUfxXi7meRMPlfgB06pCc5ElDFToWxX8TcAZ7ojq', '1994-01-01', 'Homme', 'Femme', 'Photographe', 'Montpellier', '2024-10-14 09:12:49'),
(18, 'Martinez', 'Lucie', 'lucie_18', 'lucie18@example.com', '$2y$10$ldDcuoPwO/sxA9zPu2Osl.9lgCQP7dOISTAQl/Jww.2dyGhhokp8S', '2002-01-01', 'Femme', 'Homme', 'Yoga et méditation', 'Lille', '2024-10-14 09:12:49'),
(19, 'Perez', 'Thomas', 'thomas_19', 'thomas19@example.com', '$2y$10$9.pZV0Lu2.lhAUUH3JUWxeF.eXw7eSRhM3/IQwx61DsCrHmutuu1G', '1996-01-01', 'Homme', 'Tous', 'Globe-trotter', 'Brest', '2024-10-14 09:12:49'),
(20, 'Giraud', 'Sarah', 'sarah_20', 'sarah20@example.com', '$2y$10$9GCwm00hkij0FwD7pNOp4efJzU6BYAT8MXiV1bLbH4kB7j17jzT.e', '2001-01-01', 'Femme', 'Homme', 'Fashionista', 'Tours', '2024-10-14 09:12:49'),
(21, 'Renard', 'Victor', 'victor_21', 'victor21@example.com', '$2y$10$x0KgI5tN5zWiQm.3aY/SdecJaUt3a3ijoBk3DgDxvmfsVYeejsKJm', '2000-01-01', 'Homme', 'Femme', 'DJ amateur', 'Nice', '2024-10-14 09:12:49'),
(22, 'Morel', 'Anaïs', 'anais_22', 'anais22@example.com', '$2y$10$/tEulXX3A2qNfAlPebXyse5iVgjF.I0Fkw/DBB4923/ZB.iLeTm/.', '1995-01-01', 'Femme', 'Homme', 'Sportive, aime le vélo', 'Marseille', '2024-10-14 09:12:49'),
(23, 'Leroux', 'Mathieu', 'mathieu_23', 'mathieu23@example.com', '$2y$10$hgkut8ChqsY4SubvePeKYulAik4kROhwUO0EmATLzFvdBN3DCk5Bq', '1998-01-01', 'Homme', 'Femme', 'Passionné d’automobile', 'Nantes', '2024-10-14 09:12:49'),
(24, 'Dupuis', 'Camille', 'camille_24', 'camille24@example.com', '$2y$10$zSSATJu92zXDHoXRox0doeYZPsDPpW/z/rQjPJ6G/YOT.iR789iF6', '1993-01-01', 'Femme', 'Homme', 'Voyageuse et photographe', 'Strasbourg', '2024-10-14 09:12:49'),
(25, 'Chevalier', 'Damien', 'damien_25', 'damien25@example.com', '$2y$10$8WICDXWEw.mcrq.SB0YDguDvmNw3sF2//FTpSUK6Wa1Ic9k7LR/ke', '1996-01-01', 'Homme', 'Femme', 'Artiste', 'Paris', '2024-10-14 09:12:49'),
(26, 'Adam', 'Florence', 'florence_26', 'florence26@example.com', '$2y$10$chOeliHIH3OyQ73VZJEfq.1FFRCbHfCUzjnraTqBeNkW8Bg9yMHz2', '1997-01-01', 'Femme', 'Homme', 'Écrivain amateur', 'Bordeaux', '2024-10-14 09:12:49'),
(27, 'Schmidt', 'Benoît', 'benoit_27', 'benoit27@example.com', '$2y$10$T6VxA9SKhnDlmBZGD2U11uz3rF20qai4o5VHZIeFz8yfRe6mHrnD6', '1994-01-01', 'Homme', 'Femme', 'Passionné de nouvelles technologies', 'Lyon', '2024-10-14 09:12:49'),
(28, 'Lemoine', 'Inès', 'ines_28', 'ines28@example.com', '$2y$10$2LTEPpBbsll13r4jZMoJHujGaKkF9w4ZD0eZrZDAsSAUHEdIhy.cG', '1999-01-01', 'Femme', 'Homme', 'Musicienne', 'Lille', '2024-10-14 09:12:49'),
(29, 'Carpentier', 'Julien', 'julien_29', 'julien29@example.com', '$2y$10$S8ju.Ay/EAHJE7R1m.liceXFetiEmEwzAx7KFK7j0FBA5A.SKgJ2S', '2000-01-01', 'Homme', 'Femme', 'Cinéphile', 'Paris', '2024-10-14 09:12:49'),
(30, 'Legrand', 'Élodie', 'elodie_30', 'elodie30@example.com', '$2y$10$pBNKHwFQebphzWgrwNGaiOilWRV3foLN27TuJX4PxRk5zopS10t1W', '1998-01-01', 'Femme', 'Homme', 'Danseuse amatrice', 'Nice', '2024-10-14 09:12:49');


/*Remplacer l'age par une date de naissance*/
ALTER TABLE `utilisateurs` ADD `date_naissance` DATE NULL AFTER `age`; 
update utilisateurs set date_naissance=concat(2024-age,"-01-01"); 
ALTER TABLE `utilisateurs` DROP `age`; 

ALTER TABLE `messages` ADD `lu` BOOLEAN NOT NULL AFTER `date_envoi`; 
