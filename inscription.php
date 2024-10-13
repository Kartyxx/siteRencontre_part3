<?php
include 'includes/db.php';
include 'class/Utilisateur.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nom = $_POST['nom'];
    $prenom = $_POST['prenom'];
    $pseudo = $_POST['pseudo'];
    $email = $_POST['email'];
    $mot_de_passe = password_hash($_POST['mot_de_passe'], PASSWORD_DEFAULT);
    $date_naissance = $_POST['date_naissance'];
    $genre = $_POST['genre'];
    $preference = $_POST['preference'];
    $bio = $_POST['bio'];
    $localisation = $_POST['localisation'];

    $utilisateur_non_inscrit = new Utilisateur(
        $pdo,
        null,
        $nom,
        $prenom,
        $pseudo,
        $email,
        $mot_de_passe,
        $date_naissance,
        $genre,
        $preference,
        $bio,
        $localisation,
        null
    );

    if ($utilisateur_non_inscrit->sInscrire()) {
        header('Location: connexion.php');
    } else {
        $erreur = "Une erreur est survenue lors de l'inscription";
    }
}
?>

<?php include 'includes/header.php'; ?>

<div class="container mx-auto mt-10 max-w-lg">
    <?php if (isset($erreur)){ ?>
        <p class="text-red-500 mt-2"><?= htmlspecialchars($erreur) ?></p> <!-- Utilisez htmlspecialchars pour éviter les injections XSS -->
    <?php } ?>
    <h2 class="text-2xl font-bold text-center">Inscription</h2>
    <form action="inscription.php" method="post" class="mt-4 bg-white p-6 rounded-lg shadow-md">
        <input type="text" name="nom" placeholder="Nom" class="border p-2 w-full mb-4" required>
        <input type="text" name="prenom" placeholder="Prénom" class="border p-2 w-full mb-4" required>
        <input type="text" name="pseudo" placeholder="Pseudo" class="border p-2 w-full mb-4" required>
        <input type="email" name="email" placeholder="Email" class="border p-2 w-full mb-4" required>
        <input type="password" name="mot_de_passe" placeholder="Mot de passe" class="border p-2 w-full mb-4" required>
        Date de naissance : <input type="date" name="date_naissance" class="border p-2 w-full mb-4" required>
        Vous êtes : <select name="genre" class="border p-2 w-full mb-4">
            <option value="Homme">Homme</option>
            <option value="Femme">Femme</option>
            <option value="Autre">Autre</option>
        </select>
        Vous recherchez  : <select name="preference" class="border p-2 w-full mb-4">
            <option value="Homme">Homme</option>
            <option value="Femme">Femme</option>
            <option value="Tous">Tous</option>
        </select>
        <textarea name="bio" placeholder="Votre bio" class="border p-2 w-full mb-4"></textarea>
        <input type="text" name="localisation" placeholder="Localisation" class="border p-2 w-full mb-4">
        <button type="submit" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-700 w-full">S'inscrire</button>
    </form>
</div>

<?php include 'includes/footer.php'; ?>