<?
include "db.php";
include_once "class/Message.php";

if(isset($_SESSION['user_id'])){
    $message = new Message($pdo);
    if($message->findNonLu($_SESSION['user_id'])){
        $bandeau= "<marquee><a href=\"messagerie.php\">Vous avez des nouveaux messages</a></marquee>";
    }
}

?>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <title>Site de Rencontre</title>
</head>

<body class="bg-gray-100">

    <nav class="bg-white shadow">
        <div class="container mx-auto p-4 flex justify-between">
            <a href="index.php" class="text-lg font-semibold">Site de Rencontre</a>
            <div>
                <?php if (isset($_SESSION['user_id'])): ?>
                    <a href="messagerie.php" class="mr-4">Messagerie</a>
                    <a href="logout.php" class="text-red-500">Déconnexion</a>
                <?php else: ?>
                    <a href="connexion.php" class="mr-4">Connexion</a>
                    <a href="inscription.php" class="text-blue-500">Inscription</a>
                <?php endif; ?>
            </div>
        </div>
    </nav>
    <?=($bandeau) ?? ""?>
    <? include "menu.php" ?>