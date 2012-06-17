package carmob.carma


import groovy.mock.interceptor.*
import org.junit.*
import grails.test.mixin.*
import com.grailsrocks.authentication.*
import org.springframework.mock.web.*
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import grails.test.GrailsUnitTestCase

@TestFor(ReservationController)
@Mock(Reservation)
class ReservationControllerTests {    

    def login(boolean doLogin = true) {
        def authentication=mockFor(AuthenticationService)
        authentication.demand.isLoggedIn{->doLogin}
        return authentication.createMock()
    }
    
    
    
    void testIndex() {           
        controller.authenticationService=login(false)       
        controller.index()
        assert "/index/login" == response.redirectedUrl
        
        controller.authenticationService=login(false)       
        controller.index()
        assert "/reservation/list" == response.redirectedUrl
        
    }

    void testList() {                 
        controller.authenticationService=login(false)       
        controller.list()
        assert "/index/login" == response.redirectedUrl
        
        controller.authenticationService=login(true)       
        controller.list()
        assert null == response.redirectedUrl
        
    }

}


