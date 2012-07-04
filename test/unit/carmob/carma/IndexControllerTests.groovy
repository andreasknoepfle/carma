package carmob.carma

import grails.test.mixin.*
import org.junit.*
import com.grailsrocks.authentication.*

@TestFor(IndexController)
@Mock([User])
class IndexControllerTests {
    
    def login(boolean doLogin = true) {
        def authentication=mockFor(AuthenticationService)
        authentication.demand.isLoggedIn(){request -> return doLogin }
        authentication.demand.getUserPrincipal(){ -> return new User(login: "test", email: "test@test.de") }
        return authentication.createMock()
    }
    
    
    void testIndex() {    
        controller.authenticationService=login(false)       
        controller.index()
        assert "/index/login" == controller.response.redirectedUrl
    }
    
    void testIndexSession() {
        controller.authenticationService=login(true)       
        controller.index()
        assert null == controller.response.redirectedUrl
        
    }
    
    void testLogin(){
        controller.authenticationService=login(false)       
        controller.login()
        assert null == controller.response.redirectedUrl
    }
    
    void testLoginSession(){
        controller.authenticationService=login(true)       
        controller.login()
        assert "/index/index" == controller.response.redirectedUrl
    }
    
    void testSingUp(){
        controller.authenticationService=login(true)       
        controller.signup()
        assert "/index/index" == controller.response.redirectedUrl
    }
    
    void testSingUpSession(){  
        controller.authenticationService=login(false) 
        controller.signup()
        assert null == controller.response.redirectedUrl
    }
    
   
}
