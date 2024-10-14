<?php
include 'includes/db.php';
include 'class/Utilisateur.php';
include 'class/Compteur.php'; // Inclure la classe Utilisateur
session_start();

// Création d'une instance de la classe Utilisateur
$utilisateur = new Utilisateur($pdo);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $erreur = "";
    $email = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);
    $mot_de_passe = $_POST['mot_de_passe'];

    if ($email === false) {
        $erreur = "Adresse e-mail invalide!";
    } elseif (empty($mot_de_passe)) {
        $erreur = "Le mot de passe ne peut pas être vide!";
    } else {

        $user = $utilisateur->seConnecter($email, $mot_de_passe);
        if($user!=null){
            $_SESSION['user_id'] = $user['id'];
            Compteur::incrementer();
            header('Location: index.php');
            exit(); // Utilisez exit() après header() pour arrêter l'exécution du script
        }else{
            $erreur = "Identifiants incorrects";
        }
    }
}
?>

<?php include 'includes/header.php'; ?>

<div class="container mx-auto mt-10 max-w-lg">
    <h2 class="text-2xl font-bold text-center">Connexion</h2>
    <form action="connexion.php" method="post" class="mt-4 bg-white p-6 rounded-lg shadow-md">
        <input type="email" name="email" placeholder="Email" class="border p-2 w-full mb-4" required>
        <input type="password" name="mot_de_passe" placeholder="Mot de passe" class="border p-2 w-full mb-4" required>
        <button type="submit" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-700 w-full">Se connecter</button>
        <?php if (isset($erreur)): ?>
            <p class="text-red-500 mt-2"><?= htmlspecialchars($erreur) ?></p> <!-- Utilisez htmlspecialchars pour éviter les injections XSS -->
        <?php endif; ?>
    </form>
</div>

<?php include 'includes/footer.php'; ?>
