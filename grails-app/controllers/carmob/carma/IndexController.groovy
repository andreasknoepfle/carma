package carmob.carma
import java.util.Calendar

class IndexController {
    def authenticationService
    
    def index() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(action:"login")
            return
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
        def user = authenticationService.getUserPrincipal()
        def last_login_1_day = false
        if(user.last_login) {
           def calendar = Calendar.getInstance()
            calendar.setTime(user.last_login)
            calendar.add(Calendar.DAY_OF_MONTH,1)
            last_login_1_day = calendar.before(Calendar.getInstance())
        }
        if(!user.last_login || last_login_1_day) {
            user.last_login = new Date()
            user.carma+=1
            user.save()
            // Commented because of Heroku Migration Problems. Uncomment this for getting login events in profile
//             def history = new History(
//            // User user
//            user: user,
//
//            // Date date
//            date: new Date(),
//
//            // String type
//            type: "eingeloggt",
//                               
//            // Integer carmachange
//            carmachange: "1",
//                    
//            // Integer carma
//            carma: user.carma)
//            
//            history.save()
            
             flash.message = "Für deinen heutigen Login bekommst du einen CARMA Punkt geschenkt!"
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
