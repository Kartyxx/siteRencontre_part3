<?php
session_start();
include 'includes/db.php';

// Vérifie si l'utilisateur est connecté
if (!isset($_SESSION['user_id'])) {
    header("Location: connexion.php");
    exit();
}

$utilisateurs = [];

// Si le formulaire est soumis, récupère les critères de recherche
if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['recherche'])) {

    //?? null : Cet opérateur de coalescence nulle vérifie si $_GET['age'] est défini et non null. 
    //Si c'est le cas, il retourne la valeur de $_GET['age']. 
    //Sinon, il retourne la valeur par défaut null.
    $age = $_GET['age'] ?? null;
    $genre = $_GET['genre'] ?? null;
    $localisation = $_GET['localisation'] ?? null;

    $date = new DateTime();


if($age){
    $date->modify("-$age years");
    $dateNaiss = $date->format("Y-m-d");
    $dateNaissTObject = new DateTime($dateNaiss);
    $dateNaissT = $dateNaissTObject->modify('-1 year');
    $dateNaissT =$dateNaissT->format("Y-m-d");

}

    $query = "SELECT id, nom, prenom, pseudo, localisation, date_naissance from utilisateurs WHERE 1=1 ";

    if ($genre){
        $query=$query."and genre = :genre ";
    }
    if($localisation){
        $query=$query."and localisation like :localisation ";
    }
    if($age){
        $query=$query."and date_naissance < :dateNaiss and date_naissance > :dateNaissT ";
    }

    $stmt = $pdo->prepare($query);     //préparation de la requete

    if ($genre){
        $stmt->bindParam(':genre', $genre, PDO::PARAM_STR);
    }
    if($localisation){
        $stmt->bindParam(':localisation', $localisation,  PDO::PARAM_STR);
    }
    if($age){
        $stmt->bindParam(':dateNaiss', $dateNaiss);
        $stmt->bindParam(':dateNaissT', $dateNaissT);
    }


    $stmt->execute();

    $utilisateurs = $stmt->fetchAll();
}
?>

<?php include 'includes/header.php'; ?>

<div class="container mx-auto mt-10">
    <h1 class="text-3xl font-bold">Recherche d'utilisateurs</h1>

    <form action="recherche.php" method="get" class="mt-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div>
                <label for="age" class="block text-sm font-medium">Âge</label>
                <input type="number" name="age" id="age" class="border p-2 w-full" placeholder="Ex: 25">
            </div>
            <div>
                <label for="genre" class="block text-sm font-medium">Genre</label>
                <select name="genre" id="genre" class="border p-2 w-full">
                    <option value="">Tous</option>
                    <option value="Homme">Homme</option>
                    <option value="Femme">Femme</option>
                    <option value="Autre">Autre</option>
                </select>
            </div>
            <div>
                <label for="localisation" class="block text-sm font-medium" >Localisation</label>
                <input type="text" name="localisation" id="localisation" class="border p-2 w-full" placeholder="Ex: Paris">
            </div>
        </div>

        <button type="submit" name="recherche" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-700 mt-4">Rechercher</button>
    </form>

    <div class="mt-6 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <?php if ($utilisateurs): ?>
            <?php foreach ($utilisateurs as $user): ?>
                <div class="bg-white p-4 rounded-lg shadow-md flex flex-col">
                    <h2 class="text-xl font-semibold"><?= htmlspecialchars($user['prenom'] . ' ' . $user['nom']) ?></h2>
                    <p class="">Pseudo: <?= htmlspecialchars($user['pseudo']) ?></p>
                    <p class="">Date de naissance: <?= htmlspecialchars($user['date_naissance']) ?></p>
                    <p class="">localisation: <?= htmlspecialchars($user['localisation']) ?></p>

                    <div class="mt-5">
                        <a href="profil.php?id=<?= $user['id'] ?>" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-700 w-full text-center">Voir le profil</a>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <p class="text-gray-500 mt-4">Aucun utilisateur trouvé avec ces critères.</p>
        <?php endif; ?>
    </div>
</div>

<?php include 'includes/footer.php'; ?>
