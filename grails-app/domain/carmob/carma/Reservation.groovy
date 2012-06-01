package carmob.carma
import com.grailsrocks.authentication.AuthenticationUser

class Reservation {
        AuthenticationUser provider
        AuthenticationUser user
        String orderNumber
        Integer wagon
        Integer seat
        Transfer transfer
        Date date
    static constraints = {
        user(nullable: true)
        wagon min:1
        seat min:1
        date min:new Date().clearTime()
    }
}
