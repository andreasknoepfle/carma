package carmob.carma


import com.grailsrocks.authentication.*
import org.junit.*
import grails.test.mixin.*

@TestFor(UserController)
@Mock([User,History])
class UserControllerTests {

    def login(boolean doLogin = true) {
        def authentication=mockFor(AuthenticationService)
        authentication.demand.isLoggedIn(){request -> return doLogin }
        authentication.demand.getUserPrincipal(){ -> return new User(id: new Long(1),login: "testen", email: "test@test.de") }
        return authentication.createMock()
    }
    

    void testCreate() {
       def model = controller.create()

       assert model.userInstance != null
    }

    void testSave() {
        controller.save()

        assert model.userInstance != null
        assert view == '/user/create'

        response.reset()
        controller.params.login="testen"
        controller.params.email="test@test.de"
        controller.params.password="testen"
        controller.save()

        assert response.redirectedUrl == '/user/show/1'
        assert controller.flash.message != null
        assert User.count() == 1
    }

    void testShow() {
        controller.authenticationService=login(true)
        def user = new User(login:"testen",email:"test@test.de",password:"testen" )
        mockDomain(User, [ user ])
        controller.params.id = String.valueOf(user.id)
        def model= controller.show()
        
        assert model.userInstance.login == user.login       
    }

    void testEdit() {
        controller.authenticationService=login(true)
        def user = new User(login:"testen",email:"test@test.de",password:"testen" )
        mockDomain(User, [ user ])
        def model = controller.edit()
       
        assert response.redirectedUrl == null
    }

    

    
}
