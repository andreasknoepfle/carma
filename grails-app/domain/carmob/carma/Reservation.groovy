package carmob.carma
import com.grailsrocks.authentication.AuthenticationUser

class Reservation {
        AuthenticationUser provider
        Date date
        String orderNumber
        Integer wagon
        Integer seat
    static constraints = {
    }
}
