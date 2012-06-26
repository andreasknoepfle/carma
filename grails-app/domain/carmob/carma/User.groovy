package carmob.carma

class User {
    String login
    String password
    String email
    String phone
    Date last_login
    int carma = 5
    byte[] avatar
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
    
    def hasReservationFor(Transfer transfer) {
        int num=Reservation.countByTransferAndUser(transfer,this)
        if(num>0) {
            return true;
        }
        return false;
    }
}
