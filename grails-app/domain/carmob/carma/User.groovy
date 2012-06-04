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
        avatar(nullable:true, maxSiitze: 1024 * 1024 * 2)
    }
}
