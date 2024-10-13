<?php
session_start();
include 'includes/db.php';

// Vérifie si l'utilisateur est connecté
if (!isset($_SESSION['user_id'])) {
    header("Location: connexion.php");
    exit();
}

// Vérifie si l'identifiant de l'utilisateur est fourni
if (!isset($_GET['id'])) {
    header("Location: index.php");
    exit();
}

// Récupère l'utilisateur par son ID
$user_id = intval($_GET['id']);
$stmt = $pdo->prepare("SELECT nom, prenom, pseudo, email, bio FROM utilisateurs WHERE id = ?");
$stmt->execute([$user_id]);
$user = $stmt->fetch();

if (!$user) {
    header("Location: index.php");
    exit();
}
?>

<?php include 'includes/header.php'; ?>

<div class="container mx-auto mt-10">
    <h1 class="text-3xl font-bold"><?= htmlspecialchars($user['prenom'] . ' ' . $user['nom']) ?></h1>
    <p>Pseudo: <?= htmlspecialchars($user['pseudo']) ?></p>
    <p>Email: <?= htmlspecialchars($user['email']) ?></p>

    <div class="mt-4">
        <a href="messagerie.php?destinataire_id=<?= $user_id ?>" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-700">Envoyer un message</a>
    </div>

    </form>
</div>

<?php include 'includes/footer.php'; ?>