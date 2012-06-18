package carmob.carma



import org.junit.*
import grails.test.mixin.*
import com.grailsrocks.authentication.*

@TestFor(TransferController)
@Mock([Transfer])
class TransferControllerTests {

    
    def login(boolean doLogin = true) {
        def authentication=mockFor(AuthenticationService)
        authentication.demand.isLoggedIn(){request -> return doLogin }
        return authentication.createMock()
    }
    
 
    void testList() {
        controller.authenticationService=login(false)
        // If user is not logged in
        controller.list()
        assert "/index/login" == response.redirectedUrl
    }
    
    void testListSession() {    
        // If no direction is selected
        controller.authenticationService=login(true)
        controller.list()
        
        assert "/transfer/select_direction" == response.redirectedUrl
    }
     void testListSessionDirection() {    
        // The List Method -- Empty
        controller.authenticationService=login(true)
        params.direction =10
        mockDomain(Direction, [ new Direction(id:10,from:new City(name: "Berlin"),to:new City(name: "Wolfsburg"))])
        assertEquals(1, Direction.count() )
        controller.list()
       
        assert null == response.redirectedUrl
        assert model.direction.id == 10
      
        assert model.transferInstanceList.size() == 0
        assert model.transferInstanceTotal == 0
    }

}
