package carmob.carma

class User {
    String login
    String password
    String email
    String phone
    byte[] avatar
    int status

    static constraints = {
        phone(nullable:true)
        avatar(nullable:true, maxSize: 1024 * 1024 * 2)
    }
}
