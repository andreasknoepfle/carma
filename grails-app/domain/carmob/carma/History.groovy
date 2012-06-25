package carmob.carma
import com.grailsrocks.authentication.AuthenticationUser

class History {
    User user
    Date date
    String type
    Reservation reservation
    Integer carmachange
    Integer carma
    static constraints = {
        
    }
}