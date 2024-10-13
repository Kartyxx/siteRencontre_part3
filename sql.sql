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
INSERT INTO utilisateurs (nom, prenom, pseudo, email, mot_de_passe, age, genre, preference, bio, localisation) VALUES
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


/*Remplacer l'age par une date de naissance*/
ALTER TABLE `utilisateurs` ADD `date_naissance` DATE NULL AFTER `age`; 
update utilisateurs set date_naissance=concat(2024-age,"-01-01"); 
ALTER TABLE `utilisateurs` DROP `age`; 

ALTER TABLE `messages` ADD `lu` BOOLEAN NOT NULL AFTER `date_envoi`; 
