package carmob.carma
import com.grailsrocks.authentication.AuthenticationUser

/**
* Modelliert Carma Punkte Aenderungen 
*/ 
class History {
    /**
    * Betreffender Nutzer
    */
    User user
     /**
    * Datum der Aenderung
    */
    Date date
     /**
    * Art der Aenderung 
    */
    String type
     /**
    * Zugehoerige Reservierung (fuer Link)
    */
    Reservation reservation
    /**
    * Carmapunkte Differenz
    */
    Integer carmachange
    /**
    * Carmapunkte Total
    */
    Integer carma
    static constraints = {
        reservation(nullable: true)
    }
}