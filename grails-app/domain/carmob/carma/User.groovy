package carmob.carma

class User {
    String login
    String password
    String email
    String phone
    byte[] avatar
    int status

    def authenticationService
    
    static constraints = {
        phone(nullable:true)
        avatar(nullable:true, maxSize: 1024 * 1024 * 2)
    }
    
    def hasReservationFor(Transfer transfer) {
        int num=Reservation.countByTransferAndUser(transfer,this)
        if(num>0) {
            return true;
        }
        return false;
    }
}
