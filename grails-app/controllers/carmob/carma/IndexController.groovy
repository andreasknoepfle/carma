package carmob.carma

class IndexController {
    def authenticationService
    
    def index() {
        // if user is not logged in, redirect to login
        // else redirect to create reservation
        if (!authenticationService.isLoggedIn(request)) {
            redirect(action:"login")
        }
    }
    
    def login() {
        
    }
    
    def signup() {
        
    }
}
