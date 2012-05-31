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
    
    

    def list() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "index")
            return
        }
        
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
       
        [reservationInstanceList: Reservation.findAllByProvider(authenticationService.getUserPrincipal()) , reservationInstanceTotal: Reservation.count()]
    }
    
     def select_date() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "index")
        }
        if(params.direction) {
            params.direction=Direction.get(params.int("direction"))
        }
        
        def reservationInstance = new Reservation(params)
        switch (request.method) {
        case 'GET':
                [reservationInstance: reservationInstance, directionList : Direction.list()]
                break
        case 'POST':
                if (!reservationInstance.validate(['date'])) {
                    render view: 'select_date', model: [reservationInstance: reservationInstance, directionList : Direction.list()]
                    return
                }
                
            redirect(action : 'create', params: [ date : reservationInstance.date.getTime(), direction:params.direction.id])
                break
        }
    }
    
    def create() {
    
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "index")
        }
        if(params.transfer) {
            params.transfer=Transfer.get(params.int("transfer"))
        }
        if(params.direction) {
            params.direction=Direction.get(params.int("direction"))
        }
        if(!params.date) {
           redirect(action: 'select_date')
           return
        }
        params.date = new Date(params.long("date"))
        def reservationInstance = new Reservation(params)
        
        def transferList = Transfer.createCriteria().list() {
            and {
                eq("weekday",reservationInstance.date.getDay())
                eq("dirId",params.direction)
            }
            
            order("departureHours","asc")
            order("departureMinutes","asc")
             
        }
    
        [reservationInstance: reservationInstance, transferList: transferList, direction : params.direction]
          
    }
    
    def submit() {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "index")
        }
        if(params.transfer) {
            params.transfer=Transfer.get(params.int("transfer"))
        }
       
        def direction=Direction.get(params.int("direction"))
        params.remove("direction")
        params.date = new Date(params.long("date"))
        
        def reservationInstance = new Reservation(params)
         
        def transferList = Transfer.createCriteria().list() {
            and {
                eq("weekday",reservationInstance.date.getDay())
                eq("dirId",direction)
            }
            
            order("departureHours","asc")
            order("departureMinutes","asc")
             
        }
        reservationInstance.provider = authenticationService.getUserPrincipal()
        
        if (!reservationInstance.save(flush: true)) {
            render view: 'create', model: [reservationInstance: reservationInstance, transferList: transferList, direction :direction]
            return
        }

        flash.message = "Ihre Reservierung wurde erfolgreich abgegeben! Sie haben dafür 5 CARMA Punkte erhalten!"
        redirect action: 'show', id: reservationInstance.id
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
