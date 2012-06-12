package carmob.carma

class IndexController {
    def authenticationService
    
    def index() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(action:"login")
        }
        
        def users = User.list(max: 3, sort: "carma", order: "desc")
        [userInstanceList:users, userInstanceTotal: User.count()]
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
