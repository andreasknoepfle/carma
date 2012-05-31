package carmob.carma

class User {
    String login
    String password
    String email
    String phone
    int status

    static constraints = {
        phone(nullable:true)
    }
}
