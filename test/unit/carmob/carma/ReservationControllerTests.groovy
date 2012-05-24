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
     def authenticationService  = new AuthenticationService() 
     def res= new ReservationController()     

    
    def populateValidParams(params) {
      assert params != null      
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex_logged_off() {           
        res.authenticationService=authenticationService       
        res.index()
        assert "/index/index" == response.redirectedUrl
        
    }
    
     void testIndex_logged_in() {              
        def control=mockFor(AuthenticationService)
        control.demand.isLoggedIn{->true}
        res.authenticationService=control.createMock()
        res.index()
        assert "/reservation/list" == response.redirectedUrl
    }

        

    void testList_logged_off() {                 
        res.authenticationService=authenticationService  
        res.list()
        assert "/index/index" == response.redirectedUrl
        
    }

    void testCreate_logged_off() {             
        res.authenticationService=authenticationService  
        res.create()
        assert "/index/index" == response.redirectedUrl
    }

//    void testSave() {
//                     
//        res.authenticationService=authenticationService  
//        res.save()
//        assert "/index/index" == response.redirectedUrl
//        print"NOT LOGGED "
//        controller.save()
//
//        assert model.reservationInstance != null
//        assert view == '/reservation/create'
//
//        response.reset()
//
//        populateValidParams(params)
//        controller.save()
//
//        assert response.redirectedUrl == '/reservation/show/1'
//        assert controller.flash.message != null
//        assert Reservation.count() == 1
//    }

    void testShow_logged_off() {                     
        res.authenticationService=authenticationService  
        res.show()
        assert "/index/index" == response.redirectedUrl
//       controller.show()
//        assert flash.message != null
//        assert response.redirectedUrl == '/reservation/list'
//
//
//        populateValidParams(params)
//        def reservation = new Reservation(params)
//
//        assert reservation.save() != null
//
//        params.id = reservation.id
//
//        def model = controller.show()
//
//        assert model.reservationInstance == reservation
    }

    void testEdit_logged_off() {                     
        res.authenticationService=authenticationService  
        res.edit()
        assert "/index/index" == response.redirectedUrl
    
//        controller.edit()
//
//        assert flash.message != null
//        assert response.redirectedUrl == '/reservation/list'
//
//
//        populateValidParams(params)
//        def reservation = new Reservation(params)
//
//        assert reservation.save() != null
//
//        params.id = reservation.id
//
//        def model = controller.edit()
//
//        assert model.reservationInstance == reservation
           }

//    void testUpdate() {
//        controller.update()
//
//        assert flash.message != null
//        assert response.redirectedUrl == '/reservation/list'
//
//        response.reset()
//
//
//        populateValidParams(params)
//        def reservation = new Reservation(params)
//
//        assert reservation.save() != null
//
//        // test invalid parameters in update
//        params.id = reservation.id
//        //TODO: add invalid values to params object
//
//        controller.update()
//
//        assert view == "/reservation/edit"
//        assert model.reservationInstance != null
//
//        reservation.clearErrors()
//
//        populateValidParams(params)
//        controller.update()
//
//        assert response.redirectedUrl == "/reservation/show/$reservation.id"
//        assert flash.message != null
//
//        //test outdated version number
//        response.reset()
//        reservation.clearErrors()
//
//        populateValidParams(params)
//        params.id = reservation.id
//        params.version = -1
//        controller.update()
//
//        assert view == "/reservation/edit"
//        assert model.reservationInstance != null
//        assert model.reservationInstance.errors.getFieldError('version')
//        assert flash.message != null
//    }

    void testDelete_logged_off() {        
        res.authenticationService=authenticationService  
        res.delete()
        assert "/index/index" == response.redirectedUrl
//        controller.delete()
//        assert flash.message != null
//        assert response.redirectedUrl == '/reservation/list'
//
//        response.reset()
//
//        populateValidParams(params)
//        def reservation = new Reservation(params)
//
//        assert reservation.save() != null
//        assert Reservation.count() == 1
//
//        params.id = reservation.id
//
//        controller.delete()
//
//        assert Reservation.count() == 0
//        assert Reservation.get(reservation.id) == null
//        assert response.redirectedUrl == '/reservation/list'
    }
}


