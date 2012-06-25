package carmob.carma



import org.junit.*
import grails.test.mixin.*

@TestFor(HistoryController)
@Mock(History)
class HistoryControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/history/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.historyInstanceList.size() == 0
        assert model.historyInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.historyInstance != null
    }

    void testSave() {
        controller.save()

        assert model.historyInstance != null
        assert view == '/history/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/history/show/1'
        assert controller.flash.message != null
        assert History.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/history/list'


        populateValidParams(params)
        def history = new History(params)

        assert history.save() != null

        params.id = history.id

        def model = controller.show()

        assert model.historyInstance == history
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/history/list'


        populateValidParams(params)
        def history = new History(params)

        assert history.save() != null

        params.id = history.id

        def model = controller.edit()

        assert model.historyInstance == history
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/history/list'

        response.reset()


        populateValidParams(params)
        def history = new History(params)

        assert history.save() != null

        // test invalid parameters in update
        params.id = history.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/history/edit"
        assert model.historyInstance != null

        history.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/history/show/$history.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        history.clearErrors()

        populateValidParams(params)
        params.id = history.id
        params.version = -1
        controller.update()

        assert view == "/history/edit"
        assert model.historyInstance != null
        assert model.historyInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/history/list'

        response.reset()

        populateValidParams(params)
        def history = new History(params)

        assert history.save() != null
        assert History.count() == 1

        params.id = history.id

        controller.delete()

        assert History.count() == 0
        assert History.get(history.id) == null
        assert response.redirectedUrl == '/history/list'
    }
}
