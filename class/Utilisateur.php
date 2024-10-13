<?php
class Utilisateur
{
    private $pdo;
    private $id;
    private $nom;
    private $prenom;
    private $pseudo;
    private $email;
    private $motDePasse;
    private $date_naissance;
    private $genre;
    private $preference;
    private $bio;
    private $localisation;
    private $dateInscription;

    public function __construct($pdo, $id = null, $nom = null, $prenom = null, $pseudo = null, $email = null, $motDePasse = null, $date_naissance = null, $genre = null, $preference = null, $bio = null, $localisation = null, $dateInscription = null)
    {
        $this->pdo = $pdo; // Stocke l'instance PDO
        $this->id = $id;
        $this->nom = $nom;
        $this->prenom = $prenom;
        $this->pseudo = $pseudo;
        $this->email = $email;
        $this->motDePasse = $motDePasse;
        $this->date_naissance = $date_naissance;
        $this->genre = $genre;
        $this->preference = $preference;
        $this->bio = $bio;
        $this->localisation = $localisation;
        $this->dateInscription = $dateInscription;
    }

    // Vérifie si un utilisateur avec cet e-mail existe et renvoie ses informations
    public function trouverParEmail($email)
    {
        $stmt = $this->pdo->prepare("SELECT * FROM utilisateurs WHERE email = :email");
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->execute();
        $utilisateur = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($utilisateur) {
            $this->id = $utilisateur['id'];
            $this->email = $utilisateur['email'];
            $this->motDePasse = $utilisateur['mot_de_passe'];
            return $utilisateur;
        }
        return false;
    }

    // Vérifie si le mot de passe est correct
    public function verifierMotDePasse($mot_de_passe)
    {
        return password_verify($mot_de_passe, $this->motDePasse);
    }

    // Retourne l'ID de l'utilisateur connecté
    public function getId()
    {
        return $this->id;
    }

    // Méthodes de la classe Utilisateur
    public function inscription()
    {
        $stmt = $this->pdo->prepare("INSERT INTO utilisateurs (nom, prenom, pseudo, email, mot_de_passe, date_naissance, genre, preference, bio, localisation) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bindParam(':nom', $this->nom, PDO::PARAM_STR);
        $stmt->bindParam(':prenom', $this->prenom, PDO::PARAM_STR);
        $stmt->bindParam(':pseudo', $this->pseudo, PDO::PARAM_STR);
        $stmt->bindParam(':email', $this->email, PDO::PARAM_STR);
        $stmt->bindParam(':mot_de_passe', password_hash($this->motDePasse, PASSWORD_DEFAULT), PDO::PARAM_STR);
        $stmt->bindParam(':date_naissance', $this->date_naissance, PDO::PARAM_INT);
        $stmt->bindParam(':genre', $this->genre, PDO::PARAM_STR);
        $stmt->bindParam(':preference', $this->preference, PDO::PARAM_STR);
        $stmt->bindParam(':bio', $this->bio, PDO::PARAM_STR);
        $stmt->bindParam(':localisation', $this->localisation, PDO::PARAM_STR);

        // Exécuter la requête
        $stmt->execute();
    }

    public function connexion($email, $motDePasse)
    {
        $stmt = $this->pdo->prepare("SELECT * FROM utilisateurs WHERE email = :email");
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->execute();
        $user = $stmt->fetch();

        if ($user && password_verify($motDePasse, $user['mot_de_passe'])) {
            return $user['id']; // Retourne l'ID utilisateur si la connexion est réussie
        }
        return false; // Identifiants incorrects
    }

    public function seConnecter($email, $mot_de_passe)
    {
        $stmt = $this->pdo->prepare("SELECT * FROM utilisateurs WHERE email = :email");
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->execute();
        $user = $stmt->fetch();

        //Si l'email existe et que le mot de passe correspond, on est loggué et redirigé avec la page index
        if ($user && password_verify($mot_de_passe, $user['mot_de_passe'])) {
            return $user;
        }
        return null;
    }

    public function sInscrire() 
    {
        $stmt = $this->pdo->prepare("INSERT INTO utilisateurs (nom, prenom, pseudo, email, mot_de_passe, date_naissance, genre, preference, bio, localisation) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $isOk = $stmt->execute([
            $this->nom,
            $this->prenom,
            $this->pseudo,
            $this->email,
            $this->motDePasse,
            $this->date_naissance,
            $this->genre,
            $this->preference,
            $this->bio,
            $this->localisation
        ]);

        return $isOk;
    }

    public function getUtilisateursSaufMoi($idUser){
        $stmt = $this->pdo->prepare("SELECT * FROM utilisateurs WHERE id != :id");
        $stmt->bindParam(':id', $idUser, PDO::PARAM_INT);
        $stmt->execute();
        $users = $stmt->fetchAll();
        return $users;

    }

    // Vérifie si un utilisateur avec cet e-mail existe et renvoie ses informations
    public function getById($id)
    {
        $stmt = $this->pdo->prepare("SELECT * FROM utilisateurs WHERE id = :id");
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
        $utilisateur = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($utilisateur) {
            $this->id = $utilisateur['id'];
            $this->email = $utilisateur['email'];
            $this->motDePasse = $utilisateur['mot_de_passe'];
            return $utilisateur;
        }
        return false;
    }
}
?>