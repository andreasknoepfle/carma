package carmob.carma

class IndexController {
    def authenticationService
    
    def index() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(action:"login")
        }
        
        def users = User.list(max: 3, sort: "carma", order: "desc")
        def users_all = User.list(sort: "carma", order: "desc")
        def i = 0
        for (user in users_all) {
            if (user == authenticationService.getUserPrincipal()) {
                break
            }
            i += 1
        }
        
        [userInstanceList:users, userInstanceTotal: User.count(), currentUserPlace: i+1]
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
