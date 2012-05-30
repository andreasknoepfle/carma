package carmob.carma

import org.springframework.dao.DataIntegrityViolationException

class ReservationController {
    def authenticationService
    

    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

    def index() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "index")
        } else {
            redirect action: 'list', params: params
        }
    }
    
    def select_transfer() {
         if (!params.direction) {
            redirect(controller: "reservation",action : "select_direction")
        } 
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "index")
        }
        [transferList : Transfer.findAllByDirId(Direction.get(params.int('direction')))]
    }
    
    def select_direction() {
          
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "index")
        }
        [directionList : Direction.list()]
    }

    def list() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "index")
            return
        }
        if (!params.transfer) {
            redirect(controller: "reservation",action : "select_direction")
            return
        } 
          
        
        def query = {
            if (params.transfer) {
                eq('transfer' , )
            }
        }
       
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
       
        [reservationInstanceList: Reservation.findAllByTransfer(Transfer.get(params.int('transfer')),params) , reservationInstanceTotal: Reservation.count()]       
    }

    def create() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "index")
        }
        if(params.transfer) {
            params.transfer=Transfer.get(params.int("transfer"))
        }
        def transferList = Transfer.list()
        def reservationInstance = new Reservation(params)
        reservationInstance.provider = authenticationService.getUserPrincipal()
        
        switch (request.method) {
        case 'GET':
                [reservationInstance: reservationInstance, transferList: transferList]
                break
        case 'POST':
                if (!reservationInstance.save(flush: true)) {
                    render view: 'create', model: [reservationInstance: reservationInstance, transferList: transferList]
                    return
                }

                flash.message = "Ihre Reservierung wurde erfolgreich abgegeben!"
                redirect action: 'show', id: reservationInstance.id
                break
        }
    }

    def show() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "index")
            return
        }
        def reservationInstance = Reservation.get(params.id)
        if (!reservationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'reservation.label', default: 'Reservation'), params.id])
            redirect action: 'list'
            return
        }

        [reservationInstance: reservationInstance]
    }

    def edit() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "index")
        }
		switch (request.method) {
		case 'GET':
	        def reservationInstance = Reservation.get(params.id)
	        if (!reservationInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reservation.label', default: 'Reservation'), params.id])
	            redirect action: 'list'
	            return
	        }

	        [reservationInstance: reservationInstance]
			break
		case 'POST':
	        def reservationInstance = Reservation.get(params.id)
	        if (!reservationInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reservation.label', default: 'Reservation'), params.id])
	            redirect action: 'list'
	            return
	        }

	        if (params.version) {
	            def version = params.version.toLong()
	            if (reservationInstance.version > version) {
	                reservationInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
	                          [message(code: 'reservation.label', default: 'Reservation')] as Object[],
	                          "Another user has updated this Reservation while you were editing")
	                render view: 'edit', model: [reservationInstance: reservationInstance]
	                return
	            }
	        }

	        reservationInstance.properties = params

	        if (!reservationInstance.save(flush: true)) {
	            render view: 'edit', model: [reservationInstance: reservationInstance]
	            return
	        }

			flash.message = message(code: 'default.updated.message', args: [message(code: 'reservation.label', default: 'Reservation'), reservationInstance.id])
	        redirect action: 'show', id: reservationInstance.id
			break
		}
    }

    def delete() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "index")
            return
        }
        def reservationInstance = Reservation.get(params.id)
        if (!reservationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reservation.label', default: 'Reservation'), params.id])
            redirect action: 'list'
            return
        }

        try {
            reservationInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'reservation.label', default: 'Reservation'), params.id])
            redirect action: 'list'
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'reservation.label', default: 'Reservation'), params.id])
            redirect action: 'show', id: params.id
        }
    }
}
