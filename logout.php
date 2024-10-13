<?php
include "class/Compteur.php";

session_start();

// Détruire toutes les sessions
$_SESSION = array();
session_destroy();

// Rediriger vers la page d'accueil
header("Location: index.php");
exit();
?>
