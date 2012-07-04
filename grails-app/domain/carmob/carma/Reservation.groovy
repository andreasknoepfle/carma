package carmob.carma
import com.grailsrocks.authentication.AuthenticationUser
 /**
 * Modelliert eine Reservierung 
 */
class Reservation {
        /**
        * Nutzer der die Reservierung eingestellt hat 
        */
        User provider
         /**
        * Nutzer der die Reservierung aktuell verwendet
        */
        User user
         /**
        * Bestellnummer der Reservierung 
        */
        String orderNumber
         /**
        * Waggong
        */
        Integer wagon
         /**
        * Sitzplatz
        */
        Integer seat
         /**
        * Zugehoerige Verbindung
        */
        Transfer transfer
         /**
        * Datum der Reservierung 
        */
        Date date
    static constraints = {
        user(nullable: true)
        wagon min:1
        seat min:1
        date min:new Date().clearTime()
    }
}
