package carmob.carma


import groovy.mock.interceptor.*
import org.junit.*
import grails.test.mixin.*
import com.grailsrocks.authentication.*
import org.springframework.mock.web.*
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import grails.test.GrailsUnitTestCase

@TestFor(ReservationController)
@Mock([Reservation,Direction,Transfer,History])
class ReservationControllerTests {    

    def login(boolean doLogin = true) {
        def authentication=mockFor(AuthenticationService)
        authentication.demand.isLoggedIn(){request -> return doLogin }
        authentication.demand.getUserPrincipal(2){ -> return new User(login: "test", email: "test@test.de") }
        return authentication.createMock()
    }
    
    void testIndex() {           
        controller.authenticationService=login(false)       
        controller.index()
        assert "/index/login" == response.redirectedUrl
    }
    
    void testIndexSession() {
        controller.authenticationService=login(true)       
        controller.index()
        assert "/reservation/list" == response.redirectedUrl
    }

    void testList() {                 
        controller.authenticationService=login(false)       
        controller.list()
        assert "/index/login" == response.redirectedUrl
    }
    
    void testListSession() {
        controller.authenticationService=login(true)       
        controller.list()
        assert null == response.redirectedUrl
    }

    
    void testSelectDate() {
        controller.authenticationService=login(false)  
        controller.select_date()
        assert "/index/login" == response.redirectedUrl
    }

     void testSelectDateSession() {
        controller.authenticationService=login(true)  
        controller.select_date()
        assert null == response.redirectedUrl
    }
    
    void testSelectDateSessionPost() {
        params.date= new Date().plus(1).format("dd.MM.yyyy")
        def dir = new Direction(from:new City(name: "Berlin"),to:new City(name: "Wolfsburg"))
        mockDomain(Direction, [ dir ])
        params.direction = String.valueOf(dir.id)
        request.method = 'POST'  
        controller.authenticationService=login(true)  
        controller.select_date()
        assertTrue  response.redirectedUrl.startsWith("/reservation/create")
    }
    
    void testCreate() {
        controller.authenticationService=login(false)  
        controller.create()
        assert "/index/login" == response.redirectedUrl
    }
    
    void testCreateSession() {
        controller.authenticationService=login(true)  
        controller.create()
        assert "/reservation/select_date" == response.redirectedUrl
    }
    
     void testCreateSessionWithDateAndDirection() {
        params.date= new Date().getTime()
        def dir = new Direction(from:new City(name: "Berlin"),to:new City(name: "Wolfsburg"))
        mockDomain(Direction, [ dir ])
        params.direction = String.valueOf(dir.id)
        controller.authenticationService=login(true)  
        controller.create()
        assert null == response.redirectedUrl
    }
    
    void testSubmit() {
        controller.authenticationService=login(false)  
        controller.submit()
        assert "/index/login" == response.redirectedUrl
    }
    
     void testSubmitSession() {
        params.date= new Date().getTime()
        controller.authenticationService=login(true)  
        controller.submit()
        assert null == response.redirectedUrl
        assert view == "/reservation/create"
        
    }
    
    void testSubmitSessionWithValidParams() {
        params.date= new Date().getTime()

        def dir = new Direction(from:new City(name: "Berlin"),to:new City(name: "Wolfsburg"))
        mockDomain(Direction, [ dir ])
        params.direction = String.valueOf(dir.id)
        def transfer = new Transfer( ice: "test", dirId:dir,departureMinutes:10,departureHours:10, arrivalMinutes:11,arrivalHours:11, weekday:1, active:true)
        mockDomain(Transfer, [ transfer ])
        params.transfer = String.valueOf(transfer.id)
        params.seat = 1
        params.wagon = 1
        params.orderNumber = "ABCDEFG"
        controller.authenticationService=login(true)  
        controller.submit()
        assert "/reservation/show/1" == response.redirectedUrl
    }
    
    void testShow() {
        controller.authenticationService=login(false)  
        controller.show()
        assert "/index/login" == response.redirectedUrl
    }
    
     void testShowSession() {
        def reservation = mockReservation()
        mockDomain(Reservation, [ reservation ])
        controller.authenticationService=login(true) 
        params.id = reservation.id
        def model = controller.show()
        assert null == response.redirectedUrl
        assert model.reservationInstance == reservation
        
    }
    
    Reservation mockReservation() {
        def dir = new Direction(from:new City(name: "Berlin"),to:new City(name: "Wolfsburg"))
        mockDomain(Direction, [ dir ])
        params.direction = String.valueOf(dir.id)
        def transfer = new Transfer( ice: "test", dirId:dir,departureMinutes:10,departureHours:10, arrivalMinutes:11,arrivalHours:11, weekday:1, active:true)
        mockDomain(Transfer, [ transfer ])
        def reservation = new Reservation(provider: new User(login: "test", email: "test@test.de"), 
         orderNumber :"ABCD",
         wagon : 1,
         seat : 1,
         transfer : transfer,
         date : new Date())
        return reservation
    }
    
    void testGetReservation() {
      
        controller.authenticationService=login(false)  
        controller.get_reservation()
        assert "/index/login" == response.redirectedUrl
    }
     void testGetReservationSession() {
        def reservation = mockReservation()
        mockDomain(Reservation, [ reservation ])
        controller.authenticationService=login(true)  
        params.id = reservation.id
        controller.get_reservation()
        assert "/transfer/show/1" == response.redirectedUrl
    }
    
    void testReturnReservation() {
      
        controller.authenticationService=login(false)  
        controller.return_reservation()
        assert "/index/login" == response.redirectedUrl
    }
    
    void testReturnReservationSession() {
        def reservation = mockReservation()
        mockDomain(Reservation, [ reservation ])
        controller.authenticationService=login(true)  
        params.id = reservation.id
        controller.return_reservation()
        assert "/transfer/show/1" == response.redirectedUrl
       
    }
    
   

}


