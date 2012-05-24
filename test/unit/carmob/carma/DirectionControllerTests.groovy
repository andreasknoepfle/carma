package carmob.carma



import org.junit.*
import grails.test.mixin.*

@TestFor(DirectionController)
@Mock(Direction)
class DirectionControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/direction/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.directionInstanceList.size() == 0
        assert model.directionInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.directionInstance != null
    }

    void testSave() {
        controller.save()

        assert model.directionInstance != null
        assert view == '/direction/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/direction/show/1'
        assert controller.flash.message != null
        assert Direction.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/direction/list'


        populateValidParams(params)
        def direction = new Direction(params)

        assert direction.save() != null

        params.id = direction.id

        def model = controller.show()

        assert model.directionInstance == direction
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/direction/list'


        populateValidParams(params)
        def direction = new Direction(params)

        assert direction.save() != null

        params.id = direction.id

        def model = controller.edit()

        assert model.directionInstance == direction
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/direction/list'

        response.reset()


        populateValidParams(params)
        def direction = new Direction(params)

        assert direction.save() != null

        // test invalid parameters in update
        params.id = direction.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/direction/edit"
        assert model.directionInstance != null

        direction.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/direction/show/$direction.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        direction.clearErrors()

        populateValidParams(params)
        params.id = direction.id
        params.version = -1
        controller.update()

        assert view == "/direction/edit"
        assert model.directionInstance != null
        assert model.directionInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/direction/list'

        response.reset()

        populateValidParams(params)
        def direction = new Direction(params)

        assert direction.save() != null
        assert Direction.count() == 1

        params.id = direction.id

        controller.delete()

        assert Direction.count() == 0
        assert Direction.get(direction.id) == null
        assert response.redirectedUrl == '/direction/list'
    }
}
