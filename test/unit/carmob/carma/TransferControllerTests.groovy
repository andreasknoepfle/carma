package carmob.carma

import org.junit.*
import grails.test.mixin.*
import com.grailsrocks.authentication.*

@TestFor(TransferController)
@Mock([Transfer,Reservation,Direction])
class TransferControllerTests {
    
    def login(boolean doLogin = true) {
        def authentication=mockFor(AuthenticationService)
        authentication.demand.isLoggedIn(){request -> return doLogin }
        authentication.demand.getUserPrincipal(3){ -> return new User(login: "test", email: "test@test.de") }
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
        
        def dir = new Direction(from:new City(name: "Berlin"),to:new City(name: "Wolfsburg"))
        mockDomain(Direction, [ dir ])
        
        controller.params.direction = String.valueOf(dir.id)
        def model = controller.list()
        assert null == response.redirectedUrl
        assert model.direction.id == dir.id
      
        assert model.transferList.size() == 0
        assert model.transferListTomorrow.size() == 0
    }

    void testShow() {
        controller.authenticationService=login(false)
        // If user is not logged in
        controller.show()
        assert "/index/login" == response.redirectedUrl
    }
    
    void testSelectDirection() {
        controller.authenticationService=login(false)
        // If user is not logged in
        def model = controller.select_direction()
        assert "/index/login" == response.redirectedUrl
    }
    
    void testSelectDirectionSession() {
        controller.authenticationService=login(true)
         def dir = new Direction(from:new City(name: "Berlin"),to:new City(name: "Wolfsburg"))
        mockDomain(Direction, [ dir ])
        
        def model= controller.select_direction()
        assert  null  == response.redirectedUrl
        assert model.directionList.size() == 1
    }
    
    void testShowSession() {    
        // The List Method -- Empty
        controller.authenticationService=login(true)
         def dir = new Direction(from:new City(name: "Berlin"),to:new City(name: "Wolfsburg"))
        def transfer = new Transfer( ice: "test", dirId:dir,departureMinutes:10,departureHours:10, arrivalMinutes:11,arrivalHours:11, weekday:1, active:true)
        mockDomain(Transfer, [ transfer ])
        assert transfer.id != null
        controller.params.id = String.valueOf(transfer.id)
        def model = controller.show()
        assert null == response.redirectedUrl
        assert model.transferInstance.id == 1
    }
}
