<?

class Message {
    private $pdo;
    private $id;
    private $expediteurId;
    private $destinataireId;
    private $contenu;
    private $dateEnvoi;
    private $lu;

    public function __construct($pdo,$id=null, $expediteurId=null, $destinataireId=null, $contenu=null, $dateEnvoi=null, $lu=0) {
        $this->pdo= $pdo;
        $this->id = $id;
        $this->expediteurId = $expediteurId;
        $this->destinataireId = $destinataireId;
        $this->contenu = $contenu;
        $this->dateEnvoi = $dateEnvoi;
        $this->lu = $lu;
    }

    // Méthode pour envoyer un message
    public function envoyer() {
        $stmt = $this->pdo->prepare("INSERT INTO messages (expediteur_id, destinataire_id, contenu) VALUES (?, ?, ?)");
        $stmt->execute([$this->expediteurId, $this->destinataireId, $this->contenu]);
    }

    // Méthode pour récupérer les messages
    public function recupererMesMessages($utilisateurId) {
        $stmt = $this->pdo->prepare("SELECT * FROM messages as mess INNER JOIN utilisateurs ON mess.expediteur_id = utilisateurs.id WHERE expediteur_id = ? OR destinataire_id = ? ORDER BY mess.id DESC");
        $stmt->execute([$utilisateurId, $utilisateurId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function recupererMesConversations($utilisateurId, $destinataire_id) {
        $stmt = $this->pdo->prepare("SELECT * FROM messages as mess
                                INNER JOIN utilisateurs ON mess.expediteur_id = utilisateurs.id 
                                WHERE (expediteur_id = ? AND destinataire_id = ?)
                                OR    (expediteur_id = ? AND destinataire_id = ?) ORDER BY mess.id DESC");
        $stmt->execute([$utilisateurId, $destinataire_id, $destinataire_id, $utilisateurId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function findNonLu($utilisateurId) {
        $stmt = $this->pdo->prepare("SELECT * FROM messages WHERE destinataire_id = ? AND lu=0");
        $stmt->execute([$utilisateurId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

}
?>