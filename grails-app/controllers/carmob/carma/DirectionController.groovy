package carmob.carma

import org.springframework.dao.DataIntegrityViolationException

class DirectionController {

    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

    def index() {
        redirect action: 'list', params: params
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [directionInstanceList: Direction.list(params), directionInstanceTotal: Direction.count()]
    }

    def create() {
		switch (request.method) {
		case 'GET':
        	[directionInstance: new Direction(params)]
			break
		case 'POST':
	        def directionInstance = new Direction(params)
	        if (!directionInstance.save(flush: true)) {
	            render view: 'create', model: [directionInstance: directionInstance]
	            return
	        }

			flash.message = message(code: 'default.created.message', args: [message(code: 'direction.label', default: 'Direction'), directionInstance.id])
	        redirect action: 'show', id: directionInstance.id
			break
		}
    }

    def show() {
        def directionInstance = Direction.get(params.id)
        if (!directionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'direction.label', default: 'Direction'), params.id])
            redirect action: 'list'
            return
        }

        [directionInstance: directionInstance]
    }

    def edit() {
		switch (request.method) {
		case 'GET':
	        def directionInstance = Direction.get(params.id)
	        if (!directionInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'direction.label', default: 'Direction'), params.id])
	            redirect action: 'list'
	            return
	        }

	        [directionInstance: directionInstance]
			break
		case 'POST':
	        def directionInstance = Direction.get(params.id)
	        if (!directionInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'direction.label', default: 'Direction'), params.id])
	            redirect action: 'list'
	            return
	        }

	        if (params.version) {
	            def version = params.version.toLong()
	            if (directionInstance.version > version) {
	                directionInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
	                          [message(code: 'direction.label', default: 'Direction')] as Object[],
	                          "Another user has updated this Direction while you were editing")
	                render view: 'edit', model: [directionInstance: directionInstance]
	                return
	            }
	        }

	        directionInstance.properties = params

	        if (!directionInstance.save(flush: true)) {
	            render view: 'edit', model: [directionInstance: directionInstance]
	            return
	        }

			flash.message = message(code: 'default.updated.message', args: [message(code: 'direction.label', default: 'Direction'), directionInstance.id])
	        redirect action: 'show', id: directionInstance.id
			break
		}
    }

    def delete() {
        def directionInstance = Direction.get(params.id)
        if (!directionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'direction.label', default: 'Direction'), params.id])
            redirect action: 'list'
            return
        }

        try {
            directionInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'direction.label', default: 'Direction'), params.id])
            redirect action: 'list'
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'direction.label', default: 'Direction'), params.id])
            redirect action: 'show', id: params.id
        }
    }
}
