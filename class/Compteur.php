<?
class Compteur{
    static $fichier ="admin/compteur.txt";
    private $pdo;

    public function __construct($pdo) {
        $this->pdo= $pdo;
    }


    static function incrementer(){
        $compteur = file_get_contents(self::$fichier)+1;
        file_put_contents(self::$fichier,$compteur);

    }


    static function decrémenter(){
        $compteur = file_get_contents(self::$fichier)-1;
        file_put_contents(self::$fichier,$compteur);
    }



    static function getNbUser(){
        return (file_get_contents(self::$fichier));
    }


    public function nbInscrit(){
        $stmt = $this->pdo->prepare("SELECT count(*) as compte FROM utilisateurs ");
        $stmt->execute();
        return $stmt->fetch();    }



}




?>