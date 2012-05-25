package carmob.carma
import com.grailsrocks.authentication.AuthenticationUser

class Reservation {
        AuthenticationUser provider
        AuthenticationUser user
        Date date
        String orderNumber
        Integer wagon
        Integer seat
        Transfer transfer
    static constraints = {
    }
}
