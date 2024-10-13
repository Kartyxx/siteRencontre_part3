<?php
include 'includes/db.php';
include 'class/Message.php';
include 'class/Utilisateur.php';

session_start();

if (!isset($_SESSION['user_id'])) {
    header('Location: connexion.php');
    exit;
}

$user_id = $_SESSION['user_id'];
$destinataire_id = null;

if(isset($_GET["destinataire_id"])){
    $destinataire_id = $_GET["destinataire_id"];
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $destinataire_id = $_POST['destinataire_id'];
    $message = $_POST['message'];

    $nouveauMessage = new Message($pdo,null,$user_id,$destinataire_id,$message);
    $nouveauMessage->envoyer();
    $nouveauMessage=null;
}

$mesMessages = new Message($pdo);
if($destinataire_id==null){
    $messages_list = $mesMessages->recupererMesMessages($user_id);
}else{
    $messages_list = $mesMessages->recupererMesConversations($user_id, $destinataire_id);
}
$mesMessages=null;

//ListeDéroulante
$utilisateurs = new Utilisateur($pdo);
$utilisateursList = $utilisateurs->getUtilisateursSaufMoi($user_id);
$utilisateurs=null;
?>

<?php include 'includes/header.php'; ?>

<div class="container mx-auto mt-10">
    <h2 class="text-2xl font-bold">Messagerie</h2>

    <form action="messagerie.php" method="post" class="mt-4">
        <select name="destinataire_id" class="border p-2 w-full mb-4">
            <!-- Liste des utilisateurs avec lesquels échanger des messages -->
            <?php
            foreach($utilisateursList as $user){
                if($destinataire_id==$user['id']){
                    echo "<option selected=\"selected\" value='{$user['id']}'>{$user['pseudo']}</option>";
                }else{
                    echo "<option value='{$user['id']}'>{$user['pseudo']}</option>";
                }
            }
            ?>
        </select>
        <textarea name="message" placeholder="Votre message" class="border p-2 w-full mb-4"></textarea>
        <button type="submit" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-700 w-full">Envoyer</button>
    </form>

    <div class="mt-6 bg-white p-6 rounded-lg shadow-md">
        <h3 class="text-xl font-semibold mb-4">Vos messages</h3>
        <?php foreach ($messages_list as $message): ?>
            <p><strong><?= $message['expediteur_id'] == $user_id ? "Moi" : $message['pseudo'] ?>:</strong> <?= $message['contenu'] ?></p>
        <?php endforeach; ?>
    </div>
</div>

<?php include 'includes/footer.php'; ?>
