package carmob.carma

/**
* Modelliert einen Benutzer (wird von AuthenticationPlugin verwendet)
*/
class User {
    /**
    * Benutzer Login 
    */
    String login
     /**
    * PW
    */
    String password
     /**
    * Email
    */
    String email
     /**
    * Phone
    */
    String phone
     /**
    * Datum des letzten Login s
    */
    Date last_login
     /**
    * Carma Punkte (Default: 5)
    */
    int carma = 5
     /**
    * Benutzer Avatar
    */
    byte[] avatar
     /**
    * Status des Benutzers
    */
    int status

    def authenticationService
    
    // Deployment with Heroku/Postgres doesn't allow User table
    static mapping = {
        table 'accounts'
    }
    
    static constraints = {
        phone(nullable:true)
        last_login(nullable:true)
        avatar(nullable:true, maxSize: 1000000)
    }
    
     /**
    * Hat der Nutzer reservierungen fuer eine Verbindung 
    * 
    * @param transfer Verbindung  
    */
    def hasReservationFor(Transfer transfer) {
        int num=Reservation.countByTransferAndUser(transfer,this)
        if(num>0) {
            return true;
        }
        return false;
    }
}
