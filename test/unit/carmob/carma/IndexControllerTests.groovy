package carmob.carma



import grails.test.mixin.*
import org.junit.*
import com.grailsrocks.authentication.*

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(IndexController)
class IndexControllerTests {
 def authenticationService  = new AuthenticationService() 
 def ind = new IndexController()
 
    void testIndex_logged_off() {             
        def control=mockFor(AuthenticationService)
        control.demand.isLoggedIn{->false}
        ind.authenticationService=control.createMock()
        ind.index()
        assert "/index/login" == response.redirectedUrl
    }
    
    void testIndex_logged_in() {    
        def control=mockFor(AuthenticationService)
        control.demand.isLoggedIn{->true}
        ind.authenticationService=control.createMock()
        ind.index()
        assert null == response.redirectedUrl
    }
    
    void testLogin_logged_in(){
        def control=mockFor(AuthenticationService)
        control.demand.isLoggedIn{->true}
        ind.authenticationService=control.createMock()
        ind.login()
        assert "/index/index" == response.redirectedUrl
    }
    
    void testLogin_logged_off(){
        def control=mockFor(AuthenticationService)
        control.demand.isLoggedIn{->false}
        ind.authenticationService=control.createMock()
        ind.login()
        assert null == response.redirectedUrl
    }
    
    void testSingUp_logged_in(){
        def control=mockFor(AuthenticationService)
        control.demand.isLoggedIn{->true}
        ind.authenticationService=control.createMock()  
        ind.signup()
        assert "/index/index" == response.redirectedUrl
    }
    
    void testSingUp_logged_off(){
        def control=mockFor(AuthenticationService)
        control.demand.isLoggedIn{->false}
        ind.authenticationService=control.createMock()  
        ind.signup()
        assert null == response.redirectedUrl
    }
}
