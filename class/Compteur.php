<?
class Compteur{
    static $fichier ="admin/compteur.txt";


    static function incrementer(){

        file_put_contents(self::$fichier,
        (file_get_contents(self::$fichier))+1);
        
    }


    static function decrémenter(){


        file_put_contents(self::$fichier,
        (file_get_contents(self::$fichier))-1);
    }



    static function getNbUser(){
        return (file_get_contents(self::$fichier));
    }

}




?>