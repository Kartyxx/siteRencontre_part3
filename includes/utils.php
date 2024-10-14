<?php

function dateAjd() {

    $date = date('l, d F Y');
    return $date;  

}

function nomPrenom($id,$pdo) {

    $utilisateur1 = new Utilisateur($pdo);
    $pseudo = $utilisateur1->getPseudoById($id);
    return $pseudo;
    }

?>

