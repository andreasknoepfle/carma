package carmob.carma

import org.springframework.dao.DataIntegrityViolationException

class CityController {

    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

    def index() {
        redirect action: 'list', params: params
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cityInstanceList: City.list(params), cityInstanceTotal: City.count()]
    }

    def create() {
		switch (request.method) {
		case 'GET':
        	[cityInstance: new City(params)]
			break
		case 'POST':
	        def cityInstance = new City(params)
	        if (!cityInstance.save(flush: true)) {
	            render view: 'create', model: [cityInstance: cityInstance]
	            return
	        }

			flash.message = message(code: 'default.created.message', args: [message(code: 'city.label', default: 'City'), cityInstance.id])
	        redirect action: 'show', id: cityInstance.id
			break
		}
    }

    def show() {
        def cityInstance = City.get(params.id)
        if (!cityInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), params.id])
            redirect action: 'list'
            return
        }

        [cityInstance: cityInstance]
    }

    def edit() {
		switch (request.method) {
		case 'GET':
	        def cityInstance = City.get(params.id)
	        if (!cityInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), params.id])
	            redirect action: 'list'
	            return
	        }

	        [cityInstance: cityInstance]
			break
		case 'POST':
	        def cityInstance = City.get(params.id)
	        if (!cityInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), params.id])
	            redirect action: 'list'
	            return
	        }

	        if (params.version) {
	            def version = params.version.toLong()
	            if (cityInstance.version > version) {
	                cityInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
	                          [message(code: 'city.label', default: 'City')] as Object[],
	                          "Another user has updated this City while you were editing")
	                render view: 'edit', model: [cityInstance: cityInstance]
	                return
	            }
	        }

	        cityInstance.properties = params

	        if (!cityInstance.save(flush: true)) {
	            render view: 'edit', model: [cityInstance: cityInstance]
	            return
	        }

			flash.message = message(code: 'default.updated.message', args: [message(code: 'city.label', default: 'City'), cityInstance.id])
	        redirect action: 'show', id: cityInstance.id
			break
		}
    }

    def delete() {
        def cityInstance = City.get(params.id)
        if (!cityInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), params.id])
            redirect action: 'list'
            return
        }

        try {
            cityInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'city.label', default: 'City'), params.id])
            redirect action: 'list'
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'city.label', default: 'City'), params.id])
            redirect action: 'show', id: params.id
        }
    }
}
