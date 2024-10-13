<?php
session_start();
include 'includes/db.php';

// Vérifie si l'utilisateur est connecté
if (!isset($_SESSION['user_id'])) {
    header("Location: connexion.php");
    exit();
}

// Récupère tous les utilisateurs
$stmt = $pdo->query("SELECT id, nom, prenom, pseudo FROM utilisateurs");
$utilisateurs = $stmt->fetchAll();
?>

<?php include 'includes/header.php'; ?>

<div class="container mx-auto mt-10">
    <h1 class="text-3xl font-bold">Utilisateurs</h1>

    <div class="mt-6 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <?php foreach ($utilisateurs as $user): ?>
            <div class="bg-white p-4 rounded-lg shadow-md flex flex-col">
                <h2 class="text-xl font-semibold"><?= htmlspecialchars($user['prenom'] . ' ' . $user['nom']) ?></h2>
                <p class="mb-4">Pseudo: <?= htmlspecialchars($user['pseudo']) ?></p>
                <div class="mt-auto">
                <a href="profil.php?id=<?= $user['id'] ?>" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-700 w-full text-center">Voir le profil</a>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</div>

<?php include 'includes/footer.php'; ?>
