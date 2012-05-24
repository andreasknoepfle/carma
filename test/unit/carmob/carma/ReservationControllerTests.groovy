package carmob.carma



import org.junit.*
import grails.test.mixin.*
import com.grailsrocks.authentication.*

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
        print"NOT LOGGED "
    }
    
//     void testIndex_logged_in() {              
//        res.authenticationService=authenticationService           
//        def user = new AuthenticationUser( login:'someone', password:'secret'.encodeAsMD5(), email:'someone@somewhere.com', status:AuthenticationService.STATUS_VALID)
//        assert user
//        res.index()
//        assert "/index/inde" == response.redirectedUrl
//    }


    void testList() {                 
        res.authenticationService=authenticationService  
        res.list()
        assert "/index/index" == response.redirectedUrl
        print"NOT LOGGED "
        
    }

    void testCreate() {             
        res.authenticationService=authenticationService  
        res.create()
        assert "/index/index" == response.redirectedUrl
        print"NOT LOGGED "
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

    void testShow() {                     
        res.authenticationService=authenticationService  
        res.show()
        assert "/index/index" == response.redirectedUrl
        print"NOT LOGGED "    
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

    void testEdit() {                     
        res.authenticationService=authenticationService  
        res.edit()
        assert "/index/index" == response.redirectedUrl
        print"NOT LOGGED "
    
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

    void testDelete() {        
        res.authenticationService=authenticationService  
        res.delete()
        assert "/index/index" == response.redirectedUrl
        print"NOT LOGGED "    
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
