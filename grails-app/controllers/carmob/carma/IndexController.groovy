package carmob.carma

class IndexController {
    def authenticationService
    
    def index() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(action:"login")
        }
        
        
        def users = User.executeQuery("SELECT login, carma FROM User")
        [users:users]
    }
    
    def login() {
        if (authenticationService.isLoggedIn(request)) {
            redirect(action:"index")
        }
    }
    
    def signup() {
        if (authenticationService.isLoggedIn(request)) {
            redirect(action:"index")
        }
    }
}
