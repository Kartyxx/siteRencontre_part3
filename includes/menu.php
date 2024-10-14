<?php if (isset($_SESSION['user_id'])) { ?>
    <nav class="bg-gray-800 p-4">
        <ul class="flex space-x-4">
            <li><a href="index.php" class="text-white hover:bg-gray-700 px-3 py-2 rounded">Accueil</a></li>
            <li><a href="profil.php?id=<?= $_SESSION['user_id'] ?>" class="text-white hover:bg-gray-700 px-3 py-2 rounded">Mon Profil</a></li>
            <li><a href="recherche.php" class="text-white hover:bg-gray-700 px-3 py-2 rounded">Recerche</a></li>

         </ul>
    </nav>
    
    
<? } ?>